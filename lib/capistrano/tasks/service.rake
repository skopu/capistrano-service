Capistrano::Configuration.env.fetch(:services, []).each do |service|
  namespace :service do
    namespace service do
      desc "Restart service: #{service}"
      Rake::Task.define_task(:restart) do |t|
        on roles fetch(:"#{service}_roles", :all) do
          execute :service, service, "restart"
        end
      end

      desc "Start service: #{service}"
      Rake::Task.define_task(:start) do |t|
        on roles fetch(:"#{service}_roles", :all) do
          execute :service, service, "start"
        end
      end

      desc "Stop service: #{service}"
      Rake::Task.define_task(:stop) do |t|
        on roles fetch(:"#{service}_roles", :all) do
          execute :service, service, "stop"
        end
      end

      desc "Status for service: #{service}"
      Rake::Task.define_task(:status) do |t|
        on roles fetch(:"#{service}_roles", :all) do
          info capture("service #{service} status")
        end
      end
      
      desc "Reload service: #{service}"
      Rake::Task.define_task(:reload) do |t|
        on roles fetch(:"#{service}_roles", :all) do
          info capture("service #{service} reload")
        end
      end
    end
  end
end
