class SqliteMigrations {
  static Future categoriesMigration(dynamic db) async {
    await db.execute(
      '''
        CREATE TABLE categories(
          id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
          name TEXT NOT NULL UNIQUE,
          CHECK(LENGTH(name) <= 16)
        )
      '''
    );
  }

  static Future productsMigration(dynamic db) async {
    await db.execute(
      '''
        CREATE TABLE products(
          id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
          categoryId INTEGER NOT NULL,
          code TEXT NOT NULL UNIQUE,
          name TEXT NOT NULL,
          volume INTEGER NOT NULL,
          unit TINYINT NOT NULL DEFAULT 0,
          quantityInBox INTEGER NOT NULL,
          price INTEGER NOT NULL,
          seenAt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
          UNIQUE (name, categoryId),
          CHECK(LENGTH(code) <= 16),
          CHECK(LENGTH(name) <= 64),
          CHECK(LENGTH(volume) <= 8),
          CHECK(LENGTH(unit) = 1),
          CHECK(LENGTH(quantityInBox) <= 3),
          CHECK(LENGTH(price) <= 8),
          FOREIGN KEY (categoryId) REFERENCES categories(id) ON DELETE CASCADE
        )
      '''
    );
  }
  
  static Future customersMigration(dynamic db) async {
    await db.execute(
      '''
        CREATE TABLE customers(
          id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
          nationalCode TEXT NOT NULL UNIQUE,
          name TEXT NOT NULL,
          phone TEXT NOT NULL,
          address TEXT NULL,
          createdAt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
          updatedAt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
          seenAt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
          CHECK(LENGTH(nationalCode) = 10),
          CHECK(LENGTH(name) <= 32),
          CHECK(LENGTH(phone) = 11),
          CHECK(LENGTH(address) <= 64)
        )
      '''
    );
  }

  static Future invoicesMigration(dynamic db) async {
    await db.execute(
      '''
        CREATE TABLE invoices(
          id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
          customerId INTEGER NOT NULL,
          type TINYINT NOT NULL DEFAULT 0,
          cashDiscount TINYINT NOT NULL DEFAULT 0,
          volumeDiscount TINYINT NOT NULL DEFAULT 0,
          description TEXT NULL,
          bookmark TINYINT NOT NULL DEFAULT 0,
          createdAt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
          updatedAt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
          CHECK(LENGTH(type) = 1),
          CHECK(LENGTH(cashDiscount) <= 2),
          CHECK(LENGTH(volumeDiscount) <= 2),
          CHECK(LENGTH(description) <= 512),
          CHECK(LENGTH(bookmark) = 1),
          FOREIGN KEY (customerId) REFERENCES customers(id) ON DELETE CASCADE
        )
      '''
    );
  }

  static Future invoiceProductsMigration(dynamic db) async {
    await db.execute(
      '''
        CREATE TABLE invoiceProducts(
          id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
          invoiceId INTEGER NOT NULL,
          productId INTEGER NOT NULL,
          productVolumeEach INTEGER NOT NULL,
          quantityOfBoxes INTEGER NOT NULL,
          productPriceEach INTEGER NOT NULL,
          CHECK(LENGTH(productVolumeEach) <= 8),
          CHECK(LENGTH(quantityOfBoxes) <= 3),
          CHECK(LENGTH(productPriceEach) <= 8),
          UNIQUE (invoiceId, productId)
          FOREIGN KEY (invoiceId) REFERENCES invoices(id) ON DELETE CASCADE
          FOREIGN KEY (productId) REFERENCES products(id) ON DELETE CASCADE
        )
      '''
    );
  }

  static Future settingsMigration(dynamic db) async {
    await db.execute(
      '''
        CREATE TABLE settings(
          id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
          passcode TEXT NULL,
          autoLockDuration INTEGER NOT NULL DEFAULT 0,
          fingerprint TINYINT NOT NULL DEFAULT 0,
          quantityOfAuthAttempts TINYINT NOT NULL DEFAULT 0
        )
      '''
    );
  }
}
