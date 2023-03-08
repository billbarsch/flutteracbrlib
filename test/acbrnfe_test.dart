import 'package:acbrlib/AcbrNfe.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  ACBrNFe acbrNfe = ACBrNFe();

  test('Nome', () {
    expect(acbrNfe.nome(), equals('ACBrLibNFE'));
  });

  test('Versão', () {
    expect(acbrNfe.versao().length, equals(9));
  });
}
