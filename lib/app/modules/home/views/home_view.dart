import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ongkir/app/modules/home/views/widgets/berat.dart';
import 'package:ongkir/app/modules/home/views/widgets/kota.dart';
import 'package:ongkir/app/modules/home/views/widgets/province.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'CEK ONGKIR SELURUH INDONESIA',
          style: GoogleFonts.poppins(),
        ),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 0, 121, 84),
        elevation: 0,
      ),
      body: SafeArea(
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/img/regal.jpg"), fit: BoxFit.cover),
          ),
          child: ListView(
            padding: const EdgeInsets.all(20),
            children: [
              // provinsi asal
              Provinsi(type: "asal"),

              const SizedBox(height: 10),

              // kota Asal
              Obx(
                () => controller.hiddenKotaAsal.isTrue
                    ? SizedBox()
                    : Kota(
                        provId: controller.provAsalId.value,
                        type: "asal",
                      ),
              ),

              const SizedBox(height: 10),

              // provinsi tujuan
              Provinsi(type: "tujuan"),

              const SizedBox(height: 10),

              // kota Tujuan
              Obx(
                () => controller.hiddenKotaTujuan.isTrue
                    ? SizedBox()
                    : Kota(
                        provId: controller.provTujuanId.value,
                        type: "tujuan",
                      ),
              ),

              const SizedBox(height: 10),

              // inputan berat
              BeratBarang(),

              const SizedBox(height: 10),

              // kurir
              DropdownSearch<Map<String, dynamic>>(
                dropdownSearchBaseStyle: GoogleFonts.poppins().copyWith(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                mode: Mode.DIALOG,
                showClearButton: true,
                items: [
                  {
                    "code": "jne",
                    "name": "Jalur Nugraha Ekakurir (JNE)",
                  },
                  {
                    "code": "tiki",
                    "name": "Titipan Kilat (TIKI)",
                  },
                  {
                    "code": "pos",
                    "name": "Perusahaan Opsional Surat (POS)",
                  }
                ],
                label: "Kurir",
                hint: "pilih kurir",
                onChanged: (value) {
                  // cek ada valuenya ata tidak
                  if (value != null) {
                    controller.kurir.value = value["code"];

                    // jalankan method showButton
                    controller.showButton();
                  } else {
                    controller.hiddenButton.value = true;
                    controller.kurir.value = "";
                  }
                },
                itemAsString: (item) => "${item['name']}",
                popupItemBuilder: (context, item, isSelected) => Container(
                  padding: const EdgeInsets.all(20),
                  child: Text(
                    "${item['name']}",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // tombol
              Obx(
                () => controller.hiddenButton.isTrue
                    ? SizedBox()
                    : ElevatedButton(
                        onPressed: () => controller.ongkosKirim(),
                        child: Text(
                          "CEK ONGKOS KIRIM",
                          style: TextStyle(fontSize: 15),
                        ),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          backgroundColor: Color.fromARGB(255, 0, 121, 84),
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
