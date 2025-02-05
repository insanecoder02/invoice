import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'Invoice';

  @override
  String get language => 'Language';

  @override
  String get selectLanguage => 'Select language';

  @override
  String get switchToSystemTheme => 'Switch to system theme';

  @override
  String get switchToDarkMode => 'Switch to dark mode';

  @override
  String get switchToLightMode => 'Switch to light mode';

  @override
  String get dbError => 'An error occurred in the database.';

  @override
  String get checkNetwork => 'Check your internet connection.';

  @override
  String get iUnderstand => 'I understand';

  @override
  String get emptyData => 'No data found.';

  @override
  String get name => 'name';

  @override
  String get customerName => 'Customer name';

  @override
  String get categoryName => 'Category name';

  @override
  String get productName => 'Product name';

  @override
  String get discount => 'Discount';

  @override
  String get cashDiscount => 'Cash discount';

  @override
  String get volumeDiscount => 'Volume discount';

  @override
  String get discountPercent => 'Discount percent';

  @override
  String get withoutDiscount => 'Without discount';

  @override
  String get address => 'Address';

  @override
  String get customerAddress => 'Customer address';

  @override
  String get withoutAddress => 'Without address';

  @override
  String get code => 'Code';

  @override
  String get productCode => 'Product code';

  @override
  String get title => 'Product info';

  @override
  String get quantityInBox => 'Quantity in box';

  @override
  String get quantityOfBoxes => 'Number of boxes';

  @override
  String get price => 'Price';

  @override
  String get productPrice => 'Product price';

  @override
  String get priceEach => 'Price each';

  @override
  String get formError => 'Error in validating the form.';

  @override
  String get successfulOperation => 'Successful Operation';

  @override
  String get invoiceCreate => 'Invoice create';

  @override
  String get productCreate => 'Create product';

  @override
  String get categoryCreate => 'Create category';

  @override
  String get customerCreate => 'Create customer';

  @override
  String get invoiceEdit => 'Invoice edit';

  @override
  String get preinvoiceEdit => 'Preinvoice edit';

  @override
  String get productEdit => 'Edit product';

  @override
  String get invoiceDelete => 'Invoice delete';

  @override
  String get categoryEdit => 'Edit category';

  @override
  String get customerEdit => 'Edit customer';

  @override
  String get requiredField => 'Please fill in field.';

  @override
  String get create => 'Create';

  @override
  String get edit => 'Edit';

  @override
  String get fetchDataError => 'Error in data fetch.';

  @override
  String get tryAgain => 'Try again';

  @override
  String areYouSure(Object subject) {
    return 'Are you sure for $subject?';
  }

  @override
  String get delete => 'Delete';

  @override
  String get remove => 'Remove';

  @override
  String get removeForever => 'Remove forever';

  @override
  String get yes => 'Yes';

  @override
  String get no => 'No';

  @override
  String get cancel => 'Cancel';

  @override
  String get ok => 'Ok';

  @override
  String get noCategories => 'No categories';

  @override
  String get noCustomers => 'No customers';

  @override
  String get tapAddCategories => 'Tap the Add button to create a category.';

  @override
  String get tapAddCustomers => 'Tap the Add button to create a customer.';

  @override
  String get noProducts => 'No products';

  @override
  String get tapAddProducts => 'Tap the Add button to create a product.';

  @override
  String get noInvoices => 'No invoices';

  @override
  String get tapAddInvoice => 'Tap the Add button to create a invoice.';

  @override
  String get noInvoiceProducts => 'No products';

  @override
  String get tapAddInvoiceProducts => 'Tap the Add button to create a products.';

  @override
  String get bookmark => 'Bookmark';

  @override
  String get bookmarks => 'Bookmarks';

  @override
  String get selected => 'Selected';

  @override
  String get newest => 'Newest';

  @override
  String get oldest => 'Oldest';

  @override
  String get invoice => 'Invoice';

  @override
  String get invoices => 'Invoices';

  @override
  String get preinvoice => 'Preinvoice';

  @override
  String get newProduct => 'New product';

  @override
  String get total => 'Total';

  @override
  String get payable => 'Payable';

  @override
  String get rial => 'Rial';

  @override
  String get category => 'Category';

  @override
  String get categories => 'Categories';

  @override
  String get productCategory => 'Product category';

  @override
  String alreadyExisted(Object subject) {
    return 'Such a $subject already existed.';
  }

  @override
  String get product => 'Product';

  @override
  String get products => 'Products';

  @override
  String get withoutProduct => 'Without product';

  @override
  String get descriptionForDeleteCategory => 'By deleting a category, all the products of that category will be deleted, and the invoices whose products have been deleted will also change';

  @override
  String get descriptionForDeleteProduct => 'By removing the product, the invoices that had this product will change';

  @override
  String get descriptionForDeleteCustomer => 'By deleting the customer, all the invoices of that customer will be deleted';

  @override
  String get volume => 'Volume';

  @override
  String get productVolume => 'Product volume';

  @override
  String get volumeUnit => 'Volume unit';

  @override
  String get gram => 'Gram';

  @override
  String get cc => 'CC';

  @override
  String get numbers => 'No';

  @override
  String get newCustomer => 'New customer';

  @override
  String get registeredCustomer => 'Registered customer';

  @override
  String get phone => 'Phone';

  @override
  String get customers => 'Customers';

  @override
  String get discountDescription => 'The discount fields can be empty, which is equivalent to zero or no discount.';

  @override
  String get nationalCode => 'National code';

  @override
  String get latestInvoices => 'Last registered or changed invoices';

  @override
  String get withoutPreinvoiceOrInvoice => 'Without proinvoice or invoice';

  @override
  String get settings => 'Settings';

  @override
  String get productInformation => 'Product information';

  @override
  String get box => 'Box';

  @override
  String get search => 'Search';

  @override
  String get noResultsFound => 'No results found';

  @override
  String get backup => 'Backup';

  @override
  String get restore => 'Restore';

  @override
  String get download => 'Download';

  @override
  String get downloadAndShare => 'Download and share';

  @override
  String get share => 'Share';

  @override
  String get error => 'An error occurred. Please try again.';

  @override
  String get successfulRestore => 'Data restore was successful.';

  @override
  String get selectFile => 'Select file';

  @override
  String get backupDescription => 'In this section, you can back up your data to recover this data if needed. Our suggestion is to perform the backup periodically so that in case of an error or the application is deleted, your data will be saved from don\'t get lost.';

  @override
  String get restoreDescription => 'You can select the files that you saved under the title of backup with the extension of db to restore the data, note that after the data is restored, your current information will be deleted, and if needed, you can back up the current data.';

  @override
  String get noProduct => 'There is no such product.';

  @override
  String get invoiceDescription => 'Invoice description';

  @override
  String get description => 'Description';

  @override
  String bookmarked(Object subject) {
    return 'The $subject has been marked';
  }

  @override
  String unBookmarked(Object subject) {
    return '$subject marking was removed';
  }

  @override
  String get noBookmark => 'No bookmark';

  @override
  String get invalidLengthField => 'The number of characters in the field is not correct.';

  @override
  String get onlyInvoice => 'Only invoice';

  @override
  String get onlyPreinvoic => 'Only preinvoice';

  @override
  String get official => 'Official';

  @override
  String get unofficial => 'Unofficial';

  @override
  String get options => 'Options';

  @override
  String get invoiceDate => 'Invoice date';

  @override
  String get invoiceNumber => 'Invoice number';

  @override
  String get customerNationalCode => 'Customer national code';

  @override
  String get customerPhone => 'Customer phone';

  @override
  String get colorInvoice => 'Color invoice';

  @override
  String get termsOfSale => 'Terms of sale';

  @override
  String get invoiceHints => 'Invoice hints';

  @override
  String get signers => 'Signers';

  @override
  String get details => 'Details';

  @override
  String get invoiceDetails => 'Invoice details';

  @override
  String get customer => 'Customer';

  @override
  String get invoiceRegistration => 'Invoice registration';

  @override
  String get dateLastEdit => 'Date last edit';

  @override
  String get enterYourPasscode => 'Enter your passcode';

  @override
  String get enterPasscode => 'Enter passcode';

  @override
  String get enterYourPasscodeDescription => 'Please enter your current password to manage these settings.';

  @override
  String get signInTitle => 'Authentication required';

  @override
  String get biometricHint => 'Verify identity';

  @override
  String get fingerprintDescription => 'Scan your fingerprint (or face or whatever) to authenticate.';

  @override
  String get security => 'Security';

  @override
  String get enablePasscode => 'Enable passcode';

  @override
  String get lockWithPasscode => 'Passcode lock';

  @override
  String get lockWithPasscodeDescription => 'Once a passcode is set, a lock icon will appear on the home screen of your app, Tap to lock the app.';

  @override
  String passcodeDescription(Object number) {
    return 'Create a $number digit passcode that you can remember.';
  }

  @override
  String get createPasscode => 'Create a passcode';

  @override
  String get reEnterYourPasscode => 'Re-enter your passcode';

  @override
  String get reEnterYourPasscodeDescription => 'If you forget the passcode, it is not possible to recover it and you have to reinstall the program.';

  @override
  String get noMatchPasscode => 'Passcodes don\'t match.';

  @override
  String get lockSettings => 'Lock settings';

  @override
  String get changePasscode => 'Change passcode';

  @override
  String get newPasscode => 'New passcode';

  @override
  String get passcodeInvalid => 'The passcode is invalid.';

  @override
  String get enable => 'Enable';

  @override
  String get disable => 'Disable';

  @override
  String get disablePasscode => 'Disable passcode';

  @override
  String get lockConfigDescription => 'To lock the program, click on the lock icon at the top of the first screen.';

  @override
  String get unlockWithFingerprint => 'Unlock with fingerprint';

  @override
  String get automaticLock => 'Automatic lock';

  @override
  String get autoLockDescription => 'If you do not re-enter the program for a certain period of time, you will be asked for a password.';

  @override
  String get confirm => 'Confirm';

  @override
  String get minutes => 'Minutes';

  @override
  String get hour => 'Houre';

  @override
  String get hours => 'Hours';

  @override
  String get within => 'In';

  @override
  String get helperTextforPrice => 'Changes in the price each field are only applied to the current invoice.';

  @override
  String get tooManyTries => 'Too many tries.';

  @override
  String tooManyTriesCornometer(Object number) {
    return 'please try again in $number seconds.';
  }

  @override
  String get forgotPasscode => 'Forgot passcode?';

  @override
  String get forgotPasscodeDescription => 'If you have forgotten your passcode, please delete and reinstall the program, unfortunately your data will be deleted.';

  @override
  String get fakeData => 'Fake data';
}
