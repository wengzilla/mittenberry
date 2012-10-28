Product =
  loadProduct: (el) =>
    $('.selected').removeClass('selected');
    $(el.target).addClass('selected');
    data = $(el.target).data()
    $('#product_photo').attr('src', "/assets/#{data.photo}")
    $('#order_product_product_id').val(data.id)
    $('#color_name').html(data.colorName)

  addProduct: () =>
    $.ajax({
      url: '/order_products',
      type: 'POST',
      data: {
          'order_product': { 
            'product_id': $('#order_product_product_id').val(),
            'quantity': $('#order_product_quantity').val(),
          }
      },
      success: (data) ->
        total_quantity = 0
        for o_p in data.order_products
          total_quantity += o_p.quantity

        $('#total_quantity').html(total_quantity)
    });

Payment =
  formatted_billing: () =>
    billing_info = Payment.response
    console.log(billing_info)
    "#{billing_info.card.name}<br>
    #{billing_info.card.type}<br>
    XXXX-XXXX-XXXX-#{billing_info.card.last4}<br>"

  stripeGetToken: () =>
    Stripe.createToken
      name: $("#cardholder_name").val()
      number: $("#card_number").val()
      cvc: $("#card_cvc").val()
      exp_month: $("#card_expiry_month").val()
      exp_year: $("#card_expiry_year").val()
    , Payment.stripeResponseHandler

  stripeResponseHandler: (status, response) =>
    console.log response
    if response.error
      $("#payment_form_errors").text(response.error.message).show()
      $("#submit_checkout").removeAttr "disabled"
    else
      $form = $("#payment_form")
      Payment.response = response
      stripe_token = response["id"]
      $("#shipping_details_modal").modal()
      $("#stripe_token").val(stripe_token)
      $("#stripe_response").val(JSON.stringify(response))

Shipping =
  validate: () =>
    errors = []
    unless $("#street1").val() then errors.push("A street is required.</br>")
    unless $("#city").val() then errors.push("A city is required.</br>")
    unless $("#state").val() then errors.push("A state is required.</br>")
    unless $("#postal_code").val().length >= 5 then errors.push("A zipcode is required.</br>")
    errors

  address: () =>
    address = {
      'name': $("#name").val()
      'street1': $("#street1").val(),
      'street2': $("#street2").val(),
      'city': $("#city").val(),
      'state': $("#state").val(),
      'postal_code': $("#postal_code").val(),
    }

  address_json: () =>
    JSON.stringify(Shipping.address())

  formatted_address: () =>
    address = Shipping.address()
    result = "<strong>#{address.name}</strong><br>
     #{address.street1}<br>"
    result += "#{address.street2}<br>" if address.street2.length > 0
    result += "#{address.city}, #{address.state} #{address.postal_code}"

  submit: () =>
    errors = Shipping.validate()

    unless _.isEmpty(errors)
      $("#shipping_form_errors").show()
      $("#shipping_form_errors").html(errors)
    else
      Confirmation.show()

jQuery ->
  $('.color').hover( (el) => 
    Product.loadProduct(el)
  )

  $('#new_order_product').submit( ->
    Product.addProduct()
    false
  )

  $("#submit_checkout").click (event) ->
    $("#submit_checkout").attr "disabled", "disabled"
    Payment.stripeGetToken()
    false

  $("#submit_shipping_details").click (event) ->
    Shipping.submit()
    false
    
