import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"
import "../posts" // Import your custom JavaScript file

Rails.start()
Turbolinks.start()
ActiveStorage.start()
