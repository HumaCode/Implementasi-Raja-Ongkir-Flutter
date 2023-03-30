import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:ongkir/app/modules/home/courier_model.dart';
import 'package:ongkir/config/app_format.dart';

class HomeController extends GetxController {
  var hiddenKotaAsal = true.obs;
  var provAsalId = 0.obs;
  var kotaAsalId = 0.obs;
  var hiddenKotaTujuan = true.obs;
  var provTujuanId = 0.obs;
  var kotaTujuanId = 0.obs;
  var hiddenButton = true.obs;
  var kurir = "".obs;

  double berat = 0.0;
  String satuan = "gram";

  // validasi button
  void showButton() {
    // cek kota asal dan tujuan dan berat sudah di isi atau belum
    if (kotaAsalId != 0 && kotaTujuanId != 0 && berat > 0 && kurir != "") {
      hiddenButton.value = false;
    } else {
      hiddenButton.value = true;
    }
  }

  // function ongkos kirim
  void ongkosKirim() async {
    Uri url = Uri.parse("https://api.rajaongkir.com/starter/cost");

    try {
      final response = await http.post(url, body: {
        "origin": "$kotaAsalId",
        "destination": "$kotaTujuanId",
        "weight": "$berat",
        "courier": "$kurir",
      }, headers: {
        'key': '3f7e1ce98f309f0acc807d018a341f48',
        'content_type': 'application/x-www-form-urlencoded',
      });

      var data = jsonDecode(response.body) as Map<String, dynamic>;
      var result = data["rajaongkir"]["results"] as List<dynamic>;

      var listAllCourier = CourierModel.fromJsonList(result);

      var courier = listAllCourier[0];

      // tampilkan di dalam dialog
      Get.defaultDialog(
          title: courier.name,
          content: Column(
            children: courier.costs
                .map(
                  (e) => ListTile(
                    title: Text("${e.service}"),
                    subtitle: Text(
                        "${AppFormat.currency(e.cost[0].value.toString())}"),
                    trailing: Text(courier.code == "pos"
                        ? "${e.cost[0].etd}"
                        : "${e.cost[0].etd} HARI"),
                  ),
                )
                .toList(),
          ));
    } catch (e) {
      print(e);

      Get.defaultDialog(
        title: "Terjadi Kesalahan",
        middleText: e.toString(),
      );
    }
  }

  // function ubah berat
  void ubahBerat(String value) {
    berat = double.tryParse(value) ?? 0.0;
    String cekSatuan = satuan;

    switch (cekSatuan) {
      case "ton":
        berat = berat * 1000000;
        break;
      case "kwintal":
        berat = berat * 100000;
        break;
      case "ons":
        berat = berat * 100;
        break;
      case "lbs":
        berat = berat * 2204.62;
        break;
      case "pound":
        berat = berat * 2204.62;
        break;
      case "kg":
        berat = berat * 1000;
        break;
      case "hg":
        berat = berat * 100;
        break;
      case "dag":
        berat = berat * 10;
        break;
      case "gram":
        berat = berat;
        break;
      case "dg":
        berat = berat / 10;
        break;
      case "cg":
        berat = berat / 100;
        break;
      case "mg":
        berat = berat / 1000;
        break;
      default:
        berat = berat;
    }

    print("$berat gram");
    showButton();
  }

  // function ubah satuan
  void ubahSatuan(String value) {
    berat = double.tryParse(beratC.text) ?? 0.0;

    switch (value) {
      case "ton":
        berat = berat * 1000000;
        break;
      case "kwintal":
        berat = berat * 100000;
        break;
      case "ons":
        berat = berat * 100;
        break;
      case "lbs":
        berat = berat * 2204.62;
        break;
      case "pound":
        berat = berat * 2204.62;
        break;
      case "kg":
        berat = berat * 1000;
        break;
      case "hg":
        berat = berat * 100;
        break;
      case "dag":
        berat = berat * 10;
        break;
      case "gram":
        berat = berat;
        break;
      case "dg":
        berat = berat / 10;
        break;
      case "cg":
        berat = berat / 100;
        break;
      case "mg":
        berat = berat / 1000;
        break;
      default:
        berat = berat;
    }

    satuan = value;

    print("$berat gram");
    showButton();
  }

  // inputan
  late TextEditingController beratC;

  @override
  void onInit() {
    beratC = TextEditingController(text: "$berat");
    super.onInit();
  }

  @override
  void onClose() {
    beratC.dispose();
    super.onClose();
  }
}