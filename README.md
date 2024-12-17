# GitHub Action to perform various S3 commands

This action uses the AWS CLI to execute various S3 commands (ls, sync, rm) and helper commands (exists). Helper commands are simplified GitHub Action-specific commands for S3 operations.

## Configuration

The following settings must be passed as environment variables for all
of the commands provided by this GitHub Action. Sensitive information, especially `S3_ACCESS_KEY_ID` and
`S3_SECRET_ACCESS_KEY` should be set as encrypted secrets — otherwise,
they'll be public to anyone browsing your repository's source code and
CI logs.

| Key                    | Value                                                                                                                                                                                                                                                                                                                                  | Suggested Type | Required | Default                                                            |
| ---------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | -------------- | -------- | ------------------------------------------------------------------ |
| `COMMAND`              | The action command (see below) you wish to execute                                                                                                                                                                                                                                                                                     | `env`          | **Yes**  | N/A                                                                |
| `S3_ACCESS_KEY_ID`     | Your AWS Access Key. [More info here.](https://docs.aws.amazon.com/general/latest/gr/managing-aws-access-keys.html)                                                                                                                                                                                                                    | `secret env`   | **Yes**  | N/A                                                                |
| `S3_SECRET_ACCESS_KEY` | Your AWS Secret Access Key. [More info here.](https://docs.aws.amazon.com/general/latest/gr/managing-aws-access-keys.html)                                                                                                                                                                                                             | `secret env`   | **Yes**  | N/A                                                                |
| `S3_BUCKET`            | The name of the bucket you're syncing to. For example, `jarv.is` or `my-app-releases`.                                                                                                                                                                                                                                                 | `secret env`   | **Yes**  | N/A                                                                |
| `S3_REGION`            | The region where you created your bucket. Set to `us-east-1` by default. [Full list of regions here.](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/using-regions-availability-zones.html#concepts-available-regions)                                                                                                            | `env`          | No       | `us-east-1`                                                        |
| `S3_ENDPOINT`          | The endpoint URL of the bucket you're syncing to. Can be used for [VPC scenarios](https://aws.amazon.com/blogs/aws/new-vpc-endpoint-for-amazon-s3/) or for non-AWS services using the S3 API, like [DigitalOcean Spaces](https://www.digitalocean.com/community/tools/adapting-an-existing-aws-s3-application-to-digitalocean-spaces). | `env`          | No       | Automatic (`s3.amazonaws.com` or AWS's region-specific equivalent) |

## Commands

### `exists`

This command performs `aws s3api header-object` to verify if a file exists.

#### `workflow.yml` Step Example

You can add the following as a step in one of your workflows:

```
- name: S3 exists
  uses: the-events-calendar/action-s3-utility@main
	env:
		COMMAND: exists
		S3_BUCKET: ${{ secrets.S3_BUCKET }}
		S3_ACCESS_KEY_ID: ${{ secrets.S3_ACCESS_KEY_ID }}
		S3_SECRET_ACCESS_KEY: ${{ secrets.S3_SECRET_ACCESS_KEY }}
		S3_REGION: ${{ secrets.S3_REGION }}
		S3_ENDPOINT: ${{ secrets.S3_ENDPOINT }}
		FILE: 'some-file-name.txt'
```

#### Configuration

Additional configuration for this command:

| Key    | Value                                           | Suggested Type | Required | Default |
| ------ | ----------------------------------------------- | -------------- | -------- | ------- |
| `FILE` | The file you want to check for the existence of | `env`          | Yes      | N/A     |

### `ls`

This command performs `aws s3 ls` and returns the output into the `outputs.ls_output`.

#### `workflow.yml` Step Example

You can add the following as a step in one of your workflows:

```
- name: S3 ls
  uses: the-events-calendar/action-s3-utility@main
	env:
		COMMAND: ls
		S3_BUCKET: ${{ secrets.S3_BUCKET }}
		S3_ACCESS_KEY_ID: ${{ secrets.S3_ACCESS_KEY_ID }}
		S3_SECRET_ACCESS_KEY: ${{ secrets.S3_SECRET_ACCESS_KEY }}
		S3_REGION: ${{ secrets.S3_REGION }}
		S3_ENDPOINT: ${{ secrets.S3_ENDPOINT }}
		FILE: 'some-file-name.txt'
```

#### Configuration

Additional configuration for this command:

| Key    | Value                                           | Suggested Type | Required | Default |
| ------ | ----------------------------------------------- | -------------- | -------- | ------- |
| `FILE` | The file you want to check for the existence of | `env`          | Yes      | N/A     |

### `rm`

This command performs `aws s3 rm`.

#### `workflow.yml` Step Example

You can add the following as a step in one of your workflows:

```
- name: S3 rm
  uses: the-events-calendar/action-s3-utility@main
	env:
		COMMAND: rm
		S3_BUCKET: ${{ secrets.S3_BUCKET }}
		S3_ACCESS_KEY_ID: ${{ secrets.S3_ACCESS_KEY_ID }}
		S3_SECRET_ACCESS_KEY: ${{ secrets.S3_SECRET_ACCESS_KEY }}
		S3_REGION: ${{ secrets.S3_REGION }}
		S3_ENDPOINT: ${{ secrets.S3_ENDPOINT }}
		FILE: 'some-file-name.txt'
```

#### Configuration

Additional configuration for this command:

| Key    | Value                                           | Suggested Type | Required | Default |
| ------ | ----------------------------------------------- | -------------- | -------- | ------- |
| `FILE` | The file you want to check for the existence of | `env`          | Yes      | N/A     |

### `sync`

This command performs `aws s3 sync`.

#### `workflow.yml` Step Example

You can add the following as a step in one of your workflows:

```
- name: S3 sync
  uses: the-events-calendar/action-s3-utility@main
	env:
		COMMAND: sync
		S3_BUCKET: ${{ secrets.S3_BUCKET }}
		S3_ACCESS_KEY_ID: ${{ secrets.S3_ACCESS_KEY_ID }}
		S3_SECRET_ACCESS_KEY: ${{ secrets.S3_SECRET_ACCESS_KEY }}
		S3_REGION: ${{ secrets.S3_REGION }}
		S3_ENDPOINT: ${{ secrets.S3_ENDPOINT }}
		SOURCE_DIR: 'some-dir/'
```

#### Configuration

Additional configuration for this command:

| Key          | Value                                  | Suggested Type | Required | Default              |
| ------------ | -------------------------------------- | -------------- | -------- | -------------------- |
| `SOURCE_DIR` | The file or directory you wish to sync | `env`          | No       | `/` (root of bucket) |

### `cp`

This command performs `aws s3 cp`.

#### `workflow.yml` Step Example

You can add the following as a step in one of your workflows:

```
- name: S3 cp
  uses: the-events-calendar/action-s3-utility@main
	env:
		COMMAND: cp
		S3_BUCKET: ${{ secrets.S3_BUCKET }}
		S3_ACCESS_KEY_ID: ${{ secrets.S3_ACCESS_KEY_ID }}
		S3_SECRET_ACCESS_KEY: ${{ secrets.S3_SECRET_ACCESS_KEY }}
		S3_REGION: ${{ secrets.S3_REGION }}
		S3_ENDPOINT: ${{ secrets.S3_ENDPOINT }}
		FILE: 'some-file-name.txt'
		DESTINATION: 'some-dir/some-file-name.txt'
```

#### Configuration

Additional configuration for this command:

| Key           | Value                        | Suggested Type | Required | Default |
| ------------- | ---------------------------- | -------------- | -------- | ------- |
| `DESTINATION` | The destination file or dir. | `env`          | Yes      | N/A     |
