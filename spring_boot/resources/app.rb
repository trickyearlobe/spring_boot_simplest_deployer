property :name,         String,   default: 'badapp'
property :artifact_url, String,   default: 'https://bad.springboot.url/badjar.jar'

action :create do
  package node['spring_boot']['jdk'] do
    action :install
  end

  directory "/opt/springboot/#{new_resource.name}" do
    recursive true
    owner 'root'
    group 'root'
    mode  '0755'
  end

  remote_file "/opt/springboot/#{new_resource.name}/#{new_resource.name}.jar" do
    source new_resource.artifact_url
    owner 'root'
    group 'root'
    mode '0755'
    notifies :restart, "service[springboot.#{new_resource.name}]"
  end

  systemd_unit "springboot.#{new_resource.name}.service" do
    content(
      Unit: {
        Description: "springboot.#{new_resource.name}",
        Documentation: "https://www.chef.io",
        After: 'syslog.target'
      },
      Service: {
        # type: 'notify',
        ExecStart: "/usr/bin/java -jar /opt/springboot/#{new_resource.name}/#{new_resource.name}.jar",
        # Restart: 'always',
        SuccessExitStatus: 143
      },
      Install: {
        WantedBy: 'multi-user.target'
      }
    )
    action :create
    notifies :restart, "service[springboot.#{new_resource.name}]"
  end

  service "springboot.#{new_resource.name}" do
    action [:enable, :start]
  end
end
