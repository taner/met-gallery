import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:met_gallery/env.dart';

const _museumApi = 'https://collectionapi.metmuseum.org/public/collection';
const _museumPages = 'https://www.metmuseum.org/art/collection/search';

void main() {
  tearDown(dotenv.clean);

  test('a value in .env is the one the app uses', () {
    dotenv.loadFromString(
      envString: 'COLLECTION_BASE_URL=https://collection.invalid',
    );

    expect(Env.collectionBaseUrl, 'https://collection.invalid');
  });

  test('without a loaded .env the app still points at the museum', () {
    expect(dotenv.isInitialized, isFalse);

    expect(Env.collectionBaseUrl, _museumApi);
    expect(Env.objectPageBaseUrl, _museumPages);
  });

  test('a blank or missing value falls back instead of pointing nowhere', () {
    dotenv.loadFromString(envString: 'COLLECTION_BASE_URL=   \nOTHER=1');

    expect(Env.collectionBaseUrl, _museumApi);
    expect(Env.objectPageBaseUrl, _museumPages);
  });

  // The outage check in the manual test plan edits `.env`. This is what
  // stops that edit from being shipped.
  test('the committed .env points at the museum, not a QA address', () {
    dotenv.loadFromString(envString: File('.env').readAsStringSync());

    expect(Env.collectionBaseUrl, _museumApi);
    expect(Env.objectPageBaseUrl, _museumPages);
  });
}
