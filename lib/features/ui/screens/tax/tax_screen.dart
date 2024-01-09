import 'package:expatrio_tax_task/core/core.dart';
import 'package:expatrio_tax_task/features/features.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class TaxScreen extends StatelessWidget {
  const TaxScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Consumer<TaxState>(
          builder: (context, taxState, _) {
            return Padding(
              padding: const EdgeInsets.all(48),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 180,
                    child: SvgPicture.asset(
                      kCryingGirlSvg,
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: 210,
                    child: Text(
                      getTranslatedValue(context, 'empty_tax_info_title'),
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: 200,
                    child: Text(
                      getTranslatedValue(context, 'empty_tax_info_subtitle'),
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: 250,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(backgroundColor: Theme.of(context).colors.primary),
                        onPressed: () async {
                          showModalBottomSheet<void>(
                            context: context,
                            isScrollControlled: true,
                            builder: (BuildContext context) {
                              return FractionallySizedBox(
                                heightFactor: 0.9,
                                child: Container(
                                  color: Colors.transparent,
                                  child: Container(
                                    padding: const EdgeInsets.all(32),
                                    decoration: const BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.all(Radius.circular(50)),
                                    ),
                                    child: Center(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            getTranslatedValue(context, 'country_drop_down_hint').toUpperCase(),
                                            style: TextStyle(fontSize: 12),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              showModalBottomSheet<void>(
                                                context: context,
                                                isScrollControlled: true,
                                                builder: (BuildContext context) {
                                                  return FractionallySizedBox(
                                                    heightFactor: 0.8,
                                                    child: Container(
                                                      color: Colors.transparent,
                                                      child: Container(
                                                        decoration: const BoxDecoration(
                                                          color: Colors.white,
                                                          borderRadius: BorderRadius.all(Radius.circular(50)),
                                                        ),
                                                        child: Column(
                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                          mainAxisSize: MainAxisSize.min,
                                                          children: <Widget>[
                                                            ListView.builder(
                                                                itemCount: CountriesConstants.countryInfos.length,
                                                                itemBuilder: (context, countryIndex) {
                                                                  return ListTile(
                                                                    onTap: () {
                                                                      taxState.selectTaxCountry(
                                                                          CountriesConstants.countryInfos[countryIndex],
                                                                          countryIndex);
                                                                      Navigator.pop(context);
                                                                    },
                                                                    title: Text(CountriesConstants
                                                                        .countryInfos[countryIndex].label),
                                                                  );
                                                                }),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                },
                                              );
                                            },
                                            child: Container(
                                              height: 48,
                                              width: MediaQuery.of(context).size.width,
                                              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
                                              decoration: BoxDecoration(
                                                border: Border.all(),
                                                borderRadius: const BorderRadius.all(Radius.circular(8)),
                                              ),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Text(
                                                    'Country label',
                                                    style: TextStyle(fontSize: 12),
                                                  ),
                                                  const Icon(Icons.arrow_drop_down_outlined),
                                                ],
                                              ),
                                            ),
                                          ),
                                          const SizedBox(height: 16),
                                          Text(
                                            getTranslatedValue(context, 'tax_number_hint').toUpperCase(),
                                            style: TextStyle(fontSize: 12),
                                            textAlign: TextAlign.left,
                                          ),
                                          TextFormField(
                                            textAlignVertical: TextAlignVertical.center,
                                            style: const TextStyle(fontSize: 16),
                                            textInputAction: TextInputAction.done,
                                            autovalidateMode: AutovalidateMode.onUserInteraction,
                                            decoration: InputDecoration(
                                              contentPadding: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(color: Theme.of(context).colors.primary),
                                                borderRadius: const BorderRadius.all(Radius.circular(8)),
                                              ),
                                              enabledBorder: const OutlineInputBorder(
                                                borderRadius: BorderRadius.all(Radius.circular(8)),
                                              ),
                                            ),
                                            onChanged: (value) {
                                              print("taxId Changed : ${value} ");
                                            },
                                          ),
                                          const SizedBox(height: 16),
                                          ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: Theme.of(context).colors.primary,
                                              ),
                                              onPressed: () async {
                                                Navigator.pop(context);
                                              },
                                              child: Container(
                                                height: 24,
                                                width: 250,
                                                alignment: Alignment.center,
                                                decoration: BoxDecoration(
                                                  color: Theme.of(context).colors.primary,
                                                  borderRadius: const BorderRadius.all(Radius.circular(100)),
                                                ),
                                                child: Text(
                                                  getTranslatedValue(context, 'save'),
                                                  style: const TextStyle(color: Colors.white, fontSize: 16),
                                                ),
                                              )),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        },
                        child: Container(
                          height: 32,
                          width: MediaQuery.of(context).size.width,
                          alignment: Alignment.center,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(100)),
                          ),
                          child: Text(
                            getTranslatedValue(context, 'empty_tax_info_action').toUpperCase(),
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        )),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
