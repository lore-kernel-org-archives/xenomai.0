Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 2 May 2007 11:04:09 +0200
Message-ID: <403B28AE6257B548B66BB88414AC78330174BBE4@domain.hid>
In-Reply-To: <305035a40704240527y455c74aemb0b8e80148b008db@domain.hid>
From: "BOUIN Alexandre" <abouin@domain.hid>
Subject: Re: [Adeos-main] [PATCH] Adeos support for AT91SAM92x ( AT91SAM9260
	and AT91SAM9261)
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: adeos-main@gna.org

According to all tips Gilles has given us, we finally post our last =
results with AT91SAM9260-EK Board.

As announced previously, we use this patched kernel.
Nucleus latency was set to 40=B5s (40000ns).
The uclibc Buildroot envirronnement was hosted by our host system via =
nfs.
We performed 2 tests : one under dd load and another one under an =
heavier load using Bonnie++, Calibrator and a ping to our host system.

Comments are welcome.

So here are our histogram and statistics :=20

 - DD load results :=20

---|--param|----range-|--samples
HSD|    min|   7 -  8 |       23
HSD|    min|   8 -  9 |      470
HSD|    min|   9 - 10 |     5524
HSD|    min|  10 - 11 |    10921
HSD|    min|  11 - 12 |     9897
HSD|    min|  12 - 13 |     2311
HSD|    min|  13 - 14 |       35
HSD|    min|  32 - 33 |        1
---|--param|----range-|--samples
HSD|    avg|   7 -  8 |       23
HSD|    avg|   8 -  9 |      471
HSD|    avg|   9 - 10 |     5910
HSD|    avg|  10 - 11 |    15789
HSD|    avg|  11 - 12 |    36278
HSD|    avg|  12 - 13 |    90018
HSD|    avg|  13 - 14 |   204887
HSD|    avg|  14 - 15 |   298100
HSD|    avg|  15 - 16 |   258292
HSD|    avg|  16 - 17 |   161504
HSD|    avg|  17 - 18 |    90341
HSD|    avg|  18 - 19 |    48553
HSD|    avg|  19 - 20 |    31356
HSD|    avg|  20 - 21 |    19468
HSD|    avg|  21 - 22 |    24162
HSD|    avg|  22 - 23 |    26104
HSD|    avg|  23 - 24 |    24633
HSD|    avg|  24 - 25 |    21022
HSD|    avg|  25 - 26 |    15905
HSD|    avg|  26 - 27 |    13305
HSD|    avg|  27 - 28 |    16697
HSD|    avg|  28 - 29 |    17545
HSD|    avg|  29 - 30 |     4363
HSD|    avg|  30 - 31 |     3432
HSD|    avg|  31 - 32 |     7512
HSD|    avg|  32 - 33 |     5992
HSD|    avg|  33 - 34 |     3659
HSD|    avg|  34 - 35 |     3240
HSD|    avg|  35 - 36 |     3783
HSD|    avg|  36 - 37 |   547627
HSD|    avg|  37 - 38 | 12729599
HSD|    avg|  38 - 39 | 77089778
HSD|    avg|  39 - 40 | 22621843
HSD|    avg|  40 - 41 |  1916567
HSD|    avg|  41 - 42 |   147142
HSD|    avg|  42 - 43 |    85184
HSD|    avg|  43 - 44 |    33597
HSD|    avg|  44 - 45 |    12214
HSD|    avg|  45 - 46 |     7891
HSD|    avg|  46 - 47 |     6819
HSD|    avg|  47 - 48 |     6777
HSD|    avg|  48 - 49 |     9836
HSD|    avg|  49 - 50 |     8094
HSD|    avg|  50 - 51 |    10521
HSD|    avg|  51 - 52 |    10963
HSD|    avg|  52 - 53 |     8708
HSD|    avg|  53 - 54 |     9251
HSD|    avg|  54 - 55 |     6819
HSD|    avg|  55 - 56 |     2458
HSD|    avg|  56 - 57 |     1430
HSD|    avg|  57 - 58 |      967
HSD|    avg|  58 - 59 |      496
HSD|    avg|  59 - 60 |      469
HSD|    avg|  60 - 61 |      170
HSD|    avg|  61 - 62 |       31
HSD|    avg|  62 - 63 |       14
HSD|    avg|  63 - 64 |       23
HSD|    avg|  64 - 65 |       24
HSD|    avg|  65 - 66 |       14
HSD|    avg|  66 - 67 |       13
HSD|    avg|  67 - 68 |       12
HSD|    avg|  68 - 69 |        5
HSD|    avg|  69 - 70 |        5
HSD|    avg|  70 - 71 |       11
HSD|    avg|  71 - 72 |       17
HSD|    avg|  72 - 73 |       27
HSD|    avg|  73 - 74 |       35
HSD|    avg|  74 - 75 |       83
HSD|    avg|  75 - 76 |       93
HSD|    avg|  76 - 77 |       45
HSD|    avg|  77 - 78 |       23
HSD|    avg|  78 - 79 |       30
HSD|    avg|  79 - 80 |        6
HSD|    avg|  80 - 81 |        2
HSD|    avg|  81 - 82 |        2
HSD|    avg|  84 - 85 |        1
---|--param|----range-|--samples
HSD|    max|  43 - 44 |        3
HSD|    max|  44 - 45 |       19
HSD|    max|  45 - 46 |      102
HSD|    max|  46 - 47 |      248
HSD|    max|  47 - 48 |      562
HSD|    max|  48 - 49 |     1267
HSD|    max|  49 - 50 |     1271
HSD|    max|  50 - 51 |     1953
HSD|    max|  51 - 52 |     2863
HSD|    max|  52 - 53 |     3791
HSD|    max|  53 - 54 |     5953
HSD|    max|  54 - 55 |     5271
HSD|    max|  55 - 56 |     2084
HSD|    max|  56 - 57 |     1284
HSD|    max|  57 - 58 |      904
HSD|    max|  58 - 59 |      490
HSD|    max|  59 - 60 |      463
HSD|    max|  60 - 61 |      167
HSD|    max|  61 - 62 |       31
HSD|    max|  62 - 63 |       14
HSD|    max|  63 - 64 |       21
HSD|    max|  64 - 65 |       22
HSD|    max|  65 - 66 |       14
HSD|    max|  66 - 67 |       11
HSD|    max|  67 - 68 |       12
HSD|    max|  68 - 69 |        5
HSD|    max|  69 - 70 |        5
HSD|    max|  70 - 71 |       10
HSD|    max|  71 - 72 |       16
HSD|    max|  72 - 73 |       25
HSD|    max|  73 - 74 |       30
HSD|    max|  74 - 75 |       76
HSD|    max|  75 - 76 |       87
HSD|    max|  76 - 77 |       45
HSD|    max|  77 - 78 |       23
HSD|    max|  78 - 79 |       29
HSD|    max|  79 - 80 |        6
HSD|    max|  80 - 81 |        2
HSD|    max|  81 - 82 |        2
HSD|    max|  84 - 85 |        1
HSH|--param|--samples-|--average--|---stddev--
HSS|    min|     29182|     10.278|      0.931
HSS|    avg| 116728080|      1.058|     36.887
HSS|    max|     29182|     52.983|      3.641
---|------------|------------|------------|--------|---------------------=
----
RTS|       7.087|      38.015|      84.407|       0|    =
08:06:23/08:06:23

 - Bonnie++, Calibrator, ping load results :=20

