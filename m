From: Stefan Kisdaroczi <kisda@domain.hid>
Date: Sun, 8 Jan 2006 15:47:23 +0100
References: <43988C40.3070003@domain.hid>
In-Reply-To: <43988C40.3070003@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1977451.ZhHOa9XX8u";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200601081547.29370.kisda@domain.hid>
Subject: [Xenomai-core] rt_task_spawn with NULL name and pascal linking
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

--nextPart1977451.ZhHOa9XX8u
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

I needed a lot coffee and tobacco resources to find out that rt_task_spawn=
=20
with NULL name will not work in userspace. The call failed with -3 (ESRCH?).
This error seems not documented the xenomai api documention.

Using rt_task_create and rt_task_start it was rt_task_start that failed.
I think this is related to Jans statement below.

As rt_task_spawn is a inline function and a combination of create/start, th=
is=20
can be confusing. I.e. rt_task_shadow works with NULL name and rt_task_spaw=
n=20
dont. At this point I should mention that im testing my pascal-translations=
=20
of the xenomai native and rtdm headers, but i dont see that the problem=20
should be related to it, I searched the problem a long time i this part ;-)

Some questions:
Im still using Xenomai 2.0.1, is this the problem ?
Shouldnt this be documented better ?
Would it work if rt_task_spawn is a skincall?

pascal-related:
Is there a way to export the c-inline functions also in the libs, so that t=
he=20
complete api is exported ?
rt_task_spawn and some rt_*_unbind funtions are inlined.
Its not a problem to reprogram these in pascal, but for maintenance reasons
it would be nice if i could link against these functions.

greetings
kisda

Am Donnerstag, 8. Dezember 2005 20.40 schrieb Jan Kiszka:
> Hi again,
>
> some questions just came up for me:
>
> 1. Is it intended that tasks created with NULL name in userspace are not
> accessible even to the creator? I.e. don't they have to register
> anonymously in that case like semaphores e.g. do?


--nextPart1977451.ZhHOa9XX8u
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQBDwSYBIPTw9rIdn6oRAupbAJ99GbqOYS9x2GIATFytwwZFhRPNzACeNGK8
M7g0M870KEMs/3yn0vPKXH4=
=GBto
-----END PGP SIGNATURE-----

--nextPart1977451.ZhHOa9XX8u--

