FROM ubuntu:18.04
RUN apt-get update && apt-get install -y \
	python \
	git \
	python-setuptools \
	python3-dev \
	tox \
	gcc \
	python-pip \
	python-pymysql
RUN mkdir cloudkitty \
	&& cd cloudkitty \
	&& git clone https://git.openstack.org/openstack/cloudkitty.git . \
	&& git checkout 8.0.0 \
	&& python setup.py install \
	&& mkdir /etc/cloudkitty \
	&& tox -e genconfig \
	&& cp etc/cloudkitty/cloudkitty.conf.sample /etc/cloudkitty/cloudkitty.conf \
	&& cp etc/cloudkitty/api_paste.ini /etc/cloudkitty \
	&& mkdir /var/log/cloudkitty/ \
	&& pip install -r requirements.txt

COPY policy.json /etc/cloudkitty/policy.json
COPY metrics.yml /etc/cloudkitty/metrics.yml
