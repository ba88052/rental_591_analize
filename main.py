from app import app
import os

os.environ['TF_CPP_MIN_LOG_LEVEL'] = '2'
os.system("python3 data_platform.py")

@app.route("/")
def index():
    return "Hello!! Welcome to rental_591_analize"


# if __name__ == "__main__":
#     app.run(host="0.0.0.0", port=8081)
