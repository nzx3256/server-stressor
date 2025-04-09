import os
from sys import exit
from signal import SIGINT, signal
from dash import Dash, html, dcc, Input, Output, callback
import plotly.express as px
import pandas as pd
import numpy as np

INSTALL_LOC = '/opt/stress-app'
if not os.path.exists(INSTALL_LOC):
    print('must install stress-app through install.sh')
    print('\tsudo ./install.sh')
    exit(1)
df = pd.read_csv(INSTALL_LOC+"/cputab")
fig=px.line(data_frame=df,y='bogo_ops',x=np.arange(0,df.shape[0]), title="%CPU Usage")


app = Dash(server=True
    ,external_stylesheets=['https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css']
)

app.layout = [
    html.H1(className='navbar; text-center',id='title-text', children=[html.Div(children='System Statistics')],style={'background-color':'red'}),
    html.Br(),
    html.Div(children=[
        dcc.RadioItems(
            id='metrics-radio',
            options={
                'bogo_ops':'Bogo Operations',
                'real_time':'Real Time (sec)',
                'usr_time':'User Time (sec)',
                'sys_time':'System Time (sec)',
                'bogo_OPS_rt':'Bogo Ops/s (real time)',
                'bogo_OPS_ust':'Bogo Ops/s (usr+real time)'
            },
            value='bogo_ops',
            inline=True,
            labelStyle={'display':'inline-block','margin':'0 5px 0 50px'}
        ),
        html.Br(),
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
        html.Div(id='graph-div', children=[
            dcc.Graph(figure=fig)
        ]),
    ]),
    dcc.Interval(id='timer',
                 disabled=False,
                 n_intervals=0,
                 interval=10*1000
    ),
    html.Footer(id='footer')
]

@callback(
    Output(component_id='graph-div', component_property='children'),
    Input(component_id='tab-group', component_property='value'),
    Input(component_id='metrics-radio', component_property='value'),
    Input(component_id='timer', component_property='n_intervals')
)
def update_displayedGraph(tab,radio_option,_) -> html.Div:
    global fig
    fig = dict([])
    title_text = "Untitled"
    if tab == 'cpu-graph':
        df=pd.read_csv(INSTALL_LOC+'/cputab')
        title_text='%CPU Usage'
    elif tab == 'vm-graph':
        df=pd.read_csv(INSTALL_LOC+'/vmtab')
        title_text='Virtual Mem. Utilization'
    elif tab == 'ramfs-graph':
        df=pd.read_csv(INSTALL_LOC+'/ramfstab')
        title_text='RAM File System'
    elif tab == 'hdd-graph':
        df=pd.read_csv(INSTALL_LOC+'/hddtab')
        title_text='Hard Drive Utilization'
    elif tab == 'aio-graph':
        df=pd.read_csv(INSTALL_LOC+'/aiotab')
        title_text='Async IO Throttling'
    fig=px.line(data_frame=df,y=radio_option,x=np.arange(0,df.shape[0]), title=title_text)
    return html.Div(children=[
        dcc.Graph(figure=fig)
    ])

def sigint_handle(sig, frame):
    exit(0)

if __name__ == "__main__":
    signal(SIGINT, sigint_handle)
    app.run(debug=True, port=8050)
