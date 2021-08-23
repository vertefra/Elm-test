# Test Kubernetes deployements with Helm and ArgoCD.

Goal for this project is a CI/CD pipeline that will deliver on two different Kubernetes clusters, simulating a staging environment and a production environment.

ArgoCD will monitor changes on the `staging` and `prod` branches, pulling the application image from Github registry and setting up the Kubernetes deployemnt based on the Helm manifests templates. In particular, the application on the staging environment, will have only one replica, while the one in production will have 3 replicas.

The parameters defining the `deployment.yml` manifest comes from `values.yml` and `values-prod.yml` for production, and `values.yml` and `values-stag.yml` for staging.

This values file are defined in the argo application manifest

<img src="https://user-images.githubusercontent.com/63065831/130364034-2607abdf-53d5-4414-82dd-78ee3de81578.png" style="width:100px;"/>

Once a commitment is pushed on stagin or develop branches, the Github CI is triggered, updating the Docker image on Github registry.

On the remote server (In my case a VM handled by Vagrant with Kubernetes and ArgoCD installed) the two branches are monitored for changes by ArgoCD

![Screenshot from 2021-08-22 12-19-20](https://user-images.githubusercontent.com/63065831/130364190-e4041513-f335-44fa-9739-612a8c751e48.png).

![Screenshot from 2021-08-22 12-27-33](https://user-images.githubusercontent.com/63065831/130364292-4c319b02-21e2-49b1-abdd-e8eee15b0a22.png)

Syncronization will deploy the Application on the Kubernetes cluster, following the manifests stored in `elm/templates`.
On the staging branch all the specific templates values will be taken from `values-stag` while the production values from `values-prod`.

Generating, in two different namespaces, a deployment with only one replica for the staging environment 
![Screenshot from 2021-08-22 12-27-44](https://user-images.githubusercontent.com/63065831/130364263-b9ace6fa-6f91-4e2c-a9e3-a1c19affc1fc.png)

and three replicas for the production environment

![Screenshot from 2021-08-22 13-06-29](https://user-images.githubusercontent.com/63065831/130364278-4b52dc0c-b13a-43a2-93ad-009945aa6ae8.png)


