Message-ID: <305035a40710091019n77e1a453gd0d349dc1eebc15d@domain.hid>
Date: Tue, 9 Oct 2007 19:19:55 +0200
From: "Gregory CLEMENT" <gclement00@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Subject: [Xenomai-core] RTAI and Xenomai latency in kernel mode on
	AT91SAM9261-EK
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

Here, they are the last latency we get on AT91SAM9261-EK. As just now
I haven't the board at home, I send the last result we stored. The
prority of dbgu should be set to 6 instead of 7, but I can't assure
it, for Xenomai.
first Xenomai:

#insmod /lib/modules/2.6.20.13/kernel/drivers/xenomai/testing/xeno_timerben=
ch.ko
#cd /usr/xenomai/bin/
#./latency -t 2 -p 150 -h -H 500
---|--param|----range-|--samples
HSD|    min|   3 -  4 |        6
HSD|    min|   4 -  5 |       12
HSD|    min|   5 -  6 |        5
HSD|    min|   6 -  7 |      128
HSD|    min|   7 -  8 |      405
HSD|    min|   8 -  9 |       18
---|--param|----range-|--samples
HSD|    avg|   3 -  4 |        6
HSD|    avg|   4 -  5 |       12
HSD|    avg|   5 -  6 |        5
HSD|    avg|   6 -  7 |     1248
HSD|    avg|   7 -  8 |  1159824
HSD|    avg|   8 -  9 |  1188725
HSD|    avg|   9 - 10 |   238045
HSD|    avg|  10 - 11 |    78398
HSD|    avg|  11 - 12 |   134973
HSD|    avg|  12 - 13 |   132552
HSD|    avg|  13 - 14 |   129661
HSD|    avg|  14 - 15 |   137458
HSD|    avg|  15 - 16 |    49208
HSD|    avg|  16 - 17 |     4532
HSD|    avg|  17 - 18 |     2793
HSD|    avg|  18 - 19 |     2494
HSD|    avg|  19 - 20 |     2489
HSD|    avg|  20 - 21 |     2373
HSD|    avg|  21 - 22 |     3677
HSD|    avg|  22 - 23 |    15370
HSD|    avg|  23 - 24 |   173411
HSD|    avg|  24 - 25 |   181883
HSD|    avg|  25 - 26 |     1509
HSD|    avg|  26 - 27 |     5058
HSD|    avg|  27 - 28 |     9483
HSD|    avg|  28 - 29 |    19691
HSD|    avg|  29 - 30 |    18397
HSD|    avg|  30 - 31 |    24228
HSD|    avg|  31 - 32 |    19539
HSD|    avg|  32 - 33 |    20438
HSD|    avg|  33 - 34 |    17420
HSD|    avg|  34 - 35 |    19943
HSD|    avg|  35 - 36 |    15057
HSD|    avg|  36 - 37 |    12100
HSD|    avg|  37 - 38 |     1873
HSD|    avg|  38 - 39 |      417
HSD|    avg|  39 - 40 |      347
HSD|    avg|  40 - 41 |      282
HSD|    avg|  41 - 42 |      177
HSD|    avg|  42 - 43 |      106
HSD|    avg|  43 - 44 |      108
HSD|    avg|  44 - 45 |       94
HSD|    avg|  45 - 46 |      138
HSD|    avg|  46 - 47 |      114
HSD|    avg|  47 - 48 |      109
HSD|    avg|  48 - 49 |       50
HSD|    avg|  49 - 50 |       35
HSD|    avg|  50 - 51 |       40
HSD|    avg|  51 - 52 |       32
HSD|    avg|  52 - 53 |       23
HSD|    avg|  53 - 54 |       21
HSD|    avg|  54 - 55 |       13
HSD|    avg|  55 - 56 |       12
HSD|    avg|  56 - 57 |       13
HSD|    avg|  57 - 58 |       15
HSD|    avg|  58 - 59 |       24
HSD|    avg|  59 - 60 |       13
HSD|    avg|  60 - 61 |       22
HSD|    avg|  61 - 62 |       29
HSD|    avg|  62 - 63 |       13
HSD|    avg|  63 - 64 |        7
HSD|    avg|  64 - 65 |        8
HSD|    avg|  65 - 66 |       13
HSD|    avg|  66 - 67 |        8
HSD|    avg|  67 - 68 |        7
HSD|    avg|  68 - 69 |        5
HSD|    avg|  69 - 70 |        8
HSD|    avg|  70 - 71 |        4
HSD|    avg|  71 - 72 |        9
HSD|    avg|  72 - 73 |        8
HSD|    avg|  73 - 74 |       13
HSD|    avg|  74 - 75 |        9
HSD|    avg|  75 - 76 |        6
HSD|    avg|  76 - 77 |        4
HSD|    avg|  77 - 78 |        5
HSD|    avg|  78 - 79 |       11
HSD|    avg|  79 - 80 |        1
HSD|    avg|  80 - 81 |        2
HSD|    avg|  81 - 82 |        1
HSD|    avg|  82 - 83 |        4
HSD|    avg|  83 - 84 |        4
HSD|    avg|  84 - 85 |        6
HSD|    avg|  85 - 86 |        5
HSD|    avg|  86 - 87 |        1
HSD|    avg|  87 - 88 |        3
HSD|    avg|  88 - 89 |        2
HSD|    avg|  89 - 90 |        2
HSD|    avg|  90 - 91 |        1
HSD|    avg|  92 - 93 |        2
HSD|    avg|  93 - 94 |        1
HSD|    avg|  94 - 95 |        1
HSD|    avg|  95 - 96 |        1
HSD|    avg|  96 - 97 |        1
HSD|    avg|  99 -100 |        1
HSD|    avg| 110 -111 |        1
---|--param|----range-|--samples
HSD|    max|  25 - 26 |        2
HSD|    max|  26 - 27 |        1
HSD|    max|  27 - 28 |        1
HSD|    max|  29 - 30 |        4
HSD|    max|  30 - 31 |        4
HSD|    max|  31 - 32 |        7
HSD|    max|  32 - 33 |       18
HSD|    max|  33 - 34 |       18
HSD|    max|  34 - 35 |       36
HSD|    max|  35 - 36 |       59
HSD|    max|  36 - 37 |       72
HSD|    max|  37 - 38 |       42
HSD|    max|  38 - 39 |       40
HSD|    max|  39 - 40 |       20
HSD|    max|  40 - 41 |       26
HSD|    max|  41 - 42 |       27
HSD|    max|  42 - 43 |       25
HSD|    max|  43 - 44 |       18
HSD|    max|  44 - 45 |       16
HSD|    max|  45 - 46 |        8
HSD|    max|  46 - 47 |        3
HSD|    max|  47 - 48 |        3
HSD|    max|  48 - 49 |        8
HSD|    max|  49 - 50 |        2
HSD|    max|  50 - 51 |        5
HSD|    max|  51 - 52 |        4
HSD|    max|  52 - 53 |        3
HSD|    max|  53 - 54 |        2
HSD|    max|  54 - 55 |        2
HSD|    max|  55 - 56 |        2
HSD|    max|  56 - 57 |        3
HSD|    max|  57 - 58 |        4
HSD|    max|  58 - 59 |        7
HSD|    max|  59 - 60 |        4
HSD|    max|  60 - 61 |        1
HSD|    max|  61 - 62 |        4
HSD|    max|  62 - 63 |        4
HSD|    max|  69 - 70 |        2
HSD|    max|  70 - 71 |        1
HSD|    max|  71 - 72 |        3
HSD|    max|  72 - 73 |        3
HSD|    max|  73 - 74 |        3
HSD|    max|  74 - 75 |        5
HSD|    max|  75 - 76 |        4
HSD|    max|  76 - 77 |        1
HSD|    max|  77 - 78 |        2
HSD|    max|  78 - 79 |        7
HSD|    max|  80 - 81 |        2
HSD|    max|  81 - 82 |        1
HSD|    max|  82 - 83 |        4
HSD|    max|  83 - 84 |        4
HSD|    max|  84 - 85 |        6
HSD|    max|  85 - 86 |        5
HSD|    max|  86 - 87 |        1
HSD|    max|  87 - 88 |        3
HSD|    max|  88 - 89 |        2
HSD|    max|  89 - 90 |        2
HSD|    max|  90 - 91 |        1
HSD|    max|  92 - 93 |        2
HSD|    max|  93 - 94 |        1
HSD|    max|  94 - 95 |        1
HSD|    max|  95 - 96 |        1
HSD|    max|  96 - 97 |        1
HSD|    max|  99 -100 |        1
HSH|--param|--samples-|--average--|---stddev--
HSS|    min|       574|      6.686|      0.740
HSS|    avg|   3826285|     11.213|      6.706
HSS|    max|       574|     44.190|     15.169
---|------------|------------|------------|--------|-----------------------=
--
RTS|       3.480|      11.779|      99.163|       0|    14:23:01/14:23:01

