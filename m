content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [Xenomai-core] Testing the adeos-ipipe-2.6.13-ppc-1.0-00.patch
Date: Wed, 19 Oct 2005 15:54:04 +0200
Message-ID: <1CFEB358338412458B21FAA0D78FE86D4F0E32@domain.hid>
From: "Fillod Stephane" <stephane.fillod@domain.hid>
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

Philippe Gerum wrote:
[..]
>The last significant change between -00 and -01 is actually the one =
related to=20
>the fork pressure (others are cosmetic ones aimed at better sharing =
stuff with=20
>the blackfin port). The patch below against -02 removes it.

Here is the result of tests with version 1.0-02+ (entry.S patch) on =
e500:
=20
load: ~1 minute ping -f, one run of calibrator chewing 64MiB.

SWITCH without load:
RTH|     lat min|     lat avg|     lat max|        lost
RTD|        3660|        3690|        8070|           0    1.0-00
RTD|        4620|        4740|        8730|           0    1.0-01
RTD|        4620|        4740|        8190|           0    1.0-02
RTD|        4650|        4740|        7980|           0    1.0-02+

KLATENCY with load:
RTH|-----lat min|-----lat avg|-----lat max|-overrun|
RTS|       -7350|       -5715|        6420|       0|    00:03:17 1.0-00
RTS|       -6150|       -4384|       12180|       0|    00:03:13 1.0-01
RTS|       -6150|       -4183|       12480|       0|    00:03:38 1.0-02
RTS|       -6120|       -4447|        8370|       0|    00:03:47 1.0-02+

LATENCY with load:
=3D=3D Sampling period: 100 us
RTH|-----lat min|-----lat avg|-----lat max|-overrun|
RTS|       -6930|       -4260|        8700|       0|    00:08:06 1.0-00
RTS|       -5670|       -4620|       12930|       0|    00:12:39 1.0-01
RTS|       -5700|       -3750|       11280|       0|    00:06:05 1.0-02
RTS|       -5640|       -2250|       11310|       0|    00:10:31 1.0-02+

Load is still generated manually, so the pattern may vary: lat avg
is not meaningful. The amplitude would be a much more interesting value.
Anyway, are the generated load comparable?

The klatency is in better shape, however the latency test did not =
improve.
The 1.0-00 patch should be rerun as a double check.
I'm afraid we're already entering performance fine tuning, while we have
IMO other higher priority tasks for now. At least, I do :-(

--=20
St=E9phane


