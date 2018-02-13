FROM openjdk:8u151-jdk
MAINTAINER Heston Snodgrass "heston.snodgrass@connexta.com"

ENV JENKINS_HOME /jenkins

RUN apt-get update \
    && apt-get install -y ruby \
    && gem install puppet puppet-lint puppet-syntax rake rspec rspec-puppet rspec-puppet-facts rspec-puppet-utils

COPY scripts/entrypoint.sh /

RUN mkdir -p $JENKINS_HOME

ENTRYPOINT ["/entrypoint.sh"]
