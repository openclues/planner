import 'dart:async';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:image_picker/image_picker.dart';
import 'package:planner/common_presentation/buttons.dart';
import 'package:planner/common_presentation/messages_helper.dart';
import 'package:planner/modules/auth_module/presentation/widgets/auth_widget_field.dart';
import 'package:planner/modules/loading_module/bloc/loading_bloc.dart';
import 'package:planner/modules/user_module/bloc/user_bloc.dart';
import 'package:planner/theme/size_settings.dart';

import '../../user_module/data/user_model.dart';

class CompleteProfile extends StatefulWidget {
  const CompleteProfile({super.key});

  @override
  State<CompleteProfile> createState() => _CompleteProfileState();
}

class _CompleteProfileState extends State<CompleteProfile> {
  String? _firstName;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? _lastName;

  var _email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
              top: SizeSettings.heightMultiplier * 4,
              left: SizeSettings.heightMultiplier,
              right: SizeSettings.heightMultiplier),
          child: BlocListener<UserBloc, UserState>(
            listener: (context, state) {
              if (state is UpdateUserInformationLoading) {
                MessageHelper.showLoading(context);
              }
              if (state is UpdateUserInformationLoaded) {
                MessageHelper.hideLoading(context);
                MessageHelper.showSuccess(
                    context, "Profile Information Were completed");
                Navigator.of(context).pushNamed("/");
              }
              if (state is UpdateUserInformationError) {
                MessageHelper.showError(context, "Something wrong happened");
              }
            },
            child: Form(
              key: _formKey,
              child: Column(children: [
                SizeSettings.smalPaddingHeightWidgetMulti(5),
                const Text("Complete your profile Information"),
                SizeSettings.smalPaddingHeightWidgetMulti(5),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ProfilePictureWidget(
                    imageUrl: (context.read<LoadingBloc>().state
                            as LoadingUserIncompleteProfile)
                        .user
                        .picImage,
                    placeholderAsset: "assets/user.png",
                    size: SizeSettings.screenWidth! * 0.4,
                    user: (context.read<LoadingBloc>().state
                            as LoadingUserIncompleteProfile)
                        .user,
                  ),
                ),
                AuthTextFieldWidget(
                  suffix: const Icon(IconlyLight.profile),
                  hintText: "First name",
                  validator: (v) {
                    if (v == null || v.isEmpty) {
                      return "You have to write your first name";
                    }
                    return null;
                  },
                  onSaved: (v) {
                    setState(() {
                      _firstName = v;
                    });
                    return null;
                  },
                ),
                AuthTextFieldWidget(
                  suffix: const Icon(IconlyLight.profile),
                  hintText: "Last name",
                  validator: (v) {
                    if (v == null || v.isEmpty) {
                      return "You have to write your last name";
                    }
                    return null;
                  },
                  onSaved: (v) {
                    setState(() {
                      _lastName = v;
                    });
                    return null;
                  },
                ),
                SizeSettings.smalPaddingHeightWidgetMulti(3),
                SizeSettings.smalPaddingHeightWidgetMulti(3),
                PrimaryButton(
                  buttonText: "Complete your profile",
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      context.read<UserBloc>().add(UpdateUserInformationEvent(
                          firstName: _firstName!,
                          lastName: _lastName!,
                          email: "_email"!));
                    }
                  },
                )
              ]),
            ),
          ),
        ),
      ),
    );
  }
}

class ProfilePictureWidget extends StatefulWidget {
  final String? imageUrl;
  final double size;
  final User user;
  final String placeholderAsset;
  final VoidCallback? onEditPressed;

  ProfilePictureWidget({
    required this.imageUrl,
    required this.size,
    required this.user,
    required this.placeholderAsset,
    this.onEditPressed,
  });

  @override
  _ProfilePictureWidgetState createState() => _ProfilePictureWidgetState();
}

