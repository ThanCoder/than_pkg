class SrcDestType {
  final String src;
  final String dest;
  const SrcDestType({required this.src, required this.dest});

  Map<String, dynamic> toMap() => {'src': src, 'dist': dest};
}
