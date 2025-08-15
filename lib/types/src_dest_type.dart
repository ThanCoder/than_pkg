class SrcDestType {
  String src;
  String dest;
  SrcDestType({required this.src, required this.dest});

  Map<String, dynamic> toMap() => {'src': src, 'dist': dest};
}
