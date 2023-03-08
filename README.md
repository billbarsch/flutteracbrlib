# Flutter AcbrLib

Projeto flutter para mostrar uso da DLL AcbrNfe

## Getting Started

Copie a Dll para a pasta assets


## Exemplo

```
import 'package:acbrlib/AcbrNfe.dart';

void main() {
  ACBrNFe acbrNfe = ACBrNFe();
  print(acbrNfe.nome() + ' ' + acbrNfe.versao());
}
```

## Executar a aplicação

``` 
flutter run -d windows
```


## Teste

``` 
flutter test ../test/acbrnfe_test.dart
```