---|--param|----range-|--samples
HSD|    min|   0 -  1 |        1
HSD|    min|  13 - 14 |       17
HSD|    min|  14 - 15 |      271
HSD|    min|  15 - 16 |     1989
HSD|    min|  16 - 17 |     7223
HSD|    min|  17 - 18 |    18812
HSD|    min|  18 - 19 |    56597
HSD|    min|  19 - 20 |   118591
HSD|    min|  20 - 21 |    27122
HSD|    min|  21
 - 22 |     1526
HSD|    min|  22 - 23 |       10
HSD|    min|  45 - 46 |        1
---|--param|----range-|--samples
HSD|    avg|   0 -  1 |        1
HSD|    avg|   1 -  2 |        1
HSD|    avg|   2 -  3 |        5
HSD|    avg|   3 -  4 |        1
HSD|    avg|   6 -  7 |        1
HSD|    avg|  13 - 14 |       17
HSD|    avg|  14 - 15 |      271
HSD|    avg|  15 - 16 |     1989
HSD|    avg|  16 - 17 |     7235
HSD|    avg|  17 - 18 |    19631
HSD|    avg|  18 - 19 |    71130
HSD|    avg|  19 - 20 |   312498
HSD|    avg|  20 - 21 |   451474
HSD|    avg|  21 - 22 |   532035
HSD|    avg|  22 - 23 |   448286
HSD|    avg|  23 - 24 |   281441
HSD|    avg|  24 - 25 |   165942
HSD|    avg|  25 - 26 |   141774
HSD|    avg|  26 - 27 |   171955
HSD|    avg|  27 - 28 |   250416
HSD|    avg|  28 - 29 |   349206
HSD|    avg|  29 - 30 |   179498
HSD|    avg|  30 - 31 |   110430
HSD|    avg|  31 - 32 |   357107
HSD|    avg|  32 - 33 |  4200212
HSD|    avg|  33 - 34 | 10181440
HSD|    avg|  34 - 35 | 15326062
HSD|    avg|  35 - 36 |  5124584
HSD|    avg|  36 - 37 |  1510427
HSD|    avg|  37 - 38 |   880396
HSD|    avg|  38 - 39 |   616192
HSD|    avg|  39 - 40 |   319152
HSD|    avg|  40 - 41 |   123574
HSD|    avg|  41 - 42 |    50572
HSD|    avg|  42 - 43 |    40890
HSD|    avg|  43 - 44 |    36724
HSD|    avg|  44 - 45 |    38847
HSD|    avg|  45 - 46 |    50219
HSD|    avg|  46 - 47 |   165299
HSD|    avg|  47 - 48 |   224580
HSD|    avg|  48 - 49 |   124768
HSD|    avg|  49 - 50 |    55880
HSD|    avg|  50 - 51 |    31203
HSD|    avg|  51 - 52 |    15184
HSD|    avg|  52 - 53 |     9597
HSD|    avg|  53 - 54 |    10163
HSD|    avg|  54 - 55 |    12932
HSD|    avg|  55 - 56 |    15829
HSD|    avg|  56 - 57 |    13791
HSD|    avg|  57 - 58 |    11168
HSD|    avg|  58 - 59 |     7219
HSD|    avg|  59 - 60 |     6947
HSD|    avg|  60 - 61 |     6870
HSD|    avg|  61 - 62 |     5761
HSD|    avg|  62 - 63 |     4258
HSD|    avg|  63 - 64 |     3366
HSD|    avg|  64 - 65 |     2872
HSD|    avg|  65 - 66 |     2770
HSD|    avg|  66 - 67 |     2762
HSD|    avg|  67 - 68 |     3583
HSD|    avg|  68 - 69 |     2530
HSD|    avg|  69 - 70 |     2251
HSD|    avg|  70 - 71 |     2055
HSD|    avg|  71 - 72 |     3800
HSD|    avg|  72 - 73 |     5342
HSD|    avg|  73 - 74 |    15041
HSD|    avg|  74 - 75 |  1234004
HSD|    avg|  75 - 76 | 12292873
HSD|    avg|  76 - 77 |  3584889
HSD|    avg|  77 - 78 |  1184810
HSD|    avg|  78 - 79 | 36627942
HSD|    avg|  79 - 80 | 195365854
HSD|    avg|  80 - 81 | 159618422
HSD|    avg|  81 - 82 |  5753873
HSD|    avg|  82 - 83 |    73089
HSD|    avg|  83 - 84 |    86209
HSD|    avg|  84 - 85 |    69779
HSD|    avg|  85 - 86 |   100487
HSD|    avg|  86 - 87 |   114727
HSD|    avg|  87 - 88 |   150208
HSD|    avg|  88 - 89 |    96264
HSD|    avg|  89 - 90 |    60396
HSD|    avg|  90 - 91 |    39298
HSD|    avg|  91 - 92 |    21519
HSD|    avg|  92 - 93 |     9462
HSD|    avg|  93 - 94 |     4513
HSD|    avg|  94 - 95 |    10297
HSD|    avg|  95 - 96 |    10793
HSD|    avg|  96 - 97 |     1317
HSD|    avg|  97 - 98 |      447
HSD|    avg|  98 - 99 |      360
HSD|    avg|  99 -100 |      485
HSD|    avg| 100 -101 |      694
HSD|    avg| 101 -102 |      826
HSD|    avg| 102 -103 |      820
HSD|    avg| 103 -104 |      628
HSD|    avg| 104 -105 |      482
HSD|    avg| 105 -106 |      472
HSD|    avg| 106 -107 |    20981
HSD|    avg| 107 -108 |  2593259
HSD|    avg| 108 -109 |  2057151
HSD|    avg| 109 -110 |     2990
HSD|    avg| 110 -111 |      469
HSD|    avg| 111 -112 |     1067
HSD|    avg| 112 -113 |     2048
HSD|    avg| 113 -114 |     2318
HSD|    avg| 114 -115 |     1190
HSD|    avg| 115 -116 |      740
HSD|    avg| 116 -117 |      259
HSD|    avg| 117 -118 |      137
HSD|    avg| 118 -119 |      163
HSD|    avg| 119 -120 |      180
HSD|    avg| 120 -121 |      176
HSD|    avg| 121 -122 |      158
HSD|    avg| 122 -123 |      104
HSD|    avg| 123 -124 |       91
HSD|    avg| 124 -125 |      112
HSD|    avg| 125 -126 |      145
HSD|    avg| 126 -127 |       91
HSD|    avg| 127 -128 |       69
HSD|    avg| 128 -129 |       78
HSD|    avg| 129 -130 |      104
HSD|    avg| 130 -131 |      131
HSD|    avg| 131 -132 |      112
HSD|    avg| 132 -133 |      500
HSD|    avg| 133 -134 |      541
HSD|    avg| 134 -135 |      259
HSD|    avg| 135 -136 |      112
HSD|    avg| 136 -137 |       49
HSD|    avg| 137 -138 |       11
HSD|    avg| 138 -139 |        2
HSD|    avg| 139 -140 |        3
HSD|    avg| 140 -141 |        1
HSD|    avg| 141 -142 |        3
HSD|    avg| 142 -143 |        6
HSD|    avg| 143 -144 |       13
HSD|    avg| 144 -145 |       47
HSD|    avg| 145 -146 |       21
HSD|    avg| 146 -147 |       67
HSD|    avg| 147 -148 |       45
HSD|    avg| 148 -149 |       43
HSD|    avg| 149 -150 |       47
HSD|    avg| 150 -151 |       48
HSD|    avg| 151 -152 |       38
HSD|    avg| 152 -153 |       20
HSD|    avg| 153 -154 |       35
HSD|    avg| 154 -155 |        9
HSD|    avg| 155 -156 |        2
HSD|    avg| 156 -157 |        7
HSD|    avg| 158 -159 |        2
HSD|    avg| 159 -160 |        1
HSD|    avg| 160 -161 |        1
HSD|    avg| 162 -163 |        1
HSD|    avg| 163 -164 |        1
---|--param|----range-|--samples
HSD|    max|  47 - 48 |        1
HSD|    max|  54 - 55 |        1
HSD|    max|  59 - 60 |        2
HSD|    max|  60 - 61 |        2
HSD|    max|  70 - 71 |        1
HSD|    max|  71 - 72 |        2
HSD|    max|  72 - 73 |        1
HSD|    max|  73 - 74 |        1
HSD|    max|  74 - 75 |        1
HSD|    max|  75 - 76 |        1
HSD|    max|  76 - 77 |        4
HSD|    max|  77 - 78 |        2
HSD|    max|  79 - 80 |        2
HSD|    max|  80 - 81 |        3
HSD|    max|  81 - 82 |        4
HSD|    max|  82 - 83 |        1
HSD|    max|  84 - 85 |        1
HSD|    max|  96 - 97 |        1
HSD|    max|  97 - 98 |        1
HSD|    max|  99 -100 |        1
HSD|    max| 100 -101 |        2
HSD|    max| 102 -103 |        1
HSD|    max| 107 -108 |       31
HSD|    max| 108 -109 |   220562
HSD|    max| 109 -110 |     2714
HSD|    max| 110 -111 |      301
HSD|    max| 111 -112 |      922
HSD|    max| 112 -113 |     1851
HSD|    max| 113 -114 |     2145
HSD|    max| 114 -115 |     1075
HSD|    max| 115 -116 |      593
HSD|    max| 116 -117 |      148
HSD|    max| 117 -118 |       31
HSD|    max| 118 -119 |       75
HSD|    max| 119 -120 |       80
HSD|    max| 120 -121 |       74
HSD|    max| 121 -122 |       55
HSD|    max| 122 -123 |       14
HSD|    max| 123 -124 |        2
HSD|    max| 131 -132 |       11
HSD|    max| 132 -133 |      415
HSD|    max| 133 -134 |      444
HSD|    max| 134 -135 |      105
HSD|    max| 135 -136 |       10
HSD|    max| 136 -137 |        1
HSD|    max| 137 -138 |        2
HSD|    max| 138 -139 |        2
HSD|    max| 139 -140 |        3
HSD|    max| 140 -141 |        1
HSD|    max| 141 -142 |        3
HSD|    max| 142 -143 |        6
HSD|    max| 143 -144 |       13
HSD|    max| 144 -145 |       47
HSD|    max| 145 -146 |       21
HSD|    max| 146 -147 |       67
HSD|    max| 147 -148 |       45
HSD|    max| 148 -149 |       43
HSD|    max| 149 -150 |       47
HSD|    max| 150 -151 |       48
HSD|    max| 151 -152 |       38
HSD|    max| 152 -153 |       20
HSD|    max| 153 -154 |       35
HSD|    max| 154 -155 |        9
HSD|    max| 155 -156 |        2
HSD|    max| 156 -157 |        7
HSD|    max| 158 -159 |        2
HSD|    max| 159 -160 |        1
HSD|    max| 160 -161 |        1
HSD|    max| 162 -163 |        1
HSD|    max| 163 -164 |        1
HSH|--param|--samples-|--average--|---stddev--
HSS|    min|    232160|     18.590|      0.999
HSS|    avg| 464321953|      1.205|     75.272
HSS|    max|    232160|    108.352|      2.613
---|------------|------------|------------|--------|---------------------=
----
RTS|       0.966|      75.386|     163.981|       0|    =
64:29:22/64:29:22

