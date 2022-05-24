FROM intersystemsdc/irishealth-community:latest

COPY --chown=irisowner:irisowner ./data/fhir /home/irisowner/fhirdata
COPY --chown=irisowner:irisowner ./ /home/irisowner/fhirapp/

RUN \
	--mount=type=bind,src=.,dst=/home/irisowner/fhirapp \
	--mount=type=bind,src=iris.script,dst=/tmp/iris.script \
	iris start IRIS && \
	pip3 install -r /home/irisowner/fhirapp/src/python/requirements.txt  && \
	# iris session IRIS '##class(%ZPM.PackageManager).Shell("load /home/irisowner/fhirapp -v",1,1)' && \
	iris session IRIS < /tmp/iris.script && \
	iris stop iris quietly


RUN pip3 install -r /home/irisowner/fhirapp/src/python/requirements.txt

ENV IRISUSERNAME "SuperUser"
ENV IRISPASSWORD "SYS"
ENV IRISNAMESPACE "IRISAPP"