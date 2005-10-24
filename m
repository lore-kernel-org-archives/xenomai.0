Message-ID: <435D4B16.7020907@domain.hid>
Date: Mon, 24 Oct 2005 22:59:02 +0200
From: Jan Kiszka <kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [bug-reminder] user/kernel space header deps
References: <43536E90.2050001@domain.hid>	<43538C34.7010802@domain.hid>
	<435CC24C.20708@domain.hid> <435D4840.2050602@domain.hid>
In-Reply-To: <435D4840.2050602@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig73FA3951BB60477135FD70A0"
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
--------------enig73FA3951BB60477135FD70A0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

Philippe Gerum wrote:
> Jan Kiszka wrote:
>
>> Philippe Gerum wrote:
>>
>>> Jan Kiszka wrote:
>>>
>>>
>>>> Hi,
>>>>
>>>> just to avoid that this issue got lost during the migration to Xenomai:
>>>>
>>>> It's still not possible to compile a C++ POSIX program with CFLAGS
>>>> obtained via "xeno-config --posix-ldflags". This is due to the fact
>>>> that
>>>> low-level, C++-incompatible headers get included in that case.
>>>> Moreover,
>>>> the same scenarion works for native skin programs only by chance at the
>>>> moment.
>>>>
>>>> On the long term, a clear separation between types, defines, function
>>>> prototypes, etc. needed for the user API on the one and for core
>>>> compilation on the other side is required.
>>>>
>>>
>>> Without duplicating definitions and ABI information, otherwise this
>>> would be an absolute nightmare. Suggestions welcome.
>>>
>>
>>
>> To pick up this issue again (as it's biting me more and more...):
>>
>> What precisely prevents us at the moment from removing the
>> -I<kernel-headers> from all userspace build steps, both Xenomai's own
>> libraries as well as external rt-applications?
>>
>
> Because a few things like asm/atomic.h and linux/bitops.h are wanted
> from the target header base for compiling some bits of user-space stuff.
> Not pretty, but currently needed. This is probably what needs to be
> fixed, in which case the -I directive would become useless in the same
> move.
>
>> Gilles explained to me that at least asm/atomic.h is used by certain
>> parts like UVM (or only UVM?), and that including this header directly
>> from /usr/include fails on Red Hat/Fedora boxes. Are there any further
>> problems? At least on my SuSE 10 everything still compiles fine
>> (including UVM) when I remove the kernel headers from XENO_USER_CFLAGS
>> in configure.in.
>>
>
> It's not an issue with such inclusion failing/passing, it's just that it
> would be incorrect to include your host distro's headers for that
> purpose, since what we need here is the _target_ stuff. The fact that it
> works on your box is just because 1) your host == your target arch, and
> 2) your host header base does not seem to implement guards preventing
> the use of kernel headers in user-space context. In cross compilation
> context, such inclusion would simply break the build, since it expects
> the target architecture headers to be used, not the host's ones.
>

I see, so the problem is the pre-set link of /usr/include/asm to
/usr/include/asm-i386 in my case.

Anyway, it seems that really few code is involved so that it should be
possible to find either related headers in the standard libc or copy
that few atomic ops to Xenomai's arch-dependent includes.

Jan

--------------enig73FA3951BB60477135FD70A0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFDXUsWncNeS9Q0k+IRAr+EAJ46MN4c8BclXKUq3fsIMLZJL64XGwCfRRTK
SSMgXDCFIvkt4tAFUQBce5s=
=CjDp
-----END PGP SIGNATURE-----

--------------enig73FA3951BB60477135FD70A0--

