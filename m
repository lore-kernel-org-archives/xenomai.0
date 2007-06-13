Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 13 Jun 2007 14:10:34 +0200
Message-ID: <403B28AE6257B548B66BB88414AC78330174BC4F@STEGOSAURE.adetel.com>
From: "BOUIN Alexandre" <abouin@domain.hid>
Subject: Re: [Xenomai-core] [Adeos-main] New I-pipe patch for ARM needs
	testing.
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org, adeos-main@gna.org

Same tests but for AT91SAM9260-EK board :=20
 - one under DD load, latency set to 45=B5s
 - another one under Calibrator load, latency set to 35=B5s
 - and the last under Test_switch load, latency set to 45=B5s
Xeno-test traces are available and the end of this mail.

We used kernel 2.6.20.13, Xenomai snapshot from 08/06/2007, =
adeos-ipipe-2.6.20-arm-1.7-03.patch included.

Latencies are better than previous ones. Preemt seems to work.

Latencies on AT91SAM9263-EK are coming soon.

Here are the results :=20

[DD load]
RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat =
worst
RTD|      17.396|      28.994|      44.458|       0|       3.865|      =
82.152
RTD|       8.054|      29.317|      70.554|       0|       3.865|      =
82.152
RTD|       9.987|      28.994|      41.237|       0|       3.865|      =
82.152
RTD|       7.087|      28.994|      41.237|       0|       3.865|      =
82.152
RTD|       7.731|      28.994|      42.203|       0|       3.865|      =
82.152
RTD|       9.664|      28.994|      41.881|       0|       3.865|      =
82.152
RTD|       9.664|      28.994|      41.237|       0|       3.865|      =
82.152
RTD|       9.342|      28.994|      42.203|       0|       3.865|      =
82.152
RTD|       9.664|      28.994|      42.525|       0|       3.865|      =
82.152
RTD|      17.074|      28.994|      41.881|       0|       3.865|      =
82.152
RTD|      10.309|      28.994|      41.559|       0|       3.865|      =
82.152
RTD|       7.731|      28.994|      42.203|       0|       3.865|      =
82.152
RTD|      16.752|      28.994|      41.881|       0|       3.865|      =
82.152
RTD|      10.309|      28.994|      41.881|       0|       3.865|      =
82.152
RTD|       9.020|      28.994|      41.237|       0|       3.865|      =
82.152
RTD|      12.242|      28.994|      41.881|       0|       3.865|      =
82.152
RTD|       9.664|      28.994|      42.203|       0|       3.865|      =
82.152
RTD|      14.175|      28.994|      41.881|       0|       3.865|      =
82.152
RTD|       9.342|      28.994|      40.914|       0|       3.865|      =
82.152
RTD|       8.376|      28.994|      41.881|       0|       3.865|      =
82.152
RTD|      16.752|      28.994|      41.237|       0|       3.865|      =
82.152
RTT|  17:54:52  (periodic user-mode task, 500 us period, priority 99)
RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat =
worst
RTD|       9.020|      28.994|      41.881|       0|       3.865|      =
82.152
RTD|       7.409|      29.317|      51.868|       0|       3.865|      =
82.152
RTD|       9.342|      28.994|      42.847|       0|       3.865|      =
82.152
RTD|      18.041|      28.994|      44.458|       0|       3.865|      =
82.152
RTD|       9.020|      28.994|      41.881|       0|       3.865|      =
82.152
RTD|       7.409|      28.994|      41.881|       0|       3.865|      =
82.152
RTD|       9.342|      28.994|      41.237|       0|       3.865|      =
82.152
RTD|       9.342|      28.994|      42.203|       0|       3.865|      =
82.152
RTD|       7.731|      28.994|      42.203|       0|       3.865|      =
82.152
RTD|       8.054|      28.994|      41.237|       0|       3.865|      =
82.152
RTD|       7.087|      28.994|      41.237|       0|       3.865|      =
82.152
RTD|       9.342|      28.994|      42.203|       0|       3.865|      =
82.152
RTD|      10.631|      28.994|      42.847|       0|       3.865|      =
82.152
RTD|       9.664|      28.994|      41.559|       0|       3.865|      =
82.152
RTD|      10.309|      28.994|      41.559|       0|       3.865|      =
82.152
RTD|       9.020|      28.994|      41.559|       0|       3.865|      =
82.152
---|--param|----range-|--samples
HSD|    min|   3 -  4 |        1
HSD|    min|   4 -  5 |       44
HSD|    min|   5 -  6 |      302
HSD|    min|   6 -  7 |     1536
HSD|    min|   7 -  8 |     5406
HSD|    min|   8 -  9 |    10087
HSD|    min|   9 - 10 |    16687
HSD|    min|  10 - 11 |     8271
HSD|    min|  11 - 12 |     4178
HSD|    min|  12 - 13 |     2722
HSD|    min|  13 - 14 |     2357
HSD|    min|  14 - 15 |     2175
HSD|    min|  15 - 16 |     2151
HSD|    min|  16 - 17 |     2689
HSD|    min|  17 - 18 |     3027
HSD|    min|  18 - 19 |     2381
HSD|    min|  19 - 20 |      487
HSD|    min|  20 - 21 |        5
HSD|    min|  21 - 22 |        1
---|--param|----range-|--samples
HSD|    avg|   3 -  4 |        1
HSD|    avg|   4 -  5 |       44
HSD|    avg|   5 -  6 |      302
HSD|    avg|   6 -  7 |     1536
HSD|    avg|   7 -  8 |     5407
HSD|    avg|   8 -  9 |    10088
HSD|    avg|   9 - 10 |    16693
HSD|    avg|  10 - 11 |     8277
HSD|    avg|  11 - 12 |     4183
HSD|    avg|  12 - 13 |     2729
HSD|    avg|  13 - 14 |     2359
HSD|    avg|  14 - 15 |     2178
HSD|    avg|  15 - 16 |     2254
HSD|    avg|  16 - 17 |     4155
HSD|    avg|  17 - 18 |     7020
HSD|    avg|  18 - 19 |    28118
HSD|    avg|  19 - 20 |    32524
HSD|    avg|  20 - 21 |    16131
HSD|    avg|  21 - 22 |   252228
HSD|    avg|  22 - 23 |  1742479
HSD|    avg|  23 - 24 |  2998000
HSD|    avg|  24 - 25 |  1232132
HSD|    avg|  25 - 26 |   139783
HSD|    avg|  26 - 27 |    10564
HSD|    avg|  27 - 28 |   728365
HSD|    avg|  28 - 29 | 40599026
HSD|    avg|  29 - 30 | 62750081
HSD|    avg|  30 - 31 | 16563390
HSD|    avg|  31 - 32 |   587430
HSD|    avg|  32 - 33 |    98465
HSD|    avg|  33 - 34 |    32424
HSD|    avg|  34 - 35 |    13535
HSD|    avg|  35 - 36 |    27948
HSD|    avg|  36 - 37 |    36278
HSD|    avg|  37 - 38 |    14008
HSD|    avg|  38 - 39 |    20818
HSD|    avg|  39 - 40 |   255421
HSD|    avg|  40 - 41 |   505991
HSD|    avg|  41 - 42 |   205472
HSD|    avg|  42 - 43 |    36348
HSD|    avg|  43 - 44 |     6174
HSD|    avg|  44 - 45 |     4273
HSD|    avg|  45 - 46 |     2633
HSD|    avg|  46 - 47 |     1393
HSD|    avg|  47 - 48 |      907
HSD|    avg|  48 - 49 |      930
HSD|    avg|  49 - 50 |      364
HSD|    avg|  50 - 51 |      227
HSD|    avg|  51 - 52 |      136
HSD|    avg|  52 - 53 |      105
HSD|    avg|  53 - 54 |       80
HSD|    avg|  54 - 55 |       81
HSD|    avg|  55 - 56 |       97
HSD|    avg|  56 - 57 |       81
HSD|    avg|  57 - 58 |      128
HSD|    avg|  58 - 59 |       91
HSD|    avg|  59 - 60 |       72
HSD|    avg|  60 - 61 |       54
HSD|    avg|  61 - 62 |       37
HSD|    avg|  62 - 63 |       25
HSD|    avg|  63 - 64 |       26
HSD|    avg|  64 - 65 |       14
HSD|    avg|  65 - 66 |       27
HSD|    avg|  66 - 67 |       55
HSD|    avg|  67 - 68 |      133
HSD|    avg|  68 - 69 |      183
HSD|    avg|  69 - 70 |      188
HSD|    avg|  70 - 71 |      231
HSD|    avg|  71 - 72 |      216
HSD|    avg|  72 - 73 |      237
HSD|    avg|  73 - 74 |      246
HSD|    avg|  74 - 75 |      241
HSD|    avg|  75 - 76 |      221
HSD|    avg|  76 - 77 |      187
HSD|    avg|  77 - 78 |       79
HSD|    avg|  78 - 79 |       38
HSD|    avg|  79 - 80 |       27
HSD|    avg|  80 - 81 |       13
HSD|    avg|  81 - 82 |       11
HSD|    avg|  82 - 83 |        1
---|--param|----range-|--samples
HSD|    max|  33 - 34 |        1
HSD|    max|  40 - 41 |     1005
HSD|    max|  41 - 42 |    28195
HSD|    max|  42 - 43 |    20617
HSD|    max|  43 - 44 |     3707
HSD|    max|  44 - 45 |     2474
HSD|    max|  45 - 46 |     1806
HSD|    max|  46 - 47 |     1160
HSD|    max|  47 - 48 |      811
HSD|    max|  48 - 49 |      848
HSD|    max|  49 - 50 |      337
HSD|    max|  50 - 51 |      216
HSD|    max|  51 - 52 |      132
HSD|    max|  52 - 53 |      102
HSD|    max|  53 - 54 |       78
HSD|    max|  54 - 55 |       80
HSD|    max|  55 - 56 |       95
HSD|    max|  56 - 57 |       80
HSD|    max|  57 - 58 |      123
HSD|    max|  58 - 59 |       88
HSD|    max|  59 - 60 |       71
HSD|    max|  60 - 61 |       53
HSD|    max|  61 - 62 |       37
HSD|    max|  62 - 63 |       25
HSD|    max|  63 - 64 |       25
HSD|    max|  64 - 65 |       14
HSD|    max|  65 - 66 |       26
HSD|    max|  66 - 67 |       54
HSD|    max|  67 - 68 |      133
HSD|    max|  68 - 69 |      182
HSD|    max|  69 - 70 |      188
HSD|    max|  70 - 71 |      231
HSD|    max|  71 - 72 |      216
HSD|    max|  72 - 73 |      236
HSD|    max|  73 - 74 |      246
HSD|    max|  74 - 75 |      240
HSD|    max|  75 - 76 |      221
HSD|    max|  76 - 77 |      186
HSD|    max|  77 - 78 |       79
HSD|    max|  78 - 79 |       38
HSD|    max|  79 - 80 |       27
HSD|    max|  80 - 81 |       12
HSD|    max|  81 - 82 |       11
HSD|    max|  82 - 83 |        1
HSH|--param|--samples-|--average--|---stddev--
HSS|    min|     64507|     10.557|      3.251
HSS|    avg| 129014447|     28.592|      1.875
HSS|    max|     64507|     43.324|      6.063
---|------------|------------|------------|--------|---------------------=
----
RTS|       3.865|      28.994|      82.152|       0|    =
17:55:07/17:55:07

