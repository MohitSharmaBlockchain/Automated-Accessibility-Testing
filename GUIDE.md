Behind the scenes, Pa11y-CI uses HTML CodeSniffer in a Headless Chrome to evaluate web pages based on the WCAG Guidelines. The HTML CodeSniffer is a client-side script that analyzes HTML source code and detects violations of defined standards, in this case, the WCAG.

Running Accessibility Tests
Pa11y-CI iterates over a list of web pages and highlights accessibility issues so to run Accessibility Tests locally CDLI framework should be running, please use the below commands at the root directory. Windows users use bash to run the commands
Command to run the CDLI Framework

./dev/cdlidev.py up


Command to run the Accessibility Tests locally

./cdlitest --accessibility



Pa11y-CI Configuration
By default, Pa11y-CI looks for a JSON config file named Config.json in the current working directory. You can configure Config.json accordingly (Use below examples for that)

Customise Accessibility defaults
Use defaults configuration option to set pa11y-ci default options for testing a page.

{
  "defaults": {
    "standard": "WCAG2AA",      //The accessibility standard to use when testing pages. This should be one of WCAG2A, WCAG2AA, or WCAG2AAA
    "timeout": 60000,           //Time in milliseconds that a test should be allowed to run before calling back with a timeout error.
    "level": "error"            //The level of issue which can fail the test. This should be one of error (the default), warning, or notice.
    "chromeLaunchConfig": {     //Launch options for the Headless Chrome instance
      "args": ["--no-sandbox"],
      "executablePath": "/usr/bin/chromium-browser",
      "ignoreHTTPSErrors": false
    }
  }
}



Testing multiple URLS
URLs option allows us to test multiple URLs in one go. We can also specify custom configurations for each page. We do this by passing an object into the urls, instead of a simple string. In addition to the url, we pass any of the pa11y configurations we want to override for that particular page. Use host.docker.internal instead of localhost to access the ports inside a docker container.

{
  "urls": [
    {
      "url": "http://host.docker.internal:2354/",
      "viewport": { "width": 320, "height": 480 },
      "actions": [
        "click element label.w-100",
        "screen capture screenshots/ResourseMobile.png"
      ]
    },
    "http://host.docker.internal:2354/login",
    "http://host.docker.internal:2354/register",
    "http://host.docker.internal:2354/users/profile"
  ]
}



Testing user actions
Actions are additional interactions that you can make Pa11y perform before the tests are run. They allow you to do things like click on a button, enter a value in a form, wait for a redirect, etc. You may need to increase the timeout if you have added large set of actions.

"urls": [
  {
    "url": "http://host.docker.internal:2354/",
    "actions": [                                                      //<selector> can be any CSS selector
      "click element <selector>",                                     //Allows you to click an element
      "wait for element <selector> to be visible",                    //Wait for an element to get visible
      "set field <selector> to John Doe",                             //Allows you to set the value of a text-based input or select box
      "check field <selector>",                                       //Allows you to check checkbox and radio inputs
      "uncheck field <selector>",                                     //Allows you to uncheck checkbox and radio inputs
      "screen capture screenshots/example.png",                       //Save a screen capture of the tested page
      "wait for url to be http://host.docker.internal:2354/browse",   //Wait for url to get changed to given url
      "wait for <selector> to emit load",                             //Wait for a selector to get loaded
      "navigate to http://host.docker.internal:2354/browse"           //Allows you to navigate to the given url
    ],
    "timeout": 60000
  }
]



Some more options to customize URLS
You can use the following options to customize a specific page or can use them as default by adding them to defaults configuration option.

{
  "defaults": {
    "hideElements": "#widgets, .widgets",                //A CSS selector to hide elements from testing, selectors can be comma separated
    "viewport": { "width": 320, "height": 480 },         //Allows us to specify the viewport dimensions to test a page
    "wait": 500,                                         //The time in milliseconds to wait before running tests on the page.
    "rules": [                                           //Array of WCAG 2.1 guidelines that you'd like to include to the current standard.
      "Principle1.Guideline1_4.1_4_6_AAA"
    ],
    "ignore": [                                          //Array of WCAG 2.1 guidelines and types that you'd like to ignore to the current standard.
      warning, notice,                                   //Types can be error, warning, and notice
      "WCAG2AA.Principle3.Guideline3_1.3_1_1.H57.2"
    ]
  }
}


Use HTML Code Sniffer ruleset to check for WCAG Guidelines Principles you can use in options ignore and rules.

Doing even more with Pa11y-CI
Pa11y-CI has an endless list of features and configuration options so we can test our sites in any number of ways. Checkout Pa11y and Pa11y-CI for more configuration options.
