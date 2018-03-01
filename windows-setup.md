# Windows Slave Setup

1. Download and install Java (JRE)
1. Open powershell admin
1. `cd C:\Users\Administrator\Downloads\`
1. `wget "http://URLGOESHERE/jnlpJars/agent.jar" -OutFile "agent.jar"`
1. `mkdir C:\Users\Administrator\Documents\jenkins`
1. `$env:Path += ";C:\Program Files (x86)\Java\jre1.8.0_161\bin"`
1. `java -jar agent.jar -jnlpUrl http://URLGOESHERE/computer/AGENTNAMEGOESHERE/slave-agent.jnlp -secret SECRETGOESHERE -workDir "C:\Users\Administrator\Documents\jenkins"`

## OR

Just  navigate to jenkins master, to the node, click launch then install as service!!!!