function main(){
    var scripts = document.getElementsByTagName('script')
    var styles = document.head.querySelectorAll("link[rel='stylesheet']")
    
    var jsonData = {
        html : document.documentElement.outerHTML.toString(),
        scripts : [],
        styles : []
    };
    
    for (i = 0; i < scripts.length; i++) {
        if (scripts[i].src != ""){
            jsonData.scripts.push(scripts[i].src)
        }
        
    }
    for (i = 0; i < styles.length; i++) {
        if (styles[i].href != ""){
            jsonData.styles.push(styles[i].href)
        }
    }
    
    var response = JSON.stringify(jsonData)
    
    window.webkit.messageHandlers.resourceHandler.postMessage(response);
}


