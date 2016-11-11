from flask import Flask, request
app = Flask(__name__)

db = ''

@app.route('/', methods = ['GET', 'POST'])
def api_root():
    global db

    if request.method == 'POST':
        db = request.get_data()

    return db

if __name__ == '__main__':
    app.run()

