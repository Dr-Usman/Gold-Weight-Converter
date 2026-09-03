// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'Conversor de Peso de Oro';

  @override
  String get validationValidNumber => 'Por favor ingrese un número válido';

  @override
  String get validationPositiveNumber => 'Por favor ingrese un número positivo';

  @override
  String get tolaLabel => 'Tola';

  @override
  String get tolaInfo => '1 Tola = 11,66 gramos = 12 Masha = 16 Ana = 96 Ratti';

  @override
  String get tolaHint => 'ej. 2.5';

  @override
  String get tolaSemanticLabel => 'Campo de entrada de peso en Tola';

  @override
  String get mashaLabel => 'Masha';

  @override
  String get mashaInfo => '1 Masha = 0,972 gramos = 1,333 Ana = 8 Ratti';

  @override
  String get mashaHint => 'ej. 12.5';

  @override
  String get mashaSemanticLabel => 'Campo de entrada de peso en Masha';

  @override
  String get anaLabel => 'Ana';

  @override
  String get anaInfo => '1 Ana = 0,72875 gramos = 6 Ratti';

  @override
  String get anaHint => 'ej. 16.25';

  @override
  String get anaSemanticLabel => 'Campo de entrada de peso en Ana';

  @override
  String get rattiLabel => 'Ratti';

  @override
  String get rattiInfo => '1 Ratti = 0,1215 gramos';

  @override
  String get rattiHint => 'ej. 96.75';

  @override
  String get rattiSemanticLabel => 'Campo de entrada de peso en Ratti';

  @override
  String get lalLabel => 'Lal';

  @override
  String get lalInfo => '1 Lal = 0.1166 grams = 0.01 Tola (100 Lal = 1 Tola)';

  @override
  String get lalHint => 'e.g. 25';

  @override
  String get lalSemanticLabel => 'Lal weight input field';

  @override
  String get gramLabel => 'Gramo';

  @override
  String get gramInfo => 'Entrada directa en gramos';

  @override
  String get gramHint => 'ej. 11.66';

  @override
  String get gramSemanticLabel => 'Campo de entrada de peso en gramos';

  @override
  String get goldRateLabel => 'Precio del Oro';

  @override
  String get goldRateInfo => 'Precio actual de mercado por unidad';

  @override
  String get goldRateHint => 'ej. 150,000';

  @override
  String get goldRateSemanticLabel => 'Campo de entrada del precio del oro';

  @override
  String get calculateButton => 'Calcular';

  @override
  String get calculateSemanticLabel => 'Calcular la conversión del peso de oro';

  @override
  String get clearAllButton => 'Borrar Todo';

  @override
  String get clearAllSemanticLabel => 'Borrar todos los campos de entrada';

  @override
  String get conversionDetails => 'Detalles de la Conversión';

  @override
  String tolaConversion(String value, String factor, String result) {
    return 'Tola: $value × $factor = $result gramos';
  }

  @override
  String mashaConversion(String value, String factor, String result) {
    return 'Masha: $value × $factor = $result gramos';
  }

  @override
  String anaConversion(String value, String factor, String result) {
    return 'Ana: $value × $factor = $result gramos';
  }

  @override
  String rattiConversion(String value, String factor, String result) {
    return 'Ratti: $value × $factor = $result gramos';
  }

  @override
  String lalConversion(String value, String factor, String result) {
    return 'Lal: $value × $factor = $result grams';
  }

  @override
  String gramConversion(String value) {
    return 'Gramo: $value gramos';
  }

  @override
  String totalWeight(String value) {
    return 'Peso Total: $value gramos';
  }

  @override
  String get convertedTo => 'Convertido a:';

  @override
  String tolaResult(String value) {
    return 'Tola: $value';
  }

  @override
  String lalResult(String value) {
    return 'Lal: $value';
  }

  @override
  String mashaResult(String value) {
    return 'Masha: $value';
  }

  @override
  String anaResult(String value) {
    return 'Ana: $value';
  }

  @override
  String rattiResult(String value) {
    return 'Ratti: $value';
  }

  @override
  String goldPrice(String price) {
    return 'Valor del Oro: $price';
  }

  @override
  String rateInfo(String rate, String unit) {
    return '(Precio: $rate por $unit)';
  }

  @override
  String get unitTola => 'Tola';

  @override
  String get unitLal => 'Lal';

  @override
  String get unitTenGram => '10 Gramos';

  @override
  String get unitOneGram => '1 Gramo';

  @override
  String enterValueHint(String label) {
    return 'Ingrese el valor de $label';
  }

  @override
  String inputFieldSemantic(String label) {
    return 'Campo de entrada $label';
  }

  @override
  String unitSelectorSemantic(String label) {
    return 'Selector de unidad $label';
  }

  @override
  String get converterTabLabel => 'Conversor';

  @override
  String get settingsTabLabel => 'Ajustes';

  @override
  String get settingsTitle => 'Ajustes';

  @override
  String get settingsThemeLabel => 'Tema';

  @override
  String get themeLight => 'Claro';

  @override
  String get themeDark => 'Oscuro';

  @override
  String get darkModeLabel => 'Modo Oscuro';

  @override
  String get darkModeSubtitle => 'Cambiar entre temas oscuro y claro';

  @override
  String get themeSystem => 'Sistema';

  @override
  String get settingsLanguageLabel => 'Idioma';

  @override
  String get settingsCurrencyLabel => 'Moneda';

  @override
  String get currencySelectionPrompt => 'Seleccione su moneda';

  @override
  String get currencySearchHint => 'Buscar por código, nombre o símbolo';

  @override
  String get currencySearchEmpty => 'No hay monedas coincidentes';

  @override
  String get languageSelectionPrompt => 'Por favor seleccione su idioma';

  @override
  String get languageEnglish => 'Inglés';

  @override
  String get languageUrdu => 'Urdu';

  @override
  String get languageArabic => 'Árabe';

  @override
  String get languageHindi => 'Hindi';

  @override
  String get languageTurkish => 'Turco';

  @override
  String get languageNote => 'Más idiomas próximamente';

  @override
  String get settingsAboutLabel => 'Acerca de';

  @override
  String get aboutVersion => 'Versión';

  @override
  String get aboutDescription =>
      'Gold Weight Converter es una herramienta simple y eficiente para convertir entre unidades de peso de oro tradicionales y gramos.';

  @override
  String get unknownLabel => 'Desconocido';

  @override
  String get zakatMenuLabel => 'Zakat del Oro';

  @override
  String get zakatScreenTitle => 'Zakat del Oro';

  @override
  String get zakatDisclaimer =>
      'Ayuda solo para artículos de oro — no es una evaluación completa del zakat ni un dictamen religioso. Otros activos y el nisab son su responsabilidad; consulte a un erudito local.';

  @override
  String get zakatRateInfo =>
      'Precio de mercado para oro de 24K / puro por unidad';

  @override
  String get zakatItemsTitle => 'Sus artículos de oro';

  @override
  String get zakatAddItem => 'Agregar artículo';

  @override
  String get zakatEditItem => 'Editar artículo';

  @override
  String get zakatEmptyItems =>
      'Aún no hay artículos de oro. Agregue joyas o lingotes para calcular el zakat.';

  @override
  String get zakatItemNameLabel => 'Nombre (opcional)';

  @override
  String get zakatItemNameHint => 'ej. Anillo de bodas';

  @override
  String get zakatWeightLabel => 'Peso';

  @override
  String get zakatWeightHint => 'ej. 10';

  @override
  String get zakatWeightUnitLabel => 'Unidad';

  @override
  String get zakatPurityLabel => 'Pureza (Quilates)';

  @override
  String get zakatCustomKaratLabel => 'Quilates personalizados (1–24)';

  @override
  String get zakatCustomKaratHint => 'ej. 20';

  @override
  String get zakatPurity24k => '24K (puro)';

  @override
  String get zakatPurity22k => '22K';

  @override
  String get zakatPurity21k => '21K';

  @override
  String get zakatPurity18k => '18K';

  @override
  String get zakatPurityCustom => 'Personalizado';

  @override
  String get zakatSaveItem => 'Guardar';

  @override
  String get zakatDeleteItem => 'Eliminar';

  @override
  String get zakatDeleteConfirmTitle => '¿Eliminar artículo de oro?';

  @override
  String zakatDeleteConfirmMessage(String name) {
    return 'Esto eliminará \"$name\" de su lista de zakat.';
  }

  @override
  String get zakatCancel => 'Cancelar';

  @override
  String get zakatUntitledItem => 'Artículo de oro';

  @override
  String get zakatSummaryTitle => 'Resumen del Zakat';

  @override
  String get zakatTotalPureGold => 'Total de oro puro';

  @override
  String zakatPureGoldValue(String grams, String tola) {
    return '$grams g ($tola tola)';
  }

  @override
  String get zakatTotalValue => 'Valor estimado';

  @override
  String get zakatDueLabel => 'Zakat a pagar (2,5%)';

  @override
  String get zakatEnterRatePrompt =>
      'Ingrese el precio del oro para estimar el valor y el zakat';

  @override
  String get zakatCalculateButton => 'Calcular zakat';

  @override
  String zakatItemDetail(String weight, String unit, String purity) {
    return '$weight $unit · $purity';
  }

  @override
  String get zakatValidationWeight => 'Ingrese un peso mayor a cero';

  @override
  String get zakatValidationKarat => 'Ingrese quilates entre 1 y 24';

  @override
  String get copyResults => 'Copiar';

  @override
  String get shareResults => 'Compartir';

  @override
  String get resultsCopied => 'Copiado al portapapeles';

  @override
  String get privacyPolicyLabel => 'Política de privacidad';

  @override
  String get rateAppLabel => 'Calificar la aplicación';

  @override
  String get moreAppsLabel => 'Más aplicaciones';

  @override
  String get shareAppLabel => 'Compartir la aplicación';

  @override
  String shareAppMessage(String url) {
    return 'Pruebe el conversor de peso de oro: $url';
  }

  @override
  String get openLinkFailed => 'No se pudo abrir el enlace';

  @override
  String get appUpdateReady =>
      'Actualización descargada. Reinicie para instalar.';

  @override
  String get appUpdateRestart => 'Reiniciar';
}
