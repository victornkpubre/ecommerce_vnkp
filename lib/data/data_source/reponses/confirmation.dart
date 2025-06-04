import 'package:ecommerce_vnkp/data/data_source/reponses/base.dart';

class ConfirmationResponse  implements BaseResponse<bool> {
  final int? _status;
  final String? _message;
  final bool _confirmation;

  ConfirmationResponse({
    required int? status,
    required String? message,
    required bool confirmation
  }) : _status = status, _message = message, _confirmation = confirmation;

  @override
  bool get body => _confirmation;
  @override
  String? get message => _message;
  @override
  int? get status => _status;

  bool toDomain(){
    return _confirmation;
  }

}