[Calibrator load]
---|--param|----range-|--samples
HSD|    min|   9 - 10 |        9
HSD|    min|  10 - 11 |       92
HSD|    min|  11 - 12 |     1205
HSD|    min|  12 - 13 |     2365
HSD|    min|  13 - 14 |     1244
HSD|    min|  14 - 15 |      205
HSD|    min|  15 - 16 |      343
HSD|    min|  16 - 17 |     1850
HSD|    min|  17 - 18 |     5522
HSD|    min|  18 - 19 |     8955
HSD|    min|  19 - 20 |    11804
HSD|    min|  20 - 21 |     6842
HSD|    min|  21 - 22 |     5125
HSD|    min|  22 - 23 |     3271
HSD|    min|  23 - 24 |     2341
HSD|    min|  24 - 25 |     1870
HSD|    min|  25 - 26 |     1473
HSD|    min|  26 - 27 |     1276
HSD|    min|  27 - 28 |     1209
HSD|    min|  28 - 29 |      564
HSD|    min|  29 - 30 |       68
HSD|    min|  30 - 31 |        7
HSD|    min|  31 - 32 |        1
---|--param|----range-|--samples
HSD|    avg|   9 - 10 |        9
HSD|    avg|  10 - 11 |       96
HSD|    avg|  11 - 12 |     1527
HSD|    avg|  12 - 13 |     5171
HSD|    avg|  13 - 14 |     4081
HSD|    avg|  14 - 15 |      877
HSD|    avg|  15 - 16 |      732
HSD|    avg|  16 - 17 |     2217
HSD|    avg|  17 - 18 |     6082
HSD|    avg|  18 - 19 |     9760
HSD|    avg|  19 - 20 |    12769
HSD|    avg|  20 - 21 |     7434
HSD|    avg|  21 - 22 |     5529
HSD|    avg|  22 - 23 |     3493
HSD|    avg|  23 - 24 |     2505
HSD|    avg|  24 - 25 |     2096
HSD|    avg|  25 - 26 |     1942
HSD|    avg|  26 - 27 |     4842
HSD|    avg|  27 - 28 |    34199
HSD|    avg|  28 - 29 |   120852
HSD|    avg|  29 - 30 |   136974
HSD|    avg|  30 - 31 |   101180
HSD|    avg|  31 - 32 |    69169
HSD|    avg|  32 - 33 |    57038
HSD|    avg|  33 - 34 |   228573
HSD|    avg|  34 - 35 |  1025142
HSD|    avg|  35 - 36 |  1348547
HSD|    avg|  36 - 37 |   815902
HSD|    avg|  37 - 38 |   574130
HSD|    avg|  38 - 39 | 30363456
HSD|    avg|  39 - 40 | 27246603
HSD|    avg|  40 - 41 | 13270402
HSD|    avg|  41 - 42 |  5497363
HSD|    avg|  42 - 43 |  7335063
HSD|    avg|  43 - 44 |  4849800
HSD|    avg|  44 - 45 |  2240602
HSD|    avg|  45 - 46 |    75576
HSD|    avg|  46 - 47 |    27288
HSD|    avg|  47 - 48 |    46285
HSD|    avg|  48 - 49 |   146725
HSD|    avg|  49 - 50 |   996580
HSD|    avg|  50 - 51 |  1568864
HSD|    avg|  51 - 52 |   776719
HSD|    avg|  52 - 53 |   641509
HSD|    avg|  53 - 54 |   917617
HSD|    avg|  54 - 55 |   900492
HSD|    avg|  55 - 56 |   571743
HSD|    avg|  56 - 57 |   196338
HSD|    avg|  57 - 58 |    43611
HSD|    avg|  58 - 59 |    14642
HSD|    avg|  59 - 60 |    13459
HSD|    avg|  60 - 61 |    12614
HSD|    avg|  61 - 62 |     9997
HSD|    avg|  62 - 63 |     6087
HSD|    avg|  63 - 64 |     4654
HSD|    avg|  64 - 65 |     4137
HSD|    avg|  65 - 66 |     4249
HSD|    avg|  66 - 67 |     4378
HSD|    avg|  67 - 68 |     5078
HSD|    avg|  68 - 69 |     3441
HSD|    avg|  69 - 70 |     3562
HSD|    avg|  70 - 71 |     3881
HSD|    avg|  71 - 72 |     4129
HSD|    avg|  72 - 73 |     4420
HSD|    avg|  73 - 74 |     6049
HSD|    avg|  74 - 75 |    31865
HSD|    avg|  75 - 76 |    71913
HSD|    avg|  76 - 77 |    62062
HSD|    avg|  77 - 78 |     7488
HSD|    avg|  78 - 79 |     6747
HSD|    avg|  79 - 80 |     6880
HSD|    avg|  80 - 81 |     6555
HSD|    avg|  81 - 82 |     5384
HSD|    avg|  82 - 83 |     5127
HSD|    avg|  83 - 84 |     6581
HSD|    avg|  84 - 85 |     6559
HSD|    avg|  85 - 86 |     5277
HSD|    avg|  86 - 87 |     7083
HSD|    avg|  87 - 88 |     6919
HSD|    avg|  88 - 89 |    96541
HSD|    avg|  89 - 90 |  2252688
HSD|    avg|  90 - 91 |  5672119
HSD|    avg|  91 - 92 |  3873054
HSD|    avg|  92 - 93 |   575190
HSD|    avg|  93 - 94 |   120989
HSD|    avg|  94 - 95 |    30642
HSD|    avg|  95 - 96 |     3550
HSD|    avg|  96 - 97 |     2431
HSD|    avg|  97 - 98 |     1534
HSD|    avg|  98 - 99 |     1323
HSD|    avg|  99 -100 |     1249
HSD|    avg| 100 -101 |     1477
HSD|    avg| 101 -102 |     1404
HSD|    avg| 102 -103 |     1282
HSD|    avg| 103 -104 |      957
HSD|    avg| 104 -105 |      817
HSD|    avg| 105 -106 |     1107
HSD|    avg| 106 -107 |     1038
HSD|    avg| 107 -108 |     1069
HSD|    avg| 108 -109 |     1050
HSD|    avg| 109 -110 |      887
HSD|    avg| 110 -111 |      697
HSD|    avg| 111 -112 |      589
HSD|    avg| 112 -113 |      497
HSD|    avg| 113 -114 |      509
HSD|    avg| 114 -115 |      470
HSD|    avg| 115 -116 |      466
HSD|    avg| 116 -117 |      203
HSD|    avg| 117 -118 |      182
HSD|    avg| 118 -119 |      155
HSD|    avg| 119 -120 |      126
HSD|    avg| 120 -121 |      157
HSD|    avg| 121 -122 |      110
HSD|    avg| 122 -123 |      104
HSD|    avg| 123 -124 |       88
HSD|    avg| 124 -125 |       42
HSD|    avg| 125 -126 |       31
HSD|    avg| 126 -127 |        6
HSD|    avg| 127 -128 |        7
HSD|    avg| 128 -129 |        2

