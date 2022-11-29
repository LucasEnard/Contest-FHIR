ARG IMAGE=intersystemsdc/irishealth-community:preview
FROM $IMAGE

USER root

#COPY key/iris.key /usr/irissys/mgr/iris.key

# Update package and install sudo
RUN apt-get update && apt-get install -y \
	git \
	nano \
	sudo && \
	/bin/echo -e ${ISC_PACKAGE_MGRUSER}\\tALL=\(ALL\)\\tNOPASSWD: ALL >> /etc/sudoers && \
	sudo -u ${ISC_PACKAGE_MGRUSER} sudo echo enabled passwordless sudo-ing for ${ISC_PACKAGE_MGRUSER}

WORKDIR /irisdev/app
RUN chown ${ISC_PACKAGE_MGRUSER}:${ISC_PACKAGE_IRISGROUP} /irisdev/app
USER ${ISC_PACKAGE_MGRUSER}

COPY . .
COPY data/fhir fhirdata
COPY iris.script /tmp/iris.script
COPY fhirUI /usr/irissys/csp/user/fhirUI

RUN pip3 install -r requirements.txt

ENV PYTHON_PATH=/usr/irissys/bin/irispython
ENV IRISUSERNAME "SuperUser"
ENV IRISPASSWORD "SYS"
ENV IRISNAMESPACE "FHIRSERVER"

# run iris and initial 
RUN iris start IRIS \
	&& iris session IRIS < /tmp/iris.script \
	&& /usr/irissys/bin/irispython /irisdev/app/src/register.py \
	&& iris stop IRIS quietly

ENTRYPOINT [ "/tini", "--", "/irisdev/app/entrypoint.sh" ]
