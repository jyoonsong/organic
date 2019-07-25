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
//= require_tree .

document.addEventListener('DOMContentLoaded', function() {
    var contribution = document.querySelector(".progress-bar");
    var elem = document.querySelector('.collapsible');
    var isDones = document.querySelectorAll(".isDone");
    
    // init collapsible
    M.Collapsible.init(elem);
    var instance = M.Collapsible.getInstance(elem);
    
    instance.open(1);

    // task 1
    var status = false;
    document.querySelector("#start1").onclick = function(e) {
        if (!status) {
            this.innerText = "click to finish!";
            status = true;
        }
        else {
            instance.open(1);
            status = false;
            contribution.style.width = "10%";
            isDones[0].style.opacity = 1;
        }
        
    }

    document.querySelector("#start2").onclick = function(e) {
        if (!status) {
            document.querySelector(".next").classList.add("shown");
            status = true;
        }
        
    }

});