Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Apr 2007 17:21:17 +0200
Message-ID: <403B28AE6257B548B66BB88414AC78330174BBD9@domain.hid>
In-Reply-To: <403B28AE6257B548B66BB88414AC78330174BBD8@domain.hid>
From: "BOUIN Alexandre" <abouin@domain.hid>
Subject: Re: [Adeos-main] New patch for AT91SAM9261 adeos support for 2.6.19
	kernel
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: adeos-main@gna.org

The clock settings of the AT91SAM9261-EK board I am using, displayed by =
the
kernel are:
Clocks: Clocks: CPU 198 MHz, master 99 MHz, main 18.432 MHz

Running a 2.6.19 I-pipe kernel, setting the nucleus latency
(/proc/xenomai/latency) to 323us, I get a worst case latency of 231 us
over 6 hours, under dd if=3D/dev/zero of=3D/dev/null load.

Histogramm has been shortened.
Next time I will add the parameter "-H 500" to increase histogramm size.

Here are the latency histogram results.
---|--param|----range-|--samples
HSD|    min|  34 - 35 |        1
HSD|    min|  35 - 36 |        4
HSD|    min|  36 - 37 |        8
HSD|    min|  37 - 38 |       13
HSD|    min|  38 - 39 |       34
HSD|    min|  39 - 40 |       27
HSD|    min|  40 - 41 |       40
HSD|    min|  41 - 42 |       57
HSD|    min|  42 - 43 |       87
HSD|    min|  43 - 44 |      168
HSD|    min|  44 - 45 |      594
HSD|    min|  45 - 46 |     2808
HSD|    min|  46 - 47 |     7334
HSD|    min|  47 - 48 |     7966
HSD|    min|  48 - 49 |     3047
HSD|    min|  49 - 50 |      125
HSD|    min|  50 - 51 |        5
HSD|    min|  73 - 74 |        1
---|--param|----range-|--samples
HSD|    avg|  34 - 35 |        1
HSD|    avg|  35 - 36 |        4
HSD|    avg|  36 - 37 |        8
HSD|    avg|  37 - 38 |       13
HSD|    avg|  38 - 39 |       34
HSD|    avg|  39 - 40 |       27
HSD|    avg|  40 - 41 |       40
HSD|    avg|  41 - 42 |       57
HSD|    avg|  42 - 43 |       87
HSD|    avg|  43 - 44 |      168
HSD|    avg|  44 - 45 |      608
HSD|    avg|  45 - 46 |     3032
HSD|    avg|  46 - 47 |     9985
HSD|    avg|  47 - 48 |    20644
HSD|    avg|  48 - 49 |    38564
HSD|    avg|  49 - 50 |    38041
HSD|    avg|  50 - 51 |    41848
HSD|    avg|  51 - 52 |    36631
HSD|    avg|  52 - 53 |    34410
HSD|    avg|  53 - 54 |    37510
HSD|    avg|  54 - 55 |    40837
HSD|    avg|  55 - 56 |    38238
HSD|    avg|  56 - 57 |    30134
HSD|    avg|  57 - 58 |    27623
HSD|    avg|  58 - 59 |    11770
HSD|    avg|  59 - 60 |     6833
HSD|    avg|  60 - 61 |     4652
HSD|    avg|  61 - 62 |     3958
HSD|    avg|  62 - 63 |     3773
HSD|    avg|  63 - 64 |     3456
HSD|    avg|  64 - 65 |     3048
HSD|    avg|  65 - 66 |     2725
HSD|    avg|  66 - 67 |     2462
HSD|    avg|  67 - 68 |     3107
HSD|    avg|  68 - 69 |     2961
HSD|    avg|  69 - 70 |     7184
HSD|    avg|  70 - 71 |     8252
HSD|    avg|  71 - 72 |     8291
HSD|    avg|  72 - 73 |     6977
HSD|    avg|  73 - 74 |    37251
HSD|    avg|  74 - 75 |    64192
HSD|    avg|  75 - 76 |    11019
HSD|    avg|  76 - 77 |    21165
HSD|    avg|  77 - 78 |    43915
HSD|    avg|  78 - 79 |    70855
HSD|    avg|  79 - 80 |   129983
HSD|    avg|  80 - 81 |   280648
HSD|    avg|  81 - 82 |   388961
HSD|    avg|  82 - 83 |   287156
HSD|    avg|  83 - 84 |   133873
HSD|    avg|  84 - 85 |    52948
HSD|    avg|  85 - 86 |  1175229
HSD|    avg|  86 - 87 | 43142254
HSD|    avg|  87 - 88 | 19364608
HSD|    avg|  88 - 89 |  2609775
HSD|    avg|  89 - 90 |    57806
HSD|    avg|  90 - 91 |    14457
HSD|    avg|  91 - 92 |    20810
HSD|    avg|  92 - 93 |    30672
HSD|    avg|  93 - 94 |     8841
HSD|    avg|  94 - 95 |     1762
HSD|    avg|  95 - 96 |     1896
HSD|    avg|  96 - 97 |    34505
HSD|    avg|  97 - 98 |    38357
HSD|    avg|  98 - 99 |    19627
HSD|    avg|  99 -100 |   558554
---|--param|----range-|--samples
HSD|    max|  99 -100 |    22319

HSH|--param|--samples-|--average--|---stddev--
HSS|    min|     22319|     46.376|      1.268
HSS|    avg|  69079112|     23.945|     62.257
HSS|    max|     22319|     99.000|      0.000
---|------------|------------|------------|--------|---------------------=
----
RTS|      34.793|      86.662|     230.992|       0|    =
06:11:40/06:11:40


--=20
Alexandre BOUIN
Adeneo
2, chemin du Ruisseau - BP21
69136 Ecully Cedex
France
Tel : +33-4 72 18 08 40

