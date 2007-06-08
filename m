Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C7A9CB.71968B58"
Date: Fri, 8 Jun 2007 14:49:25 +0200
Message-ID: <403B28AE6257B548B66BB88414AC78330174BC35@domain.hid>
From: "BOUIN Alexandre" <abouin@domain.hid>
Subject: [Xenomai-core] adeos-ipipe-2.6.20-arm-1.7-03.patch return high
	latencies ...
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

This is a multi-part message in MIME format.

------_=_NextPart_001_01C7A9CB.71968B58
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

	I missed something : title was wrong. My apologies.

	Gilles asked for some people to test =
adeos-ipipe-2.6.20-arm-1.7-03.patch. As we said, our board are always =
ready to receive new releases.

	Once 2.6.20 kernel unpacked, I've started patching it with Xenomai, =
including last release of Adeos patch. I've kept last releases of our =
libs cause nothing seems block us to use them with a new kernel. Our =
Buildroot is using glibc and kernel has no debug traces.

	Then I setup latencies to 45=B5s, launched a dd load and latency. But =
we are expecting higher latencies (over 200s), and system crash then. No =
trace, the only thing we can do is to reboot the system.  Are you other =
expecting such results with your boards ?

	I've seen that some people get some troubles with 2.6.20 with their =
data transfer, like with dd load, even on x86. Is it a common behaviour =
with 2.6.20 ?

	Here is 2 test with 2.6.20 and one with 2.6.19 to compare :=20

	[xeno ./latency -p 500 -h -H 500 |  2.6.20arm + DD + latency=3D45000 - =
1h]
	RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat =
worst
	RTD|       7.087|      55.412|      93.750|       0|       1.288|     =
266.752
	RTD|      15.141|      54.445|      98.260|       0|       1.288|     =
266.752
	RTD|      19.652|      54.123|      94.072|       0|       1.288|     =
266.752
	RTD|      15.141|      53.157|      98.582|       0|       1.288|     =
266.752
	RTD|      17.719|      52.835|      98.260|       0|       1.288|     =
266.752
	RTD|      16.752|      51.868|     113.402|       0|       1.288|     =
266.752
	RTD|      19.974|      51.546|     105.670|       0|       1.288|     =
266.752
	RTD|      14.819|      50.579|      97.615|       0|       1.288|     =
266.752
	RTD|      19.652|      50.257|      99.226|       0|       1.288|     =
266.752
	RTD|      16.108|      49.291|     113.079|       0|       1.288|     =
266.752
	RTD|      19.329|      48.969|      96.649|       0|       1.288|     =
266.752
	RTD|      13.853|      48.002|     108.891|       0|       1.288|     =
266.752
	RTD|      21.585|      48.002|     115.012|       0|       1.288|     =
266.752
	RTD|      17.074|      46.713|      98.582|       0|       1.288|     =
266.752
	RTD|       7.087|      46.391|     109.536|       0|       1.288|     =
266.752
	RTD|      14.497|      45.425|     102.448|       0|       1.288|     =
266.752
	RTD|      21.907|      45.103|      93.750|       0|       1.288|     =
266.752
	RTD|      16.108|      44.136|      97.615|       0|       1.288|     =
266.752
	RTD|      21.907|      44.136|      93.750|       0|       1.288|     =
266.752
	RTD|      17.074|      43.170|     114.690|       0|       1.288|     =
266.752
	RTD|      19.974|      42.847|      98.260|       0|       1.288|     =
266.752
	RTT|  01:06:31  (periodic user-mode task, 500 us period, priority 99)
	RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat =
worst
	RTD|      10.631|      41.881|      98.582|       0|       1.288|     =
266.752
	RTD|      14.497|      41.881|      96.971|       0|       1.288|     =
266.752
	RTD|      16.752|      40.592|     115.012|       0|       1.288|     =
266.752
	RTD|      22.229|      40.270|     100.515|       0|       1.288|     =
266.752
	RTD|       8.054|      39.304|     105.992|       0|       1.288|     =
266.752
	RTD|      16.108|      38.981|      93.750|       0|       1.288|     =
266.752
	RTD|       6.765|      38.015|      93.750|       0|       1.288|     =
266.752
	RTD|       5.798|      37.693|      93.750|       0|       1.288|     =
266.752
	RTD|       6.765|      36.726|      93.750|       0|       1.288|     =
266.752
	RTD|      16.108|      36.404|      93.750|       0|       1.288|     =
266.752
	RTD|      16.108|      35.438|     114.690|       0|       1.288|     =
266.752
	RTD|      19.329|      35.115|      93.750|       0|       1.288|     =
266.752
	RTD|      17.719|      34.149|      93.750|       0|       1.288|     =
266.752
	RTD|      22.551|      33.827|     113.079|       0|       1.288|     =
266.752
	RTD|      15.463|      32.860|      94.072|       0|       1.288|     =
266.752
	RTD|       5.476|      32.538|      99.871|       0|       1.288|     =
266.752
	RTD|      20.940|      31.572|      93.750|       0|       1.288|     =
266.752
	RTD|      19.652|      31.250|      93.750|       0|       1.288|     =
266.752
	RTD|      22.551|      30.927|      95.038|       0|       1.288|     =
266.752
	RTD|      14.819|      30.283|      79.252|       0|       1.288|     =
266.752
	RTD|      17.396|      92.783|     138.853|       0|       1.288|     =
266.752
	RTT|  01:06:52  (periodic user-mode task, 500 us period, priority 99)
	RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat =
worst
	RTD|       5.798|      92.461|     114.690|       0|       1.288|     =
266.752
	RTD|      16.752|      91.817|     114.690|       0|       1.288|     =
266.752
	RTD|      26.417|      91.172|      96.971|       0|       1.288|     =
266.752
	RTD|      17.074|      90.206|      99.871|       0|       1.288|     =
266.752
	RTD|      26.739|      89.884|      98.260|       0|       1.288|     =
266.752
	RTD|      15.141|      88.917|      99.226|       0|       1.288|     =
266.752
	RTD|      27.061|      88.595|      99.548|       0|       1.288|     =
266.752
	RTD|       7.087|      87.628|      98.260|       0|       1.288|     =
266.752
	RTD|      19.652|      87.306|     115.012|       0|       1.288|     =
266.752
	RTD|      13.853|      86.340|      99.226|       0|       1.288|     =
266.752
	RTD|      25.773|      86.018|     111.791|       0|       1.288|     =
266.752
	RTD|      15.141|      85.051|     101.159|       0|       1.288|     =
266.752
	RTD|       7.087|      84.729|      98.260|       0|       1.288|     =
266.752
	RTD|       9.342|      83.762|     107.603|       0|       1.288|     =
266.752
	RTD|      12.242|      83.440|      99.226|       0|       1.288|     =
266.752
	RTD|      18.041|      82.474|      98.904|       0|       1.288|     =
266.752
	RTD|      26.739|      82.474|     102.126|       0|       1.288|     =
266.752
	RTD|      15.463|      81.507|     100.193|       0|       1.288|     =
266.752
	RTD|      27.384|      81.185|      96.649|       0|       1.288|     =
266.752
	RTD|      16.430|      80.219|      98.582|       0|       1.288|     =
266.752
	RTD|      15.141|      79.896|     105.992|       0|       1.288|     =
266.752
	RTT|  01:07:13  (periodic user-mode task, 500 us period, priority 99)
	RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat =
worst
	RTD|      15.463|      78.930|     113.402|       0|       1.288|     =
266.752
	RTD|      13.208|      78.930|     114.690|       0|       1.288|     =
266.752
	RTD|      15.786|      77.641|     114.690|       0|       1.288|     =
266.752
	RTD|      15.463|      77.319|     114.690|       0|       1.288|     =
266.752
	RTD|      14.175|      76.353|     115.012|       0|       1.288|     =
266.752
	RTD|       6.121|      76.030|     100.515|       0|       1.288|     =
266.752
	RTD|       8.376|      75.064|     114.690|       0|       1.288|     =
266.752
	RTD|       8.376|      74.742|     102.126|       0|       1.288|     =
266.752
	RTD|      21.907|      73.775|     115.012|       0|       1.288|     =
266.752
	RTD|      20.296|      73.453|     114.690|       0|       1.288|     =
266.752
	RTD|      17.396|      72.487|     111.146|       0|       1.288|     =
266.752
	RTD|      21.585|      72.164|      99.226|       0|       1.288|     =
266.752
	RTD|      13.853|      71.198|     101.159|       0|       1.288|     =
266.752
	RTD|      22.873|      71.198|     114.690|       0|       1.288|     =
266.752
	RTD|      16.752|      69.909|      99.226|       0|       1.288|     =
266.752
	RTD|      20.940|      69.909|     103.414|       0|       1.288|     =
266.752
	RTD|      14.819|      68.943|      98.582|       0|       1.288|     =
266.752
	RTD|      19.329|      68.621|     114.690|       0|       1.288|     =
266.752
	RTD|       7.731|      67.654|     119.201|       0|       1.288|     =
266.752
	RTD|       6.765|      67.332|      99.226|       0|       1.288|     =
266.752
	RTD|      19.007|      66.365|      99.871|       0|       1.288|     =
266.752
	RTT|  01:07:34  (periodic user-mode task, 500 us period, priority 99)
	RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat =
worst
	RTD|      17.396|      66.043|     114.690|       0|       1.288|     =
