import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
 
class ClockView extends StatefulWidget {
  const ClockView({ Key? key }) : super(key: key);

  @override
  _ClockViewState createState() => _ClockViewState();
}

class _ClockViewState extends State<ClockView> {
  @override void initState(){
    Timer.periodic(Duration(seconds:1),(timer){
         setState( () {
       
    
        });
    });

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
       width:300,
       height:300,
       child:Transform.rotate(
           angle:-pi/2,
            child: CustomPaint(
           painter:ClockPainter(),
         ),
       ),
    );
  }
}


class ClockPainter extends CustomPainter
{
  var dateTime=DateTime.now();

  @override
  void paint(Canvas canvas, Size size) 
  {
      // TODO: implement paint
      var centerX=size.width/2;
      var centerY=size.height/2;
      var center =Offset(centerX,centerY);
      var radius= min(centerX,centerY);

      var fillBrush=Paint()
      ..color = Color(0xFF444974);

      var outlineBrush=Paint()
      ..color = Color(0xFFEACEFF)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 16;

      var centerFillBrush=Paint()
      ..color = Color(0xFFEACEFF);

       var secHandBrush=Paint()
      ..color = Colors.orange.shade300
      ..style = PaintingStyle.stroke
      ..strokeCap=StrokeCap.round
      ..strokeWidth = 8;

       var minHandBrush=Paint()
      ..shader=RadialGradient(colors:[Colors.lightBlue,Colors.pink]).createShader(Rect.fromCircle(center:center,radius:radius))
      ..style = PaintingStyle.stroke
      ..strokeCap=StrokeCap.round
      ..strokeWidth = 16;

       var hourHandBrush=Paint()
       ..shader=RadialGradient(colors:[Color(0xFFEA74AB),Color(0xFFC279FB)]).createShader(Rect.fromCircle(center:center,radius:radius))
       ..style = PaintingStyle.stroke
       ..strokeCap=StrokeCap.round
       ..strokeWidth = 16;

        var dashBrush = Paint()
        ..color = Color(0xFFEAECFF)
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round
        ..strokeWidth = 1;

      canvas.drawCircle(center,radius-40,fillBrush);
      canvas.drawCircle(center,radius-40,outlineBrush);

      var secHandX=centerX+80*cos(dateTime.second*6*pi/180);
      var secHandy=centerX+80*sin(dateTime.second*6*pi/180);

      canvas.drawLine(center,Offset(secHandX,secHandy),secHandBrush);

      var minHandX=centerX+80*cos(dateTime.minute*6*pi/180);
      var minHandy=centerX+80*sin(dateTime.minute*6*pi/180);


      canvas.drawLine(center,Offset(minHandX,minHandy),minHandBrush);


      var hourHandX=centerX+60*cos(dateTime.hour*30*pi/180);
      var hourHandy=centerX+60*sin(dateTime.hour*30*pi/180);


      canvas.drawLine(center,Offset(hourHandX,hourHandy),hourHandBrush);

      canvas.drawCircle(center,16,centerFillBrush);

      var outerCircleRadius = radius;
      var innerCircleRadius = radius - 14;
      for (double i = 0; i < 360; i += 30) 
      {
        var x1 = centerX + outerCircleRadius * cos(i * pi / 180);
        var y1 = centerX + outerCircleRadius * sin(i * pi / 180);

        var x2 = centerX + innerCircleRadius * cos(i * pi / 180);
        var y2 = centerX + innerCircleRadius * sin(i * pi / 180);
        canvas.drawLine(Offset(x1, y1), Offset(x2, y2), dashBrush);
      }
    
   }
  
    @override
    bool shouldRepaint(covariant CustomPainter oldDelegate) {
     return true;
  }
      

}  