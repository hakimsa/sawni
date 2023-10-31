import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:progress_dialog_null_safe/progress_dialog_null_safe.dart';
import 'package:swani/models/Task.dart';
import 'package:swani/services/Task_Provider.dart';

class DetailsTask extends StatefulWidget {
  DetailsTask({key, this.task});
  final Task task;

  @override
  State<DetailsTask> createState() => _DetailsTaskState();
}

class _DetailsTaskState extends State<DetailsTask> {
  // const DetailsTask({super.key, required this.task});
  final task_provider = new Provider();
  bool enbale = false;
  final TextEditingController _controllerTitle = TextEditingController();
  final TextEditingController _controllerSubtitle = TextEditingController();
  final TextEditingController _controllerDescription = TextEditingController();
  final TextEditingController _controllerStartdate = TextEditingController();
  final TextEditingController _controllerEnddate = TextEditingController();
  Future<Task> _futureTask;

  bool isEditing = false;
  bool _on = false;

  void _toggleState() {
    setState(() {
      _on = !_on;
    });
  }

  ProgressDialog pr;

  @override
  void initState() {
    super.initState();
    pr = ProgressDialog(context);
    pr.style(
      message: 'Borrando...',
      progressWidget: CircularProgressIndicator(),
    );
  }

  Future<void> _showDeleteDialog() async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirmar borrado'),
          content: Text('¿Estás seguro de que deseas borrar este elemento?'),
          actions: <Widget>[
            TextButton(
              child: Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Borrar'),
              onPressed: () {
                pr.show();
                Future.delayed(Duration(seconds: 2), () {
                  pr.hide();
                  // Aquí puedes agregar lógica para borrar el elemento y mostrar el ID borrado.
                  showDeletedDialog();
                });
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Details task'),
        ),
        body: Stack(
          children: [
            _details(),
            _content(),
          ],
        ));
  }

  _details() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            Color.fromARGB(255, 113, 154, 187),
            Color.fromARGB(255, 137, 184, 52),
          ],
        ),
      ),
    );
  }

  _content() {
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 7, vertical: 10),
        padding: EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(25)),
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Color.fromARGB(136, 108, 109, 110),
              Color.fromARGB(255, 215, 245, 161),
            ],
          ),
        ),
        width: double.infinity,
        height: 600,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text("Título:"),
              isEditing
                  ? TextField(
                      onChanged: (text) {
                        setState(() {
                        _controllerTitle.text= text;
                        });
                      },

                      controller:
                          TextEditingController(text: _controllerTitle.text),
                    )
                  : Text(widget.task.title),
              SizedBox(height: 16),
              Text("Subtítulo:"),
              isEditing
                  ? TextField(
                      decoration: InputDecoration(icon: Icon(Icons.abc)),
                      onChanged: (text) {
                        setState(() {
                          widget.task.subtitle = text;
                        });
                      },
                      controller:
                          TextEditingController(text: widget.task.subtitle),
                    )
                  : Text(widget.task.subtitle),
              SizedBox(height: 16),
              Text("Descripción:"),
              isEditing
                  ? TextField(
                      onChanged: (text) {
                        setState(() {
                          widget.task.description = text;
                        });
                      },
                      controller:
                          TextEditingController(text: widget.task.description),
                    )
                  : Text(widget.task.description),
              SizedBox(height: 16),
              Row(
                children: [
                  Text("Fecha de inicio:  " + widget.task.start_date),
                ],
              ),
              Row(
                children: [
                  isEditing
                      ? IconButton(
                          onPressed: () {
                            _fetcha();
                          },
                          icon: Icon(Icons.update))
                      : Text("Fecha de Fin:  " + widget.task.end_date),
                ],
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    isEditing = !isEditing;
                    task_provider.updateTask(
                        widget.task.id,
                        _controllerTitle.text,
                        _controllerSubtitle.text,
                        _controllerDescription.text,
                        _controllerStartdate.text,
                        _controllerEnddate.text);
                  });
                },
                child: Text(isEditing ? "Guardar" : "Editar"),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  _showDeleteDialog();
                },
                style: ElevatedButton.styleFrom(primary: Colors.red),
                child: Text("Borrar"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _fetcha() async {
    DateTime pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(
            2000), //DateTime.now() - not to allow to choose before today.
        lastDate: DateTime(2101));

    if (pickedDate != null) {
      print(pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
      String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
      //formatted date output using intl package =>  2021-03-16
      //you can implement different kind of Date Format here according to your requirement

      setState(() {
        _controllerStartdate.text = formattedDate;

        // dateController= dateinput.text;
        //set output date to TextField value.
      });
    } else {
      print("Date is not selected");
    }
  }

  Future<void> showDeletedDialog() async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Elemento Borrado'),
          content:
              Text('El elemento ${widget.task.title} se ha borrado con éxito.'),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                task_provider.deleteTask(widget.task.id);

                pr = ProgressDialog(context);
                pr.update(message: "Espere ..", progress: 54, maxProgress: 80);
                pr.style(
                  message: '...',
                  progressWidget: CircularProgressIndicator(),
                );

                setState(() {

                  pr.show();
                  Future.delayed(Duration(seconds: 2), () {
                    pr.hide();
                    // Aquí puedes agregar lógica para borrar el elemento y mostrar el ID borrado.
                    Navigator.pushNamed(context, "/");
                  });

                });
              },
            ),
          ],
        );
      },
    );
  }
}
