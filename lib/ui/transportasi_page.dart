import 'package:flutter/material.dart';
import '../bloc/logout_bloc.dart';
import '../bloc/transportasi_bloc.dart';
import '/model/transportasi.dart';
import '/ui/transportasi_detail.dart';
import '/ui/transportasi_form.dart';
import 'login_page.dart';

class TransportasiPage extends StatefulWidget {
  const TransportasiPage({super.key});

  @override
  _TransportasiPageState createState() => _TransportasiPageState();
}

class _TransportasiPageState extends State<TransportasiPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow, 
        title: const Text('List Transportasi'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              child: const Icon(Icons.add, size: 26.0),
              onTap: () async {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TransportasiForm()),
                );
              },
            ),
          ),
        ],
      ),
      drawer: Drawer(
        backgroundColor: Colors.yellow, 
        child: ListView(
          children: [
            ListTile(
              title: const Text(
                'Logout',
                style: TextStyle(color: Colors.black), 
              ),
              trailing: const Icon(Icons.logout,
                  color: Colors.black), 
              onTap: () async {
                await LogoutBloc.logout().then((value) => {
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                              builder: (context) => const LoginPage()),
                          (route) => false)
                    });
              },
            ),
          ],
        ),
      ),
      body: FutureBuilder<List>(
        future: TransportasiBloc.getTransportasis(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            print(snapshot.error);
          }
          return snapshot.hasData
              ? ListTransportasi(list: snapshot.data)
              : const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

class ListTransportasi extends StatelessWidget {
  final List? list;

  const ListTransportasi({super.key, this.list});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: list?.length ?? 0,
      itemBuilder: (context, i) {
        return ItemTransportasi(transportasi: list![i]);
      },
    );
  }
}

class ItemTransportasi extends StatelessWidget {
  final Transportasi transportasi;

  const ItemTransportasi({super.key, required this.transportasi});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                TransportasiDetail(transportasi: transportasi),
          ),
        );
      },
      child: Card(
        color: Colors.yellow[50], 
        child: ListTile(
          title: Text(transportasi.vehicle!),
          subtitle: Text(transportasi.company!),
          trailing: Text(transportasi.capacity.toString()),
        ),
      ),
    );
  }
}
