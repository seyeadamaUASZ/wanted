const express = require('express');
const User = require('../models/user');
const config = require('../config');
const jwt = require('jsonwebtoken');
let middleware = require('../middleware');
const router = express.Router();
const multer = require('multer');
const Annonce = require('../models/annonce');


const storage = multer.diskStorage({
    destination: (req, file, cb) => {
        cb(null, './uploads');
    },
    filename: (req, file, cb) => {
        cb(null, req.params.id + '.jpg');
    }
});

const upload = multer({
    storage: storage,
    limits: {
        fileSize: 1024 * 1024 * 6,
    },
});

router
    .route("/add/coverImage/:id")
    .patch(middleware.checkToken, upload.single('img'), (req, res) => {
        Annonce.findOneAndUpdate({ _id: req.params.id }, {
                $set: {
                    coverImage: req.file.path
                },
            }, { new: true },
            (err, result) => {
                if (err) return res.json(err);
                return res.json(result);
            }
        )
    })


//add annonce

router
    .route("/add").post(middleware.checkToken, (req, res) => {
        const annonce = Annonce({
            title: req.body.title,
            created_at: new Date().toISOString().slice(0, 10),
            description: req.body.description,
            contact: req.body.contact,
            classee: false,
            username: req.decoded.username

        });
        annonce
            .save()
            .then((result) => {
                res.json({ data: result['_id'] })
            })
            .catch((err) => {
                console.log((err), res.json({ err: err }));
            });
    });

//classer une annonce disparution

router
    .route("/classee/:id").get(middleware.checkToken, (req, res) => {
        Annonce.findOneAndUpdate({ _id: req.params.id }, {
                $set: {
                    classee: true
                },
            }, { new: true },
            (err, result) => {
                if (err) return res.json(err);
                return res.json(result);
            }
        )
    })

//annonce with userName;

router
    .route('/getOwnAnnonce').get(middleware.checkToken, (req, res) => {
        Annonce.find({ username: req.decoded.username }, (err, result) => {
            if (err) return res.json(err);
            return res.json({ status: true, data: result });
        })
    })



//all annonces

router
    .route("/").get(middleware.checkToken, async(req, res) => {
        Annonce.find()
            .then((data) => {
                //console.log("data ", data)  ;
                res.status(200).json({ status: true, data: data })
            })
            .catch((err) => {
                res.status(500).send({
                    message: err.message || "Some error occurred while retrieving messages.",
                });
            });

    })


module.exports = router;