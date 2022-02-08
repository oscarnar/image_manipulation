import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image manipulation'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () => controller.onTapClear(),
            icon: Icon(Icons.clear_sharp),
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: GetBuilder<HomeController>(builder: (_) {
        return Center(
          child: (controller.image != null)
              ? GestureDetector(
                  onLongPress: () {},
                  onLongPressStart: (details) {
                    controller.changeStateOriginal(true);
                  },
                  onLongPressEnd: (details) {
                    controller.changeStateOriginal(false);
                  },
                  child: Container(
                    margin: const EdgeInsets.all(20),
                    width: double.infinity,
                    height: double.infinity,
                    child: Image.memory(
                      controller.image!,
                      fit: BoxFit.contain,
                    ),
                  ),
                )
              : InkWell(
                  onTap: () => controller.pickImage(),
                  child: Container(
                    margin: const EdgeInsets.all(20),
                    width: double.infinity,
                    height: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.add_photo_alternate_outlined,
                            size: 60,
                            color: Colors.black,
                          ),
                          const SizedBox(height: 12),
                          Text(
                            'Add image',
                            style: TextStyle(fontSize: 18),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => controller.onTapEdit(),
        child: Icon(Icons.photo_filter),
        tooltip: 'Apply blur filter',
      ),
    );
  }
}
