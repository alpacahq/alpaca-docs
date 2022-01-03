# alpaca-oas

Alpaca [OpenAPI specifcations (OAS)](https://swagger.io/docs/specification/about/).

**Warning**: These specs are work in progress and might not reflect latest state.

## Getting started

Install packages / tools for working with the OAS project

```
npm i
```

## Validate OpenAPI spec

`npx swagger-cli validate broker/openapi.yaml`

## Lint OpenAPI spec

`npx spectral lint broker/openapi.yaml`

## Serve an OpenAPI doc preview

`npx redoc-cli serve broker/openapi.yaml --options.onlyRequiredInSamples`

## Generate API clients for a given language

View list of potential generators: `npx openapi-generator-cli list`

Below example generates packages for Java and R from Broker API OpenAPI spec.

```
npx openapi-generator-cli generate -i broker/openapi.yaml -g java -o build/java
npx openapi-generator-cli generate -i broker/openapi.yaml -g r -o build/r
```

## Generate Postman Collection

`npx openapi2postmanv2 -s broker/openapi.yaml -o build/collection.json -p -O folderStrategy=paths,includeAuthInfoInExample=true`
