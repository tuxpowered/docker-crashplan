FROM fedora:22

#########################################
##        ENVIRONMENTAL CONFIG         ##
#########################################
# Set correct environment variables
ENV CRASHPLAN_VERSION=4.4.1

# LC_ALL=en_US.UTF-8"     \
# LANG="en_US.UTF-8"      \
# LANGUAGE="en_US.UTF-8"

#########################################
##         RUN INSTALL SCRIPT          ##
#########################################
ADD /files /tmp/installation

## Increase max file watches
# ADD /files/installation/60-max-user-watches.conf /etc/sysctl.d/60-max-user-watches.conf

RUN chmod +x /tmp/installation/install.sh && /tmp/installation/install.sh && rm -rf /tmp/installation

#########################################
##              VOLUMES                ##
#########################################
VOLUME [ "/var/crashplan", "/storage" ]

#########################################
##            EXPOSE PORTS             ##
#########################################
EXPOSE 4243 4242

WORKDIR /usr/local/crashplan

ENTRYPOINT ["/entrypoint.sh"]
CMD [ "/crashplan.sh" ]
