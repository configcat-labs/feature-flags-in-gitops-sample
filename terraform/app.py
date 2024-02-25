from flask import Flask, jsonify, request
import configcatclient

configcat_client = configcatclient.get("YOUR-CONFIGCAT-SDK-KEY")

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
    isFeatureFlagEnabled = configcat_client.get_value('YOUR-FEATURE-FLAG-KEY')
    if isFeatureFlagEnabled:
        total_users = len(users)
        return jsonify({"total_users": total_users})
    else:
        return "Sorry this endpoint is not available"

if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0', port=5000)
