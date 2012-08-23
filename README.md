[![build status](https://secure.travis-ci.org/qiao/coffee-box.png)](http://travis-ci.org/qiao/coffee-box)
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

* The layout of CoffeeBox's codebase follows Rails' convention. 
* All assets will be compiled when the first request comes, thus it will take longer time to wait for the first response, but the subsequent requests will be handled normally. 
* For convenience, when the server is running in developement environment, the OpenId login is not enabled and you can login to the dashboard with even empty account. So be sure to add `NODE_ENV=production` when deploying the site.

License
-------

[MIT License](http://www.opensource.org/licenses/mit-license.php)

&copy; 2011-2012 Xueqiao Xu &lt;xueqiaoxu@gmail.com&gt;

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
