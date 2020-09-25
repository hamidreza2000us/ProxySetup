#this script setup a Proxy server (Capsule) for a running foreman installation
#######################################################################################
git clone https://github.com/hamidreza2000us/proxysetup.git
ssh-copy-id root@$ProxyIP

bash ~/proxysetup/CO78-BaseProxyParameters.sh
scp -r ~/proxysetup root@$ProxyIP:~/
ssh $ProxyIP bash ~/proxysetup/CO78--Foreman-proxy-BaseSystem.sh
ssh $ProxyIP bash ~/proxysetup/CO78-SetupChronyClient.sh 
ssh $ProxyIP bash ~/proxysetup/CO78-IDMRegister.sh
ssh $ProxyIP bash ~/proxysetup/CO78-ProxySetup.sh
script=$(foreman-proxy-certs-generate --foreman-proxy-fqdn "$ProxyHOSTNAME" --certs-tar "/root/$ProxyHOSTNAME-certs.tar")
scp "/root/$ProxyHOSTNAME-certs.tar" root@$ProxyIP:~/
ssh $ProxyIP bash $script

