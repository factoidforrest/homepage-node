'use strict';

require.config({
    baseUrl: "./scripts",
    paths: {
       requireLib: "require",
    },
    shim: {
        #"jquery_timeago": ["jquery"],
    },
    bundles: {

    },
    name: "main",
    out: "build/main.js",
    include: "requireLib",
    preserveLicenseComments: false
});

require(['navigation'], function(nav) {
    console.log("loaded")
	


});