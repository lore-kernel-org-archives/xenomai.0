Message-ID: <473007B9.9030406@domain.hid>
Date: Tue, 06 Nov 2007 07:20:41 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <E1Ioj7Q-0004EI-JX@subversion.gna.org>	<472E3758.3060304@domain.hid>	<18222.15424.494628.332671@domain.hid>	<472F5990.5000408@domain.hid>
	<472F6CE1.7050208@domain.hid> <472FA210.7030904@domain.hid>
In-Reply-To: <472FA210.7030904@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig1F8708DC5511C6E13EEA8E54"
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
--------------enig1F8708DC5511C6E13EEA8E54
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Philippe Gerum wrote:
> Jan Kiszka wrote:
>> Philippe Gerum wrote:
>>> Gilles Chanteperdrix wrote:
>>>> Jan Kiszka wrote:
>>>>  > [Let's discuss this without bothering users :)]
>>>>  >=20
>>>>  > Philippe Gerum wrote:
>>>>  > > Author: rpm
>>>>  > > Date: Sun Nov  4 18:18:39 2007
>>>>  > > New Revision: 3147
>>>>  > >=20
>>>>  > > URL: http://svn.gna.org/viewcvs/xenomai?rev=3D3147&view=3Drev
>>>>  > > Log:
>>>>  > > Make __xn_access_ok() return false for addresses lower than the=
 natural page size.
>>>>  > >=20
>>>>  > > Modified:
>>>>  > >     trunk/ChangeLog
>>>>  > >     trunk/include/asm-x86/syscall_32.h
>>>>  > >     trunk/include/asm-x86/syscall_64.h
>>>>  >=20
>>>>  > Could it be that you meant "PAGE_SIZE" instead of "PAGE_OFFSET"? =
Because
>>>>  > the current version is "slightly" broken, tagging any address in =
user
>>>>  > land as invalid.
>>>>  >=20
>>> Another example that committing last minute "fixes" before leaving fo=
r a=20
>>> trip is just as safe as checking for your parachute _after_ you jumpe=
d=20
>>> out of the plane. Fixed the trivial way for now. Sorry for this.
>>>
>>>>  > And if this test was meant to catch NULL page accesses early, is =
the
>>>>  > intention to cope with all those current i-pipe patches that do n=
ot yet
>>>>  > include the discussed domain switch on non-root faults? If yes, t=
his
>>>>  > test would be a workaround for legacy code and should not become =
default
>>>>  > (pure overhead for later versions).
>>>>
>>>> We can reduce the overhead of the two tests by testing=20
>>>> (unsigned long) (addr - PAGE_SIZE) < (PAGE_OFFSET - PAGE_SIZE)
>>>>
>>> Yep. I'd rather keep the reference to the actual task's segment limit=
 in=20
>>> this expression though, instead of hardcoding PAGE_OFFSET.
>>>
>>> Aside of this, we should not need to pass the current task pointer to=
=20
>>> each and every syscall anymore, so we may rely on the original uacces=
s code.
>>>
>>> __xn_access_ok was there to allow for passing the task pointer
>>> explicitly in order to test the address range against the task's segm=
ent
>>> limit, at times when Adeos would switch the underlying stack to some
>>> private, non-Linux one.
>>>
>>> With modern I-pipe, domains don't have any private stack, but simply
>>> reuse the current one, which means that any task running a syscall
>>> over the Xenomai domain may always be referenced by "current", includ=
ing
>>> on archs using the stack pointer trick to determine this value.
>>>
>>> I'll do this change early in the 2.5 series; it's too late for 2.4.
>>>
>>> This said, we'll still need __xn_access_ok from now on, to pre-test t=
he=20
>>> address for obvious spuriousness, like the NULL case which started th=
is=20
>>> discussion.
>> ...which still doesn't answer my original question: Is the current
>> (virtually fixed - please fix in real-life soon!) version a legacy
>> wrapper for you? Because I still don't see the need for it with, e.g.,=

>> my latest patch for i386-ipipe.
>=20
> I usually refrain from rehashing the obvious, but here it comes anyway:=
=20

The reason why I'm picking on this is because this "obvious" detail at
least belongs into the code in form of a comment (instead of the
currently documented even more obvious properties).

> yes, it's a work around, because we have more than 340 older I-pipe=20
> patches out there for a number of archs, and leaving the possibility fo=
r=20
> lockups with those just due to some uncaught NULL pointer would be bad =

> policy. And yes, it adds a few cycles more to the hot path for that=20
> reason, so we may want to make this conditional -- albeit the fixes are=
=20
> functionally quite different, and getting -EFAULT at application level =

> may give a better debugging help than relying on CONFIG_IPIPE_DEBUG and=
=20
> looking at the kernel log periodically, at least for most common error =

> cases like NULL pointers.

Again, this detection is normally not the job of __xn_access_ok, and
people reading it can expect an explanation of this exceptional
modification (/me avoiding a stronger term here). Moreover, the reason
that certain user bugs currently only show up in kernel log is due to at
least the native skin consequently ignoring the result of
xn_copy_*_user. That's a different story, likely something that needs to
be fixed on a series of rainy days (along with RTnet which is even
worse, BTW)...

>=20
> As a matter of fact, there is not a single I-pipe patch officially=20
> released which implements the fixup I've been talking about yesterday=20
> yet, therefore, no time is lost for making the uaccess trick conditiona=
l.

I would expect 2.4 final including fixed-up I-pipe patches for at least
x86, so this should quickly become relevant.

Jan


--------------enig1F8708DC5511C6E13EEA8E54
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFHMAe5niDOoMHTA+kRAlxqAJ9T4aJcB5nMuLep6Sm1i9V6HTohRwCeKGvh
8NHDyCeY55HxIVBAPYPDL5g=
=m6VM
-----END PGP SIGNATURE-----

--------------enig1F8708DC5511C6E13EEA8E54--

