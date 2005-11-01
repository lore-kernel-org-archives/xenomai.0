From: "Bernard Dautrevaux" <bernard.dautrevaux@domain.hid>
Subject: RE: [Xenomai-core] [RFC] support for sharing IRQs
Date: Wed, 2 Nov 2005 00:21:37 +0100
Message-ID: <!&!AAAAAAAAAAAYAAAAAAAAAFl5OYS2HqNLpPPM8SELvJDCgAAAEAAAAJHy9YD7gaxGnAtpaanpWP8BAAAAAA==@ac6.fr>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <4367A60D.9030108@domain.hid>
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

=20

> -----Message d'origine-----
> De : xenomai-core-bounces@domain.hid
> [mailto:xenomai-core-bounces@domain.hid] De la part de Philippe Gerum
> Envoy=E9 : mardi 1 novembre 2005 18:30
> =C0 : Jan Kiszka
> Cc : xenomai-core
> Objet : Re: [Xenomai-core] [RFC] support for sharing IRQs
	....
>=20
> Ok, let's go for those changes this way:
>=20
> 1. The I-pipe series needs to be updated so that an opaque=20
> cookie is passed to the handler; since we have a change in=20
> the interface, the 1.1 series has to be started for this purpose.
>=20
> 2. In order to let the people running the legacy RTAI/fusion=20
> and Xenomai 2.0.x series a reasonable amount of time to=20
> upgrade their patchset, the IRQ layer updates (sharing and=20
> trampoline suppression) will go to the Xenomai 2.1 dev=20
> branch. IOW, Xenomai 2.1 will be exclusively based on the=20
> I-pipe 1.1 series, which also means that Xenomai support for=20
> the oldgen Adeos and I-pipe 1.0 patches will be discontinued=20
> after the Xenomai 2.0.x series is closed.

I agree with all that is said in this post; however there is just a smal
problem: some very useful tool for xenomai application debug and tune is
LTT; however the only available Adeos+LTT patch is not an ipipe one, but =
an
old linux-2.6.9 kernel patch.

At least the LTT support should be available with an ipipe-based =
Adeos-1.1
patch for 2.6.9 (waiting for LTT to support a more recent kernel), so =
that
LTT is not lost for xenomai (as it seems to be in fact for RTAI).=20

Bernard

> 3. Changes in the IRQ layer will be made at nucleus level,=20
> which is the most efficient way to provide them.
>=20
> It should be noted that as part of the build system=20
> refactoring, the real-time HAL has become a static portion of=20
> the Linux kernel, with its generic part being moved to the=20
> nucleus. IOW, the proposed changes will basically end up as=20
> redispatching some code inside the nucleus.
>=20
> --=20
>=20
> Philippe.
>=20
> _______________________________________________
> Xenomai-core mailing list
> Xenomai-core@domain.hid
> https://mail.gna.org/listinfo/xenomai-core
>=20
>=20