266.752
	---|--param|----range-|--samples
	HSD|    min|   1 -  2 |        3
	HSD|    min|   2 -  3 |        2
	HSD|    min|   3 -  4 |        4
	HSD|    min|   4 -  5 |        8
	HSD|    min|   5 -  6 |       22
	HSD|    min|   6 -  7 |       28
	HSD|    min|   7 -  8 |       48
	HSD|    min|   8 -  9 |       45
	HSD|    min|   9 - 10 |       32
	HSD|    min|  10 - 11 |       15
	HSD|    min|  11 - 12 |       60
	HSD|    min|  12 - 13 |      304
	HSD|    min|  13 - 14 |      989
	HSD|    min|  14 - 15 |     1161
	HSD|    min|  15 - 16 |      732
	HSD|    min|  16 - 17 |      247
	HSD|    min|  17 - 18 |       62
	HSD|    min|  18 - 19 |       37
	HSD|    min|  19 - 20 |       75
	HSD|    min|  20 - 21 |       59
	HSD|    min|  21 - 22 |       50
	HSD|    min|  22 - 23 |       25
	HSD|    min|  23 - 24 |        7
	HSD|    min|  24 - 25 |        4
	HSD|    min|  25 - 26 |        4
	HSD|    min|  26 - 27 |       14
	HSD|    min|  27 - 28 |       13
	HSD|    min|  28 - 29 |        3
	HSD|    min|  37 - 38 |        1
	---|--param|----range-|--samples
	HSD|    avg|   1 -  2 |        3
	HSD|    avg|   2 -  3 |        2
	HSD|    avg|   3 -  4 |        5
	HSD|    avg|   4 -  5 |        8
	HSD|    avg|   5 -  6 |       24
	HSD|    avg|   6 -  7 |       30
	HSD|    avg|   7 -  8 |       51
	HSD|    avg|   8 -  9 |       48
	HSD|    avg|   9 - 10 |       34
	HSD|    avg|  10 - 11 |       15
	HSD|    avg|  11 - 12 |       60
	HSD|    avg|  12 - 13 |      309
	HSD|    avg|  13 - 14 |     1003
	HSD|    avg|  14 - 15 |     1190
	HSD|    avg|  15 - 16 |      767
	HSD|    avg|  16 - 17 |      274
	HSD|    avg|  17 - 18 |       97
	HSD|    avg|  18 - 19 |       84
	HSD|    avg|  19 - 20 |      185
	HSD|    avg|  20 - 21 |      174
	HSD|    avg|  21 - 22 |      131
	HSD|    avg|  22 - 23 |       63
	HSD|    avg|  23 - 24 |       30
	HSD|    avg|  24 - 25 |       17
	HSD|    avg|  25 - 26 |       57
	HSD|    avg|  26 - 27 |      158
	HSD|    avg|  27 - 28 |      251
	HSD|    avg|  28 - 29 |    16031
	HSD|    avg|  29 - 30 |   218351
	HSD|    avg|  30 - 31 |   249438
	HSD|    avg|  31 - 32 |   124506
	HSD|    avg|  32 - 33 |    15258
	HSD|    avg|  33 - 34 |     1933
	HSD|    avg|  34 - 35 |      517
	HSD|    avg|  35 - 36 |      535
	HSD|    avg|  36 - 37 |     1141
	HSD|    avg|  37 - 38 |    41768
	HSD|    avg|  38 - 39 |   209055
	HSD|    avg|  39 - 40 |    68506
	HSD|    avg|  40 - 41 |    10223
	HSD|    avg|  41 - 42 |     2790
	HSD|    avg|  42 - 43 |   108892
	HSD|    avg|  43 - 44 |   837545
	HSD|    avg|  44 - 45 |  3041548
	HSD|    avg|  45 - 46 |  1867219
	HSD|    avg|  46 - 47 |   518993
	HSD|    avg|  47 - 48 |    28819
	HSD|    avg|  48 - 49 |     2927
	HSD|    avg|  49 - 50 |     2619
	HSD|    avg|  50 - 51 |     5577
	HSD|    avg|  51 - 52 |     3473
	HSD|    avg|  52 - 53 |      916
	HSD|    avg|  53 - 54 |     3139
	HSD|    avg|  54 - 55 |    23005
	HSD|    avg|  55 - 56 |    20144
	HSD|    avg|  56 - 57 |     3258
	HSD|    avg|  57 - 58 |     2046
	HSD|    avg|  58 - 59 |     1255
	HSD|    avg|  59 - 60 |     1036
	HSD|    avg|  60 - 61 |      389
	HSD|    avg|  61 - 62 |      265
	HSD|    avg|  62 - 63 |      296
	HSD|    avg|  63 - 64 |      263
	HSD|    avg|  64 - 65 |      206
	HSD|    avg|  65 - 66 |      186
	HSD|    avg|  66 - 67 |      151
	HSD|    avg|  67 - 68 |      223
	HSD|    avg|  68 - 69 |      184
	HSD|    avg|  69 - 70 |      224
	HSD|    avg|  70 - 71 |      226
	HSD|    avg|  71 - 72 |      244
	HSD|    avg|  72 - 73 |      195
	HSD|    avg|  73 - 74 |      140
	HSD|    avg|  74 - 75 |       83
	HSD|    avg|  75 - 76 |      117
	HSD|    avg|  76 - 77 |      245
	HSD|    avg|  77 - 78 |      171
	HSD|    avg|  78 - 79 |      107
	HSD|    avg|  79 - 80 |       42
	HSD|    avg|  80 - 81 |       19
	HSD|    avg|  81 - 82 |        4
	HSD|    avg|  82 - 83 |        3
	HSD|    avg|  84 - 85 |        2
	HSD|    avg|  85 - 86 |        2
	HSD|    avg|  86 - 87 |        2
	HSD|    avg|  87 - 88 |        2
	HSD|    avg|  88 - 89 |        2
	HSD|    avg|  89 - 90 |       13
	HSD|    avg|  90 - 91 |       22
	HSD|    avg|  91 - 92 |     1320
	HSD|    avg|  92 - 93 |    17138
	HSD|    avg|  93 - 94 |   646881
	HSD|    avg|  94 - 95 |      701
	HSD|    avg|  95 - 96 |      193
	HSD|    avg|  96 - 97 |      339
	HSD|    avg|  97 - 98 |      252
	HSD|    avg|  98 - 99 |      445
	HSD|    avg|  99 -100 |      208
	HSD|    avg| 100 -101 |       72
	HSD|    avg| 101 -102 |       57
	HSD|    avg| 102 -103 |       36
	HSD|    avg| 103 -104 |       20
	HSD|    avg| 104 -105 |       14
	HSD|    avg| 105 -106 |       21
	HSD|    avg| 106 -107 |       12
	HSD|    avg| 107 -108 |       24
	HSD|    avg| 108 -109 |       19
	HSD|    avg| 109 -110 |       24
	HSD|    avg| 110 -111 |        7
	HSD|    avg| 111 -112 |        6
	HSD|    avg| 112 -113 |        5
	HSD|    avg| 113 -114 |       26
	HSD|    avg| 114 -115 |      141
	HSD|    avg| 115 -116 |       46
	HSD|    avg| 116 -117 |        1
	HSD|    avg| 117 -118 |        1
	HSD|    avg| 118 -119 |        1
	HSD|    avg| 119 -120 |        3
	HSD|    avg| 120 -121 |        1
	HSD|    avg| 124 -125 |        2
	HSD|    avg| 127 -128 |        1
	HSD|    avg| 129 -130 |        2
	HSD|    avg| 132 -133 |        9
	HSD|    avg| 133 -134 |        2
	HSD|    avg| 134 -135 |        7
	HSD|    avg| 135 -136 |        2
	HSD|    avg| 136 -137 |        1
	HSD|    avg| 137 -138 |        3
	HSD|    avg| 138 -139 |        9
	HSD|    avg| 139 -140 |        2
	HSD|    avg| 140 -141 |        2
	HSD|    avg| 145 -146 |        3
	HSD|    avg| 257 -258 |        1
	HSD|    avg| 258 -259 |        1
	HSD|    avg| 259 -260 |        1
	HSD|    avg| 263 -264 |        3
	HSD|    avg| 266 -267 |        2
	---|--param|----range-|--samples
	HSD|    max|  55 - 56 |        2
	HSD|    max|  56 - 57 |      213
	HSD|    max|  57 - 58 |      773
	HSD|    max|  58 - 59 |      459
	HSD|    max|  59 - 60 |      281
	HSD|    max|  60 - 61 |       87
	HSD|    max|  61 - 62 |       73
	HSD|    max|  62 - 63 |       76
	HSD|    max|  63 - 64 |       94
	HSD|    max|  64 - 65 |       92
	HSD|    max|  65 - 66 |      106
	HSD|    max|  66 - 67 |      102
	HSD|    max|  67 - 68 |      184
	HSD|    max|  68 - 69 |      160
	HSD|    max|  69 - 70 |      198
	HSD|    max|  70 - 71 |      186
	HSD|    max|  71 - 72 |      173
	HSD|    max|  72 - 73 |       90
	HSD|    max|  73 - 74 |       33
	HSD|    max|  74 - 75 |       12
	HSD|    max|  75 - 76 |        2
	HSD|    max|  76 - 77 |        1
	HSD|    max|  79 - 80 |        2
	HSD|    max|  82 - 83 |        1
	HSD|    max|  93 - 94 |       89
	HSD|    max|  94 - 95 |       33
	HSD|    max|  95 - 96 |        5
	HSD|    max|  96 - 97 |       28
	HSD|    max|  97 - 98 |       35
	HSD|    max|  98 - 99 |      117
	HSD|    max|  99 -100 |       43
	HSD|    max| 100 -101 |       15
	HSD|    max| 101 -102 |       25
	HSD|    max| 102 -103 |       22
	HSD|    max| 103 -104 |        8
	HSD|    max| 104 -105 |        6
	HSD|    max| 105 -106 |       12
	HSD|    max| 106 -107 |        6
	HSD|    max| 107 -108 |       11
	HSD|    max| 108 -109 |        5
	HSD|    max| 109 -110 |        2
	HSD|    max| 110 -111 |        3
	HSD|    max| 111 -112 |        3
	HSD|    max| 112 -113 |        1
	HSD|    max| 113 -114 |       12
	HSD|    max| 114 -115 |      110
	HSD|    max| 115 -116 |       42
	HSD|    max| 118 -119 |        1
	HSD|    max| 119 -120 |        2
	HSD|    max| 120 -121 |        1
	HSD|    max| 124 -125 |        1
	HSD|    max| 129 -130 |        1
	HSD|    max| 136 -137 |        1
	HSD|    max| 138 -139 |        2
	HSD|    max| 140 -141 |        2
	HSD|    max| 145 -146 |        2
	HSD|    max| 257 -258 |        1
	HSD|    max| 258 -259 |        1
	HSD|    max| 259 -260 |        1
	HSD|    max| 263 -264 |        3
	HSD|    max| 266 -267 |        2
	HSH|--param|--samples-|--average--|---stddev--
	HSS|    min|      4054|     14.043|      2.770
	HSS|    avg|   8109628|     47.020|     14.421
	HSS|    max|      4054|     69.079|     18.232
	=
---|------------|------------|------------|--------|---------------------=
----
	RTS|       1.288|      47.358|     266.752|       0|    =
01:07:36/01:07:36
	[1] + Segmentation fault         dd if=3D/dev/zero of=3D/dev/null
	<<< Crash here, test should run all the night >>>

	[xeno ./latency -p 500 -h -H 500 |  2.6.19arm-at91 + DD + =
latency=3D45000 -3h ]
	RTT|  03:11:49  (periodic user-mode task, 500 us period, priority 99)
	RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat =
worst
	RTD|      12.886|      41.881|      54.768|       0|       1.932|      =
96.005
	RTD|      17.719|      42.203|      53.801|       0|       1.932|      =
96.005
	RTD|      20.940|      41.881|      56.701|       0|       1.932|      =
96.005
	RTD|      19.329|      41.881|      55.734|       0|       1.932|      =
96.005
	RTD|      12.564|      41.881|      57.023|       0|       1.932|      =
96.005
	RTD|      10.953|      41.881|      56.378|       0|       1.932|      =
96.005
	RTD|      10.309|      41.881|      54.768|       0|       1.932|      =
96.005
	RTD|      10.953|      41.881|      55.412|       0|       1.932|      =
96.005
	RTD|      11.920|      41.881|      57.023|       0|       1.932|      =
96.005
	RTD|      12.242|      41.881|      57.023|       0|       1.932|      =
96.005
	RTD|      19.007|      42.203|      53.801|       0|       1.932|      =
96.005
	RTD|      11.597|      41.881|      56.378|       0|       1.932|      =
96.005
	RTD|      10.631|      41.881|      59.922|       0|       1.932|      =
96.005
	RTD|      12.242|      41.881|      58.634|       0|       1.932|      =
96.005
	RTD|      19.652|      42.203|      53.479|       0|       1.932|      =
96.005
	RTD|      17.396|      41.881|      53.801|       0|       1.932|      =
96.005
	RTD|      18.041|      41.881|      52.835|       0|       1.932|      =
96.005
	RTD|      18.041|      41.881|      53.157|       0|       1.932|      =
96.005
	RTD|      10.309|      41.881|      56.701|       0|       1.932|      =
96.005
	RTD|      20.618|      41.881|      54.123|       0|       1.932|      =
96.005
	RTD|      11.275|      41.881|      60.567|       0|       1.932|      =
96.005
	RTT|  03:12:10  (periodic user-mode task, 500 us period, priority 99)
	RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat =
worst
	RTD|      17.719|      41.881|      54.445|       0|       1.932|      =
96.005
	RTD|       5.798|      42.203|      56.056|       0|       1.932|      =
96.005
	RTD|      20.940|      41.881|      53.801|       0|       1.932|      =
96.005
	RTD|      10.953|      41.881|      54.768|       0|       1.932|      =
96.005
	RTD|       8.376|      41.881|      64.110|       0|       1.932|      =
96.005
	RTD|      20.296|      41.881|      53.157|       0|       1.932|      =
96.005
	RTD|      10.631|      41.881|      52.835|       0|       1.932|      =
96.005
	RTD|      12.242|      41.881|      56.056|       0|       1.932|      =
96.005
	RTD|      11.275|      41.881|      55.734|       0|       1.932|      =
96.005
	RTD|      11.275|      41.881|      55.412|       0|       1.932|      =
96.005
	RTD|      12.242|      41.881|      57.989|       0|       1.932|      =
96.005
	RTD|      10.953|      41.881|      55.412|       0|       1.932|      =
96.005
	RTD|      10.631|      41.881|      57.345|       0|       1.932|      =
96.005
	RTD|      19.007|      41.881|      53.157|       0|       1.932|      =
96.005
	RTD|      17.074|      41.881|      56.378|       0|       1.932|      =
96.005
	RTD|      17.396|      41.881|      53.479|       0|       1.932|      =
96.005
	RTD|      10.953|      41.881|      57.345|       0|       1.932|      =
96.005
	RTD|      10.631|      42.203|      57.989|       0|       1.932|      =
96.005
	RTD|       9.342|      41.881|      56.701|       0|       1.932|      =
96.005
	RTD|      20.940|      41.881|      57.023|       0|       1.932|      =
96.005
	RTD|      19.007|      41.881|      55.734|       0|       1.932|      =
96.005
	RTT|  03:12:31  (periodic user-mode task, 500 us period, priority 99)
	RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat =
worst
	RTD|      19.974|      42.203|      56.056|       0|       1.932|      =
