Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C78C9D.48C7CCDA"
Date: Wed, 2 May 2007 11:35:56 +0200
Message-ID: <403B28AE6257B548B66BB88414AC78330174BBE6@domain.hid>
From: "BOUIN Alexandre" <abouin@domain.hid>
Subject: [Xenomai-core] Xenomai latency results on AT91SAM9260-EK board
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C78C9D.48C7CCDA
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

We tought that Xenomai users and developpers should be interrested by =
these results on AT91SAM9260-EK board. You can found our patch for Adeos =
here : https://mail.gna.org/public/adeos-main/2007-04/msg00066.html

According to all tips Gilles Chanteperdrix has given us, we finally post =
our last results with AT91SAM9260-EK Board.

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



------_=_NextPart_001_01C78C9D.48C7CCDA
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
<TITLE>Xenomai latency results on AT91SAM9260-EK board</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/rtf format -->

<P><FONT SIZE=3D2 FACE=3D"Courier New">We tought that Xenomai users and =
developpers should be interrested by these results on AT91SAM9260-EK =
board. You can found our patch for Adeos here : <A =
HREF=3D"https://mail.gna.org/public/adeos-main/2007-04/msg00066.html">htt=
ps://mail.gna.org/public/adeos-main/2007-04/msg00066.html</A></FONT></P>

<P><FONT SIZE=3D2 FACE=3D"Courier New">According to all tips Gilles =
Chanteperdrix has given us, we finally post our last results with =
AT91SAM9260-EK Board.</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Courier New">As announced previously, we use =
this patched kernel.</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">Nucleus latency was set to =
40=B5s (40000ns).</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">The uclibc Buildroot =
envirronnement was hosted by our host system via nfs.</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">We performed 2 tests : one under =
dd load and another one under an heavier load using Bonnie++, Calibrator =
and a ping to our host system.</FONT></P>

