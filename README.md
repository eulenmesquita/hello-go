# Hello-Go
Um exemplo simples de multistage building de images do Docker com menos de 2MB. Para ver seu funcionamento basta digitar:
`docker run eulen/codeeducation`

## Aplicação Golang
A aplicação é uma variação de um magistral `Hello World!` que imprime na tela `Code.education Rocks!`.

## Repositório
A imagem está no repositório do Dockerhub https://hub.docker.com/repository/docker/eulen/codeeducation 


## Passos para building, push e instância do container

```
$ docker build -t eulen/codeeducation
$ docker push
$ docker run eulen/codeeducation
```

## Sobre o multistaging
O primeiro estage foi feito a partir de uma imagem base do `golang:alpine`:

```
FROM golang:alpine as builder
...
RUN go build -o /app
```
Neste estage o ambiente é preparado para fazer o building da aplicação. Este stage foi chamado de builder.
No segundo stage a partir da imagem base `scratch`:

```
FROM scratch
COPY --from=builder /app/codeedu /app/codeedu
ENTRYPOINT ["/app/codeedu"]
```
Basta então fazer cópia do que foi construído no primeiro estágio e depois executar a aplicação. Optei por fazer via `ENTRYPOINT` para garantir que a execução aconteça de fato.