# HSD|    avg| 129 -130 |        3
HSD|    avg| 130 -131 |        4
HSD|    avg| 131 -132 |        2
HSD|    avg| 132 -133 |        2
HSD|    avg| 133 -134 |        1
HSD|    avg| 134 -135 |        1
HSD|    avg| 136 -137 |        1
HSD|    avg| 137 -138 |        1
HSD|    avg| 139 -140 |        1
HSD|    avg| 143 -144 |        1
---|--param|----range-|--samples
HSD|    max|  50 - 51 |      423
HSD|    max|  51 - 52 |      518
HSD|    max|  52 - 53 |      190
HSD|    max|  53 - 54 |      479
HSD|    max|  54 - 55 |      735
HSD|    max|  55 - 56 |     2368
HSD|    max|  56 - 57 |     4327
HSD|    max|  57 - 58 |     1937
HSD|    max|  58 - 59 |      685
HSD|    max|  59 - 60 |      635
HSD|    max|  60 - 61 |      772
HSD|    max|  61 - 62 |      692
HSD|    max|  62 - 63 |      620
HSD|    max|  63 - 64 |      573
HSD|    max|  64 - 65 |      527
HSD|    max|  65 - 66 |      503
HSD|    max|  66 - 67 |      548
HSD|    max|  67 - 68 |      815
HSD|    max|  68 - 69 |      661
HSD|    max|  69 - 70 |      694
HSD|    max|  70 - 71 |      855
HSD|    max|  71 - 72 |      976
HSD|    max|  72 - 73 |     1164
HSD|    max|  73 - 74 |     1401
HSD|    max|  74 - 75 |     1616
HSD|    max|  75 - 76 |     1844
HSD|    max|  76 - 77 |     2743
HSD|    max|  77 - 78 |     2398
HSD|    max|  78 - 79 |     2925
HSD|    max|  79 - 80 |     3688
HSD|    max|  80 - 81 |     3734
HSD|    max|  81 - 82 |     2464
HSD|    max|  82 - 83 |      984
HSD|    max|  83 - 84 |      424
HSD|    max|  84 - 85 |      324
HSD|    max|  85 - 86 |      290
HSD|    max|  86 - 87 |      373
HSD|    max|  87 - 88 |      245
HSD|    max|  88 - 89 |      173
HSD|    max|  89 - 90 |      174
HSD|    max|  90 - 91 |      187
HSD|    max|  91 - 92 |      260
HSD|    max|  92 - 93 |      183
HSD|    max|  93 - 94 |      175
HSD|    max|  94 - 95 |      388
HSD|    max|  95 - 96 |      183
HSD|    max|  96 - 97 |      195
HSD|    max|  97 - 98 |      195
HSD|    max|  98 - 99 |      222
HSD|    max|  99 -100 |      228
HSD|    max| 100 -101 |      329
HSD|    max| 101 -102 |      399
HSD|    max| 102 -103 |      363
HSD|    max| 103 -104 |      334
HSD|    max| 104 -105 |      334
HSD|    max| 105 -106 |      491
HSD|    max| 106 -107 |      469
HSD|    max| 107 -108 |      536
HSD|    max| 108 -109 |      593
HSD|    max| 109 -110 |      539
HSD|    max| 110 -111 |      442
HSD|    max| 111 -112 |      400
HSD|    max| 112 -113 |      376
HSD|    max| 113 -114 |      380
HSD|    max| 114 -115 |      388
HSD|    max| 115 -116 |      390
HSD|    max| 116 -117 |      181
HSD|    max| 117 -118 |      167
HSD|    max| 118 -119 |      146
HSD|    max| 119 -120 |      122
HSD|    max| 120 -121 |      150
HSD|    max| 121 -122 |      106
HSD|    max| 122 -123 |      103
HSD|    max| 123 -124 |       88
HSD|    max| 124 -125 |       42
HSD|    max| 125 -126 |       30
HSD|    max| 126 -127 |        5
HSD|    max| 127 -128 |        6
HSD|    max| 128 -129 |        2
HSD|    max| 129 -130 |        3
HSD|    max| 130 -131 |        4
HSD|    max| 131 -132 |        2
HSD|    max| 132 -133 |        2
HSD|    max| 133 -134 |        1
HSD|    max| 134 -135 |        1
HSD|    max| 136 -137 |        1
HSD|    max| 137 -138 |        1
HSD|    max| 139 -140 |        1
HSD|    max| 143 -144 |        1
HSH|--param|--samples-|--average--|---stddev--
HSS|    min|     57641|     19.284|      3.453
HSS|    avg| 115283577|     45.692|     16.144
HSS|    max|     57641|     76.480|     16.912
---|------------|------------|------------|--------|---------------------=
----
RTS|       9.342|      46.069|     143.363|       0|    =
16:00:42/16:00:42

