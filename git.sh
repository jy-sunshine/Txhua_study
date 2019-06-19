# git shell

set -e
set -u

# 定位到当前目录
base_path=$(
	cd "$(dirname "$0")"
	pwd
)

cd "$base_path"
message=""
origin=""
while getopts 'm:r:' OPT; do
	case $OPT in
	m)
		message="$OPTARG"
		;;
	r)
		origin="$OPTARG"
		;;
	?)
		echo "Usage: $(basename $0) [OPTIONS] [database]"
		echo " -m message."
		echo " -r origin."
		exit
		;;
	esac
done
shift $(($OPTIND - 1))

if [ "${message}" == "" ];then
	echo "message is null"
	exit;
fi

if [ "${origin}" == "" ];then
	echo "origin is null";
	exit;
fi

# 拉取最新的文件
git pull 

# 跟踪所有的文件包括新添加的文件
git add .

# 提交文件
git commit -m "${message}"

# 提交文件到远程仓库
git push -u "${origin}" master

