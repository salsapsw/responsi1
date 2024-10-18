# pariwisata - transportasi 

Nama	: Salsabilla PSW
NIM	: H1D021063
SHIFT F
PAKET PARIWISATA – TRANSPORTASI
![image](https://github.com/user-attachments/assets/f682eaaf-fb3a-4618-a3bd-6faac40ebee6)
![image](https://github.com/user-attachments/assets/e5cf4fdd-eddc-45cc-acda-58509a434369)
![image](https://github.com/user-attachments/assets/bceba433-ce73-402f-99b1-91258bf89a9c)
![image](https://github.com/user-attachments/assets/ac7cb376-b304-4bc9-adff-b9c64da19349)
![image](https://github.com/user-attachments/assets/88d262e5-d48c-483d-ac85-c3c91a266ca6)
![image](https://github.com/user-attachments/assets/1493e7b8-9339-4f18-9d25-7ba5159bd67c)
![image](https://github.com/user-attachments/assets/87d0877c-60d1-48f0-a59d-e9fa97a922e5)
![image](https://github.com/user-attachments/assets/8811d66f-2ca9-4e47-91ee-a1fff4fdd6b6)
![image](https://github.com/user-attachments/assets/7e5e6942-861b-4917-9771-01f7c7e68ebf)
![image](https://github.com/user-attachments/assets/00dae5b5-518e-43d4-9ffd-22c8d024e447)
![image](https://github.com/user-attachments/assets/7590be5e-ebae-4275-95cc-c96eb4e2d45e)
![image](https://github.com/user-attachments/assets/8804d607-f509-4c4f-8648-9ef4e65aef5d)

1.	Registrasi Page: Halaman ini buat nge-handle registrasi user. Ada form buat input nama, email, password, sama konfirmasi password. Ngecek validasi input dulu sebelum bisa submit. Kalau valid, data bakal dikirim.
ElevatedButton(
  onPressed: _formKey.currentState!.validate() ? _register : null,
  child: Text('Daftar')
)
2.	Detail Transportasi: Di sini, detail transportasi kayak nama kendaraan, perusahaan, sama kapasitas ditampilin. Ada juga action button buat "Edit" atau "Hapus" data, tapi hapusnya pakai konfirmasi dulu.
ElevatedButton.icon(
  onPressed: _confirmDelete,
  icon: Icon(Icons.delete),
  label: Text("Hapus")
)
3.	Transportasi Page: Di sini list transportasi ditampilin. Tiap item di list ada nama kendaraan, perusahaan, dan detail lainnya. Ada tombol buat tambah data baru dan opsi buat logout lewat drawer.
FloatingActionButton(
  onPressed: () => Navigator.pushNamed(context, '/tambah-transportasi'),
  child: Icon(Icons.add)
)
4.	Form Transportasi: Halaman ini buat input atau edit data transportasi. Tergantung apakah mode tambah atau edit, label dan action button-nya akan beda.
_isEditMode ? Text('Ubah Data') : Text('Tambah Data')
5.	Proses Penyimpanan dan Pengeditan Data: Function simpan dipakai buat tambah data baru, sedangkan ubah buat update data yang udah ada. Dua-duanya pakai async call ke TransportasiBloc, kalau error ada feedback ke user.
_isEditMode ? _bloc.ubahTransportasi(transportasi) : _bloc.simpanTransportasi(transportasi)

6.	Konfirmasi Hapus Data: Kalau user mau hapus data transportasi, kita kasih dialog konfirmasi dulu, jadi nggak langsung kehapus. Kalau user yakin, data bakal dihapus lewat TransportasiBloc.
showDialog(
  context: context,
  builder: (context) => AlertDialog(
    title: Text('Yakin mau hapus?'),
    actions: [
      TextButton(onPressed: () => Navigator.pop(context), child: Text('Batal')),
      TextButton(onPressed: _hapusTransportasi, child: Text('Hapus'))
    ],
  ),
)
7.	Login Page: Ada halaman login buat user masuk ke aplikasi. Formnya simpel, cuma butuh email sama password. Ada validasi email biar formatnya bener dan password minimal 6 karakter.
TextFormField(
  validator: (value) {
    if (value == null || value.isEmpty) return 'Email harus diisi';
    if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) return 'Format email salah';
    return null;
  },
)

8.	Navigasi ke Halaman Utama: Setelah user berhasil login atau registrasi, kita pakai Navigator.pushReplacement buat bawa user ke halaman utama (dashboard transportasi).
Navigator.pushReplacementNamed(context, '/transportasi')

9.	Error Handling dan Feedback: Setiap kali ada interaksi kayak tambah, edit, atau hapus data, atau gagal login, kita kasih feedback ke user pakai Snackbar atau dialog. Jadi user tahu apa yang lagi terjadi di aplikasi.
ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Data berhasil ditambah')))

10.	Drawer untuk Navigasi: Ada drawer di aplikasi yang berisi beberapa opsi navigasi, kayak "Tambah Transportasi", "Logout", dan "Bantuan". Pas user klik logout, session di-clear dan user balik ke halaman login.
Drawer(
  child: ListView(
    children: [
      ListTile(
        leading: Icon(Icons.logout),
        title: Text('Logout'),
        onTap: () => _logout(),
      ),
    ],
  ),
)

