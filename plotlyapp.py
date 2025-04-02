#!/usr/bin/python3

from dash import html, Dash
import socket

ip = socket.gethostbyname(socket.gethostname())

app = Dash(server=True,name='app1')

app.layout = [html.Div(children="Hello")]

if __name__ == "__main__":
    app.run(debug=True,port=8000,host=ip)
