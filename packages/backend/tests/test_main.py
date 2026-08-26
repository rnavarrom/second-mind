import sys
from fastapi.testclient import TestClient
sys.path.append('../src/backend/')
from backend.main import app

client = TestClient(app)

def test_root():
    response = client.get("/")
    assert response.status_code == 200
    assert response.json() == {"msg": "Hello World"}