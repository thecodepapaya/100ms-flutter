///Package imports
import 'package:flutter/widgets.dart';

///Project imports
import 'package:hms_room_kit/hms_room_kit.dart';
import 'package:hms_room_kit/src/screen_controller.dart';

///[HMSPrebuilt] is the main widget that is used to render the prebuilt
///It takes following parameters:
///[roomCode] - The room code of the room to join
///[options] - The options for the prebuilt for more details check the [HMSPrebuiltOptions] class
class HMSPrebuilt extends StatelessWidget {
  ///The room code of the room to join
  ///This is a required parameter
  ///
  /// Example: For the public Room: https://public.app.100ms.live/meeting/xvm-wxwo-gbl
  /// The room code is: xvm-wxwo-gbl
  final String roomCode;

  ///The options for the prebuilt
  ///For more details checkout the [HMSPrebuiltOptions] class
  ///Defaults to null
  final HMSPrebuiltOptions? options;

  ///The key for the widget
  const HMSPrebuilt({super.key, required this.roomCode, this.options});

  ///Builds the widget
  ///Returns a [ScreenController] widget
  ///The [ScreenController] is the main widget that renders the prebuilt
  ///For more details checkout the [ScreenController] class
  ///It takes the [roomCode] and [options] as parameters
  ///The [roomCode] is the room code of the room to join
  ///The [options] are the options for the prebuilt
  ///For more details checkout the [HMSPrebuiltOptions] class
  ///The [options] are optional and are used to customize the prebuilt
  @override
  Widget build(BuildContext context) {
    return ScreenController(
      roomCode: roomCode,
      options: options,
    );
  }
}
