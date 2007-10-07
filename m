Message-ID: <4708FAC4.1010306@domain.hid>
Date: Sun, 07 Oct 2007 17:27:00 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig549F06559D51297320004B03"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] [PATCH] Fix __ipipe_pin_range_globally
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: adeos-main@gna.org
Cc: Xenomai-core@domain.hid

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig549F06559D51297320004B03
Content-Type: multipart/mixed;
 boundary="------------020104010805000806070205"

This is a multi-part message in MIME format.
--------------020104010805000806070205
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

This patch fixes another bug of I-pipe for 2.6.22:

Due to the introduction of a pgd page cache (quicklist) into that
kernel,  __ipipe_pin_range_globally no longer addressed all spots that
need to be updated after vmalloc'ed memory was mapped into the kernel
address range. The result was that, after inserting modular Xenomai, new
application sometimes received an outdated pgd from the quicklist, and
the next timer IRQ triggered a minor fault over xeno_nucleus. As
handling faults inside non-root domains with the Linux handler doesn't
fly, the box blew up sooner or later.

So I've reworked __ipipe_pin_range_globally, basing it on pgd_list, the
list of all pgd pages (in use or cached) in the system, and folding
__ipipe_pin_range_mapping into it. That makes __ipipe_pin_range_globally
an arch-specific thing from now on.

So far the quicklist is only biting us on i386, but I would suggest to
check if/how we can apply this new pattern on other archs as well.

Jan

PS: UP is now stable with latest Xenomai here, but SMP unfortunately
still misbehaves (I suspect host timer issues).


--------------020104010805000806070205
Content-Type: text/x-patch;
 name="fix-pin_range_globally.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="fix-pin_range_globally.patch"

---
 arch/i386/mm/fault.c  |   16 +++++++++++-----
 include/linux/ipipe.h |    7 ++-----
 mm/memory.c           |   14 --------------
 3 files changed, 13 insertions(+), 24 deletions(-)

Index: linux-2.6.22.7/arch/i386/mm/fault.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.22.7.orig/arch/i386/mm/fault.c
+++ linux-2.6.22.7/arch/i386/mm/fault.c
@@ -650,16 +650,22 @@ void vmalloc_sync_all(void)
 }
=20
 #ifdef CONFIG_IPIPE
-int __ipipe_pin_range_mapping(struct mm_struct *mm,
-			      unsigned long start, unsigned long end)
+void __ipipe_pin_range_globally(unsigned long start, unsigned long end)
 {
 	unsigned long next, addr =3D start;
+	unsigned long flags;
+	struct page *page;
=20
 	do {
 		next =3D pgd_addr_end(addr, end);
-		vmalloc_sync_one(mm->pgd, addr);
-	} while (addr =3D next, addr !=3D end);
=20
-	return 0;
+		spin_lock_irqsave(&pgd_lock, flags);
+		for (page =3D pgd_list; page; page =3D (struct page *)page->index)
+			if (!vmalloc_sync_one(page_address(page), addr)) {
+				BUG_ON(page !=3D pgd_list);
+				break;
+			}
+		spin_unlock_irqrestore(&pgd_lock, flags);
+	} while (addr =3D next, addr !=3D end);
 }
 #endif /* CONFIG_IPIPE */
Index: linux-2.6.22.7/include/linux/ipipe.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.22.7.orig/include/linux/ipipe.h
+++ linux-2.6.22.7/include/linux/ipipe.h
@@ -223,11 +223,6 @@ static inline void ipipe_irq_unlock(unsi
 	__ipipe_unlock_irq(ipipe_current_domain, irq);
 }
=20
-struct mm_struct;
-
-int __ipipe_pin_range_mapping(struct mm_struct *mm,
-			      unsigned long start, unsigned long end);
-
 #ifndef __ipipe_sync_pipeline
 #define __ipipe_sync_pipeline(syncmask) __ipipe_sync_stage(syncmask)
 #endif
@@ -298,6 +293,8 @@ static inline void ipipe_init_notify(str
 		__ipipe_dispatch_event(IPIPE_EVENT_INIT,p);
 }
=20
+struct mm_struct;
+
 static inline void ipipe_cleanup_notify(struct mm_struct *mm)
 {
 	if (__ipipe_event_monitored_p(IPIPE_EVENT_CLEANUP))
Index: linux-2.6.22.7/mm/memory.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.22.7.orig/mm/memory.c
+++ linux-2.6.22.7/mm/memory.c
@@ -2959,18 +2959,4 @@ int ipipe_disable_ondemand_mappings(stru
 }
=20
 EXPORT_SYMBOL(ipipe_disable_ondemand_mappings);
-
-void __ipipe_pin_range_globally(unsigned long start, unsigned long end)
-{
-	struct task_struct *p;
-
-	read_lock(&tasklist_lock);
-
-	for_each_process(p)
-		if (p->mm)
-			__ipipe_pin_range_mapping(p->mm, start, end);
-
-	read_unlock(&tasklist_lock);
-}
-
 #endif


--------------020104010805000806070205--

--------------enig549F06559D51297320004B03
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFHCPrEniDOoMHTA+kRAl27AJ4qK5rSlNZ1Wp7u4kxfkKAcx3cohACfZHZC
KD66wcJ+RWjjuTA8pt+YsB0=
=vNVX
-----END PGP SIGNATURE-----

--------------enig549F06559D51297320004B03--

