{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "stack.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "stack.namespace" -}}
{{ .Release.Namespace }}
{{- end -}}

{{- define "stack.replicas" -}}
{{- .Values.global.enabled -}}
{{- end -}}

{{- define "stack.domain" -}}
{{- printf "%s.%s" .Values.global.dnsNamespace .Values.global.clusterDomain -}}
{{- end -}}

{{/*
Create the service endpoint including port for MinIO.
*/}}
{{- define "stack.minio" -}}
{{- if .Values.minio.enabled -}}
{{- printf "%s-%s.%s.svc:%s" .Release.Name "minio" .Release.Namespace (.Values.minio.service.port | toString) -}}
{{- end -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "stack.fullname" -}}
{{- if .Values.fullnameOverride -}}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{- define "stack.storage" -}}
{{- if .Values.minio.enabled -}}
{{- print "s3" -}}
{{- else -}}
{{- print "local" -}}
{{- end -}}
{{- end -}}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "stack.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "prometheus.enabled" -}}
{{- if .Values.tags.monitoring -}}
{{- .Values.prometheus.enabled -}}
{{- else -}}
{{- .Values.tags.monitoring -}}
{{- end -}}
{{- end -}}

{{- define "minio.endpoint" -}}
{{- printf "%s-%s.cluster.local:%d" .Release.Name "mimir" -}}
{{- end -}}
