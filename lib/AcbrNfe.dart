import 'dart:ffi';
import 'dart:io';
import 'package:ffi/ffi.dart';
import 'package:flutter/foundation.dart';

class ACBrNFe {
  static const BUFFER_LEN = 1024; // Defina o tamanho máximo do buffer aqui

  DynamicLibrary? _acbrLibNFe;

  String arqConfig;
  String chaveCrypt;

  int Function(Pointer<Utf8>, Pointer<Utf8>)? _nfeInicializar;
  int Function()? _nfeFinalizar;
  int Function(Pointer<Utf8>, Pointer<Int32>)? _nfeNome;
  int Function(Pointer<Utf8>, Pointer<Int32>)? _nfeVersao;
  int Function(Pointer<Utf8>)? _nfeConfigLer;
  int Function(Pointer<Utf8>)? _nfeConfigGravar;
  int Function(Pointer<Utf8>, Pointer<Utf8>, Pointer<Utf8>, Pointer<Int32>)? _nfeConfigLerValor;
  int Function(Pointer<Utf8>, Pointer<Utf8>, Pointer<Utf8>)? _nfeConfigGravarValor;
  int Function(Pointer<Utf8>, Pointer<Int32>)? _nfeUltimoRetorno;
  int Function(Pointer<Utf8>)? _nfeConfigImportar;
  int Function(Pointer<Utf8>, Pointer<Int32>)? _nfeConfigExportar;
  int Function(Pointer<Utf8>)? _nfeCarregarXML;
  int Function(Pointer<Utf8>)? _nfeCarregarINI;
  int Function(int, Pointer<Utf8>, Pointer<Int32>)? _nfeObterXml;
  int Function(int, Pointer<Utf8>, Pointer<Utf8>)? _nfeGravarXml;
  int Function(Pointer<Utf8>)? _nfeCarregarEventoXML;
  int Function(Pointer<Utf8>)? _nfeCarregarEventoINI;
  int Function()? _nfeLimparLista;
  int Function()? _nfeLimparListaEventos;
  int Function()? _nfeAssinar;
  int Function()? _nfeValidar;
  int Function(Pointer<Utf8>, Pointer<Int32>)? _nfeValidarRegrasdeNegocios;
  int Function(Pointer<Utf8>, Pointer<Int32>)? _nfeVerificarAssinatura;
  int Function(int, int, int, int, int, int, Pointer<Utf8>, Pointer<Utf8>, Pointer<Utf8>, Pointer<Int32>)?
      _nfeGerarChave;
  int Function(Pointer<Utf8>, Pointer<Int32>)? _nfeObterCertificados;
  int Function(int, Pointer<Utf8>, Pointer<Int32>)? _nfeGetPath;
  int Function(Pointer<Utf8>, Pointer<Utf8>, Pointer<Int32>)? _nfeGetPathEvento;
  int Function(Pointer<Utf8>, Pointer<Int32>)? _nfeStatusServico;
  int Function(Pointer<Utf8>, Pointer<Utf8>, Pointer<Int32>)? _nfeConsultar;
  int Function(Pointer<Utf8>, Pointer<Utf8>, int, int, int, int, int, Pointer<Utf8>, Pointer<Int32>)? _nfeInutilizar;
  int Function(int, bool, bool, bool, Pointer<Utf8>, Pointer<Int32>)? _nfeEnviar;
  int Function(Pointer<Utf8>, Pointer<Utf8>, Pointer<Int32>)? _nfeConsultarRecibo;
  int Function(Pointer<Utf8>, Pointer<Utf8>, Pointer<Utf8>, int, Pointer<Utf8>, Pointer<Int32>)? _nfeCancelar;
  int Function(int, Pointer<Utf8>, Pointer<Int32>)? _nfeEnviarEvento;
  int Function(Pointer<Utf8>, Pointer<Utf8>, bool, Pointer<Utf8>, Pointer<Int32>)? _nfeConsultaCadastro;
  int Function(int, Pointer<Utf8>, Pointer<Utf8>, Pointer<Utf8>, Pointer<Int32>)? _nfeDistribuicaoDFePorUltNSU;
  int Function(int, Pointer<Utf8>, Pointer<Utf8>, Pointer<Utf8>, Pointer<Int32>)? _nfeDistribuicaoDFePorNSU;
  int Function(int, Pointer<Utf8>, Pointer<Utf8>, Pointer<Utf8>, Pointer<Int32>)? _nfeDistribuicaoDFePorChave;
  int Function(Pointer<Utf8>, Pointer<Utf8>, bool, Pointer<Utf8>, Pointer<Utf8>, Pointer<Utf8>, Pointer<Utf8>)?
      _nfeEnviarEmail;
  int Function(Pointer<Utf8>, Pointer<Utf8>, Pointer<Utf8>, bool, Pointer<Utf8>, Pointer<Utf8>, Pointer<Utf8>,
      Pointer<Utf8>)? _nfeEnviarEmailEvento;
  int Function(Pointer<Utf8>, int, Pointer<Utf8>, Pointer<Utf8>, Pointer<Utf8>, Pointer<Utf8>, Pointer<Utf8>)?
      _nfeImprimir;
  int Function()? _nfeImprimirPDF;
  int Function(Pointer<Utf8>, Pointer<Utf8>)? _nfeImprimirEvento;
  int Function(Pointer<Utf8>, Pointer<Utf8>)? _nfeImprimirEventoPDF;
  int Function(Pointer<Utf8>)? _nfeImprimirInutilizacao;
  int Function(Pointer<Utf8>)? _nfeImprimirInutilizacaoPDF;

