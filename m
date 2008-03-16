Message-ID: <47DD5EEB.30609@domain.hid>
Date: Sun, 16 Mar 2008 18:54:51 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <47DD3BF9.2@domain.hid> <47DD3FB4.5080305@domain.hid>
	<47DD424A.7040006@domain.hid> <47DD47F0.5020003@domain.hid>
	<47DD4C70.2040208@domain.hid> <47DD4E1F.9050400@domain.hid>
	<47DD4FDA.8020105@domain.hid> <47DD53EF.9070302@domain.hid>
	<47DD55CF.80903@domain.hid> <47DD5A2C.3050606@domain.hid>
In-Reply-To: <47DD5A2C.3050606@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigF50886C51ADAB22C0D314D08"
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
--------------enigF50886C51ADAB22C0D314D08
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Philippe Gerum wrote:
> Jan Kiszka wrote:
>> Philippe Gerum wrote:
>>> Jan Kiszka wrote:
>>>> Philippe Gerum wrote:
>>>>> Jan Kiszka wrote:
>>>>>> Philippe Gerum wrote:
>>>>>>> Jan Kiszka wrote:
>>>>>>>> Philippe Gerum wrote:
>>>>>>>>> Jan Kiszka wrote:
>>>>>>>>>> Hi,
>>>>>>>>>>
>>>>>>>>>> doesn't this patch [1] have some relevance for us as well? As =
we use
>>>>>>>>>> xnarch_remap_io_page_range also for non-IO memory, I'm hesitat=
ing to
>>>>>>>>>> suggest that we apply this unconditionally at xnarch level. Id=
eas welcome.
>>>>>>>>>>
>>>>>>>>> Yes, I think it makes a lot of sense on powerpc at least, since=
 doing so will
>>>>>>>>> set the PAGE_GUARDED bit as well, and we obviously want to avoi=
d any
>>>>>>>>> out-of-order access of I/O memory.
>>>>>>>>>
>>>>>>>>> (I don't see the reason to force the VM_RESERVED and VM_IO on t=
he vma though,
>>>>>>>>> since remap_pfn_range will do it anyway.)
>>>>>>>> No, I was talking about cases where we may pass kmalloc'ed memor=
y to
>>>>>>>> xnarch_remap_io_page_range. In that case, caching and out-of-ord=
er
>>>>>>>> access may be desired for performance reasons.
>>>>>>>>
>>>>>>> xnarch_remap_io_page_range is intended for I/O memory only, some =
assumptions are
>>>>>>> made on this. rtdm_mmap_buffer() should be fixed; it would be muc=
h better to
>>>>>>> define another internal interface at xnarch level to specifically=
 perform
>>>>>>> kmalloc mapping.
>>>>>> Yeah, probably. But I think the issue is not just limited to RTDM.=
 The
>>>>>> xnheap can be kmalloc-hosted as well.
>>>>>>
>>>>> This one is used with DMA memory. What I would suggest, is somethin=
g like this:
>>>>>
>>>>> --- ksrc/skins/rtdm/drvlib.c	(revision 3590)
>>>>> +++ ksrc/skins/rtdm/drvlib.c	(working copy)
>>>>> @@ -1738,9 +1738,12 @@
>>>>>  		}
>>>>>  		return 0;
>>>>>  	} else
>>>>> -#endif /* CONFIG_MMU */
>>>>>  		return xnarch_remap_io_page_range(vma, maddr, paddr,
>>>>>  						  size, PAGE_SHARED);
>>>>> +#else
>>>>> +	return xnarch_remap_kmem_page_range(vma, maddr, paddr,
>>>>> +					    size, PAGE_SHARED);
>>>>> +#endif /* CONFIG_MMU */
>>>>>  }
>>>>>
>>>>>  static struct file_operations rtdm_mmap_fops =3D {
>>>>>
>>>>>
>>>>> I.e. split the cases where MMU is absent from the one where MMU is =
there but we
>>>>> come from rtdm_iomap_to_user.
>>>> Makes no sense to me yet. With CONFIG_MMU we have 3 cases, not just =
two,
>>>> no? We have to use mmap_data->src_paddr to tell kmem_page apart from=

>>>> io_page.
>>> That's what the patch I sent right after this one does.
>> Nope, vaddr can be NULL in both cases, only paddr is differentiating.
>>
>> This one should do what we need:
>>
>> Index: ksrc/skins/rtdm/drvlib.c
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> --- ksrc/skins/rtdm/drvlib.c	(Revision 3594)
>> +++ ksrc/skins/rtdm/drvlib.c	(Arbeitskopie)
>> @@ -1739,8 +1739,12 @@ static int rtdm_mmap_buffer(struct file=20
>>  		return 0;
>>  	} else
>>  #endif /* CONFIG_MMU */
>> +	if (mmap_data->src_paddr)
>>  		return xnarch_remap_io_page_range(vma, maddr, paddr,
>>  						  size, PAGE_SHARED);
>> +	else
>> +		return xnarch_remap_kmem_page_range(vma, maddr, paddr,
>> +						    size, PAGE_SHARED);
>>  }
>> =20
>>  static struct file_operations rtdm_mmap_fops =3D {
>>
>>
>=20
> Ok. So if that's fine with you, I think we should merge that because th=
e current
> situation is error-prone.

Will do, patches for 2.3..trunk in stand-by for now. Do you have a
xnarch_remap_kmem_page_range definition at hand?

>=20
> For the time being, I've defined a remap_kmem wrapper which mirrors the=
 previous
> actions of the remap_io one, before I fixed the latter with the noncach=
e
> protection bits. At least we should get the same behaviour than previou=
sly wrt
> to rtdm_mmap_buffer. This leaves some time to think about the kmem mapp=
ing modes
> without breaking the current situation, but they should be correct now.=

>=20

OK.

Jan


--------------enigF50886C51ADAB22C0D314D08
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.4-svn0 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFH3V7uniDOoMHTA+kRAjimAJ9wSrm7YQRZ1kfPJjR1+kaalkRV0QCfU+f1
LvULSHbKVTCeUiumeCvsR/Q=
=niDt
-----END PGP SIGNATURE-----

--------------enigF50886C51ADAB22C0D314D08--

