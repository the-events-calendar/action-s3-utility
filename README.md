# GitHub Action to check for file existence in an S3 bucket

This action uses the AWS CLI to verify a file's existence to help prevent executing GitHub Workflows when they are unnecessary.

## Usage

This action relies on having an S3 bucket on which to make requests.

### `workflow.yml` Step Example

You can add the following as a step in one of your workflows:

```
- name: S3 File Exists
  uses: the-events-calendar/action-s3-exists
	env:
		S3_BUCKET: ${{ secrets.S3_BUCKET }}
		S3_ACCESS_KEY_ID: ${{ secrets.S3_ACCESS_KEY_ID }}
		S3_SECRET_ACCESS_KEY: ${{ secrets.S3_SECRET_ACCESS_KEY }}
		S3_REGION: ${{ secrets.S3_REGION }}
		S3_ENDPOINT: ${{ secrets.S3_ENDPOINT }}
		FILE: 'some-file-name.txt'
```

#### Configuration

The following settings must be passed as environment variables as shown
in the example. Sensitive information, especially `S3_ACCESS_KEY_ID` and
`S3_SECRET_ACCESS_KEY` should be set as encrypted secrets — otherwise,
they'll be public to anyone browsing your repository's source code and
CI logs.

| Key | Value | Suggested Type | Required | Default |
| ------------- | ------------- | ------------- | ------------- | ------------- |
| `S3_ACCESS_KEY_ID` | Your AWS Access Key. [More info here.](https://docs.aws.amazon.com/general/latest/gr/managing-aws-access-keys.html) | `secret env` | **Yes** | N/A |
| `S3_SECRET_ACCESS_KEY` | Your AWS Secret Access Key. [More info here.](https://docs.aws.amazon.com/general/latest/gr/managing-aws-access-keys.html) | `secret env` | **Yes** | N/A |
| `S3_BUCKET` | The name of the bucket you're syncing to. For example, `jarv.is` or `my-app-releases`. | `secret env` | **Yes** | N/A |
| `S3_REGION` | The region where you created your bucket. Set to `us-east-1` by default. [Full list of regions here.](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/using-regions-availability-zones.html#concepts-available-regions) | `env` | No | `us-east-1` |
| `S3_ENDPOINT` | The endpoint URL of the bucket you're syncing to. Can be used for [VPC scenarios](https://aws.amazon.com/blogs/aws/new-vpc-endpoint-for-amazon-s3/) or for non-AWS services using the S3 API, like [DigitalOcean Spaces](https://www.digitalocean.com/community/tools/adapting-an-existing-aws-s3-application-to-digitalocean-spaces). | `env` | No | Automatic (`s3.amazonaws.com` or AWS's region-specific equivalent) |
| `FILE` | The file you want to check for the existence of | `env` | No | `/` (root of bucket) |
