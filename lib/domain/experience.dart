class Experience {
  const Experience({
    required this.label,
    required this.period,
    required this.title,
    required this.details,
  });

  final String label;
  final String period;
  final String title;
  final List<String> details;
}
