# Benevolix App

Benevolix App est une application mobile développée avec Flutter. Ce projet est conçu pour connecter des associations à des bénévoles disponibles et motivés. L'objectif est de simplifier la mise en relation, de centraliser les opportunités, et d'offrir un espace personnalisé pour les bénévoles et les associations.

## Structure du projet

Le projet est organisé comme suit :

- **lib/** : Contient le code source principal de l'application.
- **assets/** : Contient les ressources (images, fichiers JSON, etc.).
- **test/** : Contient les tests unitaires et d'intégration.
- **android/**, **ios/**, **linux/**, **macos/**, **windows/**, **web/** : Contiennent les configurations spécifiques aux plateformes.

## Prérequis

Avant de commencer, assurez-vous d'avoir installé les éléments suivants :

- [Flutter SDK](https://flutter.dev/docs/get-started/install)
- Un éditeur de code comme [Visual Studio Code](https://code.visualstudio.com/) ou [Android Studio](https://developer.android.com/studio)
- Un émulateur ou un appareil physique configuré pour tester l'application.

## Installation

1. Clonez ce dépôt :

   ```bash
   git clone <URL_DU_DEPOT>
   cd benevolix_app
   ```

2. Installez les dépendances Flutter :

   ```bash
   flutter pub get
   ```

3. Vérifiez que votre environnement Flutter est correctement configuré :

   ```bash
   flutter doctor
   ```

   Assurez-vous que toutes les dépendances nécessaires sont installées et configurées.

4. Lancez l'application sur un simulateur ou un appareil physique :

   ```bash
   flutter run
   ```

   Si vous souhaitez spécifier une plateforme particulière, utilisez l'option `-d` suivie de la plateforme, par exemple :

   ```bash
   flutter run -d chrome  # Pour le web
   flutter run -d android # Pour Android
   flutter run -d ios     # Pour iOS
   ```

## Tests

Pour exécuter les tests unitaires, utilisez la commande suivante :

```bash
flutter test
```

Pour les tests d'intégration, assurez-vous d'avoir configuré un appareil ou un émulateur, puis exécutez :

```bash
flutter drive --target=test_driver/app.dart
```

## Déploiement

Pour générer un fichier exécutable ou un package pour une plateforme spécifique, utilisez les commandes suivantes :

- **Android** : 

   ```bash
   flutter build apk
   ```

- **iOS** :

   ```bash
   flutter build ios
   ```

- **Web** :

   ```bash
   flutter build web
   ```

Les fichiers générés se trouveront dans le dossier `build/`.

## Contribution

Les contributions sont les bienvenues ! Veuillez suivre ces étapes :

1. Forkez le projet.
2. Créez une branche pour votre fonctionnalité (`git checkout -b feature/ma-fonctionnalite`).
3. Commitez vos modifications (`git commit -m 'Ajout d'une nouvelle fonctionnalité'`).
4. Poussez votre branche (`git push origin feature/ma-fonctionnalite`).
5. Ouvrez une Pull Request.

## Licence

Ce projet est sous licence [insérer le type de licence, par exemple MIT].

---

Pour toute question ou suggestion, n'hésitez pas à ouvrir une issue ou à nous contacter.