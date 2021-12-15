#!/bin/bash
source $(dirname "$0")/runtime.properties

function updateMavenSettings(){
  sed 's@${MAVEN_REPO_USERNAME}@'$MAVEN_REPO_USERNAME'@g ; s@${MAVEN_REPO_PASSWORD}@'$MAVEN_REPO_PASSWORD'@g ; s@${MAVEN_REPO_URL}@'$MAVEN_REPO_URL'@' \
    $(dirname "$0")/settings.xml.template > /opt/custom-config/settings.xml
}

updateMavenSettings

${EAP_HOME}/bin/standalone.sh -c standalone-full.xml -b 0.0.0.0 \
  -DkeycloakSso_authUrl=${SSO_AUTH_URL} -DkeycloakSso_realm_name=${SSO_REALM} \
  -DkeycloakSso_deployment=business-central.war \
  -DkeycloakSso_realm_client_name=${SSO_CLIENT_NAME} \
  -DkeycloakSso_realm_client_secret=${SSO_SECRET} \
  -Dorg.kie.server.user=${KIESERVER_USERNAME} \
  -Dorg.kie.server.pwd=${KIESERVER_PASSWORD}

#-Drhpam.sso.token=${SSO_BC_SECRET}  \