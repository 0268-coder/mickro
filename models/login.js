const connection = require('../db');

const loginModel = {
    // add Login queries to database
    getUserLogin: async (username, password) => {
        const [rows] = await connection.query(
            `SELECT * FROM Login 
            WHERE Username = ?`,
            [username]);
        return rows[0];
    }
};

module.exports = loginModel;