with qs as (
  select name, setting from pg_settings
)
select /* pgwatch2_generated */
  (extract(epoch from now()) * 1e9)::int8 as epoch_ns,
  current_setting('server_version') as server_version,
  current_setting('server_version_num')::int8 as server_version_num,
  (regexp_matches(regexp_replace(current_setting('server_version'), '(beta|devel).*', '', 'g'), E'\\d+'))[1]::float8 as major_version,
  current_setting('block_size')::int as block_size,
  current_setting('max_connections')::int as max_connections,
  current_setting('hot_standby') as hot_standby,
  (select setting from qs where name = 'hot_standby_feedback') as hot_standby_feedback,
  current_setting('fsync') as fsync,
  current_setting('full_page_writes') as full_page_writes,
  current_setting('synchronous_commit') as synchronous_commit,
  (select setting from qs where name = 'wal_compression') as wal_compression,
  (select setting from qs where name = 'wal_log_hints') as wal_log_hints,
  (select setting from qs where name = 'synchronous_standby_names') as synchronous_standby_names,
  current_setting('shared_buffers') as shared_buffers,
  current_setting('work_mem') as work_mem,
  current_setting('maintenance_work_mem') as maintenance_work_mem,
  current_setting('effective_cache_size') as effective_cache_size,
  (select setting::int8 from qs where name = 'default_statistics_target') as default_statistics_target,
  (select setting::float8 from qs where name = 'random_page_cost') as random_page_cost,
  pg_size_pretty(((select setting::int8 from qs where name = 'min_wal_size') * 1024^2)::int8) as min_wal_size,
  pg_size_pretty(((select setting::int8 from qs where name = 'max_wal_size') * 1024^2)::int8) as max_wal_size,
  (select setting from qs where name = 'checkpoint_segments') as checkpoint_segments,
  current_setting('checkpoint_timeout') as checkpoint_timeout,
  current_setting('checkpoint_completion_target') as checkpoint_completion_target,
  (select setting::int8 from qs where name = 'max_worker_processes') as max_worker_processes,
  (select setting::int8 from qs where name = 'max_parallel_workers') as max_parallel_workers,
  (select setting::int8 from qs where name = 'max_parallel_workers_per_gather') as max_parallel_workers_per_gather,
  (select case when setting = 'on' then 1 else 0 end from qs where name = 'jit') as jit,
  (select case when setting = 'on' then 1 else 0 end from qs where name = 'ssl') as ssl,
  current_setting('statement_timeout') as statement_timeout,
  current_setting('deadlock_timeout') as deadlock_timeout,
  (select setting from qs where name = 'data_checksums') as data_checksums,
  (select setting::int8 from qs where name = 'max_connections') as max_connections,
  (select setting::int8 from qs where name = 'max_wal_senders') as max_wal_senders,
  (select setting::int8 from qs where name = 'max_replication_slots') as max_replication_slots,
  (select setting::int8 from qs where name = 'max_prepared_transactions') as max_prepared_transactions,
  (select setting::int8 from qs where name = 'lock_timeout') || ' (ms)' as lock_timeout,
  (select setting from qs where name = 'archive_mode') as archive_mode,
  (select setting from qs where name = 'archive_command') as archive_command,
  current_setting('archive_timeout') as archive_timeout,
  (select setting from qs where name = 'shared_preload_libraries') as shared_preload_libraries,
  (select setting from qs where name = 'listen_addresses') as listen_addresses,
  (select setting from qs where name = 'ssl') as ssl,
  (select setting from qs where name = 'autovacuum') as autovacuum,
  (select setting::int8 from qs where name = 'autovacuum_max_workers') as autovacuum_max_workers,
  (select setting::float8 from qs where name = 'autovacuum_vacuum_scale_factor') as autovacuum_vacuum_scale_factor,
  (select setting::float8 from qs where name = 'autovacuum_vacuum_threshold') as autovacuum_vacuum_threshold,
  (select setting::float8 from qs where name = 'autovacuum_analyze_scale_factor') as autovacuum_analyze_scale_factor,
  (select setting::float8 from qs where name = 'autovacuum_analyze_threshold') as autovacuum_analyze_scale_factor
;
