function getPairing() {
  var ret = null;
  var pairing_url = $("#setting_btcpayserver_url").val();
  var pairing_code = $("#pairing_code").val();
  var data = JSON.stringify([pairing_url, pairing_code]);
  $.ajax({
    async: true,
    cache: false,
    beforeSend: function(xhr) { xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content')) },
    data: data,
    contentType: "application/json",
    dataType: "json",
    method: "POST",
    url: "/admin/getPairing",
    success: function(result) {
      console.log("SUCCESS");
      console.log(result);
      ret = result;
      hidePaircode(result[0]["token"]);
    }
  });
  return ret;
}

function hidePaircode(token) {
  $("#setting_btcpayserver_url").prop('disabled', true);
  $("#pairing_code").prop('disabled', true);
  $("#pairing_code").prop('text', "Pairing complete. Click to initiate new pairing.");
}

function showPaircode() {
  $("#setting_btcpayserver_url").prop('disabled', false);
  $("#pairing_code").prop('disabled', false);
  $("#pairing_code").prop('text', "");
  $("#pairing_code").prop('placeholder', "Pairing Code");
}

function changeLink() {
  $("#get_pairing_code").prop("href", $("#setting_btcpayserver_url").val());
  $("#get_pairing_code").prop("text", $("#setting_btcpayserver_url").val());
}

$(function(){
  changeLink();
  $("#setting_btcpayserver_url").on("change paste keyup", function() {
    changeLink();
  });
  $("#pairing_code").click(function() {
    if ($(this).prop("disabled")) {
      showPaircode();
    }
  });
});
