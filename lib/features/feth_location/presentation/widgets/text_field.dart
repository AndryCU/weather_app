import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

import '../../../../core/const/end_points.dart';
import '../../../../core/exeptions.dart';
import '../../../../injection/locator.dart';
import '../../../main_ui/presentation/bloc/main_ui_bloc.dart';
import '../../domain/entities/geocoding/geo_coding_entity.dart';
import '../../domain/usecases/geo_coding_list.dart';

class TextFieldLocation extends StatelessWidget {
  const TextFieldLocation({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return TypeAheadField<GeoCodingModel>(
      textFieldConfiguration: TextFieldConfiguration(
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(
              width: 3,
              color: Colors.white,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(width: 3, color: Colors.white),
          ),
          contentPadding: const EdgeInsets.only(left: 10),
          //helperText: 'Type here a location',
          helperStyle: const TextStyle(
            color: Colors.white30,
          ),
          hintStyle: const TextStyle(
            color: Colors.white30,
          ),
          labelText: 'Type here a location',
          labelStyle: const TextStyle(
            color: Colors.white30,
          ),
        ),
        style: const TextStyle(
          color: Colors.white,
        ),
      ),
      keepSuggestionsOnLoading: false,
      suggestionsCallback: (pattern) async {
        if (pattern.isNotEmpty) {
          return await locator
              .get<ListGeoCodingUseCase>()
              .getCitiesNames(pattern);
        }
        return [];
      },
      itemBuilder: (context, itemData) {
        final state = itemData.state != null ? '${itemData.state}' : '';
        return Card(
          elevation: 20,
          child: ListTile(
            title: Text(itemData.name),
            subtitle: Text(state),
            leading: CachedNetworkImage(
              fit: BoxFit.fill,
              imageUrl: '$baseUrlFlags${itemData.country}',
              height: size.height * 0.04,
              width: size.width * 0.1,
            ),
          ),
        );
      },
      errorBuilder: (context, error) {
        if (error is NoInternetException) {
          return Text(
            error.message,
            style: TextStyle(
              color: Colors.red,
              fontSize: size.width * 0.05,
            ),
            textAlign: TextAlign.center,
          );
        }
        if (error is TimeoutException) {
          return Text(
            'Try again',
            style: TextStyle(
              color: Colors.red,
              fontSize: size.width * 0.05,
            ),
            textAlign: TextAlign.center,
          );
        }
        return Text(
          'Oops something went wrong: ${error.toString()}',
          style: TextStyle(
            color: Colors.red,
            fontSize: size.width * 0.05,
          ),
          textAlign: TextAlign.center,
        );
      },
      onSuggestionSelected: (suggestion) {
        BlocProvider.of<MainUiBloc>(context, listen: false)
            .add(WeatherCallEvent(suggestion.lat, suggestion.lon));
      },
      noItemsFoundBuilder: (context) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Ups! No locations found',
            style: TextStyle(
              fontSize: size.width * 0.05,
            ),
          ),
        );
      },
    );
  }
}
