import 'package:dio/dio.dart';
import 'package:lista_de_contatos/contato_model.dart';

class ContatoRepository {
  Future<ContatosModel> obterContatos() async {
    final dio = Dio();
    dio.options.headers['X-Parse-Application-Id'] =
        "9q8ktvxSAI2zG8zCMcT6bP2BWa2sz3gQDPwPyJk5";
    dio.options.headers['X-Parse-REST-API-Key'] =
        "tus0cXfxM62LdlrEo2lNbYGqKITlNUvPqcD9mPpw";

    dio.options.headers['Content-Type'] = "application/json";
    var result =
        await dio.get('https://parseapi.back4app.com/classes/contatos');

    return ContatosModel.fromJson(result.data);
  }

  Future<void> criarTarefa(Contato contato) async {
    final dio = Dio();
    dio.options.headers['X-Parse-Application-Id'] =
        "9q8ktvxSAI2zG8zCMcT6bP2BWa2sz3gQDPwPyJk5";
    dio.options.headers['X-Parse-REST-API-Key'] =
        "tus0cXfxM62LdlrEo2lNbYGqKITlNUvPqcD9mPpw";

    dio.options.headers['Content-Type'] = "application/json";
    try {
      await dio.post(
        'https://parseapi.back4app.com/classes/contatos',
        data: contato.toJson(),
      );
    } catch (e) {
      print(e);
      rethrow;
    }
  }
}
