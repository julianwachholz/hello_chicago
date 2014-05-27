hello_chicago
=============

A rather simple [ChicagoBoss](http://www.chicagoboss.org/) demo application,
created by following the official introductory
[tutorial](http://www.chicagoboss.org/tutorial.pdf).

Requirements
------------

You should have current releases of both Erlang/OTP and
[`rebar`](https://github.com/rebar/rebar) installed.

Installation
------------

Installing and compiling is done with `make`:

    $ git clone http://github.com/julianwachholz/hello_chicago
    $ cd hello_chicago
    $ make rel
    $ rel/hello_chicago/bin/hello_chicago start

To get a console, use `console` as parameter or:

    $ rel/hello_chicago/bin/hello_chicago attach
