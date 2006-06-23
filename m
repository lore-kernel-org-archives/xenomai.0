Message-ID: <449BAF37.4000806@domain.hid>
Date: Fri, 23 Jun 2006 11:07:03 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [BUG] normal pthreads broken
References: <449AC16F.3020708@domain.hid> <1151052647.4438.20.camel@domain.hid>
In-Reply-To: <1151052647.4438.20.camel@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig9A4C1872473EC21CABB5D021"
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
To: rpm@xenomai.org
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig9A4C1872473EC21CABB5D021
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Philippe Gerum wrote:
> On Thu, 2006-06-22 at 18:12 +0200, Jan Kiszka wrote:
>> Hi Gilles,
>>
>> I think some regression slipped into the rt-pthread lib. This example =
no
>> longer works on my box (thread is not executed):
>=20
> The issue is in src/skins/posix/thread.c. The trampoline does not even
> attempt to fire the thread body for policy =3D=3D SCHED_OTHER. Will fix=
=2E
> This said, I still wonder why cyclic is affected, since it should only
> create SCHED_FIFO threads, but tracing it a bit, the issue is indeed th=
e
> same one.

It creates normal threads and then calls ppthread_setschedparam.

>=20
>> #include <pthread.h>
>> #include <stdio.h>
>> #include <sys/mman.h>
>>
>> void *thread(void *arg)
>> {
>>         printf("thread\n");
>>         return 0;
>> }
>>
>> main()
>> {
>>         pthread_t thr;
>>
>>         mlockall(MCL_CURRENT|MCL_FUTURE);
>>
>>         printf("create =3D %d\n",
>>                pthread_create(&thr, NULL, thread, NULL));
>>         pause();
>> }
>>
>>
>> This also explains why the cyclic test is broken.
>>
>> Jan
>>
>> _______________________________________________
>> Xenomai-core mailing list
>> Xenomai-core@domain.hid
>> https://mail.gna.org/listinfo/xenomai-core



--------------enig9A4C1872473EC21CABB5D021
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFEm687niDOoMHTA+kRArVWAJ9INP9l593h3bCWxeMjh+t84NMubQCeOXl3
zCs7FU9HqrN1pac0WEwJumQ=
=ki7C
-----END PGP SIGNATURE-----

--------------enig9A4C1872473EC21CABB5D021--

