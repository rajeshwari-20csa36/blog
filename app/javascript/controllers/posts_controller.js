import { Controller } from "@hotwired/stimulus"
// import $ from 'jquery';

// Connects to data-controller="posts"
export default class extends Controller {
  connect() {
    console.log("Connected")

    $("#read").ready(function(){
      console.log($("#read_status").val());
      if ($("#read_status").val()==="Unread") {
        let token = $('meta[name=csrf-token]').attr('content')
        console.log(token)
        let topic_id = $("#topic_id").val();
        let post_id = $("#post_id").val();
        $.ajax({
          url: +post_id + "/read_unread",
          method: 'post',
          type: 'product',
          dataType: 'script',
          headers: {'X-CSRF-Token': token},
          data: {
            topic_id: $('#topic_id').val(),
            post_id: $('#post_id').val(),
          },
          success: function (data) {
            alert("Product has been successfully viewed!");
          },
          error: function () {
            alert("error");
          }
        })
      }
    })
  }
}