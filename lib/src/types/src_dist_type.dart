class SrcDistType {
  final String src;
  final String dist;
  const SrcDistType({required this.src, required this.dist});

  Map<String, dynamic> toMap() => {'src': src, 'dist': dist};
}
