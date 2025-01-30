{{- define "app.service" }}
{{- .Release.Name }} 
{{- end }}

{{- define "app.namespace" -}}
{{- printf "%s-%s" .Release.Name .Values.environment | lower -}}
{{- end -}}
