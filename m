Message-ID: <44B35FB9.4050607@domain.hid>
Date: Tue, 11 Jul 2006 10:22:17 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: AW: [Xenomai-help] memset of heap crashes Xenomai-Task
References: <5D63919D95F87E4D9D34FF7748CE2C2A3F9210@domain.hid>
	<44B35CB7.8010708@domain.hid>
In-Reply-To: <44B35CB7.8010708@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigD9DF1CE4C46CCA207F2A0169"
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
To: Wolfgang Grandegger <wg@domain.hid>
Cc: Roderik_Wildenburg@domain.hid, xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigD9DF1CE4C46CCA207F2A0169
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Wolfgang Grandegger wrote:
> Roderik_Wildenburg@domain.hid wrote:
>>> memset should work with Xenomai heaps, I suspect your problem is
>>> rather that the memory is not really allocated until you memset it,
>>> which fails when no memory is available. In this case, calling memset=

>>> on memory allocated with malloc should segfault the same way when the=

>>> system memory is exhausted. IIRC, this behaviour is documented in
>>> mlockall manual page.
>>>
>>
>> Mr. Denk told me about this strange (for RTOSs) behaviour of the Linux=

>> kernel. Therefore I used the Xenomai heap mechanism, expecting
>> allocated memory is allocated at once not some time later (why do I
>> allocate memory otherwise : to be shure memory is available).
>> Does Xenomai use the Linux allocation mechanism ??
>>
>>
>>> Be careful with sysconf(_SC_AVPHYS_PAGES), it may include the swap
>>> size, but when mlocking memory, your application can not use swap
>>> pages, so, you should substract the size of swap, if any.
>>> Also, what is the value of /proc/sys/vm/overcommit_memory on your
>>> system ?
>>>
>>
>> Our System does not have a swap device\space.
>> /proc/sys/vm/overcommit_memory =3D 0
>> (whatever this means)
>=20
> I gave your program a try on my MPC5200 and got the following output
> (after some corrections):
>=20
> bash-2.05b# ./heap2
> Start Heap
> root_thread_init :
> timer startedt
> display task created
> root_thread_init beendet
> Available Memory 56238080 (Pagesize 4096)
> heap 0 of size 16000000 created
> Heap 0 allocated size 16000000
> heap 1 of size 16000000 created
> Heap 1 allocated size 16000000
> heap 2 of size 16000000 created
> Heap 2 allocated size 16000000
> __alloc_pages: 0-order allocation failed (gfp=3D0x1f2/0)
> Available Memory after allocation 8933376
> __alloc_pages: 0-order allocation failed (gfp=3D0x1f0/0)
> Heap 3 created with size 4218880
> Heap 3 allocated size 4218880
> Memory allocated in total : 52218880
> Segmentation fault
>=20
> The are some long delays (approx. 40 secs) around __alloc_pages. Finall=
y
> it crashes in memset. With the attached xenomai patch, which touches th=
e
> reserved page once, memset works fine. Let's wait what Philippe says. I=

> remember that the "touch" was needed for RTAI shared memory as well.

What is the difference between touching the page in kernel space and in
user space? Is there no risk that the kernel will oops then at some
point? Do we get the same result when touching the heap pages in user
space immediately after rt_help_alloc'ing them? Roderik's demo allocates
first and then touches/memsets. [I have no problem with the patch, I'm
just trying to understand the mechanism.]

Jan


--------------enigD9DF1CE4C46CCA207F2A0169
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEs1+5niDOoMHTA+kRAhvLAJ46oV2z9mJ0YpdujckuxKM+NWogfgCeN3cC
sJ77fEuJxGE7HthJpkIGEnI=
=7S9G
-----END PGP SIGNATURE-----

--------------enigD9DF1CE4C46CCA207F2A0169--

