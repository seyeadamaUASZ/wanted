const mongoose = require('mongoose');

const Schema = mongoose.Schema;

const Annonce = Schema({
    title:{
     type: String,
     required: true,   
    },
    created_at:{
      type:Date
    },
    description:{
        type:String,
        required:true
    },
    contact:{
        type:String,
        required:true
    },
    classee:{
      type:Boolean,
      default:false
    },
    coverImage:{
        type:String,
        default:""
    },
    username: {
        type: String,
        required: true,
      },
});

module.exports = mongoose.model('Annonce',Annonce);