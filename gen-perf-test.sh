#! /bin/bash
set +ex
dirname=".perf-test"
if [[ -d $dirname ]]; then
  echo "$dirname exists in current directory $(pwd)"
  exit 1
fi

# check if vegeta cli
vegeta=$(which vegeta)
if [[ -z $vegeta ]]; then
  echo "please install vegeta cli - https://github.com/tsenart/vegeta"
  exit 1
fi

mkdir -p $dirname
cd $dirname
mkdir payloads
cat << EOF > targets.txt
# Example targets.txt
# POST http://localhost:80/test
# Content-Type: application/json
# Authorization: Bearer <some-token>
# @./payloads/some_payload
EOF

cat << 'EOF' > run.sh
set -xe
path=$1
def_rate=5
def_duration=60s
def_timeout=0s
RATE="${2:-$def_rate}"
DURATION="${3:-$def_duration}"
TIMEOUT="${4:-$def_timeout}"
res_path=results.bin
mkdir -p $path
vegeta attack -rate=$RATE -duration=$DURATION -timeout=$TIMEOUT -targets=targets.txt > $path/$res_path
cd $path
vegeta report -type='hist[0,1s,2s,3s]' $res_path > histogram.data
vegeta report -type='text' $res_path > metrics.txt
cat $res_path | vegeta plot > plot.html
cp ../targets.txt targets.txt
cat << ESETTING > settings.txt
rate=$RATE
duration=$DURATION
timeout=$TIMEOUT
ESETTING
echo "Results stored in $path"
EOF
chmod 744 run.sh

echo "Created perf-test scaffold $dirname, $(ls .)"
