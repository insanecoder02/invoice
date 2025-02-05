import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:invoice/config.dart';
import 'package:invoice/database/sqlite/core_sqlite_database_.dart';
import 'package:invoice/functions/core_function.dart' show t, showSnackBarWidget;
import 'package:invoice/widgets/global/form/button_widget.dart';
import 'package:sqflite/sqflite.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:share_plus/share_plus.dart';

class BackupDatabaseSqliteScreen extends StatefulWidget {

  const BackupDatabaseSqliteScreen({super.key});

  @override
  State<BackupDatabaseSqliteScreen> createState() => _BackupDatabaseSqliteScreenState();
}

class _BackupDatabaseSqliteScreenState extends State<BackupDatabaseSqliteScreen> {

  bool _isLoading = false;

  Future<void> _permissionCheck() async {
    var status = await Permission.manageExternalStorage.status;
    if(!status.isGranted) {
      await Permission.manageExternalStorage.request();
    }

    var status1 = await Permission.storage.status;
    if(!status1.isGranted) {
      await Permission.storage.request();
    }
  }

  void _backupDatabaseHandler(context) async {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();

    try {
      await _permissionCheck();

      setState(() => _isLoading = true);

      Map<String, String> getPath = await _getPath();

      String backupContent = await CoreSqliteDatabase().backupDatabase(isEncrypted: true);
      File ourDBFile = File(getPath['withDirectory'].toString());
      Directory? folderPathForDBFile = Directory(getPath['onlyDirectory'].toString());
      await folderPathForDBFile.create(recursive: true);
      await ourDBFile.writeAsString(backupContent);
      await ourDBFile.create(recursive: true);

      setState(() => _isLoading = false);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          margin: const EdgeInsets.only(bottom: 50.0, right: 20.0, left: 20.0),
          duration: const Duration(minutes: 30),
          dismissDirection: DismissDirection.horizontal,
          content: Directionality(
            textDirection: TextDirection.rtl,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: Icon(Icons.share, color: Config.foregroundDark),
                  onPressed: () async => await _shareBackup(),
                ),
                Expanded(child: Text("${getPath['pathForShow']}", textAlign: TextAlign.left)),
                const SizedBox(width: 10.0),
                Icon(Icons.verified, color: Colors.green.shade700),
              ]
            ),
          )
        )
      );
    } catch(error) {
      setState(() => _isLoading = false);
      showSnackBarWidget(context, content: Padding(padding: const EdgeInsets.symmetric(vertical: 5.0), child: Text(t(context).error)), margin: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 50.0));
    }

    /*File ourDBFile = File((await _getPath())["databasePath"].toString());
      String path = "/storage/emulated/0/Invoice/backup/";
      Directory? folderPathForDBFile = Directory(path);
      await folderPathForDBFile.create(recursive: true);
      await ourDBFile.copy("$path${Config.sqliteDb}");

    String backupContent = await CoreSqliteDatabase().backupDatabase(isEncrypted: true);
    String databasePath = await getDatabasesPath();
    Directory? externalStoragePath = await getExternalStorageDirectory();
    // /data/user/0/com.example.invoice/databases
    // /storage/emulated/0/Android/data/com.example.invoice/files*/
  }

  Future<Map<String, String>> _getPath() async {
    String createdAt = DateTime.now().toPersianDate().toEnglishDigit().replaceAll('/', '-');
    String databasePath = await getDatabasesPath();
    databasePath = join(databasePath, Config.sqliteDb);
    String? directory = "/storage/emulated/0/Invoice/Backups/";

    return {
      "databasePath": databasePath,
      "withDirectory": "$directory${createdAt}_${Config.sqliteDb}",
      "onlyDirectory": directory,
      "pathForShow": "Invoice/Backups/$createdAt/${createdAt}_${Config.sqliteDb}"
    };
  }

  Future<void> _shareBackup() async {
    try {
      final result = await Share.shareXFiles([XFile((await _getPath())['withDirectory'].toString())]);
      
      if (result.status == ShareResultStatus.dismissed) {
        //Todo
      }

      return Future.value();
    } catch(error) {
      return Future.error(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        return Future.value(true);
      },
      child: Scaffold(
        appBar: AppBar(),
        body: ListView(
          physics: const ClampingScrollPhysics(),
          padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 100.0),
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: Icon(Icons.backup, size: 80.0, color: Theme.of(context).colorScheme.primary),
            ),
            Text(t(context).backup, style: Theme.of(context).textTheme.headlineLarge, textAlign: TextAlign.center),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 30.0),
              child: Text(t(context).backupDescription, style: Theme.of(context).textTheme.headlineSmall?.copyWith(height: 1.8), textAlign: TextAlign.center),
            ),
          ],
        ),
        bottomSheet: Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 50.0),
          child: ButtonWidget(
            isLoading: _isLoading,
            onPressed: () => _backupDatabaseHandler(context),
            child: Text(t(context).downloadAndShare)
          )
        )
      ),
    );
  }
}
