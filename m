Message-ID: <46B8ACBB.5030001@domain.hid>
Date: Tue, 07 Aug 2007 19:32:43 +0200
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
	<1186505723.5408.8.camel@domain.hid> <46B8A57D.8010606@domain.hid>
In-Reply-To: <46B8A57D.8010606@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig055B8A5DF372E2B6FF46BB6E"
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
--------------enig055B8A5DF372E2B6FF46BB6E
Content-Type: multipart/mixed;
 boundary="------------030301010303060409080609"

This is a multi-part message in MIME format.
--------------030301010303060409080609
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Jan Kiszka wrote:
> Philippe Gerum wrote:
>> On Tue, 2007-08-07 at 17:09 +0200, Gilles Chanteperdrix wrote:
>>> On 8/7/07, Jan Kiszka <jan.kiszka@domain.hid> wrote:
>>>> Gilles Chanteperdrix wrote:
>>>>> The fact that you are in a hurry should not be an excuse to propose=
 a
>>>>> fix which is much worse than the bug itself.
>>>> Please explain.
>>> Using GFP_ATOMIC is not a good idea, because the kernel needs the
>>> GFP_ATOMIC pools for allocation that take place from really atomic
>>> contexts such as interruption handlers for instance. fork should not
>>> be an atomic context.
>>>
>>> So the only reason I see why you propose this patch is because you ar=
e
>>> in a hurry. Ok, before we fix this properly, you can use GFP_ATOMIC
>>> locally, but please do not make
>>> this an official patch.
>>>
>> I'm afraid you are both right. Draining pages from the atomic pool mig=
ht
>> starve truely atomic contexts, and releasing the lock guarding the
>> pagetable pages for the source mm seems contradictory with what the
>> current code tries to achieve in holding it.
>>
>> Here is a patch preallocating the page for the cow-breaking code, whic=
h
>> relies on the lock breaking pattern already in place. Not exactly
>> pretty, slightly tested here (UP, spinlock debug), but looks ok so far=
=2E
>> Needs SMP testing before any attempt is made to merge it.
>=20
> Funny. I just finished my own patch of this kind and made it pass a
> basic COW stress test here. Find it below, it is very similar. Will
> now analyse yours to see which one looks nicer and/or is more correct.

Yours is clearly nicer, but it required/allowed a few more cleanups.
Find my variant attached (against our local 2.6.20 kernel).

=46rom my POV: problem solved. 8)

Jan

--------------030301010303060409080609
Content-Type: text/plain;
 name="breaking-cow-might-sleep.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="breaking-cow-might-sleep.patch"

---
 mm/memory.c |   55 ++++++++++++++++++++++++++++++++++++++---------------=
--
 1 file changed, 38 insertions(+), 17 deletions(-)