[Test_switch load]
RTD|       8.698|      32.216|      85.051|       0|       4.832|      =
87.628
RTD|       9.342|      32.216|      85.051|       0|       4.832|      =
87.628
RTD|      11.597|      32.216|      83.762|       0|       4.832|      =
87.628
RTD|      11.920|      32.216|      82.474|       0|       4.832|      =
87.628
RTD|      10.953|      32.216|      61.211|       0|       4.832|      =
87.628
RTD|       9.342|      32.216|      48.324|       0|       4.832|      =
87.628
RTD|       9.020|      32.216|      76.353|       0|       4.832|      =
87.628
RTD|      18.685|      32.216|      85.051|       0|       4.832|      =
87.628
RTD|       8.376|      32.216|      80.541|       0|       4.832|      =
87.628
RTD|      10.631|      32.216|      48.324|       0|       4.832|      =
87.628
RTD|      12.242|      32.216|      80.541|       0|       4.832|      =
87.628
RTD|       9.987|      32.216|      84.407|       0|       4.832|      =
87.628
RTT|  03:56:58  (periodic user-mode task, 500 us period, priority 99)
RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat =
worst
RTD|      10.309|      32.216|      68.943|       0|       4.832|      =
87.628
RTD|       7.087|      32.216|      84.407|       0|       4.832|      =
87.628
RTD|       8.698|      32.216|      84.085|       0|       4.832|      =
87.628
RTD|      10.953|      32.216|      84.729|       0|       4.832|      =
87.628
RTD|       8.376|      32.216|      78.608|       0|       4.832|      =
87.628
RTD|      10.631|      32.216|      79.574|       0|       4.832|      =
87.628
RTD|       9.987|      32.216|      85.051|       0|       4.832|      =
87.628
RTD|      12.886|      32.216|      76.353|       0|       4.832|      =
87.628
RTD|       9.020|      32.216|      82.796|       0|       4.832|      =
87.628
RTD|      12.886|      32.216|      84.729|       0|       4.832|      =
87.628
RTD|      11.920|      32.216|      71.198|       0|       4.832|      =
87.628
RTD|      11.597|      32.216|      82.796|       0|       4.832|      =
87.628
RTD|      10.953|      32.216|      84.729|       0|       4.832|      =
87.628
RTD|       6.765|      32.216|      84.085|       0|       4.832|      =
87.628
---|--param|----range-|--samples
HSD|    min|   4 -  5 |        1
HSD|    min|   5 -  6 |       17
HSD|    min|   6 -  7 |      145
HSD|    min|   7 -  8 |      622
HSD|    min|   8 -  9 |     1610
HSD|    min|   9 - 10 |     3420
HSD|    min|  10 - 11 |     2336
HSD|    min|  11 - 12 |     1775
HSD|    min|  12 - 13 |     1176
HSD|    min|  13 - 14 |      569
HSD|    min|  14 - 15 |      424
HSD|    min|  15 - 16 |      409
HSD|    min|  16 - 17 |      493
HSD|    min|  17 - 18 |      624
HSD|    min|  18 - 19 |      473
HSD|    min|  19 - 20 |      134
HSD|    min|  20 - 21 |        2
HSD|    min|  21 - 22 |        1
---|--param|----range-|--samples
HSD|    avg|   4 -  5 |        1
HSD|    avg|   5 -  6 |       17
HSD|    avg|   6 -  7 |      145
HSD|    avg|   7 -  8 |      622
HSD|    avg|   8 -  9 |     1610
HSD|    avg|   9 - 10 |     3421
HSD|    avg|  10 - 11 |     2336
HSD|    avg|  11 - 12 |     1776
HSD|    avg|  12 - 13 |     1176
HSD|    avg|  13 - 14 |      571
HSD|    avg|  14 - 15 |      473
HSD|    avg|  15 - 16 |      538
HSD|    avg|  16 - 17 |      804
HSD|    avg|  17 - 18 |     2496
HSD|    avg|  18 - 19 |     7144
HSD|    avg|  19 - 20 |     5650
HSD|    avg|  20 - 21 |     1923
HSD|    avg|  21 - 22 |    64535
HSD|    avg|  22 - 23 |   427018
HSD|    avg|  23 - 24 |   665365
HSD|    avg|  24 - 25 |   227984
HSD|    avg|  25 - 26 |    23091
HSD|    avg|  26 - 27 |     2953
HSD|    avg|  27 - 28 |     3391
HSD|    avg|  28 - 29 |     2702
HSD|    avg|  29 - 30 |     3893
HSD|    avg|  30 - 31 |   284313
HSD|    avg|  31 - 32 |  5560838
HSD|    avg|  32 - 33 | 14865620
HSD|    avg|  33 - 34 |  3283135
HSD|    avg|  34 - 35 |  1220470
HSD|    avg|  35 - 36 |  1065544
HSD|    avg|  36 - 37 |   509346
HSD|    avg|  37 - 38 |     7005
HSD|    avg|  38 - 39 |      897
HSD|    avg|  39 - 40 |     4247
HSD|    avg|  40 - 41 |    13566
HSD|    avg|  41 - 42 |    14153
HSD|    avg|  42 - 43 |     6957
HSD|    avg|  43 - 44 |    17731
HSD|    avg|  44 - 45 |    47213
HSD|    avg|  45 - 46 |    28816
HSD|    avg|  46 - 47 |    16694
HSD|    avg|  47 - 48 |    14884
HSD|    avg|  48 - 49 |    12561
HSD|    avg|  49 - 50 |     1723
HSD|    avg|  50 - 51 |     1527
HSD|    avg|  51 - 52 |     1682
HSD|    avg|  52 - 53 |     1650
HSD|    avg|  53 - 54 |     1186
HSD|    avg|  54 - 55 |      517
HSD|    avg|  55 - 56 |      328
HSD|    avg|  56 - 57 |      337
HSD|    avg|  57 - 58 |      422
HSD|    avg|  58 - 59 |      297
HSD|    avg|  59 - 60 |      298
HSD|    avg|  60 - 61 |      295
HSD|    avg|  61 - 62 |      276
HSD|    avg|  62 - 63 |      262
HSD|    avg|  63 - 64 |      238
HSD|    avg|  64 - 65 |      269
HSD|    avg|  65 - 66 |      216
HSD|    avg|  66 - 67 |      207
HSD|    avg|  67 - 68 |      273
HSD|    avg|  68 - 69 |      121
HSD|    avg|  69 - 70 |       97
HSD|    avg|  70 - 71 |      103
HSD|    avg|  71 - 72 |       86
HSD|    avg|  72 - 73 |      161
HSD|    avg|  73 - 74 |      399
HSD|    avg|  74 - 75 |     1260
HSD|    avg|  75 - 76 |     1826
HSD|    avg|  76 - 77 |     2943
HSD|    avg|  77 - 78 |     1636
HSD|    avg|  78 - 79 |      969
HSD|    avg|  79 - 80 |     1060
HSD|    avg|  80 - 81 |     1496
HSD|    avg|  81 - 82 |     2713
HSD|    avg|  82 - 83 |     2674
HSD|    avg|  83 - 84 |     2314
HSD|    avg|  84 - 85 |     2735
HSD|    avg|  85 - 86 |     2202
HSD|    avg|  86 - 87 |      531
HSD|    avg|  87 - 88 |        2
---|--param|----range-|--samples
HSD|    max|  43 - 44 |        1
HSD|    max|  44 - 45 |        1
HSD|    max|  45 - 46 |       19
HSD|    max|  46 - 47 |       16
HSD|    max|  47 - 48 |       40
HSD|    max|  48 - 49 |      102
HSD|    max|  49 - 50 |       26
HSD|    max|  50 - 51 |       27
HSD|    max|  51 - 52 |       41
HSD|    max|  52 - 53 |       62
HSD|    max|  53 - 54 |       59
HSD|    max|  54 - 55 |       61
HSD|    max|  55 - 56 |       55
HSD|    max|  56 - 57 |       77
HSD|    max|  57 - 58 |      130
HSD|    max|  58 - 59 |       81
HSD|    max|  59 - 60 |       77
HSD|    max|  60 - 61 |       87
HSD|    max|  61 - 62 |       81
HSD|    max|  62 - 63 |       86
HSD|    max|  63 - 64 |       62
HSD|    max|  64 - 65 |       84
HSD|    max|  65 - 66 |       63
HSD|    max|  66 - 67 |       61
HSD|    max|  67 - 68 |       91
HSD|    max|  68 - 69 |       23
HSD|    max|  69 - 70 |       23
HSD|    max|  70 - 71 |       31
HSD|    max|  71 - 72 |       16
HSD|    max|  72 - 73 |       20
HSD|    max|  73 - 74 |       54
HSD|    max|  74 - 75 |      247
HSD|    max|  75 - 76 |      471
HSD|    max|  76 - 77 |      803
HSD|    max|  77 - 78 |      482
HSD|    max|  78 - 79 |      343
HSD|    max|  79 - 80 |      470
HSD|    max|  80 - 81 |      673
HSD|    max|  81 - 82 |     1331
HSD|    max|  82 - 83 |     1591
HSD|    max|  83 - 84 |     1587
HSD|    max|  84 - 85 |     2080
HSD|    max|  85 - 86 |     1973
HSD|    max|  86 - 87 |      521
HSD|    max|  87 - 88 |        2
HSH|--param|--samples-|--average--|---stddev--
HSS|    min|     14231|     10.896|      2.966
HSS|    avg|  28462956|     31.822|      2.980
HSS|    max|     14231|     79.018|      8.241
---|------------|------------|------------|--------|---------------------=
----
RTS|       4.832|      32.216|      87.628|       0|    =
03:57:12/03:57:12

