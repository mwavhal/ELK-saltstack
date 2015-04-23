python-apt:
  pkg:
    - installed
 
python-software-properties:
  pkg:
    - installed
 
oracle-java-ppa:
  pkgrepo:
    - managed
    - humanname: WebUpd8 Oracle Java PPA repository
    {% if grains['os'] == 'Debian' %}
    - name: deb http://ppa.launchpad.net/webupd8team/java/ubuntu precise main
    - file: /etc/apt/sources.list.d/webupd8team-java-precise.list
    - keyid: EEA14886
    - keyserver: keyserver.ubuntu.com
    - require_in:
      - pkg: oracle-java7-installer
    {% elif grains['os'] == 'Ubuntu' %}
    - ppa: webupd8team/java
    {% endif %}
 
oracle-java-license-autoaccept:
  debconf:
    - set
    - name: oracle-java7-installer
    - data:
        'shared/accepted-oracle-license-v1-1': {'type': 'boolean', 'value': True}
 
oracle-java7-installer:
  pkg:
    - installed
    - require:
      - debconf: oracle-java-license-autoaccept
