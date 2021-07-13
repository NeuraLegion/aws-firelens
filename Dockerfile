FROM amazon/aws-for-fluent-bit:latest
ADD fluent-bit.conf /fluent-bit/alt/fluent-bit.conf
CMD ["/fluent-bit/bin/fluent-bit", "-e", "/fluent-bit/firehose.so", "-e", "/fluent-bit/cloudwatch.so", "-e", "/fluent-bit/kinesis.so", "-c", "/fluent-bit/alt/fluent-bit.conf"]
