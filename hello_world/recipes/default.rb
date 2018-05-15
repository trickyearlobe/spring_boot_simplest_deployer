#
# Cookbook:: hello_world
# Recipe:: default
#
# Copyright:: 2018, Richard Nixon
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

Chef::Log.info "Executing #{cookbook_name}::#{recipe_name}"

spring_boot_app 'helloworld' do
  artifact_url 'https://s3-eu-west-1.amazonaws.com/emea-techcft/helloworld-0.0.1.jar'
end