[Xeno-test]
xeno-test: started
withBusybox is 1
xeno-test: running tests

Thu Jan  1 00:01:49 UTC 1970
running: ./xeno-config --verbose
xeno-config --verbose
    --version=3D"2.3.50"
    =
--cc=3D"/opt/crosstool/gcc-4.1.0-glibc-2.3.2/arm-unknown-linux-gnu/bin/ar=
m-unknown-linux-gnu-gcc"
    --arch=3D"arm"
    --prefix=3D"/usr/xenomai"
    --xeno-cflags=3D"-I/usr/xenomai/include -D_GNU_SOURCE -D_REENTRANT =
-D__XENO__"
    --xeno-ldflags=3D"-L/usr/xenomai/lib -lpthread "
    --posix-cflags=3D"-I/usr/xenomai/include =
-I/usr/xenomai/include/posix -D_GNU_SOURCE -D_REENTRANT -D__XENO__"
    --posix-ldflags=3D"-L/usr/xenomai/lib -lpthread_rt -lpthread -lrt "
    --library-dir=3D"/usr/xenomai/lib"

Thu Jan  1 00:01:49 UTC 1970
running: ./xeno-info
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

BusyBox v1.2.2 (2007.05.18-11:41+0000) multi-call binary
Linux uclibc 2.6.20.13 #10 Mon Jun 11 15:29:00 CEST 2007 armv5tejl =
unknown

