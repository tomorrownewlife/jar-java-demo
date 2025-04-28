def get_branch() {
    def branch = sh (
            returnStdout: true,
            script: '''
            br=`git name-rev --name-only HEAD |awk -F '/' '{print $3}'`
            if [[ $br =~ dev ]] || [[ $br =~ bugfix ]] || [[ $br =~ feature ]];then
                 BRANCH="dev"
             elif [[ $br =~ release ]]  ||  [[ $br =~ hotfix ]];then
                 BRANCH="test"
             elif [[ $br = master ]];then
                 BRANCH="prod"
             fi
             echo -n $BRANCH
          ''')
    return branch      
}
pipeline {
    agent any
    environment {
         COMMIT_DATE = sh(returnStdout: true, script: "git log --pretty=format:%ad --date=format:'%Y%m%d%H%M' ${GIT_COMMIT} -1")
         MAVEN_HOME = "/data/apache-maven-3.6.3/bin/mvn"
		 NODE_HOME = "/root/.nvm/versions/node/v20.17.0/bin"
         //定义模块名，要根据项目进行修改、只需要修改app_id 名称
         APP_ID = "XT-dev-docker-auto-deploy-war_demo-service"
         conf_host = "ops.jvtdtest.top"
         //分支名称 开发环境是dev  测试环境是release   生产环境是prod
         BRANCH = get_branch()
         //sh "echo brach: $BRANCH"
    }

    stages {

        stage('Build') {
            steps {
                echo 'Building..'

            }
        }

        // 打包镜像
        stage('打包镜像') {
            steps {
                echo "********************************************=打包镜像"
                script {
                    build_tag = sh(returnStdout: true, script: 'git rev-parse --short HEAD').trim()
                }
                sh "echo $build_tag "
            }

            post {
                failure {
                    sendIntegrationResult("false", "打包镜像失败")
                    error("打包镜像失败")
                }
            }
        }

        stage('推送镜像') {

            steps {

              echo '推送镜像'

            }

            post {
                failure {
                    sendIntegrationResult("false", "推送镜像失败")
                    error("推送镜像失败")
                }
            }
        }

        stage('Test') {
            steps {
                echo 'Testing..'
            }
        }
        stage('Deploy') {
            steps {
                echo 'Deploying....'
            }
        }
    }
}
