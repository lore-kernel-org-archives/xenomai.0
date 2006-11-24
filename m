Message-ID: <4566CC51.20400@domain.hid>
Date: Fri, 24 Nov 2006 11:41:21 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Debugging in Xenomai
References: <DD39B5C3F4963040ADC9768BE7E430CB015D5270@domain.hid>
	<200611241020.45706.peter.soetens@domain.hid>
In-Reply-To: <200611241020.45706.peter.soetens@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig63D510E058E456EBDBAD4294"
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
To: Peter Soetens <peter.soetens@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig63D510E058E456EBDBAD4294
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Peter Soetens wrote:
> On Thursday 23 November 2006 16:25, Daniel Schnell wrote:
>> One of the next steps would be finding out which actual function back
>> trace the suspicious thread has. So I execute gdb and try to attach to=

>> the appropriate process, which works. Problem: sending Ctrl-C doesn't
>> work, independant of if gdb is executed via ssh or serial console. So =
I
>> cannot stop the actual program beeing debugged, rendering the gdb
>> approach useless. Also sending SIGINT to the GDB process doesn't work.=

>> It seems to be simply ignored. As I understand CTRL-C is effectively
>> sending SIGINT and is sent to GDB itself and not to the underlying app=
l.
>=20
> We had a similar issue while debugging an RTNET app (main thread + 1 xe=
nomai=20
> posix skin thread) under xenomai. I don't recall exactly the circumstan=
ces,=20
> but the app was blocked on a socket, and a Ctrl-C did not work. A 'kill=
all=20
> gdb' (SIGTERM) did come through and killed gdb. If you (the Xeno/RTNet =

> developers)'re interested in this case, I'll see if I can get more info=
=2E

You're welcome.

I just checked the behaviour of examples/xenomai/posix/eth_p_all over
gdb. I can interrupt the blocking recv - so far so good - but the
syscall is unfortunately not replayed when continuing. Instead, the
program just terminates because some error (EINTR) is reported to the
application.

[Too lazy to dig:] Philippe, isn't syscall restarting after an
interruption the job of the Xenomai nucleus?

Jan


--------------enig63D510E058E456EBDBAD4294
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFZsxRniDOoMHTA+kRAmQ4AJ9G1eHkSMW83cR5ritmHBaXD4N+hQCfXZ+8
/+Caeedt4qABjIzenEhwlCY=
=7YlR
-----END PGP SIGNATURE-----

--------------enig63D510E058E456EBDBAD4294--

