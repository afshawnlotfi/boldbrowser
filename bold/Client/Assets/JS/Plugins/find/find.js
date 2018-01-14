//The MIT License (MIT)
//
//Copyright (c) [2016] [Scott Stahurski]
//
//Permission is hereby granted, free of charge, to any person obtaining a copy
//of this software and associated documentation files (the "Software"), to deal
//in the Software without restriction, including without limitation the rights
//to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//copies of the Software, and to permit persons to whom the Software is
//furnished to do so, subject to the following conditions:
//
//The above copyright notice and this permission notice shall be included in all
//copies or substantial portions of the Software.
//
//THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//SOFTWARE.



//Modified by Afshawn Lotfi

var currentlySelectedIndex = -1;
var totalResults = 0;


// helper function, recursively searches in elements and their child nodes
function highlightAllOccurencesForElement(element,keyword) {
    
    if (element) {
        if (element.nodeType == 3) {        // Text node
            while (true) {
                var value = element.nodeValue;  // Search for keyword in text node
                var indexOfElement = value.toLowerCase().indexOf(keyword);
                
                if (indexOfElement < 0) break;             // not found, abort
                
                var span = document.createElement("span");
                var text = document.createTextNode(value.substr(indexOfElement,keyword.length));
                span.appendChild(text);
                span.setAttribute("class","highlightedTag");
                span.style.backgroundColor="yellow";
                span.style.color="black";
                text = document.createTextNode(value.substr(indexOfElement+keyword.length));
                element.deleteData(indexOfElement, value.length - indexOfElement);
                var next = element.nextSibling;
                element.parentNode.insertBefore(span, next);
                element.parentNode.insertBefore(text, next);
                element = text;
                totalResults++;  // update the counter
                
            }
        } else if (element.nodeType == 1) { // Element node
            if (element.style.display != "none" && element.nodeName.toLowerCase() != 'select') {
                for (var i=element.childNodes.length-1; i>=0; i--) {
                    highlightAllOccurencesForElement(element.childNodes[i],keyword);
                }
            }
        }
    }
    

}

function hightlightAllOccurences(keyword) {
    removeHighlights();
    highlightAllOccurencesForElement(document.body, keyword.toLowerCase());
    return totalResults

}


function searchNext(){
    goToNextIndex(1);
    return currentlySelectedIndex
}
function searchPrev(){
    goToNextIndex(-1);
    return currentlySelectedIndex
    
}

function goToNextIndex(increment){
    prevSelected = currentlySelectedIndex;
    currentlySelectedIndex = currentlySelectedIndex + increment;
    
    if (currentlySelectedIndex < 0){
        currentlySelectedIndex = totalResults + currentlySelectedIndex;
    }
    
    if (currentlySelectedIndex >= totalResults){
        currentlySelectedIndex = currentlySelectedIndex - totalResults;
    }
    
    prevEl = document.getElementsByClassName("highlightedTag")[prevSelected];
    
    if (prevEl){
        prevEl.style.backgroundColor="yellow";
    }
    el = document.getElementsByClassName("highlightedTag")[currentlySelectedIndex];
    el.style.backgroundColor="rgb(255, 140, 40)";
    
    
    el.scrollIntoView(true);
    var scrolledY = window.scrollY;
    if(scrolledY){
        window.scroll(0, scrolledY - 200);
    }
}


// the main entry point to start the search

// helper function, recursively removes the highlights in elements and their childs
function removeHighlightsForElement(element) {
    if (element) {
        if (element.nodeType == 1) {
            if (element.getAttribute("class") == "highlightedTag") {
                var text = element.removeChild(element.firstChild);
                element.parentNode.insertBefore(text,element);
                element.parentNode.removeChild(element);
                return true;
            } else {
                var normalize = false;
                for (var i=element.childNodes.length-1; i>=0; i--) {
                    if (removeHighlightsForElement(element.childNodes[i])) {
                        normalize = true;
                    }
                }
                if (normalize) {
                    element.normalize();
                }
            }
        }
    }
    return false;
}

// the main entry point to remove the highlights
function removeHighlights() {
    
    totalResults = 0;
    currentlySelectedIndex = -1;
    
    removeHighlightsForElement(document.body);
}
