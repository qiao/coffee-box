CoffeeBox
=========

CoffeeBox is a lightweight blog engine designed for fashionable developers. It's built upon `Node.js`, `Express`, `MongoDB` and `CoffeeScript`. It comes along with a clean theme and builtin supports for Markdown and syntax highlighting. You may check out http://66.228.62.171:3000 for a demo page. Note that this project is still in heavy construction; lots of functionalities are to be implemented. Any contribution will be appreciated.

Getting Started
---------------

You may first need to install `Node.js`, `npm` and `MongoDB`, and make sure that `MongoDB` is started.

Then clone this project and install the dependecies.

    git clone https://github.com/qiao/coffee-box
    cd coffee-box
    npm install

The site configuration file is `config/site.coffee`, modify it to meet your need and then start the server.

    NODE_ENV=production node index.js

That's it, enjoy!
