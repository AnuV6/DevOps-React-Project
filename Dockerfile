# Base image
FROM node:18-alpine

# Set working directory
WORKDIR /src

# Copy package.json and package-lock.json
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy all files
COPY . .

# Expose port 3000
EXPOSE 3000

# Start the app with npm start
CMD ["npm", "start"]