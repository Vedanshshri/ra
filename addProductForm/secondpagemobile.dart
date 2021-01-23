import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:image_picker/image_picker.dart';

import '../../state-city-data.dart';
import '../../staticdata.dart';

class CategoryPageAddSecond extends StatefulWidget {
  final selectedItem;
  final selectedSub;
  CategoryPageAddSecond(this.selectedItem, this.selectedSub);
  @override
  _CategoryPageAddSecondState createState() => _CategoryPageAddSecondState();
}

class _CategoryPageAddSecondState extends State<CategoryPageAddSecond> {
  String brand;
  File _image1;
  File _image2;
  File _image3;
  File _image4;
  // ignore: non_constant_identifier_names
  File _image_bill;
  Dio dio = new Dio();
  var picker = ImagePicker();
  String dop;
  var image1;
  var image2;
  var image3;
  var image4;
  // ignore: non_constant_identifier_names
  var image_of_bill;
  // ignore: non_constant_identifier_names
  var image1_status = "absent";
  // ignore: non_constant_identifier_names
  var image2_status = "absent";
  // ignore: non_constant_identifier_names
  var image3_status = "absent";
  // ignore: non_constant_identifier_names
  var image4_status = "absent";
  // ignore: non_constant_identifier_names
  var image_bill_status = "absent";

  String model;

  int selected = 0;
  final controler = PageController(
    initialPage: 1,
  );
  // ignore: non_constant_identifier_names
  _pickImageFromGallery(image, image_path, img_status) async {
    try {
      image =
          await picker.getImage(source: ImageSource.gallery, imageQuality: 50);

      setState(() {
        image_path = File(
          image.path,
        );
        img_status = "present";
      });
    } catch (e) {
      print(e.toString());
    }
  }

