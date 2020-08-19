// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@fortawesome/fontawesome-free/js/all")
require("../stylesheets/application.scss")
require("bootstrap")
require("admin-lte");
require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")

import toastr from 'toastr'
window.toastr = toastr
global.$ = jQuery;
