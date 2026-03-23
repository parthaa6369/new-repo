# Stage 1: Build React App
FROM node:20-alpine AS build

WORKDIR /app

# Copy package files first (better caching)
COPY package*.json ./

RUN npm install

# Copy all files
COPY . .

# Build the app
RUN npm run build


# Stage 2: Serve with Nginx
FROM nginx:1.25-alpine

# Remove default nginx config
RUN rm -rf /etc/nginx/conf.d/default.conf

# Copy custom nginx config
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Copy build files from stage 1
COPY --from=build /app/build /usr/share/nginx/html

# Expose port
EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
