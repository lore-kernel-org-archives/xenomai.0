Message-ID: <4513A5D0.3040507@domain.hid>
Date: Fri, 22 Sep 2006 10:58:56 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] 	[PATCH, RFC] Make ioremap'ed memory available
	through	rtdm_mmap_to_user()
References: <1158337583.13530.20.camel@domain.hid>	
	<450AD766.3000307@domain.hid>
	<1158613987.31164.9.camel@domain.hid>	
	<45100DF6.8030209@domain.hid>
	<1158914149.14421.10.camel@domain.hid>
In-Reply-To: <1158914149.14421.10.camel@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig0452E61F49394DD69D176D8C"
Sender: jan.kiszka@domain.hid
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Stelian Pop <stelian.pop@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig0452E61F49394DD69D176D8C
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Stelian Pop wrote:
> [Sorry for the delay, I was quite busy those days and unable to test th=
e
> patch...]
>=20
> Le mardi 19 septembre 2006 =E0 17:34 +0200, Jan Kiszka a =E9crit :
>>> Or maybe we should lower the API level a little bit, and let the user=

>>> specify the physical address of the mapping instead of the virtual
>>> one....
>> How would this help? You still need the virtual address for VMA blocks=

>> in order to collect the pages.
>=20
> Actualy we need both the virtual address (for vmalloc case) and the
> physical address (for ioremap case).
>=20
>> +    if (mmap_data->mem_type =3D=3D RTDM_MEMTYPE_VMALLOC) {
> [...]
>=20
> This still won't work because for RTDM_MEMTYPE_IOREMAP
> virt_to_phys((void *)vaddr) doesn't return the physical address.
>=20
> So we still need to either:
> 	a) walk the vmlist struct to find out the needed vm->phys_addr (which
> will probably won't work in 2.4, or even in earlier 2.6 kernels)

Sounds fragile, indeed.

>=20
> 	b) pass both the physical and the virtual adresses in the
> rtdm_mmap_to_user prototype (the physical address would be used only
> when RTDM_MEMTYPE_IOREMAP is specified)

Hmm, a bit ugly, this long argument list.

>=20
> 	c) make 'src_addr' be a virtual address in some cases, and a physical
> address in ioremap case.

That's so far the cleanest solution in my eyes.

>=20
> 	d) make a special rtdm_mmap_iomem_to_user() function...

Also an option. Specifically, it wouldn't break the existing API... What
about rtdm_iomap_to_user? Would you like to work out a patch in this
direction?

Jan


--------------enig0452E61F49394DD69D176D8C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFE6XQniDOoMHTA+kRAqQlAKCCY2QmpxAW7tA5ZZdZcTf9hd959wCdHJcv
r8wca/UGr8dsIc9j5zVCOMA=
=2W3A
-----END PGP SIGNATURE-----

--------------enig0452E61F49394DD69D176D8C--

