from app import app

@app.route("/")
def index():
    return "Hello!! Welcome to rental_591_analize"

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=8081, debug = True)
