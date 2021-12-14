class User{
  User(this.id, this.email, this.password, this.karma);

  int id;
  String email;
  String password;
  int karma;
}

class Event {
  Event(this.id, this.startDate, this.endDate, this.about, this.ratedId,
      this.name, this.pub);

  int id;
  DateTime startDate;
  DateTime endDate;
  String about;
  int ?ratedId;
  String ?name;
  List<Pub> pub;
}

class Pub {
  Pub(this.id, this.name, this.googleId, this.city, this.street,
      this.streetNumber, this.events);

  int id;
  String name;
  String googleId;
  String city;
  String street;
  int streetNumber;
  List<Event> events;

}

enum Rating{like, dislike}

class Rated {
  Rating value;

  Rated(this.value);

}