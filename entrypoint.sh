#!/bin/bash
#set -e

if [[ $LICENSE_KEY ]]; then
	sed -i -e "s/^.*license_key:.*$/license_key: ${LICENSE_KEY}/" /etc/cloudinsight-agent/cloudinsight-agent.conf
else
	echo "You must set LICENSE_KEY environment variable to run the Cloudinsight Agent container"
	exit 1
fi

if [[ $TAGS ]]; then
	sed -i -e "s/^#tags:.*$/tags: ${TAGS}/" /etc/cloudinsight-agent/cloudinsight-agent.conf
fi

if [[ $LOG_LEVEL ]]; then
    sed -i -e"s/^.*log_level:.*$/log_level: ${LOG_LEVEL}/" /etc/cloudinsight-agent/cloudinsight-agent.conf
fi

if [[ $CI_URL ]]; then
    sed -i -e "s/^.*ci_url:.*$/ci_url: ${CI_URL}/" /etc/cloudinsight-agent/cloudinsight-agent.conf
fi

if [[ $PROXY_HOST ]]; then
    sed -i -e "s/^# proxy_host:.*$/proxy_host: ${PROXY_HOST}/" /etc/cloudinsight-agent/cloudinsight-agent.conf
fi

if [[ $PROXY_PORT ]]; then
    sed -i -e "s/^# proxy_port:.*$/proxy_port: ${PROXY_PORT}/" /etc/cloudinsight-agent/cloudinsight-agent.conf
fi

if [[ $PROXY_USER ]]; then
    sed -i -e "s/^# proxy_user:.*$/proxy_user: ${PROXY_USER}/" /etc/cloudinsight-agent/cloudinsight-agent.conf
fi

if [[ $PROXY_PASSWORD ]]; then
    sed -i -e "s/^# proxy_password:.*$/proxy_password: ${PROXY_PASSWORD}/" /etc/cloudinsight-agent/cloudinsight-agent.conf
fi

find /conf.d -name '*.yaml' -exec cp {} /etc/cloudinsight-agent/conf.d \;

export PATH="/opt/cloudinsight-agent/embedded/bin:/opt/cloudinsight-agent/bin:$PATH"

exec "$@"

