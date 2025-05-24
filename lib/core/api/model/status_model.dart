class StatusModel {
  final dynamic response;
  final num? code;
  final bool isSuccess;
  StatusModel({required this.response, required this.isSuccess, required this.code});
}