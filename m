Message-ID: <47DD4FDA.8020105@domain.hid>
Date: Sun, 16 Mar 2008 17:50:34 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <47DD3BF9.2@domain.hid> <47DD3FB4.5080305@domain.hid>
	<47DD424A.7040006@domain.hid> <47DD47F0.5020003@domain.hid>
	<47DD4C70.2040208@domain.hid> <47DD4E1F.9050400@domain.hid>
In-Reply-To: <47DD4E1F.9050400@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig6B111DFFE0920FC751D0997D"
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
--------------enig6B111DFFE0920FC751D0997D
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Philippe Gerum wrote:
> Jan Kiszka wrote:
>> Philippe Gerum wrote:
>>> Jan Kiszka wrote:
>>>> Philippe Gerum wrote:
>>>>> Jan Kiszka wrote:
>>>>>> Hi,
>>>>>>
>>>>>> doesn't this patch [1] have some relevance for us as well? As we u=
se
>>>>>> xnarch_remap_io_page_range also for non-IO memory, I'm hesitating =
to
>>>>>> suggest that we apply this unconditionally at xnarch level. Ideas =
welcome.
>>>>>>
>>>>> Yes, I think it makes a lot of sense on powerpc at least, since doi=
ng so will
>>>>> set the PAGE_GUARDED bit as well, and we obviously want to avoid an=
y
>>>>> out-of-order access of I/O memory.
>>>>>
>>>>> (I don't see the reason to force the VM_RESERVED and VM_IO on the v=
ma though,
>>>>> since remap_pfn_range will do it anyway.)
>>>> No, I was talking about cases where we may pass kmalloc'ed memory to=

>>>> xnarch_remap_io_page_range. In that case, caching and out-of-order
>>>> access may be desired for performance reasons.
>>>>
>>> xnarch_remap_io_page_range is intended for I/O memory only, some assu=
mptions are
>>> made on this. rtdm_mmap_buffer() should be fixed; it would be much be=
tter to
>>> define another internal interface at xnarch level to specifically per=
form
>>> kmalloc mapping.
>> Yeah, probably. But I think the issue is not just limited to RTDM. The=

>> xnheap can be kmalloc-hosted as well.
>>
>=20
> This one is used with DMA memory. What I would suggest, is something li=
ke this:
>=20
> --- ksrc/skins/rtdm/drvlib.c	(revision 3590)
> +++ ksrc/skins/rtdm/drvlib.c	(working copy)
> @@ -1738,9 +1738,12 @@
>  		}
>  		return 0;
>  	} else
> -#endif /* CONFIG_MMU */
>  		return xnarch_remap_io_page_range(vma, maddr, paddr,
>  						  size, PAGE_SHARED);
> +#else
> +	return xnarch_remap_kmem_page_range(vma, maddr, paddr,
> +					    size, PAGE_SHARED);
> +#endif /* CONFIG_MMU */
>  }
>=20
>  static struct file_operations rtdm_mmap_fops =3D {
>=20
>=20
> I.e. split the cases where MMU is absent from the one where MMU is ther=
e but we
> come from rtdm_iomap_to_user.

Makes no sense to me yet. With CONFIG_MMU we have 3 cases, not just two,
no? We have to use mmap_data->src_paddr to tell kmem_page apart from
io_page.

And we do not need io_page at all in the !CONFIG_MMU case?

Jan


--------------enig6B111DFFE0920FC751D0997D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.4-svn0 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFH3U/dniDOoMHTA+kRAr9aAJ9ZX+ppN4KkG0RbsS8KGjU6frEyJQCfQ9Yt
3HJtXRP4VJZv5FaD6w9gYIQ=
=B7qd
-----END PGP SIGNATURE-----

--------------enig6B111DFFE0920FC751D0997D--

