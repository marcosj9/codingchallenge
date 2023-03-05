FROM ubuntu:jammy
RUN apt-get update && apt-get upgrade -y && apt-get install imagemagick bc -y
COPY compare.sh /usr/bin/imgcompare
RUN chmod +x /usr/bin/imgcompare
RUN mkdir /home/imagecompare
WORKDIR /home/imagecompare
CMD ["/usr/bin/imgcompare"]