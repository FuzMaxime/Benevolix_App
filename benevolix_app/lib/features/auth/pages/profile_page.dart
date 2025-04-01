import 'package:benevolix_app/features/auth/services/auth_service.dart';
import 'package:benevolix_app/features/auth/services/user_service.dart';
import 'package:benevolix_app/features/auth/widgets/profile_input_widget.dart';
import 'package:benevolix_app/features/auth/widgets/profile_section_widget.dart';
import 'package:flutter/material.dart';

import '../../../core/constants/color.dart';
import '../models/user_model.dart';
import '../widgets/profile_picture_widget.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  ProfilePageState createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage> {
  final UserService userService = UserService();

  User? currentUser;

  Future<String?> currentUserId = getUserId();
  String? userId;

  bool isEditingPersonalInfo = false;
  bool isEditingPassword = false;
  bool isReadOnly = false;


  bool errorPersonalInfo = false;
  String errorPersonalInfoMessage = "";

  bool errorPassword = false;
  String errorPasswordMessage = "";

  bool globalError = false;
  String globalErrorMessage = "";

  TextEditingController firstnameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController currentPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final args = ModalRoute.of(context)?.settings.arguments as String?;
      setState(() {
        if (args != null) {
          userId = args;
        }
      });
      _loadUserData();
      _isReadOnlyUser();
    });
  }

  // Load user data from the service
  Future<void> _loadUserData() async {
    globalError = false;
    try {
      final user = await userService.getUser(userId ?? (await currentUserId)!);
      setState(() {
        currentUser = user;
        firstnameController.text = user.firstName;
        lastnameController.text = user.lastName;
        emailController.text = user.email;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        globalError = true;
        globalErrorMessage = e.toString();
      });
    }
  }

  // Check if the user is the current user
  Future<void> _isReadOnlyUser() async {
    final id = await currentUserId;
    if (id != null) {
      setState(() {
        if (userId != null) {
          isReadOnly = id != userId;
        }
      });
    }
  }

  // Handle editing personal information
  void handleEditPersonalInfos() async {
    setState(() {
      errorPersonalInfo = false;
    });
    if (isEditingPersonalInfo) {
      try {
        final userId = await currentUserId;
        final updatedUser = User(
          id: currentUser!.id,
          email: emailController.text,
          firstName: firstnameController.text,
          lastName: lastnameController.text,
          phone: currentUser!.phone,
          city: currentUser!.city,
          bio: currentUser!.bio,
          password: currentUser!.password,
          tags: currentUser!.tags,
        );
        await userService.updateUser(userId!, updatedUser);
        setState(() {
          currentUser = updatedUser;
          isEditingPersonalInfo = false;
          errorPersonalInfo = false;
          errorPersonalInfoMessage = "";
        });
      } catch (e) {
        setState(() {
          errorPersonalInfo = true;
          errorPersonalInfoMessage = e.toString();
        });
      }
    } else {
      setState(() {
        isEditingPersonalInfo = true;
      });
    }
  }

  // Handle canceling the edit of personal information
  void handleCandelEditPersonalInfos() {
    setState(() {
      isEditingPersonalInfo = false;
      firstnameController.text = currentUser!.firstName;
      lastnameController.text = currentUser!.lastName;
      emailController.text = currentUser!.email;
      errorPersonalInfo = false;
      errorPersonalInfoMessage = "";
    });
  }

  // Handle editing the password
  void handleEditPassword() async {
    if (isEditingPassword) {
      if (newPasswordController.text != confirmPasswordController.text) {
        setState(() {
          errorPassword = true;
          errorPasswordMessage =
              "Les champs de nouveau mot de passe et de confirmation doivent être identiques !";
        });
        return;
      }
      try {
        final userId = await currentUserId;
        await userService.updatePassword(userId!,
            currentPasswordController.text, newPasswordController.text);
        setState(() {
          isEditingPassword = false;
          errorPassword = false;
          errorPasswordMessage = "";
        });
      } catch (e) {
        setState(() {
          errorPassword = true;
          errorPasswordMessage = e.toString();
        });
      }
    } else {
      setState(() {
        isEditingPassword = true;
      });
    }
  }

  // Handle canceling the edit of the password
  void handleCancelEditPassword() {
    setState(() {
      isEditingPassword = false;
      currentPasswordController.text = "";
      newPasswordController.text = "";
      confirmPasswordController.text = "";
      errorPassword = false;
      errorPasswordMessage = "";
    });
  }

  // Handle account deletion
  void handleDeleteAccount() {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text("Supprimer le compte"),
          content: Text("Êtes-vous sûr de vouloir supprimer votre compte ?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Annuler"),
            ),
            TextButton(
              onPressed: () async {
                try {
                  final userId = await currentUserId;
                  if (userId != null) {
                    await userService.deleteUser(userId);
                    await logout();
                    if (!mounted) return;
                    Navigator.pushReplacementNamed(context, '/login');
                  } else {
                    setState(() {
                      globalError = true;
                      globalErrorMessage = "Erreur lors de la suppression du compte";
                    });
                  }
                } catch (e) {
                  if (!mounted) return;
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Erreur lors de la suppression du compte : $e"),
                      backgroundColor: ColorConstant.red,
                    ),
                  );
                }
              },
              child: Text("Supprimer"),
            ),
          ],
        );
      },
    );
  }

  // Handle user logout
  void handleLogout() async {
    await logout();
    if (!mounted) return;
    Navigator.pushReplacementNamed(context, '/login');
  }

  // Capitalize the first letter of a string
  String _capitalize(String text) {
    if (text.isEmpty) return text;
    return text[0].toUpperCase() + text.substring(1).toLowerCase();
  }

  @override
  Widget build(BuildContext context) {
    // Display an error message if there was an issue loading the user
    if (globalError) {
      return Scaffold(
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Erreur : $globalErrorMessage"),
                SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorConstant.red,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("Retour",
                      style: TextStyle(color: ColorConstant.white)),
                ),
              ],
            ),
          ),
        ),
      );
    }

    // Display a loading indicator while the user data is being fetched
    if (currentUser == null) {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(
            color: ColorConstant.red,
          ),
        ),
      );
    }

    // Display the user profile once the data is loaded
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header with user profile picture and name
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
                    ProfilePicture(
                        id: userId ?? currentUser!.id.toString(),
                        firstName: currentUser!.firstName,
                        lastName: currentUser!.lastName,
                        size: AvatarSize.big),
                    SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              _capitalize(firstnameController.text),
                              style: TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(width: 5),
                            Text(
                              _capitalize(lastnameController.text),
                              style: TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Text(
                          emailController.text,
                          style: TextStyle(color: ColorConstant.grey),
                        ),
                      ],
                    )
                  ],
                ),
              ),

              SizedBox(height: 20),

              // Personal Information Section
              ProfileSection(
                title: "Informations Personnelles",
                isEditing: isEditingPersonalInfo,
                isReadOnly: isReadOnly,
                onEdit: () => setState(() => isEditingPersonalInfo = true),
                onCancel: handleCandelEditPersonalInfos,
                onSave: handleEditPersonalInfos,
                content: isEditingPersonalInfo
                    ? Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: ProfileInput(
                                  label: "Prénom :",
                                  controller: firstnameController,
                                  hintText: "Prénom",
                                  error: errorPersonalInfo,
                                ),
                              ),
                              SizedBox(width: 10),
                              Expanded(
                                child: ProfileInput(
                                  label: "Nom :",
                                  controller: lastnameController,
                                  hintText: "Nom",
                                  error: errorPersonalInfo,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          ProfileInput(
                            label: "Email :",
                            controller: emailController,
                            hintText: "Email",
                            error: errorPersonalInfo,
                          ),
                          SizedBox(height: 5),
                          if (errorPersonalInfo)
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Text(
                                errorPersonalInfoMessage,
                                style: TextStyle(color: ColorConstant.red),
                              ),
                            ),
                        ],
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                width:
                                    MediaQuery.of(context).size.width * 0.46 -
                                        15,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Prénom : ",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600),
                                    ),
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
                                    Text(
                                      "Nom : ",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600),
                                    ),
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
                              Text(
                                "Email : ",
                                style: TextStyle(fontWeight: FontWeight.w600),
                              ),
                              SizedBox(height: 5),
                              Text(emailController.text),
                            ],
                          ),
                        ],
                      ),
              ),

              SizedBox(height: 20),

              // Change Password Section
              isReadOnly
                  ? Container()
                  : ProfileSection(
                      title: "Changer le Mot de Passe",
                      isEditing: isEditingPassword,
                      isReadOnly: isReadOnly,
                      onEdit: () => setState(() => isEditingPassword = true),
                      onCancel: handleCancelEditPassword,
                      onSave: handleEditPassword,
                      content: isEditingPassword
                          ? Column(
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: ProfileInput(
                                        label: "Mot de Passe Actuel :",
                                        controller: currentPasswordController,
                                        hintText: "Mot de passe actuel",
                                        isPassword: true,
                                        error: errorPassword,
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    Expanded(
                                      child: ProfileInput(
                                        label: "Nouveau Mot de Passe :",
                                        controller: newPasswordController,
                                        hintText: "Nouveau mot de passe",
                                        isPassword: true,
                                        error: errorPassword,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10),
                                ProfileInput(
                                  label: "Confirmer le Nouveau Mot de Passe :",
                                  controller: confirmPasswordController,
                                  hintText: "Confirmer le nouveau mot de passe",
                                  isPassword: true,
                                  error: errorPassword,
                                ),
                                SizedBox(height: 5),
                                if (errorPassword)
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: Text(
                                      errorPasswordMessage,
                                      style:
                                          TextStyle(color: ColorConstant.red),
                                    ),
                                  ),
                              ],
                            )
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Mot de Passe Actuel : ",
                                  style: TextStyle(fontWeight: FontWeight.w600),
                                ),
                                SizedBox(height: 5),
                                Text("**********"),
                              ],
                            ),
                    ),

              SizedBox(height: 20),

              // Account Actions
              isReadOnly
                  ? Container()
                  : SizedBox(
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: ColorConstant.lightGrey, width: 2),
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Compte",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 15),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ElevatedButton(
                                  onPressed: handleDeleteAccount,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.transparent,
                                    side: BorderSide(
                                        color: ColorConstant.lightGrey),
                                    shadowColor: Colors.transparent,
                                    minimumSize: Size(100, 35),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                  ),
                                  child: Text(
                                    "Supprimer le Compte",
                                    style: TextStyle(
                                      color: ColorConstant.red,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 20),
                                ElevatedButton(
                                  onPressed: handleLogout,
                                  style: ElevatedButton.styleFrom(
                                    shadowColor: Colors.transparent,
                                    backgroundColor: Colors.transparent,
                                    side: BorderSide(
                                        color: ColorConstant.lightGrey),
                                    minimumSize: Size(100, 35),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                  ),
                                  child: Text(
                                    "Se déconnecter",
                                    style: TextStyle(
                                      color: ColorConstant.lightGrey,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                  ),
            ],
          ),
        ),
      ),
    );
  }
}
