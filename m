Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [Xenomai-help] Xenomai on PPC
Date: Tue, 4 Apr 2006 17:26:56 +0200
Message-ID: <1CFEB358338412458B21FAA0D78FE86D042A2FF0@domain.hid>
From: "Fillod Stephane" <stephane.fillod@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "Behre, Frederik - LT" <Behre.Frederik@domain.hid>, xenomai@xenomai.org

Behre, Frederik - LT wrote:
[...]
>cd linuxppc_2_4_devel-2005-10-25-1440=20
>make ARCH=3Dppc CROSS_COMPILE=3Dppc_82xx- PM825config=20
                                ^
>/bin/sh: ppc-82xx-gcc: command not found=20
             ^
Are you sure this is what you entered?

>make: *** No rule to make target `PM825config'.=A0 Stop.=20

Have you double checked this defconfig file does exist in =
arch/ppc/configs/ ?

--=20
Stephane

PS: please post to the list as bare text, and not HTML.


