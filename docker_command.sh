sudo docker run  \
--restart=unless-stopped -d  \
-p 80:4141  \
--name atlantis   \
infracost/infracost-atlantis:latest server   \
--gitlab-user={GitLab-User}   \
--gitlab-token={GitLab-Access-Token}   \
--repo-allowlist='{GitLab-Repo-URL}'  \
--repo-config-json='
    {
      "repos": [
        {
          "id": "/.*/",
          "allowed_overrides":["apply_requirements","workflow"],
          "allow_custom_workflows":true,
          "workflow": "atlantis-infracost"
        }
      ],
      "workflows": {
        "atlantis-infracost": {
          "plan": {
            "steps": [
              "init",
              "plan",
              {
                "env": {
                  "name": "INFRACOST_API_KEY",
                  "value": "{Infracost-API-Key}"
                }
              },
              {
                "env": {
                  "name": "INFRACOST_TERRAFORM_BINARY",
                  "command": "echo \"terraform\""
                }
              },
              {
                "run": "/home/atlantis/infracost_atlantis_diff.sh"
              }
            ]
          }
        }
      }
    }
  '