It was run under calibrator load during more than 14 hours.

Now RTAI:

Oneshot timer with 500=B5s period,  LATENCY =3D6000ns and SETUPTIME 1500
 duration : 17h

1970/01/1 22:34:51
RTH|    lat min|    ovl min|    lat avg|    lat max|    ovl max|   overruns
RTD|       3221|       2577|       4997|      26095|      53801|          0
RTD|       3221|       2577|       5163|      25451|      53801|          0
RTD|       3221|       2577|       5159|      25128|      53801|          0
RTD|       3221|       2577|       4799|      23518|      53801|          0
RTD|       3221|       2577|       4828|      25128|      53801|          0
RTD|       3221|       2577|       5089|      23518|      53801|          0
RTD|       3221|       2577|       4580|      23840|      53801|          0
RTD|       3221|       2577|       4924|      25128|      53801|          0
RTD|       3221|       2577|       4740|      24806|      53801|          0
RTD|       3221|       2577|       4251|      25128|      53801|          0

counts | latency
    144 2
15830672 3
31593380 4
15873143 5
9913892 6
5682938 7
3193742 8
2095821 9
2173270 10
2856232 11
3693369 12
3430282 13
3359902 14
2784427 15
 809859 16
 322901 17
 224317 18
 208420 19
 411250 20
4054145 21
8386174 22
 514707 23
 261560 24
 223286 25
 187926 26
 171329 27
 233480 28
 116408 29
  47277 30
 812908 31
2751429 32
  38513 33
   5668 34
   2386 35
   2249 36
   1555 37
   1130 38
    416 39
    217 40
    148 41
    134 42
    183 43
    118 44
    167 45
    227 46
    151 47
     95 48
     26 49
      8 50
      6 51
      7 52
      6 53



--=20
Gregory CLEMENT
Adeneo
Adetel Group
2, chemin du Ruisseau
69134 ECULLY - FRANCE
France
T=E9l. : +33 (0)4 72 18 08 40 - Fax : +33 (0)4 72 18 08 41

www.adetelgroup.com

