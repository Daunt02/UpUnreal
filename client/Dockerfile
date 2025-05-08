# Base image
FROM node:18-alpine

# Working directory
WORKDIR /app

# Copy all source code
COPY . .

# Install Quasar CLI and dependencies
RUN npm install -g @quasar/cli && npm install

# Expose dev server port
EXPOSE 9000

# Start dev server
CMD ["quasar", "dev"]
