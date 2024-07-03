# Etapa 1: Construcción
FROM node:16 AS builder

# Configura el directorio de trabajo
WORKDIR /usr/src/app

# Copia los archivos package.json y package-lock.json
COPY package*.json ./

# Instala las dependencias
RUN npm install

# Copia el resto del código de la aplicación
COPY . .

# Compila el código de TypeScript a JavaScript
RUN npm run build

# Etapa 2: Imagen final
FROM node:16

# Configura el directorio de trabajo
WORKDIR /usr/src/app

# Copia solo los archivos necesarios desde la etapa de construcción
COPY --from=builder /usr/src/app/package*.json ./
COPY --from=builder /usr/src/app/node_modules ./node_modules
COPY --from=builder /usr/src/app/dist ./dist

# Expone el puerto 3001
EXPOSE 3001

# Comando por defecto para ejecutar la aplicación
CMD ["node", "dist/main.js"]
