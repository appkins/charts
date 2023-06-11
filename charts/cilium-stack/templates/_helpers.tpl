{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "cilium-stack.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "cilium-stack.fullname" -}}
{{- coalesce .Values.fullnameOverride .Values.nameOverride .Release.Name .Chart.Name | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "cilium-stack.namespace" -}}
{{ default .Release.Namespace .Values.namespaceOverride }}
{{- end -}}

{{- define "cilium-stack.replicas" -}}
{{- .Values.global.enabled -}}
{{- end -}}

{{- define "cilium-stack.domain" -}}
{{- printf "%s.svc.%s" (include "cilium-stack.namespace" .) .Values.global.clusterDomain -}}
{{- end -}}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "cilium-stack.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "cilium-stack.labels" -}}
helm.sh/chart: {{ include "cilium-stack.chart" . }}
{{ include "cilium-stack.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "cilium-stack.selectorLabels" -}}
app.kubernetes.io/name: {{ include "cilium-stack.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{- define "monitoring.namespace" -}}
{{- default .Release.Namespace .Values.monitoring.namespace -}}
{{- end -}}

{{- define "prometheus.enabled" -}}
{{- if .Values.tags.monitoring -}}
{{- .Values.prometheus.enabled -}}
{{- else -}}
{{- .Values.tags.monitoring -}}
{{- end -}}
{{- end -}}

{{/*
MinIO Values.
*/}}
{{- define "cilium-stack.minio.endpoint" -}}
{{- printf "%s.%s:%s" "minio" (include "cilium-stack.domain" .) (.Values.minio.service.port | toString) -}}
{{- end -}}

{{- define "cilium-stack.minio.user" -}}
{{- .Values.minio.rootUser }}
{{- end -}}

{{- define "cilium-stack.minio.password" -}}
{{- .Values.minio.rootPassword }}
{{- end -}}
