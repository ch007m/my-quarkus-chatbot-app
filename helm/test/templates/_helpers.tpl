{{/* TODO */}}

{{- define "expression.image.name" -}}
{{- printf "{{ index .ImageAnnotations \"org.opencontainers.image.base.name\"}}" }}
{{- end }}

{{- define "expression.image.digest" -}}
{{- printf "{{ index .ImageAnnotations \"org.opencontainers.image.base.digest\"}}" }}
{{- end }}

{{- define "git.repo.url" -}}
{{- printf "https://%s/%s/%s.git" .Values.git.repo .Values.git.org .Values.git.name -}}
{{- end }}

{{- define "backstage.labels" -}}
backstage.io/kubernetes-id: {{ .Values.app.name }}
{{- end }}