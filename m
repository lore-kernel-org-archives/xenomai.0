From: "Bernard Dautrevaux" <bernard.dautrevaux@domain.hid>
Date: Thu, 3 Nov 2005 02:24:56 +0100
Message-ID: <!&!AAAAAAAAAAAYAAAAAAAAAFl5OYS2HqNLpPPM8SELvJDCgAAAEAAAAKfbycwad0RPhAYQJaioQp4BAAAAAA==@ac6.fr>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <4368CACD.4000905@domain.hid>
Subject: [Xenomai-core] LTT support on Xenomai (was part of support for
	sharing IRQs)
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

> -----Message d'origine-----
> De : Philippe Gerum [mailto:rpm@xenomai.org
> Envoy=E9 : mercredi 2 novembre 2005 15:19
> =C0 : Bernard Dautrevaux
> Cc : xenomai@xenomai.org; karim@domain.hid
> Objet : Re: [Xenomai-core] [RFC] support for sharing IRQs
>=20
> Bernard Dautrevaux wrote:
> > =20
> >=20
> >=20
> >>-----Message d'origine-----
> >>De : xenomai-core-bounces@domain.hid
> >>[mailto:xenomai-core-bounces@domain.hid] De la part de Philippe Gerum=20
> >>Envoy=E9 : mardi 1 novembre 2005 18:30 =C0 : Jan Kiszka Cc :=20
> xenomai-core=20
> >>Objet : Re: [Xenomai-core] [RFC] support for sharing IRQs
> >=20
> > 	....
> >=20
> > At least the LTT support should be available with an=20
> ipipe-based Adeos-1.1
> > patch for 2.6.9 (waiting for LTT to support a more recent=20
> kernel), so that
> > LTT is not lost for xenomai (as it seems to be in fact for RTAI).=20
> >=20
>=20
> LTT has been undergoing a significant refactoring recently,=20

Do you mean there is something more recent than ltt-0.9.6-pre4 ?

If this is true where can this be found?

> so there has been=20
> little incentive to go for a combo Adeos+LTT patch over a=20
> moving target, this is=20
> the reason why Alex - the LTT support maintainer for Xenomai=20
> - has focused on a=20
> 2.6.9 kernel featuring the previous LTT architecture, and=20
> this was a good=20
> decision.=20

This restrain then to use oldgen Adeos architecture, as LTT is only
available on 2.6.9 and ipipe only from 2.6.13; is there anything =
preventing
having ipipe on 2.6.9 (apart from workload of course)?
=20
> Upgrading this combo will be done in the I-pipe 1.1=20
> timeframe over the=20
> newest LTT support, for sure, basically to get rid of the=20
> oldgen Adeos patches=20
> for Xenomai completely.

That for sure will be nice.

> RTAI had problem maintaining the LTT support because of the lack of a=20
> maintainer; we do have one. This said, the best way you could=20
> contribute to this=20
> is crafting a prototype combo between I-pipe 1.0 and a recent=20
> LTT core (i.e. the=20
> one that relies on the refactored relayfs stuff), especially=20
> if you do consider=20
> this support as a critical feature. I guess that Alex would=20
> be fine working on=20
> this base later.

This is something we may look at, but need access to this new-gen LTT,
hopefuly supporting recent Linux kernel, at least 2.6.13.

BTW the rapid evolution of 2.6 is perhaps a benefit for some people, but =
to
maintain kernel-dependent extensions, it seems to be more a nightmare =
than
anything else...=20

> --=20
>=20
> Philippe.
>=20
>

Bernard=20



