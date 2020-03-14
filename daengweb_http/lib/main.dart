import 'package:flutter/material.dart';
//IMPORT PACKAGE UNTUK HTTP REQUEST DAN ASYNCHRONOUS
import 'dart:async'; 
import 'dart:convert';
import 'package:http/http.dart' as http;


void main() {
  runApp(DigitalQuran());
}

class DigitalQuran extends StatefulWidget {
  DigitalQuranState createState() => DigitalQuranState();
}

class DigitalQuranState extends State<DigitalQuran> {
  //api url
  final String url = 'https://api.banghasan.com/quran/format/json/surat';
  List data; //DEFINE VARIABLE data DENGAN TYPE List AGAR DAPAT MENAMPUNG COLLECTION / ARRAY


@override
void initState() {
    super.initState();
    this.getData(); 



}
  Future<String> getData() async {
    
    var res = await http.get(Uri.encodeFull(url), headers: { 'accept':'application/json' });
    
    setState(() {
    
      var content = json.decode(res.body);
      //KEMUDIAN DATANYA DISIMPAN KE DALAM VARIABLE data, 
      //DIMANA SECARA SPESIFIK YANG INGIN KITA AMBIL ADALAH ISI DARI KEY hasil
      data = content['hasil'];
    });
    return 'success!';
  }
Widget build(context) {
    return MaterialApp(
      title: 'Digital Quran',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Digital Quran')
        ),
        body: Container(
          margin: EdgeInsets.all(10.0), //SET MARGIN DARI CONTAINER
          child: ListView.builder( //MEMBUAT LISTVIEW
            itemCount: data == null ? 0:data.length, // APABILA ADA MAKA KITA COUNT JUMLAH DATA YANG ADA
            itemBuilder: (BuildContext context, int index) { 
              return Container(
                child: Card(
                  child: Column(
                    mainAxisSize: MainAxisSize.min, children: <Widget>[
                    //ListTile MENGELOMPOKKAN WIDGET MENJADI BEBERAPA BAGIAN
                    ListTile(
                      // berisi noomer
                      leading: Text(data[index]['nomor'], style: TextStyle(fontSize: 30.0),),
                      //berisi surat
                      title: Text(data[index]['nama'], style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),),
                      //gambar
                      trailing: Image.asset(data[index]['type'] == 'mekah' ? 'imgg/mekah.jpg':'imgg/madinah.png', width: 30.0, height: 30.0,),
                      //subtitle TAMPIL TEPAT DIBAWAH title
                      subtitle: Column(children: <Widget>[ //MENGGUNAKAN COLUMN
                        //DIMANA MASING-MASING COLUMN TERDAPAT ROW
                        Row(
                          children: <Widget>[
                            //MENAMPILKAN TEXT arti
                            Text('Arti : ', style: TextStyle(fontWeight: FontWeight.bold),),
                            //MENAMPILKAN TEXT DARI VALUE arti
                            Text(data[index]['arti'], style: TextStyle(fontStyle: FontStyle.italic, fontSize: 15.0),),
                          ],
                        ),
                        //ROW SELANJUTNYA MENAMPILKAN JUMLAH AYAT
                        Row(
                          children: <Widget>[
                            Text('Jumlah Ayat : ', style: TextStyle(fontWeight: FontWeight.bold),),
                            //DARI INDEX ayat
                            Text(data[index]['ayat'])
                          ],
                        ),
                        //MENAMPILKAN DIMANA SURAH TERSEBUT DITURUNKAN
                        Row(
                          children: <Widget>[
                            Text('Diturunkan : ', style: TextStyle(fontWeight: FontWeight.bold),),
                            //DENGAN INDEX type
                            Text(data[index]['type'])
                          ],
                        ),
                      ],),
                    ),
                   
                    ButtonTheme.bar(
                      child: ButtonBar(
                        children: <Widget>[
                          // BUTTON  
                          FlatButton(
                            // LIHAT DETAIL
                            child: const Text('LIHAT DETAIL'),
                            onPressed: () { /* ... */ },
                          ),
                          //BUTTON KEDUA
                          FlatButton(
                            // DENGARKAN
                            child: const Text('LISTEN'),
                            onPressed: () { /* ... */ },
                          ),
                        ],
                      ),
                    ),
                  ],),
                )
              );
            },
          ),
        )
      ),
    );
}

}
