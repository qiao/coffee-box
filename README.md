CoffeeBox
=========

CoffeeBox is a lightweight blog engine designed for fashionable developers. It's built upon `Node.js`, `Express`, `MongoDB` and `CoffeeScript`. 

You may check out http://66.228.62.171:3000 for a demo page. Note that this project is still in heavy construction; lots of functionalities are to be implemented. If you are interested in this project, then a pull request or a issue ticket will always be appreciated.

Features
--------

* Markdown is your best friend on easy formatting.
* Every developer loves syntax highlighting.
* Previews on posts and comments rest the minds of you and your visitors.
* Login with OpenID, leave the dirty work to the professionals.
* Embrace HTML5, embrace the future.
* Ajax contributes a lot to smooth interaction.
* Wow, Node.js is lightning fast!
* Asset pipeline should be a standard component.
* CoffeeScript === Javascript, The Good Parts.

Getting Started
---------------

You may first need to install `Node.js`, `npm`, `MongoDB`, `python2` and `pygments`, and make sure that `MongoDB` is running.

Then clone this project and install the dependecies.

    git clone https://github.com/qiao/coffee-box
    cd coffee-box
    npm install

The site configuration file is `config/site.json`, you will need to modify it accordingly. Note that you will need an OpenID in order to login. You may register one at http://www.myopenid.com.

To start the server in production mode:

    NODE_ENV=production node index.js

Now navigate your browser to `localhost:3000`, you should see CoffeeBox up and running.

Developing
----------

Some notices:

* The layout of CoffeeBox's code base follows Rails' convention. 
* All assets will be compiled when the first request comes, thus it will take longer time to wait for the first response, but the subsequent requests will be handled normally. 
* For convenience, when the server is running in developement environment, the OpenId login is not enabled and you can login to the dashboard with even empt password. So be sure to add `NODE_ENV=production` when deploying the site.
