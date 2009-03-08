Message-ID: <49B3D4C9.2000801@domain.hid>
Date: Sun, 08 Mar 2009 15:23:05 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <49B3A126.6000602@domain.hid> <49B3CAFF.6090406@domain.hid>
In-Reply-To: <49B3CAFF.6090406@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig4070869A7B9A6C2975A53DB3"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] Watchdog / immediate Linux signal delivery
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig4070869A7B9A6C2975A53DB3
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Gilles Chanteperdrix wrote:
> Jan Kiszka wrote:
>> Linux (e.g. via xnpod_suspend_thread(<cpu-hog>). Unfortunately, there =
is
>> no way to force a shadow thread into secondary mode to handle pending
>> Linux signals unless that thread issues a syscall once in a while. And=

>> that raises the question if we shouldn't improve this as well while we=

>> are on it.
>>
>> Granted, non-broken Xenomai user space threads always issue frequent
>> syscalls, otherwise the system would starve (and the watchdog would co=
me
>> around). On the other hand, delaying signals till syscall prologues is=

>> different from plain Linux behaviour...
>>
>> Comments, ideas?
>=20
> We discussed the issue of having a way to force threads to relax with
> Philippe, and we both had patches to make this work. However, the issue=

> we recently had with the emulated iret on x86 makes me think that we ca=
n
> not relax at any point in time, the code surrounding the relax has to b=
e
> made to allow a relax to occur.
>=20

Those issues were fixed. If we have similar problems around
__ipipe_handle_irq (I would expect the relaxation to take place in
xnintr_*_handler), then they should be fixed as well.

The problem is that I currently do not see any other way of cleanly
terminating or debugging some Xenomai user space thread doing "while
(1);" (or any more complicated variation).

Jan


--------------enig4070869A7B9A6C2975A53DB3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAkmz1M4ACgkQniDOoMHTA+mAXgCePHIcXYAQ7JByeyw03Ai6qoZk
kBsAn2xxM9THhZ8PS7+JXVr1BXqqbhk4
=XFY0
-----END PGP SIGNATURE-----

--------------enig4070869A7B9A6C2975A53DB3--

