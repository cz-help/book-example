FROM czhelp/mp-base

LABEL maintainer=info@evolveum.com

ADD https://raw.githubusercontent.com/Evolveum/midpoint-samples/master/samples/book/8/hr.csv /opt/midpoint/var/resources/

ADD https://raw.githubusercontent.com/Evolveum/midpoint-samples/master/samples/book/8/extension-example.xsd /opt/midpoint/var/schema/

ADD https://raw.githubusercontent.com/Evolveum/midpoint-samples/master/samples/book/8/resource-csv-hr.xml \
 https://raw.githubusercontent.com/Evolveum/midpoint-samples/master/samples/book/8/resource-openldap.xml \
 https://raw.githubusercontent.com/Evolveum/midpoint-samples/master/samples/book/8/object-template-user.xml \
 https://raw.githubusercontent.com/Evolveum/midpoint-samples/master/samples/book/8/role-cook.xml \
 https://raw.githubusercontent.com/Evolveum/midpoint-samples/master/samples/book/8/role-employee.xml \
 https://raw.githubusercontent.com/Evolveum/midpoint-samples/master/samples/book/8/role-hatter.xml \
 https://raw.githubusercontent.com/Evolveum/midpoint-samples/master/samples/book/8/role-sales-agent.xml \
 https://raw.githubusercontent.com/Evolveum/midpoint-samples/master/samples/book/8/role-sales-assistant.xml \
 https://raw.githubusercontent.com/Evolveum/midpoint-samples/master/samples/book/8/role-sales-manager.xml \
 z-001-task-update-resource-ldap_host-chapter9.xml \
 z-002-task-testResource-resource-csv.xml \
 /opt/midpoint/var/post-initial-objects/

