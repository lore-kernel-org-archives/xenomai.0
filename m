Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 25 Jun 2009 16:54:11 +0200
Message-ID: <E5CDD68F7A516B4F863D651CDA2DBF71010A9E66@domain.hid>
References: <1245226350.3614.10.camel@domain.hid>
	<4A38AD4D.9090802@domain.hid>
	<E5CDD68F7A516B4F863D651CDA2DBF71010A9E64@domain.hid>
	<4A43820B.2020701@domain.hid>
From: "LEMARCHAND Ludovic" <Ludovic.LEMARCHAND@tech.viveris.com>
Subject: [Xenomai-help] =?iso-8859-1?q?RE=A0=3A_RE_=3A__problem_with_gtk?=
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

Hello

I use Xenomai 2.4.7 with the ipipe patch for 2.6.26 because I should use =
a 2.6.26 Debian kernel.

Ludovic lemarchand


-------- Message d'origine--------
De: Gilles Chanteperdrix [mailto:gilles.chanteperdrix@xenomai.org]
Date: jeu. 25/06/2009 15:56
=C0: LEMARCHAND Ludovic
Cc: xenomai@xenomai.org
Objet : Re: RE : [Xenomai-help] problem with gtk
=20
LEMARCHAND Ludovic wrote:
> Hello
>=20
> I solved the problem of the freeze.
>=20
> I disabled the Symmetric multi-processing support (SMP) and now it =
works with no freeze.
>=20
> Ludovic Lemarchand

That is not normal. Does the SMP kernel freeze with Xenomai 2.4.8 and
the ipipe patch for 2.6.29 it contains ?

If yes, then please try to get the kernel logs and post them on this =
list.

--=20
                                          Gilles



