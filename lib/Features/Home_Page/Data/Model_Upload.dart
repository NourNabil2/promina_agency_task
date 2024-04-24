class ModelUpload {
  ModelUpload({
    required this.status,
    required this.data,
    required this.message,
  });
  late final String status;
  late final List<dynamic> data;
  late final String message;

  ModelUpload.fromJson(Map<String, dynamic> json){
    status = json['status'];
    data = List.castFrom<dynamic, dynamic>(json['data']);
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['data'] = data;
    _data['message'] = message;
    return _data;
  }
}