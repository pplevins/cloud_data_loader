from fastapi import FastAPI, HTTPException

from services.data_loader.dal import PeopleDAL

app = FastAPI()
dal = PeopleDAL()


@app.get("/get-all")
async def get_people_records():
    """Get people records from the database."""
    try:
        return {"values": dal.get_all_people()}
    except Exception as e:
        raise HTTPException(status_code=400, detail=str(e))
