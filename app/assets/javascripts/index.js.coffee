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
        for o_p in data.order_products
          console.log(o_p.id)
    });

Payment =
  stripeGetToken: () =>
    Stripe.createToken
      number: $("#card_number").val()
      cvc: $("#card_cvc").val()
      exp_month: $("#card_expiry_month").val()
      exp_year: $("#card_expiry_year").val()
    , Payment.stripeResponseHandler

  stripeResponseHandler: (status, response) =>
    console.log(status)
    if response.error
      $(".payment_errors").text response.error.message
      $("#submit_checkout").removeAttr "disabled"
    else
      $form = $("#payment_form")
      token = response["id"]
      $form.append "<input type='hidden' name='stripe_token' value='" + token + "'/>"
      $form.get(0).submit()

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