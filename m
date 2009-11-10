Message-ID: <4AF9D976.4020701@domain.hid>
Date: Tue, 10 Nov 2009 22:21:58 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <6FCCA913376DD7488F4139A4D11B8F48FD1044@domain.hid>	<4AF99CAD.9070105@domain.hid>	<6FCCA913376DD7488F4139A4D11B8F48FD107D@troe2k1.cs.myharris.net>	<4AF9AD44.10000@domain.hid>	<6FCCA913376DD7488F4139A4D11B8F48FD1085@domain.hid>	<4AF9B6F2.9040206@domain.hid>
	<6FCCA913376DD7488F4139A4D11B8F48FD10A9@domain.hid>
In-Reply-To: <6FCCA913376DD7488F4139A4D11B8F48FD10A9@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigABE993F9B20C5A20A0F6DBB2"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] rtdm_iomap_to_user with phys addr > 4GB
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: "Herrera-Bendezu, Luis" <lherrera@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigABE993F9B20C5A20A0F6DBB2
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Herrera-Bendezu, Luis wrote:
> =20
>=20
>> -----Original Message-----
>> From: Jan Kiszka [mailto:jan.kiszka@domain.hid
>> Sent: Tuesday, November 10, 2009 1:55 PM
>> To: Herrera-Bendezu, Luis
>> Cc: xenomai@xenomai.org
>> Subject: Re: rtdm_iomap_to_user with phys addr > 4GB
>>
>>
>> Herrera-Bendezu, Luis wrote:
>>> =20
>>>
>>>> -----Original Message-----
>>>> From: Jan Kiszka [mailto:jan.kiszka@domain.hid
>>>> Sent: Tuesday, November 10, 2009 1:13 PM
>>>> To: Herrera-Bendezu, Luis
>>>> Cc: xenomai@xenomai.org
>>>> Subject: Re: rtdm_iomap_to_user with phys addr > 4GB
>>>>
>>>>
>>>> Herrera-Bendezu, Luis wrote:
>>>>> =20
>>>>>
>>>>>> -----Original Message-----
>>>>>> From: Jan Kiszka [mailto:jan.kiszka@domain.hid
>>>>>> Sent: Tuesday, November 10, 2009 12:03 PM
>>>>>> To: Herrera-Bendezu, Luis
>>>>>> Cc: xenomai@xenomai.org
>>>>>> Subject: Re: rtdm_iomap_to_user with phys addr > 4GB
>>>>>>
>>>>>>
>>>>>> Herrera-Bendezu, Luis wrote:
>>>>>>> Hello,
>>>>>>>
>>>>>>> I am writing an RTDM driver to replace one that uses UIO.=20
>>>> The device
>>>>>>> resides in a physical address > 4 GB on a PPC440EPx. The=20
>> UIO could
>>>>>>> not handle this address so I made a proposal to address it,=20
>>>>>> details at:
>> http://lists.ozlabs.org/pipermail/linuxppc-dev/2009-April/070097.html
>>>>>>> Function rtdm_iomap_to_user() has same issue with the=20
>> physical I/O
>>>>>>> address
>>>>>>>    unsigned long src_addr
>>>>>>>
>>>>>>> I am new to Xenomai and would like to get some ideas on=20
>>>> how to solve
>>>>>>> this
>>>>>>> issue.
>>>>>> I think UIO as well as RTDM suffers from the same problem=20
>> here: The
>>>>>> kernel service used to remap the physical memory (remap_pfn_range)=

>>>>>> accepts unsigned long, not phys_addr_t. How is this=20
>>>> supposed to work?
>>>>>> Jan
>>>>>>
>>>>>> --=20
>>>>>> Siemens AG, Corporate Technology, CT SE 2
>>>>>> Corporate Competence Center Embedded Linux
>>>>>>
>>>>> Actually, remap_pfn_range() gets passed the physical address left
>>>>> shifted by PAGE_SIZE in both UIO and RTDM=20
>>>> (xnarch_remap_io_page_range,
>>>>> wrap_remap_io_page_range).
>>>> No, the target address is expressed in pages, the source in bytes.
>>>>
>>> That is true for rtdm_mmap_to_user but not for=20
>> rtdm_iomap_to_user. See
>>> how
>>> mmap_data struct is set in both functions.
>>        struct rtdm_mmap_data mmap_data =3D
>>                { NULL, src_addr, vm_ops, vm_private_data };
>>
>> with src_addr =3D "physical I/O address to be mapped", setting
>> mmap_data.src_paddr -- are you looking at different code?
>>
> No, that is the code.

But there is nothing shifted, the shifting takes place in Xenomai's wrapp=
er.

>> Besides this, the key is how remap_pfn_page interprets the source
>> address argument.
>>
> I had used UIO with success (as described in link above). The equivalen=
t
> code in UIO is (uio.c):
> static int uio_mmap_physical(struct vm_area_struct *vma)
> {
> 	struct uio_device *idev =3D vma->vm_private_data;
> 	int mi =3D uio_find_mem_index(vma);
> 	if (mi < 0)
> 		return -EINVAL;
>=20
> 	vma->vm_flags |=3D VM_IO | VM_RESERVED;
>=20
> 	vma->vm_page_prot =3D pgprot_noncached(vma->vm_page_prot);
>=20
> 	return remap_pfn_range(vma,
> 			       vma->vm_start,
> 			       idev->info->mem[mi].addr >> PAGE_SHIFT,
> 			       vma->vm_end - vma->vm_start,
> 			       vma->vm_page_prot);
> }
>=20
> where idev->info->mem[mi].addr, mem[.] is the list of mappable regions.=

> Note that for UIO, the user application needs to mmap these regions to
> user space. This is a step that is not needed on RTDM, right?

OK, now I got my mistake: Confused by the wrong argument names of our
wrap_remap_io_page_range (and probably others) I thought that the
destination is given as page number, not the source.

But before adding some fancy new service for this use case, I'd like to
understand how common it actually is (crazy embedded designs tend to pop
up and deprecate faster than such APIs...).

And what was the final conclusion on LKML? As far as I understood the
UIO maintainer, the proposal was rejected. Any different follow-ups on
this that I missed? Of course, if you have a special design you can
always patch your kernel and Xenomai to fit these special purposes. But
for upstream support, kernel or Xenomai, it requires a clean and
portable model.

Jan


--------------enigABE993F9B20C5A20A0F6DBB2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAkr52XoACgkQitSsb3rl5xQ8WQCgh+q0AAfvRs6cm/kWJS2edMYA
rNAAoI+shrCflEPIZCvkEQYOpwwh8q2/
=CIjc
-----END PGP SIGNATURE-----

--------------enigABE993F9B20C5A20A0F6DBB2--

