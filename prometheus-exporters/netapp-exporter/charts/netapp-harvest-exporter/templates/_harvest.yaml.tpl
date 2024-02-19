Defaults:
  auth_style: basic_auth
  username: {{ .Values.global.netapp_exporter_user }}
  password: {{ .Values.global.netapp_exporter_password }}
  use_insecure_tls: true
  exporters:
    - prom1
Exporters:
  prom1:
    exporter: Prometheus
    global_prefix: netapp_
    port: 13000
Pollers:{{`
  {{ .Name }}:
    {{- if (eq .Name "stnpca1-bb097") }}
    addr: stnpca1-bb097a.cc.qa-de-1.cloud.sap 
    {{- else }}
    addr: {{ .Host }}
    {{- end }}
    datacenter: {{ .AvailabilityZone }}
    labels:
      - availability_zone: {{ .AvailabilityZone }}
      - filer: {{ .Name }}`}}
    collectors:
      - Rest:
        - limited.yaml
      - RestPerf:
        - limited.yaml
      {{- if eq .Values.global.region "qa-de-1" }}
      - Ems
      {{- end }}
