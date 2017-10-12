#! bin/sh/

pathPods='./Example/Pods'
pathPodFile='./Example/Podfile.lock'

function pod_install
{
	rm -rf $pathPods

	rm -rf $Podfile 

	cd ./Example/

	(pod install)
}

#部分文件，添加git index忽略
function extra_ignore
{
	git update-index --assume-unchanged ./Example/Pods

	git update-index --assume-unchanged ./Example/Podfile.lock
}

'pod_install'

'extra_ignore'