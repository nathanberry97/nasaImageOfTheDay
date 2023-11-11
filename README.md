# nasaImageOfTheDay

> This repo is intended to use the NASA api to fetch the Astronomy Picture
> of the Day and send it through sms.
> The App is ran on AWS through a container on ECS which is triggered once a
> at 8:00 AM

## Prerequisite

You will need to make the following accounts:

- [Nasa api signup](https://api.nasa.gov/)
- [Twilio SMS](https://www.twilio.com/en-us/messaging/channels/sms)

> Don't worry both of the above are free to signup for and use

## App

For the app you can set the following env variables through a .env file in the
base of `./app`.

Please add the following to this file:

```shell
NSAS_API_KEY=VALUE
TWILIO_SID=VALUE
TWILIO_AUTH_TOKEN=VALUE
TWILIO_NUMBER=VALUE
PERSONAL_NUMBER=VALUE
```

> **Note** please replace VALUE with your keys and numbers

Once completed you can then run the following commands to run it locally:

```shell
npm run build
npm run main
```

If you want to run the test files please use the following command:

```shell
npm run test
```

## Scripts

The following bash script:

- `./scripts/pushContainerBuild.sh`

Is intended to build and push the App in a container to you ECR repo.

To do this you will need to create the following repo in your AWS account:

- `nasa_apod`

Also you will need to have the AWS cli set up and following env set before running:

- `export ACCOUNT_NUM=value`
- `export REGION=value`

> **Note** please replace VALUE with your AWS account informaion

## Infrastructure

Now if you pushed the app to ECS you can use the provided Terraform files to
have the App run once a day at 8:00 AM.

First please update the backend in the provided file `./infra/providers.tf`,
once completed you'll need to set the following env variables:

- `TF_VAR_ECR_REPO_URL=account_num.dkr.ecr.region.amazonaws.com/nasa_apod:nasa_apod`
- `TF_VAR_VPC_SUBNETS='["subnet_id", "subnet_id", ...]'`

Once the env variables are set head over to the `./infra` repo and run the following
commands:

```shell
terraform init
terraform apply
```

Once completed you will have the infra structure deployed in you AWS account and
expect to receive a message once a day.

