import 'dart:convert';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ongkir/app/modules/home/controllers/home_controller.dart';
import 'package:ongkir/app/modules/home/province_model.dart';

class Provinsi extends GetView<HomeController> {
  const Provinsi({
    Key? key,
    required this.type,
  }) : super(key: key);

  final String type;

  @override
  Widget build(BuildContext context) {
    return DropdownSearch<Province>(
      dropdownSearchBaseStyle: GoogleFonts.poppins().copyWith(
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
      showClearButton: true,
      searchBoxDecoration: InputDecoration(
        hintText: "cari provinsi",
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),
        isDense: false,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50),
        ),
      ),
      searchBoxStyle: GoogleFonts.poppins(),
      label: type == "asal" ? "Provinsi Asal" : "Provinsi Tujuan",
      showSearchBox: true,

      onFind: (String filter) async {
        Uri url = Uri.parse("https://api.rajaongkir.com/starter/province");

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

          var listAppProvince = data["rajaongkir"]["results"] as List<dynamic>;

          var models = Province.fromJsonList(listAppProvince);
          return models;
        } catch (e) {
          print(e);
          return List<Province>.empty();
        }
      },
      onChanged: (prov) {
        if (prov != null) {
          if (type == "asal") {
            controller.hiddenKotaAsal.value = false;

            // kirim id provinsi
            controller.provAsalId.value = int.parse(prov.provinceId!);
          } else {
            controller.hiddenKotaTujuan.value = false;

            // kirim id provinsi
            controller.provTujuanId.value = int.parse(prov.provinceId!);
          }
        } else {
          if (type == "asal") {
            controller.hiddenKotaAsal.value = true;
            controller.provAsalId.value = 0;
          } else {
            controller.hiddenKotaTujuan.value = true;
            controller.provTujuanId.value = 0;
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
          child: Text("${item.province}"),
        );
      },
      itemAsString: (item) => item.province!,
    );
  }
}
