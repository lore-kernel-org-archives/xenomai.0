Message-ID: <491FF8C3.7080001@domain.hid>
Date: Sun, 16 Nov 2008 11:41:07 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <491F6162.2090301@domain.hid>
In-Reply-To: <491F6162.2090301@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig25407B8B4692488E5430A273"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] [patch] fault mmaped area upon rtdm_mmap_to_user.
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
Cc: Xenomai core <Xenomai-core@domain.hid>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig25407B8B4692488E5430A273
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gilles Chanteperdrix wrote:
> Hi Jan,
>=20
> I have just commited a modification of the nucleus heap which allows
> faulting newly mapped pages. However, I noticed that we should modify
> rtdm_mmap_to_user as in the attached patch.

No general concerns, please just provide an empty xnarch_fault_range as
default to avoid the #ifdefs. Is this an ARM-only issue?

>=20
> At this chance, I also noticed that there is no way to ask for uncached=

> memory to rtdm_mmap_to_user, how do you think we should change
> rtdm_mmap_to_user to allow this?

Look like we would have to introduce a 'flags' argument to
rtdm_mmap_to_user. That's 2.5 material, where we'll change a few RTDM
APIs anyway.

Jan

>=20
> Regards.
>=20
> Index: ksrc/skins/rtdm/drvlib.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- ksrc/skins/rtdm/drvlib.c	(revision 4390)
> +++ ksrc/skins/rtdm/drvlib.c	(working copy)
> @@ -1781,6 +1781,7 @@ static int rtdm_mmap_buffer(struct file
>  {
>  	struct rtdm_mmap_data *mmap_data =3D filp->private_data;
>  	unsigned long vaddr, paddr, maddr, size;
> +	int ret;
>=20
>  	vma->vm_ops =3D mmap_data->vm_ops;
>  	vma->vm_private_data =3D mmap_data->vm_private_data;
> @@ -1810,15 +1811,25 @@ static int rtdm_mmap_buffer(struct file
>  			vaddr +=3D PAGE_SIZE;
>  			mapped_size +=3D PAGE_SIZE;
>  		}
> -		return 0;
> +#ifdef xnarch_fault_range
> +		xnarch_fault_range(vma);
> +#endif /* xnarch_fault_range */
> +		ret =3D 0;
>  	} else
>  #endif /* CONFIG_MMU */
>  	if (mmap_data->src_paddr)
> -	  	return xnarch_remap_io_page_range(filp, vma, maddr, paddr,
> -						  size, PAGE_SHARED);
> -	else
> -		return xnarch_remap_kmem_page_range(vma, maddr, paddr,
> -						    size, PAGE_SHARED);
> +	  	ret =3D xnarch_remap_io_page_range(filp, vma, maddr, paddr,
> +						 size, PAGE_SHARED);
> +	else {
> +		ret =3D xnarch_remap_kmem_page_range(vma, maddr, paddr,
> +						   size, PAGE_SHARED);
> +#ifdef xnarch_fault_range
> +		if (!ret)
> +			xnarch_fault_range(vma);
> +#endif /* xnarch_fault_range */
> +	}
> +
> +	return ret;
>  }
>=20
>  static struct file_operations rtdm_mmap_fops =3D {
>=20
>=20



--------------enig25407B8B4692488E5430A273
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAkkf+MMACgkQniDOoMHTA+kLpwCeJI4tjYRnxmnZ/jkI8ajLjC88
hAAAnAwOPmBDMEzqtwA3h2c0pB+OrcOB
=1ZX4
-----END PGP SIGNATURE-----

--------------enig25407B8B4692488E5430A273--

