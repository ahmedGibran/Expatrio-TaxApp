# expatrio_tax_task

A Flutter application for Expatrio that implements a login page, a screen with
a Call-to-Action (CTA) to update tax data, and a bottom sheet for inputting and editing tax data.


Built with flutter Channel stable --version = 3.16.5,

## Flutter IDE configuration
- Enable "Format code on save" for Flutter
- Set "hard wrap" to 128


## Testing
### How to run to Test?
Please run these command lines ... :

- flutter test test/core/network/network_info_impl_test.dart
- flutter test test/core/utils/constants/helper_test.dart
- flutter test test/features/domain/usecases/auth_use_cases_test.dart
- flutter test test/features/domain/usecases/tax_use_cases_test.dart 
- flutter test test/features/infrastructure/dataresource/local/auth_local_data_test.dart
- flutter test test/features/infrastructure/dataresource/local/tax_local_data_test.dart
- flutter test test/features/infrastructure/dataresource/remote/auth_remote_data_test.dart
- flutter test test/features/infrastructure/dataresource/remote/tax_remote_data_test.dart 
- flutter test test/features/infrastructure/model/tax_models/tax_model_test.dart
- flutter test test/features/infrastructure/model/tax_models/tax_residence_model_test.dart
- flutter test test/features/infrastructure/model/tax_models/w9_file_model_test.dart
- flutter test test/features/infrastructure/model/user_model_test.dart
- flutter test test/features/infrastructure/model/user_subject_model_test.dart
- flutter test test/features/infrastructure/repositories/auth_repository_impl_test.dart
- flutter test test/features/infrastructure/repositories/tax_repository_impl_test.dart


### Libraries & Tools Used

* [Render After Effects animations](https://pub.dev/packages/lottie)
* [url_launcher](https://pub.dev/packages/url_launcher)
* [http](https://pub.dev/packages/http)
* [Provider](https://github.com/rrousselGit/provider) (State Management)
* [Database](https://pub.dev/packages/flutter_secure_storage)
* [flutter_svg](https://pub.dev/packages/flutter_svg)
* [Equality Comparisons](https://pub.dev/packages/equatable)
* [internet connection checker](https://pub.dev/packages/internet_connection_checker)
* [dartz](https://pub.dev/packages/dartz)
* [Mocks](https://pub.dev/packages/mockito)
* [Dependency Injection](https://github.com/fluttercommunity/get_it)

### Folder Structure
Here is the core folder structure which flutter provides.

```
flutter-app/
|- android
|- build
|- ios
|- lib
|- test
```

Here is the folder structure I have been using in this project

```
lib/
|- core/
|- features/
|- main.dart
```

Now, lets dive into the lib folder which has the main code for our application.
1- core - All the application level common, shared and constants are defined in this directory with-in their respective files. 
This directory contains the constants for `extensions`, `localization`, `erros`, `network` and `utils` which is contain `constants`,
`helper`, `image_paths`.
2- features - Contains the ui, state managements and domain layer and infrastructure or data layer of our project, includes directories for local, network.
3- ui — Contains all the ui of our project, contains sub directory for each screen and widgets — which is it is going to Contain the common widgets 
for our applications. For example,custom Button, TextField etc..
4- main.dart - This is the starting point of the application. All the application level configurations are defined in this file i.e, theme, Dependency Injection init, lang etc.

### Domain layer

This layer is the core of the application. It is the layer where all business rules contracts between ui/infrastructure related to the problem to be solved are included. 
In this layer, entities, use cases, repository interfaces will take place. This has less dependencies as much as possible. And Third party libraries almost not used here.

### Infrastructure

All the business logic of our application in this directory, it represents the data layer of our application. It is sub-divided into three directories `datasource`, `model` and `repositories`, 
each containing the domain specific logic. Since each layer exists independently, that makes it easier to unit test. The communication between UI and data layer is handled by using central repository.

### Screenshots
![Screenshot_20240110_065720](https://github.com/ahmedGibran/Expatrio-TaxApp-Task/assets/51888694/6ee1799f-b5d3-426c-a40c-b1399e1d5fec)
![Screenshot_20240110_065748](https://github.com/ahmedGibran/Expatrio-TaxApp-Task/assets/51888694/79b87177-8d34-48a9-b1cc-8e7c00f933e1)
![Screenshot_20240110_065914](https://github.com/ahmedGibran/Expatrio-TaxApp-Task/assets/51888694/07bcc0c0-311f-4fde-9219-09022b4a64f6)
![Screenshot_20240110_065850](https://github.com/ahmedGibran/Expatrio-TaxApp-Task/assets/51888694/d7fcf64b-c55d-42fe-8f9b-77d9d0e84c04)
![Screenshot_20240110_065825](https://github.com/ahmedGibran/Expatrio-TaxApp-Task/assets/51888694/be184142-ed78-42da-9a65-830570564a5d)
![Screenshot_20240110_065720](https://github.com/ahmedGibran/Expatrio-TaxApp-Task/assets/51888694/5be481b3-1925-47d6-bb39-308b63a1c8fe)


