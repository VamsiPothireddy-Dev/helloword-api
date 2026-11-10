def test_health(client):
    response = client.get("/health")
    assert response.status_code == 200
    assert response.get_json() == {"status": "ok"}


def test_version(client):
    response = client.get("/version")
    assert response.status_code == 200
    assert "version" in response.get_json()


def test_hello(client):
    response = client.get("/hello?name=devin")
    assert response.status_code == 200
    assert response.get_json() == {"message": "hello, devin!"}
