#!/bin/bash
set -o errexit -o pipefail -o nounset

mypath=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

imagetag=tmpsshservertest
stdparams=""
additionalparams=""

function build {
	docker build ${stdparams} -t ${imagetag} ${mypath}
}

function run {
	docker run -it --rm ${stdparams} \
	-v ${mypath}/testauthorized_keys:/workdir/authorized_keys:ro \
	-p 23:22 \
	-e "LIFETIME=1h" \
	--name ${imagetag} ${additionalparams} ${imagetag} 
}


case $1 in
	b)
	echo "build"
	build
	;;
	r)
	echo "run"
	run
	;;
	br)
	build && run
	;;
	bash)
	additionalparams="--entrypoint /bin/bash --workdir /test"
	run
	;;
	*)
	echo "unbekanntes Kommando: $1"
	;;
esac



