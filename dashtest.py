from sys import exit
from signal import SIGINT, signal
from dash import Dash, html, dcc, Input, Output, callback
import plotly.express as px
import pandas as pd

app = Dash(server=True
    ,external_stylesheets=['https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css']
)

data = pd.DataFrame()
fig = px.line(data_frame=data)

app.layout = [
    html.H1(className='navbar',id='title-text', children='System Statistics'),
    html.Div(children=[
       html.H3(children='Stressors Stats'),
        dcc.Tabs(id='tab-group',value='cpu-graph',
            children=[
                dcc.Tab(label="CPU",value='cpu-graph'),
                dcc.Tab(label="Virtual Memory",value='vm-graph'),
                dcc.Tab(label="RAM File System",value='ramfs-graph'),
                dcc.Tab(label="Hard Disk",value='hdd-graph'),
                dcc.Tab(label="Async In/Out",value='aio-graph')
            ]
        ),
        html.Div(id='graph-div')
    ]),
    html.Footer(id='footer')
]

@callback(
    Output(component_id='graph-div', component_property='children'),
    Input(component_id='tab-group', component_property='value')
)
def update_displayedGraph(tab) -> html.Div:
    global fig
    if tab == 'cpu-graph':
        graph_title = html.H2(children='%CPU Usage', className='text-center')
        graph = dcc.Graph(figure=fig)
    elif tab == 'vm-graph':
        graph_title = html.H2(children='Virtual Mem. Utilization', className='text-center')
        graph = dcc.Graph(figure=fig)
    elif tab == 'ramfs-graph':
        graph_title = html.H2(children='RAM File System', className='text-center')
        graph = dcc.Graph(figure=fig)
    elif tab == 'hdd-graph':
        graph_title = html.H2(children='Hard Drive Utilization', className='text-center')
        graph = dcc.Graph(figure=fig)
    elif tab == 'aio-graph':
        graph_title = html.H2(children='Async IO Throttling', className='text-center')
        graph = dcc.Graph(figure=fig)
    else:
        graph_title = html.H2(children='Untitled', className='text-center')
        graph = dcc.Graph(figure=dict([]))
    return html.Div(children=[graph_title,graph])

def sigint_handle(sig, frame):
    exit(0)

if __name__ == "__main__":
    signal(SIGINT, sigint_handle)
    app.run(debug=True, port=8000)
