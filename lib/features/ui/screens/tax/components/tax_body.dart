import 'package:expatrio_tax_task/core/core.dart';
import 'package:expatrio_tax_task/features/features.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class TaxBody extends StatelessWidget {
  const TaxBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
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
                SizedBox(width: 180, child: SvgPicture.asset(kCryingGirlSvg)),
                const SizedBox(height: 16),
                SizedBox(
                  width: 210,
                  child: Text(
                    getTranslatedValue(context, 'empty_tax_info_title'),
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
                      _showTaxDataInoutFields(context);
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
                        style: const TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _showTaxDataInoutFields(BuildContext context) {
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
                child: Consumer<TaxState>(
                  builder: (context, taxState, _) => Center(
                    child: ListView(
                      children: <Widget>[
                        const SizedBox(height: 16),
                        Text(
                          getTranslatedValue(context, 'declaration_financial_info').toUpperCase(),
                          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 16),
                        for (int formIndex = 0; formIndex < taxState.taxForms.length; formIndex++)
                          _buildTaxForm(context, formIndex),
                        const SizedBox(height: 16),
                        InkWell(
                          onTap: () {
                            taxState.addTaxForm();
                          },
                          child: Row(
                            children: [
                              Icon(Icons.add, color: Theme.of(context).colors.primary),
                              const SizedBox(width: 4),
                              Text(
                                getTranslatedValue(context, 'add_another').toUpperCase(),
                                style: TextStyle(fontSize: 16, color: Theme.of(context).colors.primary),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Checkbox(
                              checkColor: Colors.white,
                              activeColor: Theme.of(context).colors.primary,
                              side: BorderSide(
                                color: taxState.isInformationAccuracyVerified == false
                                    ? Colors.red
                                    : Theme.of(context).colors.primary,
                                width: 1.5,
                              ),
                              value: taxState.isInformationAccuracyVerified ?? false,
                              onChanged: (bool? isChecked) {
                                taxState.setInformationAccuracyState(isChecked);
                              },
                            ),
                            const SizedBox(width: 2),
                            Text(
                              getTranslatedValue(context, 'checkbox_title'),
                              style: TextStyle(fontSize: 15),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Theme.of(context).colors.primary,
                            ),
                            onPressed: () async {
                              await taxState.submitTaxDataUpdates();
                              if (taxState.isSubmitButtonEnabled) {
                                Navigator.pop(context);
                              }
                            },
                            child: Container(
                              height: 24,
                              width: 250,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: Theme.of(context).colors.primary,
                                borderRadius: const BorderRadius.all(Radius.circular(100)),
                              ),
                              child: taxState.state == TaxProviderState.loading
                                  ? SizedBox(
                                      height: 24,
                                      width: 24,
                                      child: CircularProgressIndicator(
                                        backgroundColor: Colors.white,
                                        color: Theme.of(context).colors.primary,
                                      ),
                                    )
                                  : Text(
                                      getTranslatedValue(context, 'save'),
                                      style: const TextStyle(color: Colors.white, fontSize: 16),
                                    ),
                            )),
                      ],
                    ),
                  ),
                ),
              ),
            ));
      },
    );
  }

  Widget _buildTaxForm(BuildContext context, int formIndex) {
    return Consumer<TaxState>(builder: (context, taxState, _) {
      final index = taxState.taxForms[formIndex];
      String initialValue = taxState.taxResidencesMap[index]?.id ?? '';
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            getTranslatedValue(context, index == 0 ? 'primary_country_drop_down_hint' : 'country_drop_down_hint')
                .toUpperCase(),
            style: const TextStyle(fontSize: 12),
          ),
          const SizedBox(height: 4),
          InkWell(
            onTap: () {
              showModalBottomSheet<void>(
                context: context,
                isScrollControlled: true,
                builder: (BuildContext context) {
                  return Consumer<TaxState>(
                      builder: (context, taxState, _) => FractionallySizedBox(
                            heightFactor: 0.8,
                            child: Container(
                              color: Colors.transparent,
                              child: Container(
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.all(Radius.circular(50)),
                                ),
                                child: ListView(
                                  children: <Widget>[
                                    Container(
                                      height: 48,
                                      width: MediaQuery.of(context).size.width,
                                      decoration: BoxDecoration(
                                        color: Theme.of(context).colors.primary,
                                        borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(16), topRight: Radius.circular(16)),
                                      ),
                                      child: Center(
                                        child: Text(
                                          getTranslatedValue(context, 'country'),
                                          style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Padding(
                                      padding: const EdgeInsets.all(8),
                                      child: TextFormField(
                                        textAlignVertical: TextAlignVertical.center,
                                        controller: taxState.searchTextEditingController,
                                        style: const TextStyle(fontSize: 16),
                                        textInputAction: TextInputAction.done,
                                        autovalidateMode: AutovalidateMode.onUserInteraction,
                                        decoration: Constant.kInputDecoration
                                            .copyWith(hintText: getTranslatedValue(context, 'search_for_country')),
                                      ),
                                    ),
                                    const SizedBox(height: 16),
                                    for (int countryIndex = 0;
                                        countryIndex < taxState.countryInfos.length;
                                        countryIndex++)
                                      ListTile(
                                        onTap: () {
                                          taxState.selectTaxCountry(taxState.countryInfos[countryIndex], index);
                                          Navigator.pop(context);
                                        },
                                        title: Text(taxState.countryInfos[countryIndex].label),
                                      )
                                  ],
                                ),
                              ),
                            ),
                          ));
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
                    taxState.taxResidencesMap[index]?.country.isNotEmpty == true
                        ? CountriesConstants.countryInfos
                            .firstWhere((element) => element.code == taxState.taxResidencesMap[index]!.country)
                            .label
                            .toString()
                        : '',
                    style: const TextStyle(fontSize: 16),
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
          const SizedBox(height: 4),
          TextFormField(
            textAlignVertical: TextAlignVertical.center,
            initialValue: initialValue,
            style: const TextStyle(fontSize: 16),
            textInputAction: TextInputAction.done,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: Constant.kInputDecoration,
            onChanged: (taxId) {
              taxState.addTaxId(taxId, index);
            },
          ),
          if (index != 0) const SizedBox(height: 4),
          if (index != 0)
            Align(
              alignment: Alignment.centerRight,
              child: InkWell(
                onTap: () {
                  taxState.removeTaxForm(index);
                },
                child: Text(
                  getTranslatedValue(context, 'remove').toUpperCase(),
                  style: const TextStyle(fontSize: 12, color: Colors.red),
                ),
              ),
            ),
          const SizedBox(height: 16),
        ],
      );
    });
  }
}