  ACBrNFe({this.arqConfig = '', this.chaveCrypt = ''}) {
    if (kDebugMode) {
      //modo debug
      _acbrLibNFe = DynamicLibrary.open(Directory.current.path + '/assets/ACBrNFe64.dll'); //dll na pasta assets
    } else {
      //modo release
      _acbrLibNFe = DynamicLibrary.open('ACBrNFe64.dll'); //dll na mesma pasta do .exe
    }

    _nfeInicializar = _acbrLibNFe!
        .lookup<NativeFunction<Int32 Function(Pointer<Utf8>, Pointer<Utf8>)>>('NFE_Inicializar')
        .asFunction();
    _nfeFinalizar = _acbrLibNFe!.lookup<NativeFunction<Int32 Function()>>('NFE_Finalizar').asFunction();

    _nfeNome =
        _acbrLibNFe!.lookup<NativeFunction<Int32 Function(Pointer<Utf8>, Pointer<Int32>)>>('NFE_Nome').asFunction();
    _nfeVersao =
        _acbrLibNFe!.lookup<NativeFunction<Int32 Function(Pointer<Utf8>, Pointer<Int32>)>>('NFE_Versao').asFunction();
    _nfeConfigLer = _acbrLibNFe!.lookup<NativeFunction<Int32 Function(Pointer<Utf8>)>>('NFE_ConfigLer').asFunction();
    _nfeConfigGravar =
        _acbrLibNFe!.lookup<NativeFunction<Int32 Function(Pointer<Utf8>)>>('NFE_ConfigGravar').asFunction();
    _nfeConfigLerValor = _acbrLibNFe!
        .lookup<NativeFunction<Int32 Function(Pointer<Utf8>, Pointer<Utf8>, Pointer<Utf8>, Pointer<Int32>)>>(
            'NFE_ConfigLerValor')
        .asFunction();
    _nfeConfigGravarValor = _acbrLibNFe!
        .lookup<NativeFunction<Int32 Function(Pointer<Utf8>, Pointer<Utf8>, Pointer<Utf8>)>>('NFE_ConfigGravarValor')
        .asFunction();
    _nfeConfigImportar =
        _acbrLibNFe!.lookup<NativeFunction<Int32 Function(Pointer<Utf8>)>>('NFE_ConfigImportar').asFunction();
    _nfeConfigExportar = _acbrLibNFe!
        .lookup<NativeFunction<Int32 Function(Pointer<Utf8>, Pointer<Int32>)>>('NFE_ConfigExportar')
        .asFunction();
    _nfeCarregarXML =
        _acbrLibNFe!.lookup<NativeFunction<Int32 Function(Pointer<Utf8>)>>('NFE_CarregarXML').asFunction();
    _nfeCarregarINI =
        _acbrLibNFe!.lookup<NativeFunction<Int32 Function(Pointer<Utf8>)>>('NFE_CarregarINI').asFunction();
    _nfeObterXml = _acbrLibNFe!
        .lookup<NativeFunction<Int32 Function(Int32, Pointer<Utf8>, Pointer<Int32>)>>('NFE_ObterXml')
        .asFunction();
    _nfeGravarXml = _acbrLibNFe!
        .lookup<NativeFunction<Int32 Function(Int32, Pointer<Utf8>, Pointer<Utf8>)>>('NFE_GravarXml')
        .asFunction();
    _nfeCarregarEventoXML =
        _acbrLibNFe!.lookup<NativeFunction<Int32 Function(Pointer<Utf8>)>>('NFE_CarregarEventoXML').asFunction();
    _nfeCarregarEventoINI =
        _acbrLibNFe!.lookup<NativeFunction<Int32 Function(Pointer<Utf8>)>>('NFE_CarregarEventoINI').asFunction();
    _nfeLimparLista = _acbrLibNFe!.lookup<NativeFunction<Int32 Function()>>('NFE_LimparLista').asFunction();
    _nfeLimparListaEventos =
        _acbrLibNFe!.lookup<NativeFunction<Int32 Function()>>('NFE_LimparListaEventos').asFunction();
    _nfeAssinar = _acbrLibNFe!.lookup<NativeFunction<Int32 Function()>>('NFE_Assinar').asFunction();
    _nfeValidar = _acbrLibNFe!.lookup<NativeFunction<Int32 Function()>>('NFE_Validar').asFunction();
    _nfeValidarRegrasdeNegocios = _acbrLibNFe!
        .lookup<NativeFunction<Int32 Function(Pointer<Utf8>, Pointer<Int32>)>>('NFE_ValidarRegrasdeNegocios')
        .asFunction();
    _nfeVerificarAssinatura = _acbrLibNFe!
        .lookup<NativeFunction<Int32 Function(Pointer<Utf8>, Pointer<Int32>)>>('NFE_VerificarAssinatura')
        .asFunction();
    _nfeGerarChave = _acbrLibNFe!
        .lookup<
            NativeFunction<
                Int32 Function(Int32, Int32, Int32, Int32, Int32, Int32, Pointer<Utf8>, Pointer<Utf8>, Pointer<Utf8>,
                    Pointer<Int32>)>>('NFE_GerarChave')
        .asFunction();
    _nfeObterCertificados = _acbrLibNFe!
        .lookup<NativeFunction<Int32 Function(Pointer<Utf8>, Pointer<Int32>)>>('NFE_ObterCertificados')
        .asFunction();
    _nfeGetPath = _acbrLibNFe!
        .lookup<NativeFunction<Int32 Function(Int32, Pointer<Utf8>, Pointer<Int32>)>>('NFE_GetPath')
        .asFunction();
    _nfeGetPathEvento = _acbrLibNFe!
        .lookup<NativeFunction<Int32 Function(Pointer<Utf8>, Pointer<Utf8>, Pointer<Int32>)>>('NFE_GetPathEvento')
        .asFunction();
    _nfeStatusServico = _acbrLibNFe!
        .lookup<NativeFunction<Int32 Function(Pointer<Utf8>, Pointer<Int32>)>>('NFE_StatusServico')
        .asFunction();
    _nfeConsultar = _acbrLibNFe!
        .lookup<NativeFunction<Int32 Function(Pointer<Utf8>, Pointer<Utf8>, Pointer<Int32>)>>('NFE_Consultar')
        .asFunction();
    _nfeInutilizar = _acbrLibNFe!
        .lookup<
            NativeFunction<
                Int32 Function(Pointer<Utf8>, Pointer<Utf8>, Int32, Int32, Int32, Int32, Int32, Pointer<Utf8>,
                    Pointer<Int32>)>>('NFE_Inutilizar')
        .asFunction();
    _nfeEnviar = _acbrLibNFe!
        .lookup<NativeFunction<Int32 Function(Int32, Bool, Bool, Bool, Pointer<Utf8>, Pointer<Int32>)>>('NFE_Enviar')
        .asFunction();
    _nfeConsultarRecibo = _acbrLibNFe!
        .lookup<NativeFunction<Int32 Function(Pointer<Utf8>, Pointer<Utf8>, Pointer<Int32>)>>('NFE_ConsultarRecibo')
        .asFunction();
    _nfeCancelar = _acbrLibNFe!
        .lookup<
            NativeFunction<
                Int32 Function(
                    Pointer<Utf8>, Pointer<Utf8>, Pointer<Utf8>, Int32, Pointer<Utf8>, Pointer<Int32>)>>('NFE_Cancelar')
        .asFunction();
    _nfeEnviarEvento = _acbrLibNFe!
        .lookup<NativeFunction<Int32 Function(Int32, Pointer<Utf8>, Pointer<Int32>)>>('NFE_EnviarEvento')
        .asFunction();
    _nfeConsultaCadastro = _acbrLibNFe!
        .lookup<NativeFunction<Int32 Function(Pointer<Utf8>, Pointer<Utf8>, Bool, Pointer<Utf8>, Pointer<Int32>)>>(
            'NFE_ConsultaCadastro')
        .asFunction();
    _nfeDistribuicaoDFePorUltNSU = _acbrLibNFe!
        .lookup<NativeFunction<Int32 Function(Int32, Pointer<Utf8>, Pointer<Utf8>, Pointer<Utf8>, Pointer<Int32>)>>(
            'NFE_DistribuicaoDFePorUltNSU')
        .asFunction();
    _nfeDistribuicaoDFePorNSU = _acbrLibNFe!
        .lookup<NativeFunction<Int32 Function(Int32, Pointer<Utf8>, Pointer<Utf8>, Pointer<Utf8>, Pointer<Int32>)>>(
            'NFE_DistribuicaoDFePorNSU')
        .asFunction();
    _nfeDistribuicaoDFePorChave = _acbrLibNFe!
        .lookup<NativeFunction<Int32 Function(Int32, Pointer<Utf8>, Pointer<Utf8>, Pointer<Utf8>, Pointer<Int32>)>>(
            'NFE_DistribuicaoDFePorChave')
        .asFunction();
    _nfeEnviarEmail = _acbrLibNFe!
        .lookup<
            NativeFunction<
                Int32 Function(Pointer<Utf8>, Pointer<Utf8>, Bool, Pointer<Utf8>, Pointer<Utf8>, Pointer<Utf8>,
                    Pointer<Utf8>)>>('NFE_EnviarEmail')
        .asFunction();
    _nfeEnviarEmailEvento = _acbrLibNFe!
        .lookup<
            NativeFunction<
                Int32 Function(Pointer<Utf8>, Pointer<Utf8>, Pointer<Utf8>, Bool, Pointer<Utf8>, Pointer<Utf8>,
                    Pointer<Utf8>, Pointer<Utf8>)>>('NFE_EnviarEmailEvento')
        .asFunction();
    _nfeImprimir = _acbrLibNFe!
        .lookup<
            NativeFunction<
                Int32 Function(Pointer<Utf8>, Int32, Pointer<Utf8>, Pointer<Utf8>, Pointer<Utf8>, Pointer<Utf8>,
                    Pointer<Utf8>)>>('NFE_Imprimir')
        .asFunction();
    _nfeImprimirPDF = _acbrLibNFe!.lookup<NativeFunction<Int32 Function()>>('NFE_ImprimirPDF').asFunction();
    _nfeImprimirEvento = _acbrLibNFe!
        .lookup<NativeFunction<Int32 Function(Pointer<Utf8>, Pointer<Utf8>)>>('NFE_ImprimirEvento')
        .asFunction();
    _nfeImprimirInutilizacao =
        _acbrLibNFe!.lookup<NativeFunction<Int32 Function(Pointer<Utf8>)>>('NFE_ImprimirInutilizacao').asFunction();
    _nfeImprimirInutilizacaoPDF =
        _acbrLibNFe!.lookup<NativeFunction<Int32 Function(Pointer<Utf8>)>>('NFE_ImprimirInutilizacaoPDF').asFunction();

    _nfeUltimoRetorno = _acbrLibNFe!
        .lookup<NativeFunction<Int32 Function(Pointer<Utf8>, Pointer<Int32>)>>('NFE_UltimoRetorno')
        .asFunction();

    _nfeInicializar!(arqConfig.toNativeUtf8(), chaveCrypt.toNativeUtf8());
  }

