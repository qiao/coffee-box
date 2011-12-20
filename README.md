CoffeeBox
=========

CoffeeBox is a lightweight blog engine designed for fashionable developers. It's built upon `Node.js`, `Express`, `MongoDB` and `CoffeeScript`. 

You may check out http://66.228.62.171:3000 for a demo page. Note that this project is still in heavy construction; lots of functionalities are to be implemented. If you are interested in this project, then a pull request or a issue ticket will always be appreciated.

Features
--------

1. Markdown is your best friend on easy formatting.
2. Every developer loves syntax highlighting.
3. Previews on posts and comments rest the minds of you and your visitors.
4. Embrace HTML5, embrace the future.
5. Ajax contributes a lot to smooth interaction.
6. Wow, Node.js is lightning fast!
7. Asset pipeline should be a standard component.
8. CoffeeScript === Javascript, The Good Parts.

Getting Started
---------------

You may first need to install `Node.js`, `npm` and `MongoDB`, and make sure that `MongoDB` is running.

Then clone this project and install the dependecies.

    git clone https://github.com/qiao/coffee-box
    cd coffee-box
    npm install

The site configuration file is `config/site.coffee`, modify it to meet your need and then start the server.

    NODE_ENV=production node index.js

Now navigate your browser to `localhost:3000`, you should see CoffeeBox up and running.

That's it, enjoy!
