# Flutter AcbrLib

Projeto flutter para mostrar uso da DLL AcbrNfe

## Exemplo

```
import 'package:acbrlib/AcbrNfe.dart';

void main() {
  ACBrNFe acbrNfe = ACBrNFe();
  print(acbrNfe.nome() + ' ' + acbrNfe.versao());
}
```

## Executar a aplicação


### Modo Debug

``` 
flutter run -d windows
```
  - Copie a Dll para a pasta /assets para testar em modo debug

### Modo Release

``` 
flutter build windows
```
  - Copie a Dll para a pasta /build/windows/runner/Release para executar em modo release

## Teste

``` 
flutter test ../test/acbrnfe_test.dart
```

### Obervações

A dll usada é a ACBrNFe64.dll e está rodando no windows, em breve iremos testar no linux e estudar a possibilidade de android

