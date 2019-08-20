
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
                highlight = {};
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
            swal("Invalid", "Please use browser other than Internet Explorer 6-8 (version 9+ is fine)", "error")
            return;
        }

        // validation
        if (!highlight.content) {
            return "err";
        }
        else if (highlight.content.length < 15) {
            swal("Invalid", "Too short.", "error")
            return "err";
        }
        else if (tokenizer.sentences(highlight.content, {}).length > 3) {
            swal("Invalid", "You cannot select more than 3 sentences", "error")
            return "err";
        }
        else {
            let range = highlight.range;
            let startWord, endWord;
            let startingBefore = false;
            let first = false;

            console.log(range)

            // change range automatically if any tag detected
            if (!isProper(range.startContainer.parentElement.tagName)) {
                let prev = range.startContainer.parentElement.previousSibling;
                highlight.range.setStart(prev, prev.length - 1)

                let words = prev.textContent.trim().split(" ");
                startWord = words[words.length - 1];
                startingBefore = true;
            }
            else if (!isProper(range.endContainer.parentElement.tagName)) {
                endWord = range.endContainer.textContent.trim()

                highlight.range.setEnd(range.endContainer.parentElement.nextSibling, 1)
            }

            // alert if across paragraphs
            let start = range.startContainer.parentElement.dataset.index,
            end = range.endContainer.parentElement.dataset.index;

            if (start != end) {
                swal("Invalid", "Do not highlight across multiple paragraphs.", "error")
                return "err";
            }

            // calculate offsets
            if (!startWord) 
                startWord = range.startContainer.textContent.slice(range.startOffset).trim();
            if (!endWord) {
                endWord = range.endContainer.textContent.slice(0, range.endOffset).trim();

                if (endWord.length < 3) {
                    endWord = range.endContainer.textContent.trim().split(" ")[0]
                    first = true;
                }
            }

            ps = makePS();
            let startOffset = (startingBefore) ? ps[start].innerHTML.indexOf(startWord) + startWord.length : ps[start].innerHTML.indexOf(startWord);
            let endOffset = ps[start].innerHTML.indexOf(endWord) + endWord.length;
            if (first) {
                endOffset -= endWord.length;
            }

            console.log(startOffset + " " + endOffset)

            if (startOffset > endOffset) {
                return "err";
            }

            // save
            ele.querySelector("input[name='answer_value']").value = start + "," + startOffset + "," + endOffset + ",";
        }
    }

    function showHighlight() {
        let span = document.createElement("mark");
        if (!highlight.range) {
            swal("Invalid", "Nothing selected", "error");
            return "err";
        }
        highlight.range.surroundContents(span);
        return span;
    }

    function isProper(tagName) {
        return (tagName == "P" || tagName == "H1" || tagName == "H4")
    }

    function markHighlight(value) {
        let splitted = value.split(",");

        let index = parseInt(splitted[0]),
            startOffset = parseInt(splitted[1]),
            endOffset = parseInt(splitted[2]);

        ps = makePS();
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



