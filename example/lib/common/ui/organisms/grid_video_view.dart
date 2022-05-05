import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:hmssdk_flutter/hmssdk_flutter.dart';
import 'package:hmssdk_flutter_example/common/ui/organisms/video_tile.dart';
import 'package:hmssdk_flutter_example/meeting/meeting_store.dart';
import 'package:hmssdk_flutter_example/meeting/peer_track_node.dart';
import 'package:provider/provider.dart';

Widget gridVideoView(
    {required List<PeerTrackNode> peerTracks,
    required int itemCount,
    required int screenShareCount,
    required BuildContext context,
    required Size size}) {
  List<Widget> children = List.generate(itemCount, (index) {
    if (peerTracks[index].track?.source != "REGULAR") {
      return ChangeNotifierProvider.value(
        key: ValueKey(peerTracks[index].uid),
        value: peerTracks[index],
        child: peerTracks[index].peer.isLocal
            ? Container(
                margin: EdgeInsets.all(2),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 1.0),
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.screen_share),
                    Text("You are sharing your screen"),
                  ],
                ),
              )
            : VideoTile(
                key: Key(peerTracks[index].uid),
                scaleType: ScaleType.SCALE_ASPECT_FIT,
                itemHeight: size.height,
                itemWidth: size.width,
              ),
      );
    }
    return ChangeNotifierProvider.value(
        key: ValueKey(peerTracks[index].uid),
        value: peerTracks[index],
        child: VideoTile(
          key: ValueKey(peerTracks[index].uid),
          itemHeight: size.height,
          itemWidth: size.width,
        ));
  });
  return GridView(
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      physics: PageScrollPhysics(),
      children: children,
      controller: Provider.of<MeetingStore>(context).controller,
      gridDelegate: SliverStairedGridDelegate(
          startCrossAxisDirectionReversed: false,
          pattern: pattern(itemCount, screenShareCount, size)));
}

List<StairedGridTile> pattern(int itemCount, int screenShareCount, Size size) {
  double ratio = (size.height * 0.81) / (size.width);
  List<StairedGridTile> tiles = [];
  for (int i = 0; i < screenShareCount; i++) {
    tiles.add(StairedGridTile(1, ratio));
  }
  int normalTile = (itemCount - screenShareCount);
  int gridView = normalTile ~/ 4;
  int tileLeft = normalTile - (gridView * 4);
  for (int i = 0; i < (normalTile - tileLeft); i++) {
    tiles.add(StairedGridTile(0.5, ratio));
  }
  if (tileLeft == 1) {
    tiles.add(StairedGridTile(1, ratio));
  } else if (tileLeft == 2) {
    tiles.add(StairedGridTile(0.5, ratio / 2));
    tiles.add(StairedGridTile(0.5, ratio / 2));
  } else {
    tiles.add(StairedGridTile(1 / 3, ratio / 3));
    tiles.add(StairedGridTile(1 / 3, ratio / 3));
    tiles.add(StairedGridTile(1 / 3, ratio / 3));
  }
  return tiles;
}
