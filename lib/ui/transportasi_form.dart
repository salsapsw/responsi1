import 'package:flutter/material.dart';
import '../bloc/transportasi_bloc.dart';
import '../widget/warning_dialog.dart';
import '/model/transportasi.dart';
import 'transportasi_page.dart';

// ignore: must_be_immutable
class TransportasiForm extends StatefulWidget {
  Transportasi? transportasi;
  TransportasiForm({super.key, this.transportasi});

  @override
  _TransportasiFormState createState() => _TransportasiFormState();
}

class _TransportasiFormState extends State<TransportasiForm> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  String judul = "TAMBAH TRANSPORTASI";
  String tombolSubmit = "SIMPAN";
  final _vehicleTextboxController = TextEditingController();
  final _companyTextboxController = TextEditingController();
  final _capacityTextboxController = TextEditingController();

  @override
  void initState() {
    super.initState();
    isUpdate();
  }

  isUpdate() {
    if (widget.transportasi != null) {
      setState(() {
        judul = "UBAH TRANSPORTASI";
        tombolSubmit = "UBAH";
        _vehicleTextboxController.text = widget.transportasi!.vehicle!;
        _companyTextboxController.text = widget.transportasi!.company!;
        _capacityTextboxController.text =
            widget.transportasi!.capacity.toString();
      });
    } else {
      judul = "TAMBAH TRANSPORTASI";
      tombolSubmit = "SIMPAN";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(judul), backgroundColor: Colors.yellow),
      backgroundColor: Colors.yellow[100], 
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0), 
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _vehicleTextField(),
                const SizedBox(height: 12), 
                _companyTextField(),
                const SizedBox(height: 12),
                _capacityTextField(),
                const SizedBox(height: 20),
                _buttonSubmit(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Membuat Textbox Vehicle
  Widget _vehicleTextField() {
    return TextFormField(
      decoration: const InputDecoration(
        labelText: "Kendaraan",
        border: OutlineInputBorder(), 
        filled: true,
        fillColor: Colors.white, 
      ),
      keyboardType: TextInputType.text,
      controller: _vehicleTextboxController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Kendaraan harus diisi";
        }
        return null;
      },
    );
  }

  // Membuat Textbox Company
  Widget _companyTextField() {
    return TextFormField(
      decoration: const InputDecoration(
        labelText: "Perusahaan",
        border: OutlineInputBorder(),
        filled: true,
        fillColor: Colors.white,
      ),
      keyboardType: TextInputType.text,
      controller: _companyTextboxController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Perusahaan harus diisi";
        }
        return null;
      },
    );
  }

  // Membuat Textbox Capacity
  Widget _capacityTextField() {
    return TextFormField(
      decoration: const InputDecoration(
        labelText: "Kapasitas",
        border: OutlineInputBorder(),
        filled: true,
        fillColor: Colors.white,
      ),
      keyboardType: TextInputType.number,
      controller: _capacityTextboxController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Kapasitas harus diisi";
        }
        return null;
      },
    );
  }

  Widget _buttonSubmit() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.black, 
        backgroundColor: Colors.yellow, 
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
      ),
      child: Text(tombolSubmit, style: const TextStyle(fontSize: 18)),
      onPressed: () {
        var validate = _formKey.currentState!.validate();
        if (validate) {
          if (!_isLoading) {
            if (widget.transportasi != null) {
              ubah();
            } else {
              simpan();
            }
          }
        }
      },
    );
  }

  void simpan() {
    setState(() {
      _isLoading = true;
    });
    Transportasi createTransportasi = Transportasi(id: null);
    createTransportasi.vehicle = _vehicleTextboxController.text;
    createTransportasi.company = _companyTextboxController.text;
    createTransportasi.capacity = int.parse(_capacityTextboxController.text);

    TransportasiBloc.addTransportasi(transportasi: createTransportasi).then(
      (value) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
              builder: (BuildContext context) => const TransportasiPage()),
        );
      },
      onError: (error) {
        showDialog(
          context: context,
          builder: (BuildContext context) => const WarningDialog(
            description: "Simpan gagal, silahkan coba lagi",
          ),
        );
      },
    );
    setState(() {
      _isLoading = false;
    });
  }

  void ubah() {
    setState(() {
      _isLoading = true;
    });
    Transportasi updateTransportasi =
        Transportasi(id: widget.transportasi!.id!);
    updateTransportasi.vehicle = _vehicleTextboxController.text;
    updateTransportasi.company = _companyTextboxController.text;
    updateTransportasi.capacity = int.parse(_capacityTextboxController.text);

    TransportasiBloc.updateTransportasi(transportasi: updateTransportasi).then(
      (value) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
              builder: (BuildContext context) => const TransportasiPage()),
        );
      },
      onError: (error) {
        showDialog(
          context: context,
          builder: (BuildContext context) => const WarningDialog(
            description: "Permintaan ubah data gagal, silahkan coba lagi",
          ),
        );
      },
    );
    setState(() {
      _isLoading = false;
    });
  }
}
