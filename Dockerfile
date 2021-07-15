FROM amazon/aws-for-fluent-bit:latest
ADD fluent-bit.conf /fluent-bit/alt/fluent-bit.conf
ADD entrypoint.sh /
CMD ["/bin/bash", "-c", "/entrypoint.sh"]