96.005
	---|--param|----range-|--samples
	HSD|    min|   1 -  2 |        1
	HSD|    min|   2 -  3 |        3
	HSD|    min|   3 -  4 |       11
	HSD|    min|   4 -  5 |       16
	HSD|    min|   5 -  6 |       37
	HSD|    min|   6 -  7 |       45
	HSD|    min|   7 -  8 |       50
	HSD|    min|   8 -  9 |       59
	HSD|    min|   9 - 10 |      621
	HSD|    min|  10 - 11 |     1675
	HSD|    min|  11 - 12 |     2054
	HSD|    min|  12 - 13 |      947
	HSD|    min|  13 - 14 |      208
	HSD|    min|  14 - 15 |       47
	HSD|    min|  15 - 16 |       38
	HSD|    min|  16 - 17 |      203
	HSD|    min|  17 - 18 |      713
	HSD|    min|  18 - 19 |     1271
	HSD|    min|  19 - 20 |     1843
	HSD|    min|  20 - 21 |     1037
	HSD|    min|  21 - 22 |      516
	HSD|    min|  22 - 23 |      130
	HSD|    min|  23 - 24 |       25
	HSD|    min|  34 - 35 |        1
	---|--param|----range-|--samples
	HSD|    avg|   1 -  2 |        1
	HSD|    avg|   2 -  3 |        3
	HSD|    avg|   3 -  4 |       11
	HSD|    avg|   4 -  5 |       16
	HSD|    avg|   5 -  6 |       37
	HSD|    avg|   6 -  7 |       45
	HSD|    avg|   7 -  8 |       50
	HSD|    avg|   8 -  9 |       59
	HSD|    avg|   9 - 10 |      621
	HSD|    avg|  10 - 11 |     1678
	HSD|    avg|  11 - 12 |     2057
	HSD|    avg|  12 - 13 |      951
	HSD|    avg|  13 - 14 |      217
	HSD|    avg|  14 - 15 |       54
	HSD|    avg|  15 - 16 |       52
	HSD|    avg|  16 - 17 |      272
	HSD|    avg|  17 - 18 |      871
	HSD|    avg|  18 - 19 |     1432
	HSD|    avg|  19 - 20 |     1966
	HSD|    avg|  20 - 21 |     1089
	HSD|    avg|  21 - 22 |      569
	HSD|    avg|  22 - 23 |      214
	HSD|    avg|  23 - 24 |      472
	HSD|    avg|  24 - 25 |     2346
	HSD|    avg|  25 - 26 |     6366
	HSD|    avg|  26 - 27 |     2574
	HSD|    avg|  27 - 28 |       60
	HSD|    avg|  28 - 29 |       53
	HSD|    avg|  29 - 30 |       20
	HSD|    avg|  30 - 31 |       17
	HSD|    avg|  31 - 32 |        8
	HSD|    avg|  32 - 33 |        6
	HSD|    avg|  33 - 34 |      434
	HSD|    avg|  34 - 35 |   112904
	HSD|    avg|  35 - 36 |   327257
	HSD|    avg|  36 - 37 |   446650
	HSD|    avg|  37 - 38 |   197189
	HSD|    avg|  38 - 39 |    30651
	HSD|    avg|  39 - 40 |     3399
	HSD|    avg|  40 - 41 |   305769
	HSD|    avg|  41 - 42 |  4433185
	HSD|    avg|  42 - 43 | 13561440
	HSD|    avg|  43 - 44 |  3266430
	HSD|    avg|  44 - 45 |   181418
	HSD|    avg|  45 - 46 |      814
	HSD|    avg|  46 - 47 |     5584
	HSD|    avg|  47 - 48 |    11186
	HSD|    avg|  48 - 49 |     1606
	HSD|    avg|  49 - 50 |      522
	HSD|    avg|  50 - 51 |     2272
	HSD|    avg|  51 - 52 |    47021
	HSD|    avg|  52 - 53 |   108839
	HSD|    avg|  53 - 54 |    22091
	HSD|    avg|  54 - 55 |     2436
	HSD|    avg|  55 - 56 |     1564
	HSD|    avg|  56 - 57 |     3186
	HSD|    avg|  57 - 58 |     2187
	HSD|    avg|  58 - 59 |      468
	HSD|    avg|  59 - 60 |      447
	HSD|    avg|  60 - 61 |      328
	HSD|    avg|  61 - 62 |      301
	HSD|    avg|  62 - 63 |      217
	HSD|    avg|  63 - 64 |      200
	HSD|    avg|  64 - 65 |      204
	HSD|    avg|  65 - 66 |      138
	HSD|    avg|  66 - 67 |       87
	HSD|    avg|  67 - 68 |       88
	HSD|    avg|  68 - 69 |       62
	HSD|    avg|  69 - 70 |       24
	HSD|    avg|  70 - 71 |       25
	HSD|    avg|  71 - 72 |       19
	HSD|    avg|  72 - 73 |        8
	HSD|    avg|  73 - 74 |        4
	HSD|    avg|  76 - 77 |        3
	HSD|    avg|  77 - 78 |        1
	HSD|    avg|  78 - 79 |        1
	HSD|    avg|  80 - 81 |        2
	HSD|    avg|  81 - 82 |        3
	HSD|    avg|  82 - 83 |        2
	HSD|    avg|  83 - 84 |        2
	HSD|    avg|  85 - 86 |        1
	HSD|    avg|  88 - 89 |        1
	HSD|    avg|  91 - 92 |        1
	HSD|    avg|  93 - 94 |        1
	HSD|    avg|  95 - 96 |        2
	HSD|    avg|  96 - 97 |        1
	---|--param|----range-|--samples
	HSD|    max|  47 - 48 |        1
	HSD|    max|  52 - 53 |      277
	HSD|    max|  53 - 54 |     3050
	HSD|    max|  54 - 55 |     1299
	HSD|    max|  55 - 56 |      802
	HSD|    max|  56 - 57 |     1799
	HSD|    max|  57 - 58 |     1697
	HSD|    max|  58 - 59 |      463
	HSD|    max|  59 - 60 |      442
	HSD|    max|  60 - 61 |      328
	HSD|    max|  61 - 62 |      298
	HSD|    max|  62 - 63 |      215
	HSD|    max|  63 - 64 |      200
	HSD|    max|  64 - 65 |      204
	HSD|    max|  65 - 66 |      138
	HSD|    max|  66 - 67 |       87
	HSD|    max|  67 - 68 |       88
	HSD|    max|  68 - 69 |       62
	HSD|    max|  69 - 70 |       24
	HSD|    max|  70 - 71 |       25
	HSD|    max|  71 - 72 |       19
	HSD|    max|  72 - 73 |        8
	HSD|    max|  73 - 74 |        4
	HSD|    max|  76 - 77 |        3
	HSD|    max|  77 - 78 |        1
	HSD|    max|  78 - 79 |        1
	HSD|    max|  80 - 81 |        2
	HSD|    max|  81 - 82 |        3
	HSD|    max|  82 - 83 |        2
	HSD|    max|  83 - 84 |        2
	HSD|    max|  85 - 86 |        1
	HSD|    max|  88 - 89 |        1
	HSD|    max|  91 - 92 |        1
	HSD|    max|  93 - 94 |        1
	HSD|    max|  95 - 96 |        2
	HSD|    max|  96 - 97 |        1
	HSH|--param|--samples-|--average--|---stddev--
	HSS|    min|     11551|     14.710|      4.364
	HSS|    avg|  23102862|     41.701|      1.928
	HSS|    max|     11551|     56.256|      3.733
	=
---|------------|------------|------------|--------|---------------------=
----
	RTS|       1.932|      41.881|      96.005|       0|    =
03:12:32/03:12:32


	[xeno ./latency -p 500 -h -H 500 |  2.6.20arm + DD + latency=3D45000 =
-4h]
	TH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat =
worst
	RTD|      13.208|      37.371|     104.381|       0|      -8.054|     =
238.402
	RTD|      13.530|      36.726|     105.025|       0|      -8.054|     =
238.402
	RTD|      21.262|      36.082|     105.025|       0|      -8.054|     =
238.402
	RTD|      12.564|      35.438|     105.347|       0|      -8.054|     =
238.402
	RTD|      14.497|      34.793|     113.402|       0|      -8.054|     =
238.402
	RTD|      12.564|      34.149|     103.092|       0|      -8.054|     =
238.402
	RTD|      10.309|      33.505|     105.025|       0|      -8.054|     =
238.402
	RTD|      18.041|      32.860|     104.381|       0|      -8.054|     =
238.402
	RTD|      13.208|      32.216|     105.025|       0|      -8.054|     =
238.402
	RTD|       6.121|      31.250|     104.381|       0|      -8.054|     =
238.402
	RTD|      15.141|      30.927|     105.347|       0|      -8.054|     =
238.402
	RTD|      11.597|      30.283|     104.059|       0|      -8.054|     =
238.402
	RTD|      16.108|      29.639|     105.025|       0|      -8.054|     =
238.402
	RTD|      14.819|      28.994|     106.314|       0|      -8.054|     =
238.402
	RTD|       6.443|      28.672|      72.809|       0|      -8.054|     =
238.402
	RTD|      23.518|      92.461|     135.309|       0|      -8.054|     =
238.402
	RTD|      23.518|      92.139|     104.703|       0|      -8.054|     =
238.402
	RTD|      14.175|      91.172|     113.724|       0|      -8.054|     =
238.402
	RTD|      19.652|      90.850|     114.368|       0|      -8.054|     =
238.402
	RTD|      12.564|      89.884|     114.368|       0|      -8.054|     =
238.402
	RTD|      18.041|      89.561|     114.368|       0|      -8.054|     =
238.402
	RTT|  04:19:01  (periodic user-mode task, 500 us period, priority 99)
	RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat =
worst
	RTD|      14.497|      88.595|     114.046|       0|      -8.054|     =
238.402
	RTD|      13.208|      88.595|     114.368|       0|      -8.054|     =
238.402
	RTD|      10.631|      87.306|     114.368|       0|      -8.054|     =
238.402
	RTD|      18.363|      86.984|     114.368|       0|      -8.054|     =
238.402
	RTD|      11.597|      86.018|     114.368|       0|      -8.054|     =
238.402
	RTD|       4.832|      85.695|     114.368|       0|      -8.054|     =
238.402
	RTD|      11.597|      84.729|     114.368|       0|      -8.054|     =
238.402
	RTD|      22.551|      84.407|     107.603|       0|      -8.054|     =
238.402
	RTD|      11.275|      83.440|     117.268|       0|      -8.054|     =
238.402
	RTD|      14.819|      83.118|     114.368|       0|      -8.054|     =
238.402
	RTD|      13.208|      82.152|     104.381|       0|      -8.054|     =
238.402
	RTD|      10.953|      81.829|     104.059|       0|      -8.054|     =
238.402
	RTD|      11.275|      80.863|     114.368|       0|      -8.054|     =
238.402
	RTD|      24.162|      80.541|     114.046|       0|      -8.054|     =
238.402
	RTD|      11.275|      79.574|     114.046|       0|      -8.054|     =
238.402
	RTD|      20.618|      79.252|     136.275|       0|      -8.054|     =
238.402
	RTD|      13.530|      78.286|     117.590|       0|      -8.054|     =
238.402
	RTD|       9.664|      77.963|     114.368|       0|      -8.054|     =
238.402
	RTD|       7.409|      76.997|     105.025|       0|      -8.054|     =
238.402
	RTD|      16.430|      76.675|     114.046|       0|      -8.054|     =
238.402
	RTD|      10.631|      75.708|     114.046|       0|      -8.054|     =
238.402
	RTT|  04:19:22  (periodic user-mode task, 500 us period, priority 99)
	RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat =
worst
	RTD|      14.175|      75.386|     105.025|       0|      -8.054|     =
238.402
	RTD|       9.020|      74.742|     104.381|       0|      -8.054|     =
238.402
	RTD|      13.530|      74.097|     104.381|       0|      -8.054|     =
238.402
	RTD|      10.631|      73.131|     114.046|       0|      -8.054|     =
238.402
	RTD|      15.463|      72.809|     104.059|       0|      -8.054|     =
238.402
	RTD|       9.020|      71.842|     103.737|       0|      -8.054|     =
238.402
	RTD|      20.296|      71.520|     109.213|       0|      -8.054|     =
238.402
	RTD|       6.443|      70.554|     114.368|       0|      -8.054|     =
238.402
	RTD|      18.685|      70.231|     105.025|       0|      -8.054|     =
238.402
	RTD|       8.376|      69.265|     113.724|       0|      -8.054|     =
238.402
	RTD|      19.974|      68.943|     114.368|       0|      -8.054|     =
238.402
	RTD|      13.208|      68.298|     114.368|       0|      -8.054|     =
238.402
	RTD|      17.719|      67.654|     114.368|       0|      -8.054|     =
238.402
	RTD|      13.208|      66.688|     114.046|       0|      -8.054|     =
