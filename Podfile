source 'https://github.com/CocoaPods/Specs.git'
source 'git@github.com:EnterTech/PodSpecs.git'
use_frameworks!
platform :ios, '10.0'

# classified by fucntion: e.g. ui, tool
def ui
    # pod 'SnapKit', '~> 1.0.0'
end

def tool
# pod 'FlowTimeBLE', :git=> "git@github.com:Entertech/Enter-Biomodule-BLE-iOS-SDK.git", :branch=> "master"
end

# your app target 
target 'xxxx' do
    ui
    tool
end

# Swift Upgrade: generate a repo in specific swift version  
post_install do |installer|
    installer.pods_project.targets.each do |target|
        if ['xxxx'].include? "#{target}"
            target.build_configurations.each do |config|
                config.build_settings['SWIFT_VERSION'] = '4.0'
            end
        end
    end
end
