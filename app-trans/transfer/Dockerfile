FROM alpine:latest
RUN apk add --no-cache curl
WORKDIR /app
COPY transfer_logs.sh .
RUN chmod +x transfer_logs.sh
CMD ["./transfer_logs.sh"]