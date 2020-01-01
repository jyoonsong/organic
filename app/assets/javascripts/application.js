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
//= require jquery
//= require faker.min
//= require sbd
//= require swal
//= require modal.min
//= require highlight
//= require_tree .

let instance,
    article,
    ps,
    time;

document.addEventListener('turbolinks:load', function() {
    
    let elem = document.querySelector('.collapsible');

    let links = Array.from(document.querySelectorAll(".article a"));
    links.forEach(function(link) {
        link.setAttribute("target", "_blank")
    });

    MicroModal.init({
        openTrigger: 'data-custom-open',
        disableScroll: true,
        awaitCloseAnimation: true
    });
    
    if (elem) {

        // init collapsible
        let options;

        if (elem.classList.contains("expandable")) {
            // index
            options = {
                accordion: false
            }
        }
        else if (elem.classList.contains("survey")) {
            // survey
        }
        else {
            // show
            
            ps = makePS();
            ps.forEach(function(p, i) {
                p.dataset.index = i;
            })

            options = {
            onOpenEnd: function(ele) {

                    console.log("on Open end");

                    // save current time
                    time = new Date().getTime();
                    ele.querySelector("input[name='time']").value = time;

                    // check task type
                    if (document.querySelector(".pleasehighlight")) {
                        initHighlight(ele, 0);
                    }
                },
                onCloseEnd: function(ele) {
                    if (document.querySelector(".pleasehighlight")) {
                        let article = document.querySelector(".article");
                        article.innerHTML = article.innerHTML.replace(/\n|<mark.*?>/g,'');
                    }
                }
            }
        }

        instance = M.Collapsible.init(elem, options);
        instance.open(0);

        
    }

});

function makePS() {
    arr = [];
    arr.push( document.querySelector(".article > h1") )
    arr.push( document.querySelector(".article > h4") )
    arr.push(...Array.from( document.querySelectorAll(".article > p") ));
    return arr;
}