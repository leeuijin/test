#!/bin/bash
psql -U udba -d skon -e <<-!
\d equipment.eq_data_raw;
\d equipment.eq_data_raw_with_array;
select * from equipment.eq_data_raw where eqp_cd = 0 and unit_cd = 0 and param_cd = 85 limit 5;
\x
select * from equipment.eq_data_raw_with_array where eqp_cd = 0 and unit_cd = 0 and param_cd = 85 limit 1;
\x
select line,eqp_cd,unit_cd,param_cd,unnest(processid),unnest(stepseq),unnest(root_nm),unnest(leaf_nm),unnest(act_time),unnest(param_value) from equipment.eq_data_raw_with_array where eqp_cd = 0 and unit_cd = 0 and param_cd = 85 limit 5;; 
!