Index: linux-2.6.20.15/mm/memory.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.20.15.orig/mm/memory.c
+++ linux-2.6.20.15/mm/memory.c
@@ -453,10 +453,10 @@ static inline void cow_user_page(struct=20
  * covered by this vma.
  */
=20
-static inline int
+static inline void
 copy_one_pte(struct mm_struct *dst_mm, struct mm_struct *src_mm,
-		pte_t *dst_pte, pte_t *src_pte, struct vm_area_struct *vma,
-		unsigned long addr, int *rss)
+	     pte_t *dst_pte, pte_t *src_pte, struct vm_area_struct *vma,
+	     unsigned long addr, int *rss, struct page *uncow_page)
 {
 	unsigned long vm_flags =3D vma->vm_flags;
 	pte_t pte =3D *src_pte;
@@ -496,21 +496,17 @@ copy_one_pte(struct mm_struct *dst_mm, s
 	 */
 	if (is_cow_mapping(vm_flags)) {
 #ifdef CONFIG_IPIPE
-		if (((vm_flags|src_mm->def_flags) & (VM_LOCKED|VM_PINNED)) =3D=3D (VM_=
LOCKED|VM_PINNED)) {
+		if (uncow_page) {
 			struct page *old_page =3D vm_normal_page(vma, addr, pte);
-			page =3D alloc_page_vma(GFP_HIGHUSER, vma, addr);
-			if (!page)
-				return -ENOMEM;
+			cow_user_page(uncow_page, old_page, addr, vma);
+			pte =3D mk_pte(uncow_page, vma->vm_page_prot);
=20
-			cow_user_page(page, old_page, addr, vma);
-			pte =3D mk_pte(page, vma->vm_page_prot);
-		=09
 			if (vm_flags & VM_SHARED)
 				pte =3D pte_mkclean(pte);
 			pte =3D pte_mkold(pte);
=20
-			page_dup_rmap(page);
-			rss[!!PageAnon(page)]++;
+			page_dup_rmap(uncow_page);
+			rss[!!PageAnon(uncow_page)]++;
 			goto out_set_pte;
 		}
 #endif /* CONFIG_IPIPE */
@@ -535,7 +531,6 @@ copy_one_pte(struct mm_struct *dst_mm, s
=20
 out_set_pte:
 	set_pte_at(dst_mm, addr, dst_pte, pte);
-	return 0;
 }
=20
 static int copy_pte_range(struct mm_struct *dst_mm, struct mm_struct *sr=
c_mm,
@@ -546,12 +541,27 @@ static int copy_pte_range(struct mm_stru
 	spinlock_t *src_ptl, *dst_ptl;
 	int progress =3D 0;
 	int rss[2];
+#ifdef CONFIG_IPIPE
+	int do_cow_break =3D 0;
+#endif
+	struct page *uncow_page =3D NULL;
=20
 again:
+#ifdef CONFIG_IPIPE
+	if (do_cow_break) {
+		uncow_page =3D alloc_page_vma(GFP_HIGHUSER, vma, addr);
+		if (!uncow_page)
+			return -ENOMEM;
+		do_cow_break =3D 0;
+	}
+#endif
 	rss[1] =3D rss[0] =3D 0;
 	dst_pte =3D pte_alloc_map_lock(dst_mm, dst_pmd, addr, &dst_ptl);
-	if (!dst_pte)
+	if (!dst_pte) {
+		if (uncow_page)
+			page_cache_release(uncow_page);
 		return -ENOMEM;
+	}
 	src_pte =3D pte_offset_map_nested(src_pmd, addr);
 	src_ptl =3D pte_lockptr(src_mm, src_pmd);
 	spin_lock_nested(src_ptl, SINGLE_DEPTH_NESTING);
@@ -573,9 +583,20 @@ again:
 			progress++;
 			continue;
 		}
-		if (copy_one_pte(dst_mm, src_mm, dst_pte,
-				 src_pte, vma, addr, rss))
-			return -ENOMEM;
+#ifdef CONFIG_IPIPE
+		if (likely(uncow_page =3D=3D NULL) && likely(pte_present(*src_pte))) {=

+			if (is_cow_mapping(vma->vm_flags)) {
+				if (((vma->vm_flags|src_mm->def_flags) & (VM_LOCKED|VM_PINNED))
+				    =3D=3D (VM_LOCKED|VM_PINNED)) {
+					do_cow_break =3D 1;
+					break;
+				}
+			}
+		}
+#endif
+		copy_one_pte(dst_mm, src_mm, dst_pte, src_pte,
+			     vma, addr, rss, uncow_page);
+		uncow_page =3D NULL;
 		progress +=3D 8;
 	} while (dst_pte++, src_pte++, addr +=3D PAGE_SIZE, addr !=3D end);
=20

--------------030301010303060409080609--

--------------enig055B8A5DF372E2B6FF46BB6E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGuKy7niDOoMHTA+kRAscAAJ44KGh3j2FyU6z4fHl2L5oIVJZVEACdGU4U
cGEbp8jJFmIZT2C+Ix85pjY=
=OR7v
-----END PGP SIGNATURE-----

--------------enig055B8A5DF372E2B6FF46BB6E--

