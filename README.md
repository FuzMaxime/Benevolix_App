
# Benevolix App

Benevolix App est une application mobile développée avec Flutter. Ce projet est conçu pour connecter des associations à des bénévoles disponibles et motivés. L'objectif est de simplifier la mise en relation, de centraliser les opportunités, et d'offrir un espace personnalisé pour les bénévoles et les associations.

## Structure du projet

Le projet suit une organisation nommé folder by features comme suivant :

- **lib/** : Contient le code source principal de l'application.
	- **features**/
		- **announcements**/
		- **auth**/
		- **candidacies**/
		- **location**/
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
   git clone https://github.com/FuzMaxime/Benevolix_App.git
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

> Pour l'évaluation de ce projet le .env a été push, ne pas oublier de modifier l'**API_URL** avec celle de votre backend et de lancer votre backend (voir annexe).

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

## Annexes
- **Figma**: [benevolix-figma-link](https://www.figma.com/design/YTO4fzi6RVIOAMNo6vj7gj/B%C3%A9n%C3%A9volix?node-id=0-1&t=MwH8DOa7Bbaxog34-1)
- **Énnoncé Github**: [cours-développement-mobile/projet-final/ennoncé.md](https://github.com/Feldrise/Cours-Developpement-Mobile/blob/main/Projet%20final/ennonc%C3%A9.md)
- **Github backend**: https://github.com/FuzMaxime/Benevolix.git
