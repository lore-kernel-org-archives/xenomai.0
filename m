Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="----_=_NextPart_001_01C7B4E3.A1FF664C"
Date: Fri, 22 Jun 2007 17:40:17 +0200
Message-ID: <403B28AE6257B548B66BB88414AC78330174BC72@domain.hid>
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

This is a multi-part message in MIME format.

------_=_NextPart_001_01C7B4E3.A1FF664C
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_002_01C7B4E3.A1FF664C"


------_=_NextPart_002_01C7B4E3.A1FF664C
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Same tests but for AT91SAM9263-EK board :=20
 - one under DD load, latency set to 45=B5s
 - another one under Calibrator load, latency set to 30=B5s
 - and the last under Test_switch load, latency set to 45=B5s
Xeno-test traces are available and the end of this mail.

We used kernel 2.6.20.13, Xenomai snapshot from 08/06/2007, =
adeos-ipipe-2.6.20-arm-1.7-03.patch included plus 2.6.20-at91.patch.

A little correction on macb and ipipe patch was needed :=20
 - macb ethernet controler is not detected on startup
 - we added some corrections to make 9263 usable under ipipe
 - owing to changes in at91 patch (clk are now registered on startup) we =
made a little correction for future adeos-ipipe-2.6.21-arm.patch.

You will find all added patches attached to this mail.
 <<adeos-ipipe-2.6.20-arm-AT91.patch>>  <<2.6.20-at91-macb-9263.patch>>  =
<<adeos-ipipe-2.6.20-arm-AT91.patch>>=20
Latencies are a little worst than on other boards. We presume that it's =
due to the large number of peripherals.

Our latency tests on AT91 boards are done ;)

Here are the results :=20

[DD load]
RTD|      12.165|      33.293|      60.505|       0|      -3.201|      =
86.756
RTD|       3.521|      33.293|      60.825|       0|      -3.201|      =
86.756
RTD|       9.283|      33.293|      60.825|       0|      -3.201|      =
86.756
RTD|      11.524|      33.293|      60.505|       0|      -3.201|      =
86.756
RTD|       9.283|      33.293|      61.145|       0|      -3.201|      =
86.756
RTD|       4.481|      33.293|      61.145|       0|      -3.201|      =
86.756
RTD|       3.521|      33.293|      59.864|       0|      -3.201|      =
86.756
RTD|       9.924|      33.293|      60.185|       0|      -3.201|      =
86.756
RTD|      11.844|      33.293|      60.185|       0|      -3.201|      =
86.756
RTD|      10.884|      33.293|      60.505|       0|      -3.201|      =
86.756
RTD|      10.884|      33.293|      61.145|       0|      -3.201|      =
86.756
RTD|      11.524|      33.293|      60.825|       0|      -3.201|      =
86.756
RTD|      11.524|      33.293|      60.505|       0|      -3.201|      =
86.756
RTD|       8.963|      33.293|      61.145|       0|      -3.201|      =
86.756
RTD|       7.683|      33.293|      60.505|       0|      -3.201|      =
86.756
RTD|       7.363|      33.293|      60.505|       0|      -3.201|      =
86.756
RTD|       8.643|      33.293|      61.145|       0|      -3.201|      =
86.756
RTD|      10.244|      33.293|      62.425|       0|      -3.201|      =
86.756
RTD|       9.283|      33.293|      60.505|       0|      -3.201|      =
86.756
RTD|       9.603|      33.293|      60.505|       0|      -3.201|      =
86.756
RTD|       8.003|      33.293|      61.145|       0|      -3.201|      =
86.756
RTT|  05:08:54  (periodic user-mode task, 500 us period, priority 99)
RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat =
worst
RTD|      10.884|      33.293|      61.145|       0|      -3.201|      =
86.756
RTD|       2.240|      33.293|      60.825|       0|      -3.201|      =
86.756
RTD|       8.963|      33.293|      60.185|       0|      -3.201|      =
86.756
RTD|       3.201|      33.293|      60.185|       0|      -3.201|      =
86.756
RTD|       5.442|      33.293|      61.465|       0|      -3.201|      =
86.756
RTD|      11.204|      33.293|      60.505|       0|      -3.201|      =
86.756
RTD|       9.924|      33.293|      60.505|       0|      -3.201|      =
86.756
RTD|      11.844|      33.293|      63.706|       0|      -3.201|      =
86.756
RTD|       6.402|      33.293|      60.825|       0|      -3.201|      =
86.756
RTD|       7.683|      33.293|      60.825|       0|      -3.201|      =
86.756
RTD|       9.924|      33.293|      60.505|       0|      -3.201|      =
86.756
RTD|       9.924|      33.293|      61.145|       0|      -3.201|      =
86.756
RTD|       8.963|      33.293|      60.505|       0|      -3.201|      =
86.756
RTD|      10.564|      33.293|      61.145|       0|      -3.201|      =
86.756
RTD|      14.405|      33.293|      60.505|       0|      -3.201|      =
86.756
RTD|       3.841|      33.293|      60.505|       0|      -3.201|      =
86.756
RTD|       9.924|      33.293|      60.505|       0|      -3.201|      =
86.756
RTD|      10.244|      33.293|      61.145|       0|      -3.201|      =
86.756
RTD|      11.844|      33.293|      62.105|       0|      -3.201|      =
86.756
RTD|      11.844|      33.293|      60.505|       0|      -3.201|      =
86.756
---|--param|----range-|--samples
HSD|    min|   0 -  1 |      134
HSD|    min|   1 -  2 |      488
HSD|    min|   2 -  3 |     1010
HSD|    min|   3 -  4 |      965
HSD|    min|   4 -  5 |      569
HSD|    min|   5 -  6 |      261
HSD|    min|   6 -  7 |      458
HSD|    min|   7 -  8 |     1208
HSD|    min|   8 -  9 |     3131
HSD|    min|   9 - 10 |     3091
HSD|    min|  10 - 11 |     3182
HSD|    min|  11 - 12 |     2400
HSD|    min|  12 - 13 |     1245
HSD|    min|  13 - 14 |      291
HSD|    min|  14 - 15 |       49
HSD|    min|  15 - 16 |        2
HSD|    min|  16 - 17 |       16
HSD|    min|  17 - 18 |       48
HSD|    min|  18 - 19 |       14
HSD|    min|  22 - 23 |        1
---|--param|----range-|--samples
HSD|    avg|   0 -  1 |      135
HSD|    avg|   1 -  2 |      490
HSD|    avg|   2 -  3 |     1016
HSD|    avg|   3 -  4 |      978
HSD|    avg|   4 -  5 |      583
HSD|    avg|   5 -  6 |      306
HSD|    avg|   6 -  7 |      566
HSD|    avg|   7 -  8 |     1337
HSD|    avg|   8 -  9 |     3349
HSD|    avg|   9 - 10 |     3186
HSD|    avg|  10 - 11 |     3243
HSD|    avg|  11 - 12 |     2453
HSD|    avg|  12 - 13 |     1298
HSD|    avg|  13 - 14 |      341
HSD|    avg|  14 - 15 |      189
HSD|    avg|  15 - 16 |      803
HSD|    avg|  16 - 17 |     3917
HSD|    avg|  17 - 18 |    10060
HSD|    avg|  18 - 19 |     5203
HSD|    avg|  19 - 20 |     4228
HSD|    avg|  20 - 21 |     3991
HSD|    avg|  21 - 22 |     4511
HSD|    avg|  22 - 23 |    15382
HSD|    avg|  23 - 24 |    29786
HSD|    avg|  24 - 25 |    65154
HSD|    avg|  25 - 26 |   147550
HSD|    avg|  26 - 27 |   471980
HSD|    avg|  27 - 28 |   450798
HSD|    avg|  28 - 29 |   170972
HSD|    avg|  29 - 30 |    36877
HSD|    avg|  30 - 31 |    16143
HSD|    avg|  31 - 32 |   261816
HSD|    avg|  32 - 33 | 10977878
HSD|    avg|  33 - 34 | 19656366
HSD|    avg|  34 - 35 |  4151436
HSD|    avg|  35 - 36 |    83221
HSD|    avg|  36 - 37 |    24599
HSD|    avg|  37 - 38 |    11920
HSD|    avg|  38 - 39 |     4318
HSD|    avg|  39 - 40 |     4646
HSD|    avg|  40 - 41 |     2715
HSD|    avg|  41 - 42 |     5440
HSD|    avg|  42 - 43 |    99050
HSD|    avg|  43 - 44 |   147505
HSD|    avg|  44 - 45 |    34821
HSD|    avg|  45 - 46 |     6605
HSD|    avg|  46 - 47 |     1202
HSD|    avg|  47 - 48 |      220
HSD|    avg|  48 - 49 |      215
HSD|    avg|  49 - 50 |     1927
HSD|    avg|  50 - 51 |     5521
HSD|    avg|  51 - 52 |     2622
HSD|    avg|  52 - 53 |     1538
HSD|    avg|  53 - 54 |      552
HSD|    avg|  54 - 55 |       61
HSD|    avg|  55 - 56 |       18
HSD|    avg|  56 - 57 |       73
HSD|    avg|  57 - 58 |     5803
HSD|    avg|  58 - 59 |    36837
HSD|    avg|  59 - 60 |    78173
HSD|    avg|  60 - 61 |    55432
HSD|    avg|  61 - 62 |     5094
HSD|    avg|  62 - 63 |      819
HSD|    avg|  63 - 64 |      436
HSD|    avg|  64 - 65 |      217
HSD|    avg|  65 - 66 |       45
HSD|    avg|  66 - 67 |       12
HSD|    avg|  67 - 68 |        2
HSD|    avg|  68 - 69 |        2
HSD|    avg|  69 - 70 |        1
HSD|    avg|  71 - 72 |        1
HSD|    avg|  72 - 73 |        3
HSD|    avg|  74 - 75 |        1
HSD|    avg|  75 - 76 |        1
HSD|    avg|  76 - 77 |        1
HSD|    avg|  77 - 78 |        4
HSD|    avg|  78 - 79 |        2
HSD|    avg|  79 - 80 |        2
HSD|    avg|  80 - 81 |        3
HSD|    avg|  81 - 82 |        6
HSD|    avg|  82 - 83 |        3
HSD|    avg|  83 - 84 |        3
HSD|    avg|  84 - 85 |        1
HSD|    avg|  85 - 86 |        2
HSD|    avg|  86 - 87 |        3
---|--param|----range-|--samples
HSD|    max|  59 - 60 |      288
HSD|    max|  60 - 61 |    12731
HSD|    max|  61 - 62 |     4093
HSD|    max|  62 - 63 |      756
HSD|    max|  63 - 64 |      398
HSD|    max|  64 - 65 |      199
HSD|    max|  65 - 66 |       45
HSD|    max|  66 - 67 |       12
HSD|    max|  67 - 68 |        2
HSD|    max|  68 - 69 |        2
HSD|    max|  69 - 70 |        1
HSD|    max|  71 - 72 |        1
HSD|    max|  72 - 73 |        3
HSD|    max|  74 - 75 |        1
HSD|    max|  75 - 76 |        1
HSD|    max|  76 - 77 |        1
HSD|    max|  77 - 78 |        4
HSD|    max|  78 - 79 |        2
HSD|    max|  79 - 80 |        2
HSD|    max|  80 - 81 |        3
HSD|    max|  81 - 82 |        6
HSD|    max|  82 - 83 |        3
HSD|    max|  83 - 84 |        3
HSD|    max|  84 - 85 |        1
HSD|    max|  85 - 86 |        2
HSD|    max|  86 - 87 |        3
HSH|--param|--samples-|--average--|---stddev--
HSS|    min|     18563|      8.192|      3.112
HSS|    avg|  37126019|     32.748|      2.625
HSS|    max|     18563|     60.450|      1.201
---|------------|------------|------------|--------|---------------------=
----
RTS|      -3.201|      32.973|      86.756|       0|    =
05:09:13/05:09:13

[Calibrator load]
HSD|    min|   0 -  1 |       23
HSD|    min|   1 -  2 |       28
HSD|    min|   2 -  3 |       18
HSD|    min|   3 -  4 |       32
HSD|    min|   4 -  5 |       97
HSD|    min|   5 -  6 |      138
HSD|    min|   6 -  7 |      152
HSD|    min|   7 -  8 |      192
HSD|    min|   8 -  9 |      283
HSD|    min|   9 - 10 |      208
HSD|    min|  10 - 11 |      241
HSD|    min|  11 - 12 |      267
HSD|    min|  12 - 13 |      144
HSD|    min|  13 - 14 |       99
HSD|    min|  14 - 15 |      149
HSD|    min|  15 - 16 |      330
HSD|    min|  16 - 17 |     1461
HSD|    min|  17 - 18 |     1646
HSD|    min|  18 - 19 |     1151
HSD|    min|  19 - 20 |      484
HSD|    min|  20 - 21 |      205
HSD|    min|  21 - 22 |      318
HSD|    min|  22 - 23 |     1124
HSD|    min|  23 - 24 |     3020
HSD|    min|  24 - 25 |     4897
HSD|    min|  25 - 26 |     2123
HSD|    min|  26 - 27 |      649
HSD|    min|  27 - 28 |      101
HSD|    min|  28 - 29 |       11
HSD|    min|  29 - 30 |        3
HSD|    min|  30 - 31 |        2
HSD|    min|  31 - 32 |       16
HSD|    min|  32 - 33 |       33
HSD|    min|  33 - 34 |        5
HSD|    min|  35 - 36 |        1
HSD|    min|  36 - 37 |        2
---|--param|----range-|--samples
HSD|    avg|   0 -  1 |       23
HSD|    avg|   1 -  2 |       28
HSD|    avg|   2 -  3 |       22
HSD|    avg|   3 -  4 |       43
HSD|    avg|   4 -  5 |      137
HSD|    avg|   5 -  6 |      187
HSD|    avg|   6 -  7 |      299
HSD|    avg|   7 -  8 |      447
HSD|    avg|   8 -  9 |      609
HSD|    avg|   9 - 10 |      497
HSD|    avg|  10 - 11 |      540
HSD|    avg|  11 - 12 |      659
HSD|    avg|  12 - 13 |      401
HSD|    avg|  13 - 14 |      224
HSD|    avg|  14 - 15 |      240
HSD|    avg|  15 - 16 |      465
HSD|    avg|  16 - 17 |     2029
HSD|    avg|  17 - 18 |     2319
HSD|    avg|  18 - 19 |     1704
HSD|    avg|  19 - 20 |      804
HSD|    avg|  20 - 21 |      443
HSD|    avg|  21 - 22 |      596
HSD|    avg|  22 - 23 |     1489
HSD|    avg|  23 - 24 |     3643
HSD|    avg|  24 - 25 |     6119
HSD|    avg|  25 - 26 |     2682
HSD|    avg|  26 - 27 |     1105
HSD|    avg|  27 - 28 |      486
HSD|    avg|  28 - 29 |     1038
HSD|    avg|  29 - 30 |    70212
HSD|    avg|  30 - 31 |    56640
HSD|    avg|  31 - 32 |    52708
HSD|    avg|  32 - 33 |    43857
HSD|    avg|  33 - 34 |    41572
HSD|    avg|  34 - 35 |    40295
HSD|    avg|  35 - 36 |    45101
HSD|    avg|  36 - 37 |    23779
HSD|    avg|  37 - 38 |    34772
HSD|    avg|  38 - 39 |    53527
HSD|    avg|  39 - 40 |   224892
HSD|    avg|  40 - 41 |   713522
HSD|    avg|  41 - 42 |   443870
HSD|    avg|  42 - 43 |   147427
HSD|    avg|  43 - 44 |    82451
HSD|    avg|  44 - 45 |    63101
HSD|    avg|  45 - 46 |    97675
HSD|    avg|  46 - 47 |   537084
HSD|    avg|  47 - 48 | 10489464
HSD|    avg|  48 - 49 | 13121905
HSD|    avg|  49 - 50 |  1571723
HSD|    avg|  50 - 51 |  1012662
HSD|    avg|  51 - 52 |  2635842
HSD|    avg|  52 - 53 |  1102952
HSD|    avg|  53 - 54 |   193318
HSD|    avg|  54 - 55 |    27236
HSD|    avg|  55 - 56 |    27914
HSD|    avg|  56 - 57 |   622650
HSD|    avg|  57 - 58 |   430457
HSD|    avg|  58 - 59 |   218670
HSD|    avg|  59 - 60 |   292796
HSD|    avg|  60 - 61 |   318929
HSD|    avg|  61 - 62 |   150574
HSD|    avg|  62 - 63 |    94515
HSD|    avg|  63 - 64 |    44035
HSD|    avg|  64 - 65 |    92663
HSD|    avg|  65 - 66 |   201498
HSD|    avg|  66 - 67 |    92536
HSD|    avg|  67 - 68 |     6022
HSD|    avg|  68 - 69 |     3936
HSD|    avg|  69 - 70 |     2842
HSD|    avg|  70 - 71 |     2028
HSD|    avg|  71 - 72 |     1692
HSD|    avg|  72 - 73 |    19161
HSD|    avg|  73 - 74 |    54738
HSD|    avg|  74 - 75 |    51988
HSD|    avg|  75 - 76 |    12469
HSD|    avg|  76 - 77 |    11298
HSD|    avg|  77 - 78 |    13999
HSD|    avg|  78 - 79 |     9041
HSD|    avg|  79 - 80 |     4775
HSD|    avg|  80 - 81 |     3710
HSD|    avg|  81 - 82 |     2234
HSD|    avg|  82 - 83 |     1892
HSD|    avg|  83 - 84 |     1544
HSD|    avg|  84 - 85 |     1672
HSD|    avg|  85 - 86 |      977
HSD|    avg|  86 - 87 |      434
HSD|    avg|  87 - 88 |      337
HSD|    avg|  88 - 89 |      600
HSD|    avg|  89 - 90 |      978
HSD|    avg|  90 - 91 |     1039
HSD|    avg|  91 - 92 |     3270
HSD|    avg|  92 - 93 |    28168
HSD|    avg|  93 - 94 |    21162
HSD|    avg|  94 - 95 |     7248
HSD|    avg|  95 - 96 |     4191
HSD|    avg|  96 - 97 |     2320
HSD|    avg|  97 - 98 |     2278
HSD|    avg|  98 - 99 |    56442
HSD|    avg|  99 -100 |   237929
HSD|    avg| 100 -101 |    70802
HSD|    avg| 101 -102 |    14430
HSD|    avg| 102 -103 |    14533
HSD|    avg| 103 -104 |    13002
HSD|    avg| 104 -105 |     9914
HSD|    avg| 105 -106 |   358555
HSD|    avg| 106 -107 |  1495133
HSD|    avg| 107 -108 |   743224
HSD|    avg| 108 -109 |   163029
HSD|    avg| 109 -110 |    50653
HSD|    avg| 110 -111 |    38450
HSD|    avg| 111 -112 |    38028
HSD|    avg| 112 -113 |    18863
HSD|    avg| 113 -114 |    17403
HSD|    avg| 114 -115 |    10765
HSD|    avg| 115 -116 |    10368
HSD|    avg| 116 -117 |    10304
HSD|    avg| 117 -118 |     7948
HSD|    avg| 118 -119 |     6379
HSD|    avg| 119 -120 |     6637
HSD|    avg| 120 -121 |     6332
HSD|    avg| 121 -122 |     7740
HSD|    avg| 122 -123 |     4607
HSD|    avg| 123 -124 |     5423
HSD|    avg| 124 -125 |     5008
HSD|    avg| 125 -126 |     4218
HSD|    avg| 126 -127 |     4584
HSD|    avg| 127 -128 |     4164
HSD|    avg| 128 -129 |     3924
HSD|    avg| 129 -130 |     7523
HSD|    avg| 130 -131 |     5552
HSD|    avg| 131 -132 |     3398
HSD|    avg| 132 -133 |     2872
HSD|    avg| 133 -134 |     1264
HSD|    avg| 134 -135 |      599
HSD|    avg| 135 -136 |      359
HSD|    avg| 136 -137 |      213
HSD|    avg| 137 -138 |     1065
HSD|    avg| 138 -139 |     2950
HSD|    avg| 139 -140 |    10475
HSD|    avg| 140 -141 |     7105
HSD|    avg| 141 -142 |     2271
HSD|    avg| 142 -143 |      680
HSD|    avg| 143 -144 |      156
HSD|    avg| 144 -145 |       94
HSD|    avg| 145 -146 |       74
HSD|    avg| 146 -147 |       40
HSD|    avg| 147 -148 |       32
HSD|    avg| 148 -149 |       31
HSD|    avg| 149 -150 |       22
HSD|    avg| 150 -151 |       18
HSD|    avg| 151 -152 |       11
HSD|    avg| 152 -153 |        6
HSD|    avg| 153 -154 |        7
HSD|    avg| 154 -155 |       11
HSD|    avg| 155 -156 |        7
HSD|    avg| 156 -157 |        3
HSD|    avg| 157 -158 |        7
HSD|    avg| 158 -159 |        3
HSD|    avg| 159 -160 |        5
HSD|    avg| 160 -161 |        7
HSD|    avg| 161 -162 |        4
HSD|    avg| 162 -163 |        4
HSD|    avg| 163 -164 |        4
HSD|    avg| 164 -165 |        2
HSD|    avg| 165 -166 |        1
HSD|    avg| 167 -168 |        1
HSD|    avg| 168 -169 |        1
HSD|    avg| 169 -170 |        2
HSD|    avg| 170 -171 |        2
HSD|    avg| 175 -176 |        1
HSD|    avg| 176 -177 |        1
---|--param|----range-|--samples
HSD|    max|  73 - 74 |      228
HSD|    max|  74 - 75 |     3834
HSD|    max|  75 - 76 |     1219
HSD|    max|  76 - 77 |     1070
HSD|    max|  77 - 78 |     1261
HSD|    max|  78 - 79 |     1338
HSD|    max|  79 - 80 |     1163
HSD|    max|  80 - 81 |     1727
HSD|    max|  81 - 82 |     1312
HSD|    max|  82 - 83 |     1264
HSD|    max|  83 - 84 |      862
HSD|    max|  84 - 85 |      388
HSD|    max|  85 - 86 |      127
HSD|    max|  86 - 87 |       39
HSD|    max|  87 - 88 |       11
HSD|    max|  88 - 89 |       10
HSD|    max|  89 - 90 |        9
HSD|    max|  90 - 91 |        8
HSD|    max|  91 - 92 |        5
HSD|    max|  92 - 93 |        9
HSD|    max|  93 - 94 |       11
HSD|    max|  94 - 95 |       15
HSD|    max|  95 - 96 |       10
HSD|    max|  96 - 97 |       11
HSD|    max|  97 - 98 |       17
HSD|    max|  98 - 99 |       12
HSD|    max|  99 -100 |       22
HSD|    max| 100 -101 |       18
HSD|    max| 101 -102 |       16
HSD|    max| 102 -103 |       26
HSD|    max| 103 -104 |       31
HSD|    max| 104 -105 |       42
HSD|    max| 105 -106 |       50
HSD|    max| 106 -107 |       30
HSD|    max| 107 -108 |       29
HSD|    max| 108 -109 |       34
HSD|    max| 109 -110 |       11
HSD|    max| 110 -111 |       15
HSD|    max| 111 -112 |       16
HSD|    max| 112 -113 |       16
HSD|    max| 113 -114 |       38
HSD|    max| 114 -115 |       32
HSD|    max| 115 -116 |       36
HSD|    max| 116 -117 |       26
HSD|    max| 117 -118 |       29
HSD|    max| 118 -119 |       32
HSD|    max| 119 -120 |       32
HSD|    max| 120 -121 |       32
HSD|    max| 121 -122 |       23
HSD|    max| 122 -123 |       20
HSD|    max| 123 -124 |       10
HSD|    max| 124 -125 |       12
HSD|    max| 125 -126 |       11
HSD|    max| 126 -127 |       14
HSD|    max| 127 -128 |       18
HSD|    max| 128 -129 |       16
HSD|    max| 129 -130 |       28
HSD|    max| 130 -131 |       59
HSD|    max| 131 -132 |       74
HSD|    max| 132 -133 |       54
HSD|    max| 133 -134 |       29
HSD|    max| 134 -135 |       14
HSD|    max| 135 -136 |        7
HSD|    max| 136 -137 |       11
HSD|    max| 137 -138 |       16
HSD|    max| 138 -139 |       31
HSD|    max| 139 -140 |       81
HSD|    max| 140 -141 |      554
HSD|    max| 141 -142 |     1030
HSD|    max| 142 -143 |      476
HSD|    max| 143 -144 |      130
HSD|    max| 144 -145 |       78
HSD|    max| 145 -146 |       61
HSD|    max| 146 -147 |       36
HSD|    max| 147 -148 |       30
HSD|    max| 148 -149 |       30
HSD|    max| 149 -150 |       21
HSD|    max| 150 -151 |       18
HSD|    max| 151 -152 |       11
HSD|    max| 152 -153 |        5
HSD|    max| 153 -154 |        7
HSD|    max| 154 -155 |       10
HSD|    max| 155 -156 |        7
HSD|    max| 156 -157 |        3
HSD|    max| 157 -158 |        7
HSD|    max| 158 -159 |        3
HSD|    max| 159 -160 |        5
HSD|    max| 160 -161 |        7
HSD|    max| 161 -162 |        4
HSD|    max| 162 -163 |        4
HSD|    max| 163 -164 |        4
HSD|    max| 164 -165 |        2
HSD|    max| 165 -166 |        1
HSD|    max| 167 -168 |        1
HSD|    max| 168 -169 |        1
HSD|    max| 169 -170 |        2
HSD|    max| 170 -171 |        2
HSD|    max| 175 -176 |        1
HSD|    max| 176 -177 |        1
HSH|--param|--samples-|--average--|---stddev--
HSS|    min|     19653|     20.442|      5.205
HSS|    avg|  39307819|     53.751|     17.180
HSS|    max|     19653|     88.757|     23.271
---|------------|------------|------------|--------|---------------------=
----
RTS|      -8.003|      53.782|     176.073|       0|    =
05:27:24/05:27:24

