{{- define "warre-conf" }}
[DEFAULT]
# Expose oslo.messaging's RPC server ping endpoint so the worker
# startup probe (nectar-health-probe rpc-ping) can call it.
rpc_ping_enabled=true
# Same value warre sets in code; stated here so external tools such
# as nectar-health-probe see the right exchange from config alone.
control_exchange=warre

[database]
connection_recycle_time=600

[warre]
bot_auth_url={{ .Values.conf.keystone.auth_url }}
bot_role_id={{ .Values.conf.warre.bot_role_id }}
bot_user_id={{ .Values.conf.warre.bot_user_id }}

[blazar]
interface={{ .Values.conf.blazar.interface }}

[sentry]
environment={{ .Values.conf.sentry.environment }}

[oslo_messaging_rabbit]
ssl=True
rabbit_quorum_queue=true
rabbit_transient_quorum_queue=true
rabbit_stream_fanout=true
rabbit_qos_prefetch_count=1

[oslo_messaging_notifications]
driver = messagingv2

[oslo_middleware]
enable_proxy_headers_parsing=True

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
service_token_roles_required=True
{{- if .Values.conf.keystone.memcached_servers }}
memcached_servers={{ join "," .Values.conf.keystone.memcached_servers }}
{{- end }}

[oslo_limit]
auth_url={{ .Values.conf.keystone.auth_url }}
username={{ .Values.conf.keystone.username }}
user_domain_name=Default
auth_type=password
system_scope=all
endpoint_id={{ .Values.conf.keystone.endpoint_id }}
region_name={{ .Values.conf.keystone.region_name }}
{{- if .Values.conf.keystone.memcached_servers }}
memcached_servers={{ join "," .Values.conf.keystone.memcached_servers }}
{{- end }}

{{- end }}