module-init-tools      3.2.2
Modules Loaded

Thu Jan  1 00:01:50 UTC 1970
running: cat /proc/cpuinfo
Processor       : ARM926EJ-S rev 5 (v5l)
BogoMIPS        : 98.91
Features        : swp half fastmult edsp java
CPU implementer : 0x41
CPU architecture: 5TEJ
CPU variant     : 0x0
CPU part        : 0x926
CPU revision    : 5
Cache type      : write-back
Cache clean     : cp15 c7 ops
Cache lockdown  : format C
Cache format    : Harvard
I size          : 8192
I assoc         : 4
I line length   : 32
I sets          : 64
D size          : 8192
D assoc         : 4
D line length   : 32
D sets          : 64

Hardware        : Atmel AT91SAM9260-EK
Revision        : 0000
Serial          : 0000000000000000

Thu Jan  1 00:01:50 UTC 1970
running: md5sum /proc/cpuinfo # cpuinfo fingerprint
36ded2a3d6ea6737b81fe246e04b70b2  /proc/cpuinfo

Thu Jan  1 00:01:50 UTC 1970
running: cat /proc/ipipe/Linux
       +----- Handling ([A]ccepted, [G]rabbed, [W]ired, [D]iscarded)
       |+---- Sticky
       ||+--- Locked
       |||+-- Exclusive
       ||||+- Virtual
