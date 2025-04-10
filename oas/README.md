> [!WARNING]
> The OpenAPI specifications in this directory are outdated. Please find the up-to-date specifications [here](https://docs.alpaca.markets/openapi).

# alpaca-oas

Alpaca [OpenAPI specifcations (OAS)](https://swagger.io/docs/specification/about/).

---
## Getting started

Install packages / tools for working with the OAS project

```
npm i
```

## Validate an OpenAPI spec

`npm run validate broker/openapi.yaml`

You can also optionally run the `./scripts/validate-all.sh` to validate all the spec files

## Lint an OpenAPI spec

`npm run lint broker/openapi.yaml`

You can also optionally run the `./scripts/lint-all.sh` to lint all the spec files

## Serve an OpenAPI doc preview

`npm run serve broker/openapi.yaml --options.onlyRequiredInSamples`

## Generate API clients for a given language

View list of potential generators: `npx openapi-generator-cli list`

Below example generates packages for Java and R from Broker API OpenAPI spec.

```
npx openapi-generator-cli generate -i broker/openapi.yaml -g java -o build/java
npx openapi-generator-cli generate -i broker/openapi.yaml -g r -o build/r
```

While we include this in our dependencies, documenting how to use openapi-generator-cli is a bit out of scope for this document,
please see [their github page](https://github.com/OpenAPITools/openapi-generator-cli) for more information on how to use it.


## Generate Postman Collection

`npx openapi2postmanv2 -s broker/openapi.yaml -o build/collection.json -p -O folderStrategy=paths,includeAuthInfoInExample=true`
