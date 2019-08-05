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
//= require_tree .

let instance;

document.addEventListener('DOMContentLoaded', function() {
    var elem = document.querySelector('.collapsible');
    
    if (elem) {

        // var contribution = document.querySelector(".progress-bar");

        // init collapsible
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

                    // save current time
                    let time = new Date().getTime();
                    ele.querySelector("input[name='time']").value = time;

                    // check task type
                    if (ele.classList.contains("highlight")) {
                        initHighlight(ele);
                    }
                    else if (ele.classList.contains("verify")) {

                    }
                }
            }
        }

        instance = M.Collapsible.init(elem, options);

    }

});

function initHighlight(ele) {
    const article = document.querySelector("#articleContent");
    const article_tokens = tokenizer.sentences(article.innerText)
    let submit = ele.querySelector(".submitHighlight");
    let drag = false;
    let highlight = {};

    function l_mousemove() {
        drag = true;
    }
    function l_mouseup() {
        if (drag) {
            saveHighlight();
            drag = false;
        }
    }
    
    // when start clicked
    ele.querySelector(".startHighlight").onclick = function() {
        article.innerHTML = article.innerHTML.replace(/\n|<mark.*?>/g,'');

        // save highlight everytime dragged
        article.addEventListener('mousemove', l_mousemove);
        article.addEventListener('mouseup', l_mouseup);

        // show submit button
        submit.classList.remove("hidden");
        this.classList.add("hidden");
    }

    // when finish clicked
    submit.addEventListener("click", function(e) {

        // mark highlighted text
        let result = showHighlight();
        if (result == "err") {
            e.preventDefault();
        }
        else {
            // remove listeners
            article.removeEventListener('mousemove', l_mousemove);
            article.removeEventListener('mouseup', l_mouseup);
        }

        // initialize
        highlight = {};

    });



    function saveHighlight() {

        if (window.getSelection) {
            let sel = window.getSelection();
            highlight.content = sel.toString();
    
            if (sel.rangeCount && highlight.content.length > 0) {
                highlight.range = sel.getRangeAt(0);
            }
        }
        else { // IE < 9
            alert("Please use browser other than Internet Explorer 6-8 (version 9+ is fine)")
            return;
        }

        // parse the information to input 
        let content = highlight.content.trim(),
            content_tokens = tokenizer.sentences(content),
            start = 0,
            end = 0,
            offsetStart = 0,
            offsetEnd = 0,
            isFound = false;

        // calc offset etc
        for (let i = 0; !isFound && i < article_tokens.length; i++) {
            for (let j = 0; j < content_tokens.length; j++) {
                let sen = article_tokens[i + j]
                
                if (sen && sen.includes(content_tokens[j].trim())) {

                    if (j == content_tokens.length - 1) {
                        start = i;
                        end = i + j;

                        offsetStart = article_tokens[i].indexOf(content_tokens[0]);
                        offsetEnd = (j == 0) ?  offsetStart + content_tokens[j].length - 1 : content_tokens[j].length - 1;

                        isFound = true;

                        break;
                    }
                }
                else {
                    break;
                }
            }
        }

        ele.querySelector("input[name='answer_value']").value = (start + ", " + end + ", " + offsetStart + ", " + offsetEnd);
    
    }

    function showHighlight() {
        let span = document.createElement("mark");
        
        if (!highlight.content) {
            console.log(highlight);
            return "err";
        }
        else if (highlight.content.length < 3) {
            alert("Select at least 3 characters.")
            return "err";
        }
        else if (tokenizer.sentences(highlight.content, {}).length > 3) {
            alert("You cannot select more than 3 sentences")
            return "err";
        }
        else if (highlight.range.cloneContents().querySelector("mark")) {
            console.log("overlap");
            console.log(highlight);
            console.log(highlight.range.cloneContents().querySelector("mark"));
            alert("You cannot overlap the highlights. Nor can you select incomplete words.")
            return "err";
        }
        else if (highlight.range.startContainer.parentElement.id != "articleContent" || highlight.range.endContainer.parentElement.id != "articleContent") {
            alert("Out of boundary. Or do not select incomplete words.")
            return "err";
        }
        else {
            highlight.range.surroundContents(span);
            return span;
        }
    }
}



