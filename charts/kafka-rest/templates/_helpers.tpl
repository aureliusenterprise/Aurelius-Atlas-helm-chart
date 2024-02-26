{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "kafka-rest.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "kafka-rest.fullname" -}}
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

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "kafka-rest.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified zookeeper name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
*/}}
{{- define "kafka-rest.cp-zookeeper.fullname" -}}
{{- $name := default "cp-zookeeper" (index .Values "cp-zookeeper" "nameOverride") -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Form the Zookeeper URL. If zookeeper is installed as part of this chart, use k8s service discovery,
else use user-provided URL
*/}}
{{- define "kafka-rest.cp-zookeeper.service-name" }}
{{- if (index .Values "cp-zookeeper" "url") -}}
{{- printf "%s" (index .Values "cp-zookeeper" "url") }}
{{- else -}}
{{- $clientPort := default 2181 (index .Values "cp-zookeeper" "clientPort") | int -}}
{{- printf "%s-headless:%d" (include "kafka-rest.cp-zookeeper.fullname" .) $clientPort }}
{{- end -}}
{{- end -}}

{{/*
Create a default fully qualified schema registry name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
*/}}
{{- define "kafka-rest.cp-schema-registry.fullname" -}}
{{- $name := default "cp-schema-registry" (index .Values "cp-schema-registry" "nameOverride") -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "kafka-rest.cp-schema-registry.service-name" -}}
{{- if (index .Values "cp-schema-registry" "url") -}}
{{- printf "%s" (index .Values "cp-schema-registry" "url") -}}
{{- else -}}
{{- printf "http://%s:8081" (include "kafka-rest.cp-schema-registry.fullname" .) -}}
{{- end -}}
{{- end -}}

{{/*Create a default fully qualified kafka headless name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
*/}}
{{- define "kafka-rest.cp-kafka-headless.fullname" -}}
{{- $name := "cp-kafka-headless" -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "kafka-rest.kafka.bootstrapServers" -}}
{{- if (index .Values "cp-kafka" "bootstrapServers") -}}
{{- printf "%s" (index .Values "kafka" "bootstrapServers") -}}
{{- else -}}
{{- printf "PLAINTEXT://%s:9092" (include "kafka-rest.cp-kafka-headless.fullname" .) -}}
{{- end -}}
{{- end -}}