  void finalizar() {
    _nfeFinalizar!();
  }

  String nome() {
    Pointer<Utf8> sNome = calloc.allocate<Utf8>(BUFFER_LEN);
    Pointer<Int32> esTamanho = calloc<Int32>();
    esTamanho.value = BUFFER_LEN;

    _nfeNome!(sNome, esTamanho);
    String resposta = processResult(sNome, esTamanho);

    calloc.free(sNome);
    calloc.free(esTamanho);
    return resposta;
  }

  String versao() {
    Pointer<Utf8> sVersao = calloc.allocate<Utf8>(BUFFER_LEN);
    Pointer<Int32> esTamanho = calloc<Int32>();
    esTamanho.value = BUFFER_LEN;

    _nfeVersao!(sVersao, esTamanho);
    String resposta = processResult(sVersao, esTamanho);

    calloc.free(sVersao);
    calloc.free(esTamanho);
    return resposta;
  }

  void configLer(String eArqConfig) {
    _nfeConfigLer!(eArqConfig.toNativeUtf8());
  }

  void configGravar(String eArqConfig) {
    _nfeConfigGravar!(eArqConfig.toNativeUtf8());
  }

  String configLerValor(String eSessao, String eChave) {
    Pointer<Utf8> sValor = calloc.allocate<Utf8>(BUFFER_LEN);
    Pointer<Int32> esTamanho = calloc<Int32>();
    esTamanho.value = BUFFER_LEN;

    _nfeConfigLerValor!(eSessao.toNativeUtf8(), eChave.toNativeUtf8(), sValor, esTamanho);
    String resposta = processResult(sValor, esTamanho);

    calloc.free(sValor);
    calloc.free(esTamanho);
    return resposta;
  }

