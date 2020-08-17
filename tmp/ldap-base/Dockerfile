FROM actualys/ldap

LABEL maintainer=info@evolveum.com

ENV LDAP_DOMAIN=example.com
ENV LDAP_PASSWORD=secret

ADD https://raw.githubusercontent.com/Evolveum/midpoint-samples/master/samples/book/2/example.aci https://raw.githubusercontent.com/Evolveum/midpoint-samples/master/samples/book/2/openldap-base.ldif /etc/ldap/init/
RUN sed -i '/olcAccess: to attrs/,$d' /etc/ldap/init/slapd.conf.ldif \
	&& sed "s/\(.*\)/olcAccess: \1/g" /etc/ldap/init/example.aci >>/etc/ldap/init/slapd.conf.ldif \
	&& sed -n '/^dn: ou=Administrators,dc=example,dc=com/,$p' /etc/ldap/init/openldap-base.ldif >>/etc/ldap/init/db.ldif \
	&& sed -i '1,/^# Organization Units$/d' /etc/ldap/init/db.ldif \
        && head -13 /etc/ldap/init/memberof.ldif | sed "s/\({0}\)\{0,1\}memberof/sssvlv/g;s/MemberOf/SssVlvConfig/g" >/etc/ldap/init/sssvlv.ldif \
	&& sed -i "/^# Add base domain./i cat /etc/ldap/init/sssvlv.ldif | slapadd -F /etc/ldap/slapd.d -b \"cn=config\"" /install.sh

ENTRYPOINT ["/run.sh", "-h ldapi:/// ldap:/// ldaps:///"]

CMD []
