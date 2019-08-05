// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require activestorage
//= require turbolinks
//= require faker.min
//= require_tree .

document.addEventListener('DOMContentLoaded', function() {
    var elem = document.querySelector('.collapsible');
    
    if (elem) {

        // var contribution = document.querySelector(".progress-bar");

        // init collapsible
        let instance;
        let options;

        if (elem.classList.contains("expandable")) {
            // index
            options = {
                accordion: false
            }
        }
        else {
            // show
            options = {
                onOpenEnd: function(ele) {
                    let time = new Date().getTime();
                    ele.querySelector("input[name='time']").value = time;
                }
            }
        }
        instance = M.Collapsible.init(elem, options);
    }

});