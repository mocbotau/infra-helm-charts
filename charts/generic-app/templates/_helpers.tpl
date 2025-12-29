{{- define "app.service" }}
{{- .Release.Name }} 
{{- end }}

{{- define "app.namespace" -}}
{{- printf "%s-%s" .Release.Name .Values.environment | lower -}}
{{- end -}}

{{/*
Generate smart default for secret fileName
Converts secretKey to lowercase kebab-case if fileName not provided
Example: DATABASE_URL -> database-url
*/}}
{{- define "app.secretFileName" -}}
{{- .fileName | default (.secretKey | lower | replace "_" "-") -}}
{{- end -}}

{{/*
Generate smart default for secret envName
Defaults to secretKey if envName not provided
*/}}
{{- define "app.secretEnvName" -}}
{{- .envName | default .secretKey -}}
{{- end -}}

{{/*
Common pod spec template for both deployments and statefulsets
Reduces duplication and ensures consistency
*/}}
{{- define "app.podSpec" -}}
{{- if .nodeSelector }}
nodeSelector:
  {{- toYaml .nodeSelector | nindent 2 }}
{{- end }}
{{- if .affinity }}
affinity:
  {{- toYaml .affinity | nindent 2 }}
{{- end }}
{{- if .tolerations }}
tolerations:
  {{- toYaml .tolerations | nindent 2 }}
{{- end }}
{{- if .initContainer }}
initContainers:
  - name: {{ .initContainer.name }}
    image: {{ .initContainer.image }}
    command: {{ .initContainer.command | toYaml | nindent 6 }}
{{- end }}
containers:
  - name: {{ .name }}
    image: {{ .image }}
    imagePullPolicy: {{ .pullPolicy | default "Always" }}
    {{- if .service }}
    ports:
      - containerPort: {{ .service.targetPort | default 80 }}
    {{- end }}
    {{- if .readinessProbe }}
    readinessProbe:
      {{- if .readinessProbe.httpGet }}
      httpGet:
        path: {{ .readinessProbe.httpGet.path }}
        port: {{ .readinessProbe.httpGet.port }}
      {{- else if .readinessProbe.tcpSocket }}
      tcpSocket:
        port: {{ .readinessProbe.tcpSocket.port }}
      {{- end }}
      initialDelaySeconds: {{ .readinessProbe.initialDelaySeconds | default 5 }}
      periodSeconds: {{ .readinessProbe.periodSeconds | default 10 }}
      timeoutSeconds: {{ .readinessProbe.timeoutSeconds | default 1 }}
    {{- end }}
    {{- if .resources }}
    resources:
      {{- if .resources.limits }}
      limits:
        cpu: {{ .resources.limits.cpu | default "200m" }}
        memory: {{ .resources.limits.memory | default "256Mi" }}
      {{- end }}
      {{- if .resources.requests }}
      requests:
        cpu: {{ .resources.requests.cpu | default "100m" }}
        memory: {{ .resources.requests.memory | default "128Mi" }}
      {{- end }}
    {{- end }}
    {{- if or .environment (and .secretProviderClass .secretProviderClass.syncAsKubernetesSecret) }}
    envFrom:
      {{- if .environment }}
      - configMapRef:
          name: env-{{ .name }}
      {{- end }}
      {{- if and .secretProviderClass .secretProviderClass.syncAsKubernetesSecret }}
      - secretRef:
          name: secrets-{{ .name }}
      {{- end }}
    {{- end }}
    {{- if or .config .secretProviderClass .volumes }}
    volumeMounts:
      {{- if .volumes }}
      {{- range .volumes }}
      - name: {{ .name }}
        mountPath: {{ .mountPath }}
        readOnly: {{ .readOnly | default false }}
      {{- end }}
      {{- end }}
      {{- if .config }}
      - name: config-file-{{ .name }}
        mountPath: {{ .config.mountPath | default "/config" }}
        subPath: {{ .config.subPath | default "" }}
        readOnly: true
      {{- end }}
      {{- if .secretProviderClass }}
      - name: secrets-{{ .name }}
        mountPath: /secrets
        readOnly: true
      {{- end }}
    {{- end }}
{{- if or .config .secretProviderClass .volumes }}
{{- if not $.context.isStatefulSet }}
volumes:
  {{- range .volumes }}
  - name: {{ .name }}
    persistentVolumeClaim:
      claimName: {{ .name }}
  {{- end }}
  {{- if .config }}
  - name: config-file-{{ .name }}
    configMap:
      name: config-file-{{ .name }}
  {{- end }}
  {{- if .secretProviderClass }}
  - name: secrets-{{ .name }}
    csi:
      driver: secrets-store.csi.k8s.io
      readOnly: true
      volumeAttributes:
        secretProviderClass: secrets-{{ .name }}
  {{- end }}
{{- else }}
{{- if or .config .secretProviderClass }}
volumes:
  {{- if .config }}
  - name: config-file-{{ .name }}
    configMap:
      name: config-file-{{ .name }}
  {{- end }}
  {{- if .secretProviderClass }}
  - name: secrets-{{ .name }}
    csi:
      driver: secrets-store.csi.k8s.io
      readOnly: true
      volumeAttributes:
        secretProviderClass: secrets-{{ .name }}
  {{- end }}
{{- end }}
{{- end }}
{{- end }}
{{- end -}}
