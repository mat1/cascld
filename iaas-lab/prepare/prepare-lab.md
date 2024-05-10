# Lab Vorbereitung

1. AWS Educate Credits beantragen

2. Neuer AWS User erstellen

3. AWS User zur AWS Organization hinzufügen

4. IAM Gruppe CAS erstellen

5. Policy für Gruppe festlegen

AmazonEC2FullAccess
AmazonElastiCacheFullAccess
AWSCloudTrail_ReadOnlyAccess
Neue Policy erstellen `cas-limit-instance-type.json` und der Gruppe zuweisen

6. Create Access Key für neuen AWS User

7. Update `~/.aws/credentials`

8. CAS Users erstellen `./create-users.sh`

9. CSV Export

10. AWS Regions aktivieren `./enable-regions.sh` oder im UI unter Account
