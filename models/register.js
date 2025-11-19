const connection = require('../db');

const registerModel = {
    // add Register queries to database
    register: async (firstName, lastName, username, email, password, dateOfBirth, phoneNumber, address) => {
        //call procedure
        const [userRows] = await connection.query(
            "CALL register_new_user(?,?,?,?,?,?,?,?)",
            [username,password,firstName,lastName,email,phoneNumber,dateOfBirth,address]
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