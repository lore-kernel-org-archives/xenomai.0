Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 25 Jun 2009 15:35:34 +0200
Message-ID: <E5CDD68F7A516B4F863D651CDA2DBF71010A9E64@domain.hid>
References: <1245226350.3614.10.camel@domain.hid>
	<4A38AD4D.9090802@domain.hid>
From: "LEMARCHAND Ludovic" <Ludovic.LEMARCHAND@tech.viveris.com>
Subject: [Xenomai-help] =?iso-8859-1?q?RE=A0=3A__problem_with_gtk?=
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>, xenomai@xenomai.org

Hello

I solved the problem of the freeze.

I disabled the Symmetric multi-processing support (SMP) and now it works =
with no freeze.

Ludovic Lemarchand


-------- Message d'origine--------
De: Gilles Chanteperdrix [mailto:gilles.chanteperdrix@xenomai.org]
Date: mer. 17/06/2009 10:46
=C0: LEMARCHAND Ludovic
Cc: xenomai@xenomai.org
Objet : Re: [Xenomai-help] problem with gtk
=20
Ludovic Lemarchand wrote:
> Hello
>=20
> I have patched a debian kernel 2.6.26 with Xenomai 2.4.7.
>=20
> When I use Xenomai with gnome environment my computer freeze.
>=20
> So, I have install kde. Its works perfectly but when I use a gtk
> software like firefox or eclipse, my computer freeze too.
>=20
> I don't understand why Xenomai is not compatible with gtk.
>=20
>=20
> I thank you for any response and suggestions.

Could you try Xenomai 2.4.8 with the included patch for Linux 2.6.29 ?

--=20
                                          Gilles



