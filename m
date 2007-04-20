MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17960.30503.154972.409174@domain.hid>
Date: Fri, 20 Apr 2007 10:17:43 +0200
In-Reply-To: <009301c77da1$124fba10$36ef2e30$@com>
References: <305035a40704100947n5d426f9ahf8608957a2264f2f@domain.hid>
	<078801c77d27$5e7cc420$1b764c60$@com>
	<461E6CFE.7000004@domain.hid>
	<009301c77da1$124fba10$36ef2e30$@com>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Subject: Re: [Adeos-main] AT91SAM9261 adeos support for 2.6.19 kernel
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Jose Pascual <josepascual@domain.hid>
Cc: adeos-main@gna.org

Jose Pascual wrote:
 > Hi Gilles,
 > 
 > thank you for your answer,
 > 
 > Could you send your benchmark results? (what mherz are your PLLA working?
 > and your Master Clock?)?

The clock settings of the CSB637 board I am using, displayed by the
kernel are:
Clocks: CPU 184 MHz, master 46 MHz, main 3.686 MHz

Running a 2.6.20 I-pipe kernel, setting the nucleus latency
(/proc/xenomai/latency) to 70us, I get a worst case latency of 175 us
over 8 hours, under dd if=/dev/zero of=/dev/null load.

Here are the latency histogram results.
---|--param|----range-|--samples
HSD|    min|  10 - 11 |       22
HSD|    min|  11 - 12 |      746
HSD|    min|  12 - 13 |      397
HSD|    min|  13 - 14 |      206
HSD|    min|  15 - 16 |        1
HSD|    min|  20 - 21 |       31
HSD|    min|  21 - 22 |     3524
HSD|    min|  22 - 23 |    18810
HSD|    min|  23 - 24 |     3496
HSD|    min|  24 - 25 |     1135
HSD|    min|  25 - 26 |      429
HSD|    min|  26 - 27 |        1
HSD|    min|  74 - 75 |        1
---|--param|----range-|--samples
HSD|    avg|  10 - 11 |       22
HSD|    avg|  11 - 12 |      746
HSD|    avg|  12 - 13 |      397
HSD|    avg|  13 - 14 |      206
HSD|    avg|  15 - 16 |        1
HSD|    avg|  17 - 18 |        2
HSD|    avg|  18 - 19 |      137
HSD|    avg|  19 - 20 |      116
HSD|    avg|  20 - 21 |       74
HSD|    avg|  21 - 22 |     3525
HSD|    avg|  22 - 23 |    18907
HSD|    avg|  23 - 24 |     4070
HSD|    avg|  24 - 25 |     1686
HSD|    avg|  25 - 26 |     1195
HSD|    avg|  26 - 27 |      326
HSD|    avg|  27 - 28 |      971
HSD|    avg|  28 - 29 |     7377
HSD|    avg|  29 - 30 |    17482
HSD|    avg|  30 - 31 |     1602
HSD|    avg|  31 - 32 |      561
HSD|    avg|  32 - 33 |      261
HSD|    avg|  33 - 34 |      263
HSD|    avg|  34 - 35 |      271
HSD|    avg|  35 - 36 |      115
HSD|    avg|  36 - 37 |       29
HSD|    avg|  55 - 56 |       64
HSD|    avg|  56 - 57 |     1047
HSD|    avg|  57 - 58 |      222
HSD|    avg|  58 - 59 |       37
HSD|    avg|  59 - 60 |        1
HSD|    avg|  63 - 64 |        1
HSD|    avg|  70 - 71 |       10
HSD|    avg|  71 - 72 |      584
HSD|    avg|  72 - 73 |     9495
HSD|    avg|  73 - 74 |    18874
HSD|    avg|  74 - 75 |   122506
HSD|    avg|  75 - 76 |   687030
HSD|    avg|  76 - 77 |   685654
HSD|    avg|  77 - 78 |  1235930
HSD|    avg|  78 - 79 |    97036
HSD|    avg|  79 - 80 |    33766
HSD|    avg|  80 - 81 |     2983
HSD|    avg|  81 - 82 |      496
HSD|    avg|  88 - 89 |        3
HSD|    avg|  89 - 90 |        2
HSD|    avg|  90 - 91 |        9
HSD|    avg|  91 - 92 |       16
HSD|    avg|  92 - 93 |       29
HSD|    avg|  93 - 94 |      144
HSD|    avg|  94 - 95 |      167
HSD|    avg|  95 - 96 |      681
HSD|    avg|  96 - 97 |      906
HSD|    avg|  97 - 98 |    11302
HSD|    avg|  98 - 99 |    13198
HSD|    avg|  99 -100 |    14670
HSD|    avg| 100 -101 |    26229
HSD|    avg| 101 -102 |     7286
HSD|    avg| 102 -103 |    27906
HSD|    avg| 103 -104 |   173187
HSD|    avg| 104 -105 |  1694570
HSD|    avg| 105 -106 |   830944
HSD|    avg| 106 -107 |   613763
HSD|    avg| 107 -108 |    81959
HSD|    avg| 108 -109 |    41967
HSD|    avg| 109 -110 |    45206
HSD|    avg| 110 -111 |    45041
HSD|    avg| 111 -112 |  3748510
HSD|    avg| 112 -113 | 10275799
HSD|    avg| 113 -114 | 21326133
HSD|    avg| 114 -115 |  5278953
HSD|    avg| 115 -116 |  6019472
HSD|    avg| 116 -117 |  1740063
HSD|    avg| 117 -118 |  1281249
HSD|    avg| 118 -119 |   829744
HSD|    avg| 119 -120 |    30357
HSD|    avg| 120 -121 |     3123
HSD|    avg| 121 -122 |      465
HSD|    avg| 122 -123 |     1906
HSD|    avg| 123 -124 |     2173
HSD|    avg| 124 -125 |     3728
HSD|    avg| 125 -126 |     8888
HSD|    avg| 126 -127 |    25723
HSD|    avg| 127 -128 |   120826
HSD|    avg| 128 -129 |    49583
HSD|    avg| 129 -130 |    86632
HSD|    avg| 130 -131 |    33987
HSD|    avg| 131 -132 |    95449
HSD|    avg| 132 -133 |    16782
HSD|    avg| 133 -134 |     5143
HSD|    avg| 134 -135 |     1717
HSD|    avg| 135 -136 |      109
HSD|    avg| 136 -137 |      181
HSD|    avg| 137 -138 |       54
HSD|    avg| 138 -139 |       26
HSD|    avg| 139 -140 |        1
HSD|    avg| 140 -141 |        2
HSD|    avg| 142 -143 |        1
HSD|    avg| 143 -144 |        7
HSD|    avg| 144 -145 |       36
HSD|    avg| 145 -146 |       79
HSD|    avg| 146 -147 |       33
HSD|    avg| 147 -148 |       84
HSD|    avg| 148 -149 |        9
HSD|    avg| 149 -150 |        3
HSD|    avg| 150 -151 |        2
HSD|    avg| 152 -153 |        8
HSD|    avg| 153 -154 |        5
HSD|    avg| 154 -155 |       60
HSD|    avg| 155 -156 |       86
HSD|    avg| 156 -157 |      469
HSD|    avg| 157 -158 |      339
HSD|    avg| 158 -159 |      566
HSD|    avg| 159 -160 |     1962
HSD|    avg| 160 -161 |     1441
HSD|    avg| 161 -162 |     4948
HSD|    avg| 162 -163 |     2681
HSD|    avg| 163 -164 |     3713
HSD|    avg| 164 -165 |     1345
HSD|    avg| 165 -166 |     3059
HSD|    avg| 166 -167 |     1758
HSD|    avg| 167 -168 |     2036
HSD|    avg| 168 -169 |     2543
HSD|    avg| 169 -170 |      286
HSD|    avg| 170 -171 |      112
HSD|    avg| 171 -172 |        6
HSD|    avg| 172 -173 |        1
HSD|    avg| 174 -175 |        1
---|--param|----range-|--samples
HSD|    max| 122 -123 |        1
HSD|    max| 131 -132 |      243
HSD|    max| 132 -133 |      423
HSD|    max| 133 -134 |      320
HSD|    max| 134 -135 |      118
HSD|    max| 135 -136 |        4
HSD|    max| 136 -137 |       10
HSD|    max| 137 -138 |        3
HSD|    max| 138 -139 |        2
HSD|    max| 143 -144 |        6
HSD|    max| 144 -145 |       36
HSD|    max| 145 -146 |       78
HSD|    max| 146 -147 |       33
HSD|    max| 147 -148 |       84
HSD|    max| 148 -149 |        9
HSD|    max| 149 -150 |        3
HSD|    max| 150 -151 |        2
HSD|    max| 152 -153 |        8
HSD|    max| 153 -154 |        5
HSD|    max| 154 -155 |       60
HSD|    max| 155 -156 |       86
HSD|    max| 156 -157 |      469
HSD|    max| 157 -158 |      339
HSD|    max| 158 -159 |      566
HSD|    max| 159 -160 |     1962
HSD|    max| 160 -161 |     1441
HSD|    max| 161 -162 |     4948
HSD|    max| 162 -163 |     2681
HSD|    max| 163 -164 |     3713
HSD|    max| 164 -165 |     1345
HSD|    max| 165 -166 |     3059
HSD|    max| 166 -167 |     1758
HSD|    max| 167 -168 |     2035
HSD|    max| 168 -169 |     2543
HSD|    max| 169 -170 |      286
HSD|    max| 170 -171 |      112
HSD|    max| 171 -172 |        6
HSD|    max| 172 -173 |        1
HSD|    max| 174 -175 |        1
HSH|--param|--samples-|--average--|---stddev--
HSS|    min|     28799|     21.626|      2.387
HSS|    avg|  57599720|     36.359|     75.112
HSS|    max|     28799|    161.719|      6.860
---|------------|------------|------------|--------|-------------------------
RTS|      10.416|     111.111|     174.305|       0|    08:00:02/08:00:00         
-- 


					    Gilles Chanteperdrix.

