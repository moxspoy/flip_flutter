import 'package:flip/widgets/text/text.dart';
import 'package:flutter/material.dart';

class PinView extends StatefulWidget {
  const PinView({super.key, this.pin = ''});

  final String pin;

  @override
  State<PinView> createState() => _PinViewState();
}

class _PinViewState extends State<PinView> {
  final bool _isShow = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Card(
        margin: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(6, (index) {
            List<String> renderedPin = List.filled(6, '');
            for (final (index, _) in widget.pin.split('').indexed) {
              if (renderedPin.contains('')) {
                renderedPin[index] = widget.pin[index];
              }
            }

            return PinViewItem(
              char: renderedPin[index],
              isShow: _isShow,
            );
          }),
        ),
      ),
    );
  }
}

class PinViewItem extends StatelessWidget {
  const PinViewItem({super.key, this.char = '', this.isShow = false});

  final String char;
  final bool isShow;

  @override
  Widget build(BuildContext context) {
    const pinItemWidthSize = 24.0;
    const pinItemHeightSize = 50.0;
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 8),
      child: char == ''
          ? Container(
              width: pinItemWidthSize,
              height: pinItemHeightSize,
              decoration: const BoxDecoration(
                  shape: BoxShape.circle, color: Color(0xFFe0f2f1)),
              child: Container(),
            )
          : Center(
              child: SizedBox(
                width: pinItemWidthSize,
                height: pinItemHeightSize,
                child: isShow
                    ? const Icon(Icons.remove_red_eye_outlined)
                    : HeadlineText(char),
              ),
            ),
    );
  }
}
