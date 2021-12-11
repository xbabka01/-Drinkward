class User {
  int id;
  String email;
  String password;
  int karma;

  User(this.id, this.email, this.password, this.karma);
}

class Event {
  int id;
  DateTime startDate;
  DateTime endDate;
  String description;

  Event(this.id, this.startDate, this.endDate, this.description);
}

class Pub {
  int id;
  String name;
  int googleId;
  String city;
  String street;
  int streetNumber;

  Pub(this.id, this.name, this.googleId, this.city, this.street,
      this.streetNumber);
}

enum Rating{like, dislike}

class Rated {
  Rating value;

  Rated(this.value);
}