import 'dart:io';
import 'package:flutter/material.dart';
import 'package:invoice/database/sqlite/core_sqlite_database_.dart';
import 'package:invoice/functions/core_function.dart' show t, showSnackBarWidget, showDialogWidget, navigatorByPop;
import 'package:invoice/plugins/bootstrap/init_states_plugin.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:file_picker/file_picker.dart';
import 'package:invoice/widgets/global/form/button_widget.dart';

class RestoreDatabaseSqliteScreen extends StatefulWidget {
  
  const RestoreDatabaseSqliteScreen({super.key});

  @override
  State<RestoreDatabaseSqliteScreen> createState() => _RestoreDatabaseSqliteScreenState();
}

class _RestoreDatabaseSqliteScreenState extends State<RestoreDatabaseSqliteScreen> {

  bool _isLoading = false;

  void _restoreDatabaseHandler(context) async {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();

    try {
      await _permissionCheck();

      FilePickerResult? filePickerResult = await FilePicker.platform.pickFiles();

      if (filePickerResult != null) {
        _showDialogForRestore(context).then((dialogResult) async {
          if(dialogResult) {
            try {
              setState(() => _isLoading = true);
              File file = File(filePickerResult.files.single.path!);
              String backup = await file.readAsString();
              await CoreSqliteDatabase().clearDatabse();
              await CoreSqliteDatabase().restoreDatabase(backup, isEncrypted: true);
              await InitStatesPlugin.initStates(context);
              setState(() => _isLoading = false);
              showSnackBarWidget(context,
                margin: const EdgeInsets.only(bottom: 50.0, right: 20.0, left: 20.0),
                content: Row(
                  children: [
                    Icon(Icons.verified, color: Colors.green.shade700),
                    const SizedBox(width: 10.0),
                    Expanded(child: Text(t(context).successfulRestore))
                  ],
                )
              );
            } catch (error) {
              setState(() => _isLoading = false);
              showSnackBarWidget(context, content: Padding(padding: const EdgeInsets.symmetric(vertical: 5.0), child: Text(t(context).error)), margin: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 50.0));
            }
          }
        });
      }
    } catch(error) {
      setState(() => _isLoading = false);
      showSnackBarWidget(context, content: Padding(padding: const EdgeInsets.symmetric(vertical: 5.0), child: Text(t(context).error)), margin: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 50.0));
    }
  }

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

  Future<bool> _showDialogForRestore(context) async {
    return showDialogWidget(context,
      content: Text(t(context).areYouSure(t(context).restore)),
      actions: [
        TextButton(
          child: Text(t(context).cancel),
          onPressed: () => navigatorByPop(context, result: false),
        ),
        const SizedBox(width: 20.0),
        TextButton(
          child: Text(t(context).yes),
          onPressed: () => navigatorByPop(context, result: true),
        )
      ]
    );
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
              child: Icon(Icons.settings_backup_restore, size: 80.0, color: Theme.of(context).colorScheme.primary),
            ),
            Text(t(context).restore, style: Theme.of(context).textTheme.headlineLarge, textAlign: TextAlign.center),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 30.0),
              child: Text(t(context).restoreDescription, style: Theme.of(context).textTheme.headlineSmall?.copyWith(height: 1.8), textAlign: TextAlign.center),
            ),
          ],
        ),
        bottomSheet: Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 50.0),
          child: ButtonWidget(
            isLoading: _isLoading,
            onPressed: () => _restoreDatabaseHandler(context),
            child: Text(t(context).selectFile)
          )
        )
      ),
    );
  }
}
