
# Juros Sarda

Aplicativo para Android que calcula Juros Simples, Compostos, Prestação, Nº de Prestações e Taxa de Juros.

## Como compilar o APK

1. Instale o Flutter SDK: https://docs.flutter.dev/get-started/install
2. No terminal, navegue até a pasta do projeto:
```
cd juros_sarda
flutter pub get
flutter build apk --release
```
3. O APK estará em:
```
build/app/outputs/flutter-apk/app-release.apk
```

## Personalização

- Para mudar o logo, substitua `assets/logo.png` (resolução sugerida: 512x512px).
- Para alterar o nome do app, edite o arquivo `android/app/src/main/AndroidManifest.xml`.
