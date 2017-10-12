#! bin/sh/

#部分文件，添加git index忽略
function extra_ignore
{
	'git update-index --assume-unchanged Example/Pods'

	'git update-index --assume-unchanged Example/Podfile.lock'
}

'extra_ignore'