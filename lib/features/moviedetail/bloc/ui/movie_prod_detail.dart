import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../data/core/api_constants.dart';
import '../../../../data/model/movie_detail_model.dart';

class ProductionCompanyDetail extends StatelessWidget {
  final List<ProductionCompany> productionCompanies;
  const ProductionCompanyDetail({
    super.key,
    required this.productionCompanies,
  });

  @override
  Widget build(BuildContext context) {
    final aspect = MediaQuery.sizeOf(context).width /
        (MediaQuery.sizeOf(context).height / 4);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          child: GridView.builder(
            shrinkWrap: true,
            physics: ScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: aspect,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
            ),
            scrollDirection: Axis.vertical,
            itemCount: productionCompanies.length,
            itemBuilder: (context, index) {
              return IntrinsicWidth(
                child: ListTile(
                  leading: ClipOval(
                    child: CachedNetworkImage(
                      height: 60,
                      width: 60,
                      errorWidget: (context, url, error) => Icon(Icons.warning),
                      imageUrl:
                          '${ApiConstants.BASE_IMAGE_URL}${productionCompanies[index].logoPath}',
                    ),
                  ),
                  title: Text(
                    productionCompanies[index].name!,
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                  subtitle: Text(
                    productionCompanies[index].originCountry!,
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
