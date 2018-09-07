FROM jenkinsxio/builder-base:0.0.497

RUN yum -y groupinstall 'Development Tools'
RUN yum -y install https://packages.chef.io/files/stable/chefdk/3.1.0/el/7/chefdk-3.1.0-1.el7.x86_64.rpm

# Errybody loves JQ
ENV JQ_RELEASE_VERSION 1.5
RUN wget https://github.com/stedolan/jq/releases/download/jq-${JQ_RELEASE_VERSION}/jq-linux64 && mv jq-linux64 jq && chmod +x jq && cp jq /usr/bin/jq


ENV PATH $PATH:/opt/chefdk/bin
ENV PATH $PATH:/opt/chefdk/embedded/bin
ENV PATH $PATH:/usr/local/bin
ENV GEM_ROOT /opt/chefdk/embedded/lib/ruby/gems/2.5.0
# ENV GEM_HOME /some/home/.chefdk/gem/ruby/2.5.0
# ENV GEM_PATH /some/home/.chefdk/gem/ruby/2.5.0:/opt/chefdk/embedded/lib/ruby/gems/2.5.0
ENV GEM_PATH opt/chefdk/embedded/lib/ruby/gems/2.5.0

CMD ["chef","-v"]