  void configGravarValor(String eSessao, String eChave, String sValor) {
    _nfeConfigGravarValor!(eSessao.toNativeUtf8(), eChave.toNativeUtf8(), sValor.toNativeUtf8());
  }

  void configImportar(String eArqConfig) {
    _nfeConfigImportar!(eArqConfig.toNativeUtf8());
  }

  String configExportar() {
    Pointer<Utf8> sValor = calloc.allocate<Utf8>(BUFFER_LEN);
    Pointer<Int32> esTamanho = calloc<Int32>();
    esTamanho.value = BUFFER_LEN;

    _nfeConfigExportar!(sValor, esTamanho);
    String resposta = processResult(sValor, esTamanho);

    calloc.free(sValor);
    calloc.free(esTamanho);
    return resposta;
  }

  void carregarXML(String eArquivoOuXML) {
    _nfeCarregarXML!(eArquivoOuXML.toNativeUtf8());
  }

  void carregarINI(String eArquivoOuINI) {
    _nfeCarregarINI!(eArquivoOuINI.toNativeUtf8());
  }

  String obterXml(int AIndex) {
    Pointer<Utf8> sMensagem = calloc.allocate<Utf8>(BUFFER_LEN);
    Pointer<Int32> esTamanho = calloc<Int32>();
    esTamanho.value = BUFFER_LEN;

    _nfeObterXml!(AIndex, sMensagem, esTamanho);
    String resposta = processResult(sMensagem, esTamanho);

    calloc.free(sMensagem);
    calloc.free(esTamanho);
    return resposta;
  }

