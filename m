Message-ID: <4729AED3.20200@domain.hid>
Date: Thu, 01 Nov 2007 11:47:47 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <47279853.9050704@domain.hid>
In-Reply-To: <47279853.9050704@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigDFD35C46E90CEC1FFB397D6F"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] Xenomai loading module error when running
	xero-test
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Dennis Nguyen <dennisnguy@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigDFD35C46E90CEC1FFB397D6F
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Dennis Nguyen wrote:
> Hello,
> I'm using linux kernel i386 2.6.20.10, xenomai 2.4-rc5,=20
> adeos-ipipe-2.6.20-i386-1.10.10.patch.
> I got errors when running xenoo-test:
> FATAL: Error inserting xeno_nucleus=20
> (/lib/modules/2.6.20.10/kernel/kernel/xenomai/nucleus/xeno_nucleus.ko):=
=20
> No such device

Please have a look at the kernel messaged (e.g. via dmesg), then follow
the suggestions given there. I would bet it's a local APIC configuration
issue...

Jan


--------------enigDFD35C46E90CEC1FFB397D6F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD4DBQFHKa7TniDOoMHTA+kRAtMSAJ44Teg/9XpmNQkwNuJOx55/+bUfcQCYiT24
Hsm5ijMh8rbXjZ1FBx7j4w==
=LkfN
-----END PGP SIGNATURE-----

--------------enigDFD35C46E90CEC1FFB397D6F--

