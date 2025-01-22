insert into data_source (org_id, version, type, name, access, url,
  password, "user", basic_auth, is_default, json_data, created, updated
  ) values (
  1, 5, 'grafana-postgresql-datasource', 'pg-metrics2', 'proxy', 'localhost:5432',
  'pgwatch2admin', 'pgwatch2', 'f', 't', '{"connMaxLifetime":14400,"database":"pgwatch2_metrics","maxIdleConns":20,"maxIdleConnsAuto":true,"maxOpenConns":20,"postgresVersion":1700,"sslmode":"disable","timescaledb":true}', now(), now()
  );
