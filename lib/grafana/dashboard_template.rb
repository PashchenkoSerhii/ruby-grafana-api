
module Grafana

  module DashboardTemplate

    # CloudWatch Namespaces, Dimensions and Metrics Reference:
    # http://docs.aws.amazon.com/AmazonCloudWatch/latest/DeveloperGuide/CW_Support_For_AWS.html
    @@cw_dimensions = []


    def build_template(params={})

      if !params.has_key?('from')
        params['from'] = 'now-24h'
      end
      if !params.has_key?('to')
        params['to'] = 'now'
      end
      if params['title'] == ''
        return false
      end

      rows = []
      params['panels'].each do |panel|
        rows.push(self.build_panel(panel))
      end

      tpl = %q[
        {
          "dashboard": {
            "refresh": "30m",
            "id": null,
            "title": "%{title}",
            "annotations": {
              "list": []
            },
            "hideControls": false,
            "timezone": "",
            "editable": true,
            "rows": [
              %{rows}
            ],
            "time": {
              "from": "%{from}",
              "to": "%{to}"
            },
            "templating": {
              "list": []
            },
            "style": "dark",
            "version": 5,
            "links": []
          },
          "overwrite": false,
          "folderUid": "%{folder_uid}"
        }
      ]

      return tpl % {
        title: params['title'],
        from: params['from'],
        to: params['to'],
        rows: rows.join(','),
        folder_uid: params['folderUid']
      }

    end


    def build_panel(params={})

      panel = %q[
        {
          "editable": true,
          "height": "250px",
          "panels": [
            {
              "description": "%{description}",
              "fieldConfig": {
                "defaults": {
                  "color": {
                    "mode": "palette-classic"
                  },
                  "custom": {
                    "axisLabel": "Count",
                    "axisPlacement": "auto",
                    "barAlignment": 0,
                    "drawStyle": "line",
                    "fillOpacity": 0,
                    "gradientMode": "none",
                    "hideFrom": {
                      "legend": false,
                      "tooltip": false,
                      "viz": false
                    },
                    "lineInterpolation": "linear",
                    "lineWidth": 1,
                    "pointSize": 5,
                    "scaleDistribution": {
                      "type": "linear"
                    },
                    "showPoints": "auto",
                    "spanNulls": false,
                    "stacking": {
                      "group": "A",
                      "mode": "none"
                    },
                    "thresholdsStyle": {
                      "mode": "off"
                    }
                  },
                  "mappings": [],
                  "thresholds": {}
                }
              },
              "gridPos": {
                "h": %{position_h},
                "w": %{position_w},
                "x": %{position_x},
                "y": %{position_y}
              },
              "id": null,
              "options": {
                "legend": {
                  "calcs": [],
                  "displayMode": "list",
                  "placement": "bottom"
                },
                "tooltip": {
                  "mode": "single",
                  "sort": "none"
                }
              },
              "targets": [
                %{targets}
              ],
              "title": "%{title}",
              "type": "timeseries"
            }
          ]
        }
      ]

      targets = []
      params['targets'].each do |t|
        targets.push(self.build_target(t))
      end

      return panel % {
        description: params['description'],
        title: params['title'],
        position_h: params['gridPos']['h'],
        position_w: params['gridPos']['w'],
        position_x: params['gridPos']['x'],
        position_y: params['gridPos']['y'],
        targets: targets.join(',')
      }
    end

    def build_target(params={})
      target = %q[
        {
          "exemplar": true,
          "expr": "%{expr}",
          "interval": "",
          "legendFormat": "",
          "refId": "%{refId}"
        }
      ]

      return target % {
        expr: params['expr'],
        refId: params['refId']
      }

    end

  end

end