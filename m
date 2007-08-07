Message-ID: <46B8A57D.8010606@domain.hid>
Date: Tue, 07 Aug 2007 19:01:49 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <46B86E53.1030803@domain.hid> <46B86FE4.3040209@domain.hid>	
	<46B87B85.1080304@domain.hid>	
	<2ff1a98a0708070711n5e97ca03y18aef78ececc7e0d@domain.hid>	
	<46B87F93.9020308@domain.hid>	
	<2ff1a98a0708070724j5afecf20q22994d053553ed57@domain.hid>	
	<46B885E3.6060605@domain.hid>	
	<2ff1a98a0708070756q60794718wb1bc55675ea05ba4@domain.hid>	
	<46B888B4.2070301@domain.hid>	
	<2ff1a98a0708070809h2ac1a0b7q2178297d5a824bb9@domain.hid>
	<1186505723.5408.8.camel@domain.hid>
In-Reply-To: <1186505723.5408.8.camel@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig6E7B5D8CADAD32088580E98F"
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
To: rpm@xenomai.org
Cc: adeos-main <adeos-main@gna.org>, xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig6E7B5D8CADAD32088580E98F
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Philippe Gerum wrote:
> On Tue, 2007-08-07 at 17:09 +0200, Gilles Chanteperdrix wrote:
>> On 8/7/07, Jan Kiszka <jan.kiszka@domain.hid> wrote:
>>> Gilles Chanteperdrix wrote:
>>>> The fact that you are in a hurry should not be an excuse to propose =
a
>>>> fix which is much worse than the bug itself.
>>> Please explain.
>> Using GFP_ATOMIC is not a good idea, because the kernel needs the
>> GFP_ATOMIC pools for allocation that take place from really atomic
>> contexts such as interruption handlers for instance. fork should not
>> be an atomic context.
>>
>> So the only reason I see why you propose this patch is because you are=

>> in a hurry. Ok, before we fix this properly, you can use GFP_ATOMIC
>> locally, but please do not make
>> this an official patch.
>>
>=20
> I'm afraid you are both right. Draining pages from the atomic pool migh=
t
> starve truely atomic contexts, and releasing the lock guarding the
> pagetable pages for the source mm seems contradictory with what the
> current code tries to achieve in holding it.
>=20
> Here is a patch preallocating the page for the cow-breaking code, which=

> relies on the lock breaking pattern already in place. Not exactly
> pretty, slightly tested here (UP, spinlock debug), but looks ok so far.=

> Needs SMP testing before any attempt is made to merge it.

Funny. I just finished my own patch of this kind and made it pass a
basic COW stress test here. Find it below, it is very similar. Will
now analyse yours to see which one looks nicer and/or is more correct.

Jan


---
 mm/memory.c |   38 +++++++++++++++++++++++++++++---------
 1 file changed, 29 insertions(+), 9 deletions(-)

Index: linux-2.6.20.15/mm/memory.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.20.15.orig/mm/memory.c
+++ linux-2.6.20.15/mm/memory.c
@@ -456,7 +456,7 @@ static inline void cow_user_page(struct=20
 static inline int
 copy_one_pte(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 		pte_t *dst_pte, pte_t *src_pte, struct vm_area_struct *vma,
-		unsigned long addr, int *rss)
+		unsigned long addr, int *rss, struct page **new_page)
 {
 	unsigned long vm_flags =3D vma->vm_flags;
 	pte_t pte =3D *src_pte;
@@ -498,13 +498,15 @@ copy_one_pte(struct mm_struct *dst_mm, s
 #ifdef CONFIG_IPIPE
 		if (((vm_flags|src_mm->def_flags) & (VM_LOCKED|VM_PINNED)) =3D=3D (VM_=
LOCKED|VM_PINNED)) {
 			struct page *old_page =3D vm_normal_page(vma, addr, pte);
-			page =3D alloc_page_vma(GFP_HIGHUSER, vma, addr);
+
+			page =3D *new_page;
 			if (!page)
 				return -ENOMEM;
+			*new_page =3D NULL;
=20
 			cow_user_page(page, old_page, addr, vma);
 			pte =3D mk_pte(page, vma->vm_page_prot);
-		=09
+
 			if (vm_flags & VM_SHARED)
 				pte =3D pte_mkclean(pte);
 			pte =3D pte_mkold(pte);
@@ -546,12 +548,23 @@ static int copy_pte_range(struct mm_stru
 	spinlock_t *src_ptl, *dst_ptl;
 	int progress =3D 0;
 	int rss[2];
+	int err =3D 0;
+	int need_new_pages =3D 0;
+	struct page *new_page =3D NULL;
=20
 again:
+	if (need_new_pages && !new_page) {
+		new_page =3D alloc_page_vma(GFP_HIGHUSER, vma, addr);
+		if (!new_page)
+			return -ENOMEM;
+	}
+
 	rss[1] =3D rss[0] =3D 0;
 	dst_pte =3D pte_alloc_map_lock(dst_mm, dst_pmd, addr, &dst_ptl);
-	if (!dst_pte)
-		return -ENOMEM;
+	if (!dst_pte) {
+		err =3D -ENOMEM;
+		goto cleanup_exit;
+	}
 	src_pte =3D pte_offset_map_nested(src_pmd, addr);
 	src_ptl =3D pte_lockptr(src_mm, src_pmd);
 	spin_lock_nested(src_ptl, SINGLE_DEPTH_NESTING);
@@ -574,10 +587,13 @@ again:
 			continue;
 		}
 		if (copy_one_pte(dst_mm, src_mm, dst_pte,
-				 src_pte, vma, addr, rss))
-			return -ENOMEM;
+				 src_pte, vma, addr, rss, &new_page) < 0) {
+			need_new_pages =3D 1;
+			break;
+		}
 		progress +=3D 8;
-	} while (dst_pte++, src_pte++, addr +=3D PAGE_SIZE, addr !=3D end);
+	} while (dst_pte++, src_pte++, addr +=3D PAGE_SIZE,
+		 addr !=3D end && (!need_new_pages || new_page));
=20
 	arch_leave_lazy_mmu_mode();
 	spin_unlock(src_ptl);
@@ -587,7 +603,11 @@ again:
 	cond_resched();
 	if (addr !=3D end)
 		goto again;
-	return 0;
+
+cleanup_exit:
+	if (new_page)
+		page_cache_release(new_page);
+	return err;
 }
=20
 static inline int copy_pmd_range(struct mm_struct *dst_mm, struct mm_str=
uct *src_mm,



--------------enig6E7B5D8CADAD32088580E98F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGuKV9niDOoMHTA+kRAmFzAJ9qZuveoOGDExhGo7kRxWVrBcau8gCfQpYs
B0AIpmM84VJga6EV2aUOJEE=
=np2q
-----END PGP SIGNATURE-----

--------------enig6E7B5D8CADAD32088580E98F--

