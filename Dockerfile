FROM alpine:3.7
COPY healthcheck.sh /
COPY getSick heal /bin/
HEALTHCHECK --interval=5s --start-period=15s --retries=3 CMD /bin/sh healthcheck.sh
ENTRYPOINT ["/bin/ping"]
CMD ["8.8.8.8"]
