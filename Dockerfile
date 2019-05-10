FROM quay.io/giantswarm/fluentd-kubernetes-daemonset:v1.3-debian-cloudwatch

RUN buildDeps="make gcc g++ libc-dev zlib1g-dev ruby-dev git" \
 && apt-get update \
 && apt-get install -y --no-install-recommends $buildDeps zlib1g-dev ruby-dev \
 && gem install fluent-plugin-record-modifier \
 && gem install fluent-plugin-array-spin \
 && gem install fluent-plugin-rewrite-tag-filter \
 && gem install fluent-plugin-azurestorage \
 && gem sources --clear-all \
 && SUDO_FORCE_REMOVE=yes \
    apt-get purge -y --auto-remove \
                  -o APT::AutoRemove::RecommendsImportant=false \
                  $buildDeps \
 && rm -rf /var/lib/apt/lists/* \
           /home/fluent/.gem/ruby/2.6.0/cache/*.gem