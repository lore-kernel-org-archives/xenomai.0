Message-ID: <493967D3.6020805@domain.hid>
Date: Fri, 05 Dec 2008 18:41:39 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <493943B6.2040500@domain.hid>
	<493946AD.3040003@domain.hid>	<4939599E.7090208@domain.hid>
	<49395CA5.1040409@domain.hid>
In-Reply-To: <49395CA5.1040409@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigC481AA638D07203D49FE63FE"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] SCHED_RR
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigC481AA638D07203D49FE63FE
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Gilles Chanteperdrix wrote:
> Jan Kiszka wrote:
>> Gilles Chanteperdrix wrote:
>>> Jan Kiszka wrote:
>>>> Hi Gilles,
>>>>
>>>> here is a trivial test case on my desk that points to SCHED_RR issue=
s of
>>>> the POSIX skin: simple pthread_create with an attribute block that h=
as
>>>> SCHED_RR set, but neither SCHED_RR nor the priority reach the new th=
read.
>>>>
>>>> The way the scheduling policy and parameters get to that user space
>>>> thread leads via __real_pthread_setschedparam after
>>>> __pse51_thread_create. This triggers do_setsched_event in shadow.c. =
But
>>>> here we filter out all policies except for SCHED_FIFO. So neither th=
e
>>>> priority nor the required XNRRB flag make it to the target therefore=
=2E
>>>>
>>>> Even worse, we are running aperiodic timer mode, so this would not h=
ave
>>>> worked anyway due to the scheduler limitations. Fortunately, it turn=
ed
>>>> out that the customer is fine with SCHED_FIFO as well, but the broke=
n
>>>> priorities and/or lacking error codes on creation are annoying + the=

>>>> fact that it likely wouldn't work even with periodic timer mode.
>>> The fact that it does not work with aperiodic timer is documented.
>>> However, this used to work and was tested with periodic timer (you ca=
n
>>> find the tests under sim/skins/posix/testsuite), that is why there is=
 no
>>> reason to return any error code.
>> ...which is bogus IMHO. Expecting to read the doc when something does
>> not work as expected is ok. But more or less silently failing even if =
it
>> is documented that it will somehow fail is not what Xenomai is usually=

>> known for.
>>
>> That said, I still don't see (looking at TRUNK) how SCHED_RR should wo=
rk
>> even under periodic mode. Guess I have to enable and test it.
>>
>> But I guess the best we can do is to finally remove this limitation by=

>> allowing the use to create a periodic tick timer over aperiodic mode i=
f
>> there is a need for RR scheduling.
>=20
> In ksrc/skins/posix/syscall.c, function __pthread_create:
>=20
>         pthread_attr_init(&attr);
>         attr.policy =3D p->policy;
>         param.sched_priority =3D p->rt_priority;
>         attr.detachstate =3D PTHREAD_CREATE_DETACHED;
>=20
> So, the priority and policy are taken from the underlying Linux thread.=


Yep, but its prio/policy is set *after* the chunk above. Maybe it is
already a sufficient hot-fix to move __real_pthread_setschedparam before
__pse51_thread_create if this has no unwanted side effects.

Jan


--------------enigC481AA638D07203D49FE63FE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAkk5Z9gACgkQniDOoMHTA+lKIgCdGp2Bji+AyYNjsU2ESWlEeyxi
ziMAn0kiqbZegzzbj9rVpX2YBbWFL7we
=LfHp
-----END PGP SIGNATURE-----

--------------enigC481AA638D07203D49FE63FE--

