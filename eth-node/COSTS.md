# GCP Resource Cost Breakdown (Monthly Estimate)

All prices are in USD and based on GCP's us-east1 region pricing.

## Compute Costs

### VM Instance (n2-standard-4)
- vCPUs: 4
- Memory: 16 GB
- Hours per month: 730 (24/7 operation)
- Cost per hour: $0.189994
- **Monthly Cost: $138.70**

## Storage Costs

### Boot Disk (pd-ssd)
- Size: 200 GB
- Cost per GB/month: $0.17
- **Monthly Cost: $34.00**

### Data Disk (pd-ssd)
- Size: 1024 GB (1 TB)
- Cost per GB/month: $0.17
- **Monthly Cost: $174.08**

### Snapshots
- Average size: 1 TB
- Retention: 7 days
- Cost per GB/month: $0.026
- Estimated monthly snapshot storage: 500 GB (compressed)
- **Monthly Cost: $13.00**

## Network Costs

### Internet Egress
- Estimated monthly traffic: 1 TB
- First 1 TB per month: $0.12/GB
- **Monthly Cost: $122.88**

### Internal Network
- VPC Network usage
- **Monthly Cost: $0.00** (free within same region)

## Other Costs

### Cloud Logging
- Basic logging included free
- Estimated 2 GB/month
- **Monthly Cost: $0.50**

### Cloud Monitoring
- Basic metrics included free
- **Monthly Cost: $0.00**

## Total Estimated Monthly Costs

| Resource Category | Cost |
|------------------|------|
| Compute          | $138.70 |
| Boot Disk        | $34.00 |
| Data Disk        | $174.08 |
| Snapshots        | $13.00 |
| Network Egress   | $122.88 |
| Logging          | $0.50 |
| **Total**        | **$483.16** |

## Cost Optimization Tips

1. **Compute Optimization**
   - Consider using committed use discounts for 1-year or 3-year terms (up to 57% savings)
   - Use preemptible instances if interruptions are acceptable (up to 80% savings)

2. **Storage Optimization**
   - Adjust snapshot frequency based on needs
   - Consider using pd-balanced instead of pd-ssd for less critical workloads
   - Delete unnecessary snapshots promptly

3. **Network Optimization**
   - Limit unnecessary API calls
   - Use caching where possible
   - Consider using Cloud CDN for static content

4. **Monitoring Optimization**
   - Set up budget alerts
   - Regular review of resource utilization
   - Implement auto-scaling policies if needed

## Additional Considerations

- Prices are based on pay-as-you-go rates
- Actual costs may vary based on:
  - Real network usage
  - Actual disk usage
  - Region selection
  - Commitment discounts
  - Special pricing programs
- Network egress costs can vary significantly based on actual usage
- Consider using GCP's pricing calculator for more precise estimates

## Cost Control Measures

1. **Budget Alerts**
   - Set up at 50%, 75%, and 90% of budget
   - Configure email notifications

2. **Resource Quotas**
   - Set limits on resource usage
   - Monitor quota utilization

3. **Regular Reviews**
   - Monthly cost analysis
   - Resource utilization checks
   - Optimization opportunities

_Note: Prices are current as of 2024 and subject to change. Please check [GCP's pricing page](https://cloud.google.com/pricing) for the most up-to-date information._ 