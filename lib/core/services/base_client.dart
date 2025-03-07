part of 'services.dart';

@lazySingleton
class BaseClient {
  BaseClient(this.env);

  final Env env;
  static Map<String, String> headers = <String, String>{
    if (getIt<Env>().apiKey?.isNotEmpty ?? false)
      'x-api-key': getIt<Env>().apiKey ?? '',
    'Accept': 'application/json',
    // 'Content-type': 'application/json',
  };

  Logger logger = const Logger('BaseClient');

  ///Realiza una peticion `GET`
  ///[url] el segmento de url del endpoint
  ///[headers] son los headers que se mandan en la peticion
  Future<http.Response?> get({
    required String path,
    Uri? uri,
    Map<String, String>? header,
  }) async {
    Uri url = uri ?? Uri.parse(<String>[env.baseUrl, path].join('/'));
    try {
      final res = await http.get(
        url,
        headers: await _buildHeaders(
          header,
        ),
      );
      return _processResponse(res);
    } on SocketException catch (e, s) {
      //cuando no hay conexión a internet
      log(e.toString());
      throw BaseClientException(
        type: 'SocketException',
        url: uri.toString(),
        message: e.toString(),
        stackTrace: s,
      );
    } on TimeoutException catch (e, s) {
      //la api tardo mucho en responder
      log(e.toString());
      throw BaseClientException(
        type: 'TimeoutException',
        url: uri.toString(),
        message: e.toString(),
        stackTrace: s,
      );
    }
    // catch (e, s) {
    //   //ocurre cualquier otra excepcion
    //   log(e.toString());
    //   throw HttpFailure(
    //     type: 'UnknownException',
    //     url: _url.toString(),
    //     message: e.toString(),
    //     stackTrace: s,
    //   );
    // }
  }

  ///Realiza una peticion `POST`
  ///[url] el segmento de url del endpoint
  ///[headers] son los headers que se mandan en la peticion
  ///[body] es el cuerpo de la peticion
  Future<http.Response?> post({
    required String path,
    Uri? uri,
    Map<String, String>? header,
    Map<String, dynamic>? body,
  }) async {
    Uri url = uri ?? Uri.parse(<String>[env.baseUrl, path].join('/'));
    try {
      final res = await http.post(
        url,
        headers: await _buildHeaders(
          header,
        ),
        body: jsonEncode(body),
      );
      return _processResponse(res);
    } on SocketException catch (e, s) {
      //cuando no hay conexión a internet
      log(e.toString());
      throw BaseClientException(
        type: 'SocketException',
        url: uri.toString(),
        message: e.toString(),
        stackTrace: s,
      );
    } on TimeoutException catch (e, s) {
      //la api tardo mucho en responder
      log(e.toString());
      throw BaseClientException(
        type: 'TimeoutException',
        url: uri.toString(),
        message: e.toString(),
        stackTrace: s,
      );
    }
    //  catch (e, s) {
    // ? ocurre cualquier otra excepcion
    //   log(e.toString());
    //   throw HttpFailure(
    //     type: 'UnknownException',
    //     url: _url.toString(),
    //     message: e.toString(),
    //     stackTrace: s,
    //   );
    // }
  }

  Future<http.Response?> put({
    required String path,
    Uri? uri,
    Map<String, String>? header,
    Map<String, dynamic>? body,
  }) async {
    Uri url = uri ?? Uri.parse(<String>[env.baseUrl, path].join('/'));
    try {
      final res = await http.put(
        url,
        headers: await _buildHeaders(
          header,
        ),
        body: jsonEncode(body),
      );
      return _processResponse(res);
    } on SocketException catch (e, s) {
      //cuando no hay conexión a internet
      log(e.toString());
      throw BaseClientException(
        type: 'SocketException',
        url: uri.toString(),
        message: e.toString(),
        stackTrace: s,
      );
    } on TimeoutException catch (e, s) {
      //la api tardo mucho en responder
      log(e.toString());
      throw BaseClientException(
        type: 'TimeoutException',
        url: uri.toString(),
        message: e.toString(),
        stackTrace: s,
      );
    }
    //  catch (e, s) {
    // ? ocurre cualquier otra excepcion
    //   log(e.toString());
    //   throw HttpFailure(
    //     type: 'UnknownException',
    //     url: _url.toString(),
    //     message: e.toString(),
    //     stackTrace: s,
    //   );
    // }
  }

  ///Procesa la respuesta si es correcta o lanza un error
  http.Response _processResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        return response;
      case 204:
        //cuando no se encontro lo pedido
        throw BaseClientException(
          type: 'NoContent',
          statusCode: response.statusCode,
          url: response.request!.url.toString(),
          message: utf8.decode(response.bodyBytes),
        );
      case 400:
        //cuando la peticion esta mal
        throw BaseClientException(
          type: 'BadRequest',
          statusCode: response.statusCode,
          url: response.request!.url.toString(),
          message: utf8.decode(response.bodyBytes),
        );
      case 401:
      case 403:
      case 404:
        //cuando falta autorización
        throw BaseClientException(
          type: 'UnAuthorization',
          statusCode: response.statusCode,
          url: response.request!.url.toString(),
          message: utf8.decode(response.bodyBytes),
        );
      case 500:
      default:
        //cuando ocurrio un error en el servidor o por otra razon
        throw BaseClientException(
          type: 'FetchData',
          statusCode: response.statusCode,
          url: response.request!.url.toString(),
          message: 'An error has ocurred: ${utf8.decode(response.bodyBytes)}',
        );
    }
  }

  Future<Map<String, String>> _buildHeaders(
    Map<String, String>? customHeaders,
  ) async =>
      <String, String>{
        ...headers,
        ...customHeaders ?? <String, String>{},
      };
}