238.402
	RTD|      15.141|      66.365|     105.992|       0|      -8.054|     =
238.402
	RTD|       7.409|      65.399|     114.046|       0|      -8.054|     =
238.402
	RTD|      15.141|      65.077|     117.590|       0|      -8.054|     =
238.402
	RTD|      11.597|      64.110|     114.046|       0|      -8.054|     =
238.402
	RTD|      19.974|      63.788|     114.368|       0|      -8.054|     =
238.402
	RTD|       8.054|      63.144|     114.368|       0|      -8.054|     =
238.402
	<<< Crash here, test should run all the night >>>



------_=_NextPart_001_01C7A9CB.71968B58
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Diso-8859-1">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
6.5.7650.28">
<TITLE>adeos-ipipe-2.6.20-arm-1.7-03.patch return high latencies =
...</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/rtf format -->
<UL>
<P><FONT SIZE=3D2 FACE=3D"Arial">I missed something : title was wrong. =
My apologies.</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">Gilles asked for some people to test =
adeos-ipipe-2.6.20-arm-1.7-03.patch. As we said, our board are always =
ready to receive new releases.</FONT></P>

<P><FONT SIZE=3D2 FACE=3D"Arial">Once 2.6.20 kernel unpacked, I've =
started patching it with Xenomai, including last release of Adeos patch. =
I've kept last releases of our libs cause nothing seems block us to use =
them with a new kernel. Our Buildroot is using glibc and kernel has no =
debug traces.</FONT></P>

<P><FONT SIZE=3D2 FACE=3D"Arial">Then I setup latencies to 45=B5s, =
launched a dd load and latency. But we are expecting higher latencies =
(over 200s), and system crash then. No trace, the only thing we can do =
is to reboot the system.&nbsp; Are you other expecting such results with =
your boards ?</FONT></P>

<P><FONT SIZE=3D2 FACE=3D"Arial">I've seen that some people get some =
troubles with 2.6.20 with their data transfer, like with dd load, even =
on x86. Is it a common behaviour with 2.6.20 ?</FONT></P>

<P><FONT SIZE=3D2 FACE=3D"Arial">Here is 2 test with 2.6.20 and one with =
2.6.19 to compare : </FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">[xeno ./latency -p 500 -h -H 500 =
|&nbsp; 2.6.20arm + DD + latency=3D45000 - 1h]</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">RTH|-----lat min|-----lat avg|-----lat =
max|-overrun|----lat best|---lat worst</FONT>

<BR><FONT SIZE=3D2 =
FACE=3D"Arial">RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
7.087|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
55.412|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
93.750|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1.288|&nbsp;&nbsp;&nbsp;&nbsp; =
266.752</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
15.141|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
54.445|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
98.260|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1.288|&nbsp;&nbsp;&nbsp;&nbsp; =
266.752</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
19.652|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
54.123|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
94.072|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1.288|&nbsp;&nbsp;&nbsp;&nbsp; =
266.752</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
15.141|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
53.157|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
98.582|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1.288|&nbsp;&nbsp;&nbsp;&nbsp; =
266.752</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
17.719|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
52.835|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
98.260|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1.288|&nbsp;&nbsp;&nbsp;&nbsp; =
266.752</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
16.752|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 51.868|&nbsp;&nbsp;&nbsp;&nbsp; =
113.402|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1.288|&nbsp;&nbsp;&nbsp;&nbsp; =
266.752</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
19.974|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 51.546|&nbsp;&nbsp;&nbsp;&nbsp; =
105.670|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1.288|&nbsp;&nbsp;&nbsp;&nbsp; =
266.752</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
14.819|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
50.579|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
97.615|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1.288|&nbsp;&nbsp;&nbsp;&nbsp; =
266.752</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
19.652|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
50.257|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
99.226|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1.288|&nbsp;&nbsp;&nbsp;&nbsp; =
266.752</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
16.108|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 49.291|&nbsp;&nbsp;&nbsp;&nbsp; =
113.079|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1.288|&nbsp;&nbsp;&nbsp;&nbsp; =
266.752</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
19.329|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
48.969|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
96.649|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1.288|&nbsp;&nbsp;&nbsp;&nbsp; =
266.752</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
13.853|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 48.002|&nbsp;&nbsp;&nbsp;&nbsp; =
108.891|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1.288|&nbsp;&nbsp;&nbsp;&nbsp; =
266.752</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
21.585|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 48.002|&nbsp;&nbsp;&nbsp;&nbsp; =
115.012|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1.288|&nbsp;&nbsp;&nbsp;&nbsp; =
266.752</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
17.074|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
46.713|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
98.582|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1.288|&nbsp;&nbsp;&nbsp;&nbsp; =
266.752</FONT>

<BR><FONT SIZE=3D2 =
FACE=3D"Arial">RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
7.087|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 46.391|&nbsp;&nbsp;&nbsp;&nbsp; =
109.536|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1.288|&nbsp;&nbsp;&nbsp;&nbsp; =
266.752</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
14.497|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 45.425|&nbsp;&nbsp;&nbsp;&nbsp; =
102.448|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1.288|&nbsp;&nbsp;&nbsp;&nbsp; =
266.752</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
21.907|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
45.103|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
93.750|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1.288|&nbsp;&nbsp;&nbsp;&nbsp; =
266.752</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
16.108|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
44.136|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
97.615|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1.288|&nbsp;&nbsp;&nbsp;&nbsp; =
266.752</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
21.907|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
44.136|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
93.750|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1.288|&nbsp;&nbsp;&nbsp;&nbsp; =
266.752</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
17.074|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 43.170|&nbsp;&nbsp;&nbsp;&nbsp; =
114.690|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1.288|&nbsp;&nbsp;&nbsp;&nbsp; =
266.752</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
19.974|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
42.847|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
98.260|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1.288|&nbsp;&nbsp;&nbsp;&nbsp; =
266.752</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">RTT|&nbsp; 01:06:31&nbsp; (periodic =
user-mode task, 500 us period, priority 99)</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">RTH|-----lat min|-----lat avg|-----lat =
max|-overrun|----lat best|---lat worst</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
10.631|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
41.881|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
98.582|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1.288|&nbsp;&nbsp;&nbsp;&nbsp; =
266.752</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
14.497|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
41.881|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
96.971|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1.288|&nbsp;&nbsp;&nbsp;&nbsp; =
266.752</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
16.752|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 40.592|&nbsp;&nbsp;&nbsp;&nbsp; =
115.012|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1.288|&nbsp;&nbsp;&nbsp;&nbsp; =
266.752</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
22.229|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 40.270|&nbsp;&nbsp;&nbsp;&nbsp; =
100.515|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1.288|&nbsp;&nbsp;&nbsp;&nbsp; =
266.752</FONT>

<BR><FONT SIZE=3D2 =
FACE=3D"Arial">RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
8.054|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 39.304|&nbsp;&nbsp;&nbsp;&nbsp; =
105.992|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1.288|&nbsp;&nbsp;&nbsp;&nbsp; =
266.752</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
16.108|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
38.981|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
93.750|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1.288|&nbsp;&nbsp;&nbsp;&nbsp; =
266.752</FONT>

<BR><FONT SIZE=3D2 =
FACE=3D"Arial">RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
6.765|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
38.015|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
93.750|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1.288|&nbsp;&nbsp;&nbsp;&nbsp; =
266.752</FONT>

<BR><FONT SIZE=3D2 =
FACE=3D"Arial">RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
5.798|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
37.693|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
93.750|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1.288|&nbsp;&nbsp;&nbsp;&nbsp; =
266.752</FONT>

<BR><FONT SIZE=3D2 =
FACE=3D"Arial">RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
6.765|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
36.726|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
93.750|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1.288|&nbsp;&nbsp;&nbsp;&nbsp; =
266.752</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
16.108|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
36.404|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
93.750|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1.288|&nbsp;&nbsp;&nbsp;&nbsp; =
266.752</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
16.108|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 35.438|&nbsp;&nbsp;&nbsp;&nbsp; =
114.690|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1.288|&nbsp;&nbsp;&nbsp;&nbsp; =
266.752</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
19.329|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
35.115|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
93.750|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1.288|&nbsp;&nbsp;&nbsp;&nbsp; =
266.752</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
17.719|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
34.149|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
93.750|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1.288|&nbsp;&nbsp;&nbsp;&nbsp; =
266.752</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
22.551|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 33.827|&nbsp;&nbsp;&nbsp;&nbsp; =
113.079|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1.288|&nbsp;&nbsp;&nbsp;&nbsp; =
266.752</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
15.463|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
32.860|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
94.072|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1.288|&nbsp;&nbsp;&nbsp;&nbsp; =
266.752</FONT>

<BR><FONT SIZE=3D2 =
FACE=3D"Arial">RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
5.476|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
32.538|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
99.871|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1.288|&nbsp;&nbsp;&nbsp;&nbsp; =
266.752</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
20.940|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
31.572|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
93.750|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1.288|&nbsp;&nbsp;&nbsp;&nbsp; =
266.752</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
19.652|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
31.250|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
93.750|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1.288|&nbsp;&nbsp;&nbsp;&nbsp; =
266.752</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
22.551|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
30.927|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
95.038|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1.288|&nbsp;&nbsp;&nbsp;&nbsp; =
266.752</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
14.819|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
30.283|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
79.252|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1.288|&nbsp;&nbsp;&nbsp;&nbsp; =
266.752</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
17.396|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 92.783|&nbsp;&nbsp;&nbsp;&nbsp; =
138.853|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1.288|&nbsp;&nbsp;&nbsp;&nbsp; =
266.752</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">RTT|&nbsp; 01:06:52&nbsp; (periodic =
user-mode task, 500 us period, priority 99)</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">RTH|-----lat min|-----lat avg|-----lat =
max|-overrun|----lat best|---lat worst</FONT>

<BR><FONT SIZE=3D2 =
FACE=3D"Arial">RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
5.798|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 92.461|&nbsp;&nbsp;&nbsp;&nbsp; =
114.690|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1.288|&nbsp;&nbsp;&nbsp;&nbsp; =
266.752</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
16.752|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 91.817|&nbsp;&nbsp;&nbsp;&nbsp; =
114.690|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1.288|&nbsp;&nbsp;&nbsp;&nbsp; =
266.752</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
26.417|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
91.172|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
96.971|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1.288|&nbsp;&nbsp;&nbsp;&nbsp; =
266.752</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
17.074|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
90.206|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
99.871|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1.288|&nbsp;&nbsp;&nbsp;&nbsp; =
266.752</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
26.739|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
89.884|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
98.260|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1.288|&nbsp;&nbsp;&nbsp;&nbsp; =
266.752</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
15.141|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
88.917|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
99.226|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1.288|&nbsp;&nbsp;&nbsp;&nbsp; =
266.752</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
27.061|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
88.595|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
99.548|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1.288|&nbsp;&nbsp;&nbsp;&nbsp; =
266.752</FONT>

<BR><FONT SIZE=3D2 =
FACE=3D"Arial">RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
7.087|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
87.628|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
98.260|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1.288|&nbsp;&nbsp;&nbsp;&nbsp; =
266.752</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
19.652|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 87.306|&nbsp;&nbsp;&nbsp;&nbsp; =
115.012|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1.288|&nbsp;&nbsp;&nbsp;&nbsp; =
266.752</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
13.853|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
86.340|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
99.226|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1.288|&nbsp;&nbsp;&nbsp;&nbsp; =
266.752</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
25.773|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 86.018|&nbsp;&nbsp;&nbsp;&nbsp; =
111.791|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1.288|&nbsp;&nbsp;&nbsp;&nbsp; =
266.752</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
15.141|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 85.051|&nbsp;&nbsp;&nbsp;&nbsp; =
101.159|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1.288|&nbsp;&nbsp;&nbsp;&nbsp; =
266.752</FONT>

<BR><FONT SIZE=3D2 =
FACE=3D"Arial">RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
7.087|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
84.729|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
98.260|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1.288|&nbsp;&nbsp;&nbsp;&nbsp; =
266.752</FONT>