- Xeno-Test results :=20

xeno-test: started -p 200
withBusybox is 1
xeno-test: running tests

Wed Dec 31 17:24:48 MST 1969
running: /usr/xenomai/bin/xeno-config --verbose
xeno-config --verbose
    --version=3D"2.3.1"
    =
--cc=3D"/home/abouin/RTAI/rootfs.arm.ext2/buildroot/build_arm/staging_dir=
/bin/arm-linux-uclibc-gcc"
    --arch=3D"arm"
    --prefix=3D"/usr/xenomai"
    --xeno-cflags=3D"-I/usr/xenomai/include -D_GNU_SOURCE -D_REENTRANT"
    --xeno-ldflags=3D"-L/usr/xenomai/lib -lpthread "
    --posix-cflags=3D"-I/usr/xenomai/include =
-I/usr/xenomai/include/posix -D_GNU_SOURCE -D_REENTRANT -D__XENO__"
    --posix-ldflags=3D"-L/usr/xenomai/lib -lpthread_rt -lpthread -lrt "
    --library-dir=3D"/usr/xenomai/lib"

Wed Dec 31 17:24:48 MST 1969
running: /usr/xenomai/bin/xeno-info
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

BusyBox v1.5.0 (2007-04-24 18:18:59 CEST) multi-call binary
Linux uclibc 2.6.19 #16 Mon Apr 30 17:00:43 CEST 2007 armv5tejl unknown

