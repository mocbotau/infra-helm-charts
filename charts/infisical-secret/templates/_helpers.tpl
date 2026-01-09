{{/*
Expand the name of the chart.
*/}}
{{- define "infisical-secret.name" -}}
{{- default .Chart.Name .Values.name | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
*/}}
{{- define "infisical-secret.fullname" -}}
{{- if .Values.name }}
{{- .Values.name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.name }}
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
{{- define "infisical-secret.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "infisical-secret.labels" -}}
helm.sh/chart: {{ include "infisical-secret.chart" . }}
{{ include "infisical-secret.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- with .Values.labels }}
{{ toYaml . }}
{{- end }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "infisical-secret.selectorLabels" -}}
app.kubernetes.io/name: {{ include "infisical-secret.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Get the namespace
*/}}
{{- define "infisical-secret.namespace" -}}
{{- default .Release.Namespace .Values.namespace }}
{{- end }}

{{/*
Get the secret file name
*/}}
{{- define "infisical-secret.secretFileName" -}}
{{- if .fileName }}
{{- .fileName }}
{{- else if .envName }}
{{- .envName | lower | replace "_" "-" }}
{{- else }}
{{- .secretKey | lower | replace "_" "-" }}
{{- end }}
{{- end }}

{{/*
Get the secret environment variable name
*/}}
{{- define "infisical-secret.secretEnvName" -}}
{{- if .envName }}
{{- .envName }}
{{- else }}
{{- .secretKey }}
{{- end }}
{{- end }}

{{/*
Get the Kubernetes secret name
*/}}
{{- define "infisical-secret.kubernetesSecretName" -}}
{{- if .Values.syncAsKubernetesSecret.secretName }}
{{- .Values.syncAsKubernetesSecret.secretName }}
{{- else }}
{{- printf "%s-secret" (include "infisical-secret.fullname" .) }}
{{- end }}
{{- end }}