<BR><FONT SIZE=3D2 =
FACE=3D"Arial">RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
9.342|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 83.762|&nbsp;&nbsp;&nbsp;&nbsp; =
107.603|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1.288|&nbsp;&nbsp;&nbsp;&nbsp; =
266.752</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
12.242|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
83.440|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
99.226|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1.288|&nbsp;&nbsp;&nbsp;&nbsp; =
266.752</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
18.041|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
82.474|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
98.904|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1.288|&nbsp;&nbsp;&nbsp;&nbsp; =
266.752</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
26.739|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 82.474|&nbsp;&nbsp;&nbsp;&nbsp; =
102.126|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1.288|&nbsp;&nbsp;&nbsp;&nbsp; =
266.752</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
15.463|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 81.507|&nbsp;&nbsp;&nbsp;&nbsp; =
100.193|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1.288|&nbsp;&nbsp;&nbsp;&nbsp; =
266.752</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
27.384|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
81.185|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
96.649|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1.288|&nbsp;&nbsp;&nbsp;&nbsp; =
266.752</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
16.430|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
80.219|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
98.582|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1.288|&nbsp;&nbsp;&nbsp;&nbsp; =
266.752</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
15.141|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 79.896|&nbsp;&nbsp;&nbsp;&nbsp; =
105.992|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1.288|&nbsp;&nbsp;&nbsp;&nbsp; =
266.752</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">RTT|&nbsp; 01:07:13&nbsp; (periodic =
user-mode task, 500 us period, priority 99)</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">RTH|-----lat min|-----lat avg|-----lat =
max|-overrun|----lat best|---lat worst</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
15.463|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 78.930|&nbsp;&nbsp;&nbsp;&nbsp; =
113.402|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1.288|&nbsp;&nbsp;&nbsp;&nbsp; =
266.752</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
13.208|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 78.930|&nbsp;&nbsp;&nbsp;&nbsp; =
114.690|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1.288|&nbsp;&nbsp;&nbsp;&nbsp; =
266.752</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
15.786|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 77.641|&nbsp;&nbsp;&nbsp;&nbsp; =
114.690|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1.288|&nbsp;&nbsp;&nbsp;&nbsp; =
266.752</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
15.463|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 77.319|&nbsp;&nbsp;&nbsp;&nbsp; =
114.690|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1.288|&nbsp;&nbsp;&nbsp;&nbsp; =
266.752</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
14.175|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 76.353|&nbsp;&nbsp;&nbsp;&nbsp; =
115.012|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1.288|&nbsp;&nbsp;&nbsp;&nbsp; =
266.752</FONT>

<BR><FONT SIZE=3D2 =
FACE=3D"Arial">RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
6.121|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 76.030|&nbsp;&nbsp;&nbsp;&nbsp; =
100.515|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1.288|&nbsp;&nbsp;&nbsp;&nbsp; =
266.752</FONT>

<BR><FONT SIZE=3D2 =
FACE=3D"Arial">RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
8.376|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 75.064|&nbsp;&nbsp;&nbsp;&nbsp; =
114.690|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1.288|&nbsp;&nbsp;&nbsp;&nbsp; =
266.752</FONT>

<BR><FONT SIZE=3D2 =
FACE=3D"Arial">RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
8.376|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 74.742|&nbsp;&nbsp;&nbsp;&nbsp; =
102.126|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1.288|&nbsp;&nbsp;&nbsp;&nbsp; =
266.752</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
21.907|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 73.775|&nbsp;&nbsp;&nbsp;&nbsp; =
115.012|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1.288|&nbsp;&nbsp;&nbsp;&nbsp; =
266.752</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
20.296|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 73.453|&nbsp;&nbsp;&nbsp;&nbsp; =
114.690|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1.288|&nbsp;&nbsp;&nbsp;&nbsp; =
266.752</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
17.396|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 72.487|&nbsp;&nbsp;&nbsp;&nbsp; =
111.146|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1.288|&nbsp;&nbsp;&nbsp;&nbsp; =
266.752</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
21.585|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
72.164|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
99.226|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1.288|&nbsp;&nbsp;&nbsp;&nbsp; =
266.752</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
13.853|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 71.198|&nbsp;&nbsp;&nbsp;&nbsp; =
101.159|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1.288|&nbsp;&nbsp;&nbsp;&nbsp; =
266.752</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
22.873|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 71.198|&nbsp;&nbsp;&nbsp;&nbsp; =
114.690|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1.288|&nbsp;&nbsp;&nbsp;&nbsp; =
266.752</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
16.752|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
69.909|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
99.226|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1.288|&nbsp;&nbsp;&nbsp;&nbsp; =
266.752</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
20.940|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 69.909|&nbsp;&nbsp;&nbsp;&nbsp; =
103.414|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1.288|&nbsp;&nbsp;&nbsp;&nbsp; =
266.752</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
14.819|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
68.943|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
98.582|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1.288|&nbsp;&nbsp;&nbsp;&nbsp; =
266.752</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
19.329|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 68.621|&nbsp;&nbsp;&nbsp;&nbsp; =
114.690|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1.288|&nbsp;&nbsp;&nbsp;&nbsp; =
266.752</FONT>

<BR><FONT SIZE=3D2 =
FACE=3D"Arial">RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
7.731|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 67.654|&nbsp;&nbsp;&nbsp;&nbsp; =
119.201|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1.288|&nbsp;&nbsp;&nbsp;&nbsp; =
266.752</FONT>

<BR><FONT SIZE=3D2 =
FACE=3D"Arial">RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
6.765|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
67.332|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
99.226|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1.288|&nbsp;&nbsp;&nbsp;&nbsp; =
266.752</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
19.007|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
66.365|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
99.871|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1.288|&nbsp;&nbsp;&nbsp;&nbsp; =
266.752</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">RTT|&nbsp; 01:07:34&nbsp; (periodic =
user-mode task, 500 us period, priority 99)</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">RTH|-----lat min|-----lat avg|-----lat =
max|-overrun|----lat best|---lat worst</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
17.396|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 66.043|&nbsp;&nbsp;&nbsp;&nbsp; =
114.690|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1.288|&nbsp;&nbsp;&nbsp;&nbsp; =
266.752</FONT>

<BR><FONT SIZE=3D2 =
FACE=3D"Arial">---|--param|----range-|--samples</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; =
min|&nbsp;&nbsp; 1 -&nbsp; 2 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
3</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; =
min|&nbsp;&nbsp; 2 -&nbsp; 3 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
2</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; =
min|&nbsp;&nbsp; 3 -&nbsp; 4 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
4</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; =
min|&nbsp;&nbsp; 4 -&nbsp; 5 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
8</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; =
min|&nbsp;&nbsp; 5 -&nbsp; 6 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
22</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; =
min|&nbsp;&nbsp; 6 -&nbsp; 7 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
28</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; =
min|&nbsp;&nbsp; 7 -&nbsp; 8 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
48</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; =
min|&nbsp;&nbsp; 8 -&nbsp; 9 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
45</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; =
min|&nbsp;&nbsp; 9 - 10 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 32</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; min|&nbsp; 10 - =
11 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 15</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; min|&nbsp; 11 - =
12 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 60</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; min|&nbsp; 12 - =
13 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 304</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; min|&nbsp; 13 - =
14 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 989</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; min|&nbsp; 14 - =
15 |&nbsp;&nbsp;&nbsp;&nbsp; 1161</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; min|&nbsp; 15 - =
16 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 732</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; min|&nbsp; 16 - =
17 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 247</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; min|&nbsp; 17 - =
18 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 62</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; min|&nbsp; 18 - =
19 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 37</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; min|&nbsp; 19 - =
20 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 75</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; min|&nbsp; 20 - =
21 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 59</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; min|&nbsp; 21 - =
22 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 50</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; min|&nbsp; 22 - =
23 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 25</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; min|&nbsp; 23 - =
24 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 7</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; min|&nbsp; 24 - =
25 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 4</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; min|&nbsp; 25 - =
26 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 4</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; min|&nbsp; 26 - =
27 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 14</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; min|&nbsp; 27 - =
28 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 13</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; min|&nbsp; 28 - =
29 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 3</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; min|&nbsp; 37 - =
38 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1</FONT>

<BR><FONT SIZE=3D2 =
FACE=3D"Arial">---|--param|----range-|--samples</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp;&nbsp; 1 -&nbsp; 2 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
3</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp;&nbsp; 2 -&nbsp; 3 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
2</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp;&nbsp; 3 -&nbsp; 4 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
5</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp;&nbsp; 4 -&nbsp; 5 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
8</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp;&nbsp; 5 -&nbsp; 6 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
24</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp;&nbsp; 6 -&nbsp; 7 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
30</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp;&nbsp; 7 -&nbsp; 8 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
51</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp;&nbsp; 8 -&nbsp; 9 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
48</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp;&nbsp; 9 - 10 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 34</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; avg|&nbsp; 10 - =
11 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 15</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; avg|&nbsp; 11 - =
12 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 60</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; avg|&nbsp; 12 - =
13 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 309</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; avg|&nbsp; 13 - =
14 |&nbsp;&nbsp;&nbsp;&nbsp; 1003</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; avg|&nbsp; 14 - =
15 |&nbsp;&nbsp;&nbsp;&nbsp; 1190</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; avg|&nbsp; 15 - =
16 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 767</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; avg|&nbsp; 16 - =
17 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 274</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; avg|&nbsp; 17 - =
18 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 97</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; avg|&nbsp; 18 - =
19 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 84</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; avg|&nbsp; 19 - =
20 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 185</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; avg|&nbsp; 20 - =
21 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 174</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; avg|&nbsp; 21 - =
22 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 131</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; avg|&nbsp; 22 - =
23 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 63</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; avg|&nbsp; 23 - =
24 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 30</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; avg|&nbsp; 24 - =
25 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 17</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; avg|&nbsp; 25 - =
26 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 57</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; avg|&nbsp; 26 - =
27 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 158</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; avg|&nbsp; 27 - =
28 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 251</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; avg|&nbsp; 28 - =
29 |&nbsp;&nbsp;&nbsp; 16031</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; avg|&nbsp; 29 - =
30 |&nbsp;&nbsp; 218351</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; avg|&nbsp; 30 - =
31 |&nbsp;&nbsp; 249438</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; avg|&nbsp; 31 - =
32 |&nbsp;&nbsp; 124506</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; avg|&nbsp; 32 - =
33 |&nbsp;&nbsp;&nbsp; 15258</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; avg|&nbsp; 33 - =
34 |&nbsp;&nbsp;&nbsp;&nbsp; 1933</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; avg|&nbsp; 34 - =
35 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 517</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; avg|&nbsp; 35 - =
36 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 535</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; avg|&nbsp; 36 - =
37 |&nbsp;&nbsp;&nbsp;&nbsp; 1141</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; avg|&nbsp; 37 - =
38 |&nbsp;&nbsp;&nbsp; 41768</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; avg|&nbsp; 38 - =
39 |&nbsp;&nbsp; 209055</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; avg|&nbsp; 39 - =
40 |&nbsp;&nbsp;&nbsp; 68506</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; avg|&nbsp; 40 - =
41 |&nbsp;&nbsp;&nbsp; 10223</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; avg|&nbsp; 41 - =
42 |&nbsp;&nbsp;&nbsp;&nbsp; 2790</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; avg|&nbsp; 42 - =
43 |&nbsp;&nbsp; 108892</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; avg|&nbsp; 43 - =
44 |&nbsp;&nbsp; 837545</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; avg|&nbsp; 44 - =
45 |&nbsp; 3041548</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; avg|&nbsp; 45 - =
46 |&nbsp; 1867219</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; avg|&nbsp; 46 - =
47 |&nbsp;&nbsp; 518993</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; avg|&nbsp; 47 - =
48 |&nbsp;&nbsp;&nbsp; 28819</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; avg|&nbsp; 48 - =
49 |&nbsp;&nbsp;&nbsp;&nbsp; 2927</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; avg|&nbsp; 49 - =
50 |&nbsp;&nbsp;&nbsp;&nbsp; 2619</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; avg|&nbsp; 50 - =
51 |&nbsp;&nbsp;&nbsp;&nbsp; 5577</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; avg|&nbsp; 51 - =
52 |&nbsp;&nbsp;&nbsp;&nbsp; 3473</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; avg|&nbsp; 52 - =
53 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 916</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; avg|&nbsp; 53 - =
54 |&nbsp;&nbsp;&nbsp;&nbsp; 3139</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; avg|&nbsp; 54 - =
55 |&nbsp;&nbsp;&nbsp; 23005</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; avg|&nbsp; 55 - =
56 |&nbsp;&nbsp;&nbsp; 20144</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; avg|&nbsp; 56 - =
57 |&nbsp;&nbsp;&nbsp;&nbsp; 3258</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; avg|&nbsp; 57 - =
58 |&nbsp;&nbsp;&nbsp;&nbsp; 2046</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; avg|&nbsp; 58 - =
59 |&nbsp;&nbsp;&nbsp;&nbsp; 1255</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; avg|&nbsp; 59 - =
60 |&nbsp;&nbsp;&nbsp;&nbsp; 1036</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; avg|&nbsp; 60 - =
61 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 389</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; avg|&nbsp; 61 - =
62 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 265</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; avg|&nbsp; 62 - =
63 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 296</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; avg|&nbsp; 63 - =
64 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 263</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; avg|&nbsp; 64 - =
65 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 206</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; avg|&nbsp; 65 - =
66 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 186</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; avg|&nbsp; 66 - =
67 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 151</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; avg|&nbsp; 67 - =
68 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 223</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; avg|&nbsp; 68 - =
69 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 184</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; avg|&nbsp; 69 - =
70 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 224</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; avg|&nbsp; 70 - =
71 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 226</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; avg|&nbsp; 71 - =
72 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 244</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; avg|&nbsp; 72 - =
73 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 195</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; avg|&nbsp; 73 - =
74 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 140</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; avg|&nbsp; 74 - =
75 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 83</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; avg|&nbsp; 75 - =
76 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 117</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; avg|&nbsp; 76 - =
77 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 245</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; avg|&nbsp; 77 - =
78 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 171</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; avg|&nbsp; 78 - =
79 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 107</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; avg|&nbsp; 79 - =
80 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 42</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; avg|&nbsp; 80 - =
81 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 19</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; avg|&nbsp; 81 - =
82 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 4</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; avg|&nbsp; 82 - =
83 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 3</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; avg|&nbsp; 84 - =
85 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; avg|&nbsp; 85 - =
86 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; avg|&nbsp; 86 - =
87 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; avg|&nbsp; 87 - =
88 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; avg|&nbsp; 88 - =
89 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; avg|&nbsp; 89 - =
90 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 13</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; avg|&nbsp; 90 - =
91 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 22</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; avg|&nbsp; 91 - =
92 |&nbsp;&nbsp;&nbsp;&nbsp; 1320</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; avg|&nbsp; 92 - =
93 |&nbsp;&nbsp;&nbsp; 17138</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; avg|&nbsp; 93 - =
94 |&nbsp;&nbsp; 646881</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; avg|&nbsp; 94 - =
95 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 701</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; avg|&nbsp; 95 - =
96 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 193</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; avg|&nbsp; 96 - =
97 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 339</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; avg|&nbsp; 97 - =
98 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 252</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; avg|&nbsp; 98 - =
99 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 445</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; avg|&nbsp; 99 =
-100 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 208</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; avg| 100 -101 =
|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 72</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; avg| 101 -102 =
|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 57</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; avg| 102 -103 =
|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 36</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; avg| 103 -104 =
|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 20</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; avg| 104 -105 =
|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 14</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; avg| 105 -106 =
|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 21</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; avg| 106 -107 =
|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 12</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; avg| 107 -108 =
|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 24</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; avg| 108 -109 =
|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 19</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; avg| 109 -110 =
|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 24</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; avg| 110 -111 =
|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 7</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; avg| 111 -112 =
|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 6</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; avg| 112 -113 =
|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 5</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; avg| 113 -114 =
|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 26</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; avg| 114 -115 =
|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 141</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; avg| 115 -116 =
|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 46</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; avg| 116 -117 =
|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; avg| 117 -118 =
|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; avg| 118 -119 =
|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; avg| 119 -120 =
|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 3</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; avg| 120 -121 =
|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; avg| 124 -125 =
|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; avg| 127 -128 =
|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; avg| 129 -130 =
|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; avg| 132 -133 =
|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 9</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; avg| 133 -134 =
|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; avg| 134 -135 =
|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 7</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; avg| 135 -136 =
|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; avg| 136 -137 =
|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; avg| 137 -138 =
|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 3</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; avg| 138 -139 =
|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 9</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; avg| 139 -140 =
|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; avg| 140 -141 =
|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; avg| 145 -146 =
|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 3</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; avg| 257 -258 =
|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; avg| 258 -259 =
|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; avg| 259 -260 =
|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; avg| 263 -264 =
|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 3</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; avg| 266 -267 =
|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2</FONT>