[Test_switch load]
RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat =
worst
RTD|       4.481|      36.495|      79.713|       0|      -4.801|     =
106.604
RTD|       1.600|      36.815|      79.072|       0|      -4.801|     =
106.604
RTD|       8.963|      36.495|      78.752|       0|      -4.801|     =
106.604
RTD|       2.881|      36.495|      78.112|       0|      -4.801|     =
106.604
RTD|       8.003|      36.495|      78.752|       0|      -4.801|     =
106.604
RTD|      11.844|      36.495|      84.515|       0|      -4.801|     =
106.604
RTD|       1.280|      36.495|      79.072|       0|      -4.801|     =
106.604
RTD|       8.643|      36.495|      63.706|       0|      -4.801|     =
106.604
RTD|       2.881|      36.495|      77.792|       0|      -4.801|     =
106.604
RTD|       3.841|      36.495|      79.072|       0|      -4.801|     =
106.604
RTD|       8.003|      36.495|      82.594|       0|      -4.801|     =
106.604
RTD|      10.244|      36.495|      79.393|       0|      -4.801|     =
106.604
RTD|       0.960|      36.495|      80.033|       0|      -4.801|     =
106.604
RTD|       8.643|      36.495|      81.954|       0|      -4.801|     =
106.604
RTD|      11.524|      36.495|      66.907|       0|      -4.801|     =
106.604
RTD|       1.600|      36.495|      79.713|       0|      -4.801|     =
106.604
RTD|       3.841|      36.495|      81.633|       0|      -4.801|     =
106.604
RTD|       9.283|      36.495|      79.072|       0|      -4.801|     =
106.604
RTD|      10.244|      36.495|      79.393|       0|      -4.801|     =
106.604
RTD|       1.280|      36.495|      79.393|       0|      -4.801|     =
106.604
RTD|       2.240|      36.495|      78.752|       0|      -4.801|     =
106.604
RTT|  01:15:34  (periodic user-mode task, 500 us period, priority 99)
RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat =
worst
RTD|       9.603|      36.495|      82.274|       0|      -4.801|     =
106.604
RTD|       8.643|      36.495|      82.914|       0|      -4.801|     =
106.604
RTD|       1.920|      36.495|      66.907|       0|      -4.801|     =
106.604
RTD|       5.442|      36.495|      82.594|       0|      -4.801|     =
106.604
RTD|      17.927|      36.495|      82.914|       0|      -4.801|     =
106.604
RTD|       2.240|      36.495|     104.363|       0|      -4.801|     =
106.604
RTD|       2.240|      36.495|      78.112|       0|      -4.801|     =
106.604
RTD|       9.283|      36.495|      82.914|       0|      -4.801|     =
106.604
RTD|       9.283|      36.495|      82.274|       0|      -4.801|     =
106.604
RTD|      10.884|      36.495|      77.472|       0|      -4.801|     =
106.604
RTD|       9.603|      36.495|      80.033|       0|      -4.801|     =
106.604
RTD|       9.924|      36.495|      85.475|       0|      -4.801|     =
106.604
RTD|       3.521|      36.495|      77.472|       0|      -4.801|     =
106.604
RTD|       9.283|      36.495|      63.386|       0|      -4.801|     =
106.604
RTD|       3.841|      36.495|      75.871|       0|      -4.801|     =
106.604
RTD|       9.283|      36.495|      81.954|       0|      -4.801|     =
106.604
RTD|       8.323|      36.495|      75.551|       0|      -4.801|     =
106.604
RTD|       2.561|      36.495|      78.432|       0|      -4.801|     =
106.604
---|--param|----range-|--samples
HSD|    min|   0 -  1 |      135
HSD|    min|   1 -  2 |      417
HSD|    min|   2 -  3 |      655
HSD|    min|   3 -  4 |      490
HSD|    min|   4 -  5 |      172
HSD|    min|   5 -  6 |       83
HSD|    min|   6 -  7 |      125
HSD|    min|   7 -  8 |      230
HSD|    min|   8 -  9 |      528
HSD|    min|   9 - 10 |      547
HSD|    min|  10 - 11 |      577
HSD|    min|  11 - 12 |      388
HSD|    min|  12 - 13 |      157
HSD|    min|  13 - 14 |       26
HSD|    min|  14 - 15 |        3
HSD|    min|  16 - 17 |        9
HSD|    min|  17 - 18 |       10
HSD|    min|  18 - 19 |        1
HSD|    min|  20 - 21 |        1
---|--param|----range-|--samples
HSD|    avg|   0 -  1 |      135
HSD|    avg|   1 -  2 |      418
HSD|    avg|   2 -  3 |      656
HSD|    avg|   3 -  4 |      492
HSD|    avg|   4 -  5 |      179
HSD|    avg|   5 -  6 |       94
HSD|    avg|   6 -  7 |      141
HSD|    avg|   7 -  8 |      271
HSD|    avg|   8 -  9 |      584
HSD|    avg|   9 - 10 |      582
HSD|    avg|  10 - 11 |      600
HSD|    avg|  11 - 12 |      394
HSD|    avg|  12 - 13 |      170
HSD|    avg|  13 - 14 |       55
HSD|    avg|  14 - 15 |      108
HSD|    avg|  15 - 16 |      225
HSD|    avg|  16 - 17 |     1880
HSD|    avg|  17 - 18 |     1848
HSD|    avg|  18 - 19 |      596
HSD|    avg|  19 - 20 |      947
HSD|    avg|  20 - 21 |     1024
HSD|    avg|  21 - 22 |     1951
HSD|    avg|  22 - 23 |     4472
HSD|    avg|  23 - 24 |     7646
HSD|    avg|  24 - 25 |    17268
HSD|    avg|  25 - 26 |    17672
HSD|    avg|  26 - 27 |    13704
HSD|    avg|  27 - 28 |     6231
HSD|    avg|  28 - 29 |     3641
HSD|    avg|  29 - 30 |     2539
HSD|    avg|  30 - 31 |     1987
HSD|    avg|  31 - 32 |     1997
HSD|    avg|  32 - 33 |     2816
HSD|    avg|  33 - 34 |     2797
HSD|    avg|  34 - 35 |    29055
HSD|    avg|  35 - 36 |  1359783
HSD|    avg|  36 - 37 |  5963432
HSD|    avg|  37 - 38 |  1444786
HSD|    avg|  38 - 39 |    73370
HSD|    avg|  39 - 40 |     8495
HSD|    avg|  40 - 41 |    13947
HSD|    avg|  41 - 42 |     1479
HSD|    avg|  42 - 43 |     1155
HSD|    avg|  43 - 44 |     4746
HSD|    avg|  44 - 45 |     7309
HSD|    avg|  45 - 46 |     2100
HSD|    avg|  46 - 47 |      423
HSD|    avg|  47 - 48 |     1409
HSD|    avg|  48 - 49 |    23428
HSD|    avg|  49 - 50 |     8889
HSD|    avg|  50 - 51 |     1799
HSD|    avg|  51 - 52 |     2671
HSD|    avg|  52 - 53 |     2964
HSD|    avg|  53 - 54 |     1719
HSD|    avg|  54 - 55 |     1051
HSD|    avg|  55 - 56 |      590
HSD|    avg|  56 - 57 |      348
HSD|    avg|  57 - 58 |       81
HSD|    avg|  58 - 59 |      123
HSD|    avg|  59 - 60 |      128
HSD|    avg|  60 - 61 |     1124
HSD|    avg|  61 - 62 |     8847
HSD|    avg|  62 - 63 |    21745
HSD|    avg|  63 - 64 |    12408
HSD|    avg|  64 - 65 |     1584
HSD|    avg|  65 - 66 |      150
HSD|    avg|  66 - 67 |      174
HSD|    avg|  67 - 68 |      189
HSD|    avg|  68 - 69 |      168
HSD|    avg|  69 - 70 |      103
HSD|    avg|  70 - 71 |      108
HSD|    avg|  71 - 72 |       79
HSD|    avg|  72 - 73 |      101
HSD|    avg|  73 - 74 |       68
HSD|    avg|  74 - 75 |       70
HSD|    avg|  75 - 76 |      288
HSD|    avg|  76 - 77 |      830
HSD|    avg|  77 - 78 |     2039
HSD|    avg|  78 - 79 |     2193
HSD|    avg|  79 - 80 |     1235
HSD|    avg|  80 - 81 |      981
HSD|    avg|  81 - 82 |      617
HSD|    avg|  82 - 83 |      498
HSD|    avg|  83 - 84 |      394
HSD|    avg|  84 - 85 |      541
HSD|    avg|  85 - 86 |      346
HSD|    avg|  86 - 87 |      188
HSD|    avg|  87 - 88 |       22
HSD|    avg|  88 - 89 |        8
HSD|    avg|  90 - 91 |        4
HSD|    avg|  91 - 92 |        1
HSD|    avg|  92 - 93 |        2
HSD|    avg|  93 - 94 |        2
HSD|    avg|  94 - 95 |        3
HSD|    avg|  95 - 96 |        5
HSD|    avg|  96 - 97 |       10
HSD|    avg|  97 - 98 |       17
HSD|    avg|  98 - 99 |        8
HSD|    avg|  99 -100 |       10
HSD|    avg| 100 -101 |        1
HSD|    avg| 101 -102 |        3
HSD|    avg| 102 -103 |        3
HSD|    avg| 103 -104 |        5
HSD|    avg| 104 -105 |        3
HSD|    avg| 105 -106 |        1
HSD|    avg| 106 -107 |        1
---|--param|----range-|--samples
HSD|    max|  62 - 63 |        2
HSD|    max|  63 - 64 |      103
HSD|    max|  64 - 65 |       51
HSD|    max|  65 - 66 |       10
HSD|    max|  66 - 67 |       15
HSD|    max|  67 - 68 |       11
HSD|    max|  68 - 69 |       11
HSD|    max|  69 - 70 |        8
HSD|    max|  70 - 71 |        4
HSD|    max|  71 - 72 |        3
HSD|    max|  72 - 73 |        5
HSD|    max|  73 - 74 |        6
HSD|    max|  74 - 75 |       11
HSD|    max|  75 - 76 |       34
HSD|    max|  76 - 77 |      124
HSD|    max|  77 - 78 |      495
HSD|    max|  78 - 79 |      736
HSD|    max|  79 - 80 |      570
HSD|    max|  80 - 81 |      437
HSD|    max|  81 - 82 |      352
HSD|    max|  82 - 83 |      343
HSD|    max|  83 - 84 |      245
HSD|    max|  84 - 85 |      386
HSD|    max|  85 - 86 |      307
HSD|    max|  86 - 87 |      176
HSD|    max|  87 - 88 |       22
HSD|    max|  88 - 89 |        8
HSD|    max|  90 - 91 |        4
HSD|    max|  91 - 92 |        1
HSD|    max|  92 - 93 |        2
HSD|    max|  93 - 94 |        2
HSD|    max|  94 - 95 |        3
HSD|    max|  95 - 96 |        5
HSD|    max|  96 - 97 |       10
HSD|    max|  97 - 98 |       17
HSD|    max|  98 - 99 |        8
HSD|    max|  99 -100 |       10
HSD|    max| 100 -101 |        1
HSD|    max| 101 -102 |        3
HSD|    max| 102 -103 |        3
HSD|    max| 103 -104 |        5
HSD|    max| 104 -105 |        3
HSD|    max| 105 -106 |        1
HSD|    max| 106 -107 |        1
HSH|--param|--samples-|--average--|---stddev--
HSS|    min|      4554|      6.250|      3.820
HSS|    avg|   9108577|     36.167|      2.971
HSS|    max|      4554|     79.952|      5.061
---|------------|------------|------------|--------|---------------------=
----
RTS|      -4.801|      36.495|     106.604|       0|    =
01:15:53/01:15:53

[Xeno-test]
: cat /proc/xenomai/interfaces/native
0

Thu Jan  1 23:19:08 UTC 1970
running: cat /proc/xenomai/interfaces/posix
Mem: 6308K used, 56196K free, 0K shrd, 0K buff, 2984K cached
Load average: 0.23 0.05 0.02  (Status: S=3Dsleeping R=3Drunning, =
W=3Dwaiting)
  PID USER     STATUS   RSS  PPID %MEM COMMAND
  207 root     S        872     1  1.3 sh
 1269 root     R        700  1268  1.1 top
 1098 root     S        660   207  1.0 xeno-test
  176 daemon   S        592     1  0.9 portmap
    1 root     S        564     0  0.9 init
  208 root     S        548     1  0.8 syslogd
  209 root     S        532     1  0.8 klogd

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



------_=_NextPart_002_01C7B4E3.A1FF664C
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
<TITLE>RE: [Adeos-main] New I-pipe patch for ARM needs testing.</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/rtf format -->

<P><FONT SIZE=3D2 FACE=3D"Courier New">Same tests but for AT91SAM9263-EK =
board : </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp;- one under DD load, =
latency set to 45=B5s</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp;- another one under =
Calibrator load, latency set to 30=B5s</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp;- and the last under =
Test_switch load, latency set to 45=B5s</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">Xeno-test traces are available =
and the end of this mail.</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Courier New">We used kernel 2.6.20.13, Xenomai =
snapshot from 08/06/2007, adeos-ipipe-2.6.20-arm-1.7-03.patch included =
plus 2.6.20-at91.patch.</FONT></P>

<P><FONT SIZE=3D2 FACE=3D"Courier New">A little correction on macb and =
ipipe patch was needed : </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp;- macb ethernet controler =
is not detected on startup</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp;- we added some =
corrections to make 9263 usable under ipipe</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp;- owing to changes in at91 =
patch (clk are now registered on startup) we made a little correction =
for future adeos-ipipe-2.6.21-arm.patch.</FONT></P>

<P><FONT SIZE=3D2 FACE=3D"Courier New">You will find all added patches =
attached to this mail.</FONT>

