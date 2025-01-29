// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:netflixclone/feature/details/presentation/view/movie_view.dart';
import 'package:netflixclone/feature/home/presentation/view/tabs_view_home/tv_series.dart';
import 'package:netflixclone/feature/home/presentation/view/tabs_view_home/up_coming.dart';

class DetailsView extends StatefulWidget {
  DetailsView(
    Key? key,
    this.newid,
    this.newtupe,
  ) : super(key: key);
  var newid;
  var newtupe;

  @override
  State<DetailsView> createState() => _DetailsViewState();
}

class _DetailsViewState extends State<DetailsView> {
  checktupe() {
    if (widget.newtupe == 'tv') {
      return MovieDetailView(widget.newid);
    } else if (widget.newtupe == 'movie') {
      return MovieDetailView(widget.newid);
    } else if (widget.newtupe == 'upcoming') {
      return MovieDetailView(widget.newid);
    } else {
      return errorWidget();
    }
  }

  @override
  Widget build(BuildContext context) {
    return checktupe();
  }
}

Widget errorWidget() {
  return const Center(
    child: Text('error'),
  );
}
