const mysql = require("mysql2/promise.js");
const bcrypt = require("bcryptjs");
const jwt = require('jsonwebtoken');

const connectionConfig = {
    host: process.env.DB_HOST,
    user: process.env.DB_USER,
    database: process.env.DB_NAME,
    password: process.env.DB_PASSWORD,
    port: process.env.DB_PORT
}

class User {
    constructor(nickname, email, password) {
        this.nickname = nickname;
        this.email = email;
        this.password = password;
    }

    async hashPassword() {
        this.password = await bcrypt.hash(this.password, 10);
    }

    async save() {
        const connection = await mysql.createConnection(connectionConfig);

        try {
            await connection.query('INSERT INTO users (nickname, email, password) VALUES (?, ?, ?)', [
                this.nickname,
                this.email,
                this.password
            ]);
        } catch (error) {
            console.log(error)
            throw new Error('User registration failed');
        } finally {
            connection.end();
        }
    }

    async generateAuthTokens() {
        const accessToken = jwt.sign({ nickname: this.nickname}, 'secret-PortfolioUserToken-231sca', { expiresIn: "2h" });
        return accessToken;
    }

    async generateRefreshToken() {
        const refreshToken = jwt.sign({nickname: this.nickname}, 'secret-PortfolioUserToken-231sca', {expiresIn: "7d"});
        return refreshToken;
    }

    static async findById(id) {
        const connection = await mysql.createConnection(connectionConfig);
        
        try {
            const [rows] = await connection.execute('SELECT * FROM users WHERE user_id = ?', [id]);
            if (rows.length > 0) {
                const userData = rows[0];
                // return userData;
                return userData;
            }
            return null;
        } catch (error) {
            throw new Error('User not found');
        } finally {
            connection.end();
        }
    }

    static async findByNickname(nickname) {
        const connection = await mysql.createConnection(connectionConfig);

        try {
            const [rows] = await connection.execute('SELECT * FROM users WHERE nickname = ?', [nickname]);
            if (rows.length > 0) {
                const userData = rows[0];
                // return userData;
                return [new User(userData.nickname, userData.email, userData.password), userData];
            }
            return null;
        } catch (error) {
            throw new Error('User not found');
        } finally {
            connection.end();
        }
    }

    // async getUserId()
}

module.exports = User;