[IRQ]  |||||
   0:  A....
   1:  A....
   2:  A....
   3:  A....
   4:  A....
   5:  A....
   6:  A....
   7:  A....
   8:  A....
   9:  A....
  10:  A....
  11:  A....
  12:  A....
  13:  A....
  14:  A....
  15:  A....
  16:  A....
  17:  A....
  18:  A....
  19:  A....
  20:  A....
  21:  A....
  22:  A....
  23:  A....
  24:  A....
  25:  A....
  26:  A....
  27:  A....
  28:  A....
  29:  A....
  30:  A....
  31:  A....
  32:  A....
  33:  A....
  34:  A....
  35:  A....
  36:  A....
  37:  A....
  38:  A....
  39:  A....
  40:  A....
  41:  A....
  42:  A....
  43:  A....
  44:  A....
  45:  A....
  46:  A....
  47:  A....
  48:  A....
  49:  A....
  50:  A....
  51:  A....
  52:  A....
  53:  A....
  54:  A....
  55:  A....
  56:  A....
  57:  A....
  58:  A....
  59:  A....
  60:  A....
  61:  A....
  62:  A....
  63:  A....
  64:  A....
  65:  A....
  66:  A....
  67:  A....
  68:  A....
  69:  A....
  70:  A....
  71:  A....
  72:  A....
  73:  A....
  74:  A....
  75:  A....
  76:  A....
  77:  A....
  78:  A....
  79:  A....
  80:  A....
  81:  A....
  82:  A....
  83:  A....
  84:  A....
  85:  A....
  86:  A....
  87:  A....
  88:  A....
  89:  A....
  90:  A....
  91:  A....
  92:  A....
  93:  A....
  94:  A....
  95:  A....
  96:  A....
  97:  A....
  98:  A....
  99:  A....
 100:  A....
 101:  A....
 102:  A....
 103:  A....
 104:  A....
 105:  A....
 106:  A....
 107:  A....
 108:  A....
 109:  A....
 110:  A....
 111:  A....
 112:  A....
 113:  A....
 114:  A....
 115:  A....
 116:  A....
 117:  A....
 118:  A....
 119:  A....
 120:  A....
 121:  A....
 122:  A....
 123:  A....
 124:  A....
 125:  A....
 126:  A....
 127:  A....
 128:  A....
 129:  A....
 130:  A....
 131:  A....
 132:  A....
 133:  A....
 134:  A....
 135:  A....
 136:  A....
 137:  A....
 138:  A....
 139:  A....
 140:  A....
 141:  A....
 142:  A....
 143:  A....
 144:  A....
 145:  A....
 146:  A....
 147:  A....
 148:  A....
 149:  A....
 150:  A....
 151:  A....
 152:  A....
 153:  A....
 154:  A....
 155:  A....
 156:  A....
 157:  A....
 158:  A....
 159:  A....
 160:  G...V
 161:  G...V
[Domain info]
id=3D0x00000000
priority=3D100

Thu Jan  1 00:01:50 UTC 1970
running: cat /proc/ipipe/Xenomai
       +----- Handling ([A]ccepted, [G]rabbed, [W]ired, [D]iscarded)
       |+---- Sticky
       ||+--- Locked
       |||+-- Exclusive
       ||||+- Virtual
[IRQ]  |||||
  17:  W..X.
 162:  W...V
[Domain info]
id=3D0x58454e4f
priority=3Dtopmost

Thu Jan  1 00:01:50 UTC 1970
running: cat /proc/ipipe/version
1.7-03

Thu Jan  1 00:01:50 UTC 1970
running: generate_loads 1
dd workload started, pids 324 stored in /var/lock/xeno-test.224.pids

