Message-ID: <437F6766.2060003@domain.hid>
Date: Sat, 19 Nov 2005 18:56:54 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] v2.1 status
References: <437CB8BA.8040902@domain.hid>	<437DD08E.1020202@domain.hid>
	<437DE7FD.7050206@domain.hid> <437E036D.4010707@domain.hid>
In-Reply-To: <437E036D.4010707@domain.hid>
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
To: =?ISO-8859-1?Q?Ignacio_Garc=EDa_P=E9rez?= <iggarpe@domain.hid>
Cc: xenomai@xenomai.org

Ignacio Garc=EDa P=E9rez wrote:
> I had a first contact with the new build system. I really really don't
> like the fact it touches my kernel source tree. Besides adeos, I like t=
o
> keep the kernel source independent of xenomai, because that tree is
> shared for other projects.
>

At that point, I would really consider leaving the burden of keeping=20
various users of a single code base in sync to a SCM, not to the filesyst=
em.

> Also, why does it default to monolithic build of the xeno modules when
> in 2.0 you always got them as modules?.
>=20
>=20

Because it's a reasonable default:

o Most setups don't need to unload the real-time support, but rather=20
load it once for all at startup.
o Given #1, in the embedded space, modules are often considered as pure=20
annoyance. Among other things, you need to activate the module support=20
in the kernel just to load the RT system once, and this does not come=20
for free, especially in terms of memory footprints.
o Modules are allocated in vmalloc space. Given that the vanilla kernel=20
already has rather poor code locality (spatially speaking at least),=20
things are not going to improve for time-critical code in modules which=20
increase TLB misses.

For the rare cases where the arguments above are outweight by a strong=20
requirement to have modules, you can still switch them on in your kernel=20
configuration; this is the kind of flexibility you did not have with the=20
previous build system.

--=20

Philippe.

