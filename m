Date: Thu, 10 May 2012 19:38:36 +0200 (CEST)
From: aubin.rebillat@domain.hid
Message-ID: <1019836294.145115940.1336671516044.JavaMail.root@domain.hid>
In-Reply-To: <4FABFACE.7030904@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] Xenomai on the TS-7553 ARM SBC
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

> De: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
> =C3=80: "aubin rebillat" <aubin.rebillat@domain.hid>
> Cc: xenomai@xenomai.org
> Envoy=C3=A9: Jeudi 10 Mai 2012 19:28:46
> Objet: Re: [Xenomai-help] Xenomai on the TS-7553 ARM SBC
>=20
> On 05/10/2012 03:26 PM, aubin.rebillat@domain.hid wrote:
> > Hello,
> >=20
> > I am trying to port Xenomai on the TS-7553 SBC from Technologic
> > systems, based on the ECONA CNS2132 (STAR8132) from Cavium
> > networks (250 MHz arm922t).
> > A Linux kernel is available for this board, version 2.6.24.4, which
> > is running fine.
> > I patched this kernel with adeos-ipipe-2.6.24-arm-1.9-01.patch and
> > I implemented all the IPIPE code for the CNS2132 and everything is
> > compiling and booting fine.
>=20
> Note that the following page:
> http://www.openembedded.org/wiki/TS-7500
>=20
> Proposes patches for linux 2.6.35, which is really, really, really
> more
> current than 2.6.24, and for which an I-pipe patch also exists.
>=20
> I mean, with 2.6.24, you may find bugs we do not even remember,
> because
> they were fixed such a long time ago.
>=20

I preferred to use the version 2.6.24  which is shipped with the board=20
because the manufacturer can provide support in case of trouble.
But, I compiled and tested the version 2.6.35 and it's running fine at=20
first but the dmesg output is corrupted with a lot of "BAD IRQ".
I thought that this version was not really stable yet and I don't have
enough time in my project to ensure it. That's why I preferred to use
the version 2.6.24.

If a bug is happening with our application, I will definitely move
to the most recent one.

Best regards,

--=20
REBILLAT Aubin

