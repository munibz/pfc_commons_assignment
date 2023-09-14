import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../common/constants/route_constants.dart';
import '../../../data/core/api_constants.dart';

class MovieListTile extends StatelessWidget {
  final title, description, posterPath;
  final int movieid;
  const MovieListTile({
    super.key,
    required this.movieid,
    required this.title,
    required this.description,
    required this.posterPath,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, RouteList.movieDetail,
              arguments: movieid);
        },
        child: Padding(
          padding: EdgeInsets.only(top: 2, bottom: 10),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 15, right: 8),
                child: SizedBox(
                  width: 80,
                  child: AspectRatio(
                    aspectRatio: 0.6,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: CachedNetworkImage(
                        errorWidget: (context, url, error) =>
                            Icon(Icons.warning),
                        imageUrl: '${ApiConstants.BASE_IMAGE_URL}$posterPath',
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
              ),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Text(
                        title,
                        maxLines: 1,
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                    ),
                    Text(
                      description,
                      softWrap: true,
                      maxLines: 5,
                      overflow: TextOverflow.visible,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
