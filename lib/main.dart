import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:medical_app/db/db_doctors.dart';
import 'package:medical_app/db/db_patients.dart';
import 'package:medical_app/models/doctor_model.dart';
import 'package:medical_app/pages/calculate_water_page.dart';
import 'package:medical_app/pages/doctor_page.dart';
import 'package:medical_app/pages/doctor_pages/doctor_profile.dart';
import 'package:medical_app/pages/messages/chat_messages.dart';
import 'package:medical_app/pages/messages/chat_page.dart';
import 'package:medical_app/pages/diagnosis_kidney_page.dart';
import 'package:medical_app/pages/foods_pages/allowed_food.dart';
import 'package:medical_app/pages/foods_pages/forbidden_food.dart';
import 'package:medical_app/pages/foods_pages/potassium_food.dart';
import 'package:medical_app/pages/foods_pages/protien_food.dart';
import 'package:medical_app/pages/home.dart';
import 'package:medical_app/pages/landing_page.dart';
import 'package:medical_app/pages/registration/registration.dart';
import 'package:medical_app/pages/splash_screen.dart';
import 'package:medical_app/pages/treatment_centers/treatment_centers.dart';
import 'package:medical_app/pages/treatment_centers/treatment_details_page.dart';
import 'package:medical_app/providers/israted_provider.dart';
import 'package:medical_app/providers/num_of_rates_provider.dart';
import 'package:medical_app/providers/obscure_provider.dart';
import 'package:medical_app/providers/user_login_type_provider.dart';
import 'package:provider/provider.dart';
import 'pages/doctor_page.dart';
import 'pages/doctor_pages/patients_page.dart';
import 'pages/foods_pages/global_advices_page.dart';
import 'providers/doctor_provider.dart';
import 'providers/auth_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  FirebaseMessaging _fcm = FirebaseMessaging.instance;

  @override
  void initState() {
    super.initState();
    _fcm.requestPermission();
    _fcm.setForegroundNotificationPresentationOptions(
        alert: true, badge: true, sound: true);
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
/*----------------------------------------------------------------------------------------------*/
/*--------------------------------------  Doctor Provider  -------------------------------------*/
/*----------------------------------------------------------------------------------------------*/
        ChangeNotifierProvider(create: (context) => DoctorProvider()),
/*----------------------------------------------------------------------------------------------*/
/*-------------------------------------  Obscure Provider  -------------------------------------*/
/*----------------------------------------------------------------------------------------------*/
        ChangeNotifierProvider(create: (context) => ObscureProvider()),
/*----------------------------------------------------------------------------------------------*/
/*--------------------------------------  Auth Provider  ---------------------------------------*/
/*----------------------------------------------------------------------------------------------*/
        Provider(create: (context) => AuthProvider()),
/*----------------------------------------------------------------------------------------------*/
/*-----------------------------------  Auth State Provider  ------------------------------------*/
/*----------------------------------------------------------------------------------------------*/
        StreamProvider(
            create: (context) => context.read<AuthProvider>().authStateChanges,
            initialData: null),
/*----------------------------------------------------------------------------------------------*/
/*----------------------------------  Patient Data Provider  -----------------------------------*/
/*----------------------------------------------------------------------------------------------*/
        StreamProvider(
            create: (context) => PatientsDB().getData(), initialData: null),
/*----------------------------------------------------------------------------------------------*/
/*----------------------------------  Patient Data Provider  -----------------------------------*/
/*----------------------------------------------------------------------------------------------*/
        StreamProvider(
            create: (context) => PatientsDB().getAllPatients(),
            initialData: null),
/*----------------------------------------------------------------------------------------------*/
/*----------------------------------  Doctor Data Provider  ------------------------------------*/
/*----------------------------------------------------------------------------------------------*/
        StreamProvider<List<DoctorModel>>(
            create: (context) => DoctorsDB().getAllDoctors(),
            initialData: null),
/*----------------------------------------------------------------------------------------------*/
/*-----------------------------------  Doctor Data Provider  -----------------------------------*/
/*----------------------------------------------------------------------------------------------*/
        StreamProvider(
            create: (context) => DoctorsDB().getData(), initialData: null),
/*----------------------------------------------------------------------------------------------*/
/*-----------------------------  Doctor Number of Rates Provider  ------------------------------*/
/*----------------------------------------------------------------------------------------------*/
        ChangeNotifierProvider(create: (context) => NumOfRateProvider()),
/*----------------------------------------------------------------------------------------------*/
/*--------------------------------  User Login Type Provider  ----------------------------------*/
/*----------------------------------------------------------------------------------------------*/
        ChangeNotifierProvider(create: (context) => UserLoginTypeProvider()),
/*----------------------------------------------------------------------------------------------*/
/*------------------------------------  Is Rated Provider  -------------------------------------*/
/*----------------------------------------------------------------------------------------------*/
        ChangeNotifierProvider(create: (context) => IsRatedProvider()),
      ],
      builder: (context, child) => child,
      child: MaterialApp(
        title: 'Medical App',
        localizationsDelegates: [
          GlobalCupertinoLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        debugShowCheckedModeBanner: false,
        supportedLocales: const [Locale("ar", "EG")],
        locale: const Locale("ar", "EG"),
        theme: ThemeData(
          accentColor: const Color(0xFF045de9),
          primaryColor: const Color(0xFF95A3F5),
        ),
        initialRoute: SplashScreen.routeName,
        routes: {
          Registration.routeName: (context) => Registration(),
          SplashScreen.routeName: (context) => SplashScreen(),
          LandingPage.routeName: (context) => LandingPage(),
          Home.routeName: (context) => Home(),
          ChatPage.routeName: (context) => ChatPage(),
          ChatMessages.routeName: (context) => ChatMessages(),
          DoctorPage.routeName: (context) => DoctorPage(),
          TreatmentCenter.routeName: (context) => TreatmentCenter(),
          CalculateWaterPage.routeName: (context) => CalculateWaterPage(),
          ProtienFood.routeName: (context) => ProtienFood(),
          PotassiumFood.routeName: (context) => PotassiumFood(),
          AllowedFood.routeName: (context) => AllowedFood(),
          ForbiddenFood.routeName: (context) => ForbiddenFood(),
          DiagnosisKidneyPage.routeName: (context) => DiagnosisKidneyPage(),
          TreatmentDetailsPage.routeName: (context) => TreatmentDetailsPage(),
          DoctorProfile.routeName: (context) => DoctorProfile(),
          GlobalAdvicesPage.routeName: (context) => GlobalAdvicesPage(),
          PatientProfilePage.routeName: (context) => PatientProfilePage(),
        },
      ),
    );
  }
}
