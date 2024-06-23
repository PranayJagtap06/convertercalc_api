import base64
from fastapi import FastAPI, Request, Response
from pydantic import BaseModel, FiniteFloat
from tf_response import plot_response


app = FastAPI()

class Params(BaseModel):
    d: float
    vin: float
    inductor: float
    capacitor: float
    resistor: float
    mode: str

@app.get("/root")
async def root():
    return {"Welcome to ConverterCalc API up and running..."}
    
@app.post("/root")
async def response_plot(params:Params):
    params = params.model_dump()
    d = params['d']
    vin = params['vin']
    inductor = params['inductor']
    capacitor = params['capacitor']
    resistor = params['resistor']
    mode = params['mode']

    plot, sys = plot_response(d, vin, inductor, capacitor, resistor, mode)

    plot_base64 = base64.b64encode(plot).decode('utf-8')
    
    return {"img": plot_base64, "transfer_func":sys}

