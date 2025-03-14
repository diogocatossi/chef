#
# Cookbook:: apache
# Spec:: default
#
# Copyright:: 2025, The Authors, All Rights Reserved.

require 'spec_helper'

describe 'apache::default' do

  step_into :apache_vhost

  context 'When all attributes are default, on Ubuntu 20.04' do
    platform 'ubuntu', '20.04'

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end

    it 'installs the apache2 package' do
      expect(chef_run).to install_package('apache2')
    end

    it 'starts and enables the apache2 service' do
      expect(chef_run).to start_service('apache2')
      expect(chef_run).to enable_service('apache2')
    end

    it 'creates the USERS conf file' do
      expect(chef_run).to render_file('/etc/apache2/sites-enabled/users.conf')
    end

    it 'creates the ADMINS conf file' do
      expect(chef_run).to render_file('/etc/apache2/sites-enabled/admins.conf')
    end

    it 'creates the USERS conf directory' do
      expect(chef_run).to create_directory('/srv/apache/users/html')
    end

    it 'creates the USERS index file' do
      expect(chef_run).to render_file('/srv/apache/users/html/index.html').with_content('<h1>Welcome users!</h1>')
    end

    it 'creates the ADMIN conf directory' do
      expect(chef_run).to create_directory('/srv/apache/admins/html')
    end

    it 'creates the ADMIN index file' do
      expect(chef_run).to render_file('/srv/apache/admins/html/index.html').with_content('<h1>Welcome admins!</h1>')
    end
  end

  context 'When all attributes are default, on CentOS 8' do
    platform 'centos', '8'

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end

    it 'installs the httpd package' do
      expect(chef_run).to install_package('httpd')
    end

    it 'starts and enables the httpd service' do
      expect(chef_run).to start_service('httpd')
      expect(chef_run).to enable_service('httpd')
    end

    it 'creates the USERS conf file' do
      expect(chef_run).to render_file('/etc/httpd/conf.d/users.conf')
    end
    it 'creates the ADMINS conf file' do
      expect(chef_run).to render_file('/etc/httpd/conf.d/admins.conf')
    end

    it 'creates the USERS conf directory' do
      expect(chef_run).to create_directory('/srv/apache/users/html')
    end

    it 'creates the USERS index file' do
      expect(chef_run).to render_file('/srv/apache/users/html/index.html').with_content('<h1>Welcome users!</h1>')
    end

    it 'creates the ADMIN conf directory' do
      expect(chef_run).to create_directory('/srv/apache/admins/html')
    end

    it 'creates the ADMIN index file' do
      expect(chef_run).to render_file('/srv/apache/admins/html/index.html').with_content('<h1>Welcome admins!</h1>')
    end
  end
end
