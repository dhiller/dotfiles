class Env {
    def JOB_NAME = "testjob"
    def BUILD_NUMBER = 42
    def BUILD_URL = "http://someserver"
    def credentials = 'myCredentials'
}


def post_build_status_to_slack(result, credentials_id, slack_channel) {
    def env = new Env()
    Map<String, String> statusResult = for_status(result)
    message = "${env.JOB_NAME} build #${env.BUILD_NUMBER}\n${statusResult['description']}\n${env.BUILD_URL}"
    slackSend channel: slack_channel, color: statusResult['color'], message: message, teamDomain: 'intuit-teams', tokenCredentialId: credentials_id
}

/**
 * Sets build status for a commit id using the github api.
 *
 * @param result usually the <code>currentBuild.result</code> but can be any String
 *        using set (null, 'SUCCESS', 'UNSTABLE') resulting in success for null or SUCCESS or UNSTABLE,
 *        everything else will result in success
 * @param org the github organization id
 * @param repo the repository id
 * @param target_url the target url that should be served when clicking on the
 *        status in GitHub, should usually be env.BUILD_URL
 * @param credentials_id the id of the Github api token stored in Jenkins credentials
 *        as a Secret text type credentials item
 * @see <a href="https://help.github.com/articles/creating-a-personal-access-token-for-the-command-line/">Creating a personal access token</a>
 * @see <a href=""></a>
 */
def set_build_status(result, org, repo, target_url, credentials_id) {
    Map<String, String> statusResult = for_status(result)
    commit_id = fetch_git_commit_id()
    withCredentials([[$class: 'StringBinding', credentialsId: credentials_id, variable: 'credentials']]) {
        sh """curl --insecure -L -f -s -H"Authorization: token ${env.credentials}" -XPOST 'https://github.intuit.com/api/v3/repos/$org/$repo/statuses/$commit_id' -d '{
          "state": "${statusResult['state']}",
          "target_url": "$target_url",
          "description": "${statusResult['description']}",
          "context": "continuous-integration/jenkins"
        }'"""
    }
}

/**
 * @return the current git commit id
 */
def fetch_git_commit_id() {
    sh "git rev-parse HEAD > .git/commit-id"
    readFile('.git/commit-id').replaceAll("\\r?\\n", '')
}

Map<String, String> for_status(String buildResult) {
    buildResult = buildResult ?: 'SUCCESS'
    switch (buildResult) {
        case 'SUCCESS':
            return [
                    color: 'good',
                    state: 'success',
                    description: 'The build succeeded'
            ]
        case 'UNSTABLE':
            return [
                    color: 'warning',
                    state: 'failure',
                    description: 'The build had test errors'
            ]
        default:
            return [
                    color: 'danger',
                    state: 'failure',
                    description: 'The build failed'
            ]
    }
}

def sh(String arg) {
    println "sh $arg"
}

def slackSend(Map<String,String> values) {
    println "slackSend $values"
}

post_build_status_to_slack('SUCCESS', '37', '42')

