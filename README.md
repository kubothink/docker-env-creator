# Docker Environment Creation Script

This project provides a script to easily set up a new Docker environment.

## Setup Instructions

1. Create a project folder and initialize a Git repository:

   ```bash
   git clone https://github.com/kubothink/docker-env-creator.git ~/dev/docker-env-creator

2. Create the ~/sh directory (if it doesn't exist):

    ```bash
    mkdir -p ~/sh

3. Create a symbolic link:

    ```bash
    ln -s ~/dev/docker-env-creator/create_docker_env ~/sh/create_docker_env

4. Give the script execution permissions:

    ```bash
    chmod +x ~/dev/docker-env-creator/create_docker_env

5. Add the following line to `~/.zshrc` to set up the PATH:

    ```bash
    export PATH="$HOME/sh:$PATH"

6. Apply the settings:

    ```bash
    source ~/.zshrc

## Usage
Once setup is complete, you can create a Docker environment with the following command:

    ```bash
    create_docker_env project_name


----

# Docker環境作成スクリプト

このスクリプトは、新しいプロジェクトのためのDocker環境を簡単に構築するためのものです。

## セットアップ方法

1. このリポジトリをクローンします：

   ```bash
   git clone https://github.com/kubothink/docker-env-creator.git ~/dev/docker-env-creator

2. ~/sh ディレクトリが存在することを確認します（なければ作成します）：

    ```bash
    mkdir -p ~/sh

3. スクリプトへのシンボリックリンクを作成します：

    ```bash
    ln -s ~/dev/docker-env-creator/create_docker_env ~/sh/create_docker_env

4. スクリプトに実行権限を与えます：

    ```bash
    chmod +x ~/dev/docker-env-creator/create_docker_env

5. ~/.zshrcファイルを編集して、~/shをPATHに追加します。ファイルの最後に以下の行を追加してください：

    ```bash
    export PATH="$HOME/sh:$PATH"

6. 変更を反映させるため、新しいターミナルウィンドウを開くか、以下のコマンドを実行します：

    ```bash
    source ~/.zshrc

## 使用方法
セットアップが完了したら、以下のようにスクリプトを使用できます：
    ```bash
    create_docker_env プロジェクト名