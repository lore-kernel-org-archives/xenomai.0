Message-ID: <4458949A.10606@domain.hid>
Date: Wed, 03 May 2006 13:31:38 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Xenomai in a VM
References: <6ee4c8380605012208xf8f9bb6p5eb542d8fb8da567@domain.hid>
In-Reply-To: <6ee4c8380605012208xf8f9bb6p5eb542d8fb8da567@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigD1221302A07708862CCA7166"
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
--------------enigD1221302A07708862CCA7166
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Brian L. wrote:
> Has anyone tried running Xenomai inside a virtual machine (i.e. Qemu,
> Parallels, VMWare, bochs, simics)? Is there any reason to expect this
> to fail? In theory, the virtualization software should appear as a
> vanilla x86 to the OS running inside of it, but I'd imagine xenomai
> could potentially tweak bits of the cpu/architecture that are not as
> supported by the virtualization software .
>=20
> Of course, I wouldn't expect any real-time characteristics or
> performance to speak of. This would be for development/testing only.
>=20
> Thoughts?

Should work, just give it a try. We once started to play with our full
embedded distro under bochs, but I do not recall right now how far we
came - need to check with the person who actually did the work.

Anyway, RTAI used to run fine under ancient VMware, I do not see any
reason why this shouldn't work for Xenomai as well. If it breaks and
Xenomai crashes, please post the results. If your VM goes South - switch
to another product. ;)

Jan


--------------enigD1221302A07708862CCA7166
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEWJSaniDOoMHTA+kRAjyJAKCEeHUSht4jWXuZp6qH1iKMgIEBJACfQLDu
cAAP+bsRKQeyEdG150kswlM=
=0Tf7
-----END PGP SIGNATURE-----

--------------enigD1221302A07708862CCA7166--

