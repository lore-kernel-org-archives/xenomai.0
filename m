Message-ID: <454B0FA0.9080307@domain.hid>
Date: Fri, 03 Nov 2006 10:45:04 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Fwd: Re: [Xenomai-help] invalid use of FPU in Xenomai context]
References: <4548C170.1000504@domain.hid> <4548F8BE.90809@domain.hid>
	<454901B6.80606@domain.hid>
In-Reply-To: <454901B6.80606@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig017E44F877525CC59AFD8CCE"
Sender: jan.kiszka@domain.hid
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jeff Webb <jeff.webb@domain.hid>, Philippe Gerum <rpm@xenomai.org>, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai help <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig017E44F877525CC59AFD8CCE
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Jeff Webb wrote:
> Jan Kiszka wrote:
>> Jeff Webb wrote:
>>> Does anyone else have an AMD system that can verify my results?
>>
>> I have an old Athlon 800. Maybe we are lucky and it exposes the proble=
m
>> when the kernel is optimised for it. I'm going to give this a try, but=

>> it may take a few days (and a free time slot).
>=20
> Thank you.  I appreciate you giving it a try when you get some free
> time.  I was able to work around the problem by writing the queue data
> in smaller chunks (or use an i686 kernel), so I am not in urgent need o=
f
> an immediate fix.  I do think it's important to fix this bug eventually=
,
> so I didn't want it to slip through the cracks.
>=20
>>> The problem seems to be connected with the size of writes to Xenomai
>>> pipes.  This example uses POSIX message queues, but I had a similar
>>> problem a while back with RTAI pipes.  Maybe this tells us the proble=
m
>>> is in the nucleus pipe code?  Just a guess.  The problem seems to aff=
ect
>>> both 2.4 and 2.6 systems, and goes back to at least Xenomai 2.2.1.
>>
>> Maybe, maybe not. Pipes remain fairly unrelated to FPU usage, so there=

>> is still /at least/ one piece missing in the puzzle.
>=20
> True.  It is very strange that the amount of data in the write call end=
s
> up affecting the FPU context.

I found the reason: "3-dimensional" memcpy (__memcpy3d/_mmx_memcpy)

http://lxr.free-electrons.com/source/include/asm-i386/string.h#285

It's an optimised memcpy for 3DNow CPUs that is used with blocks >=3D 512=

bytes. It messes up with the FPU state and may get trapped by other
issues as well (blind access to "current" in order to test
in_interrupt()). I don't have an answer for this right now beyond "don't
switch on AMD optimisations when using Xenomai". But that's a bit
unsatisfying.

Another way would be to wrap any memcpy access from Xenomai context, but
that's likely impractical (think of all the drivers).

Jan


--------------enig017E44F877525CC59AFD8CCE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFFSw+jniDOoMHTA+kRAvTVAJ48xmdDKqxollehSNGEfLgwMt6UmwCdF9LG
teW5MEO7yw2oJQZ0ja9tvCg=
=VexE
-----END PGP SIGNATURE-----

--------------enig017E44F877525CC59AFD8CCE--

