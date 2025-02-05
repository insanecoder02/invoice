import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Persian (`fa`).
class AppLocalizationsFa extends AppLocalizations {
  AppLocalizationsFa([String locale = 'fa']) : super(locale);

  @override
  String get appName => 'فاکتور';

  @override
  String get language => 'زبان';

  @override
  String get selectLanguage => 'انتخاب زبان';

  @override
  String get switchToSystemTheme => 'تغییر به حالت سیستم';

  @override
  String get switchToDarkMode => 'تغییر به حالت شب';

  @override
  String get switchToLightMode => 'تغییر به حالت روز';

  @override
  String get dbError => 'خطایی در پایگاه داده رخ داده است.';

  @override
  String get checkNetwork => 'اتصال به شبکه اینترنت خود را بررسی کنید.';

  @override
  String get iUnderstand => 'متوجه ام';

  @override
  String get emptyData => 'داده ای یافت نشد.';

  @override
  String get name => 'نام';

  @override
  String get customerName => 'نام مشتری';

  @override
  String get categoryName => 'نام دسته';

  @override
  String get productName => 'نام محصول';

  @override
  String get discount => 'تخفیف';

  @override
  String get cashDiscount => 'تخفیف نقدی';

  @override
  String get volumeDiscount => 'تخفیف حجمی';

  @override
  String get discountPercent => 'درصد تخفیف';

  @override
  String get withoutDiscount => 'بدون تخفیف';

  @override
  String get address => 'آدرس';

  @override
  String get customerAddress => 'آدرس مشتری';

  @override
  String get withoutAddress => 'بدون آدرس';

  @override
  String get code => 'کد';

  @override
  String get productCode => 'کد محصول';

  @override
  String get title => 'مشخصات کالا';

  @override
  String get quantityInBox => 'تعداد در کارتن';

  @override
  String get quantityOfBoxes => 'تعداد کارتن';

  @override
  String get price => 'قیمت';

  @override
  String get productPrice => 'قیمت محصول';

  @override
  String get priceEach => 'فی هر';

  @override
  String get formError => 'خطایی در اعتبارسنجی فرم';

  @override
  String get successfulOperation => 'عملیات موفقیت آمیز';

  @override
  String get invoiceCreate => 'ثبت فاکتور';

  @override
  String get productCreate => 'ثبت محصول';

  @override
  String get categoryCreate => 'ثبت دسته';

  @override
  String get customerCreate => 'ثبت مشتری';

  @override
  String get invoiceEdit => 'ویرایش فاکتور';

  @override
  String get preinvoiceEdit => 'ویرایش پیش فاکتور';

  @override
  String get productEdit => 'ویرایش محصول';

  @override
  String get invoiceDelete => 'حذف فاکتور';

  @override
  String get categoryEdit => 'ویرایش دسته';

  @override
  String get customerEdit => 'ویرایش مشتری';

  @override
  String get requiredField => 'لطفا فیلد را پر کنید.';

  @override
  String get create => 'ثبت';

  @override
  String get edit => 'ویرایش';

  @override
  String get fetchDataError => 'خطا در بازیابی دیتا';

  @override
  String get tryAgain => 'تلاش مجدد';

  @override
  String areYouSure(Object subject) {
    return 'برای $subject اطمینان دارید؟';
  }

  @override
  String get delete => 'حذف';

  @override
  String get remove => 'حذف';

  @override
  String get removeForever => 'حذف برای همیشه';

  @override
  String get yes => 'بله';

  @override
  String get no => 'خیر';

  @override
  String get cancel => 'انصراف';

  @override
  String get ok => 'بله';

  @override
  String get noCategories => 'دسته بندی وجود ندارد.';

  @override
  String get noCustomers => 'مشتری وجود ندارد.';

  @override
  String get tapAddCategories => 'برای ایجاد دسته بندی، دکمه افزودن را ضربه بزنید.';

  @override
  String get tapAddCustomers => 'برای ایجاد مشتری، دکمه افزودن را ضربه بزنید.';

  @override
  String get noProducts => 'محصولی وجود ندارد.';

  @override
  String get tapAddProducts => 'برای ایجاد محصول، دکمه افزودن را ضربه بزنید.';

  @override
  String get noInvoices => 'فاکتوری وجود ندارد.';

  @override
  String get tapAddInvoice => 'برای ایجاد فاکتور، دکمه افزودن را ضربه بزنید.';

  @override
  String get noInvoiceProducts => 'محصولی وجود ندارد.';

  @override
  String get tapAddInvoiceProducts => 'برای ایجاد محصول، دکمه افزودن را ضربه بزنید.';

  @override
  String get bookmark => 'نشانه';

