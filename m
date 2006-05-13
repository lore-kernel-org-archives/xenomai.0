Message-ID: <44658F8A.6090709@domain.hid>
Date: Sat, 13 May 2006 09:49:30 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Xenomai in a VM
References: <6ee4c8380605012208xf8f9bb6p5eb542d8fb8da567@domain.hid>
	<4458949A.10606@domain.hid>
In-Reply-To: <4458949A.10606@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig688D9BD62391BC45109B768E"
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
To: "Brian L." <bluczkie@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig688D9BD62391BC45109B768E
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Jan Kiszka wrote:
> Brian L. wrote:
>> Has anyone tried running Xenomai inside a virtual machine (i.e. Qemu,
>> Parallels, VMWare, bochs, simics)? Is there any reason to expect this
>> to fail? In theory, the virtualization software should appear as a
>> vanilla x86 to the OS running inside of it, but I'd imagine xenomai
>> could potentially tweak bits of the cpu/architecture that are not as
>> supported by the virtualization software .
>>
>> Of course, I wouldn't expect any real-time characteristics or
>> performance to speak of. This would be for development/testing only.
>>
>> Thoughts?
>=20
> Should work, just give it a try. We once started to play with our full
> embedded distro under bochs, but I do not recall right now how far we
> came - need to check with the person who actually did the work.
>=20

Meanwhile I'm running a VM myself: QEMU. No problems, it just works
without any trick, also with RT software or with kgdb attached to the
Xenomai kernel.

Jan


--------------enig688D9BD62391BC45109B768E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEZY+KniDOoMHTA+kRAu/RAJ463HTzugwfHHDacmfhfGG+UnhAiwCfSzTg
GemZ0ur8GQXh9xA3Obc81q4=
=B7pW
-----END PGP SIGNATURE-----

--------------enig688D9BD62391BC45109B768E--

