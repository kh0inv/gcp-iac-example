gcloud compute forwarding-rules create prime-lb \
    --address IP \
    --load-balancing-scheme internal \
    --region=REGION \
    --backend-service prime-service \
    --ports 80

gcloud compute backend-services create prime-service \
    --load-balancing-scheme internal \
    --region=REGION \
    --protocol tcp \
    --health-checks ilb-health

gcloud compute backend-services add-backend prime-service \
    --instance-group backend --instance-group-zone=ZONE \
    --region=REGION




gcloud compute health-checks create http ilb-health --request-path /2

gcloud compute firewall-rules create http \
    --target-tags backend
    --allow=tcp:80 \
    --source-ranges IP \
