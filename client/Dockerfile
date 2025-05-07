FROM node:18-alpine
WORKDIR /app
COPY . .
RUN npm install -g @quasar/cli && npm install
EXPOSE 9000
CMD ["quasar", "dev"]
