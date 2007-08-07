Message-ID: <46B888B4.2070301@domain.hid>
Date: Tue, 07 Aug 2007 16:59:00 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <46B86E53.1030803@domain.hid> <46B86FE4.3040209@domain.hid>	
	<46B87B85.1080304@domain.hid>	
	<2ff1a98a0708070711n5e97ca03y18aef78ececc7e0d@domain.hid>	
	<46B87F93.9020308@domain.hid>	
	<2ff1a98a0708070724j5afecf20q22994d053553ed57@domain.hid>	
	<46B885E3.6060605@domain.hid>
	<2ff1a98a0708070756q60794718wb1bc55675ea05ba4@domain.hid>
In-Reply-To: <2ff1a98a0708070756q60794718wb1bc55675ea05ba4@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig1149C4DA31D3ABDC5242274A"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] [Adeos-main] [COW-BUG] __alloc_pages called from
	atomic context
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
Cc: adeos-main <adeos-main@gna.org>, xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig1149C4DA31D3ABDC5242274A
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Gilles Chanteperdrix wrote:
> On 8/7/07, Jan Kiszka <jan.kiszka@domain.hid> wrote:
>> Gilles Chanteperdrix wrote:
>>> On 8/7/07, Jan Kiszka <jan.kiszka@domain.hid> wrote:
>>>> Gilles Chanteperdrix wrote:
>>>>> On 8/7/07, Jan Kiszka <jan.kiszka@domain.hid> wrote:
>>>>>> Gilles Chanteperdrix wrote:
>>>>>>> Jan Kiszka wrote:
>>>>>>>> Hi all,
>>>>>>>>
>>>>>>>> we are getting a lot of
>>>>>>>>
>>>>>>>> BUG: sleeping function called from invalid context at mm/page_al=
loc.c:1225
>>>>>>>> in_atomic():1, irqs_disabled():0
>>>>>>>>  [<c010305d>] show_trace_log_lvl+0x1a/0x2f
>>>>>>>>  [<c0103156>] show_trace+0x12/0x14
>>>>>>>>  [<c0103915>] dump_stack+0x16/0x18
>>>>>>>>  [<c010c4ab>] __might_sleep+0xcd/0xd3
>>>>>>>>  [<c0149488>] __alloc_pages+0x32/0x281
>>>>>>>>  [<c014fdd2>] copy_page_range+0x221/0x41e
>>>>>>>>  [<c010ec18>] copy_process+0x9e1/0xfe2
>>>>>>>>  [<c010f415>] do_fork+0x99/0x176
>>>>>>>>  [<c0100e75>] sys_clone+0x33/0x39
>>>>>>>>  [<c0102aaf>] syscall_call+0x7/0xb
>>>>>>>>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
>>>>>>>>
>>>>>>>> here due to a Xenomai program issuing system() calls.
>>>>>>>>
>>>>>>>> After once again dissecting the "nice" mm code (sigh...), the re=
ason
>>>>>>>> turned out to be plain simple:
>>>>>>>>
>>>>>>>> copy_pte_range(...);
>>>>>>>>   spin_lock_nested(src_ptl, SINGLE_DEPTH_NESTING);
>>>>>>>>   copy_one_pte(...);
>>>>>>>>     if (is_cow_mapping(vm_flags))
>>>>>>>>       alloc_page_vma(GFP_HIGHUSER, ...);
>>>>>>>>         __alloc_pages(...)
>>>>>>>>        might_sleep_if(gfp_mask & __GFP_WAIT);
>>>>>>>>
>>>>>>>> And this is true due to #define GFP_HIGHUSER (__GFP_WAIT | ...
>>>>>>>>
>>>>>>>> So the bad news is that the COW code in likely all i-pipe versio=
ns is
>>>>>>>> broken. But the good new is that this might be easily fixable by=

>>>>>>>> providing the right gfp_mask. GFP_ATOMIC?
>>>>>>> It does not look like a good solution, you are going to empty the=

>>>>>>> GFP_ATOMIC pools. The proper solution would rather be to look at =
the
>>>>>>> real mm code (I mean not the one I wrote) and see how they cope w=
ith
>>>>>>> this issue.
>>>>>> Mmpf. What are the chances for a quick fix within the next days? W=
e have
>>>>>> to consider alternatives right now here because the whole system i=
s
>>>>>> meant for production purpose next week (C-ELROB '07).
>>>>>>
>>>>>> OK, I'm already finding myself inside the code :-/. What about thi=
s
>>>>>> approach: We try to alloc with GFP_ATOMIC. Once this fails, we bre=
ak
>>>>>> out, drop all locks (just like it happens in case of need_resched(=
)),
>>>>>> try to fill up the pool, and restart then. What would reliably mak=
e
>>>>>> Linux refill its atomic pool?
>>>>>>
>>>>>> Alternative approach: preallocate the required pages before enteri=
ng the
>>>>>> loop in copy_pte_range. But that may require more code changes.
>>>>> I would say the real fix is to drop momentarily the spinlock(s?) fo=
r allocating.
>>>>>
>>>> Are you sure it's safe to drop locks in the (logical) middle of
>>>> copy_one_pte()? I can't tell yet from the few glances I took. It's j=
ust
>>>> my feeling that says "no" so far.
>>> There is certainly something possible, since the vanilla kernel
>>> actually works without these warning.
>> Vanilla doesn't allocate pages from within copy_one_pte.
>=20
> The fact that you are in a hurry should not be an excuse to propose a
> fix which is much worse than the bug itself.

Please explain.


--------------enig1149C4DA31D3ABDC5242274A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGuIi0niDOoMHTA+kRAv5BAJ9QjYPeUjpbt40ghgdF9jN/9gONDACfWanY
SrIfLaSQMwtgU3VbmR9awSQ=
=CCPd
-----END PGP SIGNATURE-----

--------------enig1149C4DA31D3ABDC5242274A--

