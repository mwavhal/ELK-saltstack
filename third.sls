openjdk-7-jre-headless:
  pkg:
    - installed

/srv/logstash/:
  file.directory:
    - makedirs: True
    - user: root
    - group: root

/srv/logstash/log/:
  file.directory:
    - makedirs: True
    - user: root
    - group: root

/etc/logstash/:
  file.directory:
    - makedirs: True
    - user: root
    - group: root

/etc/logstash/conf.d:
  file.directory:
    - makedirs: True
    - user: root
    - group: root

  file.managed:
    - source: salt://logstash/01-lumberjack-input.conf
    - user: root
    - reuire:
      dir: conf.d
#    - source_hash: md5=d1c7091cddc37387230982be46473f06
#    - template: jinja

#  copy_my_files:
#    file.recurse:
#      - source: 10.43.4.237://etc/logstash/01-lumberjack-input.conf
#      - target: /etc/logstash/conf.d/01-lumberjack-input.conf
#/etc/logstash/conf.d/:
#    - include_empty: True
#    - copy: src=/etc/logstash/01-lumberjack-input.conf  dest=/etc/logstash/conf.d/01-lumberjack-input.conf  owner=root group=root mode=0644
#    - recurse: True 
#    - copy: src=/etc/logstash/hi dest=/etc/logstash/conf.d/  owner=root group=root mode=0644

