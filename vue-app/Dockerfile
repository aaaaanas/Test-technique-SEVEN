# Utiliser l'image node officielle
FROM node:16-alpine

# Définir le répertoire de travail
WORKDIR /app

# Copier package.json et installer les dépendances
COPY package.json .
RUN npm install

# Copier le reste des fichiers de l'application
COPY . .

# Exposer le port sur lequel l'application va fonctionner
EXPOSE 8080

# Commande pour démarrer l'application
CMD ["npm", "run", "serve"]
