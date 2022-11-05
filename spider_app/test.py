import json
with open ("test.txt", "r") as f:
    t = f.read()
    # print(t)

print(json.loads(t))