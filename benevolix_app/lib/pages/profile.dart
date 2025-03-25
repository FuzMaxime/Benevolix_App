import 'package:benevolix_app/constants/color.dart';
import 'package:benevolix_app/models/user.dart';
import 'package:benevolix_app/services/user_service.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final UserService userService = UserService();
  late User currentUser;

  bool isEditingPersonalInfo = false;
  bool isEditingPassword = false;

  TextEditingController firstnameController =
      TextEditingController(text: 'John');
  TextEditingController lastnameController = TextEditingController(text: 'Doe');
  TextEditingController emailController =
      TextEditingController(text: 'user@example.com');
  TextEditingController currentPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    try {
      final user = await userService.getUser("1");
      setState(() {
        currentUser = user;
        firstnameController.text = user.lastName;
        lastnameController.text = user.lastName;
        emailController.text = user.email;
      });
    } catch (e) {
      print("Error loading user data: $e");
    }
  }

  void handleEditPersonalInfos() async {
    if (isEditingPersonalInfo) {
      try {
        final updatedUser = User(
          id: currentUser.id,
          email: emailController.text,
          firstName: firstnameController.text,
          lastName: lastnameController.text,
        );
        await userService.updateUser(currentUser.id, updatedUser);
        setState(() {
          currentUser = updatedUser;
          isEditingPersonalInfo = false;
        });
      } catch (e) {
        print("Error updating user info: $e");
      }
    } else {
      setState(() {
        isEditingPersonalInfo = true;
      });
    }
  }

  void handleEditPassword() {
    setState(() {
      isEditingPassword = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  border: Border.all(color: ColorConstant.lightGrey, width: 2),
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(radius: 40, backgroundColor: Colors.grey),
                    SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              firstnameController.text,
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(width: 5),
                            Text(
                              lastnameController.text,
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Text(
                          emailController.text,
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    )
                  ],
                ),
              ),

              SizedBox(height: 20),

              // Personal Information
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    border:
                        Border.all(color: ColorConstant.lightGrey, width: 2),
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Personal Information",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        isEditingPersonalInfo
                            ? Row(
                                children: [
                                  IconButton(
                                    onPressed: () => setState(
                                      () {
                                        isEditingPersonalInfo = false;
                                      },
                                    ),
                                    icon: Icon(
                                      Icons.close,
                                      color: Colors.black,
                                      size: 25,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: handleEditPersonalInfos,
                                    icon: Icon(
                                      Icons.check_circle,
                                      color: ColorConstant.black,
                                      size: 25,
                                    ),
                                  ),
                                ],
                              )
                            : IconButton(
                                onPressed: () => setState(
                                  () {
                                    isEditingPersonalInfo = true;
                                  },
                                ),
                                icon: Icon(
                                  Icons.edit,
                                  color: ColorConstant.black,
                                  size: 25,
                                ),
                              ),
                      ],
                    ),
                    if (isEditingPersonalInfo)
                      Column(
                        children: [
                          Row(children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("First Name:"),
                                  SizedBox(height: 5),
                                  SizedBox(
                                    height: 45,
                                    child: TextField(
                                      controller: firstnameController,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: ColorConstant.lightGrey,
                                              width: 1),
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                        contentPadding: EdgeInsets.symmetric(
                                            vertical: 10, horizontal: 10),
                                        hintText: "First name",
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Last Name:"),
                                  SizedBox(height: 5),
                                  SizedBox(
                                    height: 45,
                                    child: TextField(
                                      controller: lastnameController,
                                      decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: ColorConstant.lightGrey,
                                                width: 1),
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                          contentPadding: EdgeInsets.symmetric(
                                              vertical: 10, horizontal: 10),
                                          hintText: "Last name"),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ]),
                          SizedBox(height: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Email:"),
                              SizedBox(height: 5),
                              SizedBox(
                                height: 45,
                                child: TextField(
                                  controller: emailController,
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: ColorConstant.lightGrey,
                                            width: 1),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: 10, horizontal: 10),
                                      hintText: "Email"),
                                ),
                              ),
                            ],
                          ),
                        ],
                      )
                    else
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.5 -
                                    15,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("First Name: "),
                                    SizedBox(height: 5),
                                    Text(firstnameController.text),
                                  ],
                                ),
                              ),
                              SizedBox(width: 10),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.4 -
                                    15,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Last Name: "),
                                    SizedBox(height: 5),
                                    Text(lastnameController.text),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Email: "),
                              SizedBox(height: 5),
                              Text(emailController.text),
                            ],
                          ),
                        ],
                      ),
                  ],
                ),
              ),

              SizedBox(height: 20),

              // Change Password
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    border:
                        Border.all(color: ColorConstant.lightGrey, width: 2),
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Change Password",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        isEditingPassword
                            ? Row(
                                children: [
                                  IconButton(
                                    onPressed: () => setState(() {
                                      isEditingPassword = false;
                                    }),
                                    icon: Icon(
                                      Icons.close,
                                      color: Colors.black,
                                      size: 25,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: handleEditPassword,
                                    icon: Icon(
                                      Icons.check_circle,
                                      color: ColorConstant.black,
                                      size: 25,
                                    ),
                                  ),
                                ],
                              )
                            : IconButton(
                                onPressed: () => setState(
                                  () {
                                    isEditingPassword = true;
                                  },
                                ),
                                icon: Icon(
                                  Icons.edit,
                                  color: ColorConstant.black,
                                  size: 25,
                                ),
                              ),
                      ],
                    ),
                    if (isEditingPassword)
                      Column(
                        children: [
                          Row(children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Current Password:"),
                                  SizedBox(height: 5),
                                  SizedBox(
                                    height: 45,
                                    child: TextField(
                                      controller: currentPasswordController,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: ColorConstant.lightGrey,
                                              width: 1),
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                        contentPadding: EdgeInsets.symmetric(
                                            vertical: 10, horizontal: 10),
                                        hintText: "Current password",
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("New Password:"),
                                  SizedBox(height: 5),
                                  SizedBox(
                                    height: 45,
                                    child: TextField(
                                      controller: newPasswordController,
                                      decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: ColorConstant.lightGrey,
                                                width: 1),
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                          contentPadding: EdgeInsets.symmetric(
                                              vertical: 10, horizontal: 10),
                                          hintText: "New password"),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ]),
                          SizedBox(height: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Confirm New Password:"),
                              SizedBox(height: 5),
                              SizedBox(
                                height: 45,
                                child: TextField(
                                  controller: confirmPasswordController,
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: ColorConstant.lightGrey,
                                            width: 1),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: 10, horizontal: 10),
                                      hintText: "Confirm new password"),
                                ),
                              ),
                            ],
                          ),
                        ],
                      )
                    else
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Current Password:"),
                          SizedBox(height: 5),
                          Text("**********"),
                        ],
                      ),
                  ],
                ),
              ),

              SizedBox(height: 20),

              // Account Actions
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    border:
                        Border.all(color: ColorConstant.lightGrey, width: 2),
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Account",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.transparent,
                                side:
                                    BorderSide(color: ColorConstant.lightGrey),
                                shadowColor: Colors.transparent,
                                minimumSize: Size(100, 35),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5))),
                            child: Text(
                              "Delete Account",
                              style: TextStyle(
                                color: ColorConstant.red,
                              ),
                            )),
                        SizedBox(width: 20),
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                              shadowColor: Colors.transparent,
                              backgroundColor: Colors.transparent,
                              side: BorderSide(color: ColorConstant.lightGrey),
                              minimumSize: Size(100, 35),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5))),
                          child: Text(
                            "Log out",
                            style: TextStyle(
                              color: ColorConstant.lightGrey,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
