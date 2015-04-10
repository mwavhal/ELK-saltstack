debconf-utils:
  pkg.installed

oracle-java8-installer: 
  pkgrepo.managed: 
    - human_name: ppa:webupd8team/java 
    - ppa: webupd8team/java 
    - comments: 
      - #for oracle java installs

  pkg.installed:
    - require:
      - pkgrepo: oracle-java8-installer
  debconf.set:
   - data:
       'shared/accepted-oracle-license-v1-1': {'type': 'boolean', 'value': True}
   - require_in:
       - pkg: oracle-java8-installer
