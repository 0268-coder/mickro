const connection = require('../db');

const addressModel = {

    updateAddress: async (address, userId) => {
        const [result] = await connection.query(
            `UPDATE User SET Address = ? WHERE ID = ?`,
            [address, userId]
        );
        return result;
    },

    getAddress: async (userId) => {
        const [result] = await connection.query(
            `SELECT Address FROM User WHERE ID = ?`,
            [userId]
        );
        return result[0].Address;
    }
};

module.exports = addressModel;