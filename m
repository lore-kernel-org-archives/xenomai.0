Message-ID: <4399BA56.3030405@domain.hid>
Date: Fri, 09 Dec 2005 18:09:42 +0100
From: Jan Kiszka <kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [bug] user memory leakage on rt_task_delete
References: <43986AFA.6060908@domain.hid>
	<4399B6B8.8030209@domain.hid>
	<4399B81F.2030106@domain.hid>
In-Reply-To: <4399B81F.2030106@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig6C03273123CE37F24D472D2E"
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig6C03273123CE37F24D472D2E
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Jan Kiszka wrote:
> Philippe Gerum wrote:
>> Jan Kiszka wrote:
>>> Hi all,
>>>
>>> during my ongoing search for the init/cleanup issue of shadow threads=
, I
>>> stumbled over another problem: Deleting a userspace native thread tha=
t
>>> is blocked in primary mode does not let the NPTL clean up all resourc=
es
>>> allocated in userspace. If you plan to do some rt_task_create/delete =
in
>>> a loop, you will soon run out of memory (and Mr. oom-killer will show=

>>> up...).
>>>
>>> I haven't found a solution for this beyond letting a rt-task always
>>> terminate itself (or terminate the whole program after forced
>>> deletions). If there is no solution, we should at least document this=

>>> fact somewhere.
>>>
>>> Again, it's not a common use case, but it's also not an expectable
>>> behaviour of the native skin.
>>>
>> I see no possible workaround to allow a shadow thread deletion from
>> kernel space while still leaving the opportunity for the NPTL thread t=
o
>> perform some user-space cleanups; recycling a previous Xenomai context=

>> to unwind a Linux context would lead to some terminally broken
>> situation, so the nucleus must reap the terminated shadow at kernel
>> level asap. However, the rt_task_delete() wrapper from the user-space
>> support library might preferably pthread_kill() the thread, instead of=

>> asking the nucleus for that purpose.
>=20
> Hmm, I think I've read something about signal delivery and handling in
> threads which said that the delivery is per thread, but the handling
> remains to affect the whole process. Thus, I'm afraid we may kill
> ourselves here and not just the thread...
>=20
> Ok, Versuch macht klug (in English: just give it a try)!
>=20

Yep, as soon as the target thread was able to receive the signal, the
whole process can "enjoy" its effect.

What remains is to reserve one signal for the native skin and register a
handler on in to call pthread_exit. This should work, but leaves the
risk to collide with user defined signal handlers.

Jan


--------------enig6C03273123CE37F24D472D2E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFDmbpWncNeS9Q0k+IRAmW6AJ9Y8yDk/5XIVv8W24y+WJxIA60jQwCfW0+F
zZE74SsehIxUuE7VEJuZIcY=
=/QzV
-----END PGP SIGNATURE-----

--------------enig6C03273123CE37F24D472D2E--

