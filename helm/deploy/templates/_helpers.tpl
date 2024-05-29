{{/*
Expand the name of the chart.
*/}}
{{- define "quarkus-template.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{- define "quarkus-template.namespace" -}}
{{- printf "%s" .Values.app.namespace }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "quarkus-template.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "quarkus-template.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common annotations
*/}}
{{- define "quarkus-template.annotations" -}}
app.openshift.io/vcs-uri: {{ printf "https://%s/%s/%s.git" .Values.git.repo .Values.git.org .Values.git.name }}
app.quarkus.io/quarkus-version: 3.7.1
{{- end }}

{{/*
Common labels
*/}}
{{- define "backstage.labels" -}}
backstage.io/kubernetes-id: {{ .Values.app.name }}
{{- end }}

{{- define "quarkus-template.labels" -}}
backstage.io/kubernetes-id: {{ .Values.app.name }}
helm.sh/chart: {{ include "quarkus-template.chart" . }}
{{ include "quarkus-template.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.openshift.io/runtime: quarkus
{{- end }}

{{/*
Selector labels
*/}}
{{- define "quarkus-template.selectorLabels" -}}
app.kubernetes.io/name: {{ include "quarkus-template.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "quarkus-template.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "quarkus-template.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}
