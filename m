Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Apr 2007 16:35:27 +0200
Message-ID: <403B28AE6257B548B66BB88414AC78330174BBCF@STEGOSAURE.adetel.com>
In-Reply-To: <4623820C.6060306@domain.hid>
From: "BOUIN Alexandre" <abouin@domain.hid>
Subject: Re: [Adeos-main] AT91SAM9261 adeos support for 2.6.19 kernel
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: adeos-main <adeos-main@gna.org>

Hi, with Gregory we've worked on Xenomai implementation on =
AT91SAM9261-EK
board.
Here are our latency results :
[run test]
uclibc login: root
# cd /usr/xenomai/bin/
# ./latency -p 500 -h
[histogram]
---|--param|----range-|--samples
HSD|    min|  14 - 15 |        1
HSD|    min|  15 - 16 |        2
HSD|    min|  16 - 17 |        4
HSD|    min|  17 - 18 |       25
HSD|    min|  18 - 19 |        2
HSD|    min|  19 - 20 |        1
HSD|    min|  26 - 27 |        1
---|--param|----range-|--samples
HSD|    avg|  14 - 15 |        1
HSD|    avg|  15 - 16 |        2
HSD|    avg|  16 - 17 |       11
HSD|    avg|  17 - 18 |       47
HSD|    avg|  18 - 19 |       17
HSD|    avg|  19 - 20 |       22
HSD|    avg|  20 - 21 |       37
HSD|    avg|  21 - 22 |       25
HSD|    avg|  22 - 23 |        9
HSD|    avg|  23 - 24 |       43
HSD|    avg|  24 - 25 |        8
HSD|    avg|  25 - 26 |       41
HSD|    avg|  26 - 27 |    23144
HSD|    avg|  27 - 28 |     1084
HSD|    avg|  28 - 29 |       91
HSD|    avg|  29 - 30 |       35
HSD|    avg|  30 - 31 |       24
HSD|    avg|  31 - 32 |       10
HSD|    avg|  32 - 33 |       16
HSD|    avg|  33 - 34 |       22
HSD|    avg|  34 - 35 |       19
HSD|    avg|  35 - 36 |        6
HSD|    avg|  36 - 37 |        7
HSD|    avg|  37 - 38 |        4
HSD|    avg|  38 - 39 |        6
HSD|    avg|  39 - 40 |        1
HSD|    avg|  40 - 41 |       13
HSD|    avg|  41 - 42 |        7
HSD|    avg|  42 - 43 |        1
HSD|    avg|  43 - 44 |       11
HSD|    avg|  44 - 45 |       16
HSD|    avg|  45 - 46 |        3
HSD|    avg|  46 - 47 |        7
HSD|    avg|  47 - 48 |        4
HSD|    avg|  48 - 49 |       11
HSD|    avg|  49 - 50 |        5
HSD|    avg|  50 - 51 |        5
HSD|    avg|  51 - 52 |        7
HSD|    avg|  52 - 53 |        6
HSD|    avg|  53 - 54 |        9
HSD|    avg|  54 - 55 |       53
HSD|    avg|  55 - 56 |       94
HSD|    avg|  56 - 57 |      132
HSD|    avg|  57 - 58 |    11271
HSD|    avg|  58 - 59 |    35072
HSD|    avg|  59 - 60 |      598
HSD|    avg|  60 - 61 |      156
HSD|    avg|  61 - 62 |       52
HSD|    avg|  62 - 63 |       28
HSD|    avg|  63 - 64 |       33
HSD|    avg|  64 - 65 |        7
HSD|    avg|  65 - 66 |        2
HSD|    avg|  66 - 67 |        2
HSD|    avg|  67 - 68 |        7
HSD|    avg|  68 - 69 |        3
HSD|    avg|  69 - 70 |        1
HSD|    avg|  70 - 71 |        1
HSD|    avg|  71 - 72 |        2
HSD|    avg|  72 - 73 |       14
HSD|    avg|  73 - 74 |       31
HSD|    avg|  76 - 77 |        2
HSD|    avg|  79 - 80 |        7
HSD|    avg|  80 - 81 |      153
HSD|    avg|  81 - 82 |       25
---|--param|----range-|--samples
HSD|    max|  61 - 62 |        2
HSD|    max|  62 - 63 |        4
HSD|    max|  63 - 64 |        9
HSD|    max|  64 - 65 |        2
HSD|    max|  65 - 66 |        2
HSD|    max|  66 - 67 |        2
HSD|    max|  67 - 68 |        3
HSD|    max|  68 - 69 |        3
HSD|    max|  69 - 70 |        1
HSD|    max|  70 - 71 |        1
HSD|    max|  71 - 72 |        1
HSD|    max|  73 - 74 |        1
HSD|    max|  80 - 81 |        1
HSD|    max|  81 - 82 |        4
[results]
HSH|--param|--samples-|--average--|---stddev--
HSS|    min|        36|     17.056|      1.756
HSS|    avg|     72583|     47.011|     15.153
HSS|    max|        36|     67.194|      6.242
---|------------|------------|------------|--------|---------------------=
----
RTS|      14.501|      47.532|      81.368|       0|    =
00:00:37/00:00:37

We tried to run the tests under load, but it could be better to run them
again with the same load as you.
Could you say us which load test you launch during Latency tests ?

Thanks

Alexandre Bouin
Adeneo
2, chemin du Ruisseau - BP21
69136 Ecully Cedex
France
Tel : +33-4 72 18 08 40


-----Message d'origine-----
De : adeos-main-bounces@domain.hid [mailto:adeos-main-bounces@domain.hid la
part de Gilles Chanteperdrix
Envoy=E9 : vendredi 13 avril 2007 10:54
=C0 : Jose Pascual
Cc : adeos-main@gna.org
Objet : Re: [Adeos-main] AT91SAM9261 adeos support for 2.6.19 kernel


Jose Pascual wrote:
> Hi Gilles,
>=20
> thank you for your answer,
>=20
> Could you send your benchmark results? (what mherz are your PLLA =
working?
> and your Master Clock?)?

I do not remember the PLLA setting, I know the master clock is set to 46
MHz. The user-space latencies were around 200 us under load, sometimes
even greater than that. I do not remember if I had some debug options
enabled, I will re-run some tests.

--=20
                                                 Gilles Chanteperdrix

_______________________________________________
Adeos-main mailing list
Adeos-main@domain.hid
https://mail.gna.org/listinfo/adeos-main

