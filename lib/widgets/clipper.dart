import 'package:flutter/material.dart';

class ClippedContainer extends StatelessWidget {
  const ClippedContainer({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: MyClipper(),
      child: Container(
        alignment: Alignment.center,
        child: Text("Let's get Started!" , style: TextStyle(color: Theme.of(context).accentColor , fontSize: 28 , fontWeight: FontWeight.bold),),
        decoration: BoxDecoration(
        gradient: LinearGradient(
          tileMode: TileMode.mirror,
            begin: Alignment.topLeft,
            end: Alignment(0.8, 1),
            colors: <Color>[
             Color.fromARGB(255, 159, 115, 236),
             Color.fromARGB(255, 116, 76, 226),
             
             Color.fromARGB(255, 165, 86, 226),
             Color.fromARGB(255, 173, 53, 213),
             

            ], ),),
        //color: Colors.purpleAccent[100],
        height:MediaQuery.of(context).size.height/2-30,
        width: MediaQuery.of(context).size.width,
      ),
    );
  }
}

class MyClipper extends CustomClipper<Path>{
  @override
  Path getClip(Size size) {
    Path path =  new Path();
    path.lineTo(0, size.height);
    //var firstEndPoint = new Offset(0, size.height);
    var firstEndPoint = new Offset(size.width/2  , (size.height/2)+170);
    var firstControlPoint = new Offset(size.width/4,  size.height-60);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy, firstEndPoint.dx, firstEndPoint.dy);

  
    var secondEndPoint = new Offset(size.width +20, size.height-80);
    var secondControlPoint = new Offset(size.width *0.95,  size.height+30);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy, secondEndPoint.dx, secondEndPoint.dy);

    path.lineTo(size.width, size.height/2);
    path.lineTo(size.width, 0);
    path.close();
    return path;
    throw UnimplementedError();
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
    throw UnimplementedError();
  }
}