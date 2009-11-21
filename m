Message-ID: <4B07A815.6020309@domain.hid>
Date: Sat, 21 Nov 2009 09:43:01 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <6FCCA913376DD7488F4139A4D11B8F48FD1044@domain.hid>	<4AF99CAD.9070105@domain.hid>	<6FCCA913376DD7488F4139A4D11B8F48FD107D@troe2k1.cs.myharris.net>	<4AF9AD44.10000@domain.hid>	<6FCCA913376DD7488F4139A4D11B8F48FD1085@domain.hid>	<4AF9B6F2.9040206@domain.hid>	<6FCCA913376DD7488F4139A4D11B8F48FD10A9@domain.hid>	<4AF9D976.4020701@domain.hid>	<6FCCA913376DD7488F4139A4D11B8F48FD1129@domain.hid>	<4AFAC4E1.1090109@domain.hid>	<6FCCA913376DD7488F4139A4D11B8F48FD17F8@domain.hid>	<4B0423EF.9030307@domain.hid>	<6FCCA913376DD7488F4139A4D11B8F48FD187B@troe2k1.cs.myharris.net>	<4B0670FC.4080907@domain.hid>
	<6FCCA913376DD7488F4139A4D11B8F48FD1B53@domain.hid>
In-Reply-To: <6FCCA913376DD7488F4139A4D11B8F48FD1B53@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig194046545AFCC47D16B38F1C"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] [PATCH] rtdm: Extend rtdm_iomap_to_user to map
 phys addr > 4G
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: "Herrera-Bendezu, Luis" <lherrera@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig194046545AFCC47D16B38F1C
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Herrera-Bendezu, Luis wrote:
> rtdm_iomap_to_user does not handle I/O memory mapping of
> physical I/O address grater than 4 GB.
>=20
> This patch changes the src_addr argument and underlying
> code to handle this case.
>=20
> Signed-off-by: Luis Herrera-Bendezu <lherrera@domain.hid>
                                                ^^^^^^^^^^^
Something made your mail address unreadable. This is pointless (your
address is already archived on this list). Moreover, we need a proper
signature as a declaration that you are authorized to contribute this
patch. One may argue that the patch is trivial and not "copyrightable",
but we better avoid being sloppy even in that case.

Besides this, the patch is unfortunately line wrap. Make sure that
wrapping is switched off or use a different mailer.

Thanks,
Jan

> ---
> diff --git a/include/asm-generic/system.h b/include/asm-generic/system.=
h
> index 020e763..f2a9424 100644
> --- a/include/asm-generic/system.h
> +++ b/include/asm-generic/system.h
> @@ -417,7 +417,7 @@ static inline int xnarch_remap_vm_page(struct
> vm_area_struct *vma,
>  static inline int xnarch_remap_io_page_range(struct file *filp,
>  					     struct vm_area_struct *vma,
>  					     unsigned long from,
> -					     unsigned long to,
> +					     phys_addr_t to,
>  					     unsigned long size,
>  					     pgprot_t prot)
>  {
> diff --git a/include/asm-generic/wrappers.h
> b/include/asm-generic/wrappers.h
> index 943ed34..239eb93 100644
> --- a/include/asm-generic/wrappers.h
> +++ b/include/asm-generic/wrappers.h
> @@ -400,4 +400,8 @@ static inline int wrap_raise_cap(int cap)
>  }
>  #endif /* LINUX_VERSION_CODE >=3D 2.6.29 */
> =20
> +#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,28)
> +typedef unsigned long phys_addr_t;
> +#endif
> +
>  #endif /* _XENO_ASM_GENERIC_WRAPPERS_H */
> diff --git a/include/rtdm/rtdm_driver.h b/include/rtdm/rtdm_driver.h
> index 3026aff..0340de8 100644
> --- a/include/rtdm/rtdm_driver.h
> +++ b/include/rtdm/rtdm_driver.h
> @@ -1168,7 +1168,7 @@ int rtdm_mmap_to_user(rtdm_user_info_t *user_info=
,
>  		      struct vm_operations_struct *vm_ops,
>  		      void *vm_private_data);
>  int rtdm_iomap_to_user(rtdm_user_info_t *user_info,
> -		       unsigned long src_addr, size_t len,
> +		       phys_addr_t src_addr, size_t len,
>  		       int prot, void **pptr,
>  		       struct vm_operations_struct *vm_ops,
>  		       void *vm_private_data);
> diff --git a/ksrc/skins/rtdm/drvlib.c b/ksrc/skins/rtdm/drvlib.c
> index 65c630f..8922689 100644
> --- a/ksrc/skins/rtdm/drvlib.c
> +++ b/ksrc/skins/rtdm/drvlib.c
> @@ -1765,7 +1765,7 @@ void rtdm_nrtsig_pend(rtdm_nrtsig_t *nrt_sig);
>  #if defined(CONFIG_XENO_OPT_PERVASIVE) || defined(DOXYGEN_CPP)
>  struct rtdm_mmap_data {
>  	void *src_vaddr;
> -	unsigned long src_paddr;
> +	phys_addr_t src_paddr;
>  	struct vm_operations_struct *vm_ops;
>  	void *vm_private_data;
>  };
> @@ -1773,14 +1773,15 @@ struct rtdm_mmap_data {
>  static int rtdm_mmap_buffer(struct file *filp, struct vm_area_struct
> *vma)
>  {
>  	struct rtdm_mmap_data *mmap_data =3D filp->private_data;
> -	unsigned long vaddr, paddr, maddr, size;
> +	unsigned long vaddr, maddr, size;
> +	phys_addr_t paddr;
>  	int ret;
> =20
>  	vma->vm_ops =3D mmap_data->vm_ops;
>  	vma->vm_private_data =3D mmap_data->vm_private_data;
> =20
>  	vaddr =3D (unsigned long)mmap_data->src_vaddr;
> -	paddr =3D (unsigned long)mmap_data->src_paddr;
> +	paddr =3D mmap_data->src_paddr;
>  	if (!paddr)
>  		/* kmalloc memory */
>  		paddr =3D virt_to_phys((void *)vaddr);
> @@ -1982,7 +1983,7 @@ EXPORT_SYMBOL(rtdm_mmap_to_user);
>   * Rescheduling: possible.
>   */
>  int rtdm_iomap_to_user(rtdm_user_info_t *user_info,
> -		       unsigned long src_addr, size_t len,
> +		       phys_addr_t src_addr, size_t len,
>  		       int prot, void **pptr,
>  		       struct vm_operations_struct *vm_ops,
>  		       void *vm_private_data)
> ---



--------------enig194046545AFCC47D16B38F1C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAksHqB8ACgkQitSsb3rl5xT5QwCfaxAA+xmZmEE5EVNgcBi0KZKO
IsEAoLPhssgJgoq7iDxmdLFt43vbx5i9
=hAID
-----END PGP SIGNATURE-----

--------------enig194046545AFCC47D16B38F1C--

