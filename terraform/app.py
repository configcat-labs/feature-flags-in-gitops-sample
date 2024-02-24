from flask import Flask, jsonify, request

app = Flask(__name__)

# Sample user data
users = [
    {"id": 1, "name": "Alice"},
    {"id": 2, "name": "Bob"},
    {"id": 3, "name": "Charlie"}
]

@app.route('/users', methods=['GET'])
def get_users():
    return jsonify(users)

@app.route('/user_count', methods=['GET'])
def get_user_count():
    name = request.args.get('name')
    if name:
        count = sum(1 for user in users if user['name'] == name)
        return jsonify({"count": count})
    else:
        total_users = len(users)
        return jsonify({"total_users": total_users})

if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0', port=5000)
