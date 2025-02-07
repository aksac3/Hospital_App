import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'injection_container.dart' as di;
import 'presentation/bloc/login_bloc.dart';
import 'presentation/pages/hospital_list_page.dart';
import 'presentation/pages/login_page.dart';
import 'presentation/bloc/hospital_bloc.dart'; 

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LoginBloc>(
          create: (context) => di.sl<LoginBloc>(),
        ),
        BlocProvider<HospitalBloc>( 
          create: (context) => di.sl<HospitalBloc>(), 
        ),
      ],
      child: MaterialApp(
        title: 'Hospital App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => LoginPage(),
          '/hospitals': (context) => HospitalListPage(), 
        },
      ),
    );
  }
}