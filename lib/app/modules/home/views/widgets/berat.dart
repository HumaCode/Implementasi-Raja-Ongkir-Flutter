import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ongkir/app/modules/home/controllers/home_controller.dart';

class BeratBarang extends GetView<HomeController> {
  const BeratBarang({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            autocorrect: false,
            controller: controller.beratC,
            keyboardType: TextInputType.numberWithOptions(decimal: true),
            decoration: InputDecoration(
              labelText: "Berat Barang",
              hintText: "Berat Barang",
              labelStyle: GoogleFonts.poppins().copyWith(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              hintStyle: GoogleFonts.poppins().copyWith(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              border: OutlineInputBorder(),
            ),
            onChanged: (value) => controller.ubahBerat(value),
          ),
        ),
        const SizedBox(width: 10),

        // satuan
        Container(
          width: 150,
          child: DropdownSearch<String>(
            dropdownSearchBaseStyle: GoogleFonts.poppins().copyWith(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            searchBoxDecoration: InputDecoration(
              hintText: "cari satuan berat.",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(50),
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 10,
              ),
              labelStyle: GoogleFonts.poppins().copyWith(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            mode: Mode.BOTTOM_SHEET,
            showSelectedItem: true,
            showSearchBox: true,
            items: [
              "gram",
              "kg",
              "ton",
              'kwintal',
              'ons',
              'pound',
              'lbs',
              'hg',
              'dag',
              'dg',
              'cg',
              'mg',
            ],
            label: "Satuan",
            onChanged: (value) => controller.ubahSatuan(value!),
            selectedItem: "gram",
          ),
        )
      ],
    );
  }
}
