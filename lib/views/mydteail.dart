import 'package:flutter/material.dart';
import 'package:progress_dialog_null_safe/progress_dialog_null_safe.dart';



class MyDetailPage extends StatefulWidget {
  @override
  _MyDetailPageState createState() => _MyDetailPageState();
}

class _MyDetailPageState extends State<MyDetailPage> {
  String title = "Título";
  String subtitle = "Subtítulo";
  String description = "Descripción";
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now();

  bool isEditing = false;

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

  Future<void> showDeletedDialog() async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Elemento Borrado'),
          content: Text('El elemento se ha borrado con éxito.'),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
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
        title: Text("Detalles"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text("Título:"),
            isEditing
                ? TextField(
              onChanged: (text) {
                setState(() {
                  title = text;
                });
              },
              controller: TextEditingController(text: title),
            )
                : Text(title),
            SizedBox(height: 16),
            Text("Subtítulo:"),
            isEditing
                ? TextField(
              onChanged: (text) {
                setState(() {
                  subtitle = text;
                });
              },
              controller: TextEditingController(text: subtitle),
            )
                : Text(subtitle),
            SizedBox(height: 16),
            Text("Descripción:"),
            isEditing
                ? TextField(
              onChanged: (text) {
                setState(() {
                  description = text;
                });
              },
              controller: TextEditingController(text: description),
            )
                : Text(description),
            SizedBox(height: 16),
            Text("Fecha de inicio: ${startDate.toLocal()}"),
            Text("Fecha de finalización: ${endDate.toLocal()}"),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  isEditing = !isEditing;
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
    );
  }
}
