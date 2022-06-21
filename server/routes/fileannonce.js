const express = require('express');
const User = require('../models/user');
const config = require('../config');
const jwt = require('jsonwebtoken');
let middleware = require('../middleware');
const router = express.Router();
const multer = require('multer');

const FileAnnonce = require('../models/fileannonce');
const Annonce = require('../models/annonce');

const storage = multer.diskStorage({
    destination:(req,file,cb)=>{
     cb(null,'./uploads');
    },
    filename:(req,file,cb)=>{
        cb(null,Date.now()+'--'+file.originalname);
    }
});

const upload = multer({
    storage:storage,
    limits:{
        fileSize: 1024 * 1024 * 6,
    },
});


router 
 .route('/add/:id').post(middleware.checkToken,upload.single('file'), (req,res)=>{
   Annonce.findById(
      {_id :req.params.id}
  ).then((annonce)=>{
      const fileannonce = FileAnnonce({
          annonceId : annonce._id,
          url: req.file.path
      });
      fileannonce
      .save()
       .then((result)=>{
           res.json({data:result['_id']})
       })
       .catch((err)=>{
        console.log((err),res.json({err:err}));
       })
  })
   .catch((err)=>{
    console.log((err),res.json({err:err}));
   })
  
 })

 module.exports = router;
