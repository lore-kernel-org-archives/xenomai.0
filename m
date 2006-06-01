Message-ID: <447F704B.10303@domain.hid>
Date: Fri, 02 Jun 2006 00:55:07 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] xnpod help
References: <39142.155.98.4.39.1149186052.squirrel@domain.hid>	<17535.18007.179715.207040@domain.hid>	<447F49C8.4090609@domain.hid>
	<39455.155.98.4.39.1149195102.squirrel@domain.hid>
	<447F5935.4090105@domain.hid>
	<47190.155.98.4.39.1149199741.squirrel@domain.hid>
In-Reply-To: <47190.155.98.4.39.1149199741.squirrel@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig3918F19E4B9C266168107132"
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
To: Brandt Erickson <brandt@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig3918F19E4B9C266168107132
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Brandt Erickson wrote:
>> Ok, things get clearer. But why a kernel module? Are you *that* short =
on
>> CPU cycles?
>=20
> The reason why I'm trying to develop a kernel-space application is not =
for
> latency issues but because I need to be in kernel-space to read/write
> to/from my DAC.

ioperm() or iopl() not applicable?

> Is the IPC between kernel-space realtime and user-space
> non-realtime that much more difficult the user-space realtime to
> user-space non-realtime?  I've familiar with regular user-space IPC usi=
ng
> condition variables, semaphores, and shared memory, so if it's fairly
> similar, I'm hoping that won't be a problem.

That's feasible as well, and the API is identical. It's just the
difference of writing two separate applications instead of a single
multi-threaded one plus the additional effort for dealing with modules
(building, loading, unloading).

Jan


--------------enig3918F19E4B9C266168107132
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFEf3BLniDOoMHTA+kRAjRuAJ9qnwiE2bsPHXNMliRDVTGqvIvjrQCdEHNO
PWUaYgJsGNpNfv6hk5qm29Y=
=ZlX1
-----END PGP SIGNATURE-----

--------------enig3918F19E4B9C266168107132--