  void gravarXml(int AIndex, String eNomeArquivo, String ePathArquivo) {
    _nfeGravarXml!(AIndex, eNomeArquivo.toNativeUtf8(), ePathArquivo.toNativeUtf8());
  }

  void carregarEventoXML(String eArquivoOuXML) {
    _nfeCarregarEventoXML!(eArquivoOuXML.toNativeUtf8());
  }

  void carregarEventoINI(String eArquivoOuXML) {
    _nfeCarregarEventoINI!(eArquivoOuXML.toNativeUtf8());
  }

  void limparLista() {
    _nfeLimparLista!();
  }

  void limparListaEventos() {
    _nfeLimparListaEventos!();
  }

  void assinar() {
    _nfeAssinar!();
  }

  void validar() {
    _nfeValidar!();
  }

  String validarRegrasdeNegocios() {
    Pointer<Utf8> sResposta = calloc.allocate<Utf8>(BUFFER_LEN);
    Pointer<Int32> esTamanho = calloc<Int32>();
    esTamanho.value = BUFFER_LEN;

    _nfeValidarRegrasdeNegocios!(sResposta, esTamanho);
    String resposta = processResult(sResposta, esTamanho);

    calloc.free(sResposta);
    calloc.free(esTamanho);
    return resposta;
  }

