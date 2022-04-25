class Event {
   String documentId;
  final DateTime time;
  final String sessionTitle;
  final List<String> host;
  final List<String> attendees;
  final String location;
   int price;
   bool paid;
  
  Event(
{this.price = 0, this.paid = false, this.documentId = '',
      required this.time,
      required this.sessionTitle,
      required this.host,
      required this.attendees,
      required this.location});

//info for uploading event
  Map<String, dynamic> toJson() {
    return {
      'time': time,
      'sessionTitle': sessionTitle,
      'host': host,
      'location': location,
      'price': price,
      'paid': paid,
    };
  }

  static Event fromJson(Map<String, dynamic> json) => Event(
    documentId: json['id'],
    time: json['time'].toDate() , 
    sessionTitle: json['sessionTitle'], 
    host: List.from(json['host']), 
    attendees: List.from(json['attendees']), 
    location: json['location'],
    // price: json['price'],
    // paid: json['paid'],
    );
}