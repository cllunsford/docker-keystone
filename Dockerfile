FROM cllunsford/osbase
MAINTAINER Chris Lunsford <cllunsford@gmail.com>

RUN apt-get install -y libxml2-dev libxslt-dev lib32z1-dev

WORKDIR /opt
RUN git clone --branch 2014.1.1 https://github.com/openstack/keystone.git
WORKDIR /opt/keystone

RUN pip install -r requirements.txt
RUN python setup.py install

RUN mkdir -p /etc/keystone
RUN cp etc/keystone.conf.sample /etc/keystone/keystone.conf
RUN cp etc/keystone-paste.ini /etc/keystone/
RUN cp etc/policy.json /etc/keystone/

EXPOSE 5000
EXPOSE 35357

ADD run.sh /opt/keystone/
CMD ./run.sh
