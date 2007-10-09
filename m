Message-ID: <470B247B.6060805@domain.hid>
Date: Tue, 09 Oct 2007 08:49:31 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <bc4264770710081022n71a97a91m6d839ab1e27cb54@domain.hid>	<470A6B28.7020009@domain.hid>
	<bc4264770710081116n5d49911ah6aa0831ebd9023ae@domain.hid>
	<470AB8DA.5000408@domain.hid> <470B1CA2.8070509@domain.hid>
In-Reply-To: <470B1CA2.8070509@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig9BC643ECD2CB57EE8912DB4B"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] adeos patch for 2.6.21
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: rolandtollenaar@domain.hid
Cc: Xenomai-help@domain.hid

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig9BC643ECD2CB57EE8912DB4B
Content-Type: multipart/mixed;
 boundary="------------070500010107020108080109"

This is a multi-part message in MIME format.
--------------070500010107020108080109
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Roland Tollenaar wrote:
> Hi Jan,
>=20
>>>> But note that we are still sweeping out remaining bugs around this
>>>> kernel, see "Fix __ipipe_pin_range_globally" and "IO-APIC stall due =
to
>>>> broken fasteoi handling" on Xenomai-core / Adeos-main. Moreover,
>>>> today's
>=20
>> Just checked again: The problem is still limited to kernels with
>> CONFIG_HIGH_RES_TIMERS or CONFIG_NO_HZ. So you can already do your tes=
ts
>> with those features disabled and the two mentioned patches applied.
> I presume the "Fix __ipipe_pin_range_globally" and "IO-APIC stall due t=
o
>>>> broken fasteoi handling" are the patches you are refering to. I also=

> assume these have been posted on xenomai-core and/or adeos-main mailing=

> list. If that is correct I am having some trouble locating them in the
> ML archives with the labels above. Any other manner I can get hold of
> those patches?

This way e.g.:

http://search.gmane.org/?query=3DFix+__ipipe_pin_range_globally&group=3Dg=
mane.linux.real-time.xenomai.devel

Alternatively, I attached both for you, adding a third one which is
relevant if you use Xenomai with --enable-x86-sep.

Jan

--------------070500010107020108080109
Content-Type: text/x-patch;
 name="fix-fasteoi.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="fix-fasteoi.patch"

diff --git a/arch/i386/kernel/io_apic.c b/arch/i386/kernel/io_apic.c
index 2ae79e9..517937b 100644
--- a/arch/i386/kernel/io_apic.c
+++ b/arch/i386/kernel/io_apic.c
@@ -2022,6 +2022,8 @@ static void ack_ioapic_quirk_irq(unsigned int irq)
 		__unmask_and_level_IO_APIC_irq(irq);
 		spin_unlock(&ioapic_lock);
 	}
+
+	__mask_IO_APIC_irq(irq);
 }
=20
 static int ioapic_retrigger_irq(unsigned int irq)
diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
index ba497a7..1560b4a 100644
--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -422,8 +422,13 @@ handle_fasteoi_irq(unsigned int irq, struct irq_desc=
 *desc)
=20
 	spin_lock(&desc->lock);
 	desc->status &=3D ~IRQ_INPROGRESS;
+#ifdef CONFIG_IPIPE
+	desc->chip->unmask(irq);
+out:
+#else
 out:
 	desc->chip->eoi(irq);
+#endif
=20
 	spin_unlock(&desc->lock);
 }
@@ -533,11 +538,12 @@ void fastcall __ipipe_end_level_irq(unsigned irq, s=
truct irq_desc *desc)
=20
 void fastcall __ipipe_ack_fasteoi_irq(unsigned irq, struct irq_desc *des=
c)
 {
+	desc->chip->eoi(irq);
 }
=20
 void fastcall __ipipe_end_fasteoi_irq(unsigned irq, struct irq_desc *des=
c)
 {
-	desc->chip->eoi(irq);
+	desc->chip->unmask(irq);
 }
=20
 void fastcall __ipipe_ack_edge_irq(unsigned irq, struct irq_desc *desc)

--------------070500010107020108080109
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

--------------070500010107020108080109
Content-Type: text/x-patch;
 name="fix-wrmsr-race.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="fix-wrmsr-race.patch"

---
 arch/i386/kernel/vm86.c |    4 ++++
 1 file changed, 4 insertions(+)

Index: linux-2.6.20.20/arch/i386/kernel/vm86.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.20.20.orig/arch/i386/kernel/vm86.c
+++ linux-2.6.20.20/arch/i386/kernel/vm86.c
@@ -148,12 +148,14 @@ struct pt_regs * fastcall save_v86_state
 		do_exit(SIGSEGV);
 	}
=20
+	local_irq_disable_hw_cond();
 	tss =3D &per_cpu(init_tss, get_cpu());
 	current->thread.esp0 =3D current->thread.saved_esp0;
 	current->thread.sysenter_cs =3D __KERNEL_CS;
 	load_esp0(tss, &current->thread);
 	current->thread.saved_esp0 =3D 0;
 	put_cpu();
+	local_irq_enable_hw_cond();
=20
 	ret =3D KVM86->regs32;
=20
@@ -324,12 +326,14 @@ static void do_sys_vm86(struct kernel_vm
 	savesegment(fs, tsk->thread.saved_fs);
 	tsk->thread.saved_gs =3D info->regs32->xgs;
=20
+	local_irq_disable_hw_cond();
 	tss =3D &per_cpu(init_tss, get_cpu());
 	tsk->thread.esp0 =3D (unsigned long) &info->VM86_TSS_ESP0;
 	if (cpu_has_sep)
 		tsk->thread.sysenter_cs =3D 0;
 	load_esp0(tss, &tsk->thread);
 	put_cpu();
+	local_irq_enable_hw_cond();
=20
 	tsk->thread.screen_bitmap =3D info->screen_bitmap;
 	if (info->flags & VM86_SCREEN_BITMAP)

--------------070500010107020108080109--

--------------enig9BC643ECD2CB57EE8912DB4B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFHCyR8niDOoMHTA+kRApwiAJ46lXkxtmR9xpK1BKRiuOZovcIsqQCfYshY
g1/jMh9l00418lej+UnCMKA=
=2Ajx
-----END PGP SIGNATURE-----

--------------enig9BC643ECD2CB57EE8912DB4B--

