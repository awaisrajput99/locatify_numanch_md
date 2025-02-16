class MessageModel {
  MessageModel({
    required this.toid,
    required this.read,
    required this.type,
    required this.message,
    required this.sent,
    required this.fromid,
  });
  late final String toid;
  late final String read;
  late final Type type;
  late final String message;
  late final String sent;
  late final String fromid;

  MessageModel.fromJson(Map<String, dynamic> json){
    toid = json['toid'].toString();
    read = json['read'].toString();
    type = json['type'].toString() == Type.image.name? Type.image : Type.text;
    message = json['message'].toString();
    sent = json['sent'].toString();
    fromid = json['fromid'].toString();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['toid'] = toid;
    data['read'] = read;
    data['type'] = type.name;
    data['message'] = message;
    data['sent'] = sent;
    data['fromid'] = fromid;
    return data;
  }
}
enum Type { text, image }