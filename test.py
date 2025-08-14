import uvicorn

from services.data_loader.api_server import app

# NOTE: to use this test file on your local computer, make sure to port-forward the MySql service
# using the command: oc port-forward svc/mysql 3306:3306 -n pplevins-dev

if __name__ == "__main__":
    uvicorn.run(app, host="127.0.0.1", port=8000)
