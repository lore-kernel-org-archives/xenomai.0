Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Date: Sat, 10 Jun 2006 16:54:36 +0200
Message-ID: <FDBBB5CC70676540B3EF7CFE83FD94E04F54FE@EINT11.einet.ad.eivd.ch>
References: <FDBBB5CC70676540B3EF7CFE83FD94E04A474F@EINT11.einet.ad.eivd.ch>
	<448419A4.8080102@domain.hid>
From: "ROSSIER Daniel" <Daniel.Rossier@domain.hid>
Subject: [Xenomai-core] RE : New patch for Freescale i.MX21 (csb535fs)
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


Hi Philippe,

We have performed some test with the patch and everything is OK.

We got the same latencies than before; we're now investigating what is
the cause of some occasional peaks to 40-50 us.

Daniel


-------- Message d'origine--------
De: Philippe Gerum [mailto:rpm@xenomai.org]
Date: lun. 05.06.2006 13:46
=C0: ROSSIER Daniel
Cc: xenomai@xenomai.org
Objet : Re: New patch for Freescale i.MX21 (csb535fs)
=20

Hi,

Here is a candidate Adeos patch for the imx21 board. It applies on top=20
of 2.6.14 + generic IMX21 patch + vanilla Adeos 2.6.14-1.3-04 patch.

Since I don't have this hw at hand, It would be nice that you try this=20
patch on your board when time allows and let me know if everything works =

as expected. TIA,

--=20

Philippe.


