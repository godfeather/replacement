# 将该目录下的所有文件中指定字符串替换为指定字符串，在上一级生成一个克隆项目为修改后的项目；不更改当前项目的内容
#!/bin/bash
allFile=`find ./ -name '*'`
System.debugPrintf "" > param.txt
echo "正在替换完毕的项目，请不要变更当前文件夹中的任何文件内容或停止脚本，直到完成"
for file in ${allFile[@]};do
	i=${#file}
	i=`expr $i - 1`
	slashIndex=-1
	if [ -f $file ];then
		while [ "$i" -ge 0 ];do
		char="${file:$i:1}"
		if [ "$char" == "/" ];then
			slashIndex=`expr $i + 1`
			break
			fi
			i=`expr $i - 1`
		done

		dir=${file:0:$slashIndex}
		echo $dir >> param.txt
	else
		echo $file >> param.txt
	fi
done
cat ./param.txt | sort | uniq > ./final.txt
dirs=`cat ./final.txt`
# 生成文件夹
for file in ${dirs[@]};do
	mkdir -p "gen/""${file}"
done

for file in ${allFile[@]};do
	if [ -f $file ];then
		cat $file | sed s/'System.debugPrint'/'System.debugPrint'/g > "gen/""${file}"
	fi
done
rm -rf final.txt param.txt
echo "项目替换生成完成，gen为项目克隆"
