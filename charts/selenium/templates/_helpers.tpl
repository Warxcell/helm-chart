{{/*
Common labels
*/}}
{{- define "selenium.commonLabels" -}}
app.kubernetes.io/managed-by: {{ .Release.Service }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/version: {{ .Chart.AppVersion }}
app.kubernetes.io/component: {{ printf "selenium-grid-%s" .Chart.AppVersion }}
helm.sh/chart: {{ printf "%s-%s" .Chart.Name (.Chart.Version | replace "+" "_") }}
{{- end -}}

{{- define "selenium.fullname" -}}
{{ include "common.names.fullname" . }}
{{- end -}}

{{/*
Selenium Hub fullname
*/}}
{{- define "selenium.hub.fullname" -}}
{{ printf "%s-hub" (include "common.names.fullname" .) }}
{{- end -}}

{{/*
Event bus fullname
*/}}
{{- define "selenium.eventBus.fullname" -}}
{{ printf "%s-event-bus" (include "common.names.fullname" .) }}
{{- end -}}

{{/*
Router fullname
*/}}
{{- define "selenium.router.fullname" -}}
{{ printf "%s-router" (include "common.names.fullname" .) }}
{{- end -}}

{{/*
Distributor fullname
*/}}
{{- define "selenium.distributor.fullname" -}}
{{ printf "%s-distributor" (include "common.names.fullname" .) }}
{{- end -}}

{{/*
SessionMap fullname
*/}}
{{- define "selenium.sessionMap.fullname" -}}
{{ printf "%s-session-map" (include "common.names.fullname" .) }}
{{- end -}}

{{/*
SessionQueuer fullname
*/}}
{{- define "selenium.sessionQueuer.fullname" -}}
{{ printf "%s-session-queuer" (include "common.names.fullname" .) }}
{{- end -}}

{{/*
Chrome node fullname
*/}}
{{- define "selenium.chromeNode.fullname" -}}
{{ printf "%s-chrome" (include "common.names.fullname" .) }}
{{- end -}}

{{/*
Firefox node fullname
*/}}
{{- define "selenium.firefoxNode.fullname" -}}
{{ printf "%s-firefox" (include "common.names.fullname" .) }}
{{- end -}}

{{/*
Edge node fullname
*/}}
{{- define "selenium.edgeNode.fullname" -}}
{{ printf "%s-edge" (include "common.names.fullname" .) }}
{{- end -}}

{{- define "selenium.node.grid_url" -}}
{{- if .Values.hub.ingress.enabled -}}
{{ printf  "http%s://%s" (.Values.hub.ingress.tls.enabled | ternary "s" "") .Values.hub.ingress.host }}
{{- else -}}

{{- end -}}
{{- end -}}

{{- define "selenium.hub.host" -}}
{{- .Values.isolateComponents | ternary (include "selenium.eventBus.fullname" .) (.Values.hub.enabled | ternary (include "selenium.hub.fullname" .) .Values.hub.host) -}}
{{- end -}}

{{- define "selenium.hub.publish_port" -}}
{{- ternary .Values.components.eventBus.publishPort .Values.hub.publishPort .Values.isolateComponents -}}
{{- end -}}

{{- define "selenium.hub.subscribe_port" -}}
{{- ternary .Values.components.eventBus.subscribePort .Values.hub.subscribePort .Values.isolateComponents -}}
{{- end -}}

{{- define "selenium.hub.port" -}}
{{- ternary .Values.components.router.port .Values.hub.port .Values.isolateComponents -}}
{{- end -}}
