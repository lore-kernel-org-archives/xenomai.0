Message-ID: <447F49C8.4090609@domain.hid>
Date: Thu, 01 Jun 2006 22:10:48 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] xnpod help
References: <39142.155.98.4.39.1149186052.squirrel@domain.hid>
	<17535.18007.179715.207040@domain.hid>
In-Reply-To: <17535.18007.179715.207040@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig0C96BD51F8A844D9B67DE17D"
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
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig0C96BD51F8A844D9B67DE17D
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Gilles Chanteperdrix wrote:
> Brandt Erickson wrote:
>  > Hey,
>  > I'm trying to write a simple looping module to test out xenomai nucl=
eus
>  > usage.  The problem is, when I insert the module (code attached), on=
ly the
>  > printks from the initialization function ever get displayed and none=
 from
>  > the indefinite loop.  All the pod startup functions return success, =
so is
>  > the thread working and just not successfully sending the messages ou=
t or
>  > is the thread not starting up at all?  Could someone tell me if I'm =
using
>  > the xenomai nucleus correctly?  Thanks.
>  > -Brandt
>=20
> If you seriously intend to write a skin, you should have a look at the
> simulator, it will allow you to run your skin in a debugger and to get
> reproducible behaviours.
>=20

=2E..or an emulator. I'm using Qemu attached to ddd for such elementary
kernel development now.

The simulator is good to reproduce weird timing scenarios. The emulator
is a bit closer to the real application environment, specifically if you
plan to write a syscall interface for your skin. And Qemu can even
generate multiple CPUs. The last SMP bug of Ipipe, e.g., was also
"emulatable" (but was debugged on real hardware with kgdb first).

Jan


--------------enig0C96BD51F8A844D9B67DE17D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFEf0nIniDOoMHTA+kRAltzAJ0QoFQ1wJ6Xy8iDllID+AI+u3lebQCdHE59
47+oAune0c2/Jg1GbOjXNP0=
=4Oz1
-----END PGP SIGNATURE-----

--------------enig0C96BD51F8A844D9B67DE17D--