  @override
  String get bookmarks => 'نشانه ها';

  @override
  String get selected => 'انتخاب شده';

  @override
  String get newest => 'جدید ترین';

  @override
  String get oldest => 'قدیمی ترین';

  @override
  String get invoice => 'فاکتور';

  @override
  String get invoices => 'فاکتورها';

  @override
  String get preinvoice => 'پیش فاکتور';

  @override
  String get newProduct => 'محصول جدید';

  @override
  String get total => 'جمع کل';

  @override
  String get payable => 'قابل پرداخت';

  @override
  String get rial => 'ريال';

  @override
  String get category => 'دسته';

  @override
  String get categories => 'دسته بندی';

  @override
  String get productCategory => 'دسته محصول';

  @override
  String alreadyExisted(Object subject) {
    return 'این $subject قبلاً وجود داشته است.';
  }

  @override
  String get product => 'محصول';

  @override
  String get products => 'محصولات';

  @override
  String get withoutProduct => 'بدون محصول';

  @override
  String get descriptionForDeleteCategory => 'با حذف دسته تمامی محصولات آن دسته حذف خواهد شد و همینطور فاکتورهایی که محصولات آن ها حذف شده تغییر میکند';

  @override
  String get descriptionForDeleteProduct => 'با حذف محصول فاکتورهایی که این محصول را دارا بودند دچار تغییر میشوند';

  @override
  String get descriptionForDeleteCustomer => 'با حذف مشتری تمامی فاکتورهای آن مشتری حذف خواهد شد';

  @override
  String get volume => 'حجم';

  @override
  String get productVolume => 'حجم محصول';

  @override
  String get volumeUnit => 'واحد حجم';

  @override
  String get gram => 'گرم';

  @override
  String get cc => 'سی سی';

  @override
  String get numbers => 'عددی';

  @override
  String get newCustomer => 'مشتری جدید';

  @override
  String get registeredCustomer => 'مشتری ثبت نام شده';

  @override
  String get phone => 'تلفن';

  @override
  String get customers => 'مشتریان';

  @override
  String get discountDescription => 'فیلدهای تخفیف میتوانند خالی باشند که معادل صفر یا همان بدون تخفیف است.';

  @override
  String get nationalCode => 'کد ملی';

  @override
  String get latestInvoices => 'آخرین فاکتورهای ثبت شده یا ویرایش شده';

  @override
  String get withoutPreinvoiceOrInvoice => 'بدون پیش فاکتور یا فاکتور';

  @override
  String get settings => 'تنظیمات';

  @override
  String get productInformation => 'مشخصات محصول';

  @override
  String get box => 'کارتن';

  @override
  String get search => 'جستجو';

  @override
  String get noResultsFound => 'نتیجه ای یافت نشد';

  @override
  String get backup => 'پشتیبان گیری';

  @override
  String get restore => 'بازیابی داده';

  @override
  String get download => 'دانلود';

  @override
  String get downloadAndShare => 'دانلود و اشتراک';

  @override
  String get share => 'اشتراک';

  @override
  String get error => 'خطایی رخ داده مجدد تلاش کنید.';

  @override
  String get successfulRestore => 'بازیابی داده با موفقیت صورت گرفت.';

  @override
  String get selectFile => 'انتخاب فایل';

  @override
  String get backupDescription => 'در این بخش میتوانید از داده های خود پشتیبان گیری کنید که در صورت نیاز این داده ها را بازیابی کنید, پیشنهاد ما این هست که پشتیبان گیری را به صورت دوره ای انجام دهید تا در صورت بروز خطا یا پاک شدن برنامه داده های شما از بین نرود.';

  @override
  String get restoreDescription => 'فایل هایی را که تحت عنوان پشتیبان گیری با پسوند db ذخیره کردید را برای بازیابی داده ها انتخاب کنید, توجه داشته باشید که پس از بازیابی داده ها اطلاعات فعلی شما حذف خواهد شد.';

  @override
  String get noProduct => 'چنین محصولی وجود ندارد.';

  @override
  String get invoiceDescription => 'توضیحات فاکتور';

  @override
  String get description => 'توضیحات';

  @override
  String bookmarked(Object subject) {
    return '$subject نشانه گذاری شد';
  }

  @override
  String unBookmarked(Object subject) {
    return 'نشانه گذاری $subject حذف شد';
  }

  @override
  String get noBookmark => 'نشانه ای وجود ندارد.';

  @override
  String get invalidLengthField => 'تعداد کاراکتر های فیلد صحیح نیست.';

  @override
  String get onlyInvoice => 'فقط فاکتور';

