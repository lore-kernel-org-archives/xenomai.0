Message-ID: <454B15C5.1050803@domain.hid>
Date: Fri, 03 Nov 2006 11:11:17 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Fwd: Re: [Xenomai-help] invalid use of FPU in Xenomai context]
References: <4548C170.1000504@domain.hid> <4548F8BE.90809@domain.hid>
	<454901B6.80606@domain.hid> <454B0FA0.9080307@domain.hid>
	<454B1363.8080805@domain.hid>
In-Reply-To: <454B1363.8080805@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig2B796B337688B246C738F4C2"
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
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai help <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig2B796B337688B246C738F4C2
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Gilles Chanteperdrix wrote:
> Jan Kiszka wrote:
>> Jeff Webb wrote:
>>
>>> Jan Kiszka wrote:
>>>
>>>> Jeff Webb wrote:
>>>>
>>>>> Does anyone else have an AMD system that can verify my results?
>>>>
>>>> I have an old Athlon 800. Maybe we are lucky and it exposes the prob=
lem
>>>> when the kernel is optimised for it. I'm going to give this a try, b=
ut
>>>> it may take a few days (and a free time slot).
>>>
>>> Thank you.  I appreciate you giving it a try when you get some free
>>> time.  I was able to work around the problem by writing the queue dat=
a
>>> in smaller chunks (or use an i686 kernel), so I am not in urgent need=
 of
>>> an immediate fix.  I do think it's important to fix this bug eventual=
ly,
>>> so I didn't want it to slip through the cracks.
>>>
>>>
>>>>> The problem seems to be connected with the size of writes to Xenoma=
i
>>>>> pipes.  This example uses POSIX message queues, but I had a similar=

>>>>> problem a while back with RTAI pipes.  Maybe this tells us the prob=
lem
>>>>> is in the nucleus pipe code?  Just a guess.  The problem seems to
>>>>> affect
>>>>> both 2.4 and 2.6 systems, and goes back to at least Xenomai 2.2.1.
>>>>
>>>> Maybe, maybe not. Pipes remain fairly unrelated to FPU usage, so the=
re
>>>> is still /at least/ one piece missing in the puzzle.
>>>
>>> True.  It is very strange that the amount of data in the write call e=
nds
>>> up affecting the FPU context.
>>
>>
>> I found the reason: "3-dimensional" memcpy (__memcpy3d/_mmx_memcpy)
>>
>> http://lxr.free-electrons.com/source/include/asm-i386/string.h#285
>>
>> It's an optimised memcpy for 3DNow CPUs that is used with blocks >=3D =
512
>> bytes. It messes up with the FPU state and may get trapped by other
>> issues as well (blind access to "current" in order to test
>> in_interrupt()). I don't have an answer for this right now beyond "don=
't
>> switch on AMD optimisations when using Xenomai". But that's a bit
>> unsatisfying.
>>
>> Another way would be to wrap any memcpy access from Xenomai context, b=
ut
>> that's likely impractical (think of all the drivers).
>=20
> I see other ways to solve this issue:
> - either we disable the use of the mmx memcpy in string.h if
> ipipe_current_domain is not root

This is what came to my mind as well meanwhile.

> - or we allow the exception to happen for threads in primary mode with
> the XNFPU bit set and call xnarch_restore_fpu in xnpod_fault_handler in=

> this case.

Given that this is a special case for a subset of x86[_64] CPUs, I
rather think we should go for the first variant. Should be simpler.

Jan


--------------enig2B796B337688B246C738F4C2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFSxXFniDOoMHTA+kRAg1TAJ9uMc3BVg2rNZkrWVuZUfP54NSliQCbBAcw
t7zXiXUz5e98FravFAFhdyE=
=syO0
-----END PGP SIGNATURE-----

--------------enig2B796B337688B246C738F4C2--