<BR><FONT SIZE=3D2 =
FACE=3D"Arial">---|--param|----range-|--samples</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; max|&nbsp; 55 - =
56 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; max|&nbsp; 56 - =
57 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 213</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; max|&nbsp; 57 - =
58 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 773</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; max|&nbsp; 58 - =
59 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 459</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; max|&nbsp; 59 - =
60 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 281</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; max|&nbsp; 60 - =
61 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 87</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; max|&nbsp; 61 - =
62 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 73</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; max|&nbsp; 62 - =
63 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 76</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; max|&nbsp; 63 - =
64 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 94</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; max|&nbsp; 64 - =
65 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 92</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; max|&nbsp; 65 - =
66 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 106</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; max|&nbsp; 66 - =
67 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 102</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; max|&nbsp; 67 - =
68 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 184</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; max|&nbsp; 68 - =
69 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 160</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; max|&nbsp; 69 - =
70 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 198</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; max|&nbsp; 70 - =
71 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 186</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; max|&nbsp; 71 - =
72 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 173</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; max|&nbsp; 72 - =
73 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 90</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; max|&nbsp; 73 - =
74 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 33</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; max|&nbsp; 74 - =
75 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 12</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; max|&nbsp; 75 - =
76 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; max|&nbsp; 76 - =
77 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; max|&nbsp; 79 - =
80 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; max|&nbsp; 82 - =
83 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; max|&nbsp; 93 - =
94 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 89</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; max|&nbsp; 94 - =
95 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 33</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; max|&nbsp; 95 - =
96 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 5</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; max|&nbsp; 96 - =
97 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 28</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; max|&nbsp; 97 - =
98 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 35</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; max|&nbsp; 98 - =
99 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 117</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; max|&nbsp; 99 =
-100 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 43</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; max| 100 -101 =
|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 15</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; max| 101 -102 =
|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 25</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; max| 102 -103 =
|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 22</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; max| 103 -104 =
|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 8</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; max| 104 -105 =
|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 6</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; max| 105 -106 =
|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 12</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; max| 106 -107 =
|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 6</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; max| 107 -108 =
|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 11</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; max| 108 -109 =
|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 5</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; max| 109 -110 =
|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; max| 110 -111 =
|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 3</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; max| 111 -112 =
|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 3</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; max| 112 -113 =
|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; max| 113 -114 =
|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 12</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; max| 114 -115 =
|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 110</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; max| 115 -116 =
|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 42</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; max| 118 -119 =
|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; max| 119 -120 =
|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; max| 120 -121 =
|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; max| 124 -125 =
|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; max| 129 -130 =
|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; max| 136 -137 =
|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; max| 138 -139 =
|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; max| 140 -141 =
|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; max| 145 -146 =
|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; max| 257 -258 =
|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; max| 258 -259 =
|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; max| 259 -260 =
|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; max| 263 -264 =
|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 3</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; max| 266 -267 =
|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2</FONT>

<BR><FONT SIZE=3D2 =
FACE=3D"Arial">HSH|--param|--samples-|--average--|---stddev--</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSS|&nbsp;&nbsp;&nbsp; =
min|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 4054|&nbsp;&nbsp;&nbsp;&nbsp; =
14.043|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2.770</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSS|&nbsp;&nbsp;&nbsp; =
avg|&nbsp;&nbsp; 8109628|&nbsp;&nbsp;&nbsp;&nbsp; =
47.020|&nbsp;&nbsp;&nbsp;&nbsp; 14.421</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSS|&nbsp;&nbsp;&nbsp; =
max|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 4054|&nbsp;&nbsp;&nbsp;&nbsp; =
69.079|&nbsp;&nbsp;&nbsp;&nbsp; 18.232</FONT>

<BR><FONT SIZE=3D2 =
FACE=3D"Arial">---|------------|------------|------------|--------|------=
-------------------</FONT>

<BR><FONT SIZE=3D2 =
FACE=3D"Arial">RTS|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
1.288|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 47.358|&nbsp;&nbsp;&nbsp;&nbsp; =
266.752|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0|&nbsp;&nbsp;&nbsp; =
01:07:36/01:07:36</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">[1] + Segmentation =
fault&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dd if=3D/dev/zero =
of=3D/dev/null</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">&lt;&lt;&lt; Crash here, test should =
run all the night &gt;&gt;&gt;</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">[xeno ./latency -p 500 -h -H 500 =
|&nbsp; 2.6.19arm-at91 + DD + latency=3D45000 -3h ]</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">RTT|&nbsp; 03:11:49&nbsp; (periodic =
user-mode task, 500 us period, priority 99)</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">RTH|-----lat min|-----lat avg|-----lat =
max|-overrun|----lat best|---lat worst</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
12.886|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
41.881|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
54.768|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
1.932|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 96.005</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
17.719|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
42.203|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
53.801|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
1.932|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 96.005</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
20.940|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
41.881|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
56.701|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
1.932|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 96.005</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
19.329|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
41.881|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
55.734|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
1.932|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 96.005</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
12.564|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
41.881|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
57.023|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
1.932|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 96.005</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
10.953|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
41.881|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
56.378|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
1.932|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 96.005</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
10.309|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
41.881|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
54.768|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
1.932|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 96.005</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
10.953|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
41.881|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
55.412|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
1.932|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 96.005</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
11.920|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
41.881|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
57.023|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
1.932|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 96.005</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
12.242|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
41.881|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
57.023|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
1.932|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 96.005</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
19.007|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
42.203|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
53.801|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
1.932|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 96.005</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
11.597|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
41.881|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
56.378|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
1.932|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 96.005</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
10.631|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
41.881|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
59.922|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
1.932|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 96.005</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
12.242|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
41.881|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
58.634|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
1.932|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 96.005</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
19.652|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
42.203|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
53.479|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
1.932|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 96.005</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
17.396|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
41.881|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
53.801|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
1.932|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 96.005</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
18.041|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
41.881|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
52.835|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
1.932|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 96.005</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
18.041|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
41.881|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
53.157|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
1.932|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 96.005</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
10.309|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
41.881|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
56.701|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
1.932|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 96.005</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
20.618|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
41.881|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
54.123|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
1.932|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 96.005</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
11.275|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
41.881|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
60.567|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
1.932|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 96.005</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">RTT|&nbsp; 03:12:10&nbsp; (periodic =
user-mode task, 500 us period, priority 99)</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">RTH|-----lat min|-----lat avg|-----lat =
max|-overrun|----lat best|---lat worst</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
17.719|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
41.881|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
54.445|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
1.932|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 96.005</FONT>

<BR><FONT SIZE=3D2 =
FACE=3D"Arial">RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
5.798|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
42.203|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
56.056|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
1.932|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 96.005</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
20.940|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
41.881|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
53.801|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
1.932|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 96.005</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
10.953|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
41.881|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
54.768|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
1.932|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 96.005</FONT>

<BR><FONT SIZE=3D2 =
FACE=3D"Arial">RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
8.376|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
41.881|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
64.110|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
1.932|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 96.005</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
20.296|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
41.881|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
53.157|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
1.932|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 96.005</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
10.631|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
41.881|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
52.835|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
1.932|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 96.005</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
12.242|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
41.881|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
56.056|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
1.932|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 96.005</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
11.275|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
41.881|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
55.734|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
1.932|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 96.005</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
11.275|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
41.881|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
55.412|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
1.932|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 96.005</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
12.242|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
41.881|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
57.989|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
1.932|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 96.005</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
10.953|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
41.881|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
55.412|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
1.932|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 96.005</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
10.631|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
41.881|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
57.345|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
1.932|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 96.005</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
19.007|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
41.881|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
53.157|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
1.932|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 96.005</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
17.074|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
41.881|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
56.378|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
1.932|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 96.005</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
17.396|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
41.881|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
53.479|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
1.932|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 96.005</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
10.953|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
41.881|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
57.345|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
1.932|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 96.005</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
10.631|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
42.203|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
57.989|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
1.932|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 96.005</FONT>

<BR><FONT SIZE=3D2 =
FACE=3D"Arial">RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
9.342|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
41.881|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
56.701|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
1.932|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 96.005</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
20.940|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
41.881|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
57.023|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
1.932|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 96.005</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
19.007|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
41.881|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
55.734|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
1.932|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 96.005</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">RTT|&nbsp; 03:12:31&nbsp; (periodic =
user-mode task, 500 us period, priority 99)</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">RTH|-----lat min|-----lat avg|-----lat =
max|-overrun|----lat best|---lat worst</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
19.974|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
42.203|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
56.056|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
1.932|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 96.005</FONT>

