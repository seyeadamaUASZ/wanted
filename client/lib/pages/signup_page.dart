import 'package:client/pages/login_page.dart';
import 'package:client/services/networkhandler.dart';
import 'package:flutter/material.dart';

class SignupPage extends StatefulWidget {
  SignupPage({Key? key}) : super(key: key);

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  bool vis=true;
  final _globalkey=GlobalKey();
  NetWorkHandler netWorkHandler=NetWorkHandler();
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _telephoneController = TextEditingController();

  String? errorText;
  bool validate=false;
  bool circular = false;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(  
      body:Container(   
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(  
          // image:DecorationImage(
          // image: AssetImage("assets/wanted.jpg"),
          // fit: BoxFit.cover,
          // ) ,
          gradient: LinearGradient(  
            colors: [Colors.white,Colors.blue],
            begin: const FractionalOffset(0.0, 1.0),
            end: const FractionalOffset(0.0, 1.0),
            stops: [0.0,1.0],
            tileMode: TileMode.repeated
          )
        ),
        child: Form(
          key:_globalkey,
          child: Column(  
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Inscrire sur Wanted",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                letterSpacing: 2,
              )),
              const SizedBox(height: 25,),
              NameTextField1(),
              const SizedBox(height: 25,),
              TelephoneTextField1(),
              const SizedBox(height: 25,),
              UserNameTextField1(),
              const SizedBox(height: 25,),
              EmailTextField1(),
              const SizedBox(height: 25,),
              PasswordTextField1(),
              const SizedBox(height: 25,),
            
              InkWell(
                onTap:()async{
                  setState(() {
                    circular=true;
                  });
                  await checkUser();
                  if (validate){
                    Map<String,String> data={ 
                      "name": _nameController.text,
                      "telephone" : _telephoneController.text,
                      "username":_usernameController.text,
                      "email":_emailController.text,
                      "password":_passwordController.text
                    };
                    print(data);
                    await netWorkHandler.post("user/register", data);
                    setState(() {
                      circular=false;
                      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>LoginPage()), (route) => false);
                    });
                    
                  }else{
                    setState(() {
                      circular=false;
                    });
                  }    
                },
                child:circular ? const CircularProgressIndicator() 
                 :Container(  
                  width: 350,
                  height: 45,
                  decoration: BoxDecoration(  
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.blue
                  ),
                  child: const Center(  
                    // ignore: unnecessary_const
                    child:const Text("S'inscrire",style:TextStyle(   
                      color:  Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600
                    )),
                  ),
                ),
              ),
              SizedBox(height: 20,),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                 children:[
                  const Text("Déjà un compte ? ",style: TextStyle(
                  color: Colors.black,
                  fontSize: 17,
                ),),     
                SizedBox(width: 10,),
                InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>
                     LoginPage()
                    ));
                  },
                  child: const Text("Se connecter",style: TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.bold
                  ),),
                ),
                 ]
                
                ),
            ],
          ),
        ),
      )
    );
  }


