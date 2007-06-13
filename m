Message-ID: <466FE7FE.1080701@domain.hid>
Date: Wed, 13 Jun 2007 14:50:06 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <403B28AE6257B548B66BB88414AC78330174BC4E@STEGOSAURE.adetel.com>
In-Reply-To: <403B28AE6257B548B66BB88414AC78330174BC4E@STEGOSAURE.adetel.com>
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
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
To: BOUIN Alexandre <abouin@domain.hid>
Cc: adeos-main@gna.org, xenomai@xenomai.org

BOUIN Alexandre wrote:
> We perfomed 3 latency tests on AT91SAM9261-EK board :=20
>  - one under DD load, latency set to 45=B5s
>  - another one under Calibrator load, latency set to 35=B5s
>  - and the last under Test_switch load, latency set to 45=B5s
> Xeno-test traces are available and the end of this mail.
>=20
> We used kernel 2.6.20.13, Xenomai snapshot from 08/06/2007, adeos-ipipe-2=
.6.20-arm-1.7-03.patch included.
>=20
> Latencies are better than previous ones. Preemt seems to work.
>=20
> Actually we are doing the same tests on AT91SAM9260-EK board.
>=20
> Here are the results :=20
>=20
> [DD load]
> RTT|  17:59:04  (periodic user-mode task, 500 us period, priority 99)
> RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat w=
orst
> RTD|       9.664|      32.538|      44.458|       0|      -4.510|      85=
.373
> RTD|       5.798|      32.538|      44.780|       0|      -4.510|      85=
.373
> RTD|       8.698|      32.538|      44.780|       0|      -4.510|      85=
.373
> RTD|       9.664|      32.538|      45.425|       0|      -4.510|      85=
.373
> RTD|      11.597|      32.538|      45.425|       0|      -4.510|      85=
.373
> RTD|       2.899|      32.538|      43.492|       0|      -4.510|      85=
.373
> RTD|      12.242|      32.538|      44.780|       0|      -4.510|      85=
.373
> RTD|       2.899|      32.538|      44.780|       0|      -4.510|      85=
.373
> RTD|      10.309|      32.538|      45.425|       0|      -4.510|      85=
.373
> RTD|       2.255|      32.538|      49.935|       0|      -4.510|      85=
.373
> RTD|       9.664|      32.538|      44.458|       0|      -4.510|      85=
.373
> RTD|      10.953|      32.538|      44.136|       0|      -4.510|      85=
.373
> RTD|       1.932|      32.538|      43.170|       0|      -4.510|      85=
.373
> RTD|       9.020|      32.538|      44.458|       0|      -4.510|      85=
.373
> RTD|       9.987|      32.538|      44.136|       0|      -4.510|      85=
.373
> RTD|      11.597|      32.538|      45.425|       0|      -4.510|      85=
.373
> RTD|       0.644|      32.538|      47.036|       0|      -4.510|      85=
.373
> ---|--param|----range-|--samples
> HSD|    min|   0 -  1 |     1091
> HSD|    min|   1 -  2 |     3898
> HSD|    min|   2 -  3 |     5716
> HSD|    min|   3 -  4 |     4689
> HSD|    min|   4 -  5 |     1831
> HSD|    min|   5 -  6 |      607
> HSD|    min|   6 -  7 |      746
> HSD|    min|   7 -  8 |     2287
> HSD|    min|   8 -  9 |     5553
> HSD|    min|   9 - 10 |    11769
> HSD|    min|  10 - 11 |    10739
> HSD|    min|  11 - 12 |     9920
> HSD|    min|  12 - 13 |     4555
> HSD|    min|  13 - 14 |     1162
> HSD|    min|  14 - 15 |      163
> HSD|    min|  15 - 16 |       10
> HSD|    min|  16 - 17 |       10
> HSD|    min|  17 - 18 |        7
> HSD|    min|  18 - 19 |        3
> HSD|    min|  19 - 20 |        3
> HSD|    min|  25 - 26 |        1
> ---|--param|----range-|--samples
> HSD|    avg|   0 -  1 |     1092
> HSD|    avg|   1 -  2 |     3898
> HSD|    avg|   2 -  3 |     5717
> HSD|    avg|   3 -  4 |     4693
> HSD|    avg|   4 -  5 |     1836
> HSD|    avg|   5 -  6 |      609
> HSD|    avg|   6 -  7 |      763
> HSD|    avg|   7 -  8 |     2432
> HSD|    avg|   8 -  9 |     6053
> HSD|    avg|   9 - 10 |    12767
> HSD|    avg|  10 - 11 |    11145
> HSD|    avg|  11 - 12 |    10086
> HSD|    avg|  12 - 13 |     4637
> HSD|    avg|  13 - 14 |     1321
> HSD|    avg|  14 - 15 |     1193
> HSD|    avg|  15 - 16 |     3160
> HSD|    avg|  16 - 17 |    18628
> HSD|    avg|  17 - 18 |    27938
> HSD|    avg|  18 - 19 |    12775
> HSD|    avg|  19 - 20 |     1345
> HSD|    avg|  20 - 21 |      222
> HSD|    avg|  21 - 22 |      249
> HSD|    avg|  22 - 23 |      130
> HSD|    avg|  23 - 24 |       49
> HSD|    avg|  24 - 25 |     1635
> HSD|    avg|  25 - 26 |   128230
> HSD|    avg|  26 - 27 |  1263169
> HSD|    avg|  27 - 28 |  2694164
> HSD|    avg|  28 - 29 |  1799796
> HSD|    avg|  29 - 30 |   196947
> HSD|    avg|  30 - 31 |   417025
> HSD|    avg|  31 - 32 |  8634102
> HSD|    avg|  32 - 33 | 78219326
> HSD|    avg|  33 - 34 | 32442049
> HSD|    avg|  34 - 35 |  2236174
> HSD|    avg|  35 - 36 |    83038
> HSD|    avg|  36 - 37 |    88527
> HSD|    avg|  37 - 38 |    28251
> HSD|    avg|  38 - 39 |    47536
> HSD|    avg|  39 - 40 |    32562
> HSD|    avg|  40 - 41 |    17629
> HSD|    avg|  41 - 42 |    89802
> HSD|    avg|  42 - 43 |   623640
> HSD|    avg|  43 - 44 |   212188
> HSD|    avg|  44 - 45 |    55030
> HSD|    avg|  45 - 46 |    16578
> HSD|    avg|  46 - 47 |    34788
> HSD|    avg|  47 - 48 |    18416
> HSD|    avg|  48 - 49 |     2078
> HSD|    avg|  49 - 50 |     1131
> HSD|    avg|  50 - 51 |     2026
> HSD|    avg|  51 - 52 |     1425
> HSD|    avg|  52 - 53 |     1035
> HSD|    avg|  53 - 54 |      223
> HSD|    avg|  54 - 55 |       90
> HSD|    avg|  55 - 56 |       61
> HSD|    avg|  56 - 57 |       16
> HSD|    avg|  57 - 58 |       36
> HSD|    avg|  58 - 59 |       18
> HSD|    avg|  59 - 60 |       15
> HSD|    avg|  60 - 61 |       19
> HSD|    avg|  61 - 62 |       15
> HSD|    avg|  62 - 63 |        6
> HSD|    avg|  63 - 64 |        7
> HSD|    avg|  64 - 65 |        3
> HSD|    avg|  65 - 66 |        4
> HSD|    avg|  66 - 67 |        2
> HSD|    avg|  67 - 68 |        2
> HSD|    avg|  68 - 69 |        4
> HSD|    avg|  69 - 70 |        1
> HSD|    avg|  71 - 72 |        1
> HSD|    avg|  72 - 73 |        2
> HSD|    avg|  75 - 76 |        1
> HSD|    avg|  76 - 77 |        1
> HSD|    avg|  77 - 78 |        2
> HSD|    avg|  78 - 79 |        1
> HSD|    avg|  79 - 80 |        1
> HSD|    avg|  80 - 81 |        1
> HSD|    avg|  81 - 82 |        3
> HSD|    avg|  82 - 83 |        2
> HSD|    avg|  83 - 84 |        5
> HSD|    avg|  84 - 85 |        6
> HSD|    avg|  85 - 86 |        4
> ---|--param|----range-|--samples
> HSD|    max|  36 - 37 |        1
> HSD|    max|  42 - 43 |       61
> HSD|    max|  43 - 44 |     6197
> HSD|    max|  44 - 45 |    13951
> HSD|    max|  45 - 46 |     6233
> HSD|    max|  46 - 47 |    17653
> HSD|    max|  47 - 48 |    14159
> HSD|    max|  48 - 49 |     1722
> HSD|    max|  49 - 50 |      814
> HSD|    max|  50 - 51 |     1438
> HSD|    max|  51 - 52 |     1117
> HSD|    max|  52 - 53 |      909
> HSD|    max|  53 - 54 |      202
> HSD|    max|  54 - 55 |       80
> HSD|    max|  55 - 56 |       56
> HSD|    max|  56 - 57 |       13
> HSD|    max|  57 - 58 |       33
> HSD|    max|  58 - 59 |       16
> HSD|    max|  59 - 60 |       15
> HSD|    max|  60 - 61 |       18
> HSD|    max|  61 - 62 |       15
> HSD|    max|  62 - 63 |        6
> HSD|    max|  63 - 64 |        6
> HSD|    max|  64 - 65 |        3
> HSD|    max|  65 - 66 |        3
> HSD|    max|  66 - 67 |        2
> HSD|    max|  67 - 68 |        2
> HSD|    max|  68 - 69 |        4
> HSD|    max|  69 - 70 |        1
> HSD|    max|  71 - 72 |        1
> HSD|    max|  72 - 73 |        2
> HSD|    max|  75 - 76 |        1
> HSD|    max|  76 - 77 |        1
> HSD|    max|  77 - 78 |        2
> HSD|    max|  78 - 79 |        1
> HSD|    max|  79 - 80 |        1
> HSD|    max|  80 - 81 |        1
> HSD|    max|  81 - 82 |        3
> HSD|    max|  82 - 83 |        2
> HSD|    max|  83 - 84 |        5
> HSD|    max|  84 - 85 |        6
> HSD|    max|  85 - 86 |        4
> HSH|--param|--samples-|--average--|---stddev--
> HSS|    min|     64760|      7.716|      3.672
> HSS|    avg| 129521587|     -1.101|     33.205
> HSS|    max|     64760|     45.835|      2.195
> ---|------------|------------|------------|--------|---------------------=
----
> RTS|      -4.510|      32.216|      85.373|       0|    17:59:21/17:59:21
>=20
> [Calibrator load]
> # ---|--param|----range-|--samples
> HSD|    min|   0 -  1 |     1395
> HSD|    min|   1 -  2 |     1049
> HSD|    min|   2 -  3 |       21
> HSD|    min|   3 -  4 |        7
> HSD|    min|   4 -  5 |       11
> HSD|    min|   5 -  6 |       53
> HSD|    min|   6 -  7 |      132
> HSD|    min|   7 -  8 |       79
> HSD|    min|   8 -  9 |       52
> HSD|    min|   9 - 10 |      111
> HSD|    min|  10 - 11 |      342
> HSD|    min|  11 - 12 |      722
> HSD|    min|  12 - 13 |      691
> HSD|    min|  13 - 14 |      562
> HSD|    min|  14 - 15 |      319
> HSD|    min|  15 - 16 |      245
> HSD|    min|  16 - 17 |      422
> HSD|    min|  17 - 18 |     1609
> HSD|    min|  18 - 19 |     3899
> HSD|    min|  19 - 20 |     6346
> HSD|    min|  20 - 21 |     3240
> HSD|    min|  21 - 22 |     1180
> HSD|    min|  22 - 23 |      233
> HSD|    min|  23 - 24 |       29
> HSD|    min|  24 - 25 |        7
> HSD|    min|  25 - 26 |        1
> HSD|    min|  27 - 28 |        3
> HSD|    min|  28 - 29 |        3
> HSD|    min|  29 - 30 |        2
> HSD|    min|  31 - 32 |        1
> HSD|    min|  32 - 33 |        2
> ---|--param|----range-|--samples
> HSD|    avg|   0 -  1 |    16244
> HSD|    avg|   1 -  2 |     2931
> HSD|    avg|   2 -  3 |      655
> HSD|    avg|   3 -  4 |      518
> HSD|    avg|   4 -  5 |      271
> HSD|    avg|   5 -  6 |      624
> HSD|    avg|   6 -  7 |     1280
> HSD|    avg|   7 -  8 |      761
> HSD|    avg|   8 -  9 |      269
> HSD|    avg|   9 - 10 |      197
> HSD|    avg|  10 - 11 |      403
> HSD|    avg|  11 - 12 |      786
> HSD|    avg|  12 - 13 |      855
> HSD|    avg|  13 - 14 |     1157
> HSD|    avg|  14 - 15 |     1038
> HSD|    avg|  15 - 16 |      714
> HSD|    avg|  16 - 17 |      664
> HSD|    avg|  17 - 18 |     1807
> HSD|    avg|  18 - 19 |     4161
> HSD|    avg|  19 - 20 |     6955
> HSD|    avg|  20 - 21 |     3811
> HSD|    avg|  21 - 22 |     1925
> HSD|    avg|  22 - 23 |     1053
> HSD|    avg|  23 - 24 |      629
> HSD|    avg|  24 - 25 |      401
> HSD|    avg|  25 - 26 |      499
> HSD|    avg|  26 - 27 |     6601
> HSD|    avg|  27 - 28 |    10179
> HSD|    avg|  28 - 29 |     3673
> HSD|    avg|  29 - 30 |    28259
> HSD|    avg|  30 - 31 |    95506
> HSD|    avg|  31 - 32 |    38120
> HSD|    avg|  32 - 33 |    12696
> HSD|    avg|  33 - 34 |     2512
> HSD|    avg|  34 - 35 |     4438
> HSD|    avg|  35 - 36 |    14578
> HSD|    avg|  36 - 37 |    45120
> HSD|    avg|  37 - 38 |   483204
> HSD|    avg|  38 - 39 |   626229
> HSD|    avg|  39 - 40 |   336021
> HSD|    avg|  40 - 41 |   364037
> HSD|    avg|  41 - 42 |   468275
> HSD|    avg|  42 - 43 |  6663131
> HSD|    avg|  43 - 44 | 18935433
> HSD|    avg|  44 - 45 |  3222266
> HSD|    avg|  45 - 46 |  1132460
> HSD|    avg|  46 - 47 |  2254950
> HSD|    avg|  47 - 48 |  2461892
> HSD|    avg|  48 - 49 |   476141
> HSD|    avg|  49 - 50 |    39600
> HSD|    avg|  50 - 51 |    25490
> HSD|    avg|  51 - 52 |   305313
> HSD|    avg|  52 - 53 |   737407
> HSD|    avg|  53 - 54 |   257277
> HSD|    avg|  54 - 55 |   260007
> HSD|    avg|  55 - 56 |   347234
> HSD|    avg|  56 - 57 |   398681
> HSD|    avg|  57 - 58 |   181010
> HSD|    avg|  58 - 59 |    37539
> HSD|    avg|  59 - 60 |    18975
> HSD|    avg|  60 - 61 |    25659
> HSD|    avg|  61 - 62 |    29102
> HSD|    avg|  62 - 63 |     4644
> HSD|    avg|  63 - 64 |     3381
> HSD|    avg|  64 - 65 |     3098
> HSD|    avg|  65 - 66 |     1884
> HSD|    avg|  66 - 67 |     1215
> HSD|    avg|  67 - 68 |     1792
> HSD|    avg|  68 - 69 |     1036
> HSD|    avg|  69 - 70 |      953
> HSD|    avg|  70 - 71 |     1121
> HSD|    avg|  71 - 72 |     1090
> HSD|    avg|  72 - 73 |     1311
> HSD|    avg|  73 - 74 |     1072
> HSD|    avg|  74 - 75 |     1273
> HSD|    avg|  75 - 76 |     1312
> HSD|    avg|  76 - 77 |     1699
> HSD|    avg|  77 - 78 |      746
> HSD|    avg|  78 - 79 |      504
> HSD|    avg|  79 - 80 |      211
> HSD|    avg|  80 - 81 |       82
> HSD|    avg|  81 - 82 |       54
> HSD|    avg|  82 - 83 |       65
> HSD|    avg|  83 - 84 |       83
> HSD|    avg|  84 - 85 |       57
> HSD|    avg|  85 - 86 |      334
> HSD|    avg|  86 - 87 |      619
> HSD|    avg|  87 - 88 |     1051
> HSD|    avg|  88 - 89 |      544
> HSD|    avg|  89 - 90 |      353
> HSD|    avg|  90 - 91 |     7071
> HSD|    avg|  91 - 92 |    30696
> HSD|    avg|  92 - 93 |     7361
> HSD|    avg|  93 - 94 |      397
> HSD|    avg|  94 - 95 |      381
> HSD|    avg|  95 - 96 |      637
> HSD|    avg|  96 - 97 |     8915
> HSD|    avg|  97 - 98 |    30716
> HSD|    avg|  98 - 99 |    34872
> HSD|    avg|  99 -100 |    27269
> HSD|    avg| 100 -101 |    58893
> HSD|    avg| 101 -102 |    76860
> HSD|    avg| 102 -103 |    17547
> HSD|    avg| 103 -104 |    19677
> HSD|    avg| 104 -105 |    82218
> HSD|    avg| 105 -106 |   404854
> HSD|    avg| 106 -107 |   386541
> HSD|    avg| 107 -108 |    64958
> HSD|    avg| 108 -109 |   209449
> HSD|    avg| 109 -110 |   236910
> HSD|    avg| 110 -111 |   168711
> HSD|    avg| 111 -112 |   194477
> HSD|    avg| 112 -113 |    65353
> HSD|    avg| 113 -114 |   188428
> HSD|    avg| 114 -115 |   205712
> HSD|    avg| 115 -116 |   197926
> HSD|    avg| 116 -117 |   201026
> HSD|    avg| 117 -118 |   113964
> HSD|    avg| 118 -119 |   156261
> HSD|    avg| 119 -120 |   194091
> HSD|    avg| 120 -121 |   123428
> HSD|    avg| 121 -122 |   199243
> HSD|    avg| 122 -123 |   116735
> HSD|    avg| 123 -124 |   109313
> HSD|    avg| 124 -125 |   247811
> HSD|    avg| 125 -126 |   116763
> HSD|    avg| 126 -127 |   262561
> HSD|    avg| 127 -128 |   111704
> HSD|    avg| 128 -129 |   161566
> HSD|    avg| 129 -130 |     7973
> HSD|    avg| 130 -131 |     3923
> HSD|    avg| 131 -132 |    22350
> HSD|    avg| 132 -133 |    40693
> HSD|    avg| 133 -134 |     6999
> HSD|    avg| 134 -135 |     6472
> HSD|    avg| 135 -136 |    33423
> HSD|    avg| 136 -137 |    13747
> HSD|    avg| 137 -138 |     9982
> HSD|    avg| 138 -139 |     9962
> HSD|    avg| 139 -140 |    10883
> HSD|    avg| 140 -141 |     5818
> HSD|    avg| 141 -142 |     5650
> HSD|    avg| 142 -143 |    11294
> HSD|    avg| 143 -144 |     1629
> HSD|    avg| 144 -145 |       94
> HSD|    avg| 145 -146 |       50
> HSD|    avg| 146 -147 |       29
> HSD|    avg| 147 -148 |       31
> HSD|    avg| 148 -149 |       28
> HSD|    avg| 149 -150 |       45
> HSD|    avg| 150 -151 |       57
> HSD|    avg| 151 -152 |       26
> HSD|    avg| 152 -153 |       38
> HSD|    avg| 153 -154 |       54
> HSD|    avg| 154 -155 |       36
> HSD|    avg| 155 -156 |     1412
> HSD|    avg| 156 -157 |     5355
> HSD|    avg| 157 -158 |     9306
> HSD|    avg| 158 -159 |     7539
> HSD|    avg| 159 -160 |     5794
> HSD|    avg| 160 -161 |     2990
> HSD|    avg| 161 -162 |     4209
> HSD|    avg| 162 -163 |     6309
> HSD|    avg| 163 -164 |    11366
> HSD|    avg| 164 -165 |     3309
> HSD|    avg| 165 -166 |     4685
> HSD|    avg| 166 -167 |     3083
> HSD|    avg| 167 -168 |     6807
> HSD|    avg| 168 -169 |      187
> HSD|    avg| 169 -170 |       18
> HSD|    avg| 170 -171 |        9
> HSD|    avg| 171 -172 |        8
> HSD|    avg| 172 -173 |        6
> HSD|    avg| 173 -174 |        3
> HSD|    avg| 174 -175 |        1
> HSD|    avg| 175 -176 |        3
> HSD|    avg| 176 -177 |        2
> HSD|    avg| 177 -178 |        3
> HSD|    avg| 178 -179 |        4
> HSD|    avg| 179 -180 |        1
> HSD|    avg| 180 -181 |        4
> HSD|    avg| 181 -182 |        1
> HSD|    avg| 182 -183 |        3
> HSD|    avg| 183 -184 |        3
> HSD|    avg| 184 -185 |        4
> HSD|    avg| 185 -186 |        2
> HSD|    avg| 186 -187 |        3
> HSD|    avg| 187 -188 |        3
> HSD|    avg| 188 -189 |        5
> HSD|    avg| 189 -190 |        6
> HSD|    avg| 190 -191 |        1
> HSD|    avg| 191 -192 |        2
> HSD|    avg| 192 -193 |        2
> HSD|    avg| 196 -197 |        2
> HSD|    avg| 198 -199 |        2
> HSD|    avg| 199 -200 |        2
> HSD|    avg| 201 -202 |        3
> HSD|    avg| 202 -203 |        1
> HSD|    avg| 203 -204 |        2
> HSD|    avg| 204 -205 |        3
> ---|--param|----range-|--samples
> HSD|    max|  52 - 53 |       19
> HSD|    max|  53 - 54 |      162
> HSD|    max|  54 - 55 |      157
> HSD|    max|  55 - 56 |      172
> HSD|    max|  56 - 57 |      455
> HSD|    max|  57 - 58 |     2673
> HSD|    max|  58 - 59 |     2585
> HSD|    max|  59 - 60 |      834
> HSD|    max|  60 - 61 |      669
> HSD|    max|  61 - 62 |      751
> HSD|    max|  62 - 63 |      480
> HSD|    max|  63 - 64 |      409
> HSD|    max|  64 - 65 |      392
> HSD|    max|  65 - 66 |      404
> HSD|    max|  66 - 67 |      317
> HSD|    max|  67 - 68 |      552
> HSD|    max|  68 - 69 |      393
> HSD|    max|  69 - 70 |      398
> HSD|    max|  70 - 71 |      479
> HSD|    max|  71 - 72 |      511
> HSD|    max|  72 - 73 |      662
> HSD|    max|  73 - 74 |      629
> HSD|    max|  74 - 75 |      782
> HSD|    max|  75 - 76 |      915
> HSD|    max|  76 - 77 |     1298
> HSD|    max|  77 - 78 |      587
> HSD|    max|  78 - 79 |      411
> HSD|    max|  79 - 80 |      153
> HSD|    max|  80 - 81 |       38
> HSD|    max|  81 - 82 |       12
> HSD|    max|  82 - 83 |       16
> HSD|    max|  83 - 84 |       13
> HSD|    max|  84 - 85 |        7
> HSD|    max|  85 - 86 |        5
> HSD|    max|  86 - 87 |        5
> HSD|    max|  87 - 88 |        4
> HSD|    max|  88 - 89 |        2
> HSD|    max|  89 - 90 |        5
> HSD|    max|  90 - 91 |        3
> HSD|    max|  91 - 92 |        5
> HSD|    max|  92 - 93 |        8
> HSD|    max|  93 - 94 |       12
> HSD|    max|  94 - 95 |        8
> HSD|    max|  95 - 96 |       29
> HSD|    max|  96 - 97 |       20
> HSD|    max|  97 - 98 |       16
> HSD|    max|  98 - 99 |       29
> HSD|    max|  99 -100 |       48
> HSD|    max| 100 -101 |       27
> HSD|    max| 101 -102 |       57
> HSD|    max| 102 -103 |       32
> HSD|    max| 103 -104 |       68
> HSD|    max| 104 -105 |       28
> HSD|    max| 105 -106 |       21
> HSD|    max| 106 -107 |       16
> HSD|    max| 107 -108 |       11
> HSD|    max| 108 -109 |       13
> HSD|    max| 109 -110 |        9
> HSD|    max| 110 -111 |       24
> HSD|    max| 111 -112 |       44
> HSD|    max| 112 -113 |      119
> HSD|    max| 113 -114 |       25
> HSD|    max| 114 -115 |       24
> HSD|    max| 115 -116 |       27
> HSD|    max| 116 -117 |       17
> HSD|    max| 117 -118 |       12
> HSD|    max| 118 -119 |        9
> HSD|    max| 119 -120 |        7
> HSD|    max| 120 -121 |        8
> HSD|    max| 121 -122 |        6
> HSD|    max| 122 -123 |       18
> HSD|    max| 123 -124 |       18
> HSD|    max| 124 -125 |       25
> HSD|    max| 125 -126 |       22
> HSD|    max| 126 -127 |       11
> HSD|    max| 127 -128 |        5
> HSD|    max| 128 -129 |        6
> HSD|    max| 129 -130 |        3
> HSD|    max| 130 -131 |       14
> HSD|    max| 131 -132 |       16
> HSD|    max| 132 -133 |       17
> HSD|    max| 133 -134 |       10
> HSD|    max| 134 -135 |       13
> HSD|    max| 135 -136 |       11
> HSD|    max| 136 -137 |        4
> HSD|    max| 137 -138 |       10
> HSD|    max| 138 -139 |        9
> HSD|    max| 139 -140 |       19
> HSD|    max| 140 -141 |       11
> HSD|    max| 141 -142 |        7
> HSD|    max| 153 -154 |        1
> HSD|    max| 155 -156 |        1
> HSD|    max| 156 -157 |        1
> HSD|    max| 157 -158 |        1
> HSD|    max| 158 -159 |        6
> HSD|    max| 159 -160 |        3
> HSD|    max| 160 -161 |        2
> HSD|    max| 161 -162 |        5
> HSD|    max| 162 -163 |       13
> HSD|    max| 163 -164 |       23
> HSD|    max| 164 -165 |       26
> HSD|    max| 165 -166 |       84
> HSD|    max| 166 -167 |      247
> HSD|    max| 167 -168 |     2683
> HSD|    max| 168 -169 |      177
> HSD|    max| 169 -170 |       18
> HSD|    max| 170 -171 |        7
> HSD|    max| 171 -172 |        7
> HSD|    max| 172 -173 |        6
> HSD|    max| 173 -174 |        3
> HSD|    max| 174 -175 |        1
> HSD|    max| 175 -176 |        3
> HSD|    max| 176 -177 |        2
> HSD|    max| 177 -178 |        3
> HSD|    max| 178 -179 |        3
> HSD|    max| 179 -180 |        1
> HSD|    max| 180 -181 |        4
> HSD|    max| 181 -182 |        1
> HSD|    max| 182 -183 |        3
> HSD|    max| 183 -184 |        3
> HSD|    max| 184 -185 |        4
> HSD|    max| 185 -186 |        2
> HSD|    max| 186 -187 |        3
> HSD|    max| 187 -188 |        3
> HSD|    max| 188 -189 |        5
> HSD|    max| 189 -190 |        6
> HSD|    max| 190 -191 |        1
> HSD|    max| 191 -192 |        2
> HSD|    max| 192 -193 |        2
> HSD|    max| 196 -197 |        2
> HSD|    max| 198 -199 |        2
> HSD|    max| 199 -200 |        2
> HSD|    max| 201 -202 |        3
> HSD|    max| 202 -203 |        1
> HSD|    max| 203 -204 |        2
> HSD|    max| 204 -205 |        3
> HSH|--param|--samples-|--average--|---stddev--
> HSS|    min|     22768|     15.813|      6.110
> HSS|    avg|  45536251|     51.856|     23.148
> HSS|    max|     22768|     82.431|     37.486
> ---|------------|------------|------------|--------|---------------------=
----
> RTS|      -6.121|      51.868|     204.574|       1|    06:19:30/06:19:30
>=20
> [Test_switch load]
> RTT|  03:47:31  (periodic user-mode task, 500 us period, priority 99)
> RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat w=
orst
> RTD|      10.631|      36.726|      58.311|       0|      -0.322|      91=
.817
> RTD|       8.054|      37.048|      85.373|       0|      -0.322|      91=
.817
> RTD|      10.953|      36.726|      85.373|       0|      -0.322|      91=
.817
> RTD|       2.577|      36.726|      49.613|       0|      -0.322|      91=
.817
> RTD|      12.564|      36.726|      83.440|       0|      -0.322|      91=
.817
> RTD|       2.577|      36.726|      84.085|       0|      -0.322|      91=
.817
> RTD|      11.920|      36.726|      83.762|       0|      -0.322|      91=
.817
> RTD|       1.932|      36.726|      83.440|       0|      -0.322|      91=
.817
> RTD|       3.543|      36.726|      85.051|       0|      -0.322|      91=
.817
> RTD|       2.899|      36.726|      85.051|       0|      -0.322|      91=
.817
> RTD|       8.698|      36.726|      84.085|       0|      -0.322|      91=
.817
> RTD|       2.577|      36.726|      78.930|       0|      -0.322|      91=
.817
> RTD|       9.987|      36.726|      85.373|       0|      -0.322|      91=
.817
> RTD|       2.577|      36.726|      86.018|       0|      -0.322|      91=
.817
> RTD|       9.020|      36.726|      85.051|       0|      -0.322|      91=
.817
> RTD|       2.899|      36.726|      82.796|       0|      -0.322|      91=
.817
> RTD|      10.953|      36.726|      86.018|       0|      -0.322|      91=
.817
> RTD|       2.577|      36.726|      53.479|       0|      -0.322|      91=
.817
> RTD|       9.664|      36.726|      85.373|       0|      -0.322|      91=
.817
> RTD|       5.476|      36.726|      83.440|       0|      -0.322|      91=
.817
> RTD|       9.987|      36.726|      85.373|       0|      -0.322|      91=
.817
> RTT|  03:47:52  (periodic user-mode task, 500 us period, priority 99)
> RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat w=
orst
> RTD|       2.577|      36.726|      84.085|       0|      -0.322|      91=
.817
> RTD|      11.920|      37.048|      85.051|       0|      -0.322|      91=
.817
> RTD|       3.543|      36.726|      84.085|       0|      -0.322|      91=
.817
> RTD|       3.865|      36.726|      50.579|       0|      -0.322|      91=
.817
> RTD|       1.610|      36.726|      85.051|       0|      -0.322|      91=
.817
> RTD|       3.865|      36.726|      67.010|       0|      -0.322|      91=
.817
> RTD|       4.188|      36.726|      75.386|       0|      -0.322|      91=
.817
> RTD|       3.221|      36.726|      51.224|       0|      -0.322|      91=
.817
> RTD|      11.920|      36.726|      53.801|       0|      -0.322|      91=
.817
> RTD|       0.322|      36.726|      85.373|       0|      -0.322|      91=
.817
> RTD|       4.832|      36.726|      86.018|       0|      -0.322|      91=
.817
> RTD|      11.275|      36.726|      83.118|       0|      -0.322|      91=
.817
> RTD|       3.543|      36.726|      83.762|       0|      -0.322|      91=
.817
> ---|--param|----range-|--samples
> HSD|    min|   0 -  1 |      273
> HSD|    min|   1 -  2 |     1442
> HSD|    min|   2 -  3 |     2610
> HSD|    min|   3 -  4 |     2169
> HSD|    min|   4 -  5 |      842
> HSD|    min|   5 -  6 |      168
> HSD|    min|   6 -  7 |       65
> HSD|    min|   7 -  8 |      236
> HSD|    min|   8 -  9 |      838
> HSD|    min|   9 - 10 |     2182
> HSD|    min|  10 - 11 |     1615
> HSD|    min|  11 - 12 |      900
> HSD|    min|  12 - 13 |      281
> HSD|    min|  13 - 14 |       55
> HSD|    min|  14 - 15 |        5
> HSD|    min|  16 - 17 |        1
> HSD|    min|  17 - 18 |        1
> HSD|    min|  33 - 34 |        1
> ---|--param|----range-|--samples
> HSD|    avg|   0 -  1 |      273
> HSD|    avg|   1 -  2 |     1442
> HSD|    avg|   2 -  3 |     2610
> HSD|    avg|   3 -  4 |     2169
> HSD|    avg|   4 -  5 |      842
> HSD|    avg|   5 -  6 |      168
> HSD|    avg|   6 -  7 |       65
> HSD|    avg|   7 -  8 |      245
> HSD|    avg|   8 -  9 |      898
> HSD|    avg|   9 - 10 |     2403
> HSD|    avg|  10 - 11 |     1713
> HSD|    avg|  11 - 12 |      951
> HSD|    avg|  12 - 13 |      320
> HSD|    avg|  13 - 14 |      132
> HSD|    avg|  14 - 15 |     1053
> HSD|    avg|  15 - 16 |     3799
> HSD|    avg|  16 - 17 |     6396
> HSD|    avg|  17 - 18 |     1954
> HSD|    avg|  18 - 19 |      550
> HSD|    avg|  19 - 20 |       31
> HSD|    avg|  20 - 21 |        3
> HSD|    avg|  21 - 22 |       22
> HSD|    avg|  22 - 23 |        6
> HSD|    avg|  23 - 24 |        6
> HSD|    avg|  25 - 26 |        1
> HSD|    avg|  28 - 29 |       10
> HSD|    avg|  29 - 30 |       38
> HSD|    avg|  30 - 31 |      223
> HSD|    avg|  31 - 32 |     2877
> HSD|    avg|  32 - 33 |     3947
> HSD|    avg|  33 - 34 |     2685
> HSD|    avg|  34 - 35 |     3123
> HSD|    avg|  35 - 36 |     6132
> HSD|    avg|  36 - 37 | 14549839
> HSD|    avg|  37 - 38 | 12350006
> HSD|    avg|  38 - 39 |   193022
> HSD|    avg|  39 - 40 |     5829
> HSD|    avg|  40 - 41 |     5536
> HSD|    avg|  41 - 42 |     3830
> HSD|    avg|  42 - 43 |      995
> HSD|    avg|  43 - 44 |     1954
> HSD|    avg|  44 - 45 |    22601
> HSD|    avg|  45 - 46 |    22574
> HSD|    avg|  46 - 47 |     3639
> HSD|    avg|  47 - 48 |     3151
> HSD|    avg|  48 - 49 |    52151
> HSD|    avg|  49 - 50 |    48667
> HSD|    avg|  50 - 51 |    12112
> HSD|    avg|  51 - 52 |     3541
> HSD|    avg|  52 - 53 |     2075
> HSD|    avg|  53 - 54 |     1669
> HSD|    avg|  54 - 55 |      371
> HSD|    avg|  55 - 56 |      432
> HSD|    avg|  56 - 57 |      305
> HSD|    avg|  57 - 58 |      453
> HSD|    avg|  58 - 59 |      455
> HSD|    avg|  59 - 60 |      585
> HSD|    avg|  60 - 61 |      561
> HSD|    avg|  61 - 62 |      513
> HSD|    avg|  62 - 63 |      930
> HSD|    avg|  63 - 64 |     1468
> HSD|    avg|  64 - 65 |      599
> HSD|    avg|  65 - 66 |      634
> HSD|    avg|  66 - 67 |      352
> HSD|    avg|  67 - 68 |      244
> HSD|    avg|  68 - 69 |      100
> HSD|    avg|  69 - 70 |       76
> HSD|    avg|  70 - 71 |      277
> HSD|    avg|  71 - 72 |      445
> HSD|    avg|  72 - 73 |      244
> HSD|    avg|  73 - 74 |      226
> HSD|    avg|  74 - 75 |      218
> HSD|    avg|  75 - 76 |      335
> HSD|    avg|  76 - 77 |      267
> HSD|    avg|  77 - 78 |      232
> HSD|    avg|  78 - 79 |      435
> HSD|    avg|  79 - 80 |      292
> HSD|    avg|  80 - 81 |      322
> HSD|    avg|  81 - 82 |     1148
> HSD|    avg|  82 - 83 |     3559
> HSD|    avg|  83 - 84 |     7381
> HSD|    avg|  84 - 85 |     7088
> HSD|    avg|  85 - 86 |     8401
> HSD|    avg|  86 - 87 |      684
> HSD|    avg|  88 - 89 |        1
> HSD|    avg|  91 - 92 |        1
> ---|--param|----range-|--samples
> HSD|    max|  40 - 41 |        1
> HSD|    max|  49 - 50 |      165
> HSD|    max|  50 - 51 |      462
> HSD|    max|  51 - 52 |      516
> HSD|    max|  52 - 53 |      379
> HSD|    max|  53 - 54 |      433
> HSD|    max|  54 - 55 |      106
> HSD|    max|  55 - 56 |       65
> HSD|    max|  56 - 57 |       92
> HSD|    max|  57 - 58 |      263
> HSD|    max|  58 - 59 |      317
> HSD|    max|  59 - 60 |      166
> HSD|    max|  60 - 61 |       50
> HSD|    max|  61 - 62 |       46
> HSD|    max|  62 - 63 |       64
> HSD|    max|  63 - 64 |       65
> HSD|    max|  64 - 65 |       39
> HSD|    max|  65 - 66 |       88
> HSD|    max|  66 - 67 |       86
> HSD|    max|  67 - 68 |      110
> HSD|    max|  68 - 69 |       25
> HSD|    max|  69 - 70 |       35
> HSD|    max|  70 - 71 |       96
> HSD|    max|  71 - 72 |       81
> HSD|    max|  72 - 73 |       93
> HSD|    max|  73 - 74 |      101
> HSD|    max|  74 - 75 |      159
> HSD|    max|  75 - 76 |      273
> HSD|    max|  76 - 77 |      146
> HSD|    max|  77 - 78 |      104
> HSD|    max|  78 - 79 |      279
> HSD|    max|  79 - 80 |      185
> HSD|    max|  80 - 81 |      164
> HSD|    max|  81 - 82 |      269
> HSD|    max|  82 - 83 |      831
> HSD|    max|  83 - 84 |     1797
> HSD|    max|  84 - 85 |     1419
> HSD|    max|  85 - 86 |     3504
> HSD|    max|  86 - 87 |      608
> HSD|    max|  88 - 89 |        1
> HSD|    max|  91 - 92 |        1
> HSH|--param|--samples-|--average--|---stddev--
> HSS|    min|     13684|      5.556|      3.762
> HSS|    avg|  27369912|     36.575|      2.112
> HSS|    max|     13684|     75.492|     12.741
> ---|------------|------------|------------|--------|---------------------=
----
> RTS|      -0.322|      36.726|      91.817|       0|    03:48:05/03:48:05
>=20
> [Xeno-test]
> xeno-test: started
> withBusybox is 1
> xeno-test: running tests
>=20
> Thu Jan  1 00:00:31 UTC 1970
> running: ./xeno-config --verbose
> xeno-config --verbose
>     --version=3D"2.3.50"
>     --cc=3D"/opt/crosstool/gcc-4.1.0-glibc-2.3.2/arm-unknown-linux-gnu/bi=
n/arm-unknown-linux-gnu-gcc"
>     --arch=3D"arm"
>     --prefix=3D"/usr/xenomai"
>     --xeno-cflags=3D"-I/usr/xenomai/include -D_GNU_SOURCE -D_REENTRANT -D=
__XENO__"
>     --xeno-ldflags=3D"-L/usr/xenomai/lib -lpthread "
>     --posix-cflags=3D"-I/usr/xenomai/include -I/usr/xenomai/include/posix=
 -D_GNU_SOURCE -D_REENTRANT -D__XENO__"
