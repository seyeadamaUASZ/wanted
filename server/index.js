const express = require("express");

const mongoose = require("mongoose");

const cors = require("cors");

const port = process.env.PORT || 3000;
const app = express();

app.use(cors());


mongoose.connect(
    "mongodb://localhost:27017/wanted", {
        useNewUrlParser: true,
        useCreateIndex: true,
        useUnifiedTopology: true,
    }
);

const connection = mongoose.connection;
connection.once("open", () => {
    console.log("MongoDb connected");
});

//middleware

app.use("/uploads", express.static("uploads"));
app.use(express.json());
const userRoute = require('./routes/user');
app.use('/user', userRoute);
const annonceRoute = require('./routes/annonce');
app.use('/annonce', annonceRoute);

const fileannonceRoute = require('./routes/fileannonce');
app.use('/fileannonce', fileannonceRoute);

data = {
    msg: "Bienvenue dans l'app wanted web service",
    info: "coeur endpoint",
    Working: "documentations bientot disponibles",
    request: "developpement incremental",
};

app.route("/").get((req, res) => res.json(data));

app.listen(port, "0.0.0.0", () =>
    //console.log('today ' + new Date().toISOString().slice(0, 10)),
    console.log(`welcome your listinnig at port ${port}`)
);