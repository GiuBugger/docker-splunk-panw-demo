Palo Alto Networks Splunk App Demo for Docker
=============================================

# Information

A docker image containing Splunk that runs the latest Palo Alto Networks Splunk app.  The image also contains an optional data generator to produce demonstration data for the app.  The data generator is on by default.  To disable it, disabled the pan_datagen app in Splunk.

See the README for the base Splunk docker image for more information on available volumes and environment variables:  
https://github.com/btorresgil/docker-splunk

# Usage

Run the Splunk server unlicensed (500 MB can be indexed per day).  This is usually fine for short demos.

    docker run -d --name splunk-demo -p 8000:8000 -p 514:514/udp btorresgil/splunk-panw-demo

Run a licensed Splunk server.  This is useful for longer running servers, or servers that need to receive lots of logs from a live firewall.

    docker run -d --name splunk-demo -p 8000:8000 -p 514:514/udp -e SPLUNK_PW=paloalto -v /license.lic:<full-path-to-license-file> -v /opt/splunk/var/lib/splunk:<full-path-to-database-directory> btorresgil/splunk-panw-demo

In the command above, set the following variables for your environment:

* `SPLUNK_PW=***`: This is the password you'll use to login to Splunk.  The username is `admin`.
* `<full-path-to-license-file>`: Replace this with an absolute path to your Splunk license file.  You can get a 10 GB/day license at the [Developer Portal](http://dev.splunk.com/page/developer_license_sign_up).
* `<full-path-to-database-directory>`: Replace this with an absolute path to a directory where you want to store the Splunk indexes. This will allow your index to persist even if the docker container is removed or upgraded.

Other environment variables are documented in the base Splunk docker image:  
https://github.com/btorresgil/docker-splunk