  // ignore: non_constant_identifier_names
  void postPic(brand, model, varient, data_of_purchage, image1, image2, image3,
      image4) async {
    Response response;
    try {
      FormData formData = FormData.fromMap({
        "description": " some Discription",
        "date_of_purchage": dop,
        "brand": brand,
        "model": model,
        "varient": selected,
        "image":
            await MultipartFile.fromFile(image1.path, filename: image1.path)
      });
      response = await dio.post(postAddApi,
          data: formData,
          options: Options(
            contentType: 'application/json',
            headers: {HttpHeaders.authorizationHeader: "Token " + token},
          ));
      print(response);
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Fill the Details"),
        ),
        //backgroundColor: Colors.lightBlue.shade500,
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: PageView(
                  controller: controler,
                  scrollDirection: Axis.horizontal,
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * 0.5,
                      width: MediaQuery.of(context).size.width,
                      //color: Colors.blueAccent,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: 30,
                          ),
                          Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            shadowColor: Colors.blue,
                            //color: Colors.lightBlue.shade200,
                            elevation: 10,
                            child: Container(
                              height: MediaQuery.of(context).size.height * 0.2,
                              width: MediaQuery.of(context).size.width,
                              child: Column(
                                children: [
                                  Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.1,
                                    child: Text(
                                      "Select the Brand",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 40,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  DropdownButtonHideUnderline(
                                    child: DropdownButton<String>(
                                      value: brand,
                                      iconEnabledColor: Colors.black,
                                      icon: Icon(Icons.arrow_downward),
                                      iconSize: 24,
                                      elevation: 16,
                                      style: TextStyle(color: Colors.black),
                                      underline: Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        height: 30,
                                        color: Colors.grey,
                                      ),
                                      onChanged: (String newValue) {
                                        setState(() {
                                          brand = newValue;
                                        });
                                      },
                                      items: brandListAll['mobile']
                                          .map<DropdownMenuItem<String>>(
                                              (String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.8,
                                              child: Text(value)),
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: 60,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: 10,
                          ),
                          Card(
                            shadowColor: Colors.blue,
                            //color: Colors.lightBlue.shade200,
                            elevation: 10,
                            child: Container(
                              height: MediaQuery.of(context).size.height * 0.2,
                              width: MediaQuery.of(context).size.width,
                              child: Column(
                                children: [
                                  Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.1,
                                    width: MediaQuery.of(context).size.width,
                                    child: Center(
                                      child: Text(
                                        "Select the Model",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 40,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                  DropdownButtonHideUnderline(
                                    child: DropdownButton<String>(
                                      value: model,
                                      iconEnabledColor: Colors.black,
                                      icon: Icon(Icons.arrow_downward),
                                      iconSize: 24,
                                      elevation: 16,
                                      style: TextStyle(color: Colors.black),
                                      underline: Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        height: 10,
                                        color: Colors.grey,
                                      ),
                                      onChanged: (String newValue) {
                                        setState(() {
                                          model = newValue;
                                        });
                                      },
                                      items: model_phones['Redmi']
                                          .map<DropdownMenuItem<String>>(
                                              (String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.8,
                                              child: Text(value)),
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 50,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: 30,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: 10,
                          ),
                          Card(
                            color: Colors.blue,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            elevation: 10,
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              child: Text(
                                "Select the Varient",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 40,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.04,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                children: [
                                  RaisedButton(
                                    color: selected == 1
                                        ? Colors.blue
                                        : Colors.transparent,
                                    onPressed: () {
                                      setState(() {
                                        selected = 1;
                                      });
                                    },
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                    ),
                                    child: Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.1,
                                      width: MediaQuery.of(context).size.width *
                                          0.4,
                                      child: Center(
                                          child: Text("1 GB RAM + 16 GB ROM")),
                                    ),
                                  ),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.04,
                                  ),
                                  RaisedButton(
                                    color: selected == 2
                                        ? Colors.blue
                                        : Colors.transparent,
                                    onPressed: () {
                                      setState(() {
                                        selected = 2;
                                      });
                                    },
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                    ),
                                    child: Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.1,
                                      width: MediaQuery.of(context).size.width *
                                          0.4,
                                      child: Center(
                                          child: Text("2 GB RAM + 16 GB ROM")),
                                    ),
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  RaisedButton(
                                    color: selected == 3
                                        ? Colors.blue
                                        : Colors.transparent,
                                    onPressed: () {
                                      setState(() {
                                        selected = 3;
                                      });
                                    },
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                    ),
                                    child: Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.1,
                                      width: MediaQuery.of(context).size.width *
                                          0.4,
                                      child: Center(
                                          child: Text("3 GB RAM + 64 GB ROM")),
                                    ),
                                  ),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.04,
                                  ),
                                  RaisedButton(
                                    color: selected == 4
                                        ? Colors.blue
                                        : Colors.transparent,
                                    onPressed: () {
                                      setState(() {
                                        selected = 4;
                                      });
                                    },
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                    ),
                                    child: Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.1,
                                      width: MediaQuery.of(context).size.width *
                                          0.4,
                                      child: Center(
                                          child: Text("4 GB RAM + 64 GB ROM")),
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                          SizedBox(
                            height: 50,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            child: Text(
                              "Date of Purchage",
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.004,
                          ),
                          Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            semanticContainer: true,
                            elevation: 10,
                            child: TextField(
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "dd-mm-yyyy",
                              ),
                              onChanged: (e) {
                                dop = e;
                              },
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.05,
                          ),
                          Column(
                            children: [
                              Text(
                                "Upload Photos of Mobile                                     ",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.02,
                              ),
                              Row(
                                children: [
                                  Stack(children: [
                                    RaisedButton(
                                      onPressed: () {
                                        _pickImageFromGallery(
                                            image1, _image1, image1_status);
                                      },
                                      child: Container(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.2,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.4,
                                        child: image1_status == "absent"
                                            ? Image.file(_image1)
                                            : Icon(Icons.add_a_photo),
                                      ),
                                    ),
                                    Visibility(
                                      visible: image1_status == "present"
                                          ? true
                                          : false,
                                      child: IconButton(
                                        onPressed: () {
                                          setState(() {
                                            image1_status = "absent";
                                          });
                                        },
                                        icon: Icon(Icons.delete),
                                      ),
                                    )
                                  ]),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.029,
                                  ),
                                  Stack(children: [
                                    RaisedButton(
                                      onPressed: () {
                                        _pickImageFromGallery(
                                            image2, _image2, image2_status);
                                      },
                                      child: Container(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.2,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.4,
                                        child: image2_status == "present"
                                            ? Image.file(_image2)
                                            : Icon(Icons.add_a_photo),
                                      ),
                                    ),
                                    Visibility(
                                      visible: image2_status == "present"
                                          ? true
                                          : false,
                                      child: IconButton(
                                        onPressed: () {
                                          setState(() {
                                            image2_status = "absent";
                                          });
                                        },
                                        icon: Icon(Icons.delete),
                                      ),
                                    )
                                  ])
                                ],
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.005,
                              ),
                              Row(
                                children: [
                                  Stack(children: [
                                    RaisedButton(
                                      onPressed: () {
                                        _pickImageFromGallery(
                                            image3, _image3, image3_status);
                                      },
                                      child: Container(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.2,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.4,
                                        child: image3_status == "present"
                                            ? Image.file(_image3)
                                            : Icon(Icons.add_a_photo),
                                      ),
                                    ),
                                    Visibility(
                                      visible: image3_status == "present"
                                          ? true
                                          : false,
                                      child: IconButton(
                                        onPressed: () {
                                          setState(() {
                                            image3_status = "absent";
                                          });
                                        },
                                        icon: Icon(Icons.delete),
                                      ),
                                    )
                                  ]),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.029,
                                  ),
                                  Stack(children: [
                                    RaisedButton(
                                      onPressed: () {
                                        _pickImageFromGallery(
                                            image4, _image4, image4_status);
                                      },
                                      child: Container(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.2,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.4,
                                        child: image4_status == "present"
                                            ? Image.file(_image4)
                                            : Icon(Icons.add_a_photo),
                                      ),
                                    ),
                                    Visibility(
                                      visible: image4_status == "present"
                                          ? true
                                          : false,
                                      child: IconButton(
                                        onPressed: () {
                                          setState(() {
                                            image4_status = "absent";
                                          });
                                        },
                                        icon: Icon(Icons.delete),
                                      ),
                                    )
                                  ])
                                ],
                              )
                            ],
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.05,
                          ),
                          Text(
                            "Upload Photo of Bill                                     ",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.02,
                          ),
                          Stack(children: [
                            RaisedButton(
                              onPressed: () {
                                _pickImageFromGallery(image_of_bill,
                                    _image_bill, image_bill_status);
                              },
                              child: Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.2,
                                width: MediaQuery.of(context).size.width * 0.4,
                                child: image_bill_status == "present"
                                    ? Image.file(_image_bill)
                                    : Icon(Icons.add_a_photo),
                              ),
                            ),
                            Visibility(
                              visible:
                                  image_bill_status == "present" ? true : false,
                              child: IconButton(
                                onPressed: () {
                                  setState(() {
                                    image_bill_status = "absent";
                                  });
                                },
                                icon: Icon(Icons.delete),
                              ),
                            )
                          ]),
                          RaisedButton(
                            color: Colors.blue,
                            onPressed: () {},
                            child: Text("Done"),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
