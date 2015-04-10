
openjdk-7-jre-headless:
  pkg:
    - installed

/srv/logstash/:
  file.directory:
    - makedirs: True
    - user: root

/srv/logstash/log/:
  file.directory:
    - makedirs: True
    - user: root 

/etc/logstash/:
  file.directory:
    - makedirs: True
    - user: root

/etc/logstash/conf.d:
  file.directory:
    - makedirs: True
    - user: root
    
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
