From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <CA2340EB86378E43976ECBA4001310CA04415280@domain.hid>
References: <CA2340EB86378E43976ECBA4001310CA04415280@domain.hid>
Content-Type: text/plain; charset="iso-8859-1"
Date: Wed, 18 Jul 2007 21:44:52 +0200
Message-Id: <1184787892.13258.101.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-help]
	=?iso-8859-1?q?LINUX_and_XENOMAI_versions_compatib?=
	=?iso-8859-1?q?ility_-_compatibilit=E9_des_versions_de_LINUX_et_de?=
	=?iso-8859-1?q?_XENOMAI?=
Reply-To: rpm@xenomai.org
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: charles.biron@domain.hid
Cc: xenomai@xenomai.org

On Wed, 2007-07-18 at 13:43 +0200, charles.biron@domain.hid wrote:
> > I am working on a SBC8347 board produced by WinRiver on which is runnin=
g a LINUX 2.6.10 kernel patched specially for this board with a WindRiver p=
atch. I'd like to affix XENOMAI but I have difficulties to choose XENOMAI a=
nd ADEOS patch versions.
> >=20
> > In fact, I noticed two families of ADEOS patches : the adeos-linux patc=
hes and the adeos-ipipe patches.The adeos-ipipe family seems to works with =
2.6.13 LINUX versions and newers.
> >=20

The only series to consider is the I-pipe one. The other is more than
obsolete by now, much harder to backport, much less reliable, and is not
even supported on recent Xenomai versions.

> > However, I have difficulties to upgrade LINUX to those versions due to =
the WindRiver patch only applicable on the 2.6.10 LINUX version.
> >=20
> > - Could you confirm my analysis of XENOMAI versions and explain me the =
mains diff=E9rences betwenn these two families ?
> > - Could you help me choose the XENOMAI and ADEOS patch versions ?
> >

There is none that immediately fits your configuration. You should
backport I-pipe/2.6.14-1.5-03 to your WRS kernel. What I can tell you
for sure is that it would work, but there is no shrink-wrapped solution
to this issue.

http://download.gna.org/adeos/patches/v2.6/ppc/older/adeos-ipipe-2.6.14-ppc=
-1.5-03.patch

> =20
> > Best regards,
> > Charles BIRON
> >=20
> > -----------------------------------------------------------------------=
------------------------------------------------------------------------
> >=20
> > Je travaille sur une carte SBC8347 de WindRiver sur laquelle tourne un =
noyau LINUX 2.6.10 patch=E9 pour cette carte avec un patch fourni par WindR=
iver. Je voudrais lui adjoindre XENOMAI mais j'ai des difficult=E9s =E0 cho=
isir les versions de XENOMAI et de patch ADEOS.
> >=20
> > En effet, j'ai remarqu=E9 deux familles de patch ADEOS, jusqu'a XENOMAI=
 2.0 (adeos-linux) et apr=E8s XENOMAI 2.1 (adeos-ipipe). La famille IPIPE n=
e semble supporter que les versions LINUX depuis 2.6.13.
> >=20
> > Cependant, j'ai des difficult=E9s =E0 changer de version LINUX du fait =
du patch WindRiver applicable uniquement en LINUX 2.6.10.
> >=20
> > - Pourriez-vous me confirmer mon analyse des versions de XENOMAI et m'i=
nformer sur les grandes diff=E9rences entre ces deux familles?
> > - Pourriez-vous me conseiller dans le choix de la version XENOMAI et de=
s patchs ADEOS ?
> >=20
> > Cordialement,
> > Charles BIRON=20
>=20
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
--=20
Philippe.



