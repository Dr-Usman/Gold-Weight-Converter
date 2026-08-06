import '../models/app_currency.dart';

class Currencies {
  static const AppCurrency inr = AppCurrency(
    code: 'INR',
    name: 'Indian Rupee',
    symbol: '₹',
    locale: 'en_IN',
  );

  /// Edit this list to add/remove supported display currencies.
  ///
  /// Ordered by Play Store audience volume (highest first).
  /// Currency is display-only (formats gold price / zakat); there is no FX conversion.
  static const List<AppCurrency> supportedCurrencies = [
    inr,
    AppCurrency(
      code: 'PKR',
      name: 'Pakistani Rupee',
      symbol: 'Rs. ',
      locale: 'en_PK',
    ),
    AppCurrency(
      code: 'BDT',
      name: 'Bangladeshi Taka',
      symbol: '৳',
      locale: 'en_BD',
    ),
    AppCurrency(code: 'USD', name: 'US Dollar', symbol: '\$', locale: 'en_US'),
    AppCurrency(
      code: 'ETB',
      name: 'Ethiopian Birr',
      symbol: 'Br ',
      locale: 'en_ET',
    ),
    AppCurrency(
      code: 'NPR',
      name: 'Nepalese Rupee',
      symbol: 'Rs. ',
      locale: 'en_NP',
    ),
    AppCurrency(
      code: 'GHS',
      name: 'Ghanaian Cedi',
      symbol: 'GH₵',
      locale: 'en_GH',
    ),
    AppCurrency(
      code: 'PHP',
      name: 'Philippine Peso',
      symbol: '₱',
      locale: 'en_PH',
    ),
    AppCurrency(
      code: 'SAR',
      name: 'Saudi Riyal',
      symbol: 'SAR ',
      locale: 'en_SA',
    ),
    AppCurrency(
      code: 'MMK',
      name: 'Myanmar Kyat',
      symbol: 'K ',
      locale: 'en_MM',
    ),
    AppCurrency(
      code: 'GBP',
      name: 'British Pound',
      symbol: '£',
      locale: 'en_GB',
    ),
    AppCurrency(
      code: 'LKR',
      name: 'Sri Lankan Rupee',
      symbol: 'Rs. ',
      locale: 'en_LK',
    ),
    AppCurrency(
      code: 'MYR',
      name: 'Malaysian Ringgit',
      symbol: 'RM ',
      locale: 'en_MY',
    ),
    AppCurrency(
      code: 'ZAR',
      name: 'South African Rand',
      symbol: 'R ',
      locale: 'en_ZA',
    ),
    AppCurrency(
      code: 'NGN',
      name: 'Nigerian Naira',
      symbol: '₦',
      locale: 'en_NG',
    ),
    AppCurrency(
      code: 'QAR',
      name: 'Qatari Riyal',
      symbol: 'QAR ',
      locale: 'en_QA',
    ),
    AppCurrency(code: 'EUR', name: 'Euro', symbol: '€', locale: 'en'),
    AppCurrency(
      code: 'AFN',
      name: 'Afghan Afghani',
      symbol: '؋',
      locale: 'en_AF',
    ),
    AppCurrency(
      code: 'AUD',
      name: 'Australian Dollar',
      symbol: 'A\$',
      locale: 'en_AU',
    ),
    AppCurrency(
      code: 'IRR',
      name: 'Iranian Rial',
      symbol: '﷼',
      locale: 'fa_IR',
    ),
    AppCurrency(
      code: 'KES',
      name: 'Kenyan Shilling',
      symbol: 'KSh ',
      locale: 'en_KE',
    ),
    AppCurrency(
      code: 'SLE',
      name: 'Sierra Leonean Leone',
      symbol: 'Le ',
      locale: 'en_SL',
    ),
    AppCurrency(
      code: 'AED',
      name: 'UAE Dirham',
      symbol: 'AED ',
      locale: 'en_AE',
    ),
    AppCurrency(
      code: 'EGP',
      name: 'Egyptian Pound',
      symbol: 'E£',
      locale: 'en_EG',
    ),
    AppCurrency(
      code: 'IDR',
      name: 'Indonesian Rupiah',
      symbol: 'Rp ',
      locale: 'id_ID',
    ),
    AppCurrency(
      code: 'JPY',
      name: 'Japanese Yen',
      symbol: '¥',
      locale: 'ja_JP',
    ),
    AppCurrency(
      code: 'KWD',
      name: 'Kuwaiti Dinar',
      symbol: 'KD ',
      locale: 'en_KW',
    ),
    AppCurrency(
      code: 'CAD',
      name: 'Canadian Dollar',
      symbol: 'CA\$',
      locale: 'en_CA',
    ),
    AppCurrency(code: 'THB', name: 'Thai Baht', symbol: '฿', locale: 'th_TH'),
    AppCurrency(
      code: 'OMR',
      name: 'Omani Rial',
      symbol: 'OMR ',
      locale: 'en_OM',
    ),
    AppCurrency(
      code: 'HKD',
      name: 'Hong Kong Dollar',
      symbol: 'HK\$',
      locale: 'en_HK',
    ),
    AppCurrency(
      code: 'SGD',
      name: 'Singapore Dollar',
      symbol: 'S\$',
      locale: 'en_SG',
    ),
    AppCurrency(
      code: 'TRY',
      name: 'Turkish Lira',
      symbol: '₺',
      locale: 'tr_TR',
    ),
    AppCurrency(
      code: 'BHD',
      name: 'Bahraini Dinar',
      symbol: 'BD ',
      locale: 'en_BH',
    ),
    AppCurrency(
      code: 'CNY',
      name: 'Chinese Yuan',
      symbol: '¥',
      locale: 'zh_CN',
    ),
    AppCurrency(
      code: 'CHF',
      name: 'Swiss Franc',
      symbol: 'CHF ',
      locale: 'en_CH',
    ),
  ];
}
