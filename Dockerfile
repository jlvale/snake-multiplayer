FROM node:14

WORKDIR /app

COPY package.json ./

RUN npm install

COPY . .

EXPOSE 80
#Datadog Instrumentation
COPY --from=datadog/serverless-init:1 /datadog-init /app/datadog-init
RUN npm install --prefix /dd_tracer/node dd-trace  --save
ENV DD_SERVICE=snake-nodejs
ENV DD_ENV=lab
ENV DD_VERSION=1
ENTRYPOINT ["/"]

CMD ["/app/datadog-init","npm", "start"]