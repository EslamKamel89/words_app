// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:words_app/core/extensions/context-extensions.dart';
// import 'package:words_app/features/home/cubits/roots_index_cubit.dart';
// import 'package:words_app/features/home/entities/word_entity.dart';

// class WordBadge extends StatefulWidget {
//   const WordBadge({super.key, required this.word, this.clickable = false});
//   final WordEntity word;
//   final bool clickable;
//   @override
//   State<WordBadge> createState() => _WordBadgeState();
// }

// class _WordBadgeState extends State<WordBadge> {
//   late final RootsIndexCubit rootsController;
//   @override
//   void initState() {
//     rootsController = context.read<RootsIndexCubit>();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     // Color color = _getRandomColor(context);
//     return widget.word.wordTashkeel != null && widget.word.wordTashkeel!.isNotEmpty
//         ? InkWell(
//           onTap: () async {
//             if (!widget.clickable) return;
//             FocusScope.of(context).unfocus();
//             Navigator.of(context).pop();
//             rootsController.searchInput.text = widget.word.wordTashkeel ?? '';
//             //   await Future.delayed(500.ms);
//             //   showDialog(
//             //     context: context,
//             //     builder: (context) {
//             //       return Dialog(
//             //         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//             //         elevation: 0,
//             //         backgroundColor: Colors.transparent,
//             //         child: Container(
//             //           padding: const EdgeInsets.all(20),
//             //           decoration: BoxDecoration(
//             //             color: Colors.white,
//             //             borderRadius: BorderRadius.circular(16),
//             //             boxShadow: [
//             //               BoxShadow(
//             //                 color: Colors.black.withOpacity(0.1),
//             //                 blurRadius: 15,
//             //                 offset: const Offset(0, 4),
//             //               ),
//             //             ],
//             //           ),
//             //           child: Column(
//             //             mainAxisSize: MainAxisSize.min,
//             //             crossAxisAlignment: CrossAxisAlignment.start,
//             //             children: [
//             //               // Title
//             //               Align(
//             //                 alignment: Alignment.centerRight,
//             //                 child: Text(
//             //                   "تفاصيل الكلمة",
//             //                   style: const TextStyle(
//             //                     fontSize: 20,
//             //                     fontWeight: FontWeight.bold,
//             //                     fontFamily: 'NotoSansArabic',
//             //                   ),
//             //                 ).animate().fadeIn(duration: 400.ms).slideY(begin: -0.2),
//             //               ),
//             //               const SizedBox(height: 20),

//             //               // Data Rows
//             //               DetailRow(
//             //                 "الكلمة الأصل",
//             //                 widget.word.rootOrigin ?? '',
//             //               ).animate().moveX(begin: -0.3, duration: 500.ms).then().fadeIn(),
//             //               DetailRow(
//             //                 "اسم الكلمة الأصل",
//             //                 widget.word.rootName ?? '',
//             //               ).animate().moveX(begin: -0.3, duration: 600.ms).then().fadeIn(),
//             //               DetailRow(
//             //                 "كلمة مرتبطة بدون تشكيل",
//             //                 widget.word.word ?? '',
//             //               ).animate().moveX(begin: -0.3, duration: 700.ms).then().fadeIn(),
//             //               DetailRow(
//             //                 "كلمة مُرْتَبِطَة بِتَشْكِيل",
//             //                 widget.word.wordTashkeel ?? '',
//             //               ).animate().moveX(begin: -0.3, duration: 800.ms).then().fadeIn(),
//             //               SurahAyaCard(
//             //                 surahName: widget.word.surahName ?? '',
//             //                 verseText: widget.word.verseText ?? '',
//             //               ),

//             //               // DetailRow(
//             //               //   "اسم السورة",
//             //               //   widget.word.surahName ?? '',
//             //               // ).animate().moveX(begin: -0.3, duration: 900.ms).then().fadeIn(),
//             //               // DetailRow(
//             //               //   "الآية",
//             //               //   widget.word.verseText ?? '',
//             //               // ).animate().moveX(begin: -0.3, duration: 1000.ms).then().fadeIn(),
//             //               const SizedBox(height: 20),
//             //             ],
//             //           ),
//             //         ),
//             //       );
//             //     },
//             //   );
//           },
//           child: Container(
//             padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//             margin: EdgeInsets.all(5),
//             decoration: BoxDecoration(
//               color: context.primaryColor.withOpacity(0.05),
//               borderRadius: BorderRadius.circular(16),
//               border: Border.all(color: context.primaryColor),
//             ),
//             child: Text(
//               widget.word.wordTashkeel ?? '',
//               style: TextStyle(
//                 fontSize: 14,
//                 fontWeight: FontWeight.w500,
//                 color: context.primaryColor,
//               ),
//             ),
//           ),
//         )
//         : SizedBox();
//   }

//   // final List<Color> _colors = [
//   //   Colors.black,
//   //   Colors.blueGrey,
//   //   Colors.brown,
//   //   Colors.deepPurple,
//   //   Colors.indigo,
//   //   Colors.teal,
//   //   Colors.deepOrange,
//   //   Colors.grey[900]!,
//   //   Colors.blue[900]!,
//   //   Colors.green[900]!,
//   // ];
//   // Color _getRandomColor(BuildContext context) {
//   //   final random = Random();
//   //   return _colors[random.nextInt(_colors.length)];
//   // }
// }
