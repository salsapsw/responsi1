class ApiUrl {
  static const String baseUrl =
      'http://responsi.webwizards.my.id/pariwisata/transportasi';

  static const String registrasi = '$baseUrl/registrasi';
  static const String login = '$baseUrl/login';
  static const String listTransportasi = '$baseUrl/transportasi';
  static const String createTransportasi = '$baseUrl/transportasi';

  static String updateTransportasi(int id) {
    return '$baseUrl/transportasi/$id/update';
  }

  static String showTransportasi(int id) {
    return '$baseUrl/transportasi/$id';
  }

  static String deleteTransportasi(int id) {
    return '$baseUrl/transportasi/$id/delete';
  }
}