module-init-tools      found
/bin/sh: is setuid
Linux C Library        0.9.29
Linux C Library        0.9.29
Linux C Library        0.9.29
-v: No such file or directory
Modules Loaded

Wed Dec 31 17:24:49 MST 1969
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

Wed Dec 31 17:24:49 MST 1969
running: md5sum /proc/cpuinfo # cpuinfo fingerprint
36ded2a3d6ea6737b81fe246e04b70b2  /proc/cpuinfo

Wed Dec 31 17:24:49 MST 1969
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

Wed Dec 31 17:24:49 MST 1969
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

Wed Dec 31 17:24:49 MST 1969
running: cat /proc/ipipe/version
1.6-05

Wed Dec 31 17:24:50 MST 1969
running: generate_loads 1
dd workload started, pids 1106 stored in /var/lock/xeno-test.997.pids

Wed Dec 31 17:24:50 MST 1969
running: cat /proc/interrupts
           CPU0
  1:     142930         AIC  atmel_serial
 17:     149025         AIC  at91_tick
 21:          2         AIC  eth0
Err:          0

Wed Dec 31 17:24:50 MST 1969
running: cat /proc/loadavg
2.41 2.24 1.63 4/25 1112

Wed Dec 31 17:24:50 MST 1969
running: cat /proc/meminfo
MemTotal:        62560 kB
MemFree:         57616 kB
Buffers:             0 kB
Cached:           1620 kB
SwapCached:          0 kB
Active:           1980 kB
Inactive:          440 kB
SwapTotal:           0 kB
SwapFree:            0 kB
Dirty:               0 kB
Writeback:           0 kB
AnonPages:         820 kB
Mapped:            512 kB
Slab:             1580 kB
SReclaimable:      312 kB
SUnreclaim:       1268 kB
PageTables:        144 kB
NFS_Unstable:        0 kB
Bounce:              0 kB
CommitLimit:     31280 kB
Committed_AS:     2832 kB
VmallocTotal:   956416 kB
VmallocUsed:      8576 kB
VmallocChunk:   940028 kB

