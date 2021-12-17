<h2> Part Two </2>

<h3> What is the most basic way you can deploy the app? </h3>
<li>Spin up a ec2 on the public subnet in aws and in the shell run ./mafia.py </li>
<li>Allow inbound port 3000 TCP traffic security group</li>
<li>On your browser use the public ip of the ec2 and provide the port the application runs on (3000).</li>

<h3> How can this deployment evolve over time? </h3>
<li> Auto scaling group for scaling based on metrics and fault tolerance </li>
<li> Create a load balancer to distribute traffic </li>
<li> Consider creating read replicas if the application does intensive reads </li> 

<h3> Does it need a backend database? How would that work? </h3>
<li> </li>

<h3> Explain the process of deploying your app. </h3>
<li> </li> 