  String verificarAssinatura() {
    Pointer<Utf8> sResposta = calloc.allocate<Utf8>(BUFFER_LEN);
    Pointer<Int32> esTamanho = calloc<Int32>();
    esTamanho.value = BUFFER_LEN;

    _nfeVerificarAssinatura!(sResposta, esTamanho);
    String resposta = processResult(sResposta, esTamanho);

    calloc.free(sResposta);
    calloc.free(esTamanho);
    return resposta;
  }

  String gerarChave(int ACodigoUF, int ACodigoNumerico, int AModelo, int ASerie, int ANumero, int ATpEmi,
      String AEmissao, String ACNPJCPF) {
    Pointer<Utf8> sResposta = calloc.allocate<Utf8>(BUFFER_LEN);
    Pointer<Int32> esTamanho = calloc<Int32>();
    esTamanho.value = BUFFER_LEN;

    _nfeGerarChave!(ACodigoUF, ACodigoNumerico, AModelo, ASerie, ANumero, ATpEmi, AEmissao.toNativeUtf8(),
        ACNPJCPF.toNativeUtf8(), sResposta, esTamanho);
    String resposta = processResult(sResposta, esTamanho);

    calloc.free(sResposta);
    calloc.free(esTamanho);
    return resposta;
  }

  List<String> obterCertificados() {
    Pointer<Utf8> sResposta = calloc.allocate<Utf8>(BUFFER_LEN);
    Pointer<Int32> esTamanho = calloc<Int32>();
    esTamanho.value = BUFFER_LEN;

    _nfeObterCertificados!(sResposta, esTamanho);
    String resposta = processResult(sResposta, esTamanho);

    calloc.free(sResposta);
    calloc.free(esTamanho);
    return resposta.split("|");
  }

  String getPath(int ATipo) {
    Pointer<Utf8> sResposta = calloc.allocate<Utf8>(BUFFER_LEN);
    Pointer<Int32> esTamanho = calloc<Int32>();
    esTamanho.value = BUFFER_LEN;

    _nfeGetPath!(ATipo, sResposta, esTamanho);
    String resposta = processResult(sResposta, esTamanho);

    calloc.free(sResposta);
    calloc.free(esTamanho);
    return resposta;
  }

  String getPathEvento(String ACodEvento) {
    Pointer<Utf8> sResposta = calloc.allocate<Utf8>(BUFFER_LEN);
    Pointer<Int32> esTamanho = calloc<Int32>();
    esTamanho.value = BUFFER_LEN;

    _nfeGetPathEvento!(ACodEvento.toNativeUtf8(), sResposta, esTamanho);
    String resposta = processResult(sResposta, esTamanho);

    calloc.free(sResposta);
    calloc.free(esTamanho);
    return resposta;
  }

  String statusServico() {
    Pointer<Utf8> sResposta = calloc.allocate<Utf8>(BUFFER_LEN);
    Pointer<Int32> esTamanho = calloc<Int32>();
    esTamanho.value = BUFFER_LEN;

    _nfeStatusServico!(sResposta, esTamanho);
    String resposta = processResult(sResposta, esTamanho);

    calloc.free(sResposta);
    calloc.free(esTamanho);
    return resposta;
  }

  String consultar(String eChaveOuNFe) {
    Pointer<Utf8> sResposta = calloc.allocate<Utf8>(BUFFER_LEN);
    Pointer<Int32> esTamanho = calloc<Int32>();
    esTamanho.value = BUFFER_LEN;

    _nfeConsultar!(eChaveOuNFe.toNativeUtf8(), sResposta, esTamanho);
    String resposta = processResult(sResposta, esTamanho);

    calloc.free(sResposta);
    calloc.free(esTamanho);
    return resposta;
  }

