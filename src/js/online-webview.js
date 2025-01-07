function openInWebView(startUrl) {
    window.Capacitor.Plugins.InAppBrowser.openInWebView({
        url: startUrl,
        options: {
            // See https://github.com/ionic-team/capacitor-os-inappbrowser/blob/e5bee40e9b942da0d4dad872892f5e7007d87e75/src/defaults.ts#L33
            // Constant values are in https://github.com/ionic-team/capacitor-os-inappbrowser/blob/e5bee40e9b942da0d4dad872892f5e7007d87e75/src/definitions.ts
            showToolbar: false,
            showURL: false,

            clearCache: true,
            clearSessionCache: true,
            mediaPlaybackRequiresUserAction: false,

            // closeButtonText: 'Close',
            // toolbarPosition: 'TOP', // ToolbarPosition.TOP

            // showNavigationButtons: true,
            // leftToRight: false,
            customWebViewUserAgent: 'capacitor webview',

            android: {
                showTitle: false,
                hideToolbarOnScroll: false,
                viewStyle: 'BOTTOM_SHEET', // AndroidViewStyle.BOTTOM_SHEET

                startAnimation: 'FADE_IN', // AndroidAnimation.FADE_IN
                exitAnimation: 'FADE_OUT', // AndroidAnimation.FADE_OUT
                allowZoom: false
            },
            iOS: {
                closeButtonText: 'DONE',           // DismissStyle.DONE
                viewStyle: 'FULL_SCREEN',          // iOSViewStyle.FULL_SCREEN
                animationEffect: 'COVER_VERTICAL', // iOSAnimation.COVER_VERTICAL
                enableBarsCollapsing: true,
                enableReadersMode: false
            }
        }
    });
}

if (window.Capacitor) {
    let timeoutId = setTimeout(() => {
        openInWebView(process.env.START_URL);
    }, 200);

    window.Capacitor.Plugins.App.addListener('appUrlOpen', (event) => {
        clearTimeout(timeoutId);
        openInWebView(event.url);
    });

} else {
    console.log("Error, Capacitor not loaded");
}
