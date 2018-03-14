FROM golang:1.9 as build

WORKDIR /go/src/github.com/aws/amazon-ecs-cli
ADD . .
RUN make

FROM amazonlinux:latest
RUN yum update && yum install ca-certificates
COPY --from=build /go/src/github.com/aws/amazon-ecs-cli/bin/local/ecs-cli /bin/.
ENTRYPOINT [ "ecs-cli" ]