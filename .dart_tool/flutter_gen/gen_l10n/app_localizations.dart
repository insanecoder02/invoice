import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_fa.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'gen_l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('fa')
  ];

  /// This is name application
  ///
  /// In en, this message translates to:
  /// **'Invoice'**
  String get appName;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @selectLanguage.
  ///
  /// In en, this message translates to:
  /// **'Select language'**
  String get selectLanguage;

  /// No description provided for @switchToSystemTheme.
  ///
  /// In en, this message translates to:
  /// **'Switch to system theme'**
  String get switchToSystemTheme;

  /// No description provided for @switchToDarkMode.
  ///
  /// In en, this message translates to:
  /// **'Switch to dark mode'**
  String get switchToDarkMode;

  /// No description provided for @switchToLightMode.
  ///
  /// In en, this message translates to:
  /// **'Switch to light mode'**
  String get switchToLightMode;

  /// No description provided for @dbError.
  ///
  /// In en, this message translates to:
  /// **'An error occurred in the database.'**
  String get dbError;

  /// No description provided for @checkNetwork.
  ///
  /// In en, this message translates to:
  /// **'Check your internet connection.'**
  String get checkNetwork;

  /// No description provided for @iUnderstand.
  ///
  /// In en, this message translates to:
  /// **'I understand'**
  String get iUnderstand;

  /// No description provided for @emptyData.
  ///
  /// In en, this message translates to:
  /// **'No data found.'**
  String get emptyData;

  /// No description provided for @name.
  ///
  /// In en, this message translates to:
  /// **'name'**
  String get name;

  /// No description provided for @customerName.
  ///
  /// In en, this message translates to:
  /// **'Customer name'**
  String get customerName;

  /// No description provided for @categoryName.
  ///
  /// In en, this message translates to:
  /// **'Category name'**
  String get categoryName;

  /// No description provided for @productName.
  ///
  /// In en, this message translates to:
  /// **'Product name'**
  String get productName;

  /// No description provided for @discount.
  ///
  /// In en, this message translates to:
  /// **'Discount'**
  String get discount;

  /// No description provided for @cashDiscount.
  ///
  /// In en, this message translates to:
  /// **'Cash discount'**
  String get cashDiscount;

  /// No description provided for @volumeDiscount.
  ///
  /// In en, this message translates to:
  /// **'Volume discount'**
  String get volumeDiscount;

  /// No description provided for @discountPercent.
  ///
  /// In en, this message translates to:
  /// **'Discount percent'**
  String get discountPercent;

  /// No description provided for @withoutDiscount.
  ///
  /// In en, this message translates to:
  /// **'Without discount'**
  String get withoutDiscount;

  /// No description provided for @address.
  ///
  /// In en, this message translates to:
  /// **'Address'**
  String get address;

  /// No description provided for @customerAddress.
  ///
  /// In en, this message translates to:
  /// **'Customer address'**
  String get customerAddress;

  /// No description provided for @withoutAddress.
  ///
  /// In en, this message translates to:
  /// **'Without address'**
  String get withoutAddress;

  /// No description provided for @code.
  ///
  /// In en, this message translates to:
  /// **'Code'**
  String get code;

  /// No description provided for @productCode.
  ///
  /// In en, this message translates to:
  /// **'Product code'**
  String get productCode;

  /// No description provided for @title.
  ///
  /// In en, this message translates to:
  /// **'Product info'**
  String get title;

  /// No description provided for @quantityInBox.
  ///
  /// In en, this message translates to:
  /// **'Quantity in box'**
  String get quantityInBox;

  /// No description provided for @quantityOfBoxes.
  ///
  /// In en, this message translates to:
  /// **'Number of boxes'**
  String get quantityOfBoxes;

  /// No description provided for @price.
  ///
  /// In en, this message translates to:
  /// **'Price'**
  String get price;

  /// No description provided for @productPrice.
  ///
  /// In en, this message translates to:
  /// **'Product price'**
  String get productPrice;

  /// No description provided for @priceEach.
  ///
  /// In en, this message translates to:
  /// **'Price each'**
  String get priceEach;

  /// No description provided for @formError.
  ///
  /// In en, this message translates to:
  /// **'Error in validating the form.'**
  String get formError;

  /// No description provided for @successfulOperation.
  ///
  /// In en, this message translates to:
  /// **'Successful Operation'**
  String get successfulOperation;

  /// No description provided for @invoiceCreate.
  ///
  /// In en, this message translates to:
  /// **'Invoice create'**
  String get invoiceCreate;

  /// No description provided for @productCreate.
  ///
  /// In en, this message translates to:
  /// **'Create product'**
  String get productCreate;

  /// No description provided for @categoryCreate.
  ///
  /// In en, this message translates to:
  /// **'Create category'**
  String get categoryCreate;

  /// No description provided for @customerCreate.
  ///
  /// In en, this message translates to:
  /// **'Create customer'**
  String get customerCreate;

  /// No description provided for @invoiceEdit.
  ///
  /// In en, this message translates to:
  /// **'Invoice edit'**
  String get invoiceEdit;

  /// No description provided for @preinvoiceEdit.
  ///
  /// In en, this message translates to:
  /// **'Preinvoice edit'**
  String get preinvoiceEdit;

  /// No description provided for @productEdit.
  ///
  /// In en, this message translates to:
  /// **'Edit product'**
  String get productEdit;

  /// No description provided for @invoiceDelete.
  ///
  /// In en, this message translates to:
  /// **'Invoice delete'**
  String get invoiceDelete;

  /// No description provided for @categoryEdit.
  ///
  /// In en, this message translates to:
  /// **'Edit category'**
  String get categoryEdit;

  /// No description provided for @customerEdit.
  ///
  /// In en, this message translates to:
  /// **'Edit customer'**
  String get customerEdit;

  /// No description provided for @requiredField.
  ///
  /// In en, this message translates to:
  /// **'Please fill in field.'**
  String get requiredField;

  /// No description provided for @create.
  ///
  /// In en, this message translates to:
  /// **'Create'**
  String get create;

  /// No description provided for @edit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get edit;

  /// No description provided for @fetchDataError.
  ///
  /// In en, this message translates to:
  /// **'Error in data fetch.'**
  String get fetchDataError;

  /// No description provided for @tryAgain.
  ///
  /// In en, this message translates to:
  /// **'Try again'**
  String get tryAgain;

  /// No description provided for @areYouSure.
  ///
  /// In en, this message translates to:
  /// **'Are you sure for {subject}?'**
  String areYouSure(Object subject);

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @remove.
  ///
  /// In en, this message translates to:
  /// **'Remove'**
  String get remove;

  /// No description provided for @removeForever.
  ///
  /// In en, this message translates to:
  /// **'Remove forever'**
  String get removeForever;

  /// No description provided for @yes.
  ///
  /// In en, this message translates to:
  /// **'Yes'**
  String get yes;

  /// No description provided for @no.
  ///
  /// In en, this message translates to:
  /// **'No'**
  String get no;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @ok.
  ///
  /// In en, this message translates to:
  /// **'Ok'**
  String get ok;

  /// No description provided for @noCategories.
  ///
  /// In en, this message translates to:
  /// **'No categories'**
  String get noCategories;

  /// No description provided for @noCustomers.
  ///
  /// In en, this message translates to:
  /// **'No customers'**
  String get noCustomers;

  /// No description provided for @tapAddCategories.
  ///
  /// In en, this message translates to:
  /// **'Tap the Add button to create a category.'**
  String get tapAddCategories;

  /// No description provided for @tapAddCustomers.
  ///
  /// In en, this message translates to:
  /// **'Tap the Add button to create a customer.'**
  String get tapAddCustomers;

  /// No description provided for @noProducts.
  ///
  /// In en, this message translates to:
  /// **'No products'**
  String get noProducts;

  /// No description provided for @tapAddProducts.
  ///
  /// In en, this message translates to:
  /// **'Tap the Add button to create a product.'**
  String get tapAddProducts;

  /// No description provided for @noInvoices.
  ///
  /// In en, this message translates to:
  /// **'No invoices'**
  String get noInvoices;

  /// No description provided for @tapAddInvoice.
  ///
  /// In en, this message translates to:
  /// **'Tap the Add button to create a invoice.'**
  String get tapAddInvoice;

  /// No description provided for @noInvoiceProducts.
  ///
  /// In en, this message translates to:
  /// **'No products'**
  String get noInvoiceProducts;

  /// No description provided for @tapAddInvoiceProducts.
  ///
  /// In en, this message translates to:
  /// **'Tap the Add button to create a products.'**
  String get tapAddInvoiceProducts;

  /// No description provided for @bookmark.
  ///
  /// In en, this message translates to:
  /// **'Bookmark'**
  String get bookmark;

  /// No description provided for @bookmarks.
  ///
  /// In en, this message translates to:
  /// **'Bookmarks'**
  String get bookmarks;

  /// No description provided for @selected.
  ///
  /// In en, this message translates to:
  /// **'Selected'**
  String get selected;

  /// No description provided for @newest.
  ///
  /// In en, this message translates to:
  /// **'Newest'**
  String get newest;

  /// No description provided for @oldest.
  ///
  /// In en, this message translates to:
  /// **'Oldest'**
  String get oldest;

  /// No description provided for @invoice.
  ///
  /// In en, this message translates to:
  /// **'Invoice'**
  String get invoice;

  /// No description provided for @invoices.
  ///
  /// In en, this message translates to:
  /// **'Invoices'**
  String get invoices;

  /// No description provided for @preinvoice.
  ///
  /// In en, this message translates to:
  /// **'Preinvoice'**
  String get preinvoice;

  /// No description provided for @newProduct.
  ///
  /// In en, this message translates to:
  /// **'New product'**
  String get newProduct;

  /// No description provided for @total.
  ///
  /// In en, this message translates to:
  /// **'Total'**
  String get total;

  /// No description provided for @payable.
  ///
  /// In en, this message translates to:
  /// **'Payable'**
  String get payable;

  /// No description provided for @rial.
  ///
  /// In en, this message translates to:
  /// **'Rial'**
  String get rial;

  /// No description provided for @category.
  ///
  /// In en, this message translates to:
  /// **'Category'**
  String get category;

  /// No description provided for @categories.
  ///
  /// In en, this message translates to:
  /// **'Categories'**
  String get categories;

  /// No description provided for @productCategory.
  ///
  /// In en, this message translates to:
  /// **'Product category'**
  String get productCategory;

  /// No description provided for @alreadyExisted.
  ///
  /// In en, this message translates to:
  /// **'Such a {subject} already existed.'**
  String alreadyExisted(Object subject);

  /// No description provided for @product.
  ///
  /// In en, this message translates to:
  /// **'Product'**
  String get product;

  /// No description provided for @products.
  ///
  /// In en, this message translates to:
  /// **'Products'**
  String get products;

  /// No description provided for @withoutProduct.
  ///
  /// In en, this message translates to:
  /// **'Without product'**
  String get withoutProduct;

  /// No description provided for @descriptionForDeleteCategory.
  ///
  /// In en, this message translates to:
  /// **'By deleting a category, all the products of that category will be deleted, and the invoices whose products have been deleted will also change'**
  String get descriptionForDeleteCategory;

  /// No description provided for @descriptionForDeleteProduct.
  ///
  /// In en, this message translates to:
  /// **'By removing the product, the invoices that had this product will change'**
  String get descriptionForDeleteProduct;

  /// No description provided for @descriptionForDeleteCustomer.
  ///
  /// In en, this message translates to:
  /// **'By deleting the customer, all the invoices of that customer will be deleted'**
  String get descriptionForDeleteCustomer;

  /// No description provided for @volume.
  ///
  /// In en, this message translates to:
  /// **'Volume'**
  String get volume;

  /// No description provided for @productVolume.
  ///
  /// In en, this message translates to:
  /// **'Product volume'**
  String get productVolume;

  /// No description provided for @volumeUnit.
  ///
  /// In en, this message translates to:
  /// **'Volume unit'**
  String get volumeUnit;

  /// No description provided for @gram.
  ///
  /// In en, this message translates to:
  /// **'Gram'**
  String get gram;

  /// No description provided for @cc.
  ///
  /// In en, this message translates to:
  /// **'CC'**
  String get cc;

  /// No description provided for @numbers.
  ///
  /// In en, this message translates to:
  /// **'No'**
  String get numbers;

  /// No description provided for @newCustomer.
  ///
  /// In en, this message translates to:
  /// **'New customer'**
  String get newCustomer;

  /// No description provided for @registeredCustomer.
  ///
  /// In en, this message translates to:
  /// **'Registered customer'**
  String get registeredCustomer;

  /// No description provided for @phone.
  ///
  /// In en, this message translates to:
  /// **'Phone'**
  String get phone;

  /// No description provided for @customers.
  ///
  /// In en, this message translates to:
  /// **'Customers'**
  String get customers;

  /// No description provided for @discountDescription.
  ///
  /// In en, this message translates to:
  /// **'The discount fields can be empty, which is equivalent to zero or no discount.'**
  String get discountDescription;

  /// No description provided for @nationalCode.
  ///
  /// In en, this message translates to:
  /// **'National code'**
  String get nationalCode;

  /// No description provided for @latestInvoices.
  ///
  /// In en, this message translates to:
  /// **'Last registered or changed invoices'**
  String get latestInvoices;

  /// No description provided for @withoutPreinvoiceOrInvoice.
  ///
  /// In en, this message translates to:
  /// **'Without proinvoice or invoice'**
  String get withoutPreinvoiceOrInvoice;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @productInformation.
  ///
  /// In en, this message translates to:
  /// **'Product information'**
  String get productInformation;

  /// No description provided for @box.
  ///
  /// In en, this message translates to:
  /// **'Box'**
  String get box;

  /// No description provided for @search.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get search;

  /// No description provided for @noResultsFound.
  ///
  /// In en, this message translates to:
  /// **'No results found'**
  String get noResultsFound;

  /// No description provided for @backup.
  ///
  /// In en, this message translates to:
  /// **'Backup'**
  String get backup;

  /// No description provided for @restore.
  ///
  /// In en, this message translates to:
  /// **'Restore'**
  String get restore;

  /// No description provided for @download.
  ///
  /// In en, this message translates to:
  /// **'Download'**
  String get download;

  /// No description provided for @downloadAndShare.
  ///
  /// In en, this message translates to:
  /// **'Download and share'**
  String get downloadAndShare;

  /// No description provided for @share.
  ///
  /// In en, this message translates to:
  /// **'Share'**
  String get share;

  /// No description provided for @error.
  ///
  /// In en, this message translates to:
  /// **'An error occurred. Please try again.'**
  String get error;

  /// No description provided for @successfulRestore.
  ///
  /// In en, this message translates to:
  /// **'Data restore was successful.'**
  String get successfulRestore;

  /// No description provided for @selectFile.
  ///
  /// In en, this message translates to:
  /// **'Select file'**
  String get selectFile;

  /// No description provided for @backupDescription.
  ///
  /// In en, this message translates to:
  /// **'In this section, you can back up your data to recover this data if needed. Our suggestion is to perform the backup periodically so that in case of an error or the application is deleted, your data will be saved from don\'t get lost.'**
  String get backupDescription;

  /// No description provided for @restoreDescription.
  ///
  /// In en, this message translates to:
  /// **'You can select the files that you saved under the title of backup with the extension of db to restore the data, note that after the data is restored, your current information will be deleted, and if needed, you can back up the current data.'**
  String get restoreDescription;

  /// No description provided for @noProduct.
  ///
  /// In en, this message translates to:
  /// **'There is no such product.'**
  String get noProduct;

  /// No description provided for @invoiceDescription.
  ///
  /// In en, this message translates to:
  /// **'Invoice description'**
  String get invoiceDescription;

  /// No description provided for @description.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get description;

  /// No description provided for @bookmarked.
  ///
  /// In en, this message translates to:
  /// **'The {subject} has been marked'**
  String bookmarked(Object subject);

  /// No description provided for @unBookmarked.
  ///
  /// In en, this message translates to:
  /// **'{subject} marking was removed'**
  String unBookmarked(Object subject);

  /// No description provided for @noBookmark.
  ///
  /// In en, this message translates to:
  /// **'No bookmark'**
  String get noBookmark;

  /// No description provided for @invalidLengthField.
  ///
  /// In en, this message translates to:
  /// **'The number of characters in the field is not correct.'**
  String get invalidLengthField;

  /// No description provided for @onlyInvoice.
  ///
  /// In en, this message translates to:
  /// **'Only invoice'**
  String get onlyInvoice;

  /// No description provided for @onlyPreinvoic.
  ///
  /// In en, this message translates to:
  /// **'Only preinvoice'**
  String get onlyPreinvoic;

  /// No description provided for @official.
  ///
  /// In en, this message translates to:
  /// **'Official'**
  String get official;

  /// No description provided for @unofficial.
  ///
  /// In en, this message translates to:
  /// **'Unofficial'**
  String get unofficial;

  /// No description provided for @options.
  ///
  /// In en, this message translates to:
  /// **'Options'**
  String get options;

  /// No description provided for @invoiceDate.
  ///
  /// In en, this message translates to:
  /// **'Invoice date'**
  String get invoiceDate;

  /// No description provided for @invoiceNumber.
  ///
  /// In en, this message translates to:
  /// **'Invoice number'**
  String get invoiceNumber;

  /// No description provided for @customerNationalCode.
  ///
  /// In en, this message translates to:
  /// **'Customer national code'**
  String get customerNationalCode;

  /// No description provided for @customerPhone.
  ///
  /// In en, this message translates to:
  /// **'Customer phone'**
  String get customerPhone;

  /// No description provided for @colorInvoice.
  ///
  /// In en, this message translates to:
  /// **'Color invoice'**
  String get colorInvoice;

  /// No description provided for @termsOfSale.
  ///
  /// In en, this message translates to:
  /// **'Terms of sale'**
  String get termsOfSale;

  /// No description provided for @invoiceHints.
  ///
  /// In en, this message translates to:
  /// **'Invoice hints'**
  String get invoiceHints;

  /// No description provided for @signers.
  ///
  /// In en, this message translates to:
  /// **'Signers'**
  String get signers;

  /// No description provided for @details.
  ///
  /// In en, this message translates to:
  /// **'Details'**
  String get details;

  /// No description provided for @invoiceDetails.
  ///
  /// In en, this message translates to:
  /// **'Invoice details'**
  String get invoiceDetails;

  /// No description provided for @customer.
  ///
  /// In en, this message translates to:
  /// **'Customer'**
  String get customer;

  /// No description provided for @invoiceRegistration.
  ///
  /// In en, this message translates to:
  /// **'Invoice registration'**
  String get invoiceRegistration;

  /// No description provided for @dateLastEdit.
  ///
  /// In en, this message translates to:
  /// **'Date last edit'**
  String get dateLastEdit;

  /// No description provided for @enterYourPasscode.
  ///
  /// In en, this message translates to:
  /// **'Enter your passcode'**
  String get enterYourPasscode;

  /// No description provided for @enterPasscode.
  ///
  /// In en, this message translates to:
  /// **'Enter passcode'**
  String get enterPasscode;

  /// No description provided for @enterYourPasscodeDescription.
  ///
  /// In en, this message translates to:
  /// **'Please enter your current password to manage these settings.'**
  String get enterYourPasscodeDescription;

  /// No description provided for @signInTitle.
  ///
  /// In en, this message translates to:
  /// **'Authentication required'**
  String get signInTitle;

  /// No description provided for @biometricHint.
  ///
  /// In en, this message translates to:
  /// **'Verify identity'**
  String get biometricHint;

  /// No description provided for @fingerprintDescription.
  ///
  /// In en, this message translates to:
  /// **'Scan your fingerprint (or face or whatever) to authenticate.'**
  String get fingerprintDescription;

  /// No description provided for @security.
  ///
  /// In en, this message translates to:
  /// **'Security'**
  String get security;

  /// No description provided for @enablePasscode.
  ///
  /// In en, this message translates to:
  /// **'Enable passcode'**
  String get enablePasscode;

  /// No description provided for @lockWithPasscode.
  ///
  /// In en, this message translates to:
  /// **'Passcode lock'**
  String get lockWithPasscode;

  /// No description provided for @lockWithPasscodeDescription.
  ///
  /// In en, this message translates to:
  /// **'Once a passcode is set, a lock icon will appear on the home screen of your app, Tap to lock the app.'**
  String get lockWithPasscodeDescription;

  /// No description provided for @passcodeDescription.
  ///
  /// In en, this message translates to:
  /// **'Create a {number} digit passcode that you can remember.'**
  String passcodeDescription(Object number);

  /// No description provided for @createPasscode.
  ///
  /// In en, this message translates to:
  /// **'Create a passcode'**
  String get createPasscode;

  /// No description provided for @reEnterYourPasscode.
  ///
  /// In en, this message translates to:
  /// **'Re-enter your passcode'**
  String get reEnterYourPasscode;

  /// No description provided for @reEnterYourPasscodeDescription.
  ///
  /// In en, this message translates to:
  /// **'If you forget the passcode, it is not possible to recover it and you have to reinstall the program.'**
  String get reEnterYourPasscodeDescription;

  /// No description provided for @noMatchPasscode.
  ///
  /// In en, this message translates to:
  /// **'Passcodes don\'t match.'**
  String get noMatchPasscode;

  /// No description provided for @lockSettings.
  ///
  /// In en, this message translates to:
  /// **'Lock settings'**
  String get lockSettings;

  /// No description provided for @changePasscode.
  ///
  /// In en, this message translates to:
  /// **'Change passcode'**
  String get changePasscode;

  /// No description provided for @newPasscode.
  ///
  /// In en, this message translates to:
  /// **'New passcode'**
  String get newPasscode;

  /// No description provided for @passcodeInvalid.
  ///
  /// In en, this message translates to:
  /// **'The passcode is invalid.'**
  String get passcodeInvalid;

  /// No description provided for @enable.
  ///
  /// In en, this message translates to:
  /// **'Enable'**
  String get enable;

  /// No description provided for @disable.
  ///
  /// In en, this message translates to:
  /// **'Disable'**
  String get disable;

  /// No description provided for @disablePasscode.
  ///
  /// In en, this message translates to:
  /// **'Disable passcode'**
  String get disablePasscode;

  /// No description provided for @lockConfigDescription.
  ///
  /// In en, this message translates to:
  /// **'To lock the program, click on the lock icon at the top of the first screen.'**
  String get lockConfigDescription;

  /// No description provided for @unlockWithFingerprint.
  ///
  /// In en, this message translates to:
  /// **'Unlock with fingerprint'**
  String get unlockWithFingerprint;

  /// No description provided for @automaticLock.
  ///
  /// In en, this message translates to:
  /// **'Automatic lock'**
  String get automaticLock;

  /// No description provided for @autoLockDescription.
  ///
  /// In en, this message translates to:
  /// **'If you do not re-enter the program for a certain period of time, you will be asked for a password.'**
  String get autoLockDescription;

  /// No description provided for @confirm.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get confirm;

  /// No description provided for @minutes.
  ///
  /// In en, this message translates to:
  /// **'Minutes'**
  String get minutes;

  /// No description provided for @hour.
  ///
  /// In en, this message translates to:
  /// **'Houre'**
  String get hour;

  /// No description provided for @hours.
  ///
  /// In en, this message translates to:
  /// **'Hours'**
  String get hours;

  /// No description provided for @within.
  ///
  /// In en, this message translates to:
  /// **'In'**
  String get within;

  /// No description provided for @helperTextforPrice.
  ///
  /// In en, this message translates to:
  /// **'Changes in the price each field are only applied to the current invoice.'**
  String get helperTextforPrice;

  /// No description provided for @tooManyTries.
  ///
  /// In en, this message translates to:
  /// **'Too many tries.'**
  String get tooManyTries;

  /// No description provided for @tooManyTriesCornometer.
  ///
  /// In en, this message translates to:
  /// **'please try again in {number} seconds.'**
  String tooManyTriesCornometer(Object number);

  /// No description provided for @forgotPasscode.
  ///
  /// In en, this message translates to:
  /// **'Forgot passcode?'**
  String get forgotPasscode;

  /// No description provided for @forgotPasscodeDescription.
  ///
  /// In en, this message translates to:
  /// **'If you have forgotten your passcode, please delete and reinstall the program, unfortunately your data will be deleted.'**
  String get forgotPasscodeDescription;

  /// No description provided for @fakeData.
  ///
  /// In en, this message translates to:
  /// **'Fake data'**
  String get fakeData;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'fa'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return AppLocalizationsEn();
    case 'fa': return AppLocalizationsFa();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
