Message-ID: <46B885E3.6060605@domain.hid>
Date: Tue, 07 Aug 2007 16:46:59 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <46B86E53.1030803@domain.hid> <46B86FE4.3040209@domain.hid>	
	<46B87B85.1080304@domain.hid>	
	<2ff1a98a0708070711n5e97ca03y18aef78ececc7e0d@domain.hid>	
	<46B87F93.9020308@domain.hid>
	<2ff1a98a0708070724j5afecf20q22994d053553ed57@domain.hid>
In-Reply-To: <2ff1a98a0708070724j5afecf20q22994d053553ed57@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig6E68C9A83773B7EC7BB30DED"
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
--------------enig6E68C9A83773B7EC7BB30DED
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Gilles Chanteperdrix wrote:
> On 8/7/07, Jan Kiszka <jan.kiszka@domain.hid> wrote:
>> Gilles Chanteperdrix wrote:
>>> On 8/7/07, Jan Kiszka <jan.kiszka@domain.hid> wrote:
>>>> Gilles Chanteperdrix wrote:
>>>>> Jan Kiszka wrote:
>>>>>> Hi all,
>>>>>>
>>>>>> we are getting a lot of
>>>>>>
>>>>>> BUG: sleeping function called from invalid context at mm/page_allo=
c.c:1225
>>>>>> in_atomic():1, irqs_disabled():0
>>>>>>  [<c010305d>] show_trace_log_lvl+0x1a/0x2f
>>>>>>  [<c0103156>] show_trace+0x12/0x14
>>>>>>  [<c0103915>] dump_stack+0x16/0x18
>>>>>>  [<c010c4ab>] __might_sleep+0xcd/0xd3
>>>>>>  [<c0149488>] __alloc_pages+0x32/0x281
>>>>>>  [<c014fdd2>] copy_page_range+0x221/0x41e
>>>>>>  [<c010ec18>] copy_process+0x9e1/0xfe2
>>>>>>  [<c010f415>] do_fork+0x99/0x176
>>>>>>  [<c0100e75>] sys_clone+0x33/0x39
>>>>>>  [<c0102aaf>] syscall_call+0x7/0xb
>>>>>>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
>>>>>>
>>>>>> here due to a Xenomai program issuing system() calls.
>>>>>>
>>>>>> After once again dissecting the "nice" mm code (sigh...), the reas=
on
>>>>>> turned out to be plain simple:
>>>>>>
>>>>>> copy_pte_range(...);
>>>>>>   spin_lock_nested(src_ptl, SINGLE_DEPTH_NESTING);
>>>>>>   copy_one_pte(...);
>>>>>>     if (is_cow_mapping(vm_flags))
>>>>>>       alloc_page_vma(GFP_HIGHUSER, ...);
>>>>>>         __alloc_pages(...)
>>>>>>        might_sleep_if(gfp_mask & __GFP_WAIT);
>>>>>>
>>>>>> And this is true due to #define GFP_HIGHUSER (__GFP_WAIT | ...
>>>>>>
>>>>>> So the bad news is that the COW code in likely all i-pipe versions=
 is
>>>>>> broken. But the good new is that this might be easily fixable by
>>>>>> providing the right gfp_mask. GFP_ATOMIC?
>>>>> It does not look like a good solution, you are going to empty the
>>>>> GFP_ATOMIC pools. The proper solution would rather be to look at th=
e
>>>>> real mm code (I mean not the one I wrote) and see how they cope wit=
h
>>>>> this issue.
>>>> Mmpf. What are the chances for a quick fix within the next days? We =
have
>>>> to consider alternatives right now here because the whole system is
>>>> meant for production purpose next week (C-ELROB '07).
>>>>
>>>> OK, I'm already finding myself inside the code :-/. What about this
>>>> approach: We try to alloc with GFP_ATOMIC. Once this fails, we break=

>>>> out, drop all locks (just like it happens in case of need_resched())=
,
>>>> try to fill up the pool, and restart then. What would reliably make
>>>> Linux refill its atomic pool?
>>>>
>>>> Alternative approach: preallocate the required pages before entering=
 the
>>>> loop in copy_pte_range. But that may require more code changes.
>>> I would say the real fix is to drop momentarily the spinlock(s?) for =
allocating.
>>>
>> Are you sure it's safe to drop locks in the (logical) middle of
>> copy_one_pte()? I can't tell yet from the few glances I took. It's jus=
t
>> my feeling that says "no" so far.
>=20
> There is certainly something possible, since the vanilla kernel
> actually works without these warning.

Vanilla doesn't allocate pages from within copy_one_pte.


So, here comes proposal #1 for a solution, also addressing the broken
ENOMEM-error path of the current patch. Only compile tested yet. Might
this work?

Jan


---
 mm/memory.c |   16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

Index: linux-2.6.20.15/mm/memory.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.20.15.orig/mm/memory.c
+++ linux-2.6.20.15/mm/memory.c
@@ -498,7 +498,7 @@ copy_one_pte(struct mm_struct *dst_mm, s
 #ifdef CONFIG_IPIPE
 		if (((vm_flags|src_mm->def_flags) & (VM_LOCKED|VM_PINNED)) =3D=3D (VM_=
LOCKED|VM_PINNED)) {
 			struct page *old_page =3D vm_normal_page(vma, addr, pte);
-			page =3D alloc_page_vma(GFP_HIGHUSER, vma, addr);
+			page =3D alloc_page_vma(GFP_ATOMIC, vma, addr);
 			if (!page)
 				return -ENOMEM;
=20
@@ -546,6 +546,8 @@ static int copy_pte_range(struct mm_stru
 	spinlock_t *src_ptl, *dst_ptl;
 	int progress =3D 0;
 	int rss[2];
+	int nomem_retries =3D 10; /* Arbitrary limit */
+	int err =3D 0;
=20
 again:
 	rss[1] =3D rss[0] =3D 0;
@@ -574,8 +576,12 @@ again:
 			continue;
 		}
 		if (copy_one_pte(dst_mm, src_mm, dst_pte,
-				 src_pte, vma, addr, rss))
-			return -ENOMEM;
+				 src_pte, vma, addr, rss)) {
+			if (--nomem_retries =3D=3D 0)
+				err =3D -ENOMEM;
+			break;
+		}
+		nomem_retries =3D 10;
 		progress +=3D 8;
 	} while (dst_pte++, src_pte++, addr +=3D PAGE_SIZE, addr !=3D end);
=20
@@ -585,9 +591,9 @@ again:
 	add_mm_rss(dst_mm, rss[0], rss[1]);
 	pte_unmap_unlock(dst_pte - 1, dst_ptl);
 	cond_resched();
-	if (addr !=3D end)
+	if (addr !=3D end && !err)
 		goto again;
-	return 0;
+	return err;
 }
=20
 static inline int copy_pmd_range(struct mm_struct *dst_mm, struct mm_str=
uct *src_mm,



--------------enig6E68C9A83773B7EC7BB30DED
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGuIXjniDOoMHTA+kRAlFmAJ9QaK/4zIaljqerDkRMd6+4KUROAwCfVni4
9lUgw8nshlBv8+WfBHBQsFg=
=mPCG
-----END PGP SIGNATURE-----

--------------enig6E68C9A83773B7EC7BB30DED--

