class Env {
    def BRANCH_NAME = ""
    def BUILD_NUMBER = 1

    Env(branchName) {
        this.BRANCH_NAME = branchName
    }
}

def isAwsBranch(branchName) {
    (branchName =~ /(aws|.*-aws-.*)/).matches()
}

def env = new Env("feature--aws-blah")

setVersion env

def env2 = new Env("bugfix--aws-blah")

checkBranchName(env2.BRANCH_NAME)

setVersion env2

println replaceBranchTypePrefix(env.BRANCH_NAME, "")
println replaceBranchTypePrefix(env2.BRANCH_NAME, "")
println replaceBranchTypePrefix(env.BRANCH_NAME, "\$1/")
println replaceBranchTypePrefix(env2.BRANCH_NAME, "\$1/")

def replaceBranchTypePrefix(String branchName, String replacement) {
    branchName.replaceFirst("^([^-]+)--", replacement)
}

def setVersion(env) {
    def isFeatureBranch = !env.BRANCH_NAME.matches('(aws|develop)')
    def version = "3.0." + env.BUILD_NUMBER + (isFeatureBranch ? "-" + replaceBranchTypePrefix(env.BRANCH_NAME, "") : "")
    println "Setting Profile Version to $version"
}

def checkBranchName(branchName) {
    if (!branchName.matches("[a-zA-Z0-9-_]+"))
        throw new IllegalStateException("Branch name $branchName does not satisfy branch name rules")
}