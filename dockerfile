FROM node:12.11.0 as build-deps
WORKDIR /usr/src/app
COPY package.json yarn.lock ./
RUN yarn install --prod --frozen-lockfile
COPY . ./
RUN yarn build

FROM nginx:alpine
COPY --from=build-deps /usr/src/app/build /usr/share/nginx/html
COPY ./nginx/conf.d/default.conf /etc/nginx/conf.d/default.conf
EXPOSE 8080