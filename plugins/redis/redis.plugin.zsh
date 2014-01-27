# Aliases to stop, start and restart Postgres
# Paths noted below are for Postgress installed via Homebrew on OSX

# Redis management functions: redis_start, redis_stop, redis_list,
# redis_generate <name>, redis_remove <name>

function redis_start {
  redis_stop
  for file in `ls /usr/local/etc/redis-server-*.conf`; do
    redis-server $file
  done
}

function redis_stop {
  for file in `ls /usr/local/etc/redis-server-*.conf`; do
    pidfile=`grep pidfile $file | awk '{print $2}'`
    if [ -f $pidfile ]; then
      kill `cat $pidfile`
    fi
  done
}

function redis_list {
  ls /usr/local/etc/redis-server-*.conf
}

function redis_generate {
  if [ -z "$1" ]; then
    echo "You need to specify an app name, eg. redgen decafsucks"
    return 1
  fi

  app=$1
  config="/usr/local/etc/redis-server-${app}.conf"

  redis_stop

  echo "include /usr/local/etc/redis-common.conf"     > $config
  echo "pidfile /usr/local/var/run/redis-${app}.pid"  >> $config
  echo "unixsocket /tmp/redis-${app}.sock"            >> $config
  echo "dbfilename dump-${app}.rdb"                   >> $config

  redis_start
}

function redis_remove {
  if [ -z "$1" ]; then
    echo "You need to specify an app name, eg. redrm decafsucks"
    return 1
  fi

  redis_stop
  rm -f "/usr/local/etc/redis-server-${app}.conf"
  redis_start
}

