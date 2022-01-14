pid_file = "/src/dotnet-vault/pidfile"

auto_auth {
  method {
    type = "approle"
    config = {
      role_id_file_path                   = "/src/dotnet-vault/role-id"
      remove_secret_id_file_after_reading = false
    }
  }
}

template {
  source      = "/src/dotnet-vault/appsettings.ctmpl"
  destination = "/src/dotnet-vault/appsettings.json"
}