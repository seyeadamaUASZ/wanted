const express = require('express');
const User = require('../models/user');
const config = require('../config');
const jwt = require('jsonwebtoken');
let middleware = require('../middleware');
const router = express.Router();
const bcrypt = require('bcrypt');

router.route("/:username").get((req, res) => {
    User.findOne({ username: req.params.username }, (err, result) => {
        if (err) return res.status(500).json({ msg: err });
        return res.json({
            data: result,
            username: req.params.username,
        })
    })
})

//login
router.route("/login").post(async(req, res) => {
        User.findOne({ username: req.body.username }, (err, result) => {
            if (err) return res.status(500).json({ msg: err });
            if (result === null) {
                return res.status(403).json("Username non valide")
            }
            const validated = bcrypt.compare(req.body.password, result.password)
            if (!validated) {
                res.status(403).json("mot de passe incorrect!!!");
            } else {
                let token = jwt.sign({ username: req.body.username }, config.key, {});
                res.json({
                    token: token,
                    msg: "succés",
                    data: req.body.username
                });
            }
        })
    })
    //register

router.route("/register").post(async(req, res) => {
    const salt = bcrypt.genSalt(10);
    //console.log("salt ",salt);
    const hashedPass = await bcrypt.hash(req.body.password, parseInt(salt));

    const user = new User({
        name: req.body.name,
        telephone: req.body.telephone,
        username: req.body.username,
        password: hashedPass,
        email: req.body.email
    });
    user
        .save()
        .then(() => {
            console.log("user registered")
            res.status(200).json({ msg: "User created succesfully" })
        })
        .catch((err) => {
            res.status(403).json({ msg: err });
        })

})


module.exports = router;