Thu Jan  1 00:01:50 UTC 1970
running: cat /proc/interrupts
           CPU0
  1:       5498         AIC  atmel_serial
 17:      11124         AIC  at91_tick
 21:       3920         AIC  eth0
Err:          0

Thu Jan  1 00:01:51 UTC 1970
running: cat /proc/loadavg
0.28 0.10 0.03 2/25 330

Thu Jan  1 00:01:51 UTC 1970
running: cat /proc/meminfo
MemTotal:        62508 kB
MemFree:         57116 kB
Buffers:             0 kB
Cached:           2328 kB
SwapCached:          0 kB
Active:           2208 kB
Inactive:         1004 kB
SwapTotal:           0 kB
SwapFree:            0 kB
Dirty:               8 kB
Writeback:           0 kB
AnonPages:         904 kB
Mapped:            844 kB
Slab:             1176 kB
SReclaimable:      220 kB
SUnreclaim:        956 kB
PageTables:        148 kB
NFS_Unstable:        0 kB
Bounce:              0 kB
CommitLimit:     31252 kB
Committed_AS:     4612 kB
VmallocTotal:   956416 kB
VmallocUsed:      8576 kB
VmallocChunk:   940028 kB

Thu Jan  1 00:01:52 UTC 1970
running: cat /proc/xenomai/affinity
00000001

Thu Jan  1 00:01:52 UTC 1970
running: cat /proc/xenomai/apc
APC          CPU0
  0:            0    (pipe_wakeup)
  1:            0    (lostage_handler)
  2:            0    (registry_export)
  3:            0    (posix_signals_handler)

Thu Jan  1 00:01:52 UTC 1970
running: cat /proc/xenomai/faults
TRAP         CPU0
  0:            0    (Data or instruction access)
  1:            0    (Section fault)
  2:            0    (Generic data abort)
  3:            0    (Unknown exception)
  4:            0    (Instruction breakpoint)
  5:            0    (Floating point exception)
  6:            0    (VFP Floating point exception)
  7:            0    (Undefined instruction)

Thu Jan  1 00:01:53 UTC 1970
running: cat /proc/xenomai/hal
1.7-03

Thu Jan  1 00:01:53 UTC 1970
running: cat /proc/xenomai/heap
size=3D130560:used=3D64:pagesz=3D512

Thu Jan  1 00:01:53 UTC 1970
running: cat /proc/xenomai/irq
IRQ         CPU0
 17:       11347         [timer]
162:           0         [virtual]

Thu Jan  1 00:01:53 UTC 1970
running: cat /proc/xenomai/latency
9664

Thu Jan  1 00:01:54 UTC 1970
running: cat /proc/xenomai/sched
CPU  PID    PRI      PERIOD     TIMEOUT    TIMEBASE  STAT       NAME
  0  0       -1      0          0          master    R          ROOT

Thu Jan  1 00:01:54 UTC 1970
running: cat /proc/xenomai/timebases
NAME       RESOLUTION     JIFFIES   STATUS
master              1         n/a   enabled

Thu Jan  1 00:01:54 UTC 1970
running: cat /proc/xenomai/timer
status=3Don:setup=3D322:clock=3D355080158

Thu Jan  1 00:01:55 UTC 1970
running: cat /proc/xenomai/version
2.4-devel

Thu Jan  1 00:01:55 UTC 1970
running: cat /proc/xenomai/interfaces/native
0

Thu Jan  1 00:01:55 UTC 1970
running: cat /proc/xenomai/interfaces/posix
Mem: 5636K used, 56872K free, 0K shrd, 0K buff, 2332K cached
Load average: 0.42 0.14 0.04  (Status: S=3Dsleeping R=3Drunning, =
W=3Dwaiting)
  PID USER     STATUS   RSS  PPID %MEM COMMAND
  215 root     S        856     1  1.3 sh
  395 root     R        700   394  1.1 top
  224 root     S        660   215  1.0 xeno-test
  184 daemon   S        584     1  0.9 portmap
    1 root     S        564     0  0.9 init
  216 root     S        548     1  0.8 syslogd
  217 root     S        532     1  0.8 klogd


-----Message d'origine-----
De : adeos-main-bounces@domain.hid [mailto:adeos-main-bounces@domain.hid la
part de Gilles Chanteperdrix
Envoy=E9 : lundi 4 juin 2007 19:40
=C0 : adeos-main
Objet : [Adeos-main] New I-pipe patch for ARM needs testing.



Hi,

in Xenomai repository (trunk and v2.3.x branch), you will find
adeos-ipipe-2.6.20-arm-1.7-03.patch, the latest version of the I-pipe
patch for ARM. In addition to merging support for two new boards (ixp4xx
and at91sam926x), this patch adds a few important features:
- the at91 patch now applies after the I-pipe patch with no reject ;
- it is now possible for Xenomai to preempt Linux during the mm switch,
which should improve Xenomai scheduling latency significantly;
- Xenomai is now able to access directly I-pipe tsc emulation in
user-space, providing a low overhead timing facility to user-space
applications.

Before including this patch in a new release, and because I could only
test the patch on at91rm9200, we would like people to test the patch on
their hardware and give us feedback about the stability and performance.
In order to adequately stress-test Linux mm context switch, please use
something along the lines of the attached test_switch.c.

As for tsc emulation in user-space, I only implemented it for machines
with a free-running counter, hoping that someone (maybe Sebastian or
Stelian ?) with hardware whose tsc is based on a decrementer could do
the work. This tsc emulation in user-space also required to rework a bit
Xenomai configure script: it is now necessary to pass a
--enable-arm-mach option to configure, and to pass the option
--enable-arm-tsc to enable the tsc.

Thanks in advance.

--=20
                                                 Gilles Chanteperdrix

