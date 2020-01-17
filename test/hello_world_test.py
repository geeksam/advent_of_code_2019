from ..hello_world import get_greetings

def test_greetings():
    assert get_greetings() == "Hello World!"
