job "cgs-token-presale-static-stage" {
  datacenters = [ "mb-hel" ]
  type = "batch"

  reschedule { attempts = 0 }

  group "cgs-token-presale-static-stage-group" {
    count = 1

    task "cgs-token-presale-static-stage-task" {
      driver = "docker"

      config {
        image = "ghcr.io/communitygrocerystore/token-presale:stage"
        force_pull = true
        entrypoint = [ "/workdir/entrypoint.sh" ]
        mount {
          type = "bind"
          source = "local/entrypoint.sh"
          target = "/workdir/entrypoint.sh"
          readonly = true
        }
        mount {
          type = "bind"
          source = "secrets/rclone.conf"
          target = "/root/.config/rclone/rclone.conf"
          readonly = true
        }
      }

      restart {
        attempts = 0
        mode = "fail"
      }

      resources {
        cpu    = 4096
        memory = 4096
      }

      env {
        PHASE = "stage"
        DEPLOY_BUCKET = "token-presale-staging-communitygrocerystore-com"
        VITE_EVM_NETWORK = "sepolia"
        VITE_CGS_TOKEN_CONTRACT_ADDRESS="0x869c745a364fD9D74a6c1907A184C5E14a35abd3"
        VITE_CGS_PRESALE_CONTRACT_ADDRESS="0xD0937e8FE0b1ddbB301C2c24e9D73011e2Bd1c64"
        VITE_CGS_VESTING_CONTRACT_ADDRESS="0xD138DA59397660fD94D56580c982Fb5C81854813"
        VITE_USDC_CONTRACT_ADDRESS="0x2B3FAD429a904457758E7ec5b78fcaDDD8DE0c52"
        VITE_USDT_CONTRACT_ADDRESS="0x008E6A8EA0D44FAB8Aa620278A0a0e99a99B6DC4"
        VITE_CGS_MULTISIG_ADDRESS="0x98565Bee746Fc9ab8388e635E65f75e932d8C558"
        VITE_REOWN_PROJECT_ID="0254e21e50bf22454533c352a2c5aacb"
      }

      vault { policies = [ "cgs-deployer" ] }

      template {
        data = <<-EOF
        {{ with secret "kv/cgs/cloudflare/cgs-deployer" }}[r2]
        type = s3
        provider = Cloudflare
        region = auto
        endpoint = {{ .Data.data.ENDPOINT }}
        access_key_id = {{ .Data.data.ACCESS_KEY_ID }}
        secret_access_key = {{ .Data.data.SECRET_ACCESS_KEY }}
        {{ end }}
        EOF
        destination = "secrets/rclone.conf"
      }

      template {
        data = <<-EOF
        #!/bin/sh

        echo "Building token-admin static files"
        npm run build

        echo "Syncing token-admin static files to cloudflare r2"
        rclone sync dist r2:${DEPLOY_BUCKET}/
        EOF
        destination = "local/entrypoint.sh"
        perms = "0755"
      }
    }
  }
}
