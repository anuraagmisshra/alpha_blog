// Entry point for the build script in your package.json
// import Rails from '@rails/ujs'
// Rails.starts()
//
// require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()


// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)


//= require jquery3
//= require popper
//= require bootstrap-sprockets
import "trix"
import "@rails/actiontext"
