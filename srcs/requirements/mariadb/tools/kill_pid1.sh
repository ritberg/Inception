asyncRun() {
    "$@" &
    pid="$!"
    trap "echo 'Stopping PID $pid'; kill -SIGTERM $pid" SIGINT SIGTERM

    while kill -0 $pid > /dev/null 2>&1; do
        wait
    done
}
asyncRun ./db_script.sh $@

#source: https://github.com/docker-library/mysql/issues/47, jeremyVignelles