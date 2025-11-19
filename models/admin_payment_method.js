const {userConnection,adminConnection,staffConnection} = require('../db')
const connection = adminConnection;

const paymentMethodModel = {
    getPaymentMethod: async () => {
        const [rows] = await connection.query(
            "SELECT * FROM payment_method"
        );
        return rows;
    },

    updateMethod: async (id, method) => {
        const [rows] = await connection.query(
            "UPDATE payment_method SET Method_Type = ? WHERE Payment_Method_ID = ?",
            [method, id]
        );
        return rows;
    },

    deleteMethod: async (id) => {
        const [rows] = await connection.query(
            "DELETE FROM payment_method WHERE Payment_Method_ID = ?",
            [id]
        );
        return rows;
    },

    addMethod: async (method) => {
        const [rows] = await connection.query(
            "INSERT INTO payment_method (Method_Type) VALUES (?)",
            [method]
        );
        return rows;
    }

};

module.exports = paymentMethodModel;