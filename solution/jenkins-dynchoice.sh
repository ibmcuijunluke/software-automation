def gettags = ("git ls-remote -h git@gitlab.brandwisdom.cn:cloudwisdom/cw-hms-web.git").execute()
gettags.text.readLines().collect { it.split()[1].replaceAll('refs/heads/', '')  }.unique()

refs/remotes/origin/${BranchNameChoice}
BranchNameChoice

def gettags = ("git ls-remote -h git@gitlab.brandwisdom.cn:cloudwisdom/cw-hms-source.git").execute()
gettags.text.readLines().collect { it.split()[1].replaceAll('refs/heads/', '')  }.unique()

BranchNameChoice ${BranchNameChoice}
refs/remotes/origin/${BranchNameChoice}