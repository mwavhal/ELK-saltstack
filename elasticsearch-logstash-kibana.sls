nstall openjdk -------#

openjdk-7-jre-headless:
  pkg:
    - installed

#-------- Install logstash -------#
base:
  pkgrepo.managed:
    - humanname: Logstash PPA
    - name: deb http://ppa.launchpad.net/wolfnet/logstash/ubuntu precise main
    - dist: precise
    - file: /etc/apt/sources.list.d/logstash.list
    - keyid: 28B04E4A
    - keyserver: keyserver.ubuntu.com
    - require_in:
      - pkg: logstash

  pkg.latest:
    - name: logstash
    - refresh: True

logstash:
  service.running:
    - enable: True

#------ Copy contents of config files from master to minion -------#

/etc/logstash/conf.d/01-lumberjack-input.conf:
  file:
    - managed
    - source: salt://logstash/01-lumberjack-input.conf
    - template: jinja

/etc/logstash/conf.d/10-syslog.conf:
  file:
    - managed
    - source: salt://logstash/10-syslog.conf
    - template: jinja

/etc/logstash/conf.d/30-lumberjack-output.conf:
  file:
    - managed
    - source: salt://logstash/30-lumberjack-output.conf
    - template: jinja

#-------- Make directory structure to generate ssl certificate -------#
/etc/pki:
  file.directory:
    - makedirs: True
    - user: root
/etc/pki/tls:
  file.directory:
    - makedirs: True
    - user: root

/etc/pki/tls/certs:
  file.directory:
    - makedirs: True
    - user: root

elasticsearch_repo:
    pkgrepo.managed:
        - humanname: Elasticsearch Official Debian Repository
        - name: deb http://packages.elasticsearch.org/elasticsearch/1.4/debian stable main
        - dist: stable
        - key_url: http://packages.elasticsearch.org/GPG-KEY-elasticsearch
        - file: /etc/apt/sources.list.d/elasticsearch.list

elasticsearch:
    pkg:
        - installed
        - require:
            - pkgrepo: elasticsearch_repo
    service:
        - running
        - enable: True
        - require:
            - pkg: elasticsearch
#----- Nginx ------#

nginx_stable_ppa:
    pkgrepo.managed:
        - ppa: nginx/stable
        - require_in:
            - pkg: nginx

nginx:
  pkg:
    - installed
  service:
    - running
    - enable: True
    - reload: True
    - watch:
      - pkg: nginx

