Message-ID: <4368CACD.4000905@domain.hid>
Date: Wed, 02 Nov 2005 15:18:53 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [RFC] support for sharing IRQs
References: <!&!AAAAAAAAAAAYAAAAAAAAAFl5OYS2HqNLpPPM8SELvJDCgAAAEAAAAJHy9YD7gaxGnAtpaanpWP8BAAAAAA==@ac6.fr>
In-Reply-To: <!&!AAAAAAAAAAAYAAAAAAAAAFl5OYS2HqNLpPPM8SELvJDCgAAAEAAAAJHy9YD7gaxGnAtpaanpWP8BAAAAAA==@ac6.fr>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Bernard Dautrevaux <bernard.dautrevaux@domain.hid>
Cc: xenomai@xenomai.org

Bernard Dautrevaux wrote:
> =20
>=20
>=20
>>-----Message d'origine-----
>>De : xenomai-core-bounces@domain.hid
>>[mailto:xenomai-core-bounces@domain.hid] De la part de Philippe Gerum
>>Envoy=E9 : mardi 1 novembre 2005 18:30
>>=C0 : Jan Kiszka
>>Cc : xenomai-core
>>Objet : Re: [Xenomai-core] [RFC] support for sharing IRQs
>=20
> 	....
>=20
>>Ok, let's go for those changes this way:
>>
>>1. The I-pipe series needs to be updated so that an opaque=20
>>cookie is passed to the handler; since we have a change in=20
>>the interface, the 1.1 series has to be started for this purpose.
>>
>>2. In order to let the people running the legacy RTAI/fusion=20
>>and Xenomai 2.0.x series a reasonable amount of time to=20
>>upgrade their patchset, the IRQ layer updates (sharing and=20
>>trampoline suppression) will go to the Xenomai 2.1 dev=20
>>branch. IOW, Xenomai 2.1 will be exclusively based on the=20
>>I-pipe 1.1 series, which also means that Xenomai support for=20
>>the oldgen Adeos and I-pipe 1.0 patches will be discontinued=20
>>after the Xenomai 2.0.x series is closed.
>=20
>=20
> I agree with all that is said in this post; however there is just a sma=
l
> problem: some very useful tool for xenomai application debug and tune i=
s
> LTT; however the only available Adeos+LTT patch is not an ipipe one, bu=
t an
> old linux-2.6.9 kernel patch.
>=20
> At least the LTT support should be available with an ipipe-based Adeos-=
1.1
> patch for 2.6.9 (waiting for LTT to support a more recent kernel), so t=
hat
> LTT is not lost for xenomai (as it seems to be in fact for RTAI).=20
>=20

LTT has been undergoing a significant refactoring recently, so there has =
been=20
little incentive to go for a combo Adeos+LTT patch over a moving target, =
this is=20
the reason why Alex - the LTT support maintainer for Xenomai - has focuse=
d on a=20
2.6.9 kernel featuring the previous LTT architecture, and this was a good=
=20
decision. Upgrading this combo will be done in the I-pipe 1.1 timeframe o=
ver the=20
newest LTT support, for sure, basically to get rid of the oldgen Adeos pa=
tches=20
for Xenomai completely.

RTAI had problem maintaining the LTT support because of the lack of a=20
maintainer; we do have one. This said, the best way you could contribute =
to this=20
is crafting a prototype combo between I-pipe 1.0 and a recent LTT core (i=
.e. the=20
one that relies on the refactored relayfs stuff), especially if you do co=
nsider=20
this support as a critical feature. I guess that Alex would be fine worki=
ng on=20
this base later.

> Bernard
>=20
>=20
>>3. Changes in the IRQ layer will be made at nucleus level,=20
>>which is the most efficient way to provide them.
>>
>>It should be noted that as part of the build system=20
>>refactoring, the real-time HAL has become a static portion of=20
>>the Linux kernel, with its generic part being moved to the=20
>>nucleus. IOW, the proposed changes will basically end up as=20
>>redispatching some code inside the nucleus.
>>
>>--=20
>>
>>Philippe.
>>
>>_______________________________________________
>>Xenomai-core mailing list
>>Xenomai-core@domain.hid
>>https://mail.gna.org/listinfo/xenomai-core
>>
>>
>=20
>=20
>=20
>=20
> _______________________________________________
> Xenomai-core mailing list
> Xenomai-core@domain.hid
> https://mail.gna.org/listinfo/xenomai-core
>=20


--=20

Philippe.

