Message-ID: <43E4A102.4070207@domain.hid>
Date: Sat, 04 Feb 2006 13:41:38 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] RTDM mmap alternative
References: <20060203192739.87567.qmail@domain.hid>
	<43E46EDA.7060304@domain.hid> <43E4A197.6030801@domain.hid>
In-Reply-To: <43E4A197.6030801@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig8B1E131FEACE17530C7685A8"
Sender: jan.kiszka@domain.hid
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Rodrigo Rosenfeld Rosas <lbocseg@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig8B1E131FEACE17530C7685A8
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Rodrigo Rosenfeld Rosas wrote:
> Hi, Jan. I think I wasn't very clear on my post. I'll try to clarify
> what I meaned...
>=20
> Jan Kiszka escreveu:
>> Rodrigo Rosenfeld Rosas wrote:
>> =20
>>> Hi Jan, I'm back on this discussion.
>>>
>>> At the time I asked you, you told me to do the mmap on driver
>>> initialization.
>>>
>>> But now, I realized that, since I'll be using RTDM, how could I use
>>> mmap from RTDM, even if in a non RT-context?
>>>    =20
>>
>> Which mapping step are you now referring to, the one to get the large
>> physical DMA area inside the kernel address space or the one to map
>> kernel addresses to user space?
> I'm refering to the second case. I want to map the kernel addresses to
> user space but I'm not very sure if I can do the same thing I did in my=

> previous mmap call on an ioctl. I mean, I don't know if the kernel does=

> something else in a mmap call... And since I don't have a mmap handler
> I'm a bit confusing...
>=20
>>  Already checked the related LDD3 chapter for this?
>>  =20
> Yes, but it didn't answered to my doubts...

What precisely? I suggested to look at remap_pfn_range() or
io_remap_page_range(). Do you see problems when using one of them?

>>> I'm a bit confusing...
>>>
>>> What would be others alternatives for avoid copying the video frames
>>> in a RTDM driver?
>>>    =20
>>
>> Either map or copy, there is no third way. The point is just which
>> mapping functions to use and when.
>>  =20
> That is what I would like to know... Which mapping functions are
> available? Actually, if I can use the same I used on my previous mmap
> handler that is good. I'm just unsure if something will be missing or
> not...

As I haven't written such a driver as well yet, I cannot say which one
will fit. You will have to go though the LDD explanations and play with
it (which means e.g. finding out where to obtain all required arguments
- should be feasible).

>=20
> I have also noted that there is no poll or select handler on RTDM. Are
> there some plans to include them?
>=20

Only rough plans. This requires a lot of work and restructuring, I'm
afraid. And I doubt that it's worth it. Do you see an urgent use-case
for poll/select under RT? The only real-life use-case that we came
across was ACE/TAO.

Jan


--------------enig8B1E131FEACE17530C7685A8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFD5KECniDOoMHTA+kRAmcRAJ9cEoi5oT7qK1Z5zmEWqkU/nW4X2ACZASQq
987TefUold2x5AdCG12Itms=
=wPAc
-----END PGP SIGNATURE-----

--------------enig8B1E131FEACE17530C7685A8--

