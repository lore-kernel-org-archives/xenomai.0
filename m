Message-ID: <45D9989E.4070103@domain.hid>
Date: Mon, 19 Feb 2007 13:31:26 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Re: I-pipe 1.7 breaks mlockall safety check
References: <45D45AEA.50404@domain.hid>	<1171547803.24117.8.camel@domain.hid>	<45D46704.9050109@domain.hid>	<1171560346.24117.77.camel@domain.hid>	<45D5746C.1090003@domain.hid>	<45D8DF58.2090804@domain.hid>	<17880.57781.152126.164326@domain.hid>	<1171842613.13484.17.camel@domain.hid>	<17880.60750.537420.707178@domain.hid>
	<45D95218.6000602@domain.hid>
In-Reply-To: <45D95218.6000602@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigC0996276A3D73985F78F2C99"
Sender: jan.kiszka@domain.hid
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigC0996276A3D73985F78F2C99
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Jan Kiszka wrote:
> Gilles Chanteperdrix wrote:
>> Philippe Gerum wrote:
>>  > On Mon, 2007-02-19 at 00:31 +0100, Gilles Chanteperdrix wrote:
>>  > > Jan Kiszka wrote:
>>  > >  > Hi Philippe,
>>  > >  >=20
>>  > >  > I just verfied that the mlockall issue persists. But it doesn'=
t appear
>>  > >  > to be a regression anymore. This little posix demo exposes it =
now on
>>  > >  > both 2.6.20-1.7-02 and 2.6.19-1.6-06 against latest trunk:
>>  > >  >=20
>>  > >  > #include <stdio.h>
>>  > >  > #include <sys/mman.h>
>>  > >  > #include <pthread.h>
>>  > >  >=20
>>  > >  > int main(int argc, char *argv[])
>>  > >  > {
>>  > >  > 	struct sched_param param =3D { .sched_priority =3D 10 };
>>  > >  >=20
>>  > >  > //	mlockall(MCL_CURRENT|MCL_FUTURE);
>>  > >  >=20
>>  > >  > 	pthread_setschedparam(pthread_self(), SCHED_FIFO, &param);
>>  > >  >=20
>>  > >  > 	printf("shouldn't be printed...\n");
>>  > >  > 	pause();
>>  > >  > }
>>  > >  >=20
>>  > >  >=20
>>  > >  > In contrast, the same done via the native skin (rt_task_shadow=
) triggers
>>  > >  > warning and program termination as expected.
>>  > >  >=20
>>  > >  > It looks to me like the temporary mlockall during libpthread_r=
t init is
>>  > >  > not really reverted (but munlockall is actually called) or not=

>>  > >  > propagated to the mm state that is later checked on xnshadow_m=
ap.
>>  > >=20
>>  > > The problem is that the root thread is already shadowed in this p=
rogram
>>  > > when pthread_setschedparam is called. So, xnshadow_map is not cal=
led and
>>  > > the flag is not checked.
>>  > >=20
>>  >=20
>>  > Yep. This makes sense, since kernel-wise, sys_munlockall does clear=
 the
>>  > VM_LOCKED bit from the caller's mm default flags.
>>  >=20
>>  > Since this behaviour is specific to the POSIX skin because it silen=
tly
>>  > shadows the main thread as a Xenomai thread from the SCHED_NORMAL c=
lass,
>>  > maybe we should check the mm state in the POSIX thread creation rou=
tine
>>  > too, when SCHED_FIFO or SCHED_RR are passed as the scheduling class=
=2E
>>
>> The flag is checked if another thread is created, since xnshadow_map i=
s
>> called. The only solution I see at the moment is to remove the call to=

>> munlockall in the library initialization.
>>
>=20
> So this piece of code should trigger again?
>=20
> #include <stdio.h>
> #include <sys/mman.h>
> #include <pthread.h>
>=20
> void *thread(void *arg)
> {
>         struct sched_param param =3D { .sched_priority =3D 10 };
>=20
>         pthread_setschedparam(pthread_self(), SCHED_FIFO, &param);
>         printf("shouldn't be printed...\n");
>         return NULL;
> }
>=20
> int main(int argc, char *argv[])
> {
>         pthread_t th;
>=20
>         pthread_create(&th, NULL, thread, NULL);
>         pthread_join(th, NULL);
> }
>=20
>=20
> Well, it doesn't in fact, and I think I found my regression again. This=

> demo behaves as expected over 1.6-06, but remains silent over I-pipe 1.=
7-02.

May this hunk explain the behaviour?

http://www.rts.uni-hannover.de/xenomai/lxr/source/ksrc/arch/i386/patches/=
adeos-ipipe-2.6.20-i386-1.7-02.patch?a=3Di386;v=3DSVN-2.3.x#7755

munlockall is realised via mlockall, so OR'ing here would never take
away any flag.

Jan


--------------enigC0996276A3D73985F78F2C99
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFF2ZieniDOoMHTA+kRAiNiAJ0fWM/LcolRRsZe2awY/MnKcAK0BACeP8Mg
Hduwyw8ZG6EJd2/KPYmV2Rw=
=dgaw
-----END PGP SIGNATURE-----

--------------enigC0996276A3D73985F78F2C99--

