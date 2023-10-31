import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:swani/services/Task_Provider.dart';
import 'package:swani/views/DetailsTask.dart';
import 'package:table_calendar/table_calendar.dart';

import '../models/Task.dart';
import '../widgets/EventCol.dart';
import '../widgets/Menu.dart';
import '../widgets/complexEven.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => HomePage_State();
}

class HomePage_State extends State<HomePage> {


  @override
  void initState() {
    // TODO: implement initState

    super.initState();

    task_provider.getTasks();

  }
  TextEditingController textEditingController_title = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  TextEditingController textEditingController_subtitle =
      TextEditingController();
  TextEditingController dateInitTaskinput = TextEditingController();
  TextEditingController dateFinTaskinput = TextEditingController();
  TextEditingController textEditingController_description =
      TextEditingController();
  Provider task_provider = new Provider();
  @override
  Widget build(BuildContext context) {
    final _tasks=    task_provider.getTasks();
    return Scaffold(
        appBar: AppBar(),
        drawer: Menu(),
        body: ListView(
          children: [
            SizedBox(height: 8,),
            _taskList(),
            SizedBox(
              height: 50,
            ),
            _taskList2()
          ],
        ),
        floatingActionButton: FloatingActionButton.extended(
          hoverColor: Color.fromARGB(255, 78, 126, 50),
          heroTag: 'uniqueTag',
          onPressed: addNewTack,
          label: Row(
            children: [Icon(Icons.add), Text('New')],
          ),
        ));
  }

