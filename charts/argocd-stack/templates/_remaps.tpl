{{- define "kube-prometheus-stack.fullname" -}}
{{- print "prometheus" -}}
{{- end -}}

{{- /*
  minio
*/ -}}
{{- define "minio.name" -}}
{{- print "minio" -}}
{{- end -}}
{{- define "minio.fullname" -}}
{{- print "minio" -}}
{{- end -}}