<BR><FONT SIZE=3D2 =
FACE=3D"Arial">---|--param|----range-|--samples</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; =
min|&nbsp;&nbsp; 1 -&nbsp; 2 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
1</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; =
min|&nbsp;&nbsp; 2 -&nbsp; 3 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
3</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; =
min|&nbsp;&nbsp; 3 -&nbsp; 4 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
11</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; =
min|&nbsp;&nbsp; 4 -&nbsp; 5 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
16</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; =
min|&nbsp;&nbsp; 5 -&nbsp; 6 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
37</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; =
min|&nbsp;&nbsp; 6 -&nbsp; 7 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
45</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; =
min|&nbsp;&nbsp; 7 -&nbsp; 8 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
50</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; =
min|&nbsp;&nbsp; 8 -&nbsp; 9 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
59</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; =
min|&nbsp;&nbsp; 9 - 10 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 621</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; min|&nbsp; 10 - =
11 |&nbsp;&nbsp;&nbsp;&nbsp; 1675</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; min|&nbsp; 11 - =
12 |&nbsp;&nbsp;&nbsp;&nbsp; 2054</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; min|&nbsp; 12 - =
13 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 947</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; min|&nbsp; 13 - =
14 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 208</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; min|&nbsp; 14 - =
15 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 47</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; min|&nbsp; 15 - =
16 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 38</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; min|&nbsp; 16 - =
17 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 203</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; min|&nbsp; 17 - =
18 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 713</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; min|&nbsp; 18 - =
19 |&nbsp;&nbsp;&nbsp;&nbsp; 1271</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; min|&nbsp; 19 - =
20 |&nbsp;&nbsp;&nbsp;&nbsp; 1843</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; min|&nbsp; 20 - =
21 |&nbsp;&nbsp;&nbsp;&nbsp; 1037</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; min|&nbsp; 21 - =
22 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 516</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; min|&nbsp; 22 - =
23 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 130</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; min|&nbsp; 23 - =
24 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 25</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; min|&nbsp; 34 - =
35 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1</FONT>

<BR><FONT SIZE=3D2 =
FACE=3D"Arial">---|--param|----range-|--samples</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp;&nbsp; 1 -&nbsp; 2 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
1</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp;&nbsp; 2 -&nbsp; 3 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
3</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp;&nbsp; 3 -&nbsp; 4 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
11</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp;&nbsp; 4 -&nbsp; 5 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
16</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp;&nbsp; 5 -&nbsp; 6 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
37</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp;&nbsp; 6 -&nbsp; 7 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
45</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp;&nbsp; 7 -&nbsp; 8 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
50</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp;&nbsp; 8 -&nbsp; 9 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
59</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp;&nbsp; 9 - 10 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 621</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; avg|&nbsp; 10 - =
11 |&nbsp;&nbsp;&nbsp;&nbsp; 1678</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; avg|&nbsp; 11 - =
12 |&nbsp;&nbsp;&nbsp;&nbsp; 2057</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; avg|&nbsp; 12 - =
13 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 951</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; avg|&nbsp; 13 - =
14 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 217</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; avg|&nbsp; 14 - =
15 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 54</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; avg|&nbsp; 15 - =
16 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 52</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; avg|&nbsp; 16 - =
17 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 272</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; avg|&nbsp; 17 - =
18 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 871</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; avg|&nbsp; 18 - =
19 |&nbsp;&nbsp;&nbsp;&nbsp; 1432</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; avg|&nbsp; 19 - =
20 |&nbsp;&nbsp;&nbsp;&nbsp; 1966</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; avg|&nbsp; 20 - =
21 |&nbsp;&nbsp;&nbsp;&nbsp; 1089</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; avg|&nbsp; 21 - =
22 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 569</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; avg|&nbsp; 22 - =
23 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 214</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; avg|&nbsp; 23 - =
24 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 472</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; avg|&nbsp; 24 - =
25 |&nbsp;&nbsp;&nbsp;&nbsp; 2346</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; avg|&nbsp; 25 - =
26 |&nbsp;&nbsp;&nbsp;&nbsp; 6366</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; avg|&nbsp; 26 - =
27 |&nbsp;&nbsp;&nbsp;&nbsp; 2574</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; avg|&nbsp; 27 - =
28 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 60</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; avg|&nbsp; 28 - =
29 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 53</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; avg|&nbsp; 29 - =
30 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 20</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; avg|&nbsp; 30 - =
31 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 17</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; avg|&nbsp; 31 - =
32 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 8</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; avg|&nbsp; 32 - =
33 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 6</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; avg|&nbsp; 33 - =
34 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 434</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; avg|&nbsp; 34 - =
35 |&nbsp;&nbsp; 112904</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; avg|&nbsp; 35 - =
36 |&nbsp;&nbsp; 327257</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; avg|&nbsp; 36 - =
37 |&nbsp;&nbsp; 446650</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; avg|&nbsp; 37 - =
38 |&nbsp;&nbsp; 197189</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; avg|&nbsp; 38 - =
39 |&nbsp;&nbsp;&nbsp; 30651</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; avg|&nbsp; 39 - =
40 |&nbsp;&nbsp;&nbsp;&nbsp; 3399</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; avg|&nbsp; 40 - =
41 |&nbsp;&nbsp; 305769</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; avg|&nbsp; 41 - =
42 |&nbsp; 4433185</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; avg|&nbsp; 42 - =
43 | 13561440</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; avg|&nbsp; 43 - =
44 |&nbsp; 3266430</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; avg|&nbsp; 44 - =
45 |&nbsp;&nbsp; 181418</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; avg|&nbsp; 45 - =
46 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 814</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; avg|&nbsp; 46 - =
47 |&nbsp;&nbsp;&nbsp;&nbsp; 5584</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; avg|&nbsp; 47 - =
48 |&nbsp;&nbsp;&nbsp; 11186</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; avg|&nbsp; 48 - =
49 |&nbsp;&nbsp;&nbsp;&nbsp; 1606</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; avg|&nbsp; 49 - =
50 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 522</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; avg|&nbsp; 50 - =
51 |&nbsp;&nbsp;&nbsp;&nbsp; 2272</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; avg|&nbsp; 51 - =
52 |&nbsp;&nbsp;&nbsp; 47021</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; avg|&nbsp; 52 - =
53 |&nbsp;&nbsp; 108839</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; avg|&nbsp; 53 - =
54 |&nbsp;&nbsp;&nbsp; 22091</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; avg|&nbsp; 54 - =
55 |&nbsp;&nbsp;&nbsp;&nbsp; 2436</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; avg|&nbsp; 55 - =
56 |&nbsp;&nbsp;&nbsp;&nbsp; 1564</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; avg|&nbsp; 56 - =
57 |&nbsp;&nbsp;&nbsp;&nbsp; 3186</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; avg|&nbsp; 57 - =
58 |&nbsp;&nbsp;&nbsp;&nbsp; 2187</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; avg|&nbsp; 58 - =
59 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 468</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; avg|&nbsp; 59 - =
60 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 447</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; avg|&nbsp; 60 - =
61 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 328</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; avg|&nbsp; 61 - =
62 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 301</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; avg|&nbsp; 62 - =
63 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 217</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; avg|&nbsp; 63 - =
64 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 200</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; avg|&nbsp; 64 - =
65 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 204</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; avg|&nbsp; 65 - =
66 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 138</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; avg|&nbsp; 66 - =
67 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 87</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; avg|&nbsp; 67 - =
68 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 88</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; avg|&nbsp; 68 - =
69 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 62</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; avg|&nbsp; 69 - =
70 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 24</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; avg|&nbsp; 70 - =
71 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 25</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; avg|&nbsp; 71 - =
72 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 19</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; avg|&nbsp; 72 - =
73 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 8</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; avg|&nbsp; 73 - =
74 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 4</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; avg|&nbsp; 76 - =
77 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 3</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; avg|&nbsp; 77 - =
78 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; avg|&nbsp; 78 - =
79 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; avg|&nbsp; 80 - =
81 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; avg|&nbsp; 81 - =
82 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 3</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; avg|&nbsp; 82 - =
83 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; avg|&nbsp; 83 - =
84 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; avg|&nbsp; 85 - =
86 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; avg|&nbsp; 88 - =
89 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; avg|&nbsp; 91 - =
92 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; avg|&nbsp; 93 - =
94 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; avg|&nbsp; 95 - =
96 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; avg|&nbsp; 96 - =
97 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1</FONT>

<BR><FONT SIZE=3D2 =
FACE=3D"Arial">---|--param|----range-|--samples</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; max|&nbsp; 47 - =
48 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; max|&nbsp; 52 - =
53 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 277</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; max|&nbsp; 53 - =
54 |&nbsp;&nbsp;&nbsp;&nbsp; 3050</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; max|&nbsp; 54 - =
55 |&nbsp;&nbsp;&nbsp;&nbsp; 1299</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; max|&nbsp; 55 - =
56 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 802</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; max|&nbsp; 56 - =
57 |&nbsp;&nbsp;&nbsp;&nbsp; 1799</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; max|&nbsp; 57 - =
58 |&nbsp;&nbsp;&nbsp;&nbsp; 1697</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; max|&nbsp; 58 - =
59 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 463</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; max|&nbsp; 59 - =
60 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 442</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; max|&nbsp; 60 - =
61 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 328</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; max|&nbsp; 61 - =
62 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 298</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; max|&nbsp; 62 - =
63 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 215</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; max|&nbsp; 63 - =
64 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 200</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; max|&nbsp; 64 - =
65 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 204</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; max|&nbsp; 65 - =
66 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 138</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; max|&nbsp; 66 - =
67 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 87</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; max|&nbsp; 67 - =
68 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 88</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; max|&nbsp; 68 - =
69 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 62</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; max|&nbsp; 69 - =
70 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 24</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; max|&nbsp; 70 - =
71 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 25</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; max|&nbsp; 71 - =
72 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 19</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; max|&nbsp; 72 - =
73 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 8</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; max|&nbsp; 73 - =
74 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 4</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; max|&nbsp; 76 - =
77 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 3</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; max|&nbsp; 77 - =
78 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; max|&nbsp; 78 - =
79 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; max|&nbsp; 80 - =
81 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; max|&nbsp; 81 - =
82 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 3</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; max|&nbsp; 82 - =
83 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; max|&nbsp; 83 - =
84 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; max|&nbsp; 85 - =
86 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; max|&nbsp; 88 - =
89 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; max|&nbsp; 91 - =
92 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; max|&nbsp; 93 - =
94 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; max|&nbsp; 95 - =
96 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSD|&nbsp;&nbsp;&nbsp; max|&nbsp; 96 - =
97 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1</FONT>

<BR><FONT SIZE=3D2 =
FACE=3D"Arial">HSH|--param|--samples-|--average--|---stddev--</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSS|&nbsp;&nbsp;&nbsp; =
min|&nbsp;&nbsp;&nbsp;&nbsp; 11551|&nbsp;&nbsp;&nbsp;&nbsp; =
14.710|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 4.364</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSS|&nbsp;&nbsp;&nbsp; avg|&nbsp; =
23102862|&nbsp;&nbsp;&nbsp;&nbsp; 41.701|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
1.928</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">HSS|&nbsp;&nbsp;&nbsp; =
max|&nbsp;&nbsp;&nbsp;&nbsp; 11551|&nbsp;&nbsp;&nbsp;&nbsp; =
56.256|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 3.733</FONT>

<BR><FONT SIZE=3D2 =
FACE=3D"Arial">---|------------|------------|------------|--------|------=
-------------------</FONT>

<BR><FONT SIZE=3D2 =
FACE=3D"Arial">RTS|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
1.932|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
41.881|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
96.005|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0|&nbsp;&nbsp;&nbsp; =
03:12:32/03:12:32</FONT>
</P>
<BR>

<P><FONT SIZE=3D2 FACE=3D"Arial">[xeno ./latency -p 500 -h -H 500 =
|&nbsp; 2.6.20arm + DD + latency=3D45000 -4h]</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">TH|-----lat min|-----lat avg|-----lat =
max|-overrun|----lat best|---lat worst</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
13.208|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 37.371|&nbsp;&nbsp;&nbsp;&nbsp; =
104.381|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -8.054|&nbsp;&nbsp;&nbsp;&nbsp; =
238.402</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
13.530|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 36.726|&nbsp;&nbsp;&nbsp;&nbsp; =
105.025|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -8.054|&nbsp;&nbsp;&nbsp;&nbsp; =
238.402</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
21.262|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 36.082|&nbsp;&nbsp;&nbsp;&nbsp; =
105.025|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -8.054|&nbsp;&nbsp;&nbsp;&nbsp; =
238.402</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
12.564|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 35.438|&nbsp;&nbsp;&nbsp;&nbsp; =
105.347|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -8.054|&nbsp;&nbsp;&nbsp;&nbsp; =
238.402</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
14.497|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 34.793|&nbsp;&nbsp;&nbsp;&nbsp; =
113.402|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -8.054|&nbsp;&nbsp;&nbsp;&nbsp; =
238.402</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
12.564|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 34.149|&nbsp;&nbsp;&nbsp;&nbsp; =
103.092|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -8.054|&nbsp;&nbsp;&nbsp;&nbsp; =
238.402</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
10.309|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 33.505|&nbsp;&nbsp;&nbsp;&nbsp; =
105.025|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -8.054|&nbsp;&nbsp;&nbsp;&nbsp; =
238.402</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
18.041|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 32.860|&nbsp;&nbsp;&nbsp;&nbsp; =
104.381|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -8.054|&nbsp;&nbsp;&nbsp;&nbsp; =
238.402</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
13.208|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 32.216|&nbsp;&nbsp;&nbsp;&nbsp; =
105.025|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -8.054|&nbsp;&nbsp;&nbsp;&nbsp; =
238.402</FONT>