  String inutilizar(
      String ACNPJ, String AJustificativa, int Ano, int Modelo, int Serie, int NumeroInicial, int NumeroFinal) {
    Pointer<Utf8> sResposta = calloc.allocate<Utf8>(BUFFER_LEN);
    Pointer<Int32> esTamanho = calloc<Int32>();
    esTamanho.value = BUFFER_LEN;

    _nfeInutilizar!(ACNPJ.toNativeUtf8(), AJustificativa.toNativeUtf8(), Ano, Modelo, Serie, NumeroInicial, NumeroFinal,
        sResposta, esTamanho);
    String resposta = processResult(sResposta, esTamanho);

    calloc.free(sResposta);
    calloc.free(esTamanho);
    return resposta;
  }

  String enviar(int ALote, bool Imprimir, bool Sincrono, bool Zipado) {
    Pointer<Utf8> sResposta = calloc.allocate<Utf8>(BUFFER_LEN);
    Pointer<Int32> esTamanho = calloc<Int32>();
    esTamanho.value = BUFFER_LEN;

    _nfeEnviar!(ALote, Imprimir, Sincrono, Zipado, sResposta, esTamanho);
    String resposta = processResult(sResposta, esTamanho);

    calloc.free(sResposta);
    calloc.free(esTamanho);
    return resposta;
  }

  String consultarRecibo(String ARecibo) {
    Pointer<Utf8> sResposta = calloc.allocate<Utf8>(BUFFER_LEN);
    Pointer<Int32> esTamanho = calloc<Int32>();
    esTamanho.value = BUFFER_LEN;

    _nfeConsultarRecibo!(ARecibo.toNativeUtf8(), sResposta, esTamanho);
    String resposta = processResult(sResposta, esTamanho);

    calloc.free(sResposta);
    calloc.free(esTamanho);
    return resposta;
  }

  String cancelar(String eChave, String eJustificativa, String eCNPJ, int ALote) {
    Pointer<Utf8> sResposta = calloc.allocate<Utf8>(BUFFER_LEN);
    Pointer<Int32> esTamanho = calloc<Int32>();
    esTamanho.value = BUFFER_LEN;

    _nfeCancelar!(
        eChave.toNativeUtf8(), eJustificativa.toNativeUtf8(), eCNPJ.toNativeUtf8(), ALote, sResposta, esTamanho);
    String resposta = processResult(sResposta, esTamanho);

    calloc.free(sResposta);
    calloc.free(esTamanho);
    return resposta;
  }

  String enviarEvento(int idLote) {
    Pointer<Utf8> sResposta = calloc.allocate<Utf8>(BUFFER_LEN);
    Pointer<Int32> esTamanho = calloc<Int32>();
    esTamanho.value = BUFFER_LEN;

    _nfeEnviarEvento!(idLote, sResposta, esTamanho);
    String resposta = processResult(sResposta, esTamanho);

    calloc.free(sResposta);
    calloc.free(esTamanho);
    return resposta;
  }

  String consultaCadastro(String cUF, String nDocumento, bool IsIE) {
    Pointer<Utf8> sResposta = calloc.allocate<Utf8>(BUFFER_LEN);
    Pointer<Int32> esTamanho = calloc<Int32>();
    esTamanho.value = BUFFER_LEN;

    _nfeConsultaCadastro!(cUF.toNativeUtf8(), nDocumento.toNativeUtf8(), IsIE, sResposta, esTamanho);
    String resposta = processResult(sResposta, esTamanho);

    calloc.free(sResposta);
    calloc.free(esTamanho);
    return resposta;
  }

  String distribuicaoDFePorUltNSU(int AcUFAutor, String eCNPJCPF, String eultNSU) {
    Pointer<Utf8> sResposta = calloc.allocate<Utf8>(BUFFER_LEN);
    Pointer<Int32> esTamanho = calloc<Int32>();
    esTamanho.value = BUFFER_LEN;

    _nfeDistribuicaoDFePorUltNSU!(AcUFAutor, eCNPJCPF.toNativeUtf8(), eultNSU.toNativeUtf8(), sResposta, esTamanho);
    String resposta = processResult(sResposta, esTamanho);

    calloc.free(sResposta);
    calloc.free(esTamanho);
    return resposta;
  }

