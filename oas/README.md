# alpaca-oas

Alpaca APIs [OpenAPI specifcations](https://swagger.io/docs/specification/about/).

**Warning**: These specs are work in progress and might not reflect current state.

```
npm i
```

## Validate OpenAPI specs

`npx swagger-cli validate broker/openapi.yaml`

## Lint OpenAPI spec

`npx spectral lint broker/openapi.yaml`

## Serve an OpenAPI doc preview

`npx redoc-cli serve broker/openapi.yaml --options.onlyRequiredInSamples`

## Generate API clients for a given language

`npx openapi-generator-cli list`
`npx openapi-generator-cli generate -i broker/openapi.yaml -g java -o build/java`
`npx openapi-generator-cli generate -i broker/openapi.yaml -g r -o build/r`

## Generate Postman Collection

`npx openapi2postmanv2 -s broker/openapi.yaml -o build/collection.json -p -O folderStrategy=paths,includeAuthInfoInExample=true`
