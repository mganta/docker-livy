# docker-livy
A Docker image for [Livy, the REST Spark Server](https://github.com/cloudera/livy).

## Running 

which will expose the port `8998` on the Docker host for this image.

## Details

Have a look at the [official docs](https://github.com/cloudera/livy#rest-api) to see how to use the Livy REST API.

For exposing the service URL to http://localhost/service/livy-spark2/, you will need the labels as shown in the json below. Also, breaking docker rules and running spark-mesos-dispatcher in this too :)

Here is the DC/OS service JSON

{
  "volumes": null,
  "id": "/livy-spark2",
  "cmd": null,
  "args": null,
  "user": null,
  "env": null,
  "instances": 1,
  "cpus": 1,
  "mem": 1024,
  "disk": 0,
  "gpus": 0,
  "executor": null,
  "constraints": null,
  "fetch": null,
  "storeUrls": null,
  "backoffSeconds": 1,
  "backoffFactor": 1.15,
  "maxLaunchDelaySeconds": 3600,
  "container": {
    "docker": {
      "image": "mganta/livy2-docker",
      "forcePullImage": true,
      "privileged": false,
      "portMappings": [
        {
          "containerPort": 8998,
          "protocol": "tcp",
          "name": "livy",
          "servicePort": 10007,
          "hostPort": 0
        }
      ],
      "network": "USER"
    }
  },
  "healthChecks": null,
  "readinessChecks": null,
  "dependencies": null,
  "upgradeStrategy": {
    "minimumHealthCapacity": 1,
    "maximumOverCapacity": 1
  },
  "labels": {
    "DCOS_SERVICE_NAME": "livy-spark2",
    "DCOS_SERVICE_SCHEME": "http",
    "DCOS_SERVICE_PORT_INDEX": "0"
  },
  "acceptedResourceRoles": null,
  "ipAddress": {
    "networkName": "dcos"
  },
  "residency": null,
  "secrets": null,
  "taskKillGracePeriodSeconds": null
}

curl for livy job submit

curl -v -H "Content-Type: application/json" -X POST -d '{ "file": "https://<storage>.blob.core.windows.net/myjars/spark-examples_2.11-2.0.1.jar", "className":"org.apache.spark.examples.SparkPi", "args": ["100"] }' 'http://localhost/service/livy-spark2/batches'
