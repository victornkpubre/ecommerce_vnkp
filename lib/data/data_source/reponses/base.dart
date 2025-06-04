
abstract class BaseResponse<T> {
  int? get status;
  String? get message;
  T get body;
}