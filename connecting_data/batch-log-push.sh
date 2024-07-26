#!/usr/local/env bash

#----------------------------------------------------------------------------#
#                         CORALOGIX API LOG PUSHER                           #
#----------------------------------------------------------------------------#
# This script is used to push logs to Coralogix using the Coralogix REST API.#
# The script uses the curl command to send logs to Coralogix.                #
# The script sends logs in batches. Each batch contains multiple log lines.  #
#----------------------------------------------------------------------------#

# Set the following variables to the desired values
APPLICATION_NAME="Arun Test Task"
SUBSYSTEM_NAME="Coralogix System"
PRIVATE_KEY="<PRIVATE KEY>" # Replace with your Coralogix Private Key
ENDPOINT="https://ingress.eu2.coralogix.com/logs/v1/singles"

# Set the log lines to be sent to Coralogix
curl --location "${ENDPOINT}" \
    --header "Content-Type: application/json" \
    --header "Authorization: Bearer ${PRIVATE_KEY}" \
    --data '@-' <<EOF
[{
    "log_level": "INFO",
    "applicationName": "${APPLICATION_NAME}",
    "subsystemName": "${SUBSYSTEM_NAME}",
    "threadId": "137",
    "text": "AppsFlyerPostback?re_targeting_conversion_type=&is_retargeting=false&app_id=id624512118&platform=ios&event_type=in-app-event&attribution_type=organic&event_time=2021-04-01 09:30:50&event_time_selected_timezone=2021-04-01 02:30:50.070-0700&event_name=app-login&event_value=&currency=USD&selected_currency=USD&revenue_in_selected_currency=&cost_per_install=&click_time=&click_time_selected_timezone=&install_time=2020-03-10 11:11:17&install_time_selected_timezone=2020-03-10 04:11:17.000-0700&agency=&media_source=Organic&campaign=&af_siteid=&fb_campaign_id=&fb_campaign_name=&fb_adset_name=&fb_adset_id=&fb_adgroup_id=&fb_adgroup_name=&country_code=US&city=Brighton&ip=72.168.176.99&wifi=true&language=en-US&appsflyer_device_id=1583824277535-7503370&customer_user_id=&idfa=&mac=&device_name=&device_type=iPhone11,6&os_version=14.4.1&sdk_version=v4.7.11&app_version=1.9.1&af_sub1=&af_sub2=&af_sub3=&af_sub4=&af_sub5=&click_url=&http_referrer=&idfv=A894C35F-75A3-48BA-9197-04151F8A5A12&app_name=Lucky Play Casino Slots Games&download_time=2020-03-10 11:11:17&download_time_selected_timezone=2020-03-10 04:11:17.000-0700&af_keywords=&bundle_id=com.rocketplay.luckyplay&attributed_touch_type=&attributed_touch_time="
},
{
    "log_level": "INFO",
    "applicationName": "${APPLICATION_NAME}",
    "subsystemName": "${SUBSYSTEM_NAME}",
    "threadId": "64",
    "text": "AppsFlyerPostback?re_targeting_conversion_type=&is_retargeting=false&app_id=id624512118&platform=ios&event_type=in-app-event&attribution_type=organic&event_time=2021-04-01 09:30:58&event_time_selected_timezone=2021-04-01 02:30:58.404-0700&event_name=app-login&event_value=&currency=USD&selected_currency=USD&revenue_in_selected_currency=&cost_per_install=&click_time=&click_time_selected_timezone=&install_time=2021-03-17 23:32:36&install_time_selected_timezone=2021-03-17 16:32:36.018-0700&agency=&media_source=Organic&campaign=&af_siteid=&fb_campaign_id=&fb_campaign_name=&fb_adset_name=&fb_adset_id=&fb_adgroup_id=&fb_adgroup_name=&country_code=US&city=Clewiston&ip=71.196.0.131&wifi=true&language=en-US&appsflyer_device_id=1616009509246-659121&customer_user_id=&idfa=FB6E43C3-579E-4212-ACB2-0C54EEAF0361&mac=&device_name=&device_type=iPhone12,1&os_version=14.4.1&sdk_version=v4.7.11&app_version=1.9.1&af_sub1=&af_sub2=&af_sub3=&af_sub4=&af_sub5=&click_url=&http_referrer=&idfv=03D60765-02C4-42B7-95B1-E69DAAFE0E4B&app_name=Lucky Play Casino Slots Games&download_time=2021-03-17 23:31:49&download_time_selected_timezone=2021-03-17 16:31:49.000-0700&af_keywords=&bundle_id=com.rocketplay.luckyplay&attributed_touch_type=&attributed_touch_time="
},
{
    "log_level": "INFO",
    "applicationName": "${APPLICATION_NAME}",
    "subsystemName": "${SUBSYSTEM_NAME}",
    "threadId": "106",
    "text": "AppsFlyerPostback?re_targeting_conversion_type=&is_retargeting=false&app_id=id624512118&platform=ios&event_type=in-app-event&attribution_type=organic&event_time=2021-04-01 09:30:47&event_time_selected_timezone=2021-04-01 02:30:47.439-0700&event_name=app-login&event_value=&currency=USD&selected_currency=USD&revenue_in_selected_currency=&cost_per_install=&click_time=&click_time_selected_timezone=&install_time=2020-11-29 19:46:46&install_time_selected_timezone=2020-11-29 11:46:46.000-0800&agency=&media_source=Organic&campaign=&af_siteid=&fb_campaign_id=&fb_campaign_name=&fb_adset_name=&fb_adset_id=&fb_adgroup_id=&fb_adgroup_name=&country_code=US&city=Brownsville&ip=172.58.97.104&wifi=false&language=es-419&appsflyer_device_id=1606657606338-9252906&customer_user_id=&idfa=40869A1A-5233-4522-A913-EEA4FA62F121&mac=&device_name=&device_type=iPhone11,6&os_version=14.4&sdk_version=v4.7.11&app_version=1.9.1&af_sub1=&af_sub2=&af_sub3=&af_sub4=&af_sub5=&click_url=&http_referrer=&idfv=552DC8F3-B196-4561-8047-20D6763AA2C4&app_name=Lucky Play Casino Slots Games&download_time=2020-11-29 19:46:46&download_time_selected_timezone=2020-11-29 11:46:46.000-0800&af_keywords=&bundle_id=com.rocketplay.luckyplay&attributed_touch_type=&attributed_touch_time="
}]
EOF
