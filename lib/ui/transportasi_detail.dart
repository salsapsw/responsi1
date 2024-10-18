import 'package:flutter/material.dart';
import '../bloc/transportasi_bloc.dart';
import '../widget/warning_dialog.dart';
import '/model/transportasi.dart';
import '/ui/transportasi_form.dart';
import 'transportasi_page.dart';

// ignore: must_be_immutable
class TransportasiDetail extends StatefulWidget {
  Transportasi? transportasi;

  TransportasiDetail({super.key, this.transportasi});

  @override
  _TransportasiDetailState createState() => _TransportasiDetailState();
}

class _TransportasiDetailState extends State<TransportasiDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow, 
        title: const Text('Detail Transportasi'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0), 
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildDetailText("Kendaraan: ${widget.transportasi!.vehicle}", 20.0),
              _buildDetailText("Perusahaan: ${widget.transportasi!.company}", 18.0),
              _buildDetailText("Kapasitas: ${widget.transportasi!.capacity}", 18.0),
              const SizedBox(height: 20), 
              _tombolHapusEdit(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailText(String text, double fontSize) {
    return Text(
      text,
      style: TextStyle(fontSize: fontSize, color: Colors.black87), 
      textAlign: TextAlign.center,
    );
  }

  Widget _tombolHapusEdit() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        OutlinedButton(
          style: OutlinedButton.styleFrom(
            foregroundColor: Colors.black, side: const BorderSide(color: Colors.yellow), // Warna border
          ),
          child: const Text("EDIT"),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => TransportasiForm(
                  transportasi: widget.transportasi!,
                ),
              ),
            );
          },
        ),
        const SizedBox(width: 10), 
        // Tombol Hapus
        OutlinedButton(
          style: OutlinedButton.styleFrom(
            foregroundColor: Colors.black, side: const BorderSide(color: Colors.yellow),
          ),
          child: const Text("DELETE"),
          onPressed: () => confirmHapus(),
        ),
      ],
    );
  }

  void confirmHapus() {
    AlertDialog alertDialog = AlertDialog(
      title: const Text("Konfirmasi Hapus"),
      content: const Text("Yakin ingin menghapus data ini?"),
      actions: [
        // Tombol Hapus
        OutlinedButton(
          style: OutlinedButton.styleFrom(
            foregroundColor: Colors.black, side: const BorderSide(color: Colors.yellow),
          ),
          child: const Text("Ya"),
          onPressed: () {
            TransportasiBloc.deleteTransportasi(id: widget.transportasi!.id!).then(
              (value) => {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const TransportasiPage()))
              },
              onError: (error) {
                showDialog(
                  context: context,
                  builder: (BuildContext context) => const WarningDialog(
                    description: "Hapus gagal, silahkan coba lagi",
                  ),
                );
              },
            );
          },
        ),
        // Tombol Batal
        OutlinedButton(
          style: OutlinedButton.styleFrom(
            foregroundColor: Colors.black, side: const BorderSide(color: Colors.yellow),
          ),
          child: const Text("Batal"),
          onPressed: () => Navigator.pop(context),
        ),
      ],
    );

    showDialog(builder: (context) => alertDialog, context: context);
  }
}