Wed Dec 31 17:24:50 MST 1969
running: cat /proc/xenomai/apc
APC          CPU0
  0:            0    (pipe_wakeup)
  1:         1271    (lostage_handler)
  2:            4    (registry_export)
  3:            0    (posix_signals_handler)

Wed Dec 31 17:24:50 MST 1969
running: cat /proc/xenomai/faults
TRAP         CPU0
  0:            0    (Data or instruction access)
  1:            0    (Section fault)
  2:            0    (Generic data abort)
  3:            0    (Unknown exception)
  4:            0    (Instruction breakpoint)
  5:         1201    (Floating point exception)
  6:            0    (VFP Floating point exception)
  7:            0    (Undefined instruction)

Wed Dec 31 17:24:51 MST 1969
running: cat /proc/xenomai/hal
1.6-05

Wed Dec 31 17:24:51 MST 1969
running: cat /proc/xenomai/heap
size=3D130560:used=3D64:pagesz=3D512

Wed Dec 31 17:24:51 MST 1969
running: cat /proc/xenomai/irq
IRQ         CPU0
 17:     6433203         [timer]
162:        2543         [virtual]

Wed Dec 31 17:24:51 MST 1969
running: cat /proc/xenomai/latency
39948

Wed Dec 31 17:24:52 MST 1969
running: cat /proc/xenomai/sched
CPU  PID    PRI      PERIOD   TIMEOUT    STAT       NAME
  0  0       -1      0        0          R          ROOT

