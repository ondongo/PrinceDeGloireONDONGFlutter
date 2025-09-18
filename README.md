# Prince De Gloire ONDONGO FLutter 

Installation
1. Cloner le projet
git clone https://github.com/ton-utilisateur/ton-projet-flutter.git
cd ton-projet-flutter

2. Installer les dépendances
flutter pub get

3. Configurer l’API TMDb

L’application utilise The Movie Database (TMDb) pour récupérer les informations des films.

Crée un compte sur TMDb
.

Va dans Paramètres > API et récupère ton API Key (clé publique).

Génére un Access Token (v4 auth) pour certaines requêtes avancées.

4. Ajouter tes clés d’API

Crée un fichier .env (ou utilise directement lib/core/constants/api_constants.dart selon ton projet) et ajoute :

API_KEY=ta_clef_api
TOKEN=ton_token_v4
