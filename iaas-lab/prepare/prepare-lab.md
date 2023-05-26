# Lab Vorbereitung

1. AWS Educate Credits beantragen

2. Neuer AWS User erstellen

3. IAM Gruppe CAS erstellen

4. Policy für Gruppe festlegen

AmazonEC2FullAccess
AmazonElastiCacheFullAccess
AWSCloudTrailReadOnlyAccess
Neue Policy erstellen `cas-limit-instance-type.json` und der Gruppe zuweisen

5. Create Access Key für neuen AWS User

6. Update `~/.aws/credentials`

7. CAS Users erstellen `./create-users.sh`

8. CSV Export

9. AWS Regions aktivieren `./enable-regions.sh`
