const {userConnection,adminConnection,staffConnection} = require('../db')
const connection = adminConnection;

const adminLoginStatusModel = {
    async getLoginStatus() {
        const [rows] = await connection.query(
            "SELECT Username, Status FROM login"
        );
        return rows;
    },

    async updateLoginStatus(username, status) {
        const [rows] = await connection.query(
            "UPDATE login SET Status = ? WHERE Username = ?",
            [status, username]
        );
        return rows;
    }

};

module.exports = adminLoginStatusModel;