<BR><FONT FACE=3D"Arial" SIZE=3D2 COLOR=3D"#000000"> =
&lt;&lt;adeos-ipipe-2.6.20-arm-AT91.patch&gt;&gt; </FONT><FONT =
FACE=3D"Arial" SIZE=3D2 COLOR=3D"#000000"> =
&lt;&lt;2.6.20-at91-macb-9263.patch&gt;&gt; </FONT><FONT FACE=3D"Arial" =
SIZE=3D2 COLOR=3D"#000000"> =
&lt;&lt;adeos-ipipe-2.6.20-arm-AT91.patch&gt;&gt; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">Latencies are a little worst =
than on other boards. We presume that it's due to the large number of =
peripherals.</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Courier New">Our latency tests on AT91 boards =
are done ;)</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Courier New">Here are the results : </FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Courier New">[DD load]</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier =
New">RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
12.165|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
33.293|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
60.505|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -3.201|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
86.756</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier =
New">RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
3.521|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
33.293|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
60.825|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -3.201|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
86.756</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier =
New">RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
9.283|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
33.293|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
60.825|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -3.201|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
86.756</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier =
New">RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
11.524|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
33.293|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
60.505|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -3.201|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
86.756</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier =
New">RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
9.283|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
33.293|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
61.145|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -3.201|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
86.756</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier =
New">RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
4.481|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
33.293|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
61.145|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -3.201|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
86.756</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier =
New">RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
3.521|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
33.293|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
59.864|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -3.201|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
86.756</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier =
New">RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
9.924|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
33.293|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
60.185|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -3.201|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
86.756</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier =
New">RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
11.844|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
33.293|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
60.185|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -3.201|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
86.756</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier =
New">RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
10.884|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
33.293|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
60.505|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -3.201|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
86.756</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier =
New">RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
10.884|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
33.293|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
61.145|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -3.201|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
86.756</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier =
New">RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
11.524|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
33.293|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
60.825|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -3.201|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
86.756</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier =
New">RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
11.524|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
33.293|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
60.505|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -3.201|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
86.756</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier =
New">RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
8.963|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
33.293|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
61.145|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -3.201|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
86.756</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier =
New">RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
7.683|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
33.293|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
60.505|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -3.201|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
86.756</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier =
New">RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
7.363|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
33.293|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
60.505|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -3.201|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
86.756</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier =
New">RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
8.643|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
33.293|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
61.145|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -3.201|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
86.756</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier =
New">RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
10.244|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
33.293|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
62.425|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -3.201|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
86.756</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier =
New">RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
9.283|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
33.293|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
60.505|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -3.201|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
86.756</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier =
New">RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
9.603|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
33.293|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
60.505|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -3.201|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
86.756</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier =
New">RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
8.003|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
33.293|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
61.145|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -3.201|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
86.756</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">RTT|&nbsp; 05:08:54&nbsp; =
(periodic user-mode task, 500 us period, priority 99)</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">RTH|-----lat min|-----lat =
avg|-----lat max|-overrun|----lat best|---lat worst</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier =
New">RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
10.884|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
33.293|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
61.145|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -3.201|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
86.756</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier =
New">RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
2.240|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
33.293|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
60.825|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -3.201|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
86.756</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier =
New">RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
8.963|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
33.293|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
60.185|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -3.201|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
86.756</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier =
New">RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
3.201|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
33.293|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
60.185|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -3.201|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
86.756</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier =
New">RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
5.442|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
33.293|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
61.465|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -3.201|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
86.756</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier =
New">RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
11.204|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
33.293|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
60.505|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -3.201|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
86.756</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier =
New">RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
9.924|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
33.293|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
60.505|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -3.201|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
86.756</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier =
New">RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
11.844|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
33.293|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
63.706|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -3.201|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
86.756</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier =
New">RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
6.402|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
33.293|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
60.825|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -3.201|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
86.756</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier =
New">RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
7.683|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
33.293|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
60.825|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -3.201|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
86.756</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier =
New">RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
9.924|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
33.293|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
60.505|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -3.201|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
86.756</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier =
New">RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
9.924|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
33.293|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
61.145|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -3.201|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
86.756</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier =
New">RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
8.963|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
33.293|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
60.505|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -3.201|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
86.756</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier =
New">RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
10.564|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
33.293|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
61.145|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -3.201|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
86.756</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier =
New">RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
14.405|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
33.293|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
60.505|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -3.201|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
86.756</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier =
New">RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
3.841|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
33.293|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
60.505|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -3.201|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
86.756</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier =
New">RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
9.924|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
33.293|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
60.505|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -3.201|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
86.756</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier =
New">RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
10.244|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
33.293|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
61.145|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -3.201|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
86.756</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier =
New">RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
11.844|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
33.293|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
62.105|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -3.201|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
86.756</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier =
New">RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
11.844|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
33.293|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
60.505|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -3.201|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
86.756</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier =
New">---|--param|----range-|--samples</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
min|&nbsp;&nbsp; 0 -&nbsp; 1 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 134</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
min|&nbsp;&nbsp; 1 -&nbsp; 2 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 488</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
min|&nbsp;&nbsp; 2 -&nbsp; 3 |&nbsp;&nbsp;&nbsp;&nbsp; 1010</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
min|&nbsp;&nbsp; 3 -&nbsp; 4 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 965</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
min|&nbsp;&nbsp; 4 -&nbsp; 5 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 569</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
min|&nbsp;&nbsp; 5 -&nbsp; 6 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 261</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
min|&nbsp;&nbsp; 6 -&nbsp; 7 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 458</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
min|&nbsp;&nbsp; 7 -&nbsp; 8 |&nbsp;&nbsp;&nbsp;&nbsp; 1208</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
min|&nbsp;&nbsp; 8 -&nbsp; 9 |&nbsp;&nbsp;&nbsp;&nbsp; 3131</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
min|&nbsp;&nbsp; 9 - 10 |&nbsp;&nbsp;&nbsp;&nbsp; 3091</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
min|&nbsp; 10 - 11 |&nbsp;&nbsp;&nbsp;&nbsp; 3182</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
min|&nbsp; 11 - 12 |&nbsp;&nbsp;&nbsp;&nbsp; 2400</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
min|&nbsp; 12 - 13 |&nbsp;&nbsp;&nbsp;&nbsp; 1245</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
min|&nbsp; 13 - 14 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 291</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
min|&nbsp; 14 - 15 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 49</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
min|&nbsp; 15 - 16 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
min|&nbsp; 16 - 17 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 16</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
min|&nbsp; 17 - 18 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 48</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
min|&nbsp; 18 - 19 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 14</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
min|&nbsp; 22 - 23 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier =
New">---|--param|----range-|--samples</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp;&nbsp; 0 -&nbsp; 1 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 135</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp;&nbsp; 1 -&nbsp; 2 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 490</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp;&nbsp; 2 -&nbsp; 3 |&nbsp;&nbsp;&nbsp;&nbsp; 1016</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp;&nbsp; 3 -&nbsp; 4 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 978</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp;&nbsp; 4 -&nbsp; 5 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 583</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp;&nbsp; 5 -&nbsp; 6 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 306</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp;&nbsp; 6 -&nbsp; 7 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 566</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp;&nbsp; 7 -&nbsp; 8 |&nbsp;&nbsp;&nbsp;&nbsp; 1337</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp;&nbsp; 8 -&nbsp; 9 |&nbsp;&nbsp;&nbsp;&nbsp; 3349</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp;&nbsp; 9 - 10 |&nbsp;&nbsp;&nbsp;&nbsp; 3186</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 10 - 11 |&nbsp;&nbsp;&nbsp;&nbsp; 3243</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 11 - 12 |&nbsp;&nbsp;&nbsp;&nbsp; 2453</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 12 - 13 |&nbsp;&nbsp;&nbsp;&nbsp; 1298</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 13 - 14 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 341</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 14 - 15 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 189</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 15 - 16 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 803</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 16 - 17 |&nbsp;&nbsp;&nbsp;&nbsp; 3917</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 17 - 18 |&nbsp;&nbsp;&nbsp; 10060</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 18 - 19 |&nbsp;&nbsp;&nbsp;&nbsp; 5203</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 19 - 20 |&nbsp;&nbsp;&nbsp;&nbsp; 4228</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 20 - 21 |&nbsp;&nbsp;&nbsp;&nbsp; 3991</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 21 - 22 |&nbsp;&nbsp;&nbsp;&nbsp; 4511</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 22 - 23 |&nbsp;&nbsp;&nbsp; 15382</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 23 - 24 |&nbsp;&nbsp;&nbsp; 29786</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 24 - 25 |&nbsp;&nbsp;&nbsp; 65154</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 25 - 26 |&nbsp;&nbsp; 147550</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 26 - 27 |&nbsp;&nbsp; 471980</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 27 - 28 |&nbsp;&nbsp; 450798</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 28 - 29 |&nbsp;&nbsp; 170972</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 29 - 30 |&nbsp;&nbsp;&nbsp; 36877</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 30 - 31 |&nbsp;&nbsp;&nbsp; 16143</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 31 - 32 |&nbsp;&nbsp; 261816</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 32 - 33 | 10977878</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 33 - 34 | 19656366</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 34 - 35 |&nbsp; 4151436</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 35 - 36 |&nbsp;&nbsp;&nbsp; 83221</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 36 - 37 |&nbsp;&nbsp;&nbsp; 24599</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 37 - 38 |&nbsp;&nbsp;&nbsp; 11920</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 38 - 39 |&nbsp;&nbsp;&nbsp;&nbsp; 4318</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 39 - 40 |&nbsp;&nbsp;&nbsp;&nbsp; 4646</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 40 - 41 |&nbsp;&nbsp;&nbsp;&nbsp; 2715</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 41 - 42 |&nbsp;&nbsp;&nbsp;&nbsp; 5440</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 42 - 43 |&nbsp;&nbsp;&nbsp; 99050</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 43 - 44 |&nbsp;&nbsp; 147505</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 44 - 45 |&nbsp;&nbsp;&nbsp; 34821</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 45 - 46 |&nbsp;&nbsp;&nbsp;&nbsp; 6605</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 46 - 47 |&nbsp;&nbsp;&nbsp;&nbsp; 1202</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 47 - 48 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 220</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 48 - 49 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 215</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 49 - 50 |&nbsp;&nbsp;&nbsp;&nbsp; 1927</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 50 - 51 |&nbsp;&nbsp;&nbsp;&nbsp; 5521</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 51 - 52 |&nbsp;&nbsp;&nbsp;&nbsp; 2622</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 52 - 53 |&nbsp;&nbsp;&nbsp;&nbsp; 1538</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 53 - 54 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 552</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 54 - 55 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 61</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 55 - 56 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 18</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 56 - 57 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 73</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 57 - 58 |&nbsp;&nbsp;&nbsp;&nbsp; 5803</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 58 - 59 |&nbsp;&nbsp;&nbsp; 36837</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 59 - 60 |&nbsp;&nbsp;&nbsp; 78173</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 60 - 61 |&nbsp;&nbsp;&nbsp; 55432</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 61 - 62 |&nbsp;&nbsp;&nbsp;&nbsp; 5094</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 62 - 63 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 819</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 63 - 64 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 436</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 64 - 65 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 217</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 65 - 66 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 45</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 66 - 67 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 12</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 67 - 68 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 68 - 69 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 69 - 70 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 71 - 72 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 72 - 73 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 3</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 74 - 75 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 75 - 76 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 76 - 77 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 77 - 78 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 4</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 78 - 79 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 79 - 80 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 80 - 81 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 3</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 81 - 82 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 6</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 82 - 83 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 3</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 83 - 84 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 3</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 84 - 85 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 85 - 86 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 86 - 87 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 3</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier =
New">---|--param|----range-|--samples</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
max|&nbsp; 59 - 60 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 288</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
max|&nbsp; 60 - 61 |&nbsp;&nbsp;&nbsp; 12731</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
max|&nbsp; 61 - 62 |&nbsp;&nbsp;&nbsp;&nbsp; 4093</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
max|&nbsp; 62 - 63 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 756</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
max|&nbsp; 63 - 64 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 398</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
max|&nbsp; 64 - 65 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 199</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
max|&nbsp; 65 - 66 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 45</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
max|&nbsp; 66 - 67 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 12</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
max|&nbsp; 67 - 68 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
max|&nbsp; 68 - 69 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
max|&nbsp; 69 - 70 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
max|&nbsp; 71 - 72 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
max|&nbsp; 72 - 73 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 3</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
max|&nbsp; 74 - 75 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
max|&nbsp; 75 - 76 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
max|&nbsp; 76 - 77 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
max|&nbsp; 77 - 78 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 4</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
max|&nbsp; 78 - 79 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
max|&nbsp; 79 - 80 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
max|&nbsp; 80 - 81 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 3</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
max|&nbsp; 81 - 82 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 6</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
max|&nbsp; 82 - 83 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 3</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
max|&nbsp; 83 - 84 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 3</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
max|&nbsp; 84 - 85 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
max|&nbsp; 85 - 86 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
max|&nbsp; 86 - 87 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 3</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier =
New">HSH|--param|--samples-|--average--|---stddev--</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSS|&nbsp;&nbsp;&nbsp; =
min|&nbsp;&nbsp;&nbsp;&nbsp; 18563|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
8.192|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 3.112</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSS|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 37126019|&nbsp;&nbsp;&nbsp;&nbsp; =
32.748|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2.625</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSS|&nbsp;&nbsp;&nbsp; =
max|&nbsp;&nbsp;&nbsp;&nbsp; 18563|&nbsp;&nbsp;&nbsp;&nbsp; =
60.450|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1.201</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier =
New">---|------------|------------|------------|--------|----------------=
---------</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier =
New">RTS|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
-3.201|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
32.973|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
86.756|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0|&nbsp;&nbsp;&nbsp; =
05:09:13/05:09:13</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Courier New">[Calibrator load]</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
min|&nbsp;&nbsp; 0 -&nbsp; 1 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
23</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
min|&nbsp;&nbsp; 1 -&nbsp; 2 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
28</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
min|&nbsp;&nbsp; 2 -&nbsp; 3 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
18</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
min|&nbsp;&nbsp; 3 -&nbsp; 4 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
32</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
min|&nbsp;&nbsp; 4 -&nbsp; 5 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
97</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
min|&nbsp;&nbsp; 5 -&nbsp; 6 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 138</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
min|&nbsp;&nbsp; 6 -&nbsp; 7 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 152</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
min|&nbsp;&nbsp; 7 -&nbsp; 8 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 192</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
min|&nbsp;&nbsp; 8 -&nbsp; 9 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 283</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
min|&nbsp;&nbsp; 9 - 10 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 208</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
min|&nbsp; 10 - 11 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 241</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
min|&nbsp; 11 - 12 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 267</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
min|&nbsp; 12 - 13 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 144</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
min|&nbsp; 13 - 14 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 99</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
min|&nbsp; 14 - 15 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 149</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
min|&nbsp; 15 - 16 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 330</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
min|&nbsp; 16 - 17 |&nbsp;&nbsp;&nbsp;&nbsp; 1461</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
min|&nbsp; 17 - 18 |&nbsp;&nbsp;&nbsp;&nbsp; 1646</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
min|&nbsp; 18 - 19 |&nbsp;&nbsp;&nbsp;&nbsp; 1151</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
min|&nbsp; 19 - 20 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 484</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
min|&nbsp; 20 - 21 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 205</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
min|&nbsp; 21 - 22 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 318</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
min|&nbsp; 22 - 23 |&nbsp;&nbsp;&nbsp;&nbsp; 1124</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
min|&nbsp; 23 - 24 |&nbsp;&nbsp;&nbsp;&nbsp; 3020</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
min|&nbsp; 24 - 25 |&nbsp;&nbsp;&nbsp;&nbsp; 4897</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
min|&nbsp; 25 - 26 |&nbsp;&nbsp;&nbsp;&nbsp; 2123</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
min|&nbsp; 26 - 27 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 649</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
min|&nbsp; 27 - 28 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 101</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
min|&nbsp; 28 - 29 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 11</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
min|&nbsp; 29 - 30 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 3</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
min|&nbsp; 30 - 31 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
min|&nbsp; 31 - 32 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 16</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
min|&nbsp; 32 - 33 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 33</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
min|&nbsp; 33 - 34 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 5</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
min|&nbsp; 35 - 36 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
min|&nbsp; 36 - 37 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier =
New">---|--param|----range-|--samples</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp;&nbsp; 0 -&nbsp; 1 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
23</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp;&nbsp; 1 -&nbsp; 2 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
28</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp;&nbsp; 2 -&nbsp; 3 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
22</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp;&nbsp; 3 -&nbsp; 4 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
43</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp;&nbsp; 4 -&nbsp; 5 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 137</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp;&nbsp; 5 -&nbsp; 6 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 187</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp;&nbsp; 6 -&nbsp; 7 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 299</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp;&nbsp; 7 -&nbsp; 8 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 447</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp;&nbsp; 8 -&nbsp; 9 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 609</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp;&nbsp; 9 - 10 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 497</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 10 - 11 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 540</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 11 - 12 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 659</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 12 - 13 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 401</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 13 - 14 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 224</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 14 - 15 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 240</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 15 - 16 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 465</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 16 - 17 |&nbsp;&nbsp;&nbsp;&nbsp; 2029</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 17 - 18 |&nbsp;&nbsp;&nbsp;&nbsp; 2319</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 18 - 19 |&nbsp;&nbsp;&nbsp;&nbsp; 1704</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 19 - 20 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 804</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 20 - 21 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 443</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 21 - 22 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 596</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 22 - 23 |&nbsp;&nbsp;&nbsp;&nbsp; 1489</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 23 - 24 |&nbsp;&nbsp;&nbsp;&nbsp; 3643</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 24 - 25 |&nbsp;&nbsp;&nbsp;&nbsp; 6119</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 25 - 26 |&nbsp;&nbsp;&nbsp;&nbsp; 2682</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 26 - 27 |&nbsp;&nbsp;&nbsp;&nbsp; 1105</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 27 - 28 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 486</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 28 - 29 |&nbsp;&nbsp;&nbsp;&nbsp; 1038</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 29 - 30 |&nbsp;&nbsp;&nbsp; 70212</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 30 - 31 |&nbsp;&nbsp;&nbsp; 56640</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 31 - 32 |&nbsp;&nbsp;&nbsp; 52708</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 32 - 33 |&nbsp;&nbsp;&nbsp; 43857</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 33 - 34 |&nbsp;&nbsp;&nbsp; 41572</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 34 - 35 |&nbsp;&nbsp;&nbsp; 40295</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 35 - 36 |&nbsp;&nbsp;&nbsp; 45101</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 36 - 37 |&nbsp;&nbsp;&nbsp; 23779</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 37 - 38 |&nbsp;&nbsp;&nbsp; 34772</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 38 - 39 |&nbsp;&nbsp;&nbsp; 53527</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 39 - 40 |&nbsp;&nbsp; 224892</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 40 - 41 |&nbsp;&nbsp; 713522</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 41 - 42 |&nbsp;&nbsp; 443870</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 42 - 43 |&nbsp;&nbsp; 147427</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 43 - 44 |&nbsp;&nbsp;&nbsp; 82451</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 44 - 45 |&nbsp;&nbsp;&nbsp; 63101</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 45 - 46 |&nbsp;&nbsp;&nbsp; 97675</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 46 - 47 |&nbsp;&nbsp; 537084</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 47 - 48 | 10489464</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 48 - 49 | 13121905</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 49 - 50 |&nbsp; 1571723</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 50 - 51 |&nbsp; 1012662</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 51 - 52 |&nbsp; 2635842</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 52 - 53 |&nbsp; 1102952</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 53 - 54 |&nbsp;&nbsp; 193318</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 54 - 55 |&nbsp;&nbsp;&nbsp; 27236</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 55 - 56 |&nbsp;&nbsp;&nbsp; 27914</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 56 - 57 |&nbsp;&nbsp; 622650</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 57 - 58 |&nbsp;&nbsp; 430457</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 58 - 59 |&nbsp;&nbsp; 218670</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 59 - 60 |&nbsp;&nbsp; 292796</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 60 - 61 |&nbsp;&nbsp; 318929</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 61 - 62 |&nbsp;&nbsp; 150574</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 62 - 63 |&nbsp;&nbsp;&nbsp; 94515</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 63 - 64 |&nbsp;&nbsp;&nbsp; 44035</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 64 - 65 |&nbsp;&nbsp;&nbsp; 92663</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 65 - 66 |&nbsp;&nbsp; 201498</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 66 - 67 |&nbsp;&nbsp;&nbsp; 92536</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 67 - 68 |&nbsp;&nbsp;&nbsp;&nbsp; 6022</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 68 - 69 |&nbsp;&nbsp;&nbsp;&nbsp; 3936</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 69 - 70 |&nbsp;&nbsp;&nbsp;&nbsp; 2842</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 70 - 71 |&nbsp;&nbsp;&nbsp;&nbsp; 2028</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 71 - 72 |&nbsp;&nbsp;&nbsp;&nbsp; 1692</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 72 - 73 |&nbsp;&nbsp;&nbsp; 19161</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 73 - 74 |&nbsp;&nbsp;&nbsp; 54738</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 74 - 75 |&nbsp;&nbsp;&nbsp; 51988</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 75 - 76 |&nbsp;&nbsp;&nbsp; 12469</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 76 - 77 |&nbsp;&nbsp;&nbsp; 11298</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 77 - 78 |&nbsp;&nbsp;&nbsp; 13999</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 78 - 79 |&nbsp;&nbsp;&nbsp;&nbsp; 9041</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 79 - 80 |&nbsp;&nbsp;&nbsp;&nbsp; 4775</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 80 - 81 |&nbsp;&nbsp;&nbsp;&nbsp; 3710</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 81 - 82 |&nbsp;&nbsp;&nbsp;&nbsp; 2234</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 82 - 83 |&nbsp;&nbsp;&nbsp;&nbsp; 1892</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 83 - 84 |&nbsp;&nbsp;&nbsp;&nbsp; 1544</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 84 - 85 |&nbsp;&nbsp;&nbsp;&nbsp; 1672</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 85 - 86 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 977</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 86 - 87 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 434</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 87 - 88 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 337</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 88 - 89 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 600</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 89 - 90 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 978</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 90 - 91 |&nbsp;&nbsp;&nbsp;&nbsp; 1039</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 91 - 92 |&nbsp;&nbsp;&nbsp;&nbsp; 3270</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 92 - 93 |&nbsp;&nbsp;&nbsp; 28168</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 93 - 94 |&nbsp;&nbsp;&nbsp; 21162</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 94 - 95 |&nbsp;&nbsp;&nbsp;&nbsp; 7248</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 95 - 96 |&nbsp;&nbsp;&nbsp;&nbsp; 4191</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 96 - 97 |&nbsp;&nbsp;&nbsp;&nbsp; 2320</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 97 - 98 |&nbsp;&nbsp;&nbsp;&nbsp; 2278</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 98 - 99 |&nbsp;&nbsp;&nbsp; 56442</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 99 -100 |&nbsp;&nbsp; 237929</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; avg| 100 =
-101 |&nbsp;&nbsp;&nbsp; 70802</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; avg| 101 =
-102 |&nbsp;&nbsp;&nbsp; 14430</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; avg| 102 =
-103 |&nbsp;&nbsp;&nbsp; 14533</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; avg| 103 =
-104 |&nbsp;&nbsp;&nbsp; 13002</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; avg| 104 =
-105 |&nbsp;&nbsp;&nbsp;&nbsp; 9914</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; avg| 105 =
-106 |&nbsp;&nbsp; 358555</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; avg| 106 =
-107 |&nbsp; 1495133</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; avg| 107 =
-108 |&nbsp;&nbsp; 743224</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; avg| 108 =
-109 |&nbsp;&nbsp; 163029</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; avg| 109 =
-110 |&nbsp;&nbsp;&nbsp; 50653</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; avg| 110 =
-111 |&nbsp;&nbsp;&nbsp; 38450</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; avg| 111 =
-112 |&nbsp;&nbsp;&nbsp; 38028</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; avg| 112 =
-113 |&nbsp;&nbsp;&nbsp; 18863</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; avg| 113 =
-114 |&nbsp;&nbsp;&nbsp; 17403</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; avg| 114 =
-115 |&nbsp;&nbsp;&nbsp; 10765</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; avg| 115 =
-116 |&nbsp;&nbsp;&nbsp; 10368</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; avg| 116 =
-117 |&nbsp;&nbsp;&nbsp; 10304</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; avg| 117 =
-118 |&nbsp;&nbsp;&nbsp;&nbsp; 7948</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; avg| 118 =
-119 |&nbsp;&nbsp;&nbsp;&nbsp; 6379</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; avg| 119 =
-120 |&nbsp;&nbsp;&nbsp;&nbsp; 6637</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; avg| 120 =
-121 |&nbsp;&nbsp;&nbsp;&nbsp; 6332</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; avg| 121 =
-122 |&nbsp;&nbsp;&nbsp;&nbsp; 7740</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; avg| 122 =
-123 |&nbsp;&nbsp;&nbsp;&nbsp; 4607</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; avg| 123 =
-124 |&nbsp;&nbsp;&nbsp;&nbsp; 5423</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; avg| 124 =
-125 |&nbsp;&nbsp;&nbsp;&nbsp; 5008</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; avg| 125 =
-126 |&nbsp;&nbsp;&nbsp;&nbsp; 4218</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; avg| 126 =
-127 |&nbsp;&nbsp;&nbsp;&nbsp; 4584</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; avg| 127 =
-128 |&nbsp;&nbsp;&nbsp;&nbsp; 4164</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; avg| 128 =
-129 |&nbsp;&nbsp;&nbsp;&nbsp; 3924</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; avg| 129 =
-130 |&nbsp;&nbsp;&nbsp;&nbsp; 7523</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; avg| 130 =
-131 |&nbsp;&nbsp;&nbsp;&nbsp; 5552</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; avg| 131 =
-132 |&nbsp;&nbsp;&nbsp;&nbsp; 3398</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; avg| 132 =
-133 |&nbsp;&nbsp;&nbsp;&nbsp; 2872</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; avg| 133 =
-134 |&nbsp;&nbsp;&nbsp;&nbsp; 1264</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; avg| 134 =
-135 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 599</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; avg| 135 =
-136 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 359</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; avg| 136 =
-137 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 213</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; avg| 137 =
-138 |&nbsp;&nbsp;&nbsp;&nbsp; 1065</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; avg| 138 =
-139 |&nbsp;&nbsp;&nbsp;&nbsp; 2950</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; avg| 139 =
-140 |&nbsp;&nbsp;&nbsp; 10475</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; avg| 140 =
-141 |&nbsp;&nbsp;&nbsp;&nbsp; 7105</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; avg| 141 =
-142 |&nbsp;&nbsp;&nbsp;&nbsp; 2271</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; avg| 142 =
-143 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 680</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; avg| 143 =
-144 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 156</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; avg| 144 =
-145 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 94</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; avg| 145 =
-146 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 74</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; avg| 146 =
-147 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 40</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; avg| 147 =
-148 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 32</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; avg| 148 =
-149 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 31</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; avg| 149 =
-150 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 22</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; avg| 150 =
-151 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 18</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; avg| 151 =
-152 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 11</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; avg| 152 =
-153 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 6</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; avg| 153 =
-154 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 7</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; avg| 154 =
-155 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 11</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; avg| 155 =
-156 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 7</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; avg| 156 =
-157 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 3</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; avg| 157 =
-158 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 7</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; avg| 158 =
-159 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 3</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; avg| 159 =
-160 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 5</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; avg| 160 =
-161 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 7</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; avg| 161 =
-162 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 4</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; avg| 162 =
-163 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 4</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; avg| 163 =
-164 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 4</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; avg| 164 =
-165 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; avg| 165 =
-166 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; avg| 167 =
-168 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; avg| 168 =
-169 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; avg| 169 =
-170 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; avg| 170 =
-171 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; avg| 175 =
-176 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; avg| 176 =
-177 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier =
New">---|--param|----range-|--samples</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
max|&nbsp; 73 - 74 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 228</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
max|&nbsp; 74 - 75 |&nbsp;&nbsp;&nbsp;&nbsp; 3834</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
max|&nbsp; 75 - 76 |&nbsp;&nbsp;&nbsp;&nbsp; 1219</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
max|&nbsp; 76 - 77 |&nbsp;&nbsp;&nbsp;&nbsp; 1070</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
max|&nbsp; 77 - 78 |&nbsp;&nbsp;&nbsp;&nbsp; 1261</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
max|&nbsp; 78 - 79 |&nbsp;&nbsp;&nbsp;&nbsp; 1338</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
max|&nbsp; 79 - 80 |&nbsp;&nbsp;&nbsp;&nbsp; 1163</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
max|&nbsp; 80 - 81 |&nbsp;&nbsp;&nbsp;&nbsp; 1727</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
max|&nbsp; 81 - 82 |&nbsp;&nbsp;&nbsp;&nbsp; 1312</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
max|&nbsp; 82 - 83 |&nbsp;&nbsp;&nbsp;&nbsp; 1264</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
max|&nbsp; 83 - 84 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 862</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
max|&nbsp; 84 - 85 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 388</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
max|&nbsp; 85 - 86 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 127</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
max|&nbsp; 86 - 87 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 39</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
max|&nbsp; 87 - 88 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 11</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
max|&nbsp; 88 - 89 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 10</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
max|&nbsp; 89 - 90 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 9</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
max|&nbsp; 90 - 91 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 8</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
max|&nbsp; 91 - 92 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 5</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
max|&nbsp; 92 - 93 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 9</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
max|&nbsp; 93 - 94 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 11</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
max|&nbsp; 94 - 95 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 15</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
max|&nbsp; 95 - 96 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 10</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
max|&nbsp; 96 - 97 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 11</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
max|&nbsp; 97 - 98 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 17</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
max|&nbsp; 98 - 99 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 12</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
max|&nbsp; 99 -100 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 22</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; max| 100 =
-101 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 18</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; max| 101 =
-102 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 16</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; max| 102 =
-103 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 26</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; max| 103 =
-104 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 31</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; max| 104 =
-105 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 42</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; max| 105 =
-106 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 50</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; max| 106 =
-107 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 30</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; max| 107 =
-108 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 29</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; max| 108 =
-109 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 34</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; max| 109 =
-110 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 11</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; max| 110 =
-111 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 15</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; max| 111 =
-112 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 16</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; max| 112 =
-113 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 16</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; max| 113 =
-114 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 38</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; max| 114 =
-115 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 32</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; max| 115 =
-116 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 36</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; max| 116 =
-117 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 26</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; max| 117 =
-118 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 29</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; max| 118 =
-119 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 32</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; max| 119 =
-120 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 32</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; max| 120 =
-121 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 32</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; max| 121 =
-122 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 23</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; max| 122 =
-123 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 20</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; max| 123 =
-124 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 10</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; max| 124 =
-125 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 12</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; max| 125 =
-126 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 11</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; max| 126 =
-127 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 14</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; max| 127 =
-128 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 18</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; max| 128 =
-129 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 16</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; max| 129 =
-130 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 28</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; max| 130 =
-131 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 59</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; max| 131 =
-132 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 74</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; max| 132 =
-133 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 54</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; max| 133 =
-134 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 29</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; max| 134 =
-135 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 14</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; max| 135 =
-136 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 7</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; max| 136 =
-137 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 11</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; max| 137 =
-138 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 16</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; max| 138 =
-139 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 31</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; max| 139 =
-140 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 81</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; max| 140 =
-141 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 554</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; max| 141 =
-142 |&nbsp;&nbsp;&nbsp;&nbsp; 1030</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; max| 142 =
-143 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 476</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; max| 143 =
-144 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 130</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; max| 144 =
-145 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 78</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; max| 145 =
-146 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 61</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; max| 146 =
-147 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 36</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; max| 147 =
-148 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 30</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; max| 148 =
-149 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 30</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; max| 149 =
-150 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 21</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; max| 150 =
-151 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 18</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; max| 151 =
-152 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 11</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; max| 152 =
-153 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 5</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; max| 153 =
-154 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 7</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; max| 154 =
-155 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 10</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; max| 155 =
-156 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 7</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; max| 156 =
-157 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 3</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; max| 157 =
-158 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 7</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; max| 158 =
-159 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 3</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; max| 159 =
-160 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 5</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; max| 160 =
-161 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 7</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; max| 161 =
-162 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 4</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; max| 162 =
-163 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 4</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; max| 163 =
-164 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 4</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; max| 164 =
-165 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; max| 165 =
-166 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; max| 167 =
-168 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; max| 168 =
-169 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; max| 169 =
-170 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; max| 170 =
-171 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; max| 175 =
-176 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; max| 176 =
-177 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier =
New">HSH|--param|--samples-|--average--|---stddev--</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSS|&nbsp;&nbsp;&nbsp; =
min|&nbsp;&nbsp;&nbsp;&nbsp; 19653|&nbsp;&nbsp;&nbsp;&nbsp; =
20.442|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 5.205</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSS|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 39307819|&nbsp;&nbsp;&nbsp;&nbsp; =
53.751|&nbsp;&nbsp;&nbsp;&nbsp; 17.180</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSS|&nbsp;&nbsp;&nbsp; =
max|&nbsp;&nbsp;&nbsp;&nbsp; 19653|&nbsp;&nbsp;&nbsp;&nbsp; =
88.757|&nbsp;&nbsp;&nbsp;&nbsp; 23.271</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier =
New">---|------------|------------|------------|--------|----------------=
---------</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier =
New">RTS|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
-8.003|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 53.782|&nbsp;&nbsp;&nbsp;&nbsp; =
176.073|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0|&nbsp;&nbsp;&nbsp; =
05:27:24/05:27:24</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Courier New">[Test_switch load]</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">RTH|-----lat min|-----lat =
avg|-----lat max|-overrun|----lat best|---lat worst</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier =
New">RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
4.481|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
36.495|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
79.713|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -4.801|&nbsp;&nbsp;&nbsp;&nbsp; =
106.604</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier =
New">RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
1.600|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
36.815|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
79.072|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -4.801|&nbsp;&nbsp;&nbsp;&nbsp; =
106.604</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier =
New">RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
8.963|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
36.495|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
78.752|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -4.801|&nbsp;&nbsp;&nbsp;&nbsp; =
106.604</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier =
New">RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
2.881|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
36.495|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
78.112|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -4.801|&nbsp;&nbsp;&nbsp;&nbsp; =
106.604</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier =
New">RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
8.003|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
36.495|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
78.752|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -4.801|&nbsp;&nbsp;&nbsp;&nbsp; =
106.604</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier =
New">RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
11.844|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
36.495|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
84.515|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -4.801|&nbsp;&nbsp;&nbsp;&nbsp; =
106.604</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier =
New">RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
1.280|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
36.495|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
79.072|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -4.801|&nbsp;&nbsp;&nbsp;&nbsp; =
106.604</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier =
New">RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
8.643|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
36.495|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
63.706|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -4.801|&nbsp;&nbsp;&nbsp;&nbsp; =
106.604</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier =
New">RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
2.881|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
36.495|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
77.792|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -4.801|&nbsp;&nbsp;&nbsp;&nbsp; =
106.604</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier =
New">RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
3.841|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
36.495|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
79.072|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -4.801|&nbsp;&nbsp;&nbsp;&nbsp; =
106.604</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier =
New">RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
8.003|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
36.495|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
82.594|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -4.801|&nbsp;&nbsp;&nbsp;&nbsp; =
106.604</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier =
New">RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
10.244|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
36.495|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
79.393|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -4.801|&nbsp;&nbsp;&nbsp;&nbsp; =
106.604</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier =
New">RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0.960|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
36.495|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
80.033|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -4.801|&nbsp;&nbsp;&nbsp;&nbsp; =
106.604</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier =
New">RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
8.643|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
36.495|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
81.954|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -4.801|&nbsp;&nbsp;&nbsp;&nbsp; =
106.604</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier =
New">RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
11.524|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
36.495|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
66.907|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -4.801|&nbsp;&nbsp;&nbsp;&nbsp; =
106.604</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier =
New">RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
1.600|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
36.495|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
79.713|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -4.801|&nbsp;&nbsp;&nbsp;&nbsp; =
106.604</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier =
New">RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
3.841|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
36.495|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
81.633|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -4.801|&nbsp;&nbsp;&nbsp;&nbsp; =
106.604</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier =
New">RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
9.283|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
36.495|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
79.072|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -4.801|&nbsp;&nbsp;&nbsp;&nbsp; =
106.604</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier =
New">RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
10.244|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
36.495|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
79.393|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -4.801|&nbsp;&nbsp;&nbsp;&nbsp; =
106.604</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier =
New">RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
1.280|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
36.495|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
79.393|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -4.801|&nbsp;&nbsp;&nbsp;&nbsp; =
106.604</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier =
New">RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
2.240|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
36.495|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
78.752|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -4.801|&nbsp;&nbsp;&nbsp;&nbsp; =
106.604</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">RTT|&nbsp; 01:15:34&nbsp; =
(periodic user-mode task, 500 us period, priority 99)</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">RTH|-----lat min|-----lat =
avg|-----lat max|-overrun|----lat best|---lat worst</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier =
New">RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
9.603|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
36.495|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
82.274|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -4.801|&nbsp;&nbsp;&nbsp;&nbsp; =
106.604</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier =
New">RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
8.643|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
36.495|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
82.914|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -4.801|&nbsp;&nbsp;&nbsp;&nbsp; =
106.604</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier =
New">RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
1.920|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
36.495|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
66.907|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -4.801|&nbsp;&nbsp;&nbsp;&nbsp; =
106.604</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier =
New">RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
5.442|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
36.495|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
82.594|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -4.801|&nbsp;&nbsp;&nbsp;&nbsp; =
106.604</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier =
New">RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
17.927|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
36.495|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
82.914|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -4.801|&nbsp;&nbsp;&nbsp;&nbsp; =
106.604</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier =
New">RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
2.240|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 36.495|&nbsp;&nbsp;&nbsp;&nbsp; =
104.363|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -4.801|&nbsp;&nbsp;&nbsp;&nbsp; =
106.604</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier =
New">RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
2.240|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
36.495|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
78.112|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -4.801|&nbsp;&nbsp;&nbsp;&nbsp; =
106.604</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier =
New">RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
9.283|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
36.495|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
82.914|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -4.801|&nbsp;&nbsp;&nbsp;&nbsp; =
106.604</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier =
New">RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
9.283|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
36.495|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
82.274|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -4.801|&nbsp;&nbsp;&nbsp;&nbsp; =
106.604</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier =
New">RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
10.884|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
36.495|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
77.472|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -4.801|&nbsp;&nbsp;&nbsp;&nbsp; =
106.604</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier =
New">RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
9.603|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
36.495|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
80.033|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -4.801|&nbsp;&nbsp;&nbsp;&nbsp; =
106.604</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier =
New">RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
9.924|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
36.495|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
85.475|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -4.801|&nbsp;&nbsp;&nbsp;&nbsp; =
106.604</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier =
New">RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
3.521|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
36.495|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
77.472|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -4.801|&nbsp;&nbsp;&nbsp;&nbsp; =
106.604</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier =
New">RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
9.283|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
36.495|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
63.386|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -4.801|&nbsp;&nbsp;&nbsp;&nbsp; =
106.604</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier =
New">RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
3.841|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
36.495|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
75.871|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -4.801|&nbsp;&nbsp;&nbsp;&nbsp; =
106.604</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier =
New">RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
9.283|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
36.495|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
81.954|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -4.801|&nbsp;&nbsp;&nbsp;&nbsp; =
106.604</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier =
New">RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
8.323|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
36.495|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
75.551|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -4.801|&nbsp;&nbsp;&nbsp;&nbsp; =
106.604</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier =
New">RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
2.561|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
36.495|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
78.432|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -4.801|&nbsp;&nbsp;&nbsp;&nbsp; =
106.604</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier =
New">---|--param|----range-|--samples</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
min|&nbsp;&nbsp; 0 -&nbsp; 1 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 135</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
min|&nbsp;&nbsp; 1 -&nbsp; 2 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 417</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
min|&nbsp;&nbsp; 2 -&nbsp; 3 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 655</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
min|&nbsp;&nbsp; 3 -&nbsp; 4 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 490</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
min|&nbsp;&nbsp; 4 -&nbsp; 5 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 172</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
min|&nbsp;&nbsp; 5 -&nbsp; 6 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
83</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
min|&nbsp;&nbsp; 6 -&nbsp; 7 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 125</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
min|&nbsp;&nbsp; 7 -&nbsp; 8 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 230</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
min|&nbsp;&nbsp; 8 -&nbsp; 9 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 528</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
min|&nbsp;&nbsp; 9 - 10 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 547</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
min|&nbsp; 10 - 11 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 577</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
min|&nbsp; 11 - 12 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 388</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
min|&nbsp; 12 - 13 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 157</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
min|&nbsp; 13 - 14 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 26</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
min|&nbsp; 14 - 15 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 3</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
min|&nbsp; 16 - 17 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 9</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
min|&nbsp; 17 - 18 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 10</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
min|&nbsp; 18 - 19 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
min|&nbsp; 20 - 21 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier =
New">---|--param|----range-|--samples</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp;&nbsp; 0 -&nbsp; 1 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 135</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp;&nbsp; 1 -&nbsp; 2 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 418</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp;&nbsp; 2 -&nbsp; 3 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 656</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp;&nbsp; 3 -&nbsp; 4 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 492</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp;&nbsp; 4 -&nbsp; 5 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 179</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp;&nbsp; 5 -&nbsp; 6 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
94</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp;&nbsp; 6 -&nbsp; 7 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 141</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp;&nbsp; 7 -&nbsp; 8 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 271</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp;&nbsp; 8 -&nbsp; 9 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 584</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp;&nbsp; 9 - 10 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 582</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 10 - 11 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 600</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 11 - 12 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 394</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 12 - 13 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 170</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 13 - 14 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 55</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 14 - 15 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 108</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 15 - 16 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 225</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 16 - 17 |&nbsp;&nbsp;&nbsp;&nbsp; 1880</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 17 - 18 |&nbsp;&nbsp;&nbsp;&nbsp; 1848</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 18 - 19 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 596</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 19 - 20 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 947</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 20 - 21 |&nbsp;&nbsp;&nbsp;&nbsp; 1024</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 21 - 22 |&nbsp;&nbsp;&nbsp;&nbsp; 1951</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 22 - 23 |&nbsp;&nbsp;&nbsp;&nbsp; 4472</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 23 - 24 |&nbsp;&nbsp;&nbsp;&nbsp; 7646</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 24 - 25 |&nbsp;&nbsp;&nbsp; 17268</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 25 - 26 |&nbsp;&nbsp;&nbsp; 17672</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 26 - 27 |&nbsp;&nbsp;&nbsp; 13704</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 27 - 28 |&nbsp;&nbsp;&nbsp;&nbsp; 6231</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 28 - 29 |&nbsp;&nbsp;&nbsp;&nbsp; 3641</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 29 - 30 |&nbsp;&nbsp;&nbsp;&nbsp; 2539</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 30 - 31 |&nbsp;&nbsp;&nbsp;&nbsp; 1987</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 31 - 32 |&nbsp;&nbsp;&nbsp;&nbsp; 1997</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 32 - 33 |&nbsp;&nbsp;&nbsp;&nbsp; 2816</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 33 - 34 |&nbsp;&nbsp;&nbsp;&nbsp; 2797</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 34 - 35 |&nbsp;&nbsp;&nbsp; 29055</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 35 - 36 |&nbsp; 1359783</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 36 - 37 |&nbsp; 5963432</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 37 - 38 |&nbsp; 1444786</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 38 - 39 |&nbsp;&nbsp;&nbsp; 73370</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 39 - 40 |&nbsp;&nbsp;&nbsp;&nbsp; 8495</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 40 - 41 |&nbsp;&nbsp;&nbsp; 13947</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 41 - 42 |&nbsp;&nbsp;&nbsp;&nbsp; 1479</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 42 - 43 |&nbsp;&nbsp;&nbsp;&nbsp; 1155</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 43 - 44 |&nbsp;&nbsp;&nbsp;&nbsp; 4746</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 44 - 45 |&nbsp;&nbsp;&nbsp;&nbsp; 7309</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 45 - 46 |&nbsp;&nbsp;&nbsp;&nbsp; 2100</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 46 - 47 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 423</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 47 - 48 |&nbsp;&nbsp;&nbsp;&nbsp; 1409</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 48 - 49 |&nbsp;&nbsp;&nbsp; 23428</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 49 - 50 |&nbsp;&nbsp;&nbsp;&nbsp; 8889</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 50 - 51 |&nbsp;&nbsp;&nbsp;&nbsp; 1799</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 51 - 52 |&nbsp;&nbsp;&nbsp;&nbsp; 2671</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 52 - 53 |&nbsp;&nbsp;&nbsp;&nbsp; 2964</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 53 - 54 |&nbsp;&nbsp;&nbsp;&nbsp; 1719</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 54 - 55 |&nbsp;&nbsp;&nbsp;&nbsp; 1051</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 55 - 56 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 590</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 56 - 57 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 348</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 57 - 58 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 81</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 58 - 59 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 123</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 59 - 60 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 128</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 60 - 61 |&nbsp;&nbsp;&nbsp;&nbsp; 1124</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 61 - 62 |&nbsp;&nbsp;&nbsp;&nbsp; 8847</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 62 - 63 |&nbsp;&nbsp;&nbsp; 21745</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 63 - 64 |&nbsp;&nbsp;&nbsp; 12408</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 64 - 65 |&nbsp;&nbsp;&nbsp;&nbsp; 1584</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 65 - 66 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 150</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 66 - 67 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 174</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 67 - 68 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 189</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 68 - 69 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 168</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 69 - 70 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 103</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 70 - 71 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 108</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 71 - 72 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 79</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 72 - 73 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 101</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 73 - 74 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 68</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 74 - 75 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 70</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 75 - 76 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 288</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 76 - 77 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 830</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 77 - 78 |&nbsp;&nbsp;&nbsp;&nbsp; 2039</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 78 - 79 |&nbsp;&nbsp;&nbsp;&nbsp; 2193</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 79 - 80 |&nbsp;&nbsp;&nbsp;&nbsp; 1235</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 80 - 81 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 981</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 81 - 82 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 617</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 82 - 83 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 498</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 83 - 84 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 394</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 84 - 85 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 541</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 85 - 86 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 346</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 86 - 87 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 188</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 87 - 88 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 22</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 88 - 89 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 8</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 90 - 91 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 4</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 91 - 92 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 92 - 93 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 93 - 94 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 94 - 95 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 3</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 95 - 96 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 5</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 96 - 97 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 10</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 97 - 98 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 17</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 98 - 99 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 8</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 99 -100 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 10</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; avg| 100 =
-101 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; avg| 101 =
-102 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 3</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; avg| 102 =
-103 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 3</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; avg| 103 =
-104 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 5</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; avg| 104 =
-105 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 3</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; avg| 105 =
-106 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; avg| 106 =
-107 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier =
New">---|--param|----range-|--samples</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
max|&nbsp; 62 - 63 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
max|&nbsp; 63 - 64 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 103</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
max|&nbsp; 64 - 65 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 51</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
max|&nbsp; 65 - 66 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 10</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
max|&nbsp; 66 - 67 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 15</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
max|&nbsp; 67 - 68 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 11</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
max|&nbsp; 68 - 69 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 11</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
max|&nbsp; 69 - 70 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 8</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
max|&nbsp; 70 - 71 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 4</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
max|&nbsp; 71 - 72 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 3</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
max|&nbsp; 72 - 73 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 5</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
max|&nbsp; 73 - 74 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 6</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
max|&nbsp; 74 - 75 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 11</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
max|&nbsp; 75 - 76 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 34</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
max|&nbsp; 76 - 77 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 124</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
max|&nbsp; 77 - 78 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 495</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
max|&nbsp; 78 - 79 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 736</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
max|&nbsp; 79 - 80 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 570</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
max|&nbsp; 80 - 81 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 437</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
max|&nbsp; 81 - 82 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 352</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
max|&nbsp; 82 - 83 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 343</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
max|&nbsp; 83 - 84 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 245</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
max|&nbsp; 84 - 85 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 386</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
max|&nbsp; 85 - 86 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 307</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
max|&nbsp; 86 - 87 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 176</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
max|&nbsp; 87 - 88 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 22</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
max|&nbsp; 88 - 89 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 8</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
max|&nbsp; 90 - 91 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 4</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
max|&nbsp; 91 - 92 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
max|&nbsp; 92 - 93 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
max|&nbsp; 93 - 94 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
max|&nbsp; 94 - 95 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 3</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
max|&nbsp; 95 - 96 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 5</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
max|&nbsp; 96 - 97 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 10</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
max|&nbsp; 97 - 98 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 17</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
max|&nbsp; 98 - 99 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 8</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
max|&nbsp; 99 -100 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 10</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; max| 100 =
-101 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; max| 101 =
-102 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 3</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; max| 102 =
-103 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 3</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; max| 103 =
-104 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 5</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; max| 104 =
-105 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 3</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; max| 105 =
-106 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; max| 106 =
-107 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier =
New">HSH|--param|--samples-|--average--|---stddev--</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSS|&nbsp;&nbsp;&nbsp; =
min|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 4554|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
6.250|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 3.820</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSS|&nbsp;&nbsp;&nbsp; =
avg|&nbsp;&nbsp; 9108577|&nbsp;&nbsp;&nbsp;&nbsp; =
36.167|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2.971</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSS|&nbsp;&nbsp;&nbsp; =
max|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 4554|&nbsp;&nbsp;&nbsp;&nbsp; =
79.952|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 5.061</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier =
New">---|------------|------------|------------|--------|----------------=
---------</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier =
New">RTS|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
-4.801|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 36.495|&nbsp;&nbsp;&nbsp;&nbsp; =
106.604|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0|&nbsp;&nbsp;&nbsp; =
01:15:53/01:15:53</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Courier New">[Xeno-test]</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">: cat =
/proc/xenomai/interfaces/native</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">0</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Courier New">Thu Jan&nbsp; 1 23:19:08 UTC =
1970</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">running: cat =
/proc/xenomai/interfaces/posix</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">Mem: 6308K used, 56196K free, 0K =
shrd, 0K buff, 2984K cached</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">Load average: 0.23 0.05 =
0.02&nbsp; (Status: S=3Dsleeping R=3Drunning, W=3Dwaiting)</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp; PID =
USER&nbsp;&nbsp;&nbsp;&nbsp; STATUS&nbsp;&nbsp; RSS&nbsp; PPID %MEM =
COMMAND</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp; 207 =
root&nbsp;&nbsp;&nbsp;&nbsp; S&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
872&nbsp;&nbsp;&nbsp;&nbsp; 1&nbsp; 1.3 sh</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp;1269 =
root&nbsp;&nbsp;&nbsp;&nbsp; R&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
700&nbsp; 1268&nbsp; 1.1 top</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp;1098 =
root&nbsp;&nbsp;&nbsp;&nbsp; S&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
660&nbsp;&nbsp; 207&nbsp; 1.0 xeno-test</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp; 176 daemon&nbsp;&nbsp; =
S&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 592&nbsp;&nbsp;&nbsp;&nbsp; =
1&nbsp; 0.9 portmap</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp;&nbsp;&nbsp; 1 =
root&nbsp;&nbsp;&nbsp;&nbsp; S&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
564&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp; 0.9 init</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp; 208 =
root&nbsp;&nbsp;&nbsp;&nbsp; S&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
548&nbsp;&nbsp;&nbsp;&nbsp; 1&nbsp; 0.8 syslogd</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp; 209 =
root&nbsp;&nbsp;&nbsp;&nbsp; S&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
532&nbsp;&nbsp;&nbsp;&nbsp; 1&nbsp; 0.8 klogd</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Courier New">-----Message =
d'origine-----</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">De : adeos-main-bounces@domain.hid =
[<A =
HREF=3D"mailto:adeos-main-bounces@domain.hid">mailto:adeos-main-bounces@domain.hid.=
org</A>]De la</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">part de Gilles =
Chanteperdrix</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">Envoy=E9 : lundi 4 juin 2007 =
19:40</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">=C0 : adeos-main</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">Objet : [Adeos-main] New I-pipe =
patch for ARM needs testing.</FONT>
</P>
<BR>
<BR>

