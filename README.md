## TLDR
- Run `sh gen-perf-test.sh` to scaffold a basic directory structure to use `vegeta` cli.
- This script creates a `.perf-test` dir in the current directory
- .perf-test file structure:  
|-- targets.txt  
|-- payloads/  
|-- run.sh  

- targets.txt contain an example configuratio. See [here](https://github.com/tsenart/vegeta#http-format) for more info
- run.sh is the entry point to start attacking, eg:
  ```sh
  ./run.sh performance-test 1/5s 10s 0s
  ```
  will create a directory `performance-test`, send `1 request every 5s`, for `10s`, with a timeout set to `0s`
  ```sh
  ls performance-test
  performance-test
  ├── histogram.data
  ├── metrics.txt
  ├── plot.html
  ├── results.bin
  ├── settings.txt
  └── targets.txt
  ```
- see [here](https://github.com/tsenart/vegeta#report-command) for the types of vegeta output formats
  
