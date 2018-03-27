## このリポジトリについて

Terraform使って、AWSの環境構築するサンプル


## 目指す構成

以下を目指して構成を作っていく

- 参考にしてる情報を元にしてVPC使って、public/privateなセグメントが切られてる
- 踏み台となるサーバー経由でアプリケーション・サーバーにSSHできる

## 参考にしてる情報

[お金をかけずに、TerraformでAWSのVPC環境を準備する](https://qiita.com/CkReal/items/1dbbc78888e157a80668)
[TerraformでVPCを管理するmoduleを作る](https://www.sambaiz.net/article/121/)



## 利用にあたって

[Shared Credentials file](https://www.terraform.io/docs/providers/aws/#shared-credentials-file)の仕組みを使ってAWSリソースを操作する想定で作ってます。

具体的には

```
provider "aws" {
  profile = "private-aws"
  region = "ap-northeast-1"
}
```

という記述があり、private-awsというprofileを利用する想定になってるので


```sh
aws configure --profile private-aws
```

として、defaultのprofileとは別のprofileを設定します。


上記実行すると
~/.aws/credentials
は以下のような記述になってるかと思います。

```
[default]
aws_access_key_id = xxxx
aws_secret_access_key = xxx
[private-aws]
aws_access_key_id = xxxx
aws_secret_access_key = xxxx
```
