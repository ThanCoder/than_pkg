import 'dart:convert';
import 'dart:io';

Future<ProcessResult> ffprobeRun({required List<String> arguments}) async {
  return await processRun('ffprobe', arguments: arguments);
}

Future<ProcessResult> ffmpegRun({required List<String> arguments}) async {
  return await processRun('ffmpeg', arguments: arguments);
}

Future<void> ffmpegStart({
  required List<String> arguments,
  void Function(String data)? onStdout,
  void Function(String data)? onStdErrorOut,
}) async {
  await processStart(
    'ffmpeg',
    arguments: arguments,
    onStdErrorOut: onStdErrorOut,
    onStdout: onStdout,
  );
}

Future<void> ffprobeStart({
  required List<String> arguments,
  void Function(String data)? onStdout,
  void Function(String data)? onStdErrorOut,
}) async {
  await processStart(
    'ffprobe',
    arguments: arguments,
    onStdErrorOut: onStdErrorOut,
    onStdout: onStdout,
  );
}

// process
Future<ProcessResult> processRun(
  String executable, {
  required List<String> arguments,
}) async {
  return await Process.run(executable, arguments);
}

Future<void> processStart(
  String executable, {
  required List<String> arguments,
  void Function(String data)? onStdout,
  void Function(String data)? onStdErrorOut,
}) async {
  final process = await Process.start(executable, arguments);

  process.stdout.transform(utf8.decoder).listen(onStdout);
  process.stderr.transform(utf8.decoder).listen(onStdErrorOut);
  final exitCode = await process.exitCode;
  if (exitCode == 0) {
    onStdout?.call('Doned');
  } else {
    onStdErrorOut?.call('error');
  }
}
