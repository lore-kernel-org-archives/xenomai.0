Message-ID: <47DD424A.7040006@domain.hid>
Date: Sun, 16 Mar 2008 16:52:42 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <47DD3BF9.2@domain.hid> <47DD3FB4.5080305@domain.hid>
In-Reply-To: <47DD3FB4.5080305@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigB662737B1849B0EB6D7B466A"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] pgprot_noncached for io-remapping?
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: rpm@xenomai.org
Cc: Xenomai-core@domain.hid

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigB662737B1849B0EB6D7B466A
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Philippe Gerum wrote:
> Jan Kiszka wrote:
>> Hi,
>>
>> doesn't this patch [1] have some relevance for us as well? As we use
>> xnarch_remap_io_page_range also for non-IO memory, I'm hesitating to
>> suggest that we apply this unconditionally at xnarch level. Ideas welc=
ome.
>>
>=20
> Yes, I think it makes a lot of sense on powerpc at least, since doing s=
o will
> set the PAGE_GUARDED bit as well, and we obviously want to avoid any
> out-of-order access of I/O memory.
>=20
> (I don't see the reason to force the VM_RESERVED and VM_IO on the vma t=
hough,
> since remap_pfn_range will do it anyway.)

No, I was talking about cases where we may pass kmalloc'ed memory to
xnarch_remap_io_page_range. In that case, caching and out-of-order
access may be desired for performance reasons.

Jan


--------------enigB662737B1849B0EB6D7B466A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.4-svn0 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFH3UJKniDOoMHTA+kRApYeAJ9zWjaYJEMb7gYoa5yb1e1QvXw4RACfW/lz
Cw7gK8AutQmgtXrQK1hRs3w=
=Lmqs
-----END PGP SIGNATURE-----

--------------enigB662737B1849B0EB6D7B466A--