Wed Dec 31 17:24:52 MST 1969
running: cat /proc/xenomai/timer
status=3Doneshot:setup=3D322:tickval=3D1:jiffies=3D1492095772873

Wed Dec 31 17:24:52 MST 1969
running: cat /proc/xenomai/version
2.3.1

Wed Dec 31 17:24:52 MST 1969
running: cat /proc/xenomai/interfaces/native
0

Wed Dec 31 17:24:53 MST 1969
running: cat /proc/xenomai/interfaces/posix
Mem: 5120K used, 57440K free, 0K shrd, 0K buff, 1620K cached
Load average: 2.29 2.22 1.63
  PID USER     STATUS   VSZ  PPID %CPU %MEM COMMAND
 1106 root     R       1392     1 98.0  2.2 dd
 1171 root     R       1396  1170  1.9  2.2 top
 1023 root     S       1420   997  0.0  2.2 xeno-test
 1167 root     S       1420  1023  0.0  2.2 xeno-test
 1170 root     S       1420  1167  0.0  2.2 xeno-test
  200 root     S       1416     1  0.0  2.2 sh
  997 root     S       1416   200  0.0  2.2 xeno-test

--=20
Alexandre BOUIN
Adeneo
2, chemin du Ruisseau - BP21
69136 Ecully Cedex
France
Tel : +33-4 72 18 08 40

-----Message d'origine-----
De : Gregory CLEMENT [mailto:gclement00@domain.hid]
Envoy=E9 : mardi 24 avril 2007 14:27
=C0 : adeos-main
Cc : BOUIN Alexandre; Preetam Joshi; Claudio Scordino
Objet : [PATCH] Adeos support for AT91SAM92x ( AT91SAM9260 and
AT91SAM9261)


Hi,
this is the last version of patch support for  AT91SAM926x, it now
support  AT91SAM9260 and  AT91SAM9261
To use it:
- take a vanilla linux
- apply the I-pipe patch
- apply the AT91 patch, then solve the three rejects by hand
- finally apply this patch

(as we also use NFS root on AT91SAM9260-EK, we needed to had support
for Ethernet MAC B, see
http://www.spinics.net/lists/arm/msg12707.html and
http://www.spinics.net/lists/arm/msg12961.html )

As there is no support for AT91SAM9263  in at91 patch in 2.6.19
kernel, we prefer wait for 2.6.20 (or higher) ipipe version for
integrate this chip.

performance with Xenomai on AT91SAM9260-EK and AT91SAM9261-EK coming =
soon.

--=20
Gregory CLEMENT
Adeneo
2, chemin du Ruisseau - BP21
69136 Ecully Cedex
France
Tel : +33-4 72 18 08 40

