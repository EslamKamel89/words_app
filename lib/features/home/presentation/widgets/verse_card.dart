import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:html_unescape/html_unescape.dart';
import 'package:words_app/core/heleprs/database_helper.dart';
import 'package:words_app/core/heleprs/print_helper.dart';
import 'package:words_app/features/home/entities/verse_entity.dart';
import 'package:words_app/features/home/models/osmani_word.dart';

class VerseCard extends StatefulWidget {
  final VerseEntity verse;

  const VerseCard({super.key, required this.verse});

  @override
  State<VerseCard> createState() => _VerseCardState();
}

class _VerseCardState extends State<VerseCard> {
  final db = DataBaseHelper.dataBaseInstance();
  List<OsmaniWord> words = [];
  @override
  void initState() {
    initWords();
    super.initState();
  }

  Future initWords() async {
    if (widget.verse.surahId == null || widget.verse.verseNumber == null) {
      pr('surahId or verNumber is null');
      return;
    }
    words = await db.getDetails2(widget.verse.surahId!, widget.verse.verseNumber!);
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void didUpdateWidget(VerseCard oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.verse.verseNumber != oldWidget.verse.verseNumber ||
        widget.verse.surahId != oldWidget.verse.surahId) {
      initWords();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          padding: const EdgeInsets.all(20),
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Surah Name + Verse Number Row
              SizedBox(width: double.infinity),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    widget.verse.surahName ?? '',
                    style: TextStyle(
                      // fontFamily: 'NotoSansArabic',
                      fontWeight: FontWeight.bold,
                      color: Colors.indigo.shade900,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    "الآية ${widget.verse.verseNumber ?? ''}",
                    style: TextStyle(
                      // fontFamily: 'NotoSansArabic',
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ).animate().fadeIn(duration: 500.ms).slideX(begin: -0.2),

              const SizedBox(height: 12),
              RichText(
                textAlign: TextAlign.start,
                text: TextSpan(children: ayaText(), style: DefaultTextStyle.of(context).style),
              ),
              const SizedBox(height: 12),

              // Verse Text
              // Text(
              //   widget.verse.verseText ?? '',
              //   textAlign: TextAlign.right,
              //   textDirection: TextDirection.rtl,
              //   maxLines: 100,
              //   // overflow: TextOverflow.ellipsis,
              //   style: TextStyle(
              //     fontFamily: 'uthmanic3',
              //     fontSize: 20,
              //     height: 2.0,
              //     color: Colors.brown.shade900,
              //     fontWeight: FontWeight.w500,
              //   ),
              // ).animate().fadeIn(duration: 600.ms).scaleXY(begin: 0.98, end: 1.0),
            ],
          ),
        );
      },
    );
  }

  List<TextSpan> ayaText() {
    List<TextSpan> widgets = [];

    for (var x = 0; x < words.length; x++) {
      widgets.add(
        TextSpan(
          text: HtmlUnescape().convert(words[x].code!),
          style: TextStyle(fontSize: 25, fontFamily: 'p${words[x].page}'),
        ),
      );
    }
    return widgets;
  }
}
