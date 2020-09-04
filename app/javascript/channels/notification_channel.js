import consumer from "./consumer"
import { NEW_NOTIFICATION } from "../packs/constant";

consumer.subscriptions.create("NotificationChannel", {
  connected() {
  },

  disconnected() {
  },

  received(data) {
    if(data.action == NEW_NOTIFICATION){
      if(data.count !== 0 ) {
        $("#unviewed-notification").removeClass("d-none")
        $("#unviewed-notification").html(data.count)
      }
      toastr.info(I18n.t("notification_msg"))
    }
  }
});
