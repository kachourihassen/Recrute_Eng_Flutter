import 'package:flutter/material.dart';
import 'package:gestionuser/Pages/SignUpPage.dart';
import 'package:gestionuser/Pages/WelcomPage.dart';
import 'package:linkedin_login/linkedin_login.dart';

import 'SignUpLinkedInPage.dart';

final String redirectUrl = 'https://app.carde.de';
final String clientId = '776rnw4e4izlvg';
final String clientSecret = 'rQEgboUHMLcQi59v';

class LinkedIn extends StatefulWidget {
  LinkedIn({Key key}) : super(key: key);

  @override
  _LinkedInState createState() => _LinkedInState();
}

class _LinkedInState extends State<LinkedIn> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LinkedIn',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
                icon: Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () => Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => WelcomePage()),
                    (route) => false)),
            title: const Text('LinkedIn Profile'),
          ),
          body: TabBarView(
            children: [
              LinkedInProfileExamplePage(),
              LinkedInAuthCodeExamplePage(),
            ],
          ),
        ),
      ),
    );
  }
}

class LinkedInProfileExamplePage extends StatefulWidget {
  @override
  State createState() => _LinkedInProfileExamplePageState();
}

class _LinkedInProfileExamplePageState
    extends State<LinkedInProfileExamplePage> {
  UserObject user;
  bool logoutUser = false;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            LinkedInButtonStandardWidget(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => LinkedInUserWidget(
                      appBar: AppBar(
                        title: Text('OAuth User'),
                      ),
                      destroySession: logoutUser,
                      redirectUrl: redirectUrl,
                      clientId: clientId,
                      clientSecret: clientSecret,
                      projection: [
                        ProjectionParameters.id,
                        ProjectionParameters.localizedFirstName,
                        ProjectionParameters.localizedLastName,
                        ProjectionParameters.firstName,
                        ProjectionParameters.lastName,
                        ProjectionParameters.profilePicture,
                      ],
                      onGetUserProfile: (LinkedInUserModel linkedInUser) {
                        user = UserObject(
                          firstName: linkedInUser?.firstName?.localized?.label,
                          lastName: linkedInUser?.lastName?.localized?.label,
                          email: linkedInUser
                              ?.email?.elements[0]?.handleDeep?.emailAddress,
                          profileImageUrl: linkedInUser
                              ?.profilePicture
                              ?.displayImageContent
                              ?.elements[0]
                              ?.identifiers[0]
                              ?.identifier,
                        );

                        setState(() {
                          logoutUser = false;
                        });

                        Navigator.pop(context);
                      },
                      catchError: (LinkedInErrorObject error) {
                        print('Error description: ${error.description},'
                            ' Error code: ${error.statusCode.toString()}');
                        Navigator.pop(context);
                      },
                    ),
                    fullscreenDialog: true,
                  ),
                );
              },
            ),
            LinkedInButtonStandardWidget(
              onTap: () {
                setState(() {
                  user = null;
                  logoutUser = true;
                });
              },
              buttonText: 'Logout',
            ),
            Container(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('First: ${user?.firstName} '),
                  Text('Last: ${user?.lastName} '),
                  Text('Email: ${user?.email}'),
                  //Text('Profile image: ${user?.profileImageUrl}'),
                ],
              ),
            ),
            LinkedInButtonStandardWidget(
              onTap: () {
                String firstName = user?.firstName;
                String email = user?.email;
                setState(() {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          SignUpLinkedInPage(firstName, email)));
                });
              },
              buttonText: 'Sign Up with Role ',
            ),
          ]),
    );
  }
}

class LinkedInAuthCodeExamplePage extends StatefulWidget {
  @override
  State createState() => _LinkedInAuthCodeExamplePageState();
}

class _LinkedInAuthCodeExamplePageState
    extends State<LinkedInAuthCodeExamplePage> {
  AuthCodeObject authorizationCode;
  bool logoutUser = false;

  @override
  Widget build(BuildContext context) {
    // return Column(
    //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //   crossAxisAlignment: CrossAxisAlignment.center,
    //   mainAxisSize: MainAxisSize.max,
    //   children: <Widget>[
    //     LinkedInButtonStandardWidget(
    //       onTap: () {
    //         Navigator.push(
    //           context,
    //           MaterialPageRoute(
    //             builder: (BuildContext context) => LinkedInAuthCodeWidget(
    //               destroySession: logoutUser,
    //               redirectUrl: redirectUrl,
    //               clientId: clientId,
    //               onGetAuthCode: (AuthorizationCodeResponse response) {
    //                 print('Auth code ${response.code}');

    //                 print('State: ${response.state}');

    //                 authorizationCode = AuthCodeObject(
    //                   code: response.code,
    //                   state: response.state,
    //                 );
    //                 setState(() {});

    //                 Navigator.pop(context);
    //               },
    //               catchError: (LinkedInErrorObject error) {
    //                 print('Error description: ${error.description},'
    //                     ' Error code: ${error.statusCode.toString()}');
    //                 Navigator.pop(context);
    //               },
    //             ),
    //             fullscreenDialog: true,
    //           ),
    //         );
    //       },
    //     ),
    //     LinkedInButtonStandardWidget(
    //       onTap: () {
    //         setState(() {
    //           authorizationCode = null;
    //           logoutUser = true;
    //         });
    //       },
    //       buttonText: 'Logout user',
    //     ),
    //     Container(
    //       margin: EdgeInsets.symmetric(horizontal: 16),
    //       child: Column(
    //         mainAxisSize: MainAxisSize.max,
    //         mainAxisAlignment: MainAxisAlignment.center,
    //         children: <Widget>[
    //           Text('Auth code: ${authorizationCode?.code} '),
    //           Text('State: ${authorizationCode?.state} '),
    //         ],
    //       ),
    //     ),
    //   ],
    // );
  }
}

class AuthCodeObject {
  String code, state;

  AuthCodeObject({this.code, this.state});
}

class UserObject {
  String firstName, lastName, email, profileImageUrl;

  UserObject({this.firstName, this.lastName, this.email, this.profileImageUrl});
}
