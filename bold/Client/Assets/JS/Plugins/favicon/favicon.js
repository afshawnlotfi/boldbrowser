var totalResults = 0;

function main(){
    
    var selectors = ["link[rel='apple-touch-icon']","link[rel~='icon']","link[rel='apple-touch-icon-precomposed']"];
    var iconSelector;
    
    for (var selector in selectors) {
        if (document.head.querySelectorAll(selectors[selector]).length >= 1){
            iconSelector = document.head.querySelectorAll(selectors[selector]).item(0).href
            break;
        }else{
            iconSelector = document.location.origin + "/favicon.ico"
        }
    }
    window.webkit.messageHandlers.faviconHandler.postMessage(iconSelector);

}

