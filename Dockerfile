FROM btorresgil/splunk:6.2.6

MAINTAINER Brian Torres-Gil <btorresgil@dralth.com>

ENV REFRESHED_AT 2015-10-20

# Copy in the demo setup script
COPY init/demo /init/demo

# Install unzip
RUN yum install -y unzip

RUN mkdir /panw-apps

# Download the latest stable Palo Alto Networks App for Splunk
RUN wget -O /SplunkforPaloAltoNetworks.zip https://github.com/PaloAltoNetworks-BD/SplunkforPaloAltoNetworks/archive/v4.2.2.zip
RUN unzip /SplunkforPaloAltoNetworks.zip -d /panw-apps/
RUN mv /panw-apps/SplunkforPaloAltoNetworks-4.2.2 /panw-apps/SplunkforPaloAltoNetworks
RUN rm -f /SplunkforPaloAltoNetworks.zip

# Download the latest stable Palo Alto Networks data generator app for Splunk
RUN wget -O /pan_datagen.zip https://github.com/PaloAltoNetworks-BD/Splunk-App-Data-Generator/archive/master.zip
RUN unzip /pan_datagen.zip -d /panw-apps/
RUN mv /panw-apps/Splunk-App-Data-Generator-master /panw-apps/pan_datagen
RUN rm -f /pan_datagen.zip

# Add 514/udp syslog input to app
RUN mkdir /panw-apps/SplunkforPaloAltoNetworks/local
RUN mkdir /panw-apps/pan_datagen/local
COPY inputs.conf /inputs.conf

RUN echo '/bin/bash -x /init/demo' >> /init/setup

VOLUME /opt/splunk/var/lib/splunk

EXPOSE 8000 8089 9997 514/udp

ENTRYPOINT ["/bin/bash", "-e", "/init/start"]
CMD ["run"]
