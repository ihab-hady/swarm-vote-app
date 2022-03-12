 #!/bin/bash


 brew  install --cask virtualbox
 brew  install --cask vagrant
 brew  install --cask vagrant-manager
 vagrant box add ubuntu/xenial64 http://cloud-images.ubuntu.com/xenial/current/xenial-server-cloudimg-amd64-vagrant.box
 vagrant up
 #### uncommment below when you have similar machine names, this will make sure to filter by the path from where the code is fired
 #### ex. 'manager' vms names in different location #######
 #pwd=$(pwd) 
 #BOX_ID=$(vagrant global-status | grep manager |grep $pwd |  awk '{print $1}')
 ####################
 
 BOX_ID=$(vagrant global-status | grep manager | awk '{print $1}')
 vagrant ssh $BOX_ID  -- -t '
 git clone https://github.com/jcwimer/docker-swarm-autoscaler.git
 cd docker-swarm-autoscaler
 docker stack deploy -c swarm-autoscaler-stack.yml autoscaler
 cd /home/vagrant/example-voting-app
 docker stack deploy --compose-file docker-stack-01.yml vote
  echo "============== scaling up vote app services ====================="
 docker service scale vote_db=1
 docker service scale vote_redis=1
 docker service scale vote_worker=1
 docker service scale vote_visualizer=1
 docker service scale vote_result=1
'


