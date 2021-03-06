import 'package:flutter/material.dart';
import 'package:medical_app/db/db_patients.dart';
import 'package:medical_app/models/user.dart';
import 'package:medical_app/pages/calculate_water_page.dart';
import 'package:medical_app/pages/diagnosis_kidney_page.dart';
import 'package:medical_app/pages/foods_pages/allowed_food.dart';
import 'package:medical_app/pages/foods_pages/forbidden_food.dart';
import 'package:medical_app/pages/foods_pages/potassium_food.dart';
import 'package:medical_app/pages/foods_pages/protien_food.dart';
import 'package:medical_app/pages/foods_pages/global_advices_page.dart';
import 'package:medical_app/pages/messages/chat_messages.dart';
import 'package:medical_app/pages/treatment_centers/treatment_centers.dart';
import 'package:medical_app/providers/auth_provider.dart';
import 'package:provider/provider.dart';

import '../constants.dart';

class PatientDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: ListView(
          children: [
            StreamBuilder<Users>(
                stream: PatientsDB().getData(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(child: CircularProgressIndicator());
                  } else {
                    Users user = snapshot.data;
                    return Container(
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              colors: [
                                Theme.of(context).accentColor,
                                Constants.color2,
                              ],
                              begin: Alignment.centerRight,
                              end: Alignment.centerLeft),
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(60))),
                      child: UserAccountsDrawerHeader(
                        decoration: BoxDecoration(
                            color: Constants.textFieldColor,
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(60))),
                        currentAccountPicture: CircleAvatar(
                          backgroundColor: Constants.textFieldColor,
                          backgroundImage: AssetImage('assets/app_logo.png'),
                        ),
                        accountName: Text(user.name),
                        accountEmail: Text(user.email),
                      ),
                    );
                  }
                }),
            ListTile(
              onTap: () =>
                  Navigator.of(context).pushNamed(TreatmentCenter.routeName),
              title: const Text("?????????? ????????????"),
              leading: Icon(
                Icons.local_hospital_outlined,
                color: Theme.of(context).accentColor,
              ),
            ),
            StreamBuilder<Object>(
                stream: PatientsDB().getData(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(child: CircularProgressIndicator());
                  } else {
                    Users user = snapshot.data;
                    return ListTile(
                      onTap: () => Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              ChatMessages(userName: user.username))),
                      title: const Text("??????????????"),
                      leading: Icon(
                        Icons.message_outlined,
                        color: Theme.of(context).accentColor,
                      ),
                    );
                  }
                }),
            ListTile(
              onTap: () =>
                  Navigator.of(context).pushNamed(CalculateWaterPage.routeName),
              title: const Text("???????? ?????? ??????????"),
              leading: Icon(
                Icons.local_drink_outlined,
                color: Theme.of(context).accentColor,
              ),
            ),
            ListTile(
              onTap: () => Navigator.of(context)
                  .pushNamed(DiagnosisKidneyPage.routeName),
              title: const Text("?????????? ?????????? ??????????"),
              leading: Icon(
                Icons.help_center_outlined,
                color: Theme.of(context).accentColor,
              ),
            ),
            ListTile(
              onTap: () =>
                  Navigator.of(context).pushNamed(ProtienFood.routeName),
              title: const Text("?????????????? ????????????????????"),
              leading: Icon(
                Icons.food_bank_outlined,
                color: Theme.of(context).accentColor,
              ),
            ),
            ListTile(
              onTap: () =>
                  Navigator.of(context).pushNamed(PotassiumFood.routeName),
              title: const Text("?????????????? ???????? ??????????????????????"),
              leading: Icon(
                Icons.water_damage_outlined,
                color: Theme.of(context).accentColor,
              ),
            ),
            ListTile(
              onTap: () =>
                  Navigator.of(context).pushNamed(AllowedFood.routeName),
              title: const Text("?????????????? ????????????????"),
              leading: Icon(
                Icons.fastfood_outlined,
                color: Theme.of(context).accentColor,
              ),
            ),
            ListTile(
              onTap: () =>
                  Navigator.of(context).pushNamed(ForbiddenFood.routeName),
              title: const Text("?????????????? ????????????????"),
              leading: Icon(
                Icons.no_food_outlined,
                color: Theme.of(context).accentColor,
              ),
            ),
            ListTile(
              onTap: () =>
                  Navigator.of(context).pushNamed(GlobalAdvicesPage.routeName),
              title: const Text("?????????? ????????"),
              leading: Icon(
                Icons.privacy_tip_outlined,
                color: Theme.of(context).accentColor,
              ),
            ),
            Divider(
              height: 10,
              color: Theme.of(context).primaryColor,
              endIndent: 30,
              indent: 30,
            ),
            ListTile(
              onTap: () {
                context.read<AuthProvider>().signOut();
              },
              title: const Text("?????????? ????????????"),
              leading: Icon(
                Icons.exit_to_app_outlined,
                color: Theme.of(context).accentColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
