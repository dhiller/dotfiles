class Env {
    def BRANCH_NAME = ""
    def BUILD_NUMBER = 1

    Env(branchName) {
        this.BRANCH_NAME = branchName
    }
}


println trigger_branch_name(new Env("feature--aws-blah"))
println trigger_branch_name(new Env("bugfix--aws-blah"))
println trigger_branch_name(new Env("aws"))
println trigger_branch_name(new Env("develop"))

def replaceBranchTypePrefix(String branchName, String replacement) {
    branchName.replaceFirst("^([^-]+)--", replacement)
}


def trigger_branch_name(Env env) {
    print "${env.BRANCH_NAME} -> "
    env.BRANCH_NAME.equals("aws") ? "develop" : replaceBranchTypePrefix(env.BRANCH_NAME, "\$1/")
}