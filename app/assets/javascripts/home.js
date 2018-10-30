var values = {};

function getInvoice() {
  $('#finalPayButtonClose').hide();
  $('#finalPayButton').hide();
  $('#linkLoader').show();
  var ret = null;
  getFormValues();
  var data = JSON.stringify(values);
  $.ajax({
    async: true,
    cache: false,
    beforeSend: function(xhr) { xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content')) },
    data: data,
    contentType: "application/json",
    dataType: "json",
    method: "POST",
    url: "/home/generateInvoice",
    success: function(result) {
      console.log("SUCCESS");
      console.log(result);
      ret = result;
      window.location.href = ret["url"];
    }
  });
  return ret;
}

function getFormValues() {
  var inputValue = $("input[name='paymentTier']:checked").val().split(':');
  values['amount'] = inputValue[0];
  values['currency'] = inputValue[1];
  values['tier'] = inputValue[2];
  values['tier_id'] = inputValue[3];
  values['divisor'] = inputValue[4];
  values['email'] = $('#payeeEmail').val();
  values['name'] = $('#payeeName').val();
  values['duration'] = $('#duration').val();
  return values;
}

function setPaymentTotal() {
  $('#payment_total').text( 
    (values['amount'] * values['duration'] / values['divisor']) +" "+ values['currency']
  );
}

function copyToClipboard() {
  var tempElement = document.createElement('textarea');
  var link = document.getElementById('copyLinkToClipboard').href;
  tempElement.value = link;
  tempElement.setAttribute('readonly', '');
  tempElement.style = {position: 'absolute', left: '-9999px;'};
  document.body.appendChild(tempElement);
  tempElement.select();
  document.execCommand("copy");
  document.body.removeChild(tempElement);
  alert("Link copied to clipboard: " + link);
}

$(function(){
  $('#linkLoader').hide();

  $('#paymentTierButton').on('change', function() {
    getFormValues();
    setPaymentTotal();
  });

  $('.paymentButton').on('click', function() {
    var amountCurrency = $(this).val().split(':');
    values['amount'] = amountCurrency[0];
    values['currency'] = amountCurrency[1];
    values['tier'] = amountCurrency[2];
    values['tier_id'] = amountCurrency[3];
    values['divisor'] = amountCurrency[4];
    $("#paymentTierButton").children('p').children('input').each(function(i){
      $(this).removeAttr('checked');
    });
    $('#tierIndex' + amountCurrency[2]).attr('checked', 'true');
    values['duration'] = $('#duration').val();
    setPaymentTotal();
  });
});
