#!/usr/bin/python3

from dash import html, Dash

app = Dash()

app.layout = [html.Div(children="Hello")]

if __name__ == "__main__":
    app.run(debug=True)
