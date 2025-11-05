// ignore_for_file: public_member_api_docs, sort_constructors_first, non_constant_identifier_names
class AndroidDeviceInfo {
  final String fingerprint;
  final String soc_model;
  final String model;
  final String product;
  final String manufacture;
  final String hardware;
  final String bootloader;
  final String board;
  final String release_or_codename;
  final String security_patch;
  final int preview_sdk_int;
  final int sdk_int;
  final String base_os;
  final String codename;
  final List<String> abi;
  AndroidDeviceInfo({
    required this.fingerprint,
    required this.soc_model,
    required this.model,
    required this.product,
    required this.manufacture,
    required this.hardware,
    required this.bootloader,
    required this.board,
    required this.release_or_codename,
    required this.security_patch,
    required this.preview_sdk_int,
    required this.sdk_int,
    required this.base_os,
    required this.codename,
    required this.abi,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'fingerprint': fingerprint,
      'soc_model': soc_model,
      'model': model,
      'product': product,
      'manufacture': manufacture,
      'hardware': hardware,
      'bootloader': bootloader,
      'board': board,
      'release_or_codename': release_or_codename,
      'security_patch': security_patch,
      'preview_sdk_int': preview_sdk_int,
      'sdk_int': sdk_int,
      'base_os': base_os,
      'codename': codename,
      'abi': abi,
    };
  }

  factory AndroidDeviceInfo.fromMap(Map<String, dynamic> map) {
    return AndroidDeviceInfo(
      fingerprint: map['fingerprint'] as String,
      soc_model: map['soc_model'] as String,
      model: map['model'] as String,
      product: map['product'] as String,
      manufacture: map['manufacture'] as String,
      hardware: map['hardware'] as String,
      bootloader: map['bootloader'] as String,
      board: map['board'] as String,
      release_or_codename: map['release_or_codename'] as String,
      security_patch: map['security_patch'] as String,
      preview_sdk_int: map['preview_sdk_int'] as int,
      sdk_int: map['sdk_int'] as int,
      base_os: map['base_os'] as String,
      codename: map['codename'] as String,
      abi: List<String>.from(map['abi'] ?? []),
    );
  }
}


/*
"fingerprint" to Build.FINGERPRINT,
"soc_model" to Build.SOC_MODEL,
"model" to Build.MODEL,
"product" to Build.PRODUCT,
"manufacture" to Build.MANUFACTURER,
"hardware" to Build.HARDWARE,
"bootloader" to Build.BOOTLOADER,
"board" to Build.BOARD,
"release_or_codename" to Build.VERSION.RELEASE_OR_CODENAME,
"security_patch" to Build.VERSION.SECURITY_PATCH,
"preview_sdk_int" to Build.VERSION.PREVIEW_SDK_INT,
"sdk_int" to Build.VERSION.SDK_INT,
"base_os" to Build.VERSION.BASE_OS,
"codename" to Build.VERSION.CODENAME,
 */