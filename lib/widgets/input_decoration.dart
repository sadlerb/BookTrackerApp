  import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

InputDecoration formInputDecoraton({required String label, required String hintText}) {
    return InputDecoration(
                                  fillColor: Colors.white,
                                  focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.blue),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: HexColor('#69639F')),
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                  labelText: label ,
                                  hintText: hintText
                                );
  }
