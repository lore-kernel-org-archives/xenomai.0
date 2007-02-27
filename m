Message-ID: <45E40448.5050107@domain.hid>
Date: Tue, 27 Feb 2007 11:13:28 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Adeos-main] Scheduling of different domains in Adeos
References: <45E15BC1.2000303@domain.hid>
	<45E161AA.9070005@domain.hid>
	<45E2FAB3.2000305@domain.hid>
	<45E3116E.70402@domain.hid>
	<45E3E323.7060209@domain.hid>
In-Reply-To: <45E3E323.7060209@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigAFA1D84053E5C0AED24B210F"
Sender: jan.kiszka@domain.hid
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Markus.Franke@domain.hid
Cc: adeos-main@gna.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigAFA1D84053E5C0AED24B210F
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Markus Franke wrote:
> Jan Kiszka wrote:
>> See above: each domain (which may contain an OS) has a certain priorit=
y,
>> and the one with the highest priority which has events pending gets th=
e
>> CPU. That's what the Adeos/I-pipe patch does on event arrival or domai=
n
>> suspension.
>=20
> Ok, this I know already.
>=20
>> Adeos doesn't do full CPU virtualisation. Therefore, the domains must
>> cooperate on those resources (memory management, FPU, etc.) that aren'=
t
>> switched by the nano-kernel. Adeos is not qemu or kvm, if this is what=

>> you have in mind.
>=20
> So if you want to get working more than one operating system, each
> embodied in it's own domain, you have to adapt the operating systems in=

> order to get also some kind of CPU virtualization. But these changes ar=
e
> not part of the Adeos-Patches for the Linux kernel, right?

They are included as far as Linux as root domain is concerned, i.e. the
lowest prioritised domain, hosting the whole stack.

>=20
> Has anybody ever tried to set up a system with let's say two Linux
> kernels working on top of Adeos, simultaneously?

Don't know, but I also don't think so. There is still quite a difference
between stacking Linux and Xenomai on top of Adeos (with Linux as root).
Xenomai was built with the constraints of running cooperatively on top
of Linux already in mind.

Jan



--------------enigAFA1D84053E5C0AED24B210F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFF5ARIniDOoMHTA+kRAhe1AKCBN12MB1ajkf/IE7hjJUrl7QeKGgCfZ7w/
cnfaf9wQQCvyubP7x4xDHF0=
=r6pj
-----END PGP SIGNATURE-----

--------------enigAFA1D84053E5C0AED24B210F--

