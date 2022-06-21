const mongoose = require('mongoose');

const Schema = mongoose.Schema;

const FileAnnonce = Schema({
   annonceId:{
       type:String,
       required:true
   },
   url:{
       type:String,
       default:""
   }
});

module.exports = mongoose.model('FileAnnonce',FileAnnonce);