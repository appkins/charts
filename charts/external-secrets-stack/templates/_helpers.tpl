{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "external-secrets-stack.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "external-secrets-stack.fullname" -}}
{{- coalesce .Values.fullnameOverride .Values.nameOverride .Release.Name .Chart.Name | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "external-secrets-stack.namespace" -}}
{{ default .Release.Namespace .Values.namespaceOverride }}
{{- end -}}

{{- define "external-secrets-stack.replicas" -}}
{{- .Values.global.enabled -}}
{{- end -}}

{{- define "external-secrets-stack.domain" -}}
{{- printf "%s.svc.%s" (include "external-secrets-stack.namespace" .) .Values.global.clusterDomain -}}
{{- end -}}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "external-secrets-stack.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "external-secrets-stack.labels" -}}
helm.sh/chart: {{ include "external-secrets-stack.chart" . }}
{{ include "external-secrets-stack.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "external-secrets-stack.selectorLabels" -}}
app.kubernetes.io/name: {{ include "external-secrets-stack.name" . }}
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
{{- define "external-secrets-stack.minio.endpoint" -}}
{{- printf "%s.%s:%s" "minio" (include "external-secrets-stack.domain" .) (.Values.minio.service.port | toString) -}}
{{- end -}}

{{- define "external-secrets-stack.minio.user" -}}
{{- .Values.minio.rootUser }}
{{- end -}}

{{- define "external-secrets-stack.minio.password" -}}
{{- .Values.minio.rootPassword }}
{{- end -}}
