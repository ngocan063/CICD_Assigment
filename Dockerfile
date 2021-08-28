FROM node:13.12.0-alpine
MAINTAINER ngocanptit063@gmail.com
WORKDIR /app
COPY ["package.json", "package-lock.json*", "./"]
RUN npm install --production
COPY . .
CMD [ "node", "server.js" ]
