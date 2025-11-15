const connection = require('../db');

const registerModel = {
    // add Register queries to database
    register: async (firstName, lastName, username, email, password, dateOfBirth, phoneNumber, address) => {
        const [userRows] = await connection.query(
            `INSERT INTO User (Fname, lName, Email, DOB, PhoneNumber, Address)
            VALUES (?, ?, ?, ?, ?, ?)`,
            [firstName, lastName, email, dateOfBirth, phoneNumber, address]);
        
        const [loginRows] = await connection.query(
            `INSERT INTO Login (Username, Password, User_ID)
            VALUES (?, ?, ?)`,
            [username, password, userRows.insertId]
        );

        return { user: userRows, login: loginRows };
    },

    //get User from Username
    getUserFromUsername: async (username) => {
        const [rows] = await connection.query(
            `SELECT * FROM User
            INNER JOIN Login ON User.ID = Login.User_ID
            WHERE Login.Username = ?`,
            [username]
        );
        return rows[0];
    },

    getEmailFromEmail: async (email) => {
        const [rows] = await connection.query(
            `SELECT * FROM User
            WHERE User.Email = ?`,
            [email]
        );
        return rows[0];
    }

};

module.exports = registerModel;