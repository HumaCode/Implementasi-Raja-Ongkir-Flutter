import 'dart:convert';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:ongkir/app/modules/home/city_model.dart';
import 'package:ongkir/app/modules/home/controllers/home_controller.dart';

class Kota extends GetView<HomeController> {
  const Kota({
    Key? key,
    required this.provId,
    required this.type,
  }) : super(key: key);

  final int provId;
  final String type;

  @override
  Widget build(BuildContext context) {
    return DropdownSearch<City>(
      showClearButton: true,
      searchBoxDecoration: InputDecoration(
        hintText: "cari kota/kabupaten",
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),
        isDense: false,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50),
        ),
      ),
      label:
          type == "asal" ? "Kota / Kabupaten Asal" : "Kota / Kabupaten Tujuan",
      showSearchBox: true,
      onFind: (String filter) async {
        Uri url = Uri.parse(
            "https://api.rajaongkir.com/starter/city?province=$provId");

        try {
          var response = await http.get(url, headers: {
            'key': '3f7e1ce98f309f0acc807d018a341f48',
          });

          // ubah respon string ke bentuk list/map
          var data = jsonDecode(response.body) as Map<String, dynamic>;

          var statusCode = data["rajaongkir"]["status"]["code"];

          // jika statuscode nya tidak sama dengan 200
          if (statusCode != 200) {
            throw data["rajaongkir"]["status"]["description"];
          }

          var listAppCity = data["rajaongkir"]["results"] as List<dynamic>;

          var models = City.fromJsonList(listAppCity);
          return models;
        } catch (e) {
          print(e);
          return List<City>.empty();
        }
      },
      onChanged: (kota) {
        if (kota != null) {
          if (type == "asal") {
            // ambil id dari kota asal
            controller.kotaAsalId.value = int.parse(kota.cityId!);
          } else {
            // ambil id dari kota tujuan
            controller.kotaTujuanId.value = int.parse(kota.cityId!);
          }
        } else {
          if (type == "asal") {
            controller.kotaAsalId.value = 0;
          } else {
            controller.kotaTujuanId.value = 0;
          }
        }

        // jalankan method showButton
        controller.showButton();
      },

      // custom item
      popupItemBuilder: (context, item, isSelected) {
        return Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 10,
          ),
          child: Text(
            "${item.type} ${item.cityName}",
            style: TextStyle(fontSize: 18),
          ),
        );
      },
      itemAsString: (item) => item.cityName!,
    );
  }
}
