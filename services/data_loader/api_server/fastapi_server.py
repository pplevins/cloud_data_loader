from fastapi import FastAPI, HTTPException

from services.data_loader.dal import PeopleDAL

app = FastAPI()
dal = PeopleDAL()


@app.get("/get-all")
async def get_record_values():
    """Get record features from the model."""
    try:
        return {"values": dal.get_all_agents()}
    except Exception as e:
        raise HTTPException(status_code=400, detail=str(e))
