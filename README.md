# swarm-vote-app
This app provisions compelete docker swarm catvs dogs app enviorment with one manager node and 2 workers. The provisioning constructs the nodes and joins docker swarm using vagrant.
Steps to deploy:
1. Download the two files anywhere.
2. Run app.sh , Note: Donot change the vagrant file loaction keep it beside the app.sh and make sure the app.sh has the required premissions , for example run chmod 777 on app.sh and vagrant file.

What happens in the background:
The app.sh download vagrant , virtual box , the unbuntu image and docker pacakges. Once all downloaded , a swarm cluster is consturcted and then the vagrant file starts to assign the roles of managers and workers. The next step we take the deploy stack for the voting app and we add labels
"
deploy:
  labels:
    - "swarm.autoscaler=true"
 "
 Beside some selected services that needs to be scaled. The auto scaling mechanism is borrowed from https://github.com/jcwimer/docker-swarm-autoscaler where it depends on promethus and node exporters for mointioring purposes.once the cpu or memeory threshold is hit it scales the services using this sh file https://github.com/jcwimer/docker-swarm-autoscaler/blob/master/docker-swarm-autoscaler/auto-scale.sh. Moreover we added the md5 password of the user in the deploy-stack-01.yml to not expose the plaintext password.
When the cluster is avaliable the next step vagrant ssh  is used to access the manager node to deploy the autoscaler and the voting app using docker stack deploy.

To access the url of the voting app use  ip http://192.168.56.32:5001/ for results and for voting http://192.168.56.32:5000. The ip's are fixed in the vagrant file , however you can exchange them with required ip's. I didn't make it as DHCP and i wanted to be static ip's.
 
