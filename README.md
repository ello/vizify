<img src="http://d324imu86q1bqn.cloudfront.net/uploads/user/avatar/641/large_Ello.1000x1000.png" width="200px" height="200px" />

# Vizify - Simple service to render Graphviz input as an SVG

[![Build Status](https://travis-ci.org/ello/vizify.svg?branch=master)](https://travis-ci.org/ello/vizify)

We occasionally have a need to put things like graphs and diagrams in project
READMEs. [Graphviz](http://www.graphviz.org/) is an awesome tool for that sort
of thing, but it's always been a bit of a pain to actually get rendered graphs
processed and linked in.

This service lets you generate an SVG from a Graphviz source, passed either via
a URL or as a string, e.g.

`http://<your-service-hostname>/?url=<something>`

or

`http://<your-service-hostname>/?dot=<contents of a DOT file>`


### Quickstart

This is a vanilla Ruby/Sinatra application:

* Install rbenv/rvm/Ruby 2.3
* Clone this repo
* Run `bundle install`
* Run the test suite with `bundle exec rake`

##### Deployment, Operations, and Gotchas
The service is packaged up with an Aptfile for [the APT buildpack](https://github.com/ddollar/heroku-buildpack-apt) that should allow it to be pushed directly to a Heroku application.

After cloning this repo and creating your Heroku app, you'll need to add the APT buildpack to your configuration using the following:

```
$ heroku buildpacks:add https://github.com/ddollar/heroku-buildpack-apt.git
```

## License
Vizify is released under the [MIT License](blob/master/LICENSE.txt)

## Code of Conduct
Ello was created by idealists who believe that the essential nature of all human beings is to be kind, considerate, helpful, intelligent, responsible, and respectful of others. To that end, we will be enforcing [the Ello rules](https://ello.co/wtf/policies/rules/) within all of our open source projects. If you don’t follow the rules, you risk being ignored, banned, or reported for abuse.
