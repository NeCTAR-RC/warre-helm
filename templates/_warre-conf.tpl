{{- define "warre-conf" }}
[database]
connection_recycle_time=600

[warre]
bot_auth_url={{ .Values.conf.keystone.auth_url }}
bot_role_id={{ .Values.conf.warre.bot_role_id }}
bot_user_id={{ .Values.conf.warre.bot_user_id }}

[oslo_messaging_rabbit]
rabbit_ha_queues=True
ssl=True
amqp_durable_queues=True

[service_auth]
auth_url={{ .Values.conf.keystone.auth_url }}
username={{ .Values.conf.keystone.username }}
project_name={{ .Values.conf.keystone.project_name }}
user_domain_name=Default
project_domain_name=Default
auth_type=password

[keystone_authtoken]
auth_url={{ .Values.conf.keystone.auth_url }}
www_authenticate_uri={{ .Values.conf.keystone.auth_url }}
username={{ .Values.conf.keystone.username }}
project_name={{ .Values.conf.keystone.project_name }}
user_domain_name=Default
project_domain_name=Default
auth_type=password
{{- if .Values.conf.keystone.memcached_servers }}
memcached_servers={{ join "," .Values.conf.keystone.memcached_servers }}
{{- end }}

[oslo_limit]
auth_url={{ .Values.conf.keystone.auth_url }}
username={{ .Values.conf.keystone.username }}
user_domain_name=Default
auth_type=password
system_scope=all
service_name={{ .Values.conf.keystone.service_name }}
endpoint_id={{ .Values.conf.keystone.endpoint_id }}
region_name={{ .Values.conf.keystone.region_name }}
{{- if .Values.conf.keystone.memcached_servers }}
memcached_servers={{ join "," .Values.conf.keystone.memcached_servers }}
{{- end }}

{{- end }}
