CRONY
=====

Crony is a template project to implement a crontab like scheduler. [rufus-scheduler](https://github.com/jmettraux/rufus-scheduler) is used for scheduling and [foreman](https://github.com/ddollar/foreman) is used for running the scheduler. This makes it perfect for a deployment on [heroku](http://heroku.com)'s [Caledon Cedar](http://devcenter.heroku.com/articles/cedar) stack.


Usage
-----

Just fork/clone this repository, install the gems needed using bundler:

```bash
bundle install
```

and start the scheduler using foreman:

```bash
bundle exec foreman start
```

Your crony won't do much yet, so add some cron jobs now.


Adding Cron Jobs
----------------

Each (non hidden) file in the `cron.d` directory will be evaluated and can be used to schedule jobs. Refer to [rufus-scheduler](https://github.com/jmettraux/rufus-scheduler)'s documentation on how to schedule jobs. Just be aware that your `cron.d` files will be evaluated in the context of the scheduler instance, so you can access all methods the scheduler has. Here's an example:

```ruby
every "5m" do
  # do something every five minutes
end
```

Within your `cron.d` files, you can do anything. Requiring other files/gems (just remember to put them into your `Gemfile` first), defining classes/methods etc.


Helpers
-------

There's a helper for pinging sites (eg to start some tasks or just to keep them alive when the hoster shuts them down after a certain time of inactivity) within the `lib` directory. This directory is in the load path, so you can just require the files in here and use them within your `cron.d` files. Feel free to add helpers of your own.

```ruby
require "http_ping"

every "15m" do
  HttpPing.ping "http://my.server/action/to/start"
end
```


Heroku Deployment
-----------------

After you've added your jobs and helpers, you're ready to deploy your jobs to heroku:

```bash
# create an application on the Caledon Cedar stack
heroku create --stack cedar

# tell heroku not to install the gems you only need for your local development/testing
heroku config:add BUNDLE_WITHOUT=development

# deploy your code
git push heroku master

# scale your worker (one is well within heroku's limits for a free app)
heroku ps:scale worker=1
```

After this, your private crony instance will happily be running and executing your jobs.


Contributing
------------

If you want to contribute changes you've made, helper scripts or anything else, please fork this repository and send a pull request with your changes.


License
-------

[MIT](http://www.opensource.org/licenses/mit-license.php)

Copyright (c) 2011 Thomas Jachmann

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.