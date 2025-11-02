class Course {
  final String id;
  final String title;
  const Course(this.id, {required this.title});

  @override
  String toString() {
    return 'Course<$id, "$title">';
  }
}