  @override
  String get onlyPreinvoic => 'فقط پیش فاکتور';

  @override
  String get official => 'رسمی';

  @override
  String get unofficial => 'غیر رسمی';

  @override
  String get options => 'گزینه ها';

  @override
  String get invoiceDate => 'تاریخ فاکتور';

  @override
  String get invoiceNumber => 'شماره فاکتور';

  @override
  String get customerNationalCode => 'کد ملی مشتری';

  @override
  String get customerPhone => 'تلفن مشتری';

  @override
  String get colorInvoice => 'فاکتور رنگی';

  @override
  String get termsOfSale => 'شرایط فروش';

  @override
  String get invoiceHints => 'نکات فاکتور';

  @override
  String get signers => 'امضا کنندگان';

  @override
  String get details => 'جزئیات';

  @override
  String get invoiceDetails => 'جزئیات فاکتور';

  @override
  String get customer => 'مشتری';

  @override
  String get invoiceRegistration => 'تاریخ ثبت';

  @override
  String get dateLastEdit => 'تاریخ آخرین ویرایش';

  @override
  String get enterYourPasscode => 'گذرواژه خود را وارد کنید';

  @override
  String get enterPasscode => 'ورود گذرواژه';

  @override
  String get enterYourPasscodeDescription => 'لطفا گذرواژه فعلی خود را برای مدیریت این تنظیمات وارد کنید.';

  @override
  String get signInTitle => 'احراز هویت لازم است.';

  @override
  String get biometricHint => 'تایید هویت';

  @override
  String get fingerprintDescription => 'اثر انگشت خود (یا چهره یا هر چیز دیگری) را برای احراز هویت اسکن کنید.';

  @override
  String get security => 'امنیت';

  @override
  String get enablePasscode => 'فعال کردن گذرواژه';

  @override
  String get lockWithPasscode => 'قفل با گذرواژه';

  @override
  String get lockWithPasscodeDescription => 'هنگامی که یک گذرواژه تنظیم شود, یک آیکون قفل در صفحه اول برنامه شما ظاهر می شود, برای قفل کردن برنامه روی آن بزنید.';

  @override
  String passcodeDescription(Object number) {
    return 'یک گذرواژه $number رقمی ایجاد کنید که بتوانید آن را به خاطر بسپارید.';
  }

  @override
  String get createPasscode => 'ثبت گذرواژه';

  @override
  String get reEnterYourPasscode => 'تکرار گذرواژه';

  @override
  String get reEnterYourPasscodeDescription => 'اگر گذرواژه را فراموش کردید، امکان بازیابی آن وجود ندارد و باید برنامه را دوباره نصب کنید.';

  @override
  String get noMatchPasscode => 'گذرواژه‌ها مطابقت ندارند.';

  @override
  String get lockSettings => 'تنظیمات قفل';

  @override
  String get changePasscode => 'تغییر گذرواژه';

  @override
  String get newPasscode => 'گذرواژه جدید';

  @override
  String get passcodeInvalid => 'گذرواژه نامعتبر است.';

  @override
  String get enable => 'فعال';

  @override
  String get disable => 'غیرفعال';

  @override
  String get disablePasscode => 'غیر فعال کردن گذرواژه';

  @override
  String get lockConfigDescription => 'برای قفل کردن برنامه, بر روی آیکون قفل در بالای صفحه اول برنامه بزنید.';

  @override
  String get unlockWithFingerprint => 'باز کردن قفل با اثر انگشت';

  @override
  String get automaticLock => 'قفل خودکار';

  @override
  String get autoLockDescription => 'در صورت ورود نکردن مجدد به برنامه به مدت زمان مشخص از شما گذرواژه خواسته می شود.';

  @override
  String get confirm => 'تایید';

  @override
  String get minutes => 'دقیقه';

  @override
  String get hour => 'ساعت';

  @override
  String get hours => 'ساعت';

  @override
  String get within => 'ظرف';

  @override
  String get helperTextforPrice => 'تغییر در فیلد فی هر فقط برای فاکتور فعلی اعمال میشود.';

  @override
  String get tooManyTries => 'دفعات بسیار زیادی امتحان کردید.';

  @override
  String tooManyTriesCornometer(Object number) {
    return 'لطفا $number ثانیه دیگر دوباره تلاش کنید.';
  }

  @override
  String get forgotPasscode => 'گذرواژه را فراموش کرده اید؟';

  @override
  String get forgotPasscodeDescription => 'اگر گذرواژه را فراموش کرده اید، لطفاً برنامه را حذف و نصب مجدد کنید، متأسفانه داده های شما حذف می شوند.';

  @override
  String get fakeData => 'داده های فیک';
}
