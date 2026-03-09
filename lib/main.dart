import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/src/app/app.dart';
import 'package:flutter_app/src/app/app_config.dart';
import 'package:flutter_app/src/screens/entry.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  // UI initialization
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);

  // Repository initialization
  final appDocDir = await getApplicationDocumentsDirectory();
  final dbPath = '${appDocDir.path}/transactions.db';
  final config = TransactionAppConfig(
    dbPath: dbPath,
    dbVersion: 1,
    transactionTableName: 'transactions',
    paymentMethodTableName: 'paymentMethods',
  );

  $app = TransactionApp(config);
  final r = await $app.init();

  if (r.isError) {
    print("INITIALIZATION ERROR: ${r.error}");
  } else {
    print("INITIALIZATION SUCCESSFUL!");
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.amber),
        useMaterial3: true,
      ),
      home: const Entry(),
    );
  }
}