>     --posix-ldflags=3D"-L/usr/xenomai/lib -lpthread_rt -lpthread -lrt "
>     --library-dir=3D"/usr/xenomai/lib"
>=20
> Thu Jan  1 00:00:31 UTC 1970
> running: ./xeno-info
> If some fields are empty or look unusual you may have an old version.
> Compare to the current minimal requirements in Documentation/Changes.
>=20
> BusyBox v1.2.2 (2007.05.18-11:41+0000) multi-call binary
> Linux uclibc 2.6.20.13 #1 Mon Jun 11 09:47:24 CEST 2007 armv5tejl unknown
>=20
> module-init-tools      3.2.2
> Modules Loaded
>=20
> Thu Jan  1 00:00:32 UTC 1970
> running: cat /proc/cpuinfo
> Processor       : ARM926EJ-S rev 5 (v5l)
> BogoMIPS        : 99.12
> Features        : swp half fastmult edsp java
> CPU implementer : 0x41
> CPU architecture: 5TEJ
> CPU variant     : 0x0
> CPU part        : 0x926
> CPU revision    : 5
> Cache type      : write-back
> Cache clean     : cp15 c7 ops
> Cache lockdown  : format C
> Cache format    : Harvard
> I size          : 16384
> I assoc         : 4
> I line length   : 32
> I sets          : 128
> D size          : 16384
> D assoc         : 4
> D line length   : 32
> D sets          : 128
>=20
> Hardware        : Atmel AT91SAM9261-EK
> Revision        : 0000
> Serial          : 0000000000000000

That's good news. However, I see that AT91SAM926x are armv5, not armv4,
so I should update configure.in.

--=20
                                                 Gilles Chanteperdrix

