class Point {
  int x;
  int y;

  Point(
    this.x,
    this.y,
  );

  @override
  String toString() {
    return '($x,$y)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Point && other.x == x && other.y == y;
  }

  @override
  int get hashCode => x.hashCode ^ y.hashCode;

  factory Point.fromJson(Map<String, dynamic> json) {
    return Point(
      json['x'],
      json['y'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'x': x,
      'y': y,
    };
  }
}
