#!/bin/sh
export DD_API_KEY={{datadog_api_key}}
install_script=`wget -qO- http://dtdg.co/agent-install-ubuntu`
bash -c "$install_script"
