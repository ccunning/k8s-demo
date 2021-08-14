# k8s demo

This uses digitalocean to spin up a kubernetes cluster using terraform.

## Prerequisites

1. A Digitalocean account
2. Some applications, including:
  - doctl [https://docs.digitalocean.com/reference/doctl/how-to/install/]
  - terraform (tfswitch is recommended) [https://tfswitch.warrensbox.com/]
  - kubectl [https://kubernetes.io/docs/tasks/tools/]
  - kubectx [https://github.com/ahmetb/kubectx]
  - kubens [https://github.com/ahmetb/kubectx - yes, same as kubectx]
3. Configure doctl to use your account API key
4. Get another API key for terraform an put it in an environment variable called `DIGITALOCEAN_TOKEN`.

## Spin up

To spin up the instance, go into the 'infrastructure' folder and run `terraform apply`. If things look good, respond with 'yes'.
After the cluster is up, run `doctl kubernetes cluster list` to get a list of clusters in your account. Take note of the UUID for the id, and then type `doctl kubernetes cluster kubeconfig save <uuid>` where the <uuid> is replaced with the UUID grabbed from the previous step.

At this point, you should be able to run `kubectl get pods` and see that there are no pods running in the default namespace.

## App

To create the apps:
1. Go into the ingress-nginx folder and run `kubectl apply -f .`. This will apply the ingress-nginx ingress controller, which will be able to spin up a load balancer in digitalocean to redirect public traffic to the cluster.
2. Go into the guestbook folder and run `kubectl apply -k .`. This will apply the kustomize config to spin up 3 redis instances, and 3 frontend web servers.

Because of the load of this, it should force the cluster to autoscale to 3 workers, which you should be able to watch as the cluster-autoscaler is making the decisions when some of the pods are unable to schedule.

The application should now be up and you should be able to hit the application by getting the public IP from `kubectl get ingress -n guestbook`.

## Decom

To shut everything down, run `kubectl destroy -k guestbook; kubectl destroy -f ingress-nginx` to destroy the kubernetes resources. I recommend doing this so it tears down the load balancer correctly (otherwise you will have to go into DO and delete the resource manually or you will be charged for it).

After that has been shut down, you can tear down the cluster by going into the 'infrastructure' folder again and running `terraform destroy` and saying yes when presented to destroy the resources.
