Message-ID: <1146.193.52.24.125.1129357068.squirrel@domain.hid>
Date: Sat, 15 Oct 2005 08:17:48 +0200 (CEST)
From: <smannori@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Subject: [Xenomai-help] XenoPPC : Latency test results
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

Hi:

if I run the latency test and I contunue to use the PPC as usual, after a
while, I noticed some overruns (see report below).

Question: it is a serious problems or a normal behavior ?

                Simone

"Il mattino ha l'oro in bocca"
--------------------------------------------------------------------------

..................
RTT|  00:19:58
RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat worst
RTD|      -13400|      -12532|        7486|       5|      -13400|      152777
RTD|      -13346|      -12532|        9602|       5|      -13400|      152777
RTD|      -13346|      -12532|        4340|       5|      -13400|      152777
RTD|      -13400|      -12532|       -1627|       5|      -13400|      152777
RTD|      -13346|      -12044|        4231|       5|      -13400|      152777
RTD|      -13400|      -12369|       -3580|       5|      -13400|      152777
RTD|      -13346|      -12478|        2495|       5|      -13400|      152777
RTD|      -13292|      -12532|        6130|       5|      -13400|      152777
RTD|      -13346|      -12478|       10362|       5|      -13400|      152777
RTD|      -13400|      -12478|       -6239|       5|      -13400|      152777
---|--param|----range-|--samples
HSD|    min|  12 - 13 |       71
HSD|    min|  13 - 14 |     1136
---|--param|----range-|--samples
HSD|    avg|   0 -  1 |      538
HSD|    avg|   1 -  2 |      515
HSD|    avg|   2 -  3 |      458
HSD|    avg|   3 -  4 |      498
HSD|    avg|   4 -  5 |      563
HSD|    avg|   5 -  6 |      773
HSD|    avg|   6 -  7 |     2092
HSD|    avg|   7 -  8 |     7197
HSD|    avg|   8 -  9 |    51929
HSD|    avg|   9 - 10 |   306348
HSD|    avg|  10 - 11 |   552698
HSD|    avg|  11 - 12 |   583088
HSD|    avg|  12 - 13 | 10567490
HSD|    avg|  13 - 14 |     4511
HSD|    avg|  14 - 15 |       31
HSD|    avg|  15 - 16 |       31
HSD|    avg|  16 - 17 |       21
HSD|    avg|  17 - 18 |       34
HSD|    avg|  18 - 19 |       12
HSD|    avg|  19 - 20 |        5
HSD|    avg|  20 - 21 |        4
HSD|    avg|  21 - 22 |        1
HSD|    avg|  23 - 24 |        2
HSD|    avg|  25 - 26 |        1
HSD|    avg|  26 - 27 |        1
HSD|    avg|  29 - 30 |        2
HSD|    avg|  36 - 37 |        1
HSD|    avg|  39 - 40 |        1
HSD|    avg|  43 - 44 |        1
HSD|    avg|  51 - 52 |        1
HSD|    avg|  55 - 56 |        1
HSD|    avg|  56 - 57 |        1
HSD|    avg|  60 - 61 |        1
HSD|    avg|  65 - 66 |        1
HSD|    avg|  70 - 71 |        1
HSD|    avg|  74 - 75 |        1
HSD|    avg|  91 - 92 |        1
HSD|    avg|  96 - 97 |        1
HSD|    avg|  99 -100 |        2
---|--param|----range-|--samples
HSD|    max|   0 -  1 |      133
HSD|    max|   1 -  2 |      126
HSD|    max|   2 -  3 |      110
HSD|    max|   3 -  4 |      112
HSD|    max|   4 -  5 |       99
HSD|    max|   5 -  6 |       95
HSD|    max|   6 -  7 |       88
HSD|    max|   7 -  8 |       62
HSD|    max|   8 -  9 |       56
HSD|    max|   9 - 10 |       45
HSD|    max|  10 - 11 |       50
HSD|    max|  11 - 12 |       27
HSD|    max|  12 - 13 |       43
HSD|    max|  13 - 14 |       22
HSD|    max|  14 - 15 |       30
HSD|    max|  15 - 16 |       29
HSD|    max|  16 - 17 |       20
HSD|    max|  17 - 18 |       34
HSD|    max|  18 - 19 |       12
HSD|    max|  19 - 20 |        3
HSD|    max|  20 - 21 |        3
HSD|    max|  23 - 24 |        1
HSD|    max|  25 - 26 |        1
HSD|    max|  60 - 61 |        1
HSD|    max|  65 - 66 |        1
HSD|    max|  91 - 92 |        1
HSD|    max|  96 - 97 |        1
HSD|    max|  99 -100 |        2
HSH|--param|--samples-|--average--|---stddev--
HSS|    min|      1207|     12.941|      0.235
HSS|    avg|  12078857|     11.761|      0.722
HSS|    max|      1207|      6.306|      7.550
---|------------|------------|------------|--------|-------------------------
RTS|      -13400|      -12369|      152777|       5|    00:20:08/00:20:08
[root@domain.hid latency]#

Question: it is a serious problems or a normal behavior ?