checkUser()async {
    if(_usernameController.text.length==0){
      setState(() {
        circular=false;
        validate=false;
        errorText="Username can't be empty!!!";
      });
    }else{
      var response = await netWorkHandler.get("user/${_usernameController.text}");
       if(response['data']!=null){
          setState(() {
        //circular=false;
        validate=false;
        errorText="Username already taken!!!";
      });
       }else{
          setState(() {
        //circular=false;
         validate=true;
        //errorText="Username already taken!!!";
      });
       }
    }
  }

  // Widget usernameTextField(){
  //   return Padding(
  //     padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 5.0),
  //     child: Column(children: [
  //       const Text("username..."),
  //       TextFormField(
  //         controller: _usernameController,
           
  //         decoration: InputDecoration(   
  //           errorText: validate?null: errorText ,
  //          focusedBorder:const UnderlineInputBorder (
  //            borderSide: BorderSide(color: Colors.white,width: 2),

  //          )  
  //         ),
  //       )
  //     ],),
  //   );
  // }


  // Widget NameTextField(){
  //   return Padding(
  //     padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 5.0),
  //     child: Column(children: [
  //       const Text("Nom complet"),
  //       TextFormField(
  //         controller: _nameController,
           
  //         decoration: InputDecoration(   
  //           errorText: validate?null: errorText ,
  //          focusedBorder:const UnderlineInputBorder (
  //            borderSide: BorderSide(color: Colors.white,width: 2),

  //          )  
  //         ),
  //       )
  //     ],),
  //   );
  // }

  
  // Widget TelephoneTextField(){
  //   return Padding(
  //     padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 10.0),
  //     child: Column(children: [
  //       const Text("Numéro téléphone"),
  //       TextFormField(
  //         controller: _telephoneController,
           
  //         decoration: InputDecoration(   
  //           errorText: validate?null: errorText ,
  //          focusedBorder:const UnderlineInputBorder (
  //            borderSide: BorderSide(color: Colors.white,width: 2),

  //          )  
  //         ),
  //       )
  //     ],),
  //   );
  // }

  // Widget emailTextField(){
  //   return Padding(
  //     padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 10.0),
  //     child: Column(children: [
  //       const Text("email..."),
  //       TextFormField( 
  //         controller: _emailController,
  //         validator: (value){
  //           if(value!.isEmpty) return "email can't be empty";
  //           if(!value.contains("@"))return "Email is invalid";
  //           return null;
  //         },
  //         decoration:const InputDecoration(   
            
  //          focusedBorder: UnderlineInputBorder(  
  //            borderSide: BorderSide(color: Colors.white,width: 2),

  //          )  
  //         ),
  //       )
  //     ],),
  //   );
  // }


  // Widget passwordTextField(){
  //   return Padding(
  //     padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 10.0),
  //     child: Column(children: [
  //       const Text("password..."),
  //       TextFormField( 
  //         controller: _passwordController,
  //         validator: (value){
  //           if(value!.isEmpty) return "password can't be empty";
  //           if(value.length <=8) return "password lenght should have 8";
  //           return null;
  //         },
  //         obscureText: vis,
  //         decoration: InputDecoration(
  //           suffixIcon: IconButton(  
  //             icon: Icon(vis ? Icons.visibility_off:Icons.visibility),
  //             onPressed: (){
  //               setState(() {
  //                 vis = !vis;
  //               });
  //             },
  //           ),  
            
  //           helperText: "password length should have >=8", 
  //           helperStyle: const TextStyle(   
  //             fontSize: 16
  //           ),
  //          focusedBorder:const UnderlineInputBorder(  
  //            borderSide: BorderSide(color: Colors.white,width: 2,),

  //          )  
  //         ),
  //       )
  //     ],),
  //   );
  // }





  Widget UserNameTextField1(){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 40),
      height: 45,
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 2,
              blurRadius: 4,
              offset: Offset(0, 2),
            )
          ],
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: TextField(
        controller: _usernameController,
        style: TextStyle(color: Colors.black),
        decoration: InputDecoration(
          icon: Padding(
            padding: EdgeInsets.only(left: 10),
            child: Icon(
              Icons.person ,
              color: Colors.black
            ),
          ),
          contentPadding:
              EdgeInsets.only(left: 0, right: 20, top: 10, bottom: 10),
          border: InputBorder.none,
          hintText: "nom utilisateur",
          hintStyle: TextStyle(color: Colors.black54),
        ),
      ),
    );
  }

  Widget TelephoneTextField1(){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 40),
      height: 45,
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 2,
              blurRadius: 4,
              offset: Offset(0, 2),
            )
          ],
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: TextField(
        controller: _telephoneController,
        style: TextStyle(color: Colors.black),
        decoration: InputDecoration(
          icon: Padding(
            padding: EdgeInsets.only(left: 10),
            child: Icon(
              Icons.phone ,
              color: Colors.black
            ),
          ),
          contentPadding:
              EdgeInsets.only(left: 0, right: 20, top: 10, bottom: 10),
          border: InputBorder.none,
          hintText: "numéro téléphone",
          hintStyle: TextStyle(color: Colors.black54),
        ),
      ),
    );
  }


  Widget EmailTextField1(){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 40),
      height: 45,
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 2,
              blurRadius: 4,
              offset: Offset(0, 2),
            )
          ],
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: TextField(
        controller: _emailController,
        style: TextStyle(color: Colors.black),
        decoration: InputDecoration(
          icon: Padding(
            padding: EdgeInsets.only(left: 10),
            child: Icon(
              Icons.email ,
              color: Colors.black
            ),
          ),
          contentPadding:
              EdgeInsets.only(left: 0, right: 20, top: 10, bottom: 10),
          border: InputBorder.none,
          hintText: "Votre email",
          hintStyle: TextStyle(color: Colors.black54),
        ),
      ),
    );
  }


  Widget PasswordTextField1(){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 40),
      height: 45,
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 2,
              blurRadius: 4,
              offset: Offset(0, 2),
            )
          ],
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: TextField(
        controller: _passwordController,
        obscureText: true,
        style: TextStyle(color: Colors.black),
        decoration: InputDecoration(
          icon: Padding(
            padding: EdgeInsets.only(left: 10),
            child: Icon(
              Icons.lock ,
              color: Colors.black
            ),
          ),
          contentPadding:
              EdgeInsets.only(left: 0, right: 20, top: 10, bottom: 10),
          border: InputBorder.none,
          hintText: "Mot de passe",
          hintStyle: TextStyle(color: Colors.black54),
        ),
      ),
    );
  }

  Widget NameTextField1(){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 40),
      height: 45,
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 2,
              blurRadius: 4,
              offset: Offset(0, 2),
            )
          ],
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: TextField(
        controller: _nameController,
        style: TextStyle(color: Colors.black),
        decoration: InputDecoration(
          icon: Padding(
            padding: EdgeInsets.only(left: 10),
            child: Icon(
              Icons.person ,
              color: Colors.black
            ),
          ),
          contentPadding:
              EdgeInsets.only(left: 0, right: 20, top: 10, bottom: 10),
          border: InputBorder.none,
          hintText: "votre nom",
          hintStyle: TextStyle(color: Colors.black54),
        ),
      ),
    );
  }

}