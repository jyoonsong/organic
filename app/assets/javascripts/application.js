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
let ps;

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
            ps = Array.from( document.querySelectorAll(".article > p") )
            ps.forEach(function(p, i) {
                p.dataset.index = i;
            })

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
                },
                onCloseEnd: function(ele) {
                    if (ele.classList.contains("highlight")) {
                        let article = document.querySelector(".article");
                        article.innerHTML = article.innerHTML.replace(/\n|<mark.*?>/g,'');
                    }
                }
            }
        }

        instance = M.Collapsible.init(elem, options);

    }

});

function initHighlight(ele) {
    const article = document.querySelector(".article");
    let submit = ele.querySelector(".submitHighlight");
    let drag = false;
    let highlight = {};
    

    // mark highlight if exists
    let value = ele.querySelector("input[name='answer_value']").value;
    if (value.length > 0) {
        markHighlight(value);
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
            errorHandler();
        }
        else {
            // remove listeners
            article.removeEventListener('mousemove', l_mousemove);
            article.removeEventListener('mouseup', l_mouseup);
        }

        // initialize
        highlight = {};

    });


    function l_mousemove() {
        drag = true;
    }
    function l_mouseup() {
        if (drag) {
            let result = saveHighlight();
            if (result == "err") {
                errorHandler();
            }
            drag = false;
        }
    }

    function saveHighlight() {

        // get selection
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

        // validation
        if (!highlight.content) {
            return "err";
        }
        else if (highlight.content.length < 15) {
            alert("Too short.")
            return "err";
        }
        else if (tokenizer.sentences(highlight.content, {}).length > 3) {
            alert("You cannot select more than 3 sentences")
            return "err";
        }
        else {
            let range = highlight.range;

            // change range automatically if any tag detected
            if (range.startContainer.parentElement.tagName != "P") {
                let prev = range.startContainer.parentElement.previousSibling;
                highlight.range.setStart(prev, prev.length - 1)
            }
            else if (range.endContainer.parentElement.tagName != "P") {
                highlight.range.setEnd(range.endContainer.parentElement.nextSibling, 1)
            }

            // alert if across paragraphs
            let start = range.startContainer.parentElement.dataset.index,
                end = range.endContainer.parentElement.dataset.index;

            if (start != end) {
                alert("Do not highlight across multiple paragraphs.")
                return "err";
            }

            // calculate offsets
            let startWord = range.startContainer.textContent.slice(range.startOffset).trim(),
                endWord = range.endContainer.textContent.slice(0, range.endOffset).trim();

            ps = Array.from( document.querySelectorAll(".article > p") );
            let startOffset = ps[start].innerHTML.indexOf(startWord);
            let endOffset = ps[start].innerHTML.indexOf(endWord) + endWord.length;

            if (startOffset > endOffset) 
                return "err";

            // save
            ele.querySelector("input[name='answer_value']").value = start + "," + startOffset + "," + endOffset;
        }
    }

    function showHighlight() {
        let span = document.createElement("mark");
        if (!highlight.range) {
            alert("Nothing selected");
            return "err";
        }
        highlight.range.surroundContents(span);
        return span;
    }

    function isProper(range) {
        // (range.commonAncestorContainer.parentElement.tagName == "p" // text
        // || range.commonAncestorContainer.parentElement.classList.contains("article") // same p
        // || range.commonAncestorContainer.classList.contains("article")) // different p
        let start = range.startContainer.parentElement.dataset.index,
            end = range.endContainer.parentElement.dataset.index;
        if (range.startContainer.parentElement.tagName != "P") {
            start = range.startContainer.parentElement.parentElement.dataset.index;
        }
        else if (range.endContainer.parentElement.tagName != "P") {
            end = range.endContainer.parentElement.parentElement.dataset.index;
        }
        return (start == end);
    }

    function markHighlight(value) {
        let splitted = value.split(",");

        let index = parseInt(splitted[0]),
            startOffset = parseInt(splitted[1]),
            endOffset = parseInt(splitted[2]);

        ps = Array.from( document.querySelectorAll(".article > p") );
        let inner = ps[index].innerHTML;
        ps[index].innerHTML = inner.slice(0, startOffset) + "<mark>" + inner.slice(startOffset, endOffset) + "</mark>" + inner.slice(endOffset);
    }

    function errorHandler() {
        if (window.getSelection().empty) {  // Chrome
            window.getSelection().empty();
        } else if (window.getSelection().removeAllRanges) {  // Firefox
            window.getSelection().removeAllRanges();
        }
        return;
    }
}



