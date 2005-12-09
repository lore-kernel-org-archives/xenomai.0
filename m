Message-ID: <4399B81F.2030106@domain.hid>
Date: Fri, 09 Dec 2005 18:00:15 +0100
From: Jan Kiszka <kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [bug] user memory leakage on rt_task_delete
References: <43986AFA.6060908@domain.hid>
	<4399B6B8.8030209@domain.hid>
In-Reply-To: <4399B6B8.8030209@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig31E6E9AC72A185B3081D8C69"
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
--------------enig31E6E9AC72A185B3081D8C69
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Philippe Gerum wrote:
> Jan Kiszka wrote:
>> Hi all,
>>
>> during my ongoing search for the init/cleanup issue of shadow threads,=
 I
>> stumbled over another problem: Deleting a userspace native thread that=

>> is blocked in primary mode does not let the NPTL clean up all resource=
s
>> allocated in userspace. If you plan to do some rt_task_create/delete i=
n
>> a loop, you will soon run out of memory (and Mr. oom-killer will show
>> up...).
>>
>> I haven't found a solution for this beyond letting a rt-task always
>> terminate itself (or terminate the whole program after forced
>> deletions). If there is no solution, we should at least document this
>> fact somewhere.
>>
>> Again, it's not a common use case, but it's also not an expectable
>> behaviour of the native skin.
>>
>=20
> I see no possible workaround to allow a shadow thread deletion from
> kernel space while still leaving the opportunity for the NPTL thread to=

> perform some user-space cleanups; recycling a previous Xenomai context
> to unwind a Linux context would lead to some terminally broken
> situation, so the nucleus must reap the terminated shadow at kernel
> level asap. However, the rt_task_delete() wrapper from the user-space
> support library might preferably pthread_kill() the thread, instead of
> asking the nucleus for that purpose.

Hmm, I think I've read something about signal delivery and handling in
threads which said that the delivery is per thread, but the handling
remains to affect the whole process. Thus, I'm afraid we may kill
ourselves here and not just the thread...

Ok, Versuch macht klug (in English: just give it a try)!

Jan


--------------enig31E6E9AC72A185B3081D8C69
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFDmbgfncNeS9Q0k+IRAmwtAKCsYiwpap3G62prVwSxu4ijIkr3YgCfeLcI
ys3H2vwIPMxFBtOAOTRbj+c=
=qBvp
-----END PGP SIGNATURE-----

--------------enig31E6E9AC72A185B3081D8C69--

