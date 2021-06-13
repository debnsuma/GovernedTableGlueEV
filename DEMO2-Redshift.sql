
--Create an external schema to access the Elastic Views view
--[IAM ROLE] rs_cluster_ev_role: Allows Amazon Redshift cluster to call Elastic Views operations.
CREATE EXTERNAL SCHEMA ev_schema
FROM ELASTIC_VIEWS
IAM_ROLE 'arn:aws:iam::507922848584:role/rs_cluster_ev_role';

--Copy the ARN of "favoritemovies-view" and then Materialized View into Amazon Redshift
CREATE MATERIALIZED VIEW favoritemovies_mv AS
SELECT release_year, title
FROM ev_schema."ARN of favoritemovies-view";

--Query Amazon Redshift
--(Before you query a materialized view for the first time, you need to refresh it to get data from the source data store into the materialized view)

REFRESH MATERIALIZED VIEW favoritemovies_mv;

SELECT * FROM favoritemovies_mv;

--Now lets update the source, DynamoDB table (Lets go back to our Jupyter-notebook)

--Query Amazon Redshift

REFRESH MATERIALIZED VIEW favoritemovies_mv;

SELECT * FROM favoritemovies_mv;












--Clean up--

DROP MATERIALIZED VIEW favoritemovies_mv;

DROP SCHEMA ev_schema

-- From EV UI
--- Deactivate View
--- Delete View
--- Deactivate Table(source)
--- Delete Table(source)

-- From DynamoDB UI
--- Delete the table