  String distribuicaoDFePorNSU(int AcUFAutor, String eCNPJCPF, String eNSU) {
    Pointer<Utf8> sResposta = calloc.allocate<Utf8>(BUFFER_LEN);
    Pointer<Int32> esTamanho = calloc<Int32>();
    esTamanho.value = BUFFER_LEN;

    _nfeDistribuicaoDFePorNSU!(AcUFAutor, eCNPJCPF.toNativeUtf8(), eNSU.toNativeUtf8(), sResposta, esTamanho);
    String resposta = processResult(sResposta, esTamanho);

    calloc.free(sResposta);
    calloc.free(esTamanho);
    return resposta;
  }

  String distribuicaoDFePorChave(int AcUFAutor, String eCNPJCPF, String echNFe) {
    Pointer<Utf8> sResposta = calloc.allocate<Utf8>(BUFFER_LEN);
    Pointer<Int32> esTamanho = calloc<Int32>();
    esTamanho.value = BUFFER_LEN;

    _nfeDistribuicaoDFePorChave!(AcUFAutor, eCNPJCPF.toNativeUtf8(), echNFe.toNativeUtf8(), sResposta, esTamanho);
    String resposta = processResult(sResposta, esTamanho);

    calloc.free(sResposta);
    calloc.free(esTamanho);
    return resposta;
  }

  void enviarEmail(
      String ePara, String eXmlNFe, bool AEnviaPDF, String eAssunto, String eCC, String eAnexos, String eMensagem) {
    _nfeEnviarEmail!(ePara.toNativeUtf8(), eXmlNFe.toNativeUtf8(), AEnviaPDF, eAssunto.toNativeUtf8(),
        eCC.toNativeUtf8(), eAnexos.toNativeUtf8(), eMensagem.toNativeUtf8());
  }

  void enviarEmailEvento(String ePara, String eXmlEvento, String eXmlNFe, bool AEnviaPDF, String eAssunto, String eCC,
      String eAnexos, String eMensagem) {
    _nfeEnviarEmailEvento!(ePara.toNativeUtf8(), eXmlEvento.toNativeUtf8(), eXmlNFe.toNativeUtf8(), AEnviaPDF,
        eAssunto.toNativeUtf8(), eCC.toNativeUtf8(), eAnexos.toNativeUtf8(), eMensagem.toNativeUtf8());
  }

  void imprimir(String cImpressora, int nNumCopias, String cProtocolo, bool bMostrarPreview, bool cMarcaDagua,
      bool bViaConsumidor, bool bSimplificado) {
    String sMostrarPreview = bMostrarPreview ? '1' : '0';
    String sMarcaDagua = cMarcaDagua ? '1' : '0';
    String sViaConsumidor = bViaConsumidor ? '1' : '0';
    String sSimplificado = bSimplificado ? '1' : '0';

    _nfeImprimir!(cImpressora.toNativeUtf8(), nNumCopias, cProtocolo.toNativeUtf8(), sMostrarPreview.toNativeUtf8(),
        sMarcaDagua.toNativeUtf8(), sViaConsumidor.toNativeUtf8(), sSimplificado.toNativeUtf8());
  }

  void imprimirPDF() {
    _nfeImprimirPDF!();
  }

  void imprimirEvento(String eXmlNFe, String eXmlEvento) {
    _nfeImprimirEvento!(eXmlNFe.toNativeUtf8(), eXmlEvento.toNativeUtf8());
  }

  void imprimirEventoPDF(String eXmlNFe, String eXmlEvento) {
    _nfeImprimirEventoPDF!(eXmlNFe.toNativeUtf8(), eXmlEvento.toNativeUtf8());
  }

  void imprimirInutilizacao(String eXmlInutilizacao) {
    _nfeImprimirInutilizacao!(eXmlInutilizacao.toNativeUtf8());
  }

  void imprimirInutilizacaoPDF(String eXmlInutilizacao) {
    _nfeImprimirInutilizacaoPDF!(eXmlInutilizacao.toNativeUtf8());
  }

  // Define a função ProcessResult
  String processResult(Pointer<Utf8> buffer, Pointer<Int32> bufferLen) {
    if (bufferLen.value > BUFFER_LEN) {
      calloc.free(buffer);
      buffer = calloc.allocate<Utf8>(bufferLen.value);
      _nfeUltimoRetorno!(buffer, bufferLen);
    }
    return buffer.toDartString().trim();
  }
}