<P><FONT SIZE=3D2 FACE=3D"Courier New">Hi,</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Courier New">in Xenomai repository (trunk and =
v2.3.x branch), you will find</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier =
New">adeos-ipipe-2.6.20-arm-1.7-03.patch, the latest version of the =
I-pipe</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">patch for ARM. In addition to =
merging support for two new boards (ixp4xx</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">and at91sam926x), this patch =
adds a few important features:</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">- the at91 patch now applies =
after the I-pipe patch with no reject ;</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">- it is now possible for Xenomai =
to preempt Linux during the mm switch,</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">which should improve Xenomai =
scheduling latency significantly;</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">- Xenomai is now able to access =
directly I-pipe tsc emulation in</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">user-space, providing a low =
overhead timing facility to user-space</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">applications.</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Courier New">Before including this patch in a =
new release, and because I could only</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">test the patch on at91rm9200, we =
would like people to test the patch on</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">their hardware and give us =
feedback about the stability and performance.</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">In order to adequately =
stress-test Linux mm context switch, please use</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">something along the lines of the =
attached test_switch.c.</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Courier New">As for tsc emulation in =
user-space, I only implemented it for machines</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">with a free-running counter, =
hoping that someone (maybe Sebastian or</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">Stelian ?) with hardware whose =
tsc is based on a decrementer could do</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">the work. This tsc emulation in =
user-space also required to rework a bit</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">Xenomai configure script: it is =
now necessary to pass a</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">--enable-arm-mach option to =
configure, and to pass the option</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">--enable-arm-tsc to enable the =
tsc.</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Courier New">Thanks in advance.</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Courier New">-- </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier =
New">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; Gilles Chanteperdrix</FONT>
</P>
<BR>

</BODY>
</HTML>
------_=_NextPart_002_01C7B4E3.A1FF664C--

------_=_NextPart_001_01C7B4E3.A1FF664C
Content-Type: application/octet-stream;
	name="adeos-ipipe-2.6.20-arm-AT91.patch"
Content-Transfer-Encoding: base64
Content-Description: adeos-ipipe-2.6.20-arm-AT91.patch
Content-Disposition: attachment;
	filename="adeos-ipipe-2.6.20-arm-AT91.patch"

U2V1bGVtZW50IGRhbnMgbGludXgtMi42LjIwLjEzLTkyNjMvYXJjaC9hcm0vbWFjaC1hdDkxcm05
MjAwOiBhdDkxcm05MjAwLmMub3JpZwpTZXVsZW1lbnQgZGFucyBsaW51eC0yLjYuMjAuMTMtOTI2
My9hcmNoL2FybS9tYWNoLWF0OTFybTkyMDA6IGF0OTFybTkyMDBfdGltZS5jLm9yaWcKU2V1bGVt
ZW50IGRhbnMgbGludXgtMi42LjIwLjEzLTkyNjMvYXJjaC9hcm0vbWFjaC1hdDkxcm05MjAwOiBh
dDkxc2FtOTI2MS5jLm9yaWcKZGlmZiAtYXVyZHBiQiAtWCBub2RpZmYgbGludXgtMi42LjIwLjEz
LTkyNjMtY2xlYW4vYXJjaC9hcm0vbWFjaC1hdDkxcm05MjAwL2F0OTFzYW05MjYzLmMgbGludXgt
Mi42LjIwLjEzLTkyNjMvYXJjaC9hcm0vbWFjaC1hdDkxcm05MjAwL2F0OTFzYW05MjYzLmMKLS0t
IGxpbnV4LTIuNi4yMC4xMy05MjYzLWNsZWFuL2FyY2gvYXJtL21hY2gtYXQ5MXJtOTIwMC9hdDkx
c2FtOTI2My5jCTIwMDctMDYtMTkgMTQ6MzI6MzcuMDAwMDAwMDAwICswMjAwCisrKyBsaW51eC0y
LjYuMjAuMTMtOTI2My9hcmNoL2FybS9tYWNoLWF0OTFybTkyMDAvYXQ5MXNhbTkyNjMuYwkyMDA3
LTA2LTE5IDE3OjUzOjE0LjAwMDAwMDAwMCArMDIwMApAQCAtMjgsNiArMjgsMTMgQEAgc3RhdGlj
IHN0cnVjdCBtYXBfZGVzYyBhdDkxc2FtOTI2M19pb19kZQogCQkubGVuZ3RoCQk9IFNaXzE2SywK
IAkJLnR5cGUJCT0gTVRfREVWSUNFLAogCX0sIHsKKyNpZmRlZiBDT05GSUdfSVBJUEUKKwkJLnZp
cnR1YWwJPSBBVDkxX1ZBX0JBU0VfVENCMCwKKwkJLnBmbgkJPSBfX3BoeXNfdG9fcGZuKEFUOTFT
QU05MjYzX0JBU0VfVENCMCksCisJCS5sZW5ndGgJCT0gU1pfMTZLLAorCQkudHlwZQkJPSBNVF9E
RVZJQ0UsCisgICAgICAgIH0sIHsKKyNlbmRpZiAvKiBDT05GSUdfSVBJUEUgKi8KIAkJLnZpcnR1
YWwJPSBBVDkxX0lPX1ZJUlRfQkFTRSAtIEFUOTFTQU05MjYzX1NSQU0wX1NJWkUsCiAJCS5wZm4J
CT0gX19waHlzX3RvX3BmbihBVDkxU0FNOTI2M19TUkFNMF9CQVNFKSwKIAkJLmxlbmd0aAkJPSBB
VDkxU0FNOTI2M19TUkFNMF9TSVpFLApAQCAtMjY2LDYgKzI3Myw3IEBAIHZvaWQgX19pbml0IGF0
OTFzYW05MjYzX2luaXRpYWxpemUodW5zaWcKICAqIFRoZSBkZWZhdWx0IGludGVycnVwdCBwcmlv
cml0eSBsZXZlbHMgKDAgPSBsb3dlc3QsIDcgPSBoaWdoZXN0KS4KICAqLwogc3RhdGljIHVuc2ln
bmVkIGludCBhdDkxc2FtOTI2M19kZWZhdWx0X2lycV9wcmlvcml0eVtOUl9BSUNfSVJRU10gX19p
bml0ZGF0YSA9IHsKKyNpZm5kZWYgQ09ORklHX0lQSVBFCiAJNywJLyogQWR2YW5jZWQgSW50ZXJy
dXB0IENvbnRyb2xsZXIgKEZJUSkgKi8KIAk3LAkvKiBTeXN0ZW0gUGVyaXBoZXJhbHMgKi8KIAkw
LAkvKiBQYXJhbGxlbCBJTyBDb250cm9sbGVyIEEgKi8KQEAgLTI5OCw2ICszMDYsNDIgQEAgc3Rh
dGljIHVuc2lnbmVkIGludCBhdDkxc2FtOTI2M19kZWZhdWx0XwogCTMsCS8qIFVTQiBIb3N0IHBv
cnQgKi8KIAkwLAkvKiBBZHZhbmNlZCBJbnRlcnJ1cHQgQ29udHJvbGxlciAoSVJRMCkgKi8KIAkw
LAkvKiBBZHZhbmNlZCBJbnRlcnJ1cHQgQ29udHJvbGxlciAoSVJRMSkgKi8KKyNlbHNlIC8qIENP
TkZJR19JUElQRSAqLworLyogR2l2ZSB0aGUgaGlnaGVzdCBwcmlvcml0eSB0byBUQywgc2luY2Ug
dGhleSBhcmUgdXNlZCBhcyB0aW1lciBpbnRlcnJ1cHQgYnkKKyAgIEktcGlwZS4gKi8KKwk3LAkv
KiBBZHZhbmNlZCBJbnRlcnJ1cHQgQ29udHJvbGxlciAoRklRKSAqLworCTcsCS8qIFN5c3RlbSBQ
ZXJpcGhlcmFscyAqLworCTAsCS8qIFBhcmFsbGVsIElPIENvbnRyb2xsZXIgQSAqLworCTAsCS8q
IFBhcmFsbGVsIElPIENvbnRyb2xsZXIgQiAqLworCTAsCS8qIFBhcmFsbGVsIElPIENvbnRyb2xs
ZXIgQywgRCBhbmQgRSAqLworCTAsCisJMCwKKwk2LAkvKiBVU0FSVCAwICovCisJNiwJLyogVVNB
UlQgMSAqLworCTYsCS8qIFVTQVJUIDIgKi8KKwkwLAkvKiBNdWx0aW1lZGlhIENhcmQgSW50ZXJm
YWNlIDAgKi8KKwkwLAkvKiBNdWx0aW1lZGlhIENhcmQgSW50ZXJmYWNlIDEgKi8KKwk0LAkvKiBD
QU4gKi8KKwkwLAkvKiBUd28tV2lyZSBJbnRlcmZhY2UgKi8KKwk2LAkvKiBTZXJpYWwgUGVyaXBo
ZXJhbCBJbnRlcmZhY2UgMCAqLworCTYsCS8qIFNlcmlhbCBQZXJpcGhlcmFsIEludGVyZmFjZSAx
ICovCisJNSwJLyogU2VyaWFsIFN5bmNocm9ub3VzIENvbnRyb2xsZXIgMCAqLworCTUsCS8qIFNl
cmlhbCBTeW5jaHJvbm91cyBDb250cm9sbGVyIDEgKi8KKwk2LAkvKiBBQzk3IENvbnRyb2xsZXIg
Ki8KKwk3LAkvKiBUaW1lciBDb3VudGVyIDAsIDEgYW5kIDIgKi8KKwkwLAkvKiBQdWxzZSBXaWR0
aCBNb2R1bGF0aW9uIENvbnRyb2xsZXIgKi8KKwkzLAkvKiBFdGhlcm5ldCAqLworCTAsCisJMCwJ
LyogMkQgR3JhcGhpYyBFbmdpbmUgKi8KKwkzLAkvKiBVU0IgRGV2aWNlIFBvcnQgKi8KKwkwLAkv
KiBJbWFnZSBTZW5zb3IgSW50ZXJmYWNlICovCisJMywJLyogTERDIENvbnRyb2xsZXIgKi8KKwkw
LAkvKiBETUEgQ29udHJvbGxlciAqLworCTAsCisJMywJLyogVVNCIEhvc3QgcG9ydCAqLworCTAs
CS8qIEFkdmFuY2VkIEludGVycnVwdCBDb250cm9sbGVyIChJUlEwKSAqLworCTAsCS8qIEFkdmFu
Y2VkIEludGVycnVwdCBDb250cm9sbGVyIChJUlExKSAqLworI2VuZGlmIC8qQ09ORklHX0lQSVBF
ICovCiB9OwogCiB2b2lkIF9faW5pdCBhdDkxc2FtOTI2M19pbml0X2ludGVycnVwdHModW5zaWdu
ZWQgaW50IHByaW9yaXR5W05SX0FJQ19JUlFTXSkKZGlmZiAtYXVyZHBiQiAtWCBub2RpZmYgbGlu
dXgtMi42LjIwLjEzLTkyNjMtY2xlYW4vYXJjaC9hcm0vbWFjaC1hdDkxcm05MjAwL2F0OTFzYW05
MjZ4X3RpbWUuYyBsaW51eC0yLjYuMjAuMTMtOTI2My9hcmNoL2FybS9tYWNoLWF0OTFybTkyMDAv
YXQ5MXNhbTkyNnhfdGltZS5jCi0tLSBsaW51eC0yLjYuMjAuMTMtOTI2My1jbGVhbi9hcmNoL2Fy
bS9tYWNoLWF0OTFybTkyMDAvYXQ5MXNhbTkyNnhfdGltZS5jCTIwMDctMDYtMTggMTQ6MTc6MTgu
MDAwMDAwMDAwICswMjAwCisrKyBsaW51eC0yLjYuMjAuMTMtOTI2My9hcmNoL2FybS9tYWNoLWF0
OTFybTkyMDAvYXQ5MXNhbTkyNnhfdGltZS5jCTIwMDctMDYtMjEgMTE6NDY6MTEuMDAwMDAwMDAw
ICswMjAwCkBAIC00Niw2ICs0NiwxMSBAQCBzdGF0aWMgdW5zaWduZWQgbG9uZyBsYXN0X2NydHI7
CiAjZGVmaW5lIEFUOTFfSURfVEMwIEFUOTFTQU05MjYxX0lEX1RDMAogI2RlZmluZSBBVDkxX0lE
X1RDMSBBVDkxU0FNOTI2MV9JRF9UQzEKICNkZWZpbmUgQVQ5MV9JRF9UQzIgQVQ5MVNBTTkyNjFf
SURfVEMyCisjZWxpZiBkZWZpbmVkKENPTkZJR19BUkNIX0FUOTFTQU05MjYzKQorI2luY2x1ZGUg
PGFzbS9hcmNoL2F0OTFzYW05MjYzLmg+CisjZGVmaW5lIEFUOTFfSURfVEMwIEFUOTFTQU05MjYz
X0lEX1RDQgorI2RlZmluZSBBVDkxX0lEX1RDMSBBVDkxU0FNOTI2M19JRF9UQ0IKKyNkZWZpbmUg
QVQ5MV9JRF9UQzIgQVQ5MVNBTTkyNjNfSURfVENCCiAjZWxzZQogI2Vycm9yICJVbnN1cHBvcnRl
ZCBBVDkxIHByb2Nlc3NvciIKICNlbmRpZgpAQCAtMTA3LDYgKzExMiw3IEBAIHN0YXRpYyBpbnQg
YXQ5MV90aW1lcl9pbml0aWFsaXplZDsKICAqIFJldHVybnMgbnVtYmVyIG9mIG1pY3Jvc2Vjb25k
cyBzaW5jZSBsYXN0IHRpbWVyIGludGVycnVwdC4gIE5vdGUgdGhhdCBpbnRlcnJ1cHRzCiAgKiB3
aWxsIGhhdmUgYmVlbiBkaXNhYmxlZCBieSBkb19nZXR0aW1lb2ZkYXkoKQogICogICdMQVRDSCcg
aXMgaHdjbG9jayB0aWNrcyAoc2VlIENMT0NLX1RJQ0tfUkFURSBpbiB0aW1leC5oKSBwZXIgamlm
ZnkuCisgKiAgJ3RpY2snIGlzIHVzZWNzIHBlciBqaWZmeSAobGludXgvdGltZXguaCkuCiAgKi8K
IHN0YXRpYyB1bnNpZ25lZCBsb25nIGF0OTFzYW05MjZ4X2dldHRpbWVvZmZzZXQodm9pZCkKIHsK
QEAgLTExNSw3ICsxMjEsNyBAQCBzdGF0aWMgdW5zaWduZWQgbG9uZyBhdDkxc2FtOTI2eF9nZXR0
aW1lCiAKIAllbGFwc2VkID0gKFBJVF9QSUNOVCh0KSAqIExBVENIKSArIFBJVF9DUElWKHQpOwkJ
LyogaGFyZHdhcmUgY2xvY2sgY3ljbGVzICovCiAKLQlyZXR1cm4gKHVuc2lnbmVkIGxvbmcpKGVs
YXBzZWQgKiBqaWZmaWVzX3RvX3VzZWNzKDEpKSAvIExBVENIOworCXJldHVybiAodW5zaWduZWQg
bG9uZykoZWxhcHNlZCAqIDEwMDAwMDApIC8gTEFUQ0g7CiB9CiAKIC8qCkBAIC0zNTcsMTQgKzM2
Myw5IEBAIHN0YXRpYyBzdHJ1Y3QgaXJxYWN0aW9uIGF0OTFzYW05MjZ4X3RpbWUKIAkuaGFuZGxl
cgk9ICZhdDkxc2FtOTI2eF90aW1lcl9pbnRlcnJ1cHQKIH07CiAKLXN0YXRpYyBjaGFyIGNsa19u
YW1lIFtdID0gInRjJSI7CitzdGF0aWMgY2hhciBjbGtfbmFtZSBbXSA9ICJ0YyVfY2xrIjsKIAot
c3RhdGljIHN0cnVjdCBjbGsgdGMgPSB7Ci0JLm5hbWUJCT0gKGNvbnN0IGNoYXIgKikgY2xrX25h
bWUsCi0JLnVzZXJzICAgICAgICAgID0gMCwKLQkudHlwZQkJPSBDTEtfVFlQRV9QRVJJUEhFUkFM
LAotCS5wbWNfbWFzayAgICAgICA9IDEgPDwgKEtFUk5FTF9USU1FUl9JUlFfTlVNKSwKLX07Citz
dGF0aWMgc3RydWN0IGNsayAqdGM7CiAKIHZvaWQgX19pbml0IGF0OTFzYW05MjZ4X3RpbWVyX2lu
aXQodm9pZCkKIHsKQEAgLTM3Myw5ICszNzQsMTkgQEAgdm9pZCBfX2luaXQgYXQ5MXNhbTkyNnhf
dGltZXJfaW5pdCh2b2lkKQogCWlmIChjbGtfZ2V0X3JhdGUoY2xrX2dldChOVUxMLCAibWNrIikp
ICE9IENPTkZJR19JUElQRV9BVDkxX01DSykKIAkJYXQ5MXNhbTkyNnhfdGltZXJfaXJxLmhhbmRs
ZXIgPSAmYXQ5MXNhbTkyNnhfYmFkX2ZyZXE7CiAKLQlzbnByaW50ZihjbGtfbmFtZSwgc2l6ZW9m
KGNsa19uYW1lKSwgInRjJWQiLCBDT05GSUdfSVBJUEVfQVQ5MV9UQyk7Ci0JY2xrX3JlZ2lzdGVy
KCZ0Yyk7Ci0JY2xrX2VuYWJsZSgmdGMpOworCS8qIHNpbmNlIDIuNi4yMC1hdDkxLnBhdGNoLCBh
bGwgY2xvY2tzIGFyZSByZWdpc3RlcmVkIG9uIHN0YXJ0dXAuCisJICogd2UganVzdCBuZWVkIHRv
IGdldCB0aGUgZ29vZCBzdHJ1Y3QgYW5kIGVuYWJsZSBvdXIgdGMgY2xvY2sgKi8KKyNpZmRlZiBD
T05GSUdfQVJDSF9BVDkxU0FNOTI2MworCXNucHJpbnRmKGNsa19uYW1lLCBzaXplb2YoY2xrX25h
bWUpLCAidGNiX2NsayIpOworI2Vsc2UKKwlzbnByaW50ZihjbGtfbmFtZSwgc2l6ZW9mKGNsa19u
YW1lKSwgInRjJWRfY2xrIiwgQ09ORklHX0lQSVBFX0FUOTFfVEMpOworI2VuZGlmIC8qIENPTkZJ
R19BUkNIX0FUOTFTQU05MjYzICovCisKKwl0YyA9IGNsa19nZXQoTlVMTCwgY2xrX25hbWUpOwor
CWlmKChpbnQpdGMgPT0gMHhmZmZmZmZmZSkJLy9lcnIgY29kZQorCQlwcmludGsoIj4gJXMgZG9l
cyBub3QgZXhpc3QuIixjbGtfbmFtZSk7CisJZWxzZQorCQljbGtfZW5hYmxlKHRjKTsKIAkKIAkv
KiBObyBTeW5jLiAqLwogCWF0OTFfdGNfd3JpdGUoQVQ5MV9UQ19CQ1IsIDApOwpTZXVsZW1lbnQg
ZGFucyBsaW51eC0yLjYuMjAuMTMtOTI2My9hcmNoL2FybS9tYWNoLWF0OTFybTkyMDA6IGF0OTFz
YW05MjZ4X3RpbWUuYy5vcmlnCmRpZmYgLWF1cmRwYkIgLVggbm9kaWZmIGxpbnV4LTIuNi4yMC4x
My05MjYzLWNsZWFuL2FyY2gvYXJtL21hY2gtYXQ5MXJtOTIwMC9LY29uZmlnIGxpbnV4LTIuNi4y
MC4xMy05MjYzL2FyY2gvYXJtL21hY2gtYXQ5MXJtOTIwMC9LY29uZmlnCi0tLSBsaW51eC0yLjYu
MjAuMTMtOTI2My1jbGVhbi9hcmNoL2FybS9tYWNoLWF0OTFybTkyMDAvS2NvbmZpZwkyMDA3LTA2
LTE4IDE0OjE3OjE4LjAwMDAwMDAwMCArMDIwMAorKysgbGludXgtMi42LjIwLjEzLTkyNjMvYXJj
aC9hcm0vbWFjaC1hdDkxcm05MjAwL0tjb25maWcJMjAwNy0wNi0xOSAxNzo1NzozNC4wMDAwMDAw
MDAgKzAyMDAKQEAgLTE1Myw2ICsxNTMsNyBAQCBjb25maWcgSVBJUEVfQVQ5MV9NQ0sKIAlkZWZh
dWx0IDQ2MDgwMDAwIGlmIE1BQ0hfQ1NCNjM3CiAJZGVmYXVsdCA1OTkwNDAwMCBpZiBNQUNIX0FU
OTFSTTkyMDBFSwogCWRlZmF1bHQgOTkzMjgwMDAgaWYgTUFDSF9BVDkxU0FNOTI2MEVLIHx8IE1B
Q0hfQVQ5MVNBTTkyNjFFSworCWRlZmF1bHQgOTk5NTk1ODkgaWYgTUFDSF9BVDkxU0FNOTI2M0VL
CiAJZGVmYXVsdCA1MzAwMDAwMAogCWhlbHAKIAlXaGVuIEFkZW9zIGludGVycnVwdCBwaXBlbGlu
ZSBpcyBlbmFibGVkLCBBVDkxIHRpbWVyIGlzIGJhc2VkIG9uClNldWxlbWVudCBkYW5zIGxpbnV4
LTIuNi4yMC4xMy05MjYzL2FyY2gvYXJtL21hY2gtYXQ5MXJtOTIwMDogS2NvbmZpZy5vcmlnClNl
dWxlbWVudCBkYW5zIGxpbnV4LTIuNi4yMC4xMy05MjYzL2RyaXZlcnMvY2hhcjogY29uc29sZW1h
cF9kZWZ0YmwuYwpTZXVsZW1lbnQgZGFucyBsaW51eC0yLjYuMjAuMTMtOTI2My9kcml2ZXJzL2No
YXI6IGRlZmtleW1hcC5jClNldWxlbWVudCBkYW5zIGxpbnV4LTIuNi4yMC4xMy05MjYzL2luY2x1
ZGU6IGFzbQpkaWZmIC1hdXJkcGJCIC1YIG5vZGlmZiBsaW51eC0yLjYuMjAuMTMtOTI2My1jbGVh
bi9pbmNsdWRlL2FzbS1hcm0vYXJjaC9oYXJkd2FyZS5oIGxpbnV4LTIuNi4yMC4xMy05MjYzL2lu
Y2x1ZGUvYXNtLWFybS9hcmNoL2hhcmR3YXJlLmgKLS0tIGxpbnV4LTIuNi4yMC4xMy05MjYzLWNs
ZWFuL2luY2x1ZGUvYXNtLWFybS9hcmNoL2hhcmR3YXJlLmgJMjAwNy0wNi0xOCAxNDoxNzoxOC4w
MDAwMDAwMDAgKzAyMDAKKysrIGxpbnV4LTIuNi4yMC4xMy05MjYzL2luY2x1ZGUvYXNtLWFybS9h
cmNoL2hhcmR3YXJlLmgJMjAwNy0wNi0xOSAxNjoyNTo0OC4wMDAwMDAwMDAgKzAyMDAKQEAgLTUz
LDcgKzUzLDkgQEAKICNkZWZpbmUgQVQ5MV9CQVNFX1RDQjAgICAgICAgQVQ5MVNBTTkyNjBfQkFT
RV9UQ0IwCiAjZWxpZiBkZWZpbmVkKENPTkZJR19BUkNIX0FUOTFTQU05MjYxKQogI2RlZmluZSBB
VDkxX0JBU0VfVENCMCAgICAgICBBVDkxU0FNOTI2MV9CQVNFX1RDQjAKLSNlbmRpZiAvKiBDT05G
SUdfQVJDSF9BVDkxU0FNOTI2MSAqLworI2VsaWYgZGVmaW5lZChDT05GSUdfQVJDSF9BVDkxU0FN
OTI2MykKKyNkZWZpbmUgQVQ5MV9CQVNFX1RDQjAgICAgICAgQVQ5MVNBTTkyNjNfQkFTRV9UQ0Iw
CisjZW5kaWYgLyogQ09ORklHX0FSQ0hfQVQ5MSAqLwogI2RlZmluZSBBVDkxX1ZBX0JBU0VfVENC
MCAgICBBVDkxX0lPX1AyVihBVDkxX0JBU0VfVENCMCkKICNlbmRpZiAvKiBDT05GSUdfSVBJUEUg
Ki8KIApTZXVsZW1lbnQgZGFucyBsaW51eC0yLjYuMjAuMTMtOTI2My9pbmNsdWRlL2FzbS1hcm0v
YXJjaDogaGFyZHdhcmUuaC5vcmlnCmRpZmYgLWF1cmRwYkIgLVggbm9kaWZmIGxpbnV4LTIuNi4y
MC4xMy05MjYzLWNsZWFuL2luY2x1ZGUvYXNtLWFybS9hcmNoL2lycXMuaCBsaW51eC0yLjYuMjAu
MTMtOTI2My9pbmNsdWRlL2FzbS1hcm0vYXJjaC9pcnFzLmgKLS0tIGxpbnV4LTIuNi4yMC4xMy05
MjYzLWNsZWFuL2luY2x1ZGUvYXNtLWFybS9hcmNoL2lycXMuaAkyMDA3LTA2LTE4IDE0OjE3OjE4
LjAwMDAwMDAwMCArMDIwMAorKysgbGludXgtMi42LjIwLjEzLTkyNjMvaW5jbHVkZS9hc20tYXJt
L2FyY2gvaXJxcy5oCTIwMDctMDYtMTggMTQ6MzU6NTQuMDAwMDAwMDAwICswMjAwCkBAIC01NSw3
ICs1NSwxMSBAQCBleHRlcm4gdW5zaWduZWQgX19pcGlwZV9hdDkxX2dwaW9fYmFua3M7CiAjZWxp
ZiBkZWZpbmVkKENPTkZJR19BUkNIX0FUOTFTQU05MjYxKQogI2RlZmluZSBfX2lwaXBlX21hY2hf
aXJxX211eF9wKGlycSkJCQkJCVwKIAkoKHVuc2lnbmVkKSAoaXJxIC0gQVQ5MVNBTTkyNjFfSURf
UElPQSkgPCBfX2lwaXBlX2F0OTFfZ3Bpb19iYW5rcykKLSNlbmRpZiAvKiBDT05GSUdfQVJDSF9B
VDkxU0FNOTI2MSAqLworCisjZWxpZiBkZWZpbmVkKENPTkZJR19BUkNIX0FUOTFTQU05MjYzKQor
I2RlZmluZSBfX2lwaXBlX21hY2hfaXJxX211eF9wKGlycSkJCQkJCVwKKwkoKHVuc2lnbmVkKSAo
aXJxIC0gQVQ5MVNBTTkyNjNfSURfUElPQSkgPCBfX2lwaXBlX2F0OTFfZ3Bpb19iYW5rcykKKyNl
bmRpZiAvKiBDT05GSUdfQVJDSF9BVDkxICovCiAKICNlbmRpZiAvKiBDT05GSUdfSVBJUEUgJiYg
IV9fQVNTRU1CTFlfXyAqLwogClNldWxlbWVudCBkYW5zIGxpbnV4LTIuNi4yMC4xMy05MjYzL2lu
Y2x1ZGUvYXNtLWFybS9hcmNoOiBpcnFzLmgub3JpZwpTZXVsZW1lbnQgZGFucyBsaW51eC0yLjYu
MjAuMTMtOTI2My9pbmNsdWRlL2FzbS1hcm0vYXJjaDogdGltZXguaC5vcmlnCmRpZmYgLWF1cmRw
YkIgLVggbm9kaWZmIGxpbnV4LTIuNi4yMC4xMy05MjYzLWNsZWFuL2luY2x1ZGUvYXNtLWFybS9h
cmNoLWF0OTFybTkyMDAvaGFyZHdhcmUuaCBsaW51eC0yLjYuMjAuMTMtOTI2My9pbmNsdWRlL2Fz
bS1hcm0vYXJjaC1hdDkxcm05MjAwL2hhcmR3YXJlLmgKLS0tIGxpbnV4LTIuNi4yMC4xMy05MjYz
LWNsZWFuL2luY2x1ZGUvYXNtLWFybS9hcmNoLWF0OTFybTkyMDAvaGFyZHdhcmUuaAkyMDA3LTA2
LTE4IDE0OjE3OjE4LjAwMDAwMDAwMCArMDIwMAorKysgbGludXgtMi42LjIwLjEzLTkyNjMvaW5j
bHVkZS9hc20tYXJtL2FyY2gtYXQ5MXJtOTIwMC9oYXJkd2FyZS5oCTIwMDctMDYtMTkgMTY6MjU6
NDguMDAwMDAwMDAwICswMjAwCkBAIC01Myw3ICs1Myw5IEBACiAjZGVmaW5lIEFUOTFfQkFTRV9U
Q0IwICAgICAgIEFUOTFTQU05MjYwX0JBU0VfVENCMAogI2VsaWYgZGVmaW5lZChDT05GSUdfQVJD
SF9BVDkxU0FNOTI2MSkKICNkZWZpbmUgQVQ5MV9CQVNFX1RDQjAgICAgICAgQVQ5MVNBTTkyNjFf
QkFTRV9UQ0IwCi0jZW5kaWYgLyogQ09ORklHX0FSQ0hfQVQ5MVNBTTkyNjEgKi8KKyNlbGlmIGRl
ZmluZWQoQ09ORklHX0FSQ0hfQVQ5MVNBTTkyNjMpCisjZGVmaW5lIEFUOTFfQkFTRV9UQ0IwICAg
ICAgIEFUOTFTQU05MjYzX0JBU0VfVENCMAorI2VuZGlmIC8qIENPTkZJR19BUkNIX0FUOTEgKi8K
ICNkZWZpbmUgQVQ5MV9WQV9CQVNFX1RDQjAgICAgQVQ5MV9JT19QMlYoQVQ5MV9CQVNFX1RDQjAp
CiAjZW5kaWYgLyogQ09ORklHX0lQSVBFICovCiAKU2V1bGVtZW50IGRhbnMgbGludXgtMi42LjIw
LjEzLTkyNjMvaW5jbHVkZS9hc20tYXJtL2FyY2gtYXQ5MXJtOTIwMDogaGFyZHdhcmUuaC5vcmln
CmRpZmYgLWF1cmRwYkIgLVggbm9kaWZmIGxpbnV4LTIuNi4yMC4xMy05MjYzLWNsZWFuL2luY2x1
ZGUvYXNtLWFybS9hcmNoLWF0OTFybTkyMDAvaXJxcy5oIGxpbnV4LTIuNi4yMC4xMy05MjYzL2lu
Y2x1ZGUvYXNtLWFybS9hcmNoLWF0OTFybTkyMDAvaXJxcy5oCi0tLSBsaW51eC0yLjYuMjAuMTMt
OTI2My1jbGVhbi9pbmNsdWRlL2FzbS1hcm0vYXJjaC1hdDkxcm05MjAwL2lycXMuaAkyMDA3LTA2
LTE4IDE0OjE3OjE4LjAwMDAwMDAwMCArMDIwMAorKysgbGludXgtMi42LjIwLjEzLTkyNjMvaW5j
bHVkZS9hc20tYXJtL2FyY2gtYXQ5MXJtOTIwMC9pcnFzLmgJMjAwNy0wNi0xOCAxNDozNTo1NC4w
MDAwMDAwMDAgKzAyMDAKQEAgLTU1LDcgKzU1LDExIEBAIGV4dGVybiB1bnNpZ25lZCBfX2lwaXBl
X2F0OTFfZ3Bpb19iYW5rczsKICNlbGlmIGRlZmluZWQoQ09ORklHX0FSQ0hfQVQ5MVNBTTkyNjEp
CiAjZGVmaW5lIF9faXBpcGVfbWFjaF9pcnFfbXV4X3AoaXJxKQkJCQkJXAogCSgodW5zaWduZWQp
IChpcnEgLSBBVDkxU0FNOTI2MV9JRF9QSU9BKSA8IF9faXBpcGVfYXQ5MV9ncGlvX2JhbmtzKQot
I2VuZGlmIC8qIENPTkZJR19BUkNIX0FUOTFTQU05MjYxICovCisKKyNlbGlmIGRlZmluZWQoQ09O
RklHX0FSQ0hfQVQ5MVNBTTkyNjMpCisjZGVmaW5lIF9faXBpcGVfbWFjaF9pcnFfbXV4X3AoaXJx
KQkJCQkJXAorCSgodW5zaWduZWQpIChpcnEgLSBBVDkxU0FNOTI2M19JRF9QSU9BKSA8IF9faXBp
cGVfYXQ5MV9ncGlvX2JhbmtzKQorI2VuZGlmIC8qIENPTkZJR19BUkNIX0FUOTEgKi8KIAogI2Vu
ZGlmIC8qIENPTkZJR19JUElQRSAmJiAhX19BU1NFTUJMWV9fICovCiAKU2V1bGVtZW50IGRhbnMg
bGludXgtMi42LjIwLjEzLTkyNjMvaW5jbHVkZS9hc20tYXJtL2FyY2gtYXQ5MXJtOTIwMDogaXJx
cy5oLm9yaWcKU2V1bGVtZW50IGRhbnMgbGludXgtMi42LjIwLjEzLTkyNjMvaW5jbHVkZS9hc20t
YXJtL2FyY2gtYXQ5MXJtOTIwMDogdGltZXguaC5vcmlnClNldWxlbWVudCBkYW5zIGxpbnV4LTIu
Ni4yMC4xMy05MjYzL2luY2x1ZGU6IGNvbmZpZwpTZXVsZW1lbnQgZGFucyBsaW51eC0yLjYuMjAu
MTMtOTI2My9pbmNsdWRlL2xpbnV4OiBhdXRvY29uZi5oClNldWxlbWVudCBkYW5zIGxpbnV4LTIu
Ni4yMC4xMy05MjYzL2luY2x1ZGUvbGludXg6IGNvbXBpbGUuaApTZXVsZW1lbnQgZGFucyBsaW51
eC0yLjYuMjAuMTMtOTI2My9pbmNsdWRlL2xpbnV4OiB1dHNyZWxlYXNlLmgKU2V1bGVtZW50IGRh
bnMgbGludXgtMi42LjIwLjEzLTkyNjMvaW5jbHVkZS9saW51eDogdmVyc2lvbi5oClNldWxlbWVu
dCBkYW5zIGxpbnV4LTIuNi4yMC4xMy05MjYzL2xpYjogY3JjMzJ0YWJsZS5oClNldWxlbWVudCBk
YW5zIGxpbnV4LTIuNi4yMC4xMy05MjYzL2xpYjogZ2VuX2NyYzMydGFibGUKU2V1bGVtZW50IGRh
bnMgbGludXgtMi42LjIwLjEzLTkyNjMvc2NyaXB0cy9iYXNpYzogZG9jcHJvYwpTZXVsZW1lbnQg
ZGFucyBsaW51eC0yLjYuMjAuMTMtOTI2My9zY3JpcHRzL2Jhc2ljOiBmaXhkZXAKU2V1bGVtZW50
IGRhbnMgbGludXgtMi42LjIwLjEzLTkyNjMvc2NyaXB0czogYmluMmMKU2V1bGVtZW50IGRhbnMg
bGludXgtMi42LjIwLjEzLTkyNjMvc2NyaXB0czogY29ubWFrZWhhc2gKU2V1bGVtZW50IGRhbnMg
bGludXgtMi42LjIwLjEzLTkyNjMvc2NyaXB0czoga2FsbHN5bXMKU2V1bGVtZW50IGRhbnMgbGlu
dXgtMi42LjIwLjEzLTkyNjMvc2NyaXB0cy9rY29uZmlnOiBjb25mClNldWxlbWVudCBkYW5zIGxp
bnV4LTIuNi4yMC4xMy05MjYzL3NjcmlwdHMva2NvbmZpZzogbGV4Lnpjb25mLmMKU2V1bGVtZW50
IGRhbnMgbGludXgtMi42LjIwLjEzLTkyNjMvc2NyaXB0cy9rY29uZmlnOiB6Y29uZi5oYXNoLmMK
U2V1bGVtZW50IGRhbnMgbGludXgtMi42LjIwLjEzLTkyNjMvc2NyaXB0cy9rY29uZmlnOiB6Y29u
Zi50YWIuYwpTZXVsZW1lbnQgZGFucyBsaW51eC0yLjYuMjAuMTMtOTI2My9zY3JpcHRzL21vZDog
ZWxmY29uZmlnLmgKU2V1bGVtZW50IGRhbnMgbGludXgtMi42LjIwLjEzLTkyNjMvc2NyaXB0cy9t
b2Q6IG1rX2VsZmNvbmZpZwpTZXVsZW1lbnQgZGFucyBsaW51eC0yLjYuMjAuMTMtOTI2My9zY3Jp
cHRzL21vZDogbW9kcG9zdApTZXVsZW1lbnQgZGFucyBsaW51eC0yLjYuMjAuMTMtOTI2My91c3I6
IGdlbl9pbml0X2NwaW8K

------_=_NextPart_001_01C7B4E3.A1FF664C
Content-Type: application/octet-stream;
	name="2.6.20-at91-macb-9263.patch"
Content-Transfer-Encoding: base64
Content-Description: 2.6.20-at91-macb-9263.patch
Content-Disposition: attachment;
	filename="2.6.20-at91-macb-9263.patch"

ZGlmZiAtYXVyZHBiQiAtWCBub2RpZmYgbGludXgtMi42LjIwLjEzLWNsZWFuL2FyY2gvYXJtL21h
Y2gtYXQ5MXJtOTIwMC9hdDkxc2FtOTI2MC5jIGxpbnV4LTIuNi4yMC4xMy9hcmNoL2FybS9tYWNo
LWF0OTFybTkyMDAvYXQ5MXNhbTkyNjAuYwotLS0gbGludXgtMi42LjIwLjEzLWNsZWFuL2FyY2gv
YXJtL21hY2gtYXQ5MXJtOTIwMC9hdDkxc2FtOTI2MC5jCTIwMDctMDYtMTggMTg6MDg6NDMuMDAw
MDAwMDAwICswMjAwCisrKyBsaW51eC0yLjYuMjAuMTMvYXJjaC9hcm0vbWFjaC1hdDkxcm05MjAw
L2F0OTFzYW05MjYwLmMJMjAwNy0wNi0xOCAxNjozNToyMy4wMDAwMDAwMDAgKzAyMDAKQEAgLTEy
OCw3ICsxMjgsNyBAQCBzdGF0aWMgc3RydWN0IGNsayBvaGNpX2NsayA9IHsKIAkudHlwZQkJPSBD
TEtfVFlQRV9QRVJJUEhFUkFMLAogfTsKIHN0YXRpYyBzdHJ1Y3QgY2xrIGV0aGVyX2NsayA9IHsK
LQkubmFtZQkJPSAiZXRoZXJfY2xrIiwKKwkubmFtZQkJPSAibWFjYl9jbGsiLAogCS5wbWNfbWFz
awk9IDEgPDwgQVQ5MVNBTTkyNjBfSURfRU1BQywKIAkudHlwZQkJPSBDTEtfVFlQRV9QRVJJUEhF
UkFMLAogfTsKZGlmZiAtYXVyZHBiQiAtWCBub2RpZmYgbGludXgtMi42LjIwLjEzLWNsZWFuL2Fy
Y2gvYXJtL21hY2gtYXQ5MXJtOTIwMC9hdDkxc2FtOTI2MF9kZXZpY2VzLmMgbGludXgtMi42LjIw
LjEzL2FyY2gvYXJtL21hY2gtYXQ5MXJtOTIwMC9hdDkxc2FtOTI2MF9kZXZpY2VzLmMKLS0tIGxp
bnV4LTIuNi4yMC4xMy1jbGVhbi9hcmNoL2FybS9tYWNoLWF0OTFybTkyMDAvYXQ5MXNhbTkyNjBf
ZGV2aWNlcy5jCTIwMDctMDYtMTggMTg6MDg6NDMuMDAwMDAwMDAwICswMjAwCisrKyBsaW51eC0y
LjYuMjAuMTMvYXJjaC9hcm0vbWFjaC1hdDkxcm05MjAwL2F0OTFzYW05MjYwX2RldmljZXMuYwky
MDA3LTA2LTE4IDE2OjM1OjIzLjAwMDAwMDAwMCArMDIwMApAQCAtMTksNiArMTksNyBAQAogI2lu
Y2x1ZGUgPGFzbS9hcmNoL2F0OTFzYW05MjYwLmg+CiAjaW5jbHVkZSA8YXNtL2FyY2gvYXQ5MXNh
bTkyNnhfbWMuaD4KICNpbmNsdWRlIDxhc20vYXJjaC9hdDkxc2FtOTI2MF9tYXRyaXguaD4KKyNp
bmNsdWRlIDxhc20vYXJjaC9jcHUuaD4KIAogI2luY2x1ZGUgImdlbmVyaWMuaCIKIApAQCAtMTQx
LDYgKzE0MiwxMSBAQCBzdGF0aWMgc3RydWN0IHJlc291cmNlIGV0aF9yZXNvdXJjZXNbXSA9CiAJ
CS5lbmQJPSBBVDkxU0FNOTI2MF9JRF9FTUFDLAogCQkuZmxhZ3MJPSBJT1JFU09VUkNFX0lSUSwK
IAl9LAorCVsyXSA9IHsKKwkJLnN0YXJ0CT0gQVQ5MVNBTTkyNjBfU1JBTTBfQkFTRSwKKwkJLmVu
ZAk9IEFUOTFTQU05MjYwX1NSQU0wX0JBU0UgKyBBVDkxU0FNOTI2MF9TUkFNMF9TSVpFIC0xLAor
CQkuZmxhZ3MJPSBJT1JFU09VUkNFX01FTSwKKwl9LAogfTsKIAogc3RhdGljIHN0cnVjdCBwbGF0
Zm9ybV9kZXZpY2UgYXQ5MXNhbTkyNjBfZXRoX2RldmljZSA9IHsKQEAgLTE1Nyw2ICsxNjMsOCBA
QCBzdGF0aWMgc3RydWN0IHBsYXRmb3JtX2RldmljZSBhdDkxc2FtOTI2CiAKIHZvaWQgX19pbml0
IGF0OTFfYWRkX2RldmljZV9ldGgoc3RydWN0IGF0OTFfZXRoX2RhdGEgKmRhdGEpCiB7CisJdW5z
aWduZWQgaW50IGNpZHIsIHNyYW1fc2l6ZTsKKwogCWlmICghZGF0YSkKIAkJcmV0dXJuOwogCkBA
IC0xODgsNiArMTk2LDI0IEBAIHZvaWQgX19pbml0IGF0OTFfYWRkX2RldmljZV9ldGgoc3RydWN0
IGEKIAkJYXQ5MV9zZXRfQl9wZXJpcGgoQVQ5MV9QSU5fUEEyMiwgMCk7CS8qIEVUWEVSICovCiAJ
fQogCisJaWYoIGNwdV9pc19hdDkxc2FtOTI2MCgpICkgeworCisKKwkJY2lkciA9IGF0OTFfc3lz
X3JlYWQoQVQ5MV9EQkdVX0NJRFIpOworCisJCXN3aXRjaCAoY2lkciAmIEFUOTFfQ0lEUl9TUkFN
U0laKSB7CisJCQljYXNlIEFUOTFfQ0lEUl9TUkFNU0laXzMySzoKKwkJCQlzcmFtX3NpemUgPSAy
ICogU1pfMTZLOworCQkJCWJyZWFrOworCQkJY2FzZSBBVDkxX0NJRFJfU1JBTVNJWl8xNks6CisJ
CQlkZWZhdWx0OgorCQkJCXNyYW1fc2l6ZSA9IFNaXzE2SzsKKwkJfQorCisJCWV0aF9yZXNvdXJj
ZXNbMl0uc3RhcnQgPSBBVDkxU0FNOTI2MF9TUkFNMV9CQVNFOworCQlldGhfcmVzb3VyY2VzWzJd
LmVuZCAgID0gQVQ5MVNBTTkyNjBfU1JBTTFfQkFTRSArIHNyYW1fc2l6ZSAtIDE7CisJfQorCiAJ
ZXRoX2RhdGEgPSAqZGF0YTsKIAlwbGF0Zm9ybV9kZXZpY2VfcmVnaXN0ZXIoJmF0OTFzYW05MjYw
X2V0aF9kZXZpY2UpOwogfQpkaWZmIC1hdXJkcGJCIC1YIG5vZGlmZiBsaW51eC0yLjYuMjAuMTMt
Y2xlYW4vYXJjaC9hcm0vbWFjaC1hdDkxcm05MjAwL2F0OTFzYW05MjYzLmMgbGludXgtMi42LjIw
LjEzL2FyY2gvYXJtL21hY2gtYXQ5MXJtOTIwMC9hdDkxc2FtOTI2My5jCi0tLSBsaW51eC0yLjYu
MjAuMTMtY2xlYW4vYXJjaC9hcm0vbWFjaC1hdDkxcm05MjAwL2F0OTFzYW05MjYzLmMJMjAwNy0w
Ni0xOCAxODowODo0My4wMDAwMDAwMDAgKzAyMDAKKysrIGxpbnV4LTIuNi4yMC4xMy9hcmNoL2Fy
bS9tYWNoLWF0OTFybTkyMDAvYXQ5MXNhbTkyNjMuYwkyMDA3LTA2LTE4IDE3OjMzOjMwLjAwMDAw
MDAwMCArMDIwMApAQCAtMTA4LDcgKzEwOCw3IEBAIHN0YXRpYyBzdHJ1Y3QgY2xrIHRjYl9jbGsg
PSB7CiAJLnR5cGUJCT0gQ0xLX1RZUEVfUEVSSVBIRVJBTCwKIH07CiBzdGF0aWMgc3RydWN0IGNs
ayBldGhlcl9jbGsgPSB7Ci0JLm5hbWUJCT0gImV0aGVyX2NsayIsCisJLm5hbWUJCT0gIm1hY2Jf
Y2xrIiwKIAkucG1jX21hc2sJPSAxIDw8IEFUOTFTQU05MjYzX0lEX0VNQUMsCiAJLnR5cGUJCT0g
Q0xLX1RZUEVfUEVSSVBIRVJBTCwKIH07CmRpZmYgLWF1cmRwYkIgLVggbm9kaWZmIGxpbnV4LTIu
Ni4yMC4xMy1jbGVhbi9hcmNoL2FybS9tYWNoLWF0OTFybTkyMDAvYXQ5MXNhbTkyNjNfZGV2aWNl
cy5jIGxpbnV4LTIuNi4yMC4xMy9hcmNoL2FybS9tYWNoLWF0OTFybTkyMDAvYXQ5MXNhbTkyNjNf
ZGV2aWNlcy5jCi0tLSBsaW51eC0yLjYuMjAuMTMtY2xlYW4vYXJjaC9hcm0vbWFjaC1hdDkxcm05
MjAwL2F0OTFzYW05MjYzX2RldmljZXMuYwkyMDA3LTA2LTE4IDE4OjA4OjQzLjAwMDAwMDAwMCAr
MDIwMAorKysgbGludXgtMi42LjIwLjEzL2FyY2gvYXJtL21hY2gtYXQ5MXJtOTIwMC9hdDkxc2Ft
OTI2M19kZXZpY2VzLmMJMjAwNy0wNi0xOCAxNzo0NzozMS4wMDAwMDAwMDAgKzAyMDAKQEAgLTE5
LDYgKzE5LDcgQEAKICNpbmNsdWRlIDxhc20vYXJjaC9hdDkxc2FtOTI2My5oPgogI2luY2x1ZGUg
PGFzbS9hcmNoL2F0OTFzYW05MjZ4X21jLmg+CiAjaW5jbHVkZSA8YXNtL2FyY2gvYXQ5MXNhbTky
NjNfbWF0cml4Lmg+CisjaW5jbHVkZSA8YXNtL2FyY2gvY3B1Lmg+CiAKICNpbmNsdWRlICJnZW5l
cmljLmgiCiAKQEAgLTE0OSw2ICsxNTAsMTEgQEAgc3RhdGljIHN0cnVjdCByZXNvdXJjZSBldGhf
cmVzb3VyY2VzW10gPQogCQkuZW5kCT0gQVQ5MVNBTTkyNjNfSURfRU1BQywKIAkJLmZsYWdzCT0g
SU9SRVNPVVJDRV9JUlEsCiAJfSwKKwlbMl0gPSB7CisJCS5zdGFydAk9IEFUOTFTQU05MjYzX1NS
QU0wX0JBU0UsCisJCS5lbmQJPSBBVDkxU0FNOTI2M19TUkFNMF9CQVNFICsgQVQ5MVNBTTkyNjNf
U1JBTTBfU0laRSAtMSwKKwkJLmZsYWdzCT0gSU9SRVNPVVJDRV9NRU0sCisJfSwKIH07CiAKIHN0
YXRpYyBzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlIGF0OTFzYW05MjYzX2V0aF9kZXZpY2UgPSB7CkBA
IC0xNjUsNiArMTcxLDggQEAgc3RhdGljIHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgYXQ5MXNhbTky
NgogCiB2b2lkIF9faW5pdCBhdDkxX2FkZF9kZXZpY2VfZXRoKHN0cnVjdCBhdDkxX2V0aF9kYXRh
ICpkYXRhKQogeworCXVuc2lnbmVkIGludCBjaWRyLCBzcmFtX3NpemU7CisKIAlpZiAoIWRhdGEp
CiAJCXJldHVybjsKIApAQCAtMTk2LDYgKzIwNCwyNCBAQCB2b2lkIF9faW5pdCBhdDkxX2FkZF9k
ZXZpY2VfZXRoKHN0cnVjdCBhCiAJCWF0OTFfc2V0X0JfcGVyaXBoKEFUOTFfUElOX1BDMjQsIDAp
OwkvKiBFVFhFUiAqLwogCX0KIAorCWlmKCBjcHVfaXNfYXQ5MXNhbTkyNjMoKSApIHsKKworCisJ
CWNpZHIgPSBhdDkxX3N5c19yZWFkKEFUOTFfREJHVV9DSURSKTsKKworCQlzd2l0Y2ggKGNpZHIg
JiBBVDkxX0NJRFJfU1JBTVNJWikgeworCQkJY2FzZSBBVDkxX0NJRFJfU1JBTVNJWl8zMks6CisJ
CQkJc3JhbV9zaXplID0gMiAqIFNaXzE2SzsKKwkJCQlicmVhazsKKwkJCWNhc2UgQVQ5MV9DSURS
X1NSQU1TSVpfMTZLOgorCQkJZGVmYXVsdDoKKwkJCQlzcmFtX3NpemUgPSBTWl8xNks7CisJCX0K
KworCQlldGhfcmVzb3VyY2VzWzJdLnN0YXJ0ID0gQVQ5MVNBTTkyNjNfU1JBTTFfQkFTRTsKKwkJ
ZXRoX3Jlc291cmNlc1syXS5lbmQgICA9IEFUOTFTQU05MjYzX1NSQU0xX0JBU0UgKyBzcmFtX3Np
emUgLSAxOworCX0KKwogCWV0aF9kYXRhID0gKmRhdGE7CiAJcGxhdGZvcm1fZGV2aWNlX3JlZ2lz
dGVyKCZhdDkxc2FtOTI2M19ldGhfZGV2aWNlKTsKIH0KZGlmZiAtYXVyZHBiQiAtWCBub2RpZmYg
bGludXgtMi42LjIwLjEzLWNsZWFuL2FyY2gvYXJtL21hY2gtYXQ5MXJtOTIwMC9ib2FyZC1zYW05
MjYzZWsuYyBsaW51eC0yLjYuMjAuMTMvYXJjaC9hcm0vbWFjaC1hdDkxcm05MjAwL2JvYXJkLXNh
bTkyNjNlay5jCi0tLSBsaW51eC0yLjYuMjAuMTMtY2xlYW4vYXJjaC9hcm0vbWFjaC1hdDkxcm05
MjAwL2JvYXJkLXNhbTkyNjNlay5jCTIwMDctMDYtMTggMTg6MDg6NDMuMDAwMDAwMDAwICswMjAw
CisrKyBsaW51eC0yLjYuMjAuMTMvYXJjaC9hcm0vbWFjaC1hdDkxcm05MjAwL2JvYXJkLXNhbTky
NjNlay5jCTIwMDctMDYtMTggMTc6MTc6MTYuMDAwMDAwMDAwICswMjAwCkBAIC0xMTIsNiArMTEy
LDE0IEBAIHN0YXRpYyBzdHJ1Y3QgYXQ5MV9tbWNfZGF0YSBfX2luaXRkYXRhIGUKIAogCiAvKgor
ICogTUFDQiBFdGhlcm5ldCBkZXZpY2UKKyAqLworc3RhdGljIHN0cnVjdCBhdDkxX2V0aF9kYXRh
IF9faW5pdGRhdGEgZWtfbWFjYl9kYXRhID0geworCS5pc19ybWlpCT0gMSwKK307CisKKworLyoK
ICAqIE5BTkQgZmxhc2gKICAqLwogc3RhdGljIHN0cnVjdCBtdGRfcGFydGl0aW9uIF9faW5pdGRh
dGEgZWtfbmFuZF9wYXJ0aXRpb25bXSA9IHsKQEAgLTE2MCw2ICsxNjgsOCBAQCBzdGF0aWMgdm9p
ZCBfX2luaXQgZWtfYm9hcmRfaW5pdCh2b2lkKQogCWF0OTFfYWRkX2RldmljZV9zcGkoZWtfc3Bp
X2RldmljZXMsIEFSUkFZX1NJWkUoZWtfc3BpX2RldmljZXMpKTsKIAkvKiBNTUMgKi8KIAlhdDkx
X2FkZF9kZXZpY2VfbW1jKDEsICZla19tbWNfZGF0YSk7CisJLyogRXRoZXJuZXQgKi8KKwlhdDkx
X2FkZF9kZXZpY2VfZXRoKCZla19tYWNiX2RhdGEpOwogCS8qIE5BTkQgKi8KIAlhdDkxX2FkZF9k
ZXZpY2VfbmFuZCgmZWtfbmFuZF9kYXRhKTsKIH0KZGlmZiAtYXVyZHBiQiAtWCBub2RpZmYgbGlu
dXgtMi42LjIwLjEzLWNsZWFuL2RyaXZlcnMvbmV0L0tjb25maWcgbGludXgtMi42LjIwLjEzL2Ry
aXZlcnMvbmV0L0tjb25maWcKLS0tIGxpbnV4LTIuNi4yMC4xMy1jbGVhbi9kcml2ZXJzL25ldC9L
Y29uZmlnCTIwMDctMDYtMTggMTg6MDg6NDMuMDAwMDAwMDAwICswMjAwCisrKyBsaW51eC0yLjYu
MjAuMTMvZHJpdmVycy9uZXQvS2NvbmZpZwkyMDA3LTA2LTE4IDE2OjM1OjIzLjAwMDAwMDAwMCAr
MDIwMApAQCAtMTk5LDYgKzE5OSwxNyBAQCBjb25maWcgTUFDQgogCSAgVG8gY29tcGlsZSB0aGlz
IGRyaXZlciBhcyBhIG1vZHVsZSwgY2hvb3NlIE0gaGVyZTogdGhlIG1vZHVsZQogCSAgd2lsbCBi
ZSBjYWxsZWQgbWFjYi4KIAorY29uZmlnIE1BQ0IKKwl0cmlzdGF0ZSAiQXRtZWwgTUFDQiBzdXBw
b3J0IgorCWRlcGVuZHMgb24gTkVUX0VUSEVSTkVUICYmIChBVlIzMiB8fCBBUkNIX0FUOTFTQU05
MjYwKQorCXNlbGVjdCBNSUkKKwloZWxwCisJICBUaGUgQXRtZWwgTUFDQiBldGhlcm5ldCBpbnRl
cmZhY2UgaXMgZm91bmQgb24gbWFueSBBVDMyIGFuZCBBVDkxCisJICBwYXJ0cy4gU2F5IFkgdG8g
aW5jbHVkZSBzdXBwb3J0IGZvciB0aGUgTUFDQiBjaGlwLgorCisJICBUbyBjb21waWxlIHRoaXMg
ZHJpdmVyIGFzIGEgbW9kdWxlLCBjaG9vc2UgTSBoZXJlOiB0aGUgbW9kdWxlCisJICB3aWxsIGJl
IGNhbGxlZCBtYWNiLgorCiBzb3VyY2UgImRyaXZlcnMvbmV0L2FybS9LY29uZmlnIgogCiBjb25m
aWcgTUFDRQpAQCAtMjI2LDcgKzIzNyw3IEBAIGNvbmZpZyBNQUNFX0FBVUlfUE9SVAogCiBjb25m
aWcgQk1BQwogCXRyaXN0YXRlICJCTUFDIChHMyBldGhlcm5ldCkgc3VwcG9ydCIKLQlkZXBlbmRz
IG9uIE5FVF9FVEhFUk5FVCAmJiBQUENfUE1BQyAmJiBQUEMzMgorCWRlcGVuZHMgb24gTkVUX0VU
SEVSTkVUICYmIFBQQ19QTUFDICYmIFBQQzMyICYKIAlzZWxlY3QgQ1JDMzIKIAloZWxwCiAJICBT
YXkgWSBmb3Igc3VwcG9ydCBvZiBCTUFDIEV0aGVybmV0IGludGVyZmFjZXMuIFRoZXNlIGFyZSB1
c2VkIG9uIEczCmRpZmYgLWF1cmRwYkIgLVggbm9kaWZmIGxpbnV4LTIuNi4yMC4xMy1jbGVhbi9k
cml2ZXJzL25ldC9tYWNiLmMgbGludXgtMi42LjIwLjEzL2RyaXZlcnMvbmV0L21hY2IuYwotLS0g
bGludXgtMi42LjIwLjEzLWNsZWFuL2RyaXZlcnMvbmV0L21hY2IuYwkyMDA3LTA2LTE4IDE4OjA4
OjQzLjAwMDAwMDAwMCArMDIwMAorKysgbGludXgtMi42LjIwLjEzL2RyaXZlcnMvbmV0L21hY2Iu
YwkyMDA3LTA2LTE4IDE3OjQyOjQ5LjAwMDAwMDAwMCArMDIwMApAQCAtMTA0NywxMiArMTA0Nywx
MiBAQCBzdGF0aWMgaW50IF9fZGV2aW5pdCBtYWNiX3Byb2JlKHN0cnVjdCBwCiAJc3Bpbl9sb2Nr
X2luaXQoJmJwLT5sb2NrKTsKIAogI2lmIGRlZmluZWQoQ09ORklHX0FSQ0hfQVQ5MSkKLQlicC0+
cGNsayA9IGNsa19nZXQoJnBkZXYtPmRldiwgIm1hY2JfY2xrIik7Ci0JaWYgKElTX0VSUihicC0+
cGNsaykpIHsKKwlicC0+bWFjYl9jbGsgPSBjbGtfZ2V0KCZwZGV2LT5kZXYsICJtYWNiX2NsayIp
OworCWlmIChJU19FUlIoYnAtPm1hY2JfY2xrKSkgewogCQlkZXZfZXJyKCZwZGV2LT5kZXYsICJm
YWlsZWQgdG8gZ2V0IG1hY2JfY2xrXG4iKTsKIAkJZ290byBlcnJfb3V0X2ZyZWVfZGV2OwogCX0K
LQljbGtfZW5hYmxlKGJwLT5wY2xrKTsKKwljbGtfZW5hYmxlKGJwLT5tYWNiX2Nsayk7CiAjZWxz
ZQogCWJwLT5wY2xrID0gY2xrX2dldCgmcGRldi0+ZGV2LCAicGNsayIpOwogCWlmIChJU19FUlIo
YnAtPnBjbGspKSB7CkBAIC0xMTAyLDcgKzExMDIsMTEgQEAgc3RhdGljIGludCBfX2RldmluaXQg
bWFjYl9wcm9iZShzdHJ1Y3QgcAogCWluaXRfY29tcGxldGlvbigmYnAtPm1kaW9fY29tcGxldGUp
OwogCiAJLyogU2V0IE1JSSBtYW5hZ2VtZW50IGNsb2NrIGRpdmlkZXIgKi8KKwkjaWYgZGVmaW5l
ZChDT05GSUdfQVJDSF9BVDkxKQorCQlwY2xrX2h6ID0gY2xrX2dldF9yYXRlKGJwLT5tYWNiX2Ns
ayk7CisJI2Vsc2UKIAlwY2xrX2h6ID0gY2xrX2dldF9yYXRlKGJwLT5wY2xrKTsKKwkjZW5kaWYK
IAlpZiAocGNsa19oeiA8PSAyMDAwMDAwMCkKIAkJY29uZmlnID0gTUFDQl9CRihDTEssIE1BQ0Jf
Q0xLX0RJVjgpOwogCWVsc2UgaWYgKHBjbGtfaHogPD0gNDAwMDAwMDApCkBAIC0xMTI4LDE3ICsx
MTMyLDE3IEBAIHN0YXRpYyBpbnQgX19kZXZpbml0IG1hY2JfcHJvYmUoc3RydWN0IHAKIAogCXBk
YXRhID0gcGRldi0+ZGV2LnBsYXRmb3JtX2RhdGE7CiAJaWYgKHBkYXRhICYmIHBkYXRhLT5pc19y
bWlpKQotI2lmIGRlZmluZWQoQ09ORklHX0FSQ0hfQVQ5MSkKKwkjaWYgZGVmaW5lZChDT05GSUdf
QVJDSF9BVDkxKQogCQltYWNiX3dyaXRlbChicCwgVVNSSU8sIChNQUNCX0JJVChSTUlJKSB8IE1B
Q0JfQklUKENMS0VOKSkgKTsKLSNlbHNlCisJI2Vsc2UKIAkJbWFjYl93cml0ZWwoYnAsIFVTUklP
LCAwKTsKLSNlbmRpZgorCSNlbmRpZgogCWVsc2UKLSNpZiBkZWZpbmVkKENPTkZJR19BUkNIX0FU
OTEpCisJI2lmIGRlZmluZWQoQ09ORklHX0FSQ0hfQVQ5MSkKIAkJbWFjYl93cml0ZWwoYnAsIFVT
UklPLCBNQUNCX0JJVChDTEtFTikpOwotI2Vsc2UKKwkjZWxzZQogCQltYWNiX3dyaXRlbChicCwg
VVNSSU8sIE1BQ0JfQklUKE1JSSkpOwotI2VuZGlmCisJI2VuZGlmCiAKIAlicC0+dHhfcGVuZGlu
ZyA9IERFRl9UWF9SSU5HX1BFTkRJTkc7CiAKQEAgLTExNjUsMTIgKzExNjksMTQgQEAgZXJyX291
dF9mcmVlX2lycToKIGVycl9vdXRfaW91bm1hcDoKIAlpb3VubWFwKGJwLT5yZWdzKTsKIGVycl9v
dXRfZGlzYWJsZV9jbG9ja3M6Ci0jaWZuZGVmIENPTkZJR19BUkNIX0FUOTEKKyNpZiBkZWZpbmVk
KENPTkZJR19BUkNIX0FUOTEpCisJY2xrX2Rpc2FibGUoYnAtPm1hY2JfY2xrKTsKKyNlbHNlCiAJ
Y2xrX2Rpc2FibGUoYnAtPmhjbGspOwotCWNsa19wdXQoYnAtPmhjbGspOwotI2VuZGlmCiAJY2xr
X2Rpc2FibGUoYnAtPnBjbGspOworCWNsa19wdXQoYnAtPmhjbGspOwogZXJyX291dF9wdXRfcGNs
azoKKyNlbmRpZgogCWNsa19wdXQoYnAtPnBjbGspOwogZXJyX291dF9mcmVlX2RldjoKIAlmcmVl
X25ldGRldihkZXYpOwpkaWZmIC1hdXJkcGJCIC1YIG5vZGlmZiBsaW51eC0yLjYuMjAuMTMtY2xl
YW4vZHJpdmVycy9uZXQvbWFjYi5oIGxpbnV4LTIuNi4yMC4xMy9kcml2ZXJzL25ldC9tYWNiLmgK
LS0tIGxpbnV4LTIuNi4yMC4xMy1jbGVhbi9kcml2ZXJzL25ldC9tYWNiLmgJMjAwNy0wNi0xOCAx
ODowODo0My4wMDAwMDAwMDAgKzAyMDAKKysrIGxpbnV4LTIuNi4yMC4xMy9kcml2ZXJzL25ldC9t
YWNiLmgJMjAwNy0wNi0xOCAxNzo0Mzo0Mi4wMDAwMDAwMDAgKzAyMDAKQEAgLTM3MSw2ICszNzEs
NyBAQCBzdHJ1Y3QgbWFjYiB7CiAKIAlzcGlubG9ja190CQlsb2NrOwogCXN0cnVjdCBwbGF0Zm9y
bV9kZXZpY2UJKnBkZXY7CisJc3RydWN0IGNsawkJKm1hY2JfY2xrOwogCXN0cnVjdCBjbGsJCSpw
Y2xrOwogCXN0cnVjdCBjbGsJCSpoY2xrOwogCXN0cnVjdCBuZXRfZGV2aWNlCSpkZXY7CmRpZmYg
LWF1cmRwYkIgLVggbm9kaWZmIGxpbnV4LTIuNi4yMC4xMy1jbGVhbi9kcml2ZXJzL25ldC9NYWtl
ZmlsZSBsaW51eC0yLjYuMjAuMTMvZHJpdmVycy9uZXQvTWFrZWZpbGUKLS0tIGxpbnV4LTIuNi4y
MC4xMy1jbGVhbi9kcml2ZXJzL25ldC9NYWtlZmlsZQkyMDA3LTA2LTA3IDIzOjIzOjIzLjAwMDAw
MDAwMCArMDIwMAorKysgbGludXgtMi42LjIwLjEzL2RyaXZlcnMvbmV0L01ha2VmaWxlCTIwMDct
MDYtMTggMTY6MzU6MjMuMDAwMDAwMDAwICswMjAwCkBAIC0xOTYsNiArMTk2LDcgQEAgb2JqLSQo
Q09ORklHX1NNQzkxWCkgKz0gc21jOTF4Lm8KIG9iai0kKENPTkZJR19TTUM5MTFYKSArPSBzbWM5
MTF4Lm8KIG9iai0kKENPTkZJR19ETTkwMDApICs9IGRtOTAwMC5vCiBvYmotJChDT05GSUdfRkVD
XzhYWCkgKz0gZmVjXzh4eC8KK29iai0kKENPTkZJR19NQUNCKSArPSBtYWNiLm8KIAogb2JqLSQo
Q09ORklHX01BQ0IpICs9IG1hY2IubwogClNldWxlbWVudCBkYW5zIGxpbnV4LTIuNi4yMC4xMy9p
bmNsdWRlL2FzbS1hcm06IGFyY2gKZGlmZiAtYXVyZHBiQiAtWCBub2RpZmYgbGludXgtMi42LjIw
LjEzLWNsZWFuL2luY2x1ZGUvYXNtLWFybS9hcmNoLWF0OTFybTkyMDAvYXQ5MV9kYmd1LmggbGlu
dXgtMi42LjIwLjEzL2luY2x1ZGUvYXNtLWFybS9hcmNoLWF0OTFybTkyMDAvYXQ5MV9kYmd1LmgK
LS0tIGxpbnV4LTIuNi4yMC4xMy1jbGVhbi9pbmNsdWRlL2FzbS1hcm0vYXJjaC1hdDkxcm05MjAw
L2F0OTFfZGJndS5oCTIwMDctMDYtMDcgMjM6MjM6MjMuMDAwMDAwMDAwICswMjAwCisrKyBsaW51
eC0yLjYuMjAuMTMvaW5jbHVkZS9hc20tYXJtL2FyY2gtYXQ5MXJtOTIwMC9hdDkxX2RiZ3UuaAky
MDA3LTA2LTE4IDE3OjM5OjUzLjAwMDAwMDAwMCArMDIwMApAQCAtMzUsNiArMzUsMzcgQEAKICNk
ZWZpbmUJCUFUOTFfQ0lEUl9OVlBTSVoJKDB4ZiAgPDwgOCkJCS8qIE5vbnZvbGF0aWxlIFByb2dy
YW0gTWVtb3J5IFNpemUgKi8KICNkZWZpbmUJCUFUOTFfQ0lEUl9OVlBTSVoyCSgweGYgIDw8IDEy
KQkJLyogU2Vjb25kIE5vbnZvbGF0aWxlIFByb2dyYW0gTWVtb3J5IFNpemUgKi8KICNkZWZpbmUJ
CUFUOTFfQ0lEUl9TUkFNU0laCSgweGYgIDw8IDE2KQkJLyogSW50ZXJuYWwgU1JBTSBTaXplICov
CisKKyNkZWZpbmUgQVQ5MV9DSURSX1NSQU1TSVpfMUsgKDEgPDwgMTYpCisjZGVmaW5lIEFUOTFf
Q0lEUl9TUkFNU0laXzJLICgyIDw8IDE2KQorI2RlZmluZSBBVDkxX0NJRFJfU1JBTVNJWl8xMTJL
ICg0IDw8IDE2KQorI2RlZmluZSBBVDkxX0NJRFJfU1JBTVNJWl80SyAoNSA8PCAxNikKKyNkZWZp
bmUgQVQ5MV9DSURSX1NSQU1TSVpfODBLICg2IDw8IDE2KQorI2RlZmluZSBBVDkxX0NJRFJfU1JB
TVNJWl8xNjBLICg3IDw8IDE2KQorI2RlZmluZSBBVDkxX0NJRFJfU1JBTVNJWl84SyAoOCA8PCAx
NikKKyNkZWZpbmUgQVQ5MV9DSURSX1NSQU1TSVpfMTZLICg5IDw8IDE2KQorI2RlZmluZSBBVDkx
X0NJRFJfU1JBTVNJWl8zMksgKDEwIDw8IDE2KQorI2RlZmluZSBBVDkxX0NJRFJfU1JBTVNJWl82
NEsgKDExIDw8IDE2KQorI2RlZmluZSBBVDkxX0NJRFJfU1JBTVNJWl8xMjhLICgxMiA8PCAxNikK
KyNkZWZpbmUgQVQ5MV9DSURSX1NSQU1TSVpfMjU2SyAoMTMgPDwgMTYpCisjZGVmaW5lIEFUOTFf
Q0lEUl9TUkFNU0laXzk2SyAoMTQgPDwgMTYpCisjZGVmaW5lIEFUOTFfQ0lEUl9TUkFNU0laXzUx
MksgKDE1IDw8IDE2KQorCisjZGVmaW5lIEFUOTFfQ0lEUl9TUkFNU0laXzFLICgxIDw8IDE2KQor
I2RlZmluZSBBVDkxX0NJRFJfU1JBTVNJWl8ySyAoMiA8PCAxNikKKyNkZWZpbmUgQVQ5MV9DSURS
X1NSQU1TSVpfMTEySyAoNCA8PCAxNikKKyNkZWZpbmUgQVQ5MV9DSURSX1NSQU1TSVpfNEsgKDUg
PDwgMTYpCisjZGVmaW5lIEFUOTFfQ0lEUl9TUkFNU0laXzgwSyAoNiA8PCAxNikKKyNkZWZpbmUg
QVQ5MV9DSURSX1NSQU1TSVpfMTYwSyAoNyA8PCAxNikKKyNkZWZpbmUgQVQ5MV9DSURSX1NSQU1T
SVpfOEsgKDggPDwgMTYpCisjZGVmaW5lIEFUOTFfQ0lEUl9TUkFNU0laXzE2SyAoOSA8PCAxNikK
KyNkZWZpbmUgQVQ5MV9DSURSX1NSQU1TSVpfMzJLICgxMCA8PCAxNikKKyNkZWZpbmUgQVQ5MV9D
SURSX1NSQU1TSVpfNjRLICgxMSA8PCAxNikKKyNkZWZpbmUgQVQ5MV9DSURSX1NSQU1TSVpfMTI4
SyAoMTIgPDwgMTYpCisjZGVmaW5lIEFUOTFfQ0lEUl9TUkFNU0laXzI1NksgKDEzIDw8IDE2KQor
I2RlZmluZSBBVDkxX0NJRFJfU1JBTVNJWl85NksgKDE0IDw8IDE2KQorI2RlZmluZSBBVDkxX0NJ
RFJfU1JBTVNJWl81MTJLICgxNSA8PCAxNikKKwogI2RlZmluZQkJQVQ5MV9DSURSX0FSQ0gJCSgw
eGZmIDw8IDIwKQkJLyogQXJjaGl0ZWN0dXJlIElkZW50aWZpZXIgKi8KICNkZWZpbmUJCUFUOTFf
Q0lEUl9OVlBUWVAJKDcgICAgPDwgMjgpCQkvKiBOb252b2xhdGlsZSBQcm9ncmFtIE1lbW9yeSBU
eXBlICovCiAjZGVmaW5lCQlBVDkxX0NJRFJfRVhUCQkoMSAgICA8PCAzMSkJCS8qIEV4dGVuc2lv
biBGbGFnICovCmRpZmYgLWF1cmRwYkIgLVggbm9kaWZmIGxpbnV4LTIuNi4yMC4xMy1jbGVhbi9N
QUlOVEFJTkVSUyBsaW51eC0yLjYuMjAuMTMvTUFJTlRBSU5FUlMKLS0tIGxpbnV4LTIuNi4yMC4x
My1jbGVhbi9NQUlOVEFJTkVSUwkyMDA3LTA2LTA3IDIzOjIzOjIzLjAwMDAwMDAwMCArMDIwMAor
KysgbGludXgtMi42LjIwLjEzL01BSU5UQUlORVJTCTIwMDctMDYtMTggMTY6MzU6MjMuMDAwMDAw
MDAwICswMjAwCkBAIC02MDIsNiArNjAyLDEzIEBAIFA6CUhhYXZhcmQgU2tpbm5lbW9lbgogTToJ
aHNraW5uZW1vZW5AYXRtZWwuY29tCiBTOglTdXBwb3J0ZWQKIAorQVRNRUwgTUFDQiBFVEhFUk5F
VCBEUklWRVIKK1A6CUF0bWVsIEFWUjMyIFN1cHBvcnQgVGVhbQorTToJYXZyMzJAYXRtZWwuY29t
CitQOglIYWF2YXJkIFNraW5uZW1vZW4KK006CWhza2lubmVtb2VuQGF0bWVsLmNvbQorUzoJU3Vw
cG9ydGVkCisKIEFUTUVMIFdJUkVMRVNTIERSSVZFUgogUDoJU2ltb24gS2VsbGV5CiBNOglzaW1v
bkB0aGVrZWxsZXlzLm9yZy51awo=

------_=_NextPart_001_01C7B4E3.A1FF664C
Content-Type: application/octet-stream;
	name="adeos-ipipe-2.6.20-arm-AT91.patch"
Content-Transfer-Encoding: base64
Content-Description: adeos-ipipe-2.6.20-arm-AT91.patch
Content-Disposition: attachment;
	filename="adeos-ipipe-2.6.20-arm-AT91.patch"

U2V1bGVtZW50IGRhbnMgbGludXgtMi42LjIwLjEzLTkyNjMvYXJjaC9hcm0vbWFjaC1hdDkxcm05
MjAwOiBhdDkxcm05MjAwLmMub3JpZwpTZXVsZW1lbnQgZGFucyBsaW51eC0yLjYuMjAuMTMtOTI2
My9hcmNoL2FybS9tYWNoLWF0OTFybTkyMDA6IGF0OTFybTkyMDBfdGltZS5jLm9yaWcKU2V1bGVt
ZW50IGRhbnMgbGludXgtMi42LjIwLjEzLTkyNjMvYXJjaC9hcm0vbWFjaC1hdDkxcm05MjAwOiBh
dDkxc2FtOTI2MS5jLm9yaWcKZGlmZiAtYXVyZHBiQiAtWCBub2RpZmYgbGludXgtMi42LjIwLjEz
LTkyNjMtY2xlYW4vYXJjaC9hcm0vbWFjaC1hdDkxcm05MjAwL2F0OTFzYW05MjYzLmMgbGludXgt
Mi42LjIwLjEzLTkyNjMvYXJjaC9hcm0vbWFjaC1hdDkxcm05MjAwL2F0OTFzYW05MjYzLmMKLS0t
IGxpbnV4LTIuNi4yMC4xMy05MjYzLWNsZWFuL2FyY2gvYXJtL21hY2gtYXQ5MXJtOTIwMC9hdDkx
c2FtOTI2My5jCTIwMDctMDYtMTkgMTQ6MzI6MzcuMDAwMDAwMDAwICswMjAwCisrKyBsaW51eC0y
LjYuMjAuMTMtOTI2My9hcmNoL2FybS9tYWNoLWF0OTFybTkyMDAvYXQ5MXNhbTkyNjMuYwkyMDA3
LTA2LTE5IDE3OjUzOjE0LjAwMDAwMDAwMCArMDIwMApAQCAtMjgsNiArMjgsMTMgQEAgc3RhdGlj
IHN0cnVjdCBtYXBfZGVzYyBhdDkxc2FtOTI2M19pb19kZQogCQkubGVuZ3RoCQk9IFNaXzE2SywK
IAkJLnR5cGUJCT0gTVRfREVWSUNFLAogCX0sIHsKKyNpZmRlZiBDT05GSUdfSVBJUEUKKwkJLnZp
cnR1YWwJPSBBVDkxX1ZBX0JBU0VfVENCMCwKKwkJLnBmbgkJPSBfX3BoeXNfdG9fcGZuKEFUOTFT
QU05MjYzX0JBU0VfVENCMCksCisJCS5sZW5ndGgJCT0gU1pfMTZLLAorCQkudHlwZQkJPSBNVF9E
RVZJQ0UsCisgICAgICAgIH0sIHsKKyNlbmRpZiAvKiBDT05GSUdfSVBJUEUgKi8KIAkJLnZpcnR1
YWwJPSBBVDkxX0lPX1ZJUlRfQkFTRSAtIEFUOTFTQU05MjYzX1NSQU0wX1NJWkUsCiAJCS5wZm4J
CT0gX19waHlzX3RvX3BmbihBVDkxU0FNOTI2M19TUkFNMF9CQVNFKSwKIAkJLmxlbmd0aAkJPSBB
VDkxU0FNOTI2M19TUkFNMF9TSVpFLApAQCAtMjY2LDYgKzI3Myw3IEBAIHZvaWQgX19pbml0IGF0
OTFzYW05MjYzX2luaXRpYWxpemUodW5zaWcKICAqIFRoZSBkZWZhdWx0IGludGVycnVwdCBwcmlv
cml0eSBsZXZlbHMgKDAgPSBsb3dlc3QsIDcgPSBoaWdoZXN0KS4KICAqLwogc3RhdGljIHVuc2ln
bmVkIGludCBhdDkxc2FtOTI2M19kZWZhdWx0X2lycV9wcmlvcml0eVtOUl9BSUNfSVJRU10gX19p
bml0ZGF0YSA9IHsKKyNpZm5kZWYgQ09ORklHX0lQSVBFCiAJNywJLyogQWR2YW5jZWQgSW50ZXJy
dXB0IENvbnRyb2xsZXIgKEZJUSkgKi8KIAk3LAkvKiBTeXN0ZW0gUGVyaXBoZXJhbHMgKi8KIAkw
LAkvKiBQYXJhbGxlbCBJTyBDb250cm9sbGVyIEEgKi8KQEAgLTI5OCw2ICszMDYsNDIgQEAgc3Rh
dGljIHVuc2lnbmVkIGludCBhdDkxc2FtOTI2M19kZWZhdWx0XwogCTMsCS8qIFVTQiBIb3N0IHBv
cnQgKi8KIAkwLAkvKiBBZHZhbmNlZCBJbnRlcnJ1cHQgQ29udHJvbGxlciAoSVJRMCkgKi8KIAkw
LAkvKiBBZHZhbmNlZCBJbnRlcnJ1cHQgQ29udHJvbGxlciAoSVJRMSkgKi8KKyNlbHNlIC8qIENP
TkZJR19JUElQRSAqLworLyogR2l2ZSB0aGUgaGlnaGVzdCBwcmlvcml0eSB0byBUQywgc2luY2Ug
dGhleSBhcmUgdXNlZCBhcyB0aW1lciBpbnRlcnJ1cHQgYnkKKyAgIEktcGlwZS4gKi8KKwk3LAkv
KiBBZHZhbmNlZCBJbnRlcnJ1cHQgQ29udHJvbGxlciAoRklRKSAqLworCTcsCS8qIFN5c3RlbSBQ
ZXJpcGhlcmFscyAqLworCTAsCS8qIFBhcmFsbGVsIElPIENvbnRyb2xsZXIgQSAqLworCTAsCS8q
IFBhcmFsbGVsIElPIENvbnRyb2xsZXIgQiAqLworCTAsCS8qIFBhcmFsbGVsIElPIENvbnRyb2xs
ZXIgQywgRCBhbmQgRSAqLworCTAsCisJMCwKKwk2LAkvKiBVU0FSVCAwICovCisJNiwJLyogVVNB
UlQgMSAqLworCTYsCS8qIFVTQVJUIDIgKi8KKwkwLAkvKiBNdWx0aW1lZGlhIENhcmQgSW50ZXJm
YWNlIDAgKi8KKwkwLAkvKiBNdWx0aW1lZGlhIENhcmQgSW50ZXJmYWNlIDEgKi8KKwk0LAkvKiBD
QU4gKi8KKwkwLAkvKiBUd28tV2lyZSBJbnRlcmZhY2UgKi8KKwk2LAkvKiBTZXJpYWwgUGVyaXBo
ZXJhbCBJbnRlcmZhY2UgMCAqLworCTYsCS8qIFNlcmlhbCBQZXJpcGhlcmFsIEludGVyZmFjZSAx
ICovCisJNSwJLyogU2VyaWFsIFN5bmNocm9ub3VzIENvbnRyb2xsZXIgMCAqLworCTUsCS8qIFNl
cmlhbCBTeW5jaHJvbm91cyBDb250cm9sbGVyIDEgKi8KKwk2LAkvKiBBQzk3IENvbnRyb2xsZXIg
Ki8KKwk3LAkvKiBUaW1lciBDb3VudGVyIDAsIDEgYW5kIDIgKi8KKwkwLAkvKiBQdWxzZSBXaWR0
aCBNb2R1bGF0aW9uIENvbnRyb2xsZXIgKi8KKwkzLAkvKiBFdGhlcm5ldCAqLworCTAsCisJMCwJ
LyogMkQgR3JhcGhpYyBFbmdpbmUgKi8KKwkzLAkvKiBVU0IgRGV2aWNlIFBvcnQgKi8KKwkwLAkv
KiBJbWFnZSBTZW5zb3IgSW50ZXJmYWNlICovCisJMywJLyogTERDIENvbnRyb2xsZXIgKi8KKwkw
LAkvKiBETUEgQ29udHJvbGxlciAqLworCTAsCisJMywJLyogVVNCIEhvc3QgcG9ydCAqLworCTAs
CS8qIEFkdmFuY2VkIEludGVycnVwdCBDb250cm9sbGVyIChJUlEwKSAqLworCTAsCS8qIEFkdmFu
Y2VkIEludGVycnVwdCBDb250cm9sbGVyIChJUlExKSAqLworI2VuZGlmIC8qQ09ORklHX0lQSVBF
ICovCiB9OwogCiB2b2lkIF9faW5pdCBhdDkxc2FtOTI2M19pbml0X2ludGVycnVwdHModW5zaWdu
ZWQgaW50IHByaW9yaXR5W05SX0FJQ19JUlFTXSkKZGlmZiAtYXVyZHBiQiAtWCBub2RpZmYgbGlu
dXgtMi42LjIwLjEzLTkyNjMtY2xlYW4vYXJjaC9hcm0vbWFjaC1hdDkxcm05MjAwL2F0OTFzYW05
MjZ4X3RpbWUuYyBsaW51eC0yLjYuMjAuMTMtOTI2My9hcmNoL2FybS9tYWNoLWF0OTFybTkyMDAv
YXQ5MXNhbTkyNnhfdGltZS5jCi0tLSBsaW51eC0yLjYuMjAuMTMtOTI2My1jbGVhbi9hcmNoL2Fy
bS9tYWNoLWF0OTFybTkyMDAvYXQ5MXNhbTkyNnhfdGltZS5jCTIwMDctMDYtMTggMTQ6MTc6MTgu
MDAwMDAwMDAwICswMjAwCisrKyBsaW51eC0yLjYuMjAuMTMtOTI2My9hcmNoL2FybS9tYWNoLWF0
OTFybTkyMDAvYXQ5MXNhbTkyNnhfdGltZS5jCTIwMDctMDYtMjEgMTE6NDY6MTEuMDAwMDAwMDAw
ICswMjAwCkBAIC00Niw2ICs0NiwxMSBAQCBzdGF0aWMgdW5zaWduZWQgbG9uZyBsYXN0X2NydHI7
CiAjZGVmaW5lIEFUOTFfSURfVEMwIEFUOTFTQU05MjYxX0lEX1RDMAogI2RlZmluZSBBVDkxX0lE
X1RDMSBBVDkxU0FNOTI2MV9JRF9UQzEKICNkZWZpbmUgQVQ5MV9JRF9UQzIgQVQ5MVNBTTkyNjFf
SURfVEMyCisjZWxpZiBkZWZpbmVkKENPTkZJR19BUkNIX0FUOTFTQU05MjYzKQorI2luY2x1ZGUg
PGFzbS9hcmNoL2F0OTFzYW05MjYzLmg+CisjZGVmaW5lIEFUOTFfSURfVEMwIEFUOTFTQU05MjYz
X0lEX1RDQgorI2RlZmluZSBBVDkxX0lEX1RDMSBBVDkxU0FNOTI2M19JRF9UQ0IKKyNkZWZpbmUg
QVQ5MV9JRF9UQzIgQVQ5MVNBTTkyNjNfSURfVENCCiAjZWxzZQogI2Vycm9yICJVbnN1cHBvcnRl
ZCBBVDkxIHByb2Nlc3NvciIKICNlbmRpZgpAQCAtMTA3LDYgKzExMiw3IEBAIHN0YXRpYyBpbnQg
YXQ5MV90aW1lcl9pbml0aWFsaXplZDsKICAqIFJldHVybnMgbnVtYmVyIG9mIG1pY3Jvc2Vjb25k
cyBzaW5jZSBsYXN0IHRpbWVyIGludGVycnVwdC4gIE5vdGUgdGhhdCBpbnRlcnJ1cHRzCiAgKiB3
aWxsIGhhdmUgYmVlbiBkaXNhYmxlZCBieSBkb19nZXR0aW1lb2ZkYXkoKQogICogICdMQVRDSCcg
aXMgaHdjbG9jayB0aWNrcyAoc2VlIENMT0NLX1RJQ0tfUkFURSBpbiB0aW1leC5oKSBwZXIgamlm
ZnkuCisgKiAgJ3RpY2snIGlzIHVzZWNzIHBlciBqaWZmeSAobGludXgvdGltZXguaCkuCiAgKi8K
IHN0YXRpYyB1bnNpZ25lZCBsb25nIGF0OTFzYW05MjZ4X2dldHRpbWVvZmZzZXQodm9pZCkKIHsK
QEAgLTExNSw3ICsxMjEsNyBAQCBzdGF0aWMgdW5zaWduZWQgbG9uZyBhdDkxc2FtOTI2eF9nZXR0
aW1lCiAKIAllbGFwc2VkID0gKFBJVF9QSUNOVCh0KSAqIExBVENIKSArIFBJVF9DUElWKHQpOwkJ
LyogaGFyZHdhcmUgY2xvY2sgY3ljbGVzICovCiAKLQlyZXR1cm4gKHVuc2lnbmVkIGxvbmcpKGVs
YXBzZWQgKiBqaWZmaWVzX3RvX3VzZWNzKDEpKSAvIExBVENIOworCXJldHVybiAodW5zaWduZWQg
bG9uZykoZWxhcHNlZCAqIDEwMDAwMDApIC8gTEFUQ0g7CiB9CiAKIC8qCkBAIC0zNTcsMTQgKzM2
Myw5IEBAIHN0YXRpYyBzdHJ1Y3QgaXJxYWN0aW9uIGF0OTFzYW05MjZ4X3RpbWUKIAkuaGFuZGxl
cgk9ICZhdDkxc2FtOTI2eF90aW1lcl9pbnRlcnJ1cHQKIH07CiAKLXN0YXRpYyBjaGFyIGNsa19u
YW1lIFtdID0gInRjJSI7CitzdGF0aWMgY2hhciBjbGtfbmFtZSBbXSA9ICJ0YyVfY2xrIjsKIAot
c3RhdGljIHN0cnVjdCBjbGsgdGMgPSB7Ci0JLm5hbWUJCT0gKGNvbnN0IGNoYXIgKikgY2xrX25h
bWUsCi0JLnVzZXJzICAgICAgICAgID0gMCwKLQkudHlwZQkJPSBDTEtfVFlQRV9QRVJJUEhFUkFM
LAotCS5wbWNfbWFzayAgICAgICA9IDEgPDwgKEtFUk5FTF9USU1FUl9JUlFfTlVNKSwKLX07Citz
dGF0aWMgc3RydWN0IGNsayAqdGM7CiAKIHZvaWQgX19pbml0IGF0OTFzYW05MjZ4X3RpbWVyX2lu
aXQodm9pZCkKIHsKQEAgLTM3Myw5ICszNzQsMTkgQEAgdm9pZCBfX2luaXQgYXQ5MXNhbTkyNnhf
dGltZXJfaW5pdCh2b2lkKQogCWlmIChjbGtfZ2V0X3JhdGUoY2xrX2dldChOVUxMLCAibWNrIikp
ICE9IENPTkZJR19JUElQRV9BVDkxX01DSykKIAkJYXQ5MXNhbTkyNnhfdGltZXJfaXJxLmhhbmRs
ZXIgPSAmYXQ5MXNhbTkyNnhfYmFkX2ZyZXE7CiAKLQlzbnByaW50ZihjbGtfbmFtZSwgc2l6ZW9m
KGNsa19uYW1lKSwgInRjJWQiLCBDT05GSUdfSVBJUEVfQVQ5MV9UQyk7Ci0JY2xrX3JlZ2lzdGVy
KCZ0Yyk7Ci0JY2xrX2VuYWJsZSgmdGMpOworCS8qIHNpbmNlIDIuNi4yMC1hdDkxLnBhdGNoLCBh
bGwgY2xvY2tzIGFyZSByZWdpc3RlcmVkIG9uIHN0YXJ0dXAuCisJICogd2UganVzdCBuZWVkIHRv
IGdldCB0aGUgZ29vZCBzdHJ1Y3QgYW5kIGVuYWJsZSBvdXIgdGMgY2xvY2sgKi8KKyNpZmRlZiBD
T05GSUdfQVJDSF9BVDkxU0FNOTI2MworCXNucHJpbnRmKGNsa19uYW1lLCBzaXplb2YoY2xrX25h
bWUpLCAidGNiX2NsayIpOworI2Vsc2UKKwlzbnByaW50ZihjbGtfbmFtZSwgc2l6ZW9mKGNsa19u
YW1lKSwgInRjJWRfY2xrIiwgQ09ORklHX0lQSVBFX0FUOTFfVEMpOworI2VuZGlmIC8qIENPTkZJ
R19BUkNIX0FUOTFTQU05MjYzICovCisKKwl0YyA9IGNsa19nZXQoTlVMTCwgY2xrX25hbWUpOwor
CWlmKChpbnQpdGMgPT0gMHhmZmZmZmZmZSkJLy9lcnIgY29kZQorCQlwcmludGsoIj4gJXMgZG9l
cyBub3QgZXhpc3QuIixjbGtfbmFtZSk7CisJZWxzZQorCQljbGtfZW5hYmxlKHRjKTsKIAkKIAkv
KiBObyBTeW5jLiAqLwogCWF0OTFfdGNfd3JpdGUoQVQ5MV9UQ19CQ1IsIDApOwpTZXVsZW1lbnQg
ZGFucyBsaW51eC0yLjYuMjAuMTMtOTI2My9hcmNoL2FybS9tYWNoLWF0OTFybTkyMDA6IGF0OTFz
YW05MjZ4X3RpbWUuYy5vcmlnCmRpZmYgLWF1cmRwYkIgLVggbm9kaWZmIGxpbnV4LTIuNi4yMC4x
My05MjYzLWNsZWFuL2FyY2gvYXJtL21hY2gtYXQ5MXJtOTIwMC9LY29uZmlnIGxpbnV4LTIuNi4y
MC4xMy05MjYzL2FyY2gvYXJtL21hY2gtYXQ5MXJtOTIwMC9LY29uZmlnCi0tLSBsaW51eC0yLjYu
MjAuMTMtOTI2My1jbGVhbi9hcmNoL2FybS9tYWNoLWF0OTFybTkyMDAvS2NvbmZpZwkyMDA3LTA2
LTE4IDE0OjE3OjE4LjAwMDAwMDAwMCArMDIwMAorKysgbGludXgtMi42LjIwLjEzLTkyNjMvYXJj
aC9hcm0vbWFjaC1hdDkxcm05MjAwL0tjb25maWcJMjAwNy0wNi0xOSAxNzo1NzozNC4wMDAwMDAw
MDAgKzAyMDAKQEAgLTE1Myw2ICsxNTMsNyBAQCBjb25maWcgSVBJUEVfQVQ5MV9NQ0sKIAlkZWZh
dWx0IDQ2MDgwMDAwIGlmIE1BQ0hfQ1NCNjM3CiAJZGVmYXVsdCA1OTkwNDAwMCBpZiBNQUNIX0FU
OTFSTTkyMDBFSwogCWRlZmF1bHQgOTkzMjgwMDAgaWYgTUFDSF9BVDkxU0FNOTI2MEVLIHx8IE1B
Q0hfQVQ5MVNBTTkyNjFFSworCWRlZmF1bHQgOTk5NTk1ODkgaWYgTUFDSF9BVDkxU0FNOTI2M0VL
CiAJZGVmYXVsdCA1MzAwMDAwMAogCWhlbHAKIAlXaGVuIEFkZW9zIGludGVycnVwdCBwaXBlbGlu
ZSBpcyBlbmFibGVkLCBBVDkxIHRpbWVyIGlzIGJhc2VkIG9uClNldWxlbWVudCBkYW5zIGxpbnV4
LTIuNi4yMC4xMy05MjYzL2FyY2gvYXJtL21hY2gtYXQ5MXJtOTIwMDogS2NvbmZpZy5vcmlnClNl
dWxlbWVudCBkYW5zIGxpbnV4LTIuNi4yMC4xMy05MjYzL2RyaXZlcnMvY2hhcjogY29uc29sZW1h
cF9kZWZ0YmwuYwpTZXVsZW1lbnQgZGFucyBsaW51eC0yLjYuMjAuMTMtOTI2My9kcml2ZXJzL2No
YXI6IGRlZmtleW1hcC5jClNldWxlbWVudCBkYW5zIGxpbnV4LTIuNi4yMC4xMy05MjYzL2luY2x1
ZGU6IGFzbQpkaWZmIC1hdXJkcGJCIC1YIG5vZGlmZiBsaW51eC0yLjYuMjAuMTMtOTI2My1jbGVh
bi9pbmNsdWRlL2FzbS1hcm0vYXJjaC9oYXJkd2FyZS5oIGxpbnV4LTIuNi4yMC4xMy05MjYzL2lu
Y2x1ZGUvYXNtLWFybS9hcmNoL2hhcmR3YXJlLmgKLS0tIGxpbnV4LTIuNi4yMC4xMy05MjYzLWNs
ZWFuL2luY2x1ZGUvYXNtLWFybS9hcmNoL2hhcmR3YXJlLmgJMjAwNy0wNi0xOCAxNDoxNzoxOC4w
MDAwMDAwMDAgKzAyMDAKKysrIGxpbnV4LTIuNi4yMC4xMy05MjYzL2luY2x1ZGUvYXNtLWFybS9h
cmNoL2hhcmR3YXJlLmgJMjAwNy0wNi0xOSAxNjoyNTo0OC4wMDAwMDAwMDAgKzAyMDAKQEAgLTUz
LDcgKzUzLDkgQEAKICNkZWZpbmUgQVQ5MV9CQVNFX1RDQjAgICAgICAgQVQ5MVNBTTkyNjBfQkFT
RV9UQ0IwCiAjZWxpZiBkZWZpbmVkKENPTkZJR19BUkNIX0FUOTFTQU05MjYxKQogI2RlZmluZSBB
VDkxX0JBU0VfVENCMCAgICAgICBBVDkxU0FNOTI2MV9CQVNFX1RDQjAKLSNlbmRpZiAvKiBDT05G
SUdfQVJDSF9BVDkxU0FNOTI2MSAqLworI2VsaWYgZGVmaW5lZChDT05GSUdfQVJDSF9BVDkxU0FN
OTI2MykKKyNkZWZpbmUgQVQ5MV9CQVNFX1RDQjAgICAgICAgQVQ5MVNBTTkyNjNfQkFTRV9UQ0Iw
CisjZW5kaWYgLyogQ09ORklHX0FSQ0hfQVQ5MSAqLwogI2RlZmluZSBBVDkxX1ZBX0JBU0VfVENC
MCAgICBBVDkxX0lPX1AyVihBVDkxX0JBU0VfVENCMCkKICNlbmRpZiAvKiBDT05GSUdfSVBJUEUg
Ki8KIApTZXVsZW1lbnQgZGFucyBsaW51eC0yLjYuMjAuMTMtOTI2My9pbmNsdWRlL2FzbS1hcm0v
YXJjaDogaGFyZHdhcmUuaC5vcmlnCmRpZmYgLWF1cmRwYkIgLVggbm9kaWZmIGxpbnV4LTIuNi4y
MC4xMy05MjYzLWNsZWFuL2luY2x1ZGUvYXNtLWFybS9hcmNoL2lycXMuaCBsaW51eC0yLjYuMjAu
MTMtOTI2My9pbmNsdWRlL2FzbS1hcm0vYXJjaC9pcnFzLmgKLS0tIGxpbnV4LTIuNi4yMC4xMy05
MjYzLWNsZWFuL2luY2x1ZGUvYXNtLWFybS9hcmNoL2lycXMuaAkyMDA3LTA2LTE4IDE0OjE3OjE4
LjAwMDAwMDAwMCArMDIwMAorKysgbGludXgtMi42LjIwLjEzLTkyNjMvaW5jbHVkZS9hc20tYXJt
L2FyY2gvaXJxcy5oCTIwMDctMDYtMTggMTQ6MzU6NTQuMDAwMDAwMDAwICswMjAwCkBAIC01NSw3
ICs1NSwxMSBAQCBleHRlcm4gdW5zaWduZWQgX19pcGlwZV9hdDkxX2dwaW9fYmFua3M7CiAjZWxp
ZiBkZWZpbmVkKENPTkZJR19BUkNIX0FUOTFTQU05MjYxKQogI2RlZmluZSBfX2lwaXBlX21hY2hf
aXJxX211eF9wKGlycSkJCQkJCVwKIAkoKHVuc2lnbmVkKSAoaXJxIC0gQVQ5MVNBTTkyNjFfSURf
UElPQSkgPCBfX2lwaXBlX2F0OTFfZ3Bpb19iYW5rcykKLSNlbmRpZiAvKiBDT05GSUdfQVJDSF9B
VDkxU0FNOTI2MSAqLworCisjZWxpZiBkZWZpbmVkKENPTkZJR19BUkNIX0FUOTFTQU05MjYzKQor
I2RlZmluZSBfX2lwaXBlX21hY2hfaXJxX211eF9wKGlycSkJCQkJCVwKKwkoKHVuc2lnbmVkKSAo
aXJxIC0gQVQ5MVNBTTkyNjNfSURfUElPQSkgPCBfX2lwaXBlX2F0OTFfZ3Bpb19iYW5rcykKKyNl
bmRpZiAvKiBDT05GSUdfQVJDSF9BVDkxICovCiAKICNlbmRpZiAvKiBDT05GSUdfSVBJUEUgJiYg
IV9fQVNTRU1CTFlfXyAqLwogClNldWxlbWVudCBkYW5zIGxpbnV4LTIuNi4yMC4xMy05MjYzL2lu
Y2x1ZGUvYXNtLWFybS9hcmNoOiBpcnFzLmgub3JpZwpTZXVsZW1lbnQgZGFucyBsaW51eC0yLjYu
MjAuMTMtOTI2My9pbmNsdWRlL2FzbS1hcm0vYXJjaDogdGltZXguaC5vcmlnCmRpZmYgLWF1cmRw
YkIgLVggbm9kaWZmIGxpbnV4LTIuNi4yMC4xMy05MjYzLWNsZWFuL2luY2x1ZGUvYXNtLWFybS9h
cmNoLWF0OTFybTkyMDAvaGFyZHdhcmUuaCBsaW51eC0yLjYuMjAuMTMtOTI2My9pbmNsdWRlL2Fz
bS1hcm0vYXJjaC1hdDkxcm05MjAwL2hhcmR3YXJlLmgKLS0tIGxpbnV4LTIuNi4yMC4xMy05MjYz
LWNsZWFuL2luY2x1ZGUvYXNtLWFybS9hcmNoLWF0OTFybTkyMDAvaGFyZHdhcmUuaAkyMDA3LTA2
LTE4IDE0OjE3OjE4LjAwMDAwMDAwMCArMDIwMAorKysgbGludXgtMi42LjIwLjEzLTkyNjMvaW5j
bHVkZS9hc20tYXJtL2FyY2gtYXQ5MXJtOTIwMC9oYXJkd2FyZS5oCTIwMDctMDYtMTkgMTY6MjU6
NDguMDAwMDAwMDAwICswMjAwCkBAIC01Myw3ICs1Myw5IEBACiAjZGVmaW5lIEFUOTFfQkFTRV9U
Q0IwICAgICAgIEFUOTFTQU05MjYwX0JBU0VfVENCMAogI2VsaWYgZGVmaW5lZChDT05GSUdfQVJD
SF9BVDkxU0FNOTI2MSkKICNkZWZpbmUgQVQ5MV9CQVNFX1RDQjAgICAgICAgQVQ5MVNBTTkyNjFf
QkFTRV9UQ0IwCi0jZW5kaWYgLyogQ09ORklHX0FSQ0hfQVQ5MVNBTTkyNjEgKi8KKyNlbGlmIGRl
ZmluZWQoQ09ORklHX0FSQ0hfQVQ5MVNBTTkyNjMpCisjZGVmaW5lIEFUOTFfQkFTRV9UQ0IwICAg
ICAgIEFUOTFTQU05MjYzX0JBU0VfVENCMAorI2VuZGlmIC8qIENPTkZJR19BUkNIX0FUOTEgKi8K
ICNkZWZpbmUgQVQ5MV9WQV9CQVNFX1RDQjAgICAgQVQ5MV9JT19QMlYoQVQ5MV9CQVNFX1RDQjAp
CiAjZW5kaWYgLyogQ09ORklHX0lQSVBFICovCiAKU2V1bGVtZW50IGRhbnMgbGludXgtMi42LjIw
LjEzLTkyNjMvaW5jbHVkZS9hc20tYXJtL2FyY2gtYXQ5MXJtOTIwMDogaGFyZHdhcmUuaC5vcmln
CmRpZmYgLWF1cmRwYkIgLVggbm9kaWZmIGxpbnV4LTIuNi4yMC4xMy05MjYzLWNsZWFuL2luY2x1
ZGUvYXNtLWFybS9hcmNoLWF0OTFybTkyMDAvaXJxcy5oIGxpbnV4LTIuNi4yMC4xMy05MjYzL2lu
Y2x1ZGUvYXNtLWFybS9hcmNoLWF0OTFybTkyMDAvaXJxcy5oCi0tLSBsaW51eC0yLjYuMjAuMTMt
OTI2My1jbGVhbi9pbmNsdWRlL2FzbS1hcm0vYXJjaC1hdDkxcm05MjAwL2lycXMuaAkyMDA3LTA2
LTE4IDE0OjE3OjE4LjAwMDAwMDAwMCArMDIwMAorKysgbGludXgtMi42LjIwLjEzLTkyNjMvaW5j
bHVkZS9hc20tYXJtL2FyY2gtYXQ5MXJtOTIwMC9pcnFzLmgJMjAwNy0wNi0xOCAxNDozNTo1NC4w
MDAwMDAwMDAgKzAyMDAKQEAgLTU1LDcgKzU1LDExIEBAIGV4dGVybiB1bnNpZ25lZCBfX2lwaXBl
X2F0OTFfZ3Bpb19iYW5rczsKICNlbGlmIGRlZmluZWQoQ09ORklHX0FSQ0hfQVQ5MVNBTTkyNjEp
CiAjZGVmaW5lIF9faXBpcGVfbWFjaF9pcnFfbXV4X3AoaXJxKQkJCQkJXAogCSgodW5zaWduZWQp
IChpcnEgLSBBVDkxU0FNOTI2MV9JRF9QSU9BKSA8IF9faXBpcGVfYXQ5MV9ncGlvX2JhbmtzKQot
I2VuZGlmIC8qIENPTkZJR19BUkNIX0FUOTFTQU05MjYxICovCisKKyNlbGlmIGRlZmluZWQoQ09O
RklHX0FSQ0hfQVQ5MVNBTTkyNjMpCisjZGVmaW5lIF9faXBpcGVfbWFjaF9pcnFfbXV4X3AoaXJx
KQkJCQkJXAorCSgodW5zaWduZWQpIChpcnEgLSBBVDkxU0FNOTI2M19JRF9QSU9BKSA8IF9faXBp
cGVfYXQ5MV9ncGlvX2JhbmtzKQorI2VuZGlmIC8qIENPTkZJR19BUkNIX0FUOTEgKi8KIAogI2Vu
ZGlmIC8qIENPTkZJR19JUElQRSAmJiAhX19BU1NFTUJMWV9fICovCiAKU2V1bGVtZW50IGRhbnMg
bGludXgtMi42LjIwLjEzLTkyNjMvaW5jbHVkZS9hc20tYXJtL2FyY2gtYXQ5MXJtOTIwMDogaXJx
cy5oLm9yaWcKU2V1bGVtZW50IGRhbnMgbGludXgtMi42LjIwLjEzLTkyNjMvaW5jbHVkZS9hc20t
YXJtL2FyY2gtYXQ5MXJtOTIwMDogdGltZXguaC5vcmlnClNldWxlbWVudCBkYW5zIGxpbnV4LTIu
Ni4yMC4xMy05MjYzL2luY2x1ZGU6IGNvbmZpZwpTZXVsZW1lbnQgZGFucyBsaW51eC0yLjYuMjAu
MTMtOTI2My9pbmNsdWRlL2xpbnV4OiBhdXRvY29uZi5oClNldWxlbWVudCBkYW5zIGxpbnV4LTIu
Ni4yMC4xMy05MjYzL2luY2x1ZGUvbGludXg6IGNvbXBpbGUuaApTZXVsZW1lbnQgZGFucyBsaW51
eC0yLjYuMjAuMTMtOTI2My9pbmNsdWRlL2xpbnV4OiB1dHNyZWxlYXNlLmgKU2V1bGVtZW50IGRh
bnMgbGludXgtMi42LjIwLjEzLTkyNjMvaW5jbHVkZS9saW51eDogdmVyc2lvbi5oClNldWxlbWVu
dCBkYW5zIGxpbnV4LTIuNi4yMC4xMy05MjYzL2xpYjogY3JjMzJ0YWJsZS5oClNldWxlbWVudCBk
YW5zIGxpbnV4LTIuNi4yMC4xMy05MjYzL2xpYjogZ2VuX2NyYzMydGFibGUKU2V1bGVtZW50IGRh
bnMgbGludXgtMi42LjIwLjEzLTkyNjMvc2NyaXB0cy9iYXNpYzogZG9jcHJvYwpTZXVsZW1lbnQg
ZGFucyBsaW51eC0yLjYuMjAuMTMtOTI2My9zY3JpcHRzL2Jhc2ljOiBmaXhkZXAKU2V1bGVtZW50
IGRhbnMgbGludXgtMi42LjIwLjEzLTkyNjMvc2NyaXB0czogYmluMmMKU2V1bGVtZW50IGRhbnMg
bGludXgtMi42LjIwLjEzLTkyNjMvc2NyaXB0czogY29ubWFrZWhhc2gKU2V1bGVtZW50IGRhbnMg
bGludXgtMi42LjIwLjEzLTkyNjMvc2NyaXB0czoga2FsbHN5bXMKU2V1bGVtZW50IGRhbnMgbGlu
dXgtMi42LjIwLjEzLTkyNjMvc2NyaXB0cy9rY29uZmlnOiBjb25mClNldWxlbWVudCBkYW5zIGxp
bnV4LTIuNi4yMC4xMy05MjYzL3NjcmlwdHMva2NvbmZpZzogbGV4Lnpjb25mLmMKU2V1bGVtZW50
IGRhbnMgbGludXgtMi42LjIwLjEzLTkyNjMvc2NyaXB0cy9rY29uZmlnOiB6Y29uZi5oYXNoLmMK
U2V1bGVtZW50IGRhbnMgbGludXgtMi42LjIwLjEzLTkyNjMvc2NyaXB0cy9rY29uZmlnOiB6Y29u
Zi50YWIuYwpTZXVsZW1lbnQgZGFucyBsaW51eC0yLjYuMjAuMTMtOTI2My9zY3JpcHRzL21vZDog
ZWxmY29uZmlnLmgKU2V1bGVtZW50IGRhbnMgbGludXgtMi42LjIwLjEzLTkyNjMvc2NyaXB0cy9t
b2Q6IG1rX2VsZmNvbmZpZwpTZXVsZW1lbnQgZGFucyBsaW51eC0yLjYuMjAuMTMtOTI2My9zY3Jp
cHRzL21vZDogbW9kcG9zdApTZXVsZW1lbnQgZGFucyBsaW51eC0yLjYuMjAuMTMtOTI2My91c3I6
IGdlbl9pbml0X2NwaW8K

------_=_NextPart_001_01C7B4E3.A1FF664C--

