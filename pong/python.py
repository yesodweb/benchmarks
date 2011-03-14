#!/usr/bin/python

def myapp(environ, start_response):
    start_response('200 OK', [('Content-Type', 'text/plain')])
    return ['PONG']

from flup.server.fcgi import WSGIServer
WSGIServer(myapp).run()
