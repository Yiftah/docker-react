#Builder - install dependencies and build runtime files
FROM node:alpine as builder

WORKDIR '/app'

COPY package*.json ./
RUN npm install

COPY . .
#Create the build artifacts 
RUN npm run build

#Runtime - copy only the build artifacts from the previous step
FROM nginx
EXPOSE 80
COPY --from=builder /app/build /usr/share/nginx/html



