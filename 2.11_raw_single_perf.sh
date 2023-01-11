#!/bin/bash

BMT_NO=$0
dir=`pwd -P`
time=`date +"%y%m%d_%H%M"`
LOGDIR=/$dir/log
LOGFILE=$LOGDIR"/"$BMT_NO".out"

START_TM1=`date "+%Y-%m-%d %H:%M:%S"`
echo "$0: START TIME : " $START_TM1

###### query start
psql -U udba -d skon -e > $LOGFILE 2>&1 <<-!

SELECT
        data.processid,
        data.stepseq,
        data.root_nm,
        data.leaf_nm,
        info.eqp_nm,
        info.unit_nm,
        info.param_nm        
FROM equipment.eq_data_raw as data,
equipment.param_info info
WHERE 1 = 1
        AND data.eqp_cd = info.eqp_cd
        AND data.unit_cd = info.unit_cd
        AND data.param_cd = info.param_cd
        and data.param_cd in (1055502,2147982,5022252,7746596,988663,9169695,1881539,5324253,5953433,4198721,2388875,4189202,8419015,9201085,6258066,4635752,6580923,8697107,1744005,8094790,2884083,9528941,2427930,1480947,7967384,5784353,7481809,622640,3757794,6261983,9498694,4813296,8409966,4520946,2559892,9398628,3690641,4441431,4722881,9644074,8640151,7111757,3833275,7059166,6312842,91342,1694918,2893764,8788448,3438923,988554,1672532,2967864,3416484,3153479,935249,9200837,635288,1557889,2958632,6897271,1056582,7771928,5307237,5577528,331819,4705865,9268168,4773250,9428746,8912242,3413401,6540503,2745517,472568,2853345,2836859,2167486,5747109,1625308,5606409,6735663,3297839,8574273,152147,6451318,9509522,9352985,7086606,1067411,2311616,3983877,2123993,83544,9291113,7701521,415363,3996979,6969689,5188613,3425725,5881931,8602014,9966228,8627449,9074582,2819573,1464308,1242067,8566682,3089615,6848476,5302345,6387455,5422750,5454492,2838773,4932272,4807477,9925378,5999683,7119093,3909255,8123676,7202637,3200369,5825196,7618000,7197347,2794886,2806613,623072,8676817,1408628,589300,7304266,483209,3408873,8768573,1725277,1975555,1858189,8573753,7277899,8245643,3996503,2732391,1084416,8928775,7539868,1009794,4928458,4658962,4919050,3052133,1861599,8119418,8877330,9479599,5316765,1672215,2286213,5939837,349032,3694840,6529138,7653298,4178050,9938011,6421871,5903326,1913565,8280060,4477079,9191464,6525703,8473582,1923856,7610119,7402357,9463724,8619914,2330815,4122686,3538963,5382948,5984285,1658382,4260278,5463884,6975147,5932493,7750097,2914984,6281525,1444937,9444122,3934823,5622987,9382133,356694,1526313,1295698,8636754,6003392,487162,5162457,4476975,2411018,2772577,1879332,1874742,1392491,4210147,5997428,4931454,9593095,1981713,6589835,3853373,7445597,3564982,9785867,5195694,6479967,6067392,6640631,5924088,2215,2263618,5306221,358909,3789930,6601919,8995662,9793323,7089081,4158120,4270297,9500099,6930696,6149629,1374841,8323187,359776,7372269,3254641,9952872,9353982,9844476,3806245,6799579,3409459,3592112,1995273,9889425,9659504,8635904,5813514,9661718,899521,1119735,20627,4689452,7721653,9016289,4482774,4810734,3174409,8753072,4310833,105106,4902701,5685674,8428293,5262477,3057943,1682933,5215349,2411925,1527410,9021594,9211505,4936869,2613705,1206778,4826294,2273209,9842682,639807,1934927,742203,1759542,1955554,5431655,9481195,971843,9914429,4291929,4146252)
	AND data.act_time >= '2022-01-01 00:00:00' and act_time < '2022-02-28 00:00:00'
;

!
###### query end

END_TM1=`date "+%Y-%m-%d %H:%M:%S"`

SHMS=`echo $START_TM1 | awk '{print $2}'`
EHMS=`echo $END_TM1   | awk '{print $2}'`

SEC1=`date +%s -d ${SHMS}`
SEC2=`date +%s -d ${EHMS}`
DIFFSEC=`expr ${SEC2} - ${SEC1}`

echo "Result:""|"$BMT_NO"|"$START_TM1"|"$END_TM1"|"$DIFFSEC  >> $LOGFILE
echo "$0: End TIME : "$END_TM1

echo -e "\033[43;31m$0: Total Elapsed TIME : "$DIFFSEC "sec\033[0m"
