# DB instance list చెక్ చేయండి
aws rds describe-db-instances --query "DBInstances[*].DBInstanceIdentifier"

# Instance delete చేయండి (final snapshot skip చేయాలంటే --skip-final-snapshot)
aws rds delete-db-instance \
    --db-instance-identifier <your-db-instance-id> \
    --skip-final-snapshot \
    --delete-automated-backups

# Aurora cluster అయితే (cluster + instances రెండూ delete చేయాలి)
aws rds delete-db-instance \
    --db-instance-identifier <cluster-instance-id> \
    --skip-final-snapshot

aws rds delete-db-cluster \
    --db-cluster-identifier <your-cluster-id> \
    --skip-final-snapshot

# మిగిలిన manual snapshots చెక్ చేయండి
aws rds describe-db-snapshots --query "DBSnapshots[*].DBSnapshotIdentifier"

# ఒక్కో snapshot delete చేయండి
aws rds delete-db-snapshot --db-snapshot-identifier <snapshot-id>