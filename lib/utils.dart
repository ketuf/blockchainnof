import 'dart:math';
import 'dart:io';
import 'package:hex/hex.dart';
import 'dart:convert';
import 'package:nofifty/obstructionum.dart';
import 'package:elliptic/elliptic.dart';
import 'package:nofifty/transaction.dart';
import 'package:ecdsa/ecdsa.dart';
class Utils {
  static final Random _random = Random.secure();

  static String randomHex(int length) {
    var values = List<int>.generate(length, (index) => _random.nextInt(256));
    return HEX.encode(values);
  }
  static Stream<String> fileAmnis(File file) => file.openRead().transform(utf8.decoder).transform(LineSplitter());

  static Future<Obstructionum> priorObstructionum(directory) async =>
      Obstructionum.fromJson(json.decode(await Utils.fileAmnis(File(directory.path + '/caudices_' + (directory.listSync().length -1).toString() + '.txt')).last));
  static String signum(PrivateKey privateKey, dynamic output) => signature(privateKey, utf8.encode(json.encode(output.toJson()))).toASN1Hex();


  static bool cognoscere(PublicKey publicaClavis, Signature signature, TransactionOutput txOutput) =>
      verify(publicaClavis, utf8.encode(json.encode(txOutput.toJson())), signature);
}