class _ProfilePictureWidgetState extends State<ProfilePictureWidget> {
  XFile? _selectedImage;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(shape: BoxShape.circle),
          width: widget.size,
          height: widget.size,
          child: BlocListener<UserBloc, UserState>(
            listener: (context, state) {
              if (state is UpdateUserImageLoading) {
                MessageHelper.showLoading(context);
              }
              if (state is UpdateUserImageLoaded) {
                MessageHelper.hideLoading(context);
                MessageHelper.showSuccess(
                    context, "Profile Image was uploaded");
              }
              if (state is UpdateUserImageError) {
                MessageHelper.hideLoading(context);
                MessageHelper.showError(context, state.error);
              }
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(widget.size),
              child: _selectedImage != null
                  ? Image.file(
                      File(_selectedImage!.path),
                      width: widget.size,
                      height: widget.size,
                      fit: BoxFit.cover,
                    )
                  : (widget.imageUrl != null
                      ? Container(
                          decoration: BoxDecoration(boxShadow: [
                            BoxShadow(
                                color: Theme.of(context).primaryColor,
                                blurRadius: 0.3,
                                spreadRadius: 0.3)
                          ]),
                          child: CachedNetworkImage(
                            placeholder: (context, url) =>
                                CircularProgressIndicator(
                              color: Theme.of(context).primaryColor,
                            ),
                            imageUrl: widget.imageUrl!,
                            width: widget.size,
                            height: widget.size,
                            fit: BoxFit.cover,
                          ),
                        )
                      : Image.asset(
                          "assets/user.png",
                          width: widget.size,
                          height: widget.size,
                          fit: BoxFit.cover,
                        )),
            ),
          ),
        ),
        Positioned(
          top: 0,
          right: 10,
          child: InkWell(
            onTap: () {
              showModalBottomSheet(
                context: context,
                builder: (_) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ListTile(
                        leading: const Icon(Icons.photo_library),
                        title: const Text('Choose from gallery'),
                        onTap: () async {
                          XFile? image = await _pickImage(ImageSource.gallery);
                          if (image != null) {
                            await _showImageConfirmation(image).then((value) {
                              if (value == true) {
                                context
                                    .read<UserBloc>()
                                    .add(UpdateUserImageEvent(image: image));
                                Navigator.of(context).pop();
                                setState(() {
                                  _selectedImage = image;
                                });

                                return value;
                              } else {
                                return value;
                              }
                            });
                          }
                        },
                      ),
                      ListTile(
                        leading: const Icon(Icons.camera_alt),
                        title: const Text('Take a photo'),
                        onTap: () async {
                          Navigator.pop(context);
                          XFile? image = await _pickImage(ImageSource.camera);
                          if (image != null) {
                            bool confirmed =
                                await _showImageConfirmation(image);
                            if (confirmed == true) {
                              setState(() {
                                _selectedImage = image;
                              });
                              Navigator.of(context).pop();
                            }
                            print(_selectedImage);
                          }
                        },
                      ),
                    ],
                  );
                },
              );
            },
            child: Container(
              width: 35,
              height: 35,
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(
                    color: Theme.of(context).primaryColor, blurRadius: 0.3)
              ], borderRadius: BorderRadius.circular(100), color: Colors.white),
              child: const Icon(
                IconlyBold.camera,
                color: Colors.black,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Future<XFile?> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: source);
    if (pickedImage != null) {
      return pickedImage;
    } else {
      return null;
    }
  }

  Future<bool> _showImageConfirmation(XFile image) async {
    Completer<bool> completer = Completer<bool>();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Image'),
          content: Image.file(
            File(image.path),
            fit: BoxFit.cover,
          ),
          actions: [
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                completer.complete(false);
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.resolveWith<Color>(
                  (Set<MaterialState> states) {
                    if (states.contains(MaterialState.disabled)) {
                      return Theme.of(context)
                          .primaryColor; // Set the disabled color
                    }
                    return Theme.of(context)
                        .primaryColor; // Set the default color
                  },
                ),
              ),
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Confirm',
                ),
              ),
              onPressed: () {
                completer.complete(true);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );

    return completer.future;
  }
}
