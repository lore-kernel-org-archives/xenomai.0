Message-ID: <46265FC8.1070207@domain.hid>
Date: Wed, 18 Apr 2007 20:13:28 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigC1E36D2B4F7F07552C120D45"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] [BUG] target width of shifts on 64 bits
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
--------------enigC1E36D2B4F7F07552C120D45
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Hi Philippe,

here is an explanation of the scalable scheduler issue I face on x86_64
under different gcc compilers:

        unsigned long x =3D 0;
        int n =3D 32;

        x |=3D 1 << n;

The last instruction translates to:

	mov    0xfffffffffffffffc(%rbp),%ecx
	mov    $0x1,%eax
	shl    %cl,%eax
	cltq
	or     %rax,0xfffffffffffffff0(%rbp)

That means we only shift with 32-bit precision although the target type
is 64 bit. We find such code for setting the queue usage bits in
addmlq(), but probably elsewhere too. This variant lets gcc generate the
desired code:

	x |=3D (unsigned long)1 << n;

Compiler issue, x86_64-specific oddity, or generic 64-bit problem we may
have across the ipipe and Xenomai code (ppc64, ia64?)?

After patching nucleus/queue.h appropriately, my oopses disappear, but
RT threads still do not run (no CSW to the threads latency creates).

Jan


PS: If you are interested, I could post a modified qemu patch that
enables gdb kernel debugging under x86_64.


--------------enigC1E36D2B4F7F07552C120D45
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGJl/IniDOoMHTA+kRAm/VAJ9Jysm1HjEurvyn8HzGKhzC5PotIgCfcG5e
V1EwjG7a5ghVH9igiPM9xAk=
=XVvF
-----END PGP SIGNATURE-----

--------------enigC1E36D2B4F7F07552C120D45--

