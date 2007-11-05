Message-ID: <472F7643.4010607@domain.hid>
Date: Mon, 05 Nov 2007 21:00:03 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <E1Ioj7Q-0004EI-JX@subversion.gna.org>	<472E3758.3060304@domain.hid>	<18222.15424.494628.332671@domain.hid>	<472F5990.5000408@domain.hid>
	<472F6CE1.7050208@domain.hid>
In-Reply-To: <472F6CE1.7050208@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig8DB5B267EC761B7378808CED"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] [Xenomai-commits] r3147 - __xn_access_ok changes
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
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig8DB5B267EC761B7378808CED
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Jan Kiszka wrote:
> Philippe Gerum wrote:
>> Gilles Chanteperdrix wrote:
>>> Jan Kiszka wrote:
>>>  > [Let's discuss this without bothering users :)]
>>>  >=20
>>>  > Philippe Gerum wrote:
>>>  > > Author: rpm
>>>  > > Date: Sun Nov  4 18:18:39 2007
>>>  > > New Revision: 3147
>>>  > >=20
>>>  > > URL: http://svn.gna.org/viewcvs/xenomai?rev=3D3147&view=3Drev
>>>  > > Log:
>>>  > > Make __xn_access_ok() return false for addresses lower than the =
natural page size.
>>>  > >=20
>>>  > > Modified:
>>>  > >     trunk/ChangeLog
>>>  > >     trunk/include/asm-x86/syscall_32.h
>>>  > >     trunk/include/asm-x86/syscall_64.h
>>>  >=20
>>>  > Could it be that you meant "PAGE_SIZE" instead of "PAGE_OFFSET"? B=
ecause
>>>  > the current version is "slightly" broken, tagging any address in u=
ser
>>>  > land as invalid.
>>>  >=20
>> Another example that committing last minute "fixes" before leaving for=
 a=20
>> trip is just as safe as checking for your parachute _after_ you jumped=
=20
>> out of the plane. Fixed the trivial way for now. Sorry for this.
>>
>>>  > And if this test was meant to catch NULL page accesses early, is t=
he
>>>  > intention to cope with all those current i-pipe patches that do no=
t yet
>>>  > include the discussed domain switch on non-root faults? If yes, th=
is
>>>  > test would be a workaround for legacy code and should not become d=
efault
>>>  > (pure overhead for later versions).
>>>
>>> We can reduce the overhead of the two tests by testing=20
>>> (unsigned long) (addr - PAGE_SIZE) < (PAGE_OFFSET - PAGE_SIZE)
>>>
>> Yep. I'd rather keep the reference to the actual task's segment limit =
in=20
>> this expression though, instead of hardcoding PAGE_OFFSET.
>>
>> Aside of this, we should not need to pass the current task pointer to =

>> each and every syscall anymore, so we may rely on the original uaccess=
 code.
>>
>> __xn_access_ok was there to allow for passing the task pointer
>> explicitly in order to test the address range against the task's segme=
nt
>> limit, at times when Adeos would switch the underlying stack to some
>> private, non-Linux one.
>>
>> With modern I-pipe, domains don't have any private stack, but simply
>> reuse the current one, which means that any task running a syscall
>> over the Xenomai domain may always be referenced by "current", includi=
ng
>> on archs using the stack pointer trick to determine this value.
>>
>> I'll do this change early in the 2.5 series; it's too late for 2.4.
>>
>> This said, we'll still need __xn_access_ok from now on, to pre-test th=
e=20
>> address for obvious spuriousness, like the NULL case which started thi=
s=20
>> discussion.
>=20
> ...which still doesn't answer my original question: Is the current
> (virtually fixed - please fix in real-life soon!) version a legacy

Saw it too late: already done in #3150.

> wrapper for you? Because I still don't see the need for it with, e.g.,
> my latest patch for i386-ipipe.
>=20
> Jan
>=20



--------------enig8DB5B267EC761B7378808CED
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFHL3ZEniDOoMHTA+kRAjtFAJwLSCWPhNsggFfj3KDk2x1cbnfXCwCbB1pN
IEcLRxpMXgHVFHPuPB4cNEw=
=68bN
-----END PGP SIGNATURE-----

--------------enig8DB5B267EC761B7378808CED--

