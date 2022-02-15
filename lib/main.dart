import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tap_todo/bloc/product_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tap_todo/utils/theme.dart';
import 'bloc/product_bloc.dart';
import 'presentation_layer/product_list.dart';
import 'utils/firebase_config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseConfig.platformOptions,
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget with WidgetsBindingObserver {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.dark,
    ));
    return MultiBlocProvider(
      providers: [
        BlocProvider<ProductBloc>(
          create: (context) =>
              ProductBloc(initialState: InitializeProductState()),
        ),
      ],
      child: MaterialApp(
        title: 'Tap Product',
        theme: AppThemes.lightTheme,
        darkTheme: AppThemes.darkTheme,
        themeMode: ThemeMode.system,
        home: const ProductList(),
      ),
    );
  }
}
