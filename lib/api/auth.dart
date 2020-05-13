part of api;

class AuthApi {
  static Future login(String code) async {
    return await Api.dio.get("/").then((res) {
      // return serializers.deserializeWith(Home.serializer, res.data['value'][0]);
    });
  }
}
