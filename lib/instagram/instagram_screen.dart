
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:firebase_signinauth/instagram/heartAnimationWidget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
class instagram extends StatefulWidget {
  const instagram({super.key});

  @override
  State<instagram> createState() => _instagramState();
}

class _instagramState extends State<instagram> {
  String selectedImagePath = '';
  bool isheartanimation=false;
   bool isliked=false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leadingWidth: 260,
        leading:Row(
          mainAxisSize: MainAxisSize.max,
       // crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(width: 20,),
   Center(child: Text("Instagram",style: GoogleFonts.italianno(fontSize: 48,color: Colors.black,fontWeight: FontWeight.w900))),
    // Expanded(child: IconButton(
    //           onPressed: () {},
    //           icon: Icon(Icons.a,color: Colors.black,),
    //         ),),
  ],),
  actions: <Widget>[
    Padding(
      padding: EdgeInsets.only(right: 20.0),
      child: GestureDetector(
        onTap: () {},
        child: IconButton(
          icon: Icon(
            Icons.favorite_border_outlined,color: Colors.black,
            size: 26.0,
          ),
          onPressed:(){buildAction(); }
        ),
      )
    ),
    Padding(
      padding: EdgeInsets.only(right: 20.0),
      child: GestureDetector(
        onTap: () {},
        child: IconButton(
          icon: Icon(
              Icons.my_library_add_rounded,color: Colors.black,
          ),
          onPressed: (){selectImages();},
        ),
      )
    ),
  ],
),
      
      body: Stack(
        children: [
          ListView.separated(
            padding:EdgeInsets.all(12),
            itemCount:20,
            separatorBuilder:(context ,index){
              return const SizedBox(height:50);
            },
            itemBuilder:(context ,index){
              return buildcard(index);
            }

          ),
        ],
      ),
   floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
  floatingActionButton: FloatingActionButton(
    backgroundColor: Colors.blue,
        child: Icon(Icons.camera_alt_outlined),
              onPressed: () {
              selectImage();

          setState(() {
          });
        },
      ),
    );
  }

  Widget buildcard(int index)=>GestureDetector(
 //borderRadius: BorderRadius.circular(10),
 child: Stack(
  alignment: Alignment.center,
  children:[
  
    Column(
         children: [
       Container(
           color:Colors.red,
           child:AspectRatio(aspectRatio: 1,
           child:Image.network("https://images.pexels.com/photos/2899097/pexels-photo-2899097.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
           width:double.infinity,
           height:200,
          fit: BoxFit.cover
           
           ),
       ),
       ),
       SizedBox(height: 50,),
       Container(
        color: Colors.red,
         child: selectedImagePath == ''
                    ? Image.network("https://images.pexels.com/photos/2899097/pexels-photo-2899097.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
             height: 200, width: double.infinity, fit: BoxFit.cover,)
                    : Image.file(File(selectedImagePath), height: 200, width: 200, fit: BoxFit.fill,),
       ),
     ],
   ),
  Opacity(
    opacity:isheartanimation?1:0 ,
    child: HeartAnimationWidget(
      isAnimating:isheartanimation,
      duration: Duration(milliseconds: 500),
      child: Icon(Icons.favorite ,color: Colors.white,size: 100,),
      onEnd:()=>setState(() {
        isheartanimation=false;
      })
      ),
  ),
  buildAction()
 ]),
 onDoubleTap: () {
   setState(() {
     isheartanimation=true;
     isliked=true;
   });
 },
 );
  Future selectImage() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)), //this right here
            child: Container(
              height: 150,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    Text(
                      'Select Image ',
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.bold),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          onTap: () async {
                            selectedImagePath = await selectImageFromGallery();
                            print('Image_Path:-');
                            print(selectedImagePath);
                            if (selectedImagePath != '') {
                              Navigator.pop(context);
                              setState(() {});
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text("No Image Selected !"),
                              ));
                            }
                          },
                          child: Card(
                              elevation: 5,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Image.asset(
                                      'assets/images/galleryimage.png',
                                      height: 60,
                                      width: 60,
                                    ),
                                    Text('Gallery'),
                                  ],
                                ),
                              )),
                        ),
                        GestureDetector(
                          onTap: () async {
                            selectedImagePath = await selectImageFromCamera();
                            print('Image_Path:-');
                            print(selectedImagePath);

                            if (selectedImagePath != '') {
                              Navigator.pop(context);
                              setState(() {});
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text("No Image Captured !"),
                              ));
                            }
                          },
                          child: Card(
                              elevation: 5,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Image.asset(
                                      'assets/images/camera.png',
                                      height: 60,
                                      width: 60,
                                    ),
                                    Text('Camera'),
                                  ],
                                ),
                              )),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }

  selectImageFromGallery() async {
    XFile? file = await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 10);
    if (file != null) {
      return file.path;
    } else {
      return '';
    }
  }

  //
  selectImageFromCamera() async {
    XFile? file = await ImagePicker()
        .pickImage(source: ImageSource.camera, imageQuality: 10);
    if (file != null) {
      return file.path;
    } else {
      return '';
    }
  }
  Widget buildAction(){
    final icon=isliked?Icons.favorite:Icons.favorite_outline;
    final color=isliked?Colors.red:Colors.white;
    return Container(
      
      padding: EdgeInsets.all(4),
      child:Row(children: [
 
 HeartAnimationWidget(
  alwaysAnimate:true,
  isAnimating: isliked,
   child:IconButton(
   icon:Icon(icon,color:color,size:20) ,
   onPressed: ()=>setState(()=>isliked=!isliked )
 ),
 ),

])
      ,);
  }
   Future selectImages() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)), //this right here
            child: Container(
              height: 150,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    Text(
                      'Select Image ',
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.bold),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          onTap: () async {
                            selectedImagePath = await selectImageFromGallery();
                            print('Image_Path:-');
                            print(selectedImagePath);
                            if (selectedImagePath != '') {
                              Navigator.pop(context);
                              setState(() {});
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text("No Image Selected !"),
                              ));
                            }
                          },
                          child: Card(
                              elevation: 5,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Image.asset(
                                      'assets/images/galleryimage.png',
                                      height: 60,
                                      width: 60,
                                    ),
                                    Text('Gallery'),
                                  ],
                                ),
                              )),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }

}
 
  
  
  