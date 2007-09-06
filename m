Message-ID: <46E071E6.8030807@domain.hid>
Date: Thu, 06 Sep 2007 23:32:22 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <E5E9C6CC7DC8844A8DA7A9EFE7B5350E08F1F9@domain.hid>
In-Reply-To: <E5E9C6CC7DC8844A8DA7A9EFE7B5350E08F1F9@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig1BB9ACE3BF950358264873AF"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] rtdm_iomap_to_user() with PowerPC
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: "Markus Osterried (BA/EDD)" <markus.osterried@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig1BB9ACE3BF950358264873AF
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Markus Osterried (BA/EDD) wrote:
> Hello,
>=20
> I want to use rtdm_iomap_to_user() to map our device registers to user
> space.
> But this doesn't work, our application just crashes when I read from th=
e
> mapped registers.
>=20
> When I insert the line
>=20
> 	vma->vm_page_prot =3D phys_mem_access_prot(filp,
> paddr>>PAGE_SHIFT, size, vma->vm_page_prot);
>=20
> in rtdm_mmap_buffer() just before calling xnarch_remap_io_page_range()
> it works fine.

[hint: using diff -up helps the reader to quickly localise your changes.]=


> This is just like it is done in /drivers/char/mem.c and in
> /drivers/video/fbmem.c.
>=20
> But I think this is architecture and kernel version dependent and I
> don't know whether rtdm_mmap_buffer() is the right place.
> I use Xenomai 2.3.1 and Linux 2.6.18 with PowerPC CPU.
> What is the best solution? Everyone else seen this problem?

Providing phys_mem_access_prot() services for
xnarch_remap_io_page_range() looks like it is actually required -
practically at least for PPC, but I can't tell immediately if there
aren't other yet unnoticed side effect of skipping it.

Hmm, can we extend xnarch_remap_io_page_range()/
wrap_remap_io_page_range() to take care of this as well? Suggestions
(ie. patches) welcome!

Jan


--------------enig1BB9ACE3BF950358264873AF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFG4HHmniDOoMHTA+kRAt2HAJ40xkX5s4xklz9GY7ouuRjZLZaQjwCfV/t7
jO1GDVvvs4HbKGzhYhypVoQ=
=99zq
-----END PGP SIGNATURE-----

--------------enig1BB9ACE3BF950358264873AF--

