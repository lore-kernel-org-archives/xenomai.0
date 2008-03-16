Message-ID: <47DD4C70.2040208@domain.hid>
Date: Sun, 16 Mar 2008 17:36:00 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <47DD3BF9.2@domain.hid> <47DD3FB4.5080305@domain.hid>
	<47DD424A.7040006@domain.hid> <47DD47F0.5020003@domain.hid>
In-Reply-To: <47DD47F0.5020003@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigCC46E56F80FD3E1E61178547"
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
--------------enigCC46E56F80FD3E1E61178547
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Philippe Gerum wrote:
> Jan Kiszka wrote:
>> Philippe Gerum wrote:
>>> Jan Kiszka wrote:
>>>> Hi,
>>>>
>>>> doesn't this patch [1] have some relevance for us as well? As we use=

>>>> xnarch_remap_io_page_range also for non-IO memory, I'm hesitating to=

>>>> suggest that we apply this unconditionally at xnarch level. Ideas we=
lcome.
>>>>
>>> Yes, I think it makes a lot of sense on powerpc at least, since doing=
 so will
>>> set the PAGE_GUARDED bit as well, and we obviously want to avoid any
>>> out-of-order access of I/O memory.
>>>
>>> (I don't see the reason to force the VM_RESERVED and VM_IO on the vma=
 though,
>>> since remap_pfn_range will do it anyway.)
>> No, I was talking about cases where we may pass kmalloc'ed memory to
>> xnarch_remap_io_page_range. In that case, caching and out-of-order
>> access may be desired for performance reasons.
>>
>=20
> xnarch_remap_io_page_range is intended for I/O memory only, some assump=
tions are
> made on this. rtdm_mmap_buffer() should be fixed; it would be much bett=
er to
> define another internal interface at xnarch level to specifically perfo=
rm
> kmalloc mapping.

Yeah, probably. But I think the issue is not just limited to RTDM. The
xnheap can be kmalloc-hosted as well.

Jan


--------------enigCC46E56F80FD3E1E61178547
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.4-svn0 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFH3UxzniDOoMHTA+kRAoBRAJoDc4VQFmZHl7XOnVxKIOSkK+oHpgCfTV3P
Yiw9i6+JOgt5oEeJhs0NhDY=
=e1Qh
-----END PGP SIGNATURE-----

--------------enigCC46E56F80FD3E1E61178547--