  _taskList() {
    final _tasks=    task_provider.getTasks();

    return Container(

      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(25),bottomRight: Radius.circular(25)),
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            Color.fromARGB(255, 113, 154, 187),
            Color.fromARGB(255, 137, 184, 52),
          ],
        ),
      ),
      width: double.infinity,
      height: 500,
      child: FutureBuilder(
        future:_tasks,
        builder: (BuildContext context, AsyncSnapshot<List<Task>> snapshot) {
          if (snapshot.hasData) {
            return tasks(snapshot.data);
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  _taskList2() {
    final _tasks=    task_provider.getTasks();
    return Container(
      width: double.infinity,
      color: Color.fromARGB(45, 51, 51, 50),
      height: 300,
      child: FutureBuilder(
        future:_tasks,
        builder: (BuildContext context, AsyncSnapshot<List<Task>> snapshot) {
          if (snapshot.hasData) {
            return _CategoryTask(snapshot.data);
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  FocusNode focusNode = FocusNode();

  tasks(List<Task> data) {
    final _tasks=    data;
    return ListView.builder(
      itemCount: _tasks.length,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(29)),
        ),
          width: double.infinity,
          child: Card(
           // clipBehavior: Clip.none,

            color: Colors.transparent,
            elevation: 2,
            child: ListTile(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailsTask(task: data[index]),
                    ),
                  );
                },
                title: Container(
                  width: double.infinity,
                  child:Row(children: [

                    Expanded(
                      flex: 1,
                      child: Text(
                        _tasks[index].title,
                        style: TextStyle(fontSize: 18, color: Colors.white38),
                      ),)
                  ],)
                ),
                trailing: IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () {
                      _tasks.remove(data[index]);
                    }),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text("Subtitle :"),
                    Expanded(

                      flex: 1,
                      child:Text(data[index].subtitle,
                            style:
                            TextStyle(fontSize: 11, color: Colors.white)),
                    ) ],
                    ),
                    Row(
                      children: [
                        Text("Description :"),
                        Expanded(


                          flex: 1,
                          child:Text(

                            data[index].description,
                            style:
                            TextStyle(fontSize: 11, color: Colors.white)),
                        ) ],
                    ),




                    Row(
                      children: [
                        Text("Date init Task :"),
                       Expanded(
                         flex: 1,
                         child: Text(
                         data[index].start_date.toString(),
                         style: TextStyle(
                             color: Color.fromARGB(255, 5, 165, 240)),
                       ),)
                      ]
                    ),
                    Row(
                      children: [
                        Text("Date fin Task :"),
                     Expanded(
                       flex: 1,
                       child:  Text(
                       data[index].end_date.toString(),
                       style: TextStyle(
                           color: Color.fromARGB(255, 5, 165, 240)),
                     ), )
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        IconButton(
                            onPressed: () {
                              _deleteFormDialog(context, data[index].id);
                            },
                            icon: Icon(Icons.remove))
                      ],
                    )
                  ],
                )),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    // TODO: Dont forget to dispose
    focusNode.dispose();

    super.dispose();
  }

  _CategoryTask(List<Task> data) {
    return  ListView.builder(
          itemCount: data.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 9,vertical: 12),
                color: Colors.cyanAccent,
                width: 150,
                height: 200,
                child: Card(
                  color: Color.fromARGB(20, 46, 45, 45),
                  elevation: 8,
                  child:Column(
                    children: [
                      Text(data[index].title),
                      Row(children: [
                        Text(data[index].subtitle)
                      ],)
                    ],


                  ),

            ),
              ));
          },
        );
  }

  DateTime selectedDayI = new DateTime(12);
  DateTime selectedDayF = new DateTime(12);
  void addNewTack() {
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            content: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Container(
                  width: 600,
                  child: Column(
                    children: [
                      Text(
                        "Add new Task",
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      Container(
                        margin: EdgeInsets.all(15),
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 255, 255, 255),
                          border: Border.all(),
                        ),
                        child: TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter some Title';
                            }
                            return null;
                          },
                          controller: textEditingController_title,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            labelText: "Title",
                            suffixIconColor: Colors.green,
                            suffixIcon: Icon(Icons.task),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(15),
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 255, 255, 255),
                          border: Border.all(),
                        ),
                        child: TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter some Subtitle';
                            }
                            return null;
                          },
                          controller: textEditingController_subtitle,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            labelText: "Subtitle",
                            suffixIconColor: Colors.green,
                            suffixIcon: Icon(Icons.task),
                          ),
                        ),
                      ),
                      Container(
                        height: 150,
                        margin: EdgeInsets.all(15),
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 255, 255, 255),
                          border: Border.all(),
                        ),
                        child: TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter some Description';
                            }
                            return null;
                          },
                          focusNode: focusNode,
                          controller: textEditingController_description,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            labelText: "Description",
                            suffixIconColor: Colors.green,
                            suffixIcon: Icon(Icons.task),
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Container(
                            width: 169,
                            height: 40,
                            margin: EdgeInsets.all(15),
                            padding: EdgeInsets.symmetric(horizontal: 8),
                            decoration: BoxDecoration(
                              color: Color.fromARGB(255, 255, 255, 255),
                              border: Border.all(),
                            ),
                            child: TextFormField(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter some Date';
                                }
                                return null;
                              },
                              controller:
                                  dateInitTaskinput, //editing controller of this TextField
                              decoration: InputDecoration(
                                  icon: Icon(Icons
                                      .calendar_today), //icon of text field
                                  labelText:
                                      "Enter Date init Task" //label text of field
                                  ),
                              readOnly:
                                  true, //set it true, so that user will not able to edit text
                              onTap: () async {
                                DateTime pickedDate = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(
                                        2000), //DateTime.now() - not to allow to choose before today.
                                    lastDate: DateTime(2101));

                                if (pickedDate != null) {
                                  print(
                                      pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                                  String formattedDate =
                                      DateFormat('yyyy-MM-dd')
                                          .format(pickedDate);
                                  print(
                                      formattedDate); //formatted date output using intl package =>  2021-03-16
                                  //you can implement different kind of Date Format here according to your requirement

                                  setState(() {
                                    dateInitTaskinput.text = formattedDate;

                                    // dateController= dateinput.text;
                                    //set output date to TextField value.
                                  });
                                } else {
                                  print("Date is not selected");
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                      Container(
                        width: 169,
                        height: 40,
                        margin: EdgeInsets.all(15),
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 255, 255, 255),
                          border: Border.all(),
                        ),
                        child: TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter some Fin date';
                            }
                            return null;
                          },
                          controller:
                              dateFinTaskinput, //editing controller of this TextField
                          decoration: InputDecoration(
                              icon: Icon(
                                  Icons.calendar_today), //icon of text field
                              labelText:
                                  "Enter Date fin task " //label text of field
                              ),
                          readOnly:
                              true, //set it true, so that user will not able to edit text
                          onTap: () async {
                            DateTime pickedDateF = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(
                                    2000), //DateTime.now() - not to allow to choose before today.
                                lastDate: DateTime(2101));
                            if (pickedDateF != null) {
                              print(
                                  pickedDateF); //pickedDate output format => 2021-03-10 00:00:00.000

                              String formattedDateF =
                                  DateFormat('yyyy-MM-dd').format(pickedDateF);
                              print(
                                  formattedDateF); //formatted date output using intl package =>  2021-03-16
                              //you can implement different kind of Date Format here according to your requirement

                              setState(() {
                                dateFinTaskinput.text = formattedDateF;
                                // dateController= dateinput.text;
                                //set output date to TextField value.
                              });
                            } else {
                              print("Date is not selected");
                            }
                          },
                        ),
                      ),
                      SizedBox(
                        height: 45,
                      ),
                      FloatingActionButton(
                          splashColor: Colors.purple,
                          child: Text("save"),
                          onPressed: () {
                            if (_formKey.currentState.validate()) {
                              // If the form is valid, display a snackbar. In the real world,
                              // you'd often call a server or save the information in a database.
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    duration: Duration(seconds: 8),
                                    content: Container(
                                        height: 80,
                                        child: Center(
                                          child: Column(
                                            children: [
                                              Text(" processing data"),
                                              CircularProgressIndicator()
                                            ],
                                          ),
                                        ))),
                              );

                              task_provider.createTask(
                                  textEditingController_title.value.text,
                                  textEditingController_subtitle.text,
                                  textEditingController_description.text,
                                  dateInitTaskinput.text,
                                  dateFinTaskinput.text);

                              setState(() {
                                if (task_provider.isADD == true) {
                                  showDialog(
                                      context: context,
                                      builder: (_) {
                                        return AlertDialog(
                                          content: Text(
                                              "Se ha registardo correctamente " +
                                                  DateTime.now().toString() +
                                                  task_provider.isADD
                                                      .toString()),
                                        );
                                      });
                                } else {
                                  showDialog(
                                      context: context,
                                      builder: (_) {
                                        return AlertDialog(
                                          content: Card(
                                            child: Column(
                                              children: [
                                                Text(
                                                    "Se ha regestardo con fecha :" +
                                                        DateTime.now()
                                                            .toString()),
                                                Row(
                                                  children: [
                                                    IconButton(
                                                        onPressed: () {
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        icon: Icon(Icons.one_k))
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                        );
                                      });
                                }
                              });
                            }
                          })
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }

  _deleteFormDialog(BuildContext context, taskId) {
    return showDialog(
        context: context,
        builder: (param) {
          return AlertDialog(
            title: const Text(
              'Are You Sure to Delete',
              style: TextStyle(color: Colors.teal, fontSize: 20),
            ),
            actions: [
              TextButton(
                  style: TextButton.styleFrom(
                      primary: Colors.white, // foreground
                      backgroundColor: Colors.red),
                  onPressed: ()  {

                      //Navigator.pop(context);
                      // getAllUserDetails();
                      task_provider.deleteTask(taskId);
                      //   _showSuccessSnackBar(   'User Detail Deleted Success');

                  },
                  child: const Text('Delete')),
              TextButton(
                  style: TextButton.styleFrom(
                      primary: Colors.white, // foreground
                      backgroundColor: Colors.teal),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Close'))
            ],
          );
        });
  }
}
