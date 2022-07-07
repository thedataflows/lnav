#! /bin/bash

export YES_COLOR=1

# XXX sqlite reports different results for the "detail" column, so we
# have to rewrite it.
run_cap_test ${lnav_test} -n \
    -c ";EXPLAIN QUERY PLAN SELECT * FROM access_log WHERE log_path GLOB '*/logfile_access_log.*'" \
    -c ";SELECT \$id, \$parent, \$notused, replace(\$detail, 'SCAN TABLE', 'SCAN')" \
    ${test_dir}/logfile_access_log.*

run_cap_test ${lnav_test} -n \
    -c ";SELECT *,log_unique_path FROM access_log WHERE log_path GLOB '*/logfile_access_log.*'" \
    ${test_dir}/logfile_access_log.*
