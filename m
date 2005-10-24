content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 24 Oct 2005 19:28:50 +0200
Message-ID: <1CFEB358338412458B21FAA0D78FE86D4F0E3F@rennsmail02.eu.thmulti.com>
From: "Fillod Stephane" <stephane.fillod@domain.hid>
Subject: [Xenomai-core] problem and solution with
	adeos-ipipe-2.6.13-ppc-1.0-03.patch
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

Hi,

The adeos-ipipe-2.6.13-ppc-1.0-03.patch file in Xenomai-2.0 dist appears
to be broken. The unified diff format is wrong on
include/asm-ppc/ipipe.h,
which breaks include/asm-ppc/mmu_context.h. I've found the problem while

applying the patch on a Linux 2.6.13 kernel.
Line 1664 (no pun :), instead of @@ -0,1 +1,178 @@, the following solves
the problem here: @@ -0,0 +1,177 @@

Does somebody else encountered the problem?


For the record, here is for 2.6.13-ppc-1.0-03 the result of klatency,=20
with only calibrator as a load generator.

KLATENCY with load:
RTH|-----lat min|-----lat avg|-----lat max|-overrun|
RTS|       -7350|       -5715|        6420|       0|    00:03:17 1.0-00
RTS|       -6150|       -4384|       12180|       0|    00:03:13 1.0-01
RTS|       -6150|       -4183|       12480|       0|    00:03:38 1.0-02
RTS|       -6120|       -4447|        8370|       0|    00:03:47 1.0-02+
RTS|       -6210|       -5381|       12390|       0|    00:03:38 1.0-03

--=20
Stephane

PS: kudos for the 2.0 release!


