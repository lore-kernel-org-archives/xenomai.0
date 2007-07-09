Message-ID: <46925AEF.2050803@domain.hid>
Date: Mon, 09 Jul 2007 17:57:35 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <46924A1A.4010909@domain.hid>	
	<1183992374.6014.84.camel@domain.hid> <46924B1B.1010308@domain.hid>	
	<4692501E.1060108@domain.hid> <469250F0.9080601@domain.hid>
	<1183995010.6014.102.camel@domain.hid>
In-Reply-To: <1183995010.6014.102.camel@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig97EAFDCFA7E9B2D952CB9F96"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] [PATCH] __deprecated not defined for Linux 2.4
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: rpm@xenomai.org
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig97EAFDCFA7E9B2D952CB9F96
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Philippe Gerum wrote:
> On Mon, 2007-07-09 at 17:14 +0200, Jan Kiszka wrote:
>> Wolfgang Grandegger wrote:
>>> Jan Kiszka wrote:
>>>> Philippe Gerum wrote:
>>>>> On Mon, 2007-07-09 at 16:45 +0200, Wolfgang Grandegger wrote:
>>>>>> Hello,
>>>>>>
>>>>>> the attached patch changes:
>>>>>>
>>>>>>    2007-07-09  Wolfgang Grandegger  <wg@domain.hid>
>>>>>>
>>>>>>   * include/asm-generic/wrappers.h: add  __deprecated for Linux 2.=
4.
>>>>>>
>>>>> Merged, thanks.
>>>> You are too fast for me - I was still test-building my approach!
>>> Too fast? My i-Pipe patched Linux 2.4 kernel did simply not built ;-)=
=2E
>> Yeah, and my 2.4 kernel was lying around in the corner, slightly dusty=
,
>> definitely not touched for several months.
>>
>> Hell, the amount of regressions one (specifically I) can produce due t=
o
>> all this config variants is amazing.
>=20
> We all have a very well defined job in this project, and particularly:
> - I do produce the original silly bugs.
> - You are in charge of adding regressions to your past fixes of my bugs=

> - Dmitry is in charge of finding why our common code breaks.
> - Wolfgang is in charge of making all the involved fixes compile
> properly.
> - Gilles is in charge of making the result run on bugous and/or sluggis=
h
> hardware.
>=20
> Ok, all in all, my situation is the best one. Good.

Yeah, it's certainly not bad when the boss is happy. :)

>=20
>>  What would be really nice is a
>> playground for patches, some build system you could post a patch serie=
s
>> and a set of .configs to and that will then "simply" try to generate
>> various kernels and the xenomai userland for various archs
>> automatically, reporting back any errors or warnings. Without going
>> through SVN with the changes every time. Just a dream.
>=20
> Niklaus already built most of this infrastructure for us, only the
> automated patching part seems to be missing so far:=20
> http://ngiger.dyndns.org/buildbot/

I'm very well aware of his work, but I also know that it was never
intended for broad use due to hardware and bandwidth constraints.
However, his buildbot scripts may indeed provide a helpful foundation.

> We would also have to alleviate the burden of his server by providing
> some dedicated hardware to do that, though.

That together with the required software infrastructure for more
automation are the points. We need some nice parallel box (4-way or
more) with a fast link and someone to look after the software. The
latter work may partly be distributed among the arch maintainers
(toolchain, kernel, .config updates). One could go even further with
such a platform, e.g. qemu targets, but let's concentrate on multi-arch,
multi-kernel build services first.

(My worries are also a bit egoistic: the nice 4-way box I'm using so far
for certain builds and tests will be definitely out of reach for me in
the near future.)

Jan


--------------enig97EAFDCFA7E9B2D952CB9F96
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGklrvniDOoMHTA+kRAu3+AJ9T5d/HP+zgYQbY41vFi+rCe9rntACgg6OQ
7Dz6MTNV6i92YW/jSbo4G84=
=+yOY
-----END PGP SIGNATURE-----

--------------enig97EAFDCFA7E9B2D952CB9F96--

