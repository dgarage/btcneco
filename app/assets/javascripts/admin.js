function getPairing() {
  var ret = null;
  var pairing_url = $("#setting_btcpayserver_url").val();
  var pairing_code = $("#pairing_code").val();
  console.log(pairing_url);
  console.log(pairing_code);
  var data = JSON.stringify([pairing_url, pairing_code]);
  console.log(data);
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
    }
  });
  return ret;
}
