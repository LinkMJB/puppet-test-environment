FROM alpine:3.4
MAINTAINER Heston Snodgrass "heston.snodgrass@connexta.com"

RUN apk add --update \
    ruby \
    ruby-irb \
    ruby-rdoc \
    && gem install puppet puppet-lint puppet-syntax rake rspec rspec-puppet rspec-puppet-facts rspec-puppet-utils

ENTRYPOINT ["/bin/bash"]
