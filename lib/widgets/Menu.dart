
import 'package:flutter/material.dart';

class Menu extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromARGB(174, 0, 0, 0),
      width: 250,
      child: Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.close,
                  color: Colors.redAccent,
                ))
          ],
        ),
        DrawerHeader(
            child: Row(
              children: [Text("menu")],
            )),
        ListTile(
          onTap: (){ Navigator.pushNamed(context, "s");},
          leading: Text(
            "Settings",
            style: TextStyle(color: Colors.white),
          ),
          trailing: Icon(
            Icons.settings,
            color: Colors.white,
          ),
        ),
        ListTile(
          onTap: () {
            Navigator.pushNamed(context, "det");
          },
          leading: Text(
            "Login",
            style: TextStyle(color: Colors.white),
          ),
          trailing: Icon(
            Icons.baby_changing_station,
            color: Colors.white,
          ),
        ),
        ListTile(
          leading: Text(
            "Settings",
            style: TextStyle(color: Colors.white),
          ),
          trailing: Icon(
            Icons.public,
            color: Colors.white,
          ),onTap: () {
          Navigator.pushNamed(context, "ev");
        },
        )
      ]),
    );
  }
}
