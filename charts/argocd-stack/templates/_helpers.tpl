{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "argocd-stack.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "argocd-stack.fullname" -}}
{{- coalesce .Values.fullnameOverride .Values.nameOverride .Release.Name .Chart.Name | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "argocd-stack.namespace" -}}
{{ default .Release.Namespace .Values.namespaceOverride }}
{{- end -}}

{{- define "argocd-stack.replicas" -}}
{{- .Values.global.enabled -}}
{{- end -}}

{{- define "argocd-stack.domain" -}}
{{- printf "%s.svc.%s" (include "argocd-stack.namespace" .) .Values.global.clusterDomain -}}
{{- end -}}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "argocd-stack.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "argocd-stack.labels" -}}
helm.sh/chart: {{ include "argocd-stack.chart" . }}
{{ include "argocd-stack.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "argocd-stack.selectorLabels" -}}
app.kubernetes.io/name: {{ include "argocd-stack.name" . }}
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
{{- define "argocd-stack.minio.endpoint" -}}
{{- printf "%s.%s:%s" "minio" (include "argocd-stack.domain" .) (.Values.minio.service.port | toString) -}}
{{- end -}}

{{- define "argocd-stack.minio.user" -}}
{{- .Values.minio.rootUser }}
{{- end -}}

{{- define "argocd-stack.minio.password" -}}
{{- .Values.minio.rootPassword }}
{{- end -}}
