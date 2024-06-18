const express = require('express');
const User = require("../models/user")
const bcrypt = require("bcryptjs");
const jwt = require("jsonwebtoken");
const router = express.Router();

router.use('/registration', async (req, res) => {
    const { nickname, email, password } = req.body;

    try {
        // Проверка, что пользователь с таким email не существует
        const existingUser = await User.findByNickname(nickname);
        if (existingUser) {
            return res.status(400).render("information-body", {
                layout: "information",
                title: "ошибка",
                pageTitle: "Ошибка!",
                haveMessage: true,
                message: "Пользователь с таким никнеймом уже существует!",
                link: "/registration",
                linkMessage: "Назад",
                isAuth: Boolean(req.cookies.authToken)

            })
        }

        const user = new User(nickname, email, password);
        await user.hashPassword();
        await user.save();

        const token = await user.generateAuthToken();
        const refreshToken = await user.generateRefreshToken();
        res.status(201).json({ token });
    } catch (error) {
        console.error('Error registering user:', error);
        return res.status(500).render("information-body", {
            layout: "information",
            title: "ошибка",
            pageTitle: "Ошибка!",
            haveMessage: true,
            message: "Ошибка регистрации, попробуйте еще раз.",
            link: "/registration",
            linkMessage: "Назад",
            isAuth: Boolean(req.cookies.authToken)
        })
    }

    
});

router.use('/login', async (req, res) => {
    const { nickname, password } = req.body;

    try {
        const userArr = await User.findByNickname(nickname);
        const user = userArr[0];
        if (!user) {
            return res.status(500).render("information-body", {
                layout: "information",
                title: "ошибка",
                pageTitle: "Ошибка!",
                haveMessage: true,
                message: "Пользователь не найден. Попробуйте еще раз!",
                link: "/login",
                linkMessage: "Назад",
                isAuth: Boolean(req.cookies.authToken)
            })
        }

        const isMatch = await bcrypt.compare(password, user.password);
        if (!isMatch) {
            return res.status(401).render("information-body", {
                layout: "information",
                title: "ошибка",
                pageTitle: "Ошибка!",
                haveMessage: true,
                message: "Неверный пароль! Попробуйте еще раз.",
                link: "/login",
                linkMessage: "Назад",
                isAuth: Boolean(req.cookies.authToken)

            })
        }

        let accessToken = await user.generateAuthTokens();
        const refreshToken = await user.generateRefreshToken()

        res.cookie('authToken', accessToken, {httpOnly: true});
        res.cookie('refreshToken', refreshToken, {httpOnly: true});

        
        return res.status(200).render("information-body", {
            layout: "information",
            title: "Авторизация",
            pageTitle: "Успешная авторизация",
            haveMessage: true,
            message: "Вы успешно авторизовались!",
            link: `/profile/${nickname}`,
            linkMessage: "Профиль",
            isAuth: Boolean(req.cookies.authToken)
        })
    } catch (error) {
        console.error('Error authenticating user:', error);
        return res.status(500).render("information-body", {
            layout: "information",
            title: "ошибка",
            pageTitle: "Ошибка!",
            haveMessage: true,
            message: "Ошибка авторизации, попробуйте еще раз.",
            link: "/login",
            linkMessage: "Назад",
            isAuth: Boolean(req.cookies.authToken)

        })
    }
});

router.post("/logout", (req,res) => {
    res.clearCookie("authToken");
    res.clearCookie("refreshToken");
    return res.status(200).render("information-body", {
        layout: "information",
        title: "Выход",
        pageTitle: "Вы вышли из аккаунта!",
        haveMessage: false,
        message: "",
        link: "/",
        linkMessage: "На главную",
        isAuth: Boolean(req.cookies.authToken)
    })
})

router.post("/refresh-token", async (req,res) => {
    const refreshToken = req.cookies.refreshToken;
    if (!refreshToken) {
        return res.status(401).render("information-body", {
            layout: "information",
            title: "Доступ запрещен",
            pageTitle: "Войдите в аккаунт, либо зарегестрируйтесь!",
            haveMessage: false,
            message: "",
            link: "/login",
            linkMessage: "Авторизация",
            isAuth: Boolean(req.cookies.authToken)
        })
    } 

    try {
        const verified = jwt.verify(refreshToken, "secret-PortfolioUserToken-231sca");
        const userArr = await User.findByNickname(verified.nickname);
        const user = userArr[0];
        if (!user || user.refreshToken !== refreshToken) {
            return res.status(401).render("information-body", {
                layout: "information",
                title: "Доступ запрещен",
                pageTitle: "Войдите в аккаунт, либо зарегестрируйтесь!",
                haveMessage: false,
                message: "",
                link: "/login",
                linkMessage: "Авторизация",
                isAuth: Boolean(req.cookies.authToken)
            })
        }
        const accessToken = jwt.sign({nickname: user.nickname}, "secret-PortfolioUserToken-231sca", {expiresIn: "2h"});
        res.cookie("authToken", accessToken, {httpOnly: true});
        return res.sendStatus(200);
    } catch( err) {
        console.log(err);
        return res.status(401).render("information-body", {
            layout: "information",
            title: "Доступ запрещен",
            pageTitle: "Войдите в аккаунт, либо зарегестрируйтесь!",
            haveMessage: false,
            message: "",
            link: "/login",
            linkMessage: "Авторизация",
            isAuth: Boolean(req.cookies.authToken)
        })
    }

})

module.exports = router;