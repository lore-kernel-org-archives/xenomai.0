Message-ID: <435CC24C.20708@domain.hid>
Date: Mon, 24 Oct 2005 13:15:24 +0200
From: Jan Kiszka <kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [bug-reminder] user/kernel space header deps
References: <43536E90.2050001@domain.hid>
	<43538C34.7010802@domain.hid>
In-Reply-To: <43538C34.7010802@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigD6B093031A8E35A6D3C1C6B9"
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigD6B093031A8E35A6D3C1C6B9
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

Philippe Gerum wrote:
> Jan Kiszka wrote:
> 
>> Hi,
>>
>> just to avoid that this issue got lost during the migration to Xenomai:
>>
>> It's still not possible to compile a C++ POSIX program with CFLAGS
>> obtained via "xeno-config --posix-ldflags". This is due to the fact that
>> low-level, C++-incompatible headers get included in that case. Moreover,
>> the same scenarion works for native skin programs only by chance at the
>> moment.
>>
>> On the long term, a clear separation between types, defines, function
>> prototypes, etc. needed for the user API on the one and for core
>> compilation on the other side is required.
>>
> 
> Without duplicating definitions and ABI information, otherwise this
> would be an absolute nightmare. Suggestions welcome.
> 

To pick up this issue again (as it's biting me more and more...):

What precisely prevents us at the moment from removing the
-I<kernel-headers> from all userspace build steps, both Xenomai's own
libraries as well as external rt-applications?

Gilles explained to me that at least asm/atomic.h is used by certain
parts like UVM (or only UVM?), and that including this header directly
from /usr/include fails on Red Hat/Fedora boxes. Are there any further
problems? At least on my SuSE 10 everything still compiles fine
(including UVM) when I remove the kernel headers from XENO_USER_CFLAGS
in configure.in.

Jan

--------------enigD6B093031A8E35A6D3C1C6B9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFDXMJMncNeS9Q0k+IRAooQAKCg5UYIBMCBpzkdi4XG9VjUh+FbEACgq36h
PjJamwjIDycDw0nJOglO87o=
=ZMhq
-----END PGP SIGNATURE-----

--------------enigD6B093031A8E35A6D3C1C6B9--