<BR><FONT SIZE=3D2 =
FACE=3D"Arial">RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
6.121|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 31.250|&nbsp;&nbsp;&nbsp;&nbsp; =
104.381|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -8.054|&nbsp;&nbsp;&nbsp;&nbsp; =
238.402</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
15.141|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 30.927|&nbsp;&nbsp;&nbsp;&nbsp; =
105.347|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -8.054|&nbsp;&nbsp;&nbsp;&nbsp; =
238.402</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
11.597|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 30.283|&nbsp;&nbsp;&nbsp;&nbsp; =
104.059|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -8.054|&nbsp;&nbsp;&nbsp;&nbsp; =
238.402</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
16.108|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 29.639|&nbsp;&nbsp;&nbsp;&nbsp; =
105.025|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -8.054|&nbsp;&nbsp;&nbsp;&nbsp; =
238.402</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
14.819|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 28.994|&nbsp;&nbsp;&nbsp;&nbsp; =
106.314|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -8.054|&nbsp;&nbsp;&nbsp;&nbsp; =
238.402</FONT>

<BR><FONT SIZE=3D2 =
FACE=3D"Arial">RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
6.443|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
28.672|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
72.809|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -8.054|&nbsp;&nbsp;&nbsp;&nbsp; =
238.402</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
23.518|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 92.461|&nbsp;&nbsp;&nbsp;&nbsp; =
135.309|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -8.054|&nbsp;&nbsp;&nbsp;&nbsp; =
238.402</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
23.518|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 92.139|&nbsp;&nbsp;&nbsp;&nbsp; =
104.703|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -8.054|&nbsp;&nbsp;&nbsp;&nbsp; =
238.402</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
14.175|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 91.172|&nbsp;&nbsp;&nbsp;&nbsp; =
113.724|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -8.054|&nbsp;&nbsp;&nbsp;&nbsp; =
238.402</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
19.652|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 90.850|&nbsp;&nbsp;&nbsp;&nbsp; =
114.368|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -8.054|&nbsp;&nbsp;&nbsp;&nbsp; =
238.402</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
12.564|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 89.884|&nbsp;&nbsp;&nbsp;&nbsp; =
114.368|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -8.054|&nbsp;&nbsp;&nbsp;&nbsp; =
238.402</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
18.041|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 89.561|&nbsp;&nbsp;&nbsp;&nbsp; =
114.368|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -8.054|&nbsp;&nbsp;&nbsp;&nbsp; =
238.402</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">RTT|&nbsp; 04:19:01&nbsp; (periodic =
user-mode task, 500 us period, priority 99)</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">RTH|-----lat min|-----lat avg|-----lat =
max|-overrun|----lat best|---lat worst</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
14.497|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 88.595|&nbsp;&nbsp;&nbsp;&nbsp; =
114.046|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -8.054|&nbsp;&nbsp;&nbsp;&nbsp; =
238.402</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
13.208|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 88.595|&nbsp;&nbsp;&nbsp;&nbsp; =
114.368|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -8.054|&nbsp;&nbsp;&nbsp;&nbsp; =
238.402</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
10.631|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 87.306|&nbsp;&nbsp;&nbsp;&nbsp; =
114.368|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -8.054|&nbsp;&nbsp;&nbsp;&nbsp; =
238.402</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
18.363|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 86.984|&nbsp;&nbsp;&nbsp;&nbsp; =
114.368|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -8.054|&nbsp;&nbsp;&nbsp;&nbsp; =
238.402</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
11.597|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 86.018|&nbsp;&nbsp;&nbsp;&nbsp; =
114.368|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -8.054|&nbsp;&nbsp;&nbsp;&nbsp; =
238.402</FONT>

<BR><FONT SIZE=3D2 =
FACE=3D"Arial">RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
4.832|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 85.695|&nbsp;&nbsp;&nbsp;&nbsp; =
114.368|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -8.054|&nbsp;&nbsp;&nbsp;&nbsp; =
238.402</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
11.597|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 84.729|&nbsp;&nbsp;&nbsp;&nbsp; =
114.368|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -8.054|&nbsp;&nbsp;&nbsp;&nbsp; =
238.402</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
22.551|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 84.407|&nbsp;&nbsp;&nbsp;&nbsp; =
107.603|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -8.054|&nbsp;&nbsp;&nbsp;&nbsp; =
238.402</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
11.275|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 83.440|&nbsp;&nbsp;&nbsp;&nbsp; =
117.268|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -8.054|&nbsp;&nbsp;&nbsp;&nbsp; =
238.402</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
14.819|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 83.118|&nbsp;&nbsp;&nbsp;&nbsp; =
114.368|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -8.054|&nbsp;&nbsp;&nbsp;&nbsp; =
238.402</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
13.208|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 82.152|&nbsp;&nbsp;&nbsp;&nbsp; =
104.381|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -8.054|&nbsp;&nbsp;&nbsp;&nbsp; =
238.402</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
10.953|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 81.829|&nbsp;&nbsp;&nbsp;&nbsp; =
104.059|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -8.054|&nbsp;&nbsp;&nbsp;&nbsp; =
238.402</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
11.275|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 80.863|&nbsp;&nbsp;&nbsp;&nbsp; =
114.368|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -8.054|&nbsp;&nbsp;&nbsp;&nbsp; =
238.402</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
24.162|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 80.541|&nbsp;&nbsp;&nbsp;&nbsp; =
114.046|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -8.054|&nbsp;&nbsp;&nbsp;&nbsp; =
238.402</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
11.275|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 79.574|&nbsp;&nbsp;&nbsp;&nbsp; =
114.046|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -8.054|&nbsp;&nbsp;&nbsp;&nbsp; =
238.402</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
20.618|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 79.252|&nbsp;&nbsp;&nbsp;&nbsp; =
136.275|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -8.054|&nbsp;&nbsp;&nbsp;&nbsp; =
238.402</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
13.530|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 78.286|&nbsp;&nbsp;&nbsp;&nbsp; =
117.590|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -8.054|&nbsp;&nbsp;&nbsp;&nbsp; =
238.402</FONT>

<BR><FONT SIZE=3D2 =
FACE=3D"Arial">RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
9.664|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 77.963|&nbsp;&nbsp;&nbsp;&nbsp; =
114.368|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -8.054|&nbsp;&nbsp;&nbsp;&nbsp; =
238.402</FONT>

<BR><FONT SIZE=3D2 =
FACE=3D"Arial">RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
7.409|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 76.997|&nbsp;&nbsp;&nbsp;&nbsp; =
105.025|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -8.054|&nbsp;&nbsp;&nbsp;&nbsp; =
238.402</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
16.430|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 76.675|&nbsp;&nbsp;&nbsp;&nbsp; =
114.046|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -8.054|&nbsp;&nbsp;&nbsp;&nbsp; =
238.402</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
10.631|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 75.708|&nbsp;&nbsp;&nbsp;&nbsp; =
114.046|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -8.054|&nbsp;&nbsp;&nbsp;&nbsp; =
238.402</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">RTT|&nbsp; 04:19:22&nbsp; (periodic =
user-mode task, 500 us period, priority 99)</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">RTH|-----lat min|-----lat avg|-----lat =
max|-overrun|----lat best|---lat worst</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
14.175|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 75.386|&nbsp;&nbsp;&nbsp;&nbsp; =
105.025|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -8.054|&nbsp;&nbsp;&nbsp;&nbsp; =
238.402</FONT>

<BR><FONT SIZE=3D2 =
FACE=3D"Arial">RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
9.020|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 74.742|&nbsp;&nbsp;&nbsp;&nbsp; =
104.381|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -8.054|&nbsp;&nbsp;&nbsp;&nbsp; =
238.402</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
13.530|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 74.097|&nbsp;&nbsp;&nbsp;&nbsp; =
104.381|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -8.054|&nbsp;&nbsp;&nbsp;&nbsp; =
238.402</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
10.631|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 73.131|&nbsp;&nbsp;&nbsp;&nbsp; =
114.046|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -8.054|&nbsp;&nbsp;&nbsp;&nbsp; =
238.402</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
15.463|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 72.809|&nbsp;&nbsp;&nbsp;&nbsp; =
104.059|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -8.054|&nbsp;&nbsp;&nbsp;&nbsp; =
238.402</FONT>

<BR><FONT SIZE=3D2 =
FACE=3D"Arial">RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
9.020|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 71.842|&nbsp;&nbsp;&nbsp;&nbsp; =
103.737|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -8.054|&nbsp;&nbsp;&nbsp;&nbsp; =
238.402</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
20.296|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 71.520|&nbsp;&nbsp;&nbsp;&nbsp; =
109.213|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -8.054|&nbsp;&nbsp;&nbsp;&nbsp; =
238.402</FONT>

<BR><FONT SIZE=3D2 =
FACE=3D"Arial">RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
6.443|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 70.554|&nbsp;&nbsp;&nbsp;&nbsp; =
114.368|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -8.054|&nbsp;&nbsp;&nbsp;&nbsp; =
238.402</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
18.685|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 70.231|&nbsp;&nbsp;&nbsp;&nbsp; =
105.025|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -8.054|&nbsp;&nbsp;&nbsp;&nbsp; =
238.402</FONT>

<BR><FONT SIZE=3D2 =
FACE=3D"Arial">RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
8.376|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 69.265|&nbsp;&nbsp;&nbsp;&nbsp; =
113.724|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -8.054|&nbsp;&nbsp;&nbsp;&nbsp; =
238.402</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
19.974|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 68.943|&nbsp;&nbsp;&nbsp;&nbsp; =
114.368|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -8.054|&nbsp;&nbsp;&nbsp;&nbsp; =
238.402</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
13.208|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 68.298|&nbsp;&nbsp;&nbsp;&nbsp; =
114.368|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -8.054|&nbsp;&nbsp;&nbsp;&nbsp; =
238.402</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
17.719|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 67.654|&nbsp;&nbsp;&nbsp;&nbsp; =
114.368|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -8.054|&nbsp;&nbsp;&nbsp;&nbsp; =
238.402</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
13.208|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 66.688|&nbsp;&nbsp;&nbsp;&nbsp; =
114.046|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -8.054|&nbsp;&nbsp;&nbsp;&nbsp; =
238.402</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
15.141|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 66.365|&nbsp;&nbsp;&nbsp;&nbsp; =
105.992|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -8.054|&nbsp;&nbsp;&nbsp;&nbsp; =
238.402</FONT>

<BR><FONT SIZE=3D2 =
FACE=3D"Arial">RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
7.409|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 65.399|&nbsp;&nbsp;&nbsp;&nbsp; =
114.046|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -8.054|&nbsp;&nbsp;&nbsp;&nbsp; =
238.402</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
15.141|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 65.077|&nbsp;&nbsp;&nbsp;&nbsp; =
117.590|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -8.054|&nbsp;&nbsp;&nbsp;&nbsp; =
238.402</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
11.597|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 64.110|&nbsp;&nbsp;&nbsp;&nbsp; =
114.046|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -8.054|&nbsp;&nbsp;&nbsp;&nbsp; =
238.402</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
19.974|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 63.788|&nbsp;&nbsp;&nbsp;&nbsp; =
114.368|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -8.054|&nbsp;&nbsp;&nbsp;&nbsp; =
238.402</FONT>

<BR><FONT SIZE=3D2 =
FACE=3D"Arial">RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
8.054|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 63.144|&nbsp;&nbsp;&nbsp;&nbsp; =
114.368|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -8.054|&nbsp;&nbsp;&nbsp;&nbsp; =
238.402</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">&lt;&lt;&lt; Crash here, test should =
run all the night &gt;&gt;&gt;</FONT>
</P>
<BR>
</UL>
</BODY>
</HTML>
------_=_NextPart_001_01C7A9CB.71968B58--

