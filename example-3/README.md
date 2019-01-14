# Example 3
Simple 3 node CockroachDB cluster fronted by Nginx acting as load balancer


-duration 20m -tolerate-errors -concurrency 1 -max-rate 1 'postgresql://root@lb:5432?sslmode=disable'

run ycsb --workload B --concurrency 1 --max-rate 100 --request-distribution uniform 'postgresql://root@lb:5432?sslmode=disable&application_name=ycsb'