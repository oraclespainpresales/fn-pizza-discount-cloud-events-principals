FROM fnproject/fn-java-fdk-build:jdk11-1.0.109 as build-stage
WORKDIR /function
ENV MAVEN_OPTS -Dhttp.proxyHost= -Dhttp.proxyPort= -Dhttps.proxyHost= -Dhttps.proxyPort= -Dhttp.nonProxyHosts= -Dmaven.repo.local=/usr/share/maven/ref/repository -Dhttps.protocols=TLSv1.2

ADD pom.xml /function/pom.xml
RUN ["mvn", "package", "dependency:copy-dependencies", "-DincludeScope=runtime", "-DskipTests=true", "-Dmdep.prependGroupId=true", "-DoutputDirectory=target", "--fail-never"]

ADD src /function/src
RUN ["mvn", "package", "-DskipTests=true"]

FROM fnproject/fn-java-fdk:jre11-1.0.109
#Using Resource-Pricipal. Not using the config files.
#RUN mkdir -p /home/builder/.oci
#RUN mkdir -p /.oci


#COPY config /.oci/config
#COPY oci_api_key.pem /home/builder/.oci/oci_api_key.pem

##COPY /oci-config/config /.oci/config
##COPY /oci-config/oci_api_key.pem /.oci/oci_api_key.pem

WORKDIR /function
COPY --from=build-stage /function/target/*.jar /function/app/

CMD ["com.example.fn.DiscountCampaignUploader::handleRequest"]