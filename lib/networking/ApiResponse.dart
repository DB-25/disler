class ApiResponse<T> {
  String message;
  String error;
  bool status;
  List<T> data;

  ApiResponse({this.message, this.error, this.status, this.data});

  factory ApiResponse.fromMap(Map<String, dynamic> map) {
    return ApiResponse(
        message: map.containsKey('msg') ? (map['msg'] ?? '') : '',
        error: map.containsKey('msg') ? (map['msg'] ?? '') : '',
        status: map.containsKey('status') ? (map['status'] ?? '') : '',
        data: map.containsKey("data") ? (map["data"] ?? [null]) : '');
  }
}