<P><FONT SIZE=3D2 FACE=3D"Courier New">Comments are welcome.</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Courier New">So here are our histogram and =
statistics : </FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp;- DD load results : </FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Courier =
New">---|--param|----range-|--samples</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
min|&nbsp;&nbsp; 7 -&nbsp; 8 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
23</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
min|&nbsp;&nbsp; 8 -&nbsp; 9 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 470</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
min|&nbsp;&nbsp; 9 - 10 |&nbsp;&nbsp;&nbsp;&nbsp; 5524</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
min|&nbsp; 10 - 11 |&nbsp;&nbsp;&nbsp; 10921</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
min|&nbsp; 11 - 12 |&nbsp;&nbsp;&nbsp;&nbsp; 9897</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
min|&nbsp; 12 - 13 |&nbsp;&nbsp;&nbsp;&nbsp; 2311</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
min|&nbsp; 13 - 14 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 35</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
min|&nbsp; 32 - 33 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier =
New">---|--param|----range-|--samples</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp;&nbsp; 7 -&nbsp; 8 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
23</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp;&nbsp; 8 -&nbsp; 9 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 471</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp;&nbsp; 9 - 10 |&nbsp;&nbsp;&nbsp;&nbsp; 5910</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 10 - 11 |&nbsp;&nbsp;&nbsp; 15789</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 11 - 12 |&nbsp;&nbsp;&nbsp; 36278</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 12 - 13 |&nbsp;&nbsp;&nbsp; 90018</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 13 - 14 |&nbsp;&nbsp; 204887</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 14 - 15 |&nbsp;&nbsp; 298100</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 15 - 16 |&nbsp;&nbsp; 258292</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 16 - 17 |&nbsp;&nbsp; 161504</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 17 - 18 |&nbsp;&nbsp;&nbsp; 90341</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 18 - 19 |&nbsp;&nbsp;&nbsp; 48553</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 19 - 20 |&nbsp;&nbsp;&nbsp; 31356</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 20 - 21 |&nbsp;&nbsp;&nbsp; 19468</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 21 - 22 |&nbsp;&nbsp;&nbsp; 24162</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 22 - 23 |&nbsp;&nbsp;&nbsp; 26104</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 23 - 24 |&nbsp;&nbsp;&nbsp; 24633</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 24 - 25 |&nbsp;&nbsp;&nbsp; 21022</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 25 - 26 |&nbsp;&nbsp;&nbsp; 15905</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 26 - 27 |&nbsp;&nbsp;&nbsp; 13305</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 27 - 28 |&nbsp;&nbsp;&nbsp; 16697</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 28 - 29 |&nbsp;&nbsp;&nbsp; 17545</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 29 - 30 |&nbsp;&nbsp;&nbsp;&nbsp; 4363</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 30 - 31 |&nbsp;&nbsp;&nbsp;&nbsp; 3432</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 31 - 32 |&nbsp;&nbsp;&nbsp;&nbsp; 7512</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 32 - 33 |&nbsp;&nbsp;&nbsp;&nbsp; 5992</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 33 - 34 |&nbsp;&nbsp;&nbsp;&nbsp; 3659</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 34 - 35 |&nbsp;&nbsp;&nbsp;&nbsp; 3240</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 35 - 36 |&nbsp;&nbsp;&nbsp;&nbsp; 3783</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 36 - 37 |&nbsp;&nbsp; 547627</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 37 - 38 | 12729599</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 38 - 39 | 77089778</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 39 - 40 | 22621843</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 40 - 41 |&nbsp; 1916567</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 41 - 42 |&nbsp;&nbsp; 147142</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 42 - 43 |&nbsp;&nbsp;&nbsp; 85184</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 43 - 44 |&nbsp;&nbsp;&nbsp; 33597</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 44 - 45 |&nbsp;&nbsp;&nbsp; 12214</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 45 - 46 |&nbsp;&nbsp;&nbsp;&nbsp; 7891</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 46 - 47 |&nbsp;&nbsp;&nbsp;&nbsp; 6819</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 47 - 48 |&nbsp;&nbsp;&nbsp;&nbsp; 6777</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 48 - 49 |&nbsp;&nbsp;&nbsp;&nbsp; 9836</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 49 - 50 |&nbsp;&nbsp;&nbsp;&nbsp; 8094</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 50 - 51 |&nbsp;&nbsp;&nbsp; 10521</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 51 - 52 |&nbsp;&nbsp;&nbsp; 10963</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 52 - 53 |&nbsp;&nbsp;&nbsp;&nbsp; 8708</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 53 - 54 |&nbsp;&nbsp;&nbsp;&nbsp; 9251</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 54 - 55 |&nbsp;&nbsp;&nbsp;&nbsp; 6819</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 55 - 56 |&nbsp;&nbsp;&nbsp;&nbsp; 2458</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 56 - 57 |&nbsp;&nbsp;&nbsp;&nbsp; 1430</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 57 - 58 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 967</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 58 - 59 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 496</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 59 - 60 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 469</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 60 - 61 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 170</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 61 - 62 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 31</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 62 - 63 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 14</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 63 - 64 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 23</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 64 - 65 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 24</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 65 - 66 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 14</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 66 - 67 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 13</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 67 - 68 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 12</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 68 - 69 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 5</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 69 - 70 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 5</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 70 - 71 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 11</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 71 - 72 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 17</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 72 - 73 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 27</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 73 - 74 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 35</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 74 - 75 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 83</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 75 - 76 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 93</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 76 - 77 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 45</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 77 - 78 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 23</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 78 - 79 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 30</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 79 - 80 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 6</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 80 - 81 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 81 - 82 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 84 - 85 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier =
New">---|--param|----range-|--samples</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
max|&nbsp; 43 - 44 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 3</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
max|&nbsp; 44 - 45 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 19</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
max|&nbsp; 45 - 46 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 102</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
max|&nbsp; 46 - 47 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 248</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
max|&nbsp; 47 - 48 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 562</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
max|&nbsp; 48 - 49 |&nbsp;&nbsp;&nbsp;&nbsp; 1267</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
max|&nbsp; 49 - 50 |&nbsp;&nbsp;&nbsp;&nbsp; 1271</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
max|&nbsp; 50 - 51 |&nbsp;&nbsp;&nbsp;&nbsp; 1953</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
max|&nbsp; 51 - 52 |&nbsp;&nbsp;&nbsp;&nbsp; 2863</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
max|&nbsp; 52 - 53 |&nbsp;&nbsp;&nbsp;&nbsp; 3791</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
max|&nbsp; 53 - 54 |&nbsp;&nbsp;&nbsp;&nbsp; 5953</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
max|&nbsp; 54 - 55 |&nbsp;&nbsp;&nbsp;&nbsp; 5271</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
max|&nbsp; 55 - 56 |&nbsp;&nbsp;&nbsp;&nbsp; 2084</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
max|&nbsp; 56 - 57 |&nbsp;&nbsp;&nbsp;&nbsp; 1284</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
max|&nbsp; 57 - 58 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 904</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
max|&nbsp; 58 - 59 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 490</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
max|&nbsp; 59 - 60 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 463</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
max|&nbsp; 60 - 61 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 167</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
max|&nbsp; 61 - 62 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 31</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
max|&nbsp; 62 - 63 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 14</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
max|&nbsp; 63 - 64 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 21</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
max|&nbsp; 64 - 65 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 22</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
max|&nbsp; 65 - 66 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 14</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
max|&nbsp; 66 - 67 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 11</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
max|&nbsp; 67 - 68 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 12</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
max|&nbsp; 68 - 69 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 5</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
max|&nbsp; 69 - 70 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 5</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
max|&nbsp; 70 - 71 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 10</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
max|&nbsp; 71 - 72 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 16</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
max|&nbsp; 72 - 73 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 25</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
max|&nbsp; 73 - 74 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 30</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
max|&nbsp; 74 - 75 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 76</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
max|&nbsp; 75 - 76 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 87</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
max|&nbsp; 76 - 77 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 45</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
max|&nbsp; 77 - 78 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 23</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
max|&nbsp; 78 - 79 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 29</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
max|&nbsp; 79 - 80 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 6</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
max|&nbsp; 80 - 81 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
max|&nbsp; 81 - 82 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
max|&nbsp; 84 - 85 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier =
New">HSH|--param|--samples-|--average--|---stddev--</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSS|&nbsp;&nbsp;&nbsp; =
min|&nbsp;&nbsp;&nbsp;&nbsp; 29182|&nbsp;&nbsp;&nbsp;&nbsp; =
10.278|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0.931</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSS|&nbsp;&nbsp;&nbsp; avg| =
116728080|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1.058|&nbsp;&nbsp;&nbsp;&nbsp; =
36.887</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSS|&nbsp;&nbsp;&nbsp; =
max|&nbsp;&nbsp;&nbsp;&nbsp; 29182|&nbsp;&nbsp;&nbsp;&nbsp; =
52.983|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 3.641</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier =
New">---|------------|------------|------------|--------|----------------=
---------</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier =
New">RTS|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
7.087|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
38.015|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
84.407|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0|&nbsp;&nbsp;&nbsp; =
08:06:23/08:06:23</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp;- Bonnie++, Calibrator, =
ping load results : </FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Courier =
New">---|--param|----range-|--samples</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
min|&nbsp;&nbsp; 0 -&nbsp; 1 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
1</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
min|&nbsp; 13 - 14 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 17</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
min|&nbsp; 14 - 15 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 271</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
min|&nbsp; 15 - 16 |&nbsp;&nbsp;&nbsp;&nbsp; 1989</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
min|&nbsp; 16 - 17 |&nbsp;&nbsp;&nbsp;&nbsp; 7223</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
min|&nbsp; 17 - 18 |&nbsp;&nbsp;&nbsp; 18812</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
min|&nbsp; 18 - 19 |&nbsp;&nbsp;&nbsp; 56597</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
min|&nbsp; 19 - 20 |&nbsp;&nbsp; 118591</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
min|&nbsp; 20 - 21 |&nbsp;&nbsp;&nbsp; 27122</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
min|&nbsp; 21</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp;- 22 =
|&nbsp;&nbsp;&nbsp;&nbsp; 1526</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
min|&nbsp; 22 - 23 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 10</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
min|&nbsp; 45 - 46 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier =
New">---|--param|----range-|--samples</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp;&nbsp; 0 -&nbsp; 1 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
1</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp;&nbsp; 1 -&nbsp; 2 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
1</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp;&nbsp; 2 -&nbsp; 3 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
5</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp;&nbsp; 3 -&nbsp; 4 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
1</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp;&nbsp; 6 -&nbsp; 7 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
1</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 13 - 14 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 17</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 14 - 15 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 271</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 15 - 16 |&nbsp;&nbsp;&nbsp;&nbsp; 1989</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 16 - 17 |&nbsp;&nbsp;&nbsp;&nbsp; 7235</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 17 - 18 |&nbsp;&nbsp;&nbsp; 19631</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 18 - 19 |&nbsp;&nbsp;&nbsp; 71130</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 19 - 20 |&nbsp;&nbsp; 312498</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 20 - 21 |&nbsp;&nbsp; 451474</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 21 - 22 |&nbsp;&nbsp; 532035</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 22 - 23 |&nbsp;&nbsp; 448286</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 23 - 24 |&nbsp;&nbsp; 281441</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 24 - 25 |&nbsp;&nbsp; 165942</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 25 - 26 |&nbsp;&nbsp; 141774</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 26 - 27 |&nbsp;&nbsp; 171955</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 27 - 28 |&nbsp;&nbsp; 250416</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 28 - 29 |&nbsp;&nbsp; 349206</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 29 - 30 |&nbsp;&nbsp; 179498</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 30 - 31 |&nbsp;&nbsp; 110430</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 31 - 32 |&nbsp;&nbsp; 357107</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 32 - 33 |&nbsp; 4200212</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 33 - 34 | 10181440</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 34 - 35 | 15326062</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 35 - 36 |&nbsp; 5124584</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 36 - 37 |&nbsp; 1510427</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 37 - 38 |&nbsp;&nbsp; 880396</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 38 - 39 |&nbsp;&nbsp; 616192</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 39 - 40 |&nbsp;&nbsp; 319152</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 40 - 41 |&nbsp;&nbsp; 123574</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 41 - 42 |&nbsp;&nbsp;&nbsp; 50572</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 42 - 43 |&nbsp;&nbsp;&nbsp; 40890</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 43 - 44 |&nbsp;&nbsp;&nbsp; 36724</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 44 - 45 |&nbsp;&nbsp;&nbsp; 38847</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 45 - 46 |&nbsp;&nbsp;&nbsp; 50219</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 46 - 47 |&nbsp;&nbsp; 165299</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 47 - 48 |&nbsp;&nbsp; 224580</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 48 - 49 |&nbsp;&nbsp; 124768</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 49 - 50 |&nbsp;&nbsp;&nbsp; 55880</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 50 - 51 |&nbsp;&nbsp;&nbsp; 31203</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 51 - 52 |&nbsp;&nbsp;&nbsp; 15184</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 52 - 53 |&nbsp;&nbsp;&nbsp;&nbsp; 9597</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 53 - 54 |&nbsp;&nbsp;&nbsp; 10163</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 54 - 55 |&nbsp;&nbsp;&nbsp; 12932</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 55 - 56 |&nbsp;&nbsp;&nbsp; 15829</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 56 - 57 |&nbsp;&nbsp;&nbsp; 13791</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 57 - 58 |&nbsp;&nbsp;&nbsp; 11168</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 58 - 59 |&nbsp;&nbsp;&nbsp;&nbsp; 7219</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 59 - 60 |&nbsp;&nbsp;&nbsp;&nbsp; 6947</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 60 - 61 |&nbsp;&nbsp;&nbsp;&nbsp; 6870</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 61 - 62 |&nbsp;&nbsp;&nbsp;&nbsp; 5761</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 62 - 63 |&nbsp;&nbsp;&nbsp;&nbsp; 4258</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 63 - 64 |&nbsp;&nbsp;&nbsp;&nbsp; 3366</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 64 - 65 |&nbsp;&nbsp;&nbsp;&nbsp; 2872</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 65 - 66 |&nbsp;&nbsp;&nbsp;&nbsp; 2770</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 66 - 67 |&nbsp;&nbsp;&nbsp;&nbsp; 2762</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 67 - 68 |&nbsp;&nbsp;&nbsp;&nbsp; 3583</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 68 - 69 |&nbsp;&nbsp;&nbsp;&nbsp; 2530</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 69 - 70 |&nbsp;&nbsp;&nbsp;&nbsp; 2251</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 70 - 71 |&nbsp;&nbsp;&nbsp;&nbsp; 2055</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 71 - 72 |&nbsp;&nbsp;&nbsp;&nbsp; 3800</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 72 - 73 |&nbsp;&nbsp;&nbsp;&nbsp; 5342</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 73 - 74 |&nbsp;&nbsp;&nbsp; 15041</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 74 - 75 |&nbsp; 1234004</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 75 - 76 | 12292873</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 76 - 77 |&nbsp; 3584889</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 77 - 78 |&nbsp; 1184810</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 78 - 79 | 36627942</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 79 - 80 | 195365854</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 80 - 81 | 159618422</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 81 - 82 |&nbsp; 5753873</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 82 - 83 |&nbsp;&nbsp;&nbsp; 73089</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 83 - 84 |&nbsp;&nbsp;&nbsp; 86209</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 84 - 85 |&nbsp;&nbsp;&nbsp; 69779</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 85 - 86 |&nbsp;&nbsp; 100487</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 86 - 87 |&nbsp;&nbsp; 114727</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 87 - 88 |&nbsp;&nbsp; 150208</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 88 - 89 |&nbsp;&nbsp;&nbsp; 96264</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 89 - 90 |&nbsp;&nbsp;&nbsp; 60396</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 90 - 91 |&nbsp;&nbsp;&nbsp; 39298</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 91 - 92 |&nbsp;&nbsp;&nbsp; 21519</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 92 - 93 |&nbsp;&nbsp;&nbsp;&nbsp; 9462</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 93 - 94 |&nbsp;&nbsp;&nbsp;&nbsp; 4513</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 94 - 95 |&nbsp;&nbsp;&nbsp; 10297</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 95 - 96 |&nbsp;&nbsp;&nbsp; 10793</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 96 - 97 |&nbsp;&nbsp;&nbsp;&nbsp; 1317</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 97 - 98 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 447</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 98 - 99 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 360</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
avg|&nbsp; 99 -100 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 485</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; avg| 100 =
-101 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 694</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; avg| 101 =
-102 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 826</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; avg| 102 =
-103 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 820</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; avg| 103 =
-104 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 628</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; avg| 104 =
-105 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 482</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; avg| 105 =
-106 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 472</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; avg| 106 =
-107 |&nbsp;&nbsp;&nbsp; 20981</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; avg| 107 =
-108 |&nbsp; 2593259</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; avg| 108 =
-109 |&nbsp; 2057151</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; avg| 109 =
-110 |&nbsp;&nbsp;&nbsp;&nbsp; 2990</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; avg| 110 =
-111 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 469</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; avg| 111 =
-112 |&nbsp;&nbsp;&nbsp;&nbsp; 1067</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; avg| 112 =
-113 |&nbsp;&nbsp;&nbsp;&nbsp; 2048</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; avg| 113 =
-114 |&nbsp;&nbsp;&nbsp;&nbsp; 2318</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; avg| 114 =
-115 |&nbsp;&nbsp;&nbsp;&nbsp; 1190</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; avg| 115 =
-116 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 740</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; avg| 116 =
-117 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 259</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; avg| 117 =
-118 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 137</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; avg| 118 =
-119 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 163</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; avg| 119 =
-120 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 180</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; avg| 120 =
-121 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 176</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; avg| 121 =
-122 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 158</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; avg| 122 =
-123 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 104</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; avg| 123 =
-124 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 91</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; avg| 124 =
-125 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 112</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; avg| 125 =
-126 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 145</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; avg| 126 =
-127 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 91</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; avg| 127 =
-128 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 69</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; avg| 128 =
-129 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 78</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; avg| 129 =
-130 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 104</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; avg| 130 =
-131 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 131</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; avg| 131 =
-132 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 112</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; avg| 132 =
-133 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 500</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; avg| 133 =
-134 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 541</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; avg| 134 =
-135 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 259</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; avg| 135 =
-136 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 112</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; avg| 136 =
-137 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 49</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; avg| 137 =
-138 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 11</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; avg| 138 =
-139 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; avg| 139 =
-140 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 3</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; avg| 140 =
-141 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; avg| 141 =
-142 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 3</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; avg| 142 =
-143 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 6</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; avg| 143 =
-144 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 13</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; avg| 144 =
-145 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 47</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; avg| 145 =
-146 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 21</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; avg| 146 =
-147 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 67</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; avg| 147 =
-148 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 45</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; avg| 148 =
-149 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 43</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; avg| 149 =
-150 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 47</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; avg| 150 =
-151 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 48</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; avg| 151 =
-152 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 38</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; avg| 152 =
-153 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 20</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; avg| 153 =
-154 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 35</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; avg| 154 =
-155 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 9</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; avg| 155 =
-156 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; avg| 156 =
-157 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 7</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; avg| 158 =
-159 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; avg| 159 =
-160 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; avg| 160 =
-161 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; avg| 162 =
-163 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; avg| 163 =
-164 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier =
New">---|--param|----range-|--samples</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
max|&nbsp; 47 - 48 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
max|&nbsp; 54 - 55 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
max|&nbsp; 59 - 60 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
max|&nbsp; 60 - 61 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
max|&nbsp; 70 - 71 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
max|&nbsp; 71 - 72 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
max|&nbsp; 72 - 73 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
max|&nbsp; 73 - 74 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
max|&nbsp; 74 - 75 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
max|&nbsp; 75 - 76 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
max|&nbsp; 76 - 77 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 4</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
max|&nbsp; 77 - 78 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
max|&nbsp; 79 - 80 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
max|&nbsp; 80 - 81 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 3</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
max|&nbsp; 81 - 82 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 4</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
max|&nbsp; 82 - 83 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
max|&nbsp; 84 - 85 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
max|&nbsp; 96 - 97 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
max|&nbsp; 97 - 98 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; =
max|&nbsp; 99 -100 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; max| 100 =
-101 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; max| 102 =
-103 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; max| 107 =
-108 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 31</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; max| 108 =
-109 |&nbsp;&nbsp; 220562</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; max| 109 =
-110 |&nbsp;&nbsp;&nbsp;&nbsp; 2714</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; max| 110 =
-111 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 301</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; max| 111 =
-112 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 922</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; max| 112 =
-113 |&nbsp;&nbsp;&nbsp;&nbsp; 1851</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; max| 113 =
-114 |&nbsp;&nbsp;&nbsp;&nbsp; 2145</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; max| 114 =
-115 |&nbsp;&nbsp;&nbsp;&nbsp; 1075</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; max| 115 =
-116 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 593</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; max| 116 =
-117 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 148</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; max| 117 =
-118 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 31</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; max| 118 =
-119 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 75</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; max| 119 =
-120 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 80</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; max| 120 =
-121 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 74</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; max| 121 =
-122 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 55</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; max| 122 =
-123 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 14</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; max| 123 =
-124 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; max| 131 =
-132 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 11</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; max| 132 =
-133 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 415</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; max| 133 =
-134 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 444</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; max| 134 =
-135 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 105</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; max| 135 =
-136 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 10</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; max| 136 =
-137 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; max| 137 =
-138 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; max| 138 =
-139 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; max| 139 =
-140 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 3</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; max| 140 =
-141 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; max| 141 =
-142 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 3</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; max| 142 =
-143 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 6</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; max| 143 =
-144 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 13</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; max| 144 =
-145 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 47</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; max| 145 =
-146 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 21</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; max| 146 =
-147 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 67</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; max| 147 =
-148 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 45</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; max| 148 =
-149 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 43</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; max| 149 =
-150 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 47</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; max| 150 =
-151 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 48</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; max| 151 =
-152 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 38</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; max| 152 =
-153 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 20</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; max| 153 =
-154 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 35</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; max| 154 =
-155 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 9</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; max| 155 =
-156 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; max| 156 =
-157 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 7</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; max| 158 =
-159 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; max| 159 =
-160 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; max| 160 =
-161 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; max| 162 =
-163 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSD|&nbsp;&nbsp;&nbsp; max| 163 =
-164 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier =
New">HSH|--param|--samples-|--average--|---stddev--</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSS|&nbsp;&nbsp;&nbsp; =
min|&nbsp;&nbsp;&nbsp; 232160|&nbsp;&nbsp;&nbsp;&nbsp; =
18.590|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0.999</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSS|&nbsp;&nbsp;&nbsp; avg| =
464321953|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1.205|&nbsp;&nbsp;&nbsp;&nbsp; =
75.272</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HSS|&nbsp;&nbsp;&nbsp; =
max|&nbsp;&nbsp;&nbsp; 232160|&nbsp;&nbsp;&nbsp; =
108.352|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2.613</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier =
New">---|------------|------------|------------|--------|----------------=
---------</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier =
New">RTS|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0.966|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 75.386|&nbsp;&nbsp;&nbsp;&nbsp; =
163.981|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0|&nbsp;&nbsp;&nbsp; =
64:29:22/64:29:22</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Courier New">- Xeno-Test results : </FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Courier New">xeno-test: started -p 200</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">withBusybox is 1</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">xeno-test: running tests</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Courier New">Wed Dec 31 17:24:48 MST =
1969</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">running: =
/usr/xenomai/bin/xeno-config --verbose</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">xeno-config --verbose</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp;&nbsp;&nbsp; =
--version=3D&quot;2.3.1&quot;</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp;&nbsp;&nbsp; =
--cc=3D&quot;/home/abouin/RTAI/rootfs.arm.ext2/buildroot/build_arm/stagin=
g_dir/bin/arm-linux-uclibc-gcc&quot;</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp;&nbsp;&nbsp; =
--arch=3D&quot;arm&quot;</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp;&nbsp;&nbsp; =
--prefix=3D&quot;/usr/xenomai&quot;</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp;&nbsp;&nbsp; =
--xeno-cflags=3D&quot;-I/usr/xenomai/include -D_GNU_SOURCE =
-D_REENTRANT&quot;</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp;&nbsp;&nbsp; =
--xeno-ldflags=3D&quot;-L/usr/xenomai/lib -lpthread &quot;</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp;&nbsp;&nbsp; =
--posix-cflags=3D&quot;-I/usr/xenomai/include =
-I/usr/xenomai/include/posix -D_GNU_SOURCE -D_REENTRANT =
-D__XENO__&quot;</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp;&nbsp;&nbsp; =
--posix-ldflags=3D&quot;-L/usr/xenomai/lib -lpthread_rt -lpthread -lrt =
&quot;</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp;&nbsp;&nbsp; =
--library-dir=3D&quot;/usr/xenomai/lib&quot;</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Courier New">Wed Dec 31 17:24:48 MST =
1969</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">running: =
/usr/xenomai/bin/xeno-info</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">If some fields are empty or look =
unusual you may have an old version.</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">Compare to the current minimal =
requirements in Documentation/Changes.</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Courier New">BusyBox v1.5.0 (2007-04-24 =
18:18:59 CEST) multi-call binary</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">Linux uclibc 2.6.19 #16 Mon Apr =
30 17:00:43 CEST 2007 armv5tejl unknown</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Courier =
New">module-init-tools&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; found</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">/bin/sh: is setuid</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">Linux C =
Library&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0.9.29</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">Linux C =
Library&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0.9.29</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">Linux C =
Library&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0.9.29</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">-v: No such file or =
directory</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">Modules Loaded</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Courier New">Wed Dec 31 17:24:49 MST =
1969</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">running: cat =
/proc/cpuinfo</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier =
New">Processor&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; : ARM926EJ-S rev 5 =
(v5l)</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier =
New">BogoMIPS&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; : 98.91</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier =
New">Features&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; : swp half =
fastmult edsp java</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">CPU implementer : 0x41</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">CPU architecture: 5TEJ</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">CPU =
variant&nbsp;&nbsp;&nbsp;&nbsp; : 0x0</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">CPU =
part&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; : 0x926</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">CPU revision&nbsp;&nbsp;&nbsp; : =
5</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">Cache =
type&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; : write-back</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">Cache =
clean&nbsp;&nbsp;&nbsp;&nbsp; : cp15 c7 ops</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">Cache lockdown&nbsp; : format =
C</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">Cache format&nbsp;&nbsp;&nbsp; : =
Harvard</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">I =
size&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; : 8192</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">I =
assoc&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; : 4</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">I line length&nbsp;&nbsp; : =
32</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">I =
sets&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; : 64</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">D =
size&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; : 8192</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">D =
assoc&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; : 4</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">D line length&nbsp;&nbsp; : =
32</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">D =
sets&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; : 64</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Courier =
New">Hardware&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; : Atmel =
AT91SAM9260-EK</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier =
New">Revision&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; : 0000</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier =
New">Serial&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; : =
0000000000000000</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Courier New">Wed Dec 31 17:24:49 MST =
1969</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">running: md5sum /proc/cpuinfo # =
cpuinfo fingerprint</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier =
New">36ded2a3d6ea6737b81fe246e04b70b2&nbsp; /proc/cpuinfo</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Courier New">Wed Dec 31 17:24:49 MST =
1969</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">running: cat =
/proc/ipipe/Linux</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier =
New">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +----- Handling ([A]ccepted, =
[G]rabbed, [W]ired, [D]iscarded)</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier =
New">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |+---- Sticky</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier =
New">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ||+--- Locked</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier =
New">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |||+-- Exclusive</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier =
New">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ||||+- Virtual</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">[IRQ]&nbsp; |||||</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp;&nbsp; 0:&nbsp; =
A....</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp;&nbsp; 1:&nbsp; =
A....</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp;&nbsp; 2:&nbsp; =
A....</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp;&nbsp; 3:&nbsp; =
A....</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp;&nbsp; 4:&nbsp; =
A....</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp;&nbsp; 5:&nbsp; =
A....</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp;&nbsp; 6:&nbsp; =
A....</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp;&nbsp; 7:&nbsp; =
A....</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp;&nbsp; 8:&nbsp; =
A....</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp;&nbsp; 9:&nbsp; =
A....</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp; 10:&nbsp; A....</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp; 11:&nbsp; A....</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp; 12:&nbsp; A....</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp; 13:&nbsp; A....</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp; 14:&nbsp; A....</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp; 15:&nbsp; A....</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp; 16:&nbsp; A....</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp; 17:&nbsp; A....</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp; 18:&nbsp; A....</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp; 19:&nbsp; A....</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp; 20:&nbsp; A....</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp; 21:&nbsp; A....</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp; 22:&nbsp; A....</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp; 23:&nbsp; A....</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp; 24:&nbsp; A....</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp; 25:&nbsp; A....</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp; 26:&nbsp; A....</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp; 27:&nbsp; A....</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp; 28:&nbsp; A....</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp; 29:&nbsp; A....</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp; 30:&nbsp; A....</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp; 31:&nbsp; A....</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp; 32:&nbsp; A....</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp; 33:&nbsp; A....</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp; 34:&nbsp; A....</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp; 35:&nbsp; A....</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp; 36:&nbsp; A....</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp; 37:&nbsp; A....</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp; 38:&nbsp; A....</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp; 39:&nbsp; A....</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp; 40:&nbsp; A....</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp; 41:&nbsp; A....</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp; 42:&nbsp; A....</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp; 43:&nbsp; A....</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp; 44:&nbsp; A....</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp; 45:&nbsp; A....</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp; 46:&nbsp; A....</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp; 47:&nbsp; A....</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp; 48:&nbsp; A....</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp; 49:&nbsp; A....</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp; 50:&nbsp; A....</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp; 51:&nbsp; A....</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp; 52:&nbsp; A....</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp; 53:&nbsp; A....</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp; 54:&nbsp; A....</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp; 55:&nbsp; A....</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp; 56:&nbsp; A....</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp; 57:&nbsp; A....</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp; 58:&nbsp; A....</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp; 59:&nbsp; A....</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp; 60:&nbsp; A....</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp; 61:&nbsp; A....</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp; 62:&nbsp; A....</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp; 63:&nbsp; A....</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp; 64:&nbsp; A....</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp; 65:&nbsp; A....</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp; 66:&nbsp; A....</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp; 67:&nbsp; A....</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp; 68:&nbsp; A....</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp; 69:&nbsp; A....</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp; 70:&nbsp; A....</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp; 71:&nbsp; A....</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp; 72:&nbsp; A....</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp; 73:&nbsp; A....</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp; 74:&nbsp; A....</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp; 75:&nbsp; A....</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp; 76:&nbsp; A....</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp; 77:&nbsp; A....</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp; 78:&nbsp; A....</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp; 79:&nbsp; A....</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp; 80:&nbsp; A....</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp; 81:&nbsp; A....</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp; 82:&nbsp; A....</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp; 83:&nbsp; A....</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp; 84:&nbsp; A....</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp; 85:&nbsp; A....</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp; 86:&nbsp; A....</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp; 87:&nbsp; A....</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp; 88:&nbsp; A....</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp; 89:&nbsp; A....</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp; 90:&nbsp; A....</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp; 91:&nbsp; A....</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp; 92:&nbsp; A....</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp; 93:&nbsp; A....</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp; 94:&nbsp; A....</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp; 95:&nbsp; A....</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp; 96:&nbsp; A....</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp; 97:&nbsp; A....</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp; 98:&nbsp; A....</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp; 99:&nbsp; A....</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp;100:&nbsp; A....</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp;101:&nbsp; A....</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp;102:&nbsp; A....</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp;103:&nbsp; A....</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp;104:&nbsp; A....</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp;105:&nbsp; A....</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp;106:&nbsp; A....</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp;107:&nbsp; A....</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp;108:&nbsp; A....</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp;109:&nbsp; A....</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp;110:&nbsp; A....</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp;111:&nbsp; A....</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp;112:&nbsp; A....</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp;113:&nbsp; A....</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp;114:&nbsp; A....</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp;115:&nbsp; A....</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp;116:&nbsp; A....</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp;117:&nbsp; A....</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp;118:&nbsp; A....</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp;119:&nbsp; A....</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp;120:&nbsp; A....</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp;121:&nbsp; A....</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp;122:&nbsp; A....</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp;123:&nbsp; A....</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp;124:&nbsp; A....</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp;125:&nbsp; A....</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp;126:&nbsp; A....</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp;127:&nbsp; A....</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp;128:&nbsp; A....</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp;129:&nbsp; A....</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp;130:&nbsp; A....</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp;131:&nbsp; A....</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp;132:&nbsp; A....</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp;133:&nbsp; A....</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp;134:&nbsp; A....</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp;135:&nbsp; A....</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp;136:&nbsp; A....</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp;137:&nbsp; A....</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp;138:&nbsp; A....</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp;139:&nbsp; A....</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp;140:&nbsp; A....</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp;141:&nbsp; A....</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp;142:&nbsp; A....</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp;143:&nbsp; A....</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp;144:&nbsp; A....</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp;145:&nbsp; A....</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp;146:&nbsp; A....</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp;147:&nbsp; A....</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp;148:&nbsp; A....</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp;149:&nbsp; A....</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp;150:&nbsp; A....</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp;151:&nbsp; A....</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp;152:&nbsp; A....</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp;153:&nbsp; A....</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp;154:&nbsp; A....</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp;155:&nbsp; A....</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp;156:&nbsp; A....</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp;157:&nbsp; A....</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp;158:&nbsp; A....</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp;159:&nbsp; A....</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp;160:&nbsp; G...V</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp;161:&nbsp; G...V</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">[Domain info]</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">id=3D0x00000000</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">priority=3D100</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Courier New">Wed Dec 31 17:24:49 MST =
1969</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">running: cat =
/proc/ipipe/Xenomai</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier =
New">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +----- Handling ([A]ccepted, =
[G]rabbed, [W]ired, [D]iscarded)</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier =
New">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |+---- Sticky</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier =
New">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ||+--- Locked</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier =
New">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |||+-- Exclusive</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier =
New">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ||||+- Virtual</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">[IRQ]&nbsp; |||||</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp; 17:&nbsp; W..X.</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp;162:&nbsp; W...V</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">[Domain info]</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">id=3D0x58454e4f</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">priority=3Dtopmost</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Courier New">Wed Dec 31 17:24:49 MST =
1969</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">running: cat =
/proc/ipipe/version</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">1.6-05</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Courier New">Wed Dec 31 17:24:50 MST =
1969</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">running: generate_loads 1</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">dd workload started, pids 1106 =
stored in /var/lock/xeno-test.997.pids</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Courier New">Wed Dec 31 17:24:50 MST =
1969</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">running: cat =
/proc/interrupts</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier =
New">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
CPU0</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp; =
1:&nbsp;&nbsp;&nbsp;&nbsp; =
142930&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AIC&nbsp; =
atmel_serial</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier =
New">&nbsp;17:&nbsp;&nbsp;&nbsp;&nbsp; =
149025&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AIC&nbsp; =
at91_tick</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier =
New">&nbsp;21:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
2&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AIC&nbsp; eth0</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier =
New">Err:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Courier New">Wed Dec 31 17:24:50 MST =
1969</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">running: cat =
/proc/loadavg</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">2.41 2.24 1.63 4/25 1112</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Courier New">Wed Dec 31 17:24:50 MST =
1969</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">running: cat =
/proc/meminfo</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier =
New">MemTotal:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 62560 kB</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier =
New">MemFree:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 57616 =
kB</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier =
New">Buffers:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; 0 kB</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier =
New">Cached:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
1620 kB</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier =
New">SwapCached:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0 =
kB</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier =
New">Active:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
1980 kB</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier =
New">Inactive:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 440 =
kB</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier =
New">SwapTotal:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; 0 kB</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier =
New">SwapFree:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; 0 kB</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier =
New">Dirty:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; 0 kB</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier =
New">Writeback:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; 0 kB</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier =
New">AnonPages:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 820 =
kB</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier =
New">Mapped:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; 512 kB</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier =
New">Slab:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; 1580 kB</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier =
New">SReclaimable:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 312 kB</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier =
New">SUnreclaim:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1268 kB</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier =
New">PageTables:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 144 kB</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier =
New">NFS_Unstable:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0 kB</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier =
New">Bounce:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; 0 kB</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier =
New">CommitLimit:&nbsp;&nbsp;&nbsp;&nbsp; 31280 kB</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier =
New">Committed_AS:&nbsp;&nbsp;&nbsp;&nbsp; 2832 kB</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">VmallocTotal:&nbsp;&nbsp; 956416 =
kB</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier =
New">VmallocUsed:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 8576 kB</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">VmallocChunk:&nbsp;&nbsp; 940028 =
kB</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Courier New">Wed Dec 31 17:24:50 MST =
1969</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">running: cat =
/proc/xenomai/apc</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier =
New">APC&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
CPU0</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp; =
0:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0&nbsp;&nbsp;&nbsp; (pipe_wakeup)</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp; =
1:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
1271&nbsp;&nbsp;&nbsp; (lostage_handler)</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp; =
2:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
4&nbsp;&nbsp;&nbsp; (registry_export)</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp; =
3:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0&nbsp;&nbsp;&nbsp; (posix_signals_handler)</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Courier New">Wed Dec 31 17:24:50 MST =
1969</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">running: cat =
/proc/xenomai/faults</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier =
New">TRAP&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CPU0</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp; =
0:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0&nbsp;&nbsp;&nbsp; (Data or instruction access)</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp; =
1:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0&nbsp;&nbsp;&nbsp; (Section fault)</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp; =
2:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0&nbsp;&nbsp;&nbsp; (Generic data abort)</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp; =
3:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0&nbsp;&nbsp;&nbsp; (Unknown exception)</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp; =
4:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0&nbsp;&nbsp;&nbsp; (Instruction breakpoint)</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp; =
5:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
1201&nbsp;&nbsp;&nbsp; (Floating point exception)</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp; =
6:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0&nbsp;&nbsp;&nbsp; (VFP Floating point exception)</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp; =
7:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0&nbsp;&nbsp;&nbsp; (Undefined instruction)</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Courier New">Wed Dec 31 17:24:51 MST =
1969</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">running: cat =
/proc/xenomai/hal</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">1.6-05</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Courier New">Wed Dec 31 17:24:51 MST =
1969</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">running: cat =
/proc/xenomai/heap</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier =
New">size=3D130560:used=3D64:pagesz=3D512</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Courier New">Wed Dec 31 17:24:51 MST =
1969</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">running: cat =
/proc/xenomai/irq</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier =
New">IRQ&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CPU0</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier =
New">&nbsp;17:&nbsp;&nbsp;&nbsp;&nbsp; =
6433203&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; [timer]</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier =
New">162:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
2543&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; [virtual]</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Courier New">Wed Dec 31 17:24:51 MST =
1969</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">running: cat =
/proc/xenomai/latency</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">39948</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Courier New">Wed Dec 31 17:24:52 MST =
1969</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">running: cat =
/proc/xenomai/sched</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">CPU&nbsp; PID&nbsp;&nbsp;&nbsp; =
PRI&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PERIOD&nbsp;&nbsp; =
TIMEOUT&nbsp;&nbsp;&nbsp; STAT&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
NAME</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp; 0&nbsp; =
0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
R&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ROOT</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Courier New">Wed Dec 31 17:24:52 MST =
1969</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">running: cat =
/proc/xenomai/timer</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier =
New">status=3Doneshot:setup=3D322:tickval=3D1:jiffies=3D1492095772873</FO=
NT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Courier New">Wed Dec 31 17:24:52 MST =
1969</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">running: cat =
/proc/xenomai/version</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">2.3.1</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Courier New">Wed Dec 31 17:24:52 MST =
1969</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">running: cat =
/proc/xenomai/interfaces/native</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">0</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Courier New">Wed Dec 31 17:24:53 MST =
1969</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">running: cat =
/proc/xenomai/interfaces/posix</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">Mem: 5120K used, 57440K free, 0K =
shrd, 0K buff, 1620K cached</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">Load average: 2.29 2.22 =
1.63</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp; PID =
USER&nbsp;&nbsp;&nbsp;&nbsp; STATUS&nbsp;&nbsp; VSZ&nbsp; PPID %CPU %MEM =
COMMAND</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp;1106 =
root&nbsp;&nbsp;&nbsp;&nbsp; R&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
1392&nbsp;&nbsp;&nbsp;&nbsp; 1 98.0&nbsp; 2.2 dd</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp;1171 =
root&nbsp;&nbsp;&nbsp;&nbsp; R&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
1396&nbsp; 1170&nbsp; 1.9&nbsp; 2.2 top</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp;1023 =
root&nbsp;&nbsp;&nbsp;&nbsp; S&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
1420&nbsp;&nbsp; 997&nbsp; 0.0&nbsp; 2.2 xeno-test</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp;1167 =
root&nbsp;&nbsp;&nbsp;&nbsp; S&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
1420&nbsp; 1023&nbsp; 0.0&nbsp; 2.2 xeno-test</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp;1170 =
root&nbsp;&nbsp;&nbsp;&nbsp; S&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
1420&nbsp; 1167&nbsp; 0.0&nbsp; 2.2 xeno-test</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp; 200 =
root&nbsp;&nbsp;&nbsp;&nbsp; S&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
1416&nbsp;&nbsp;&nbsp;&nbsp; 1&nbsp; 0.0&nbsp; 2.2 sh</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp; 997 =
root&nbsp;&nbsp;&nbsp;&nbsp; S&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
1416&nbsp;&nbsp; 200&nbsp; 0.0&nbsp; 2.2 xeno-test</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Courier New">-- </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">Alexandre BOUIN</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">Adeneo</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">2, chemin du Ruisseau - =
BP21</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">69136 Ecully Cedex</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">France</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">Tel : +33-4 72 18 08 40</FONT>
</P>
<BR>

</BODY>
</HTML>
------_=_NextPart_001_01C78C9D.48C7CCDA--

