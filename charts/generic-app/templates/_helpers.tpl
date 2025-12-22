{{- define "app.service" }}
{{- .Release.Name }} 
{{- end }}

{{- define "app.namespace" -}}
{{- printf "%s-%s" .Release.Name .Values.environment | lower -}}
{{- end -}}

{{- define "app.hasSecretFiles" -}}
{{- $hasFiles := false -}}
{{- range .secretProviderClass.secrets -}}
  {{- if .fileName -}}
    {{- $hasFiles = true -}}
  {{- end -}}
{{- end -}}
{{- $hasFiles -}}
{{- end -}}
