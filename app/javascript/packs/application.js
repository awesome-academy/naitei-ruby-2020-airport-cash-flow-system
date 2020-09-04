// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.
//= require bootstrap-datepicker
//= require bootstrap-datepicker/core
//= require bootstrap-datepicker/locales/bootstrap-datepicker.es.js
//= require bootstrap-datepicker/locales/bootstrap-datepicker.fr.js

require("@fortawesome/fontawesome-free/js/all")
require("../stylesheets/application.scss")
require("bootstrap")
require("admin-lte");
require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")
require("cocoon")
require("./constant")
require("./custom")
require("./notification_dropdown")

import toastr from 'toastr'
toastr.options.closeButton = true;
toastr.options.progressBar = true;
window.toastr = toastr
global.$ = jQuery;
global.I18n = require('i18n-js')
