FROM node:7
MAINTAINER Wilfried Goesgens <willi@arangodb.com>

# ARG HTTP_PROXY
# for local installation, uncomment
# ADD ./arangodb /install

COPY ./scripts/copyFileLockedIfNewer.py /usr/bin/

# add scripts to install the compiler toolchain
ADD ./scripts /scripts

RUN \
  echo 'deb http://ftp.debian.org/debian jessie-backports main' | tee /etc/apt/sources.list.d/backports.list; \
  apt-get update; \
  apt-get install -y curl python-setuptools python python-pip python-argparse debhelper apt-utils apt-transport-https ; \
  (rm -f /var/cache/apt/archives/*deb /var/lib/apt/lists/* || true )

# First the more modern stuff so we don't need to update over packages:
RUN cd /tmp/ ; \
  curl -O http://download.opensuse.org/repositories/home:/fceller2/Debian_8.0//Release.key; \
  apt-key add - < Release.key; \
  rm Release.key; \
  echo 'deb http://download.opensuse.org/repositories/home:/fceller2/Debian_8.0/ /' | tee /etc/apt/sources.list.d/arangodbbuild.list

RUN apt-get update; \
  apt-get install -y arangodb-gcc54 tar bzip2 make build-essential libjemalloc-dev libssl-dev ditaa xvfb libidn11-dev daemon libldap2-dev ; \
  apt-get -t jessie-backports install -y git ; \
  apt-get -t jessie-backports install -y cmake  ; \
  apt-get -t jessie-backports install -y git ; \
  apt-get -t jessie-backports install -y calibre ; \
  rm -f /usr/bin/ditaa; \
  printf '#!/bin/bash\njava -jar /usr/share/ditaa/ditaa.jar $@\n' > /usr/bin/ditaa; \
  chmod a+x /usr/bin/ditaa; \
  (rm -f /var/cache/apt/archives/*deb /var/lib/apt/lists/* || true )

RUN pip install lockfile

RUN cd /root; git clone https://github.com/arangodb-helper/markdown-pp/&& cd markdown-pp; python setup.py install; cd ..; rm -rf markdown-pp
RUN cd /root; git clone https://github.com/amperser/proselint.git; cd proselint; python setup.py install; cd ..; rm -rf proselint

RUN npm install gitbook-cli -g

RUN sed -i /etc/fstab -e "s;node;jenkins;"

RUN mkdir /home/jenkins

RUN echo 'PATH=/opt/arangodb/bin/:${PATH}' >> /etc/bashrc
RUN echo 'PATH=/opt/arangodb/bin/:${PATH}' >> /etc/profile


RUN for i in 3.1 3.2 3.3 devel; do \
    mkdir -p /tmp/$i; \
    cd /tmp/$i; \
    for book in AQL HTTP Manual; do \
        curl -O https://raw.githubusercontent.com/arangodb/arangodb/$i/Documentation/Books/${book}/book.json; \
        gitbook install -g; \
    done; \
    curl -O https://raw.githubusercontent.com/arangodb/Cookbook/master/recipes/book.json; \
    gitbook install -g; \
    pwd; \
    touch blarg; \
done 

RUN mkdir /usr/local/nodeshit
RUN mv ~/.gitbook/ /usr/local/nodeshit/gitbook; chmod a+rwX -R /usr/local/nodeshit/gitbook
RUN mv ~/.npm/ /usr/local/nodeshit/npm;         chmod a+rwX -R /usr/local/nodeshit/npm

RUN ln -s /usr/local/nodeshit/gitbook ~/.gitbook
RUN ln -s /usr/local/nodeshit/npm ~/.npm
RUN cp -a /tmp/devel /tmp/1

# expose the build directory:
RUN mkdir -p /jenkins
VOLUME ["/jenkins"]

# expose shared storage:
RUN mkdir -p /net/fileserver
VOLUME ["/net/fileserver"]

