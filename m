Message-ID: <47ECBCAA.50701@domain.hid>
Date: Fri, 28 Mar 2008 10:38:50 +0100
From: Neil Armstrong <narmstrong@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig76C831770B0822F72AFD6941"
Subject: [Xenomai-core] Porting Ipipe/Adeos patch to new arm9 board
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig76C831770B0822F72AFD6941
Content-Type: multipart/mixed;
 boundary="------------030600010007060101040903"

This is a multi-part message in MIME format.
--------------030600010007060101040903
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,

I need to port the actual ipipe 2.6.24 patch for a new arm926ej-s based
board for my company.
I followed the wiki's howto and helped myself with the integrator and
the s3c24xx patches.
The Soc has 3 decrementers, the arm core is running at 144MHz and the
timers has a 256 ticks prescaler (we need 563 ticks to get 1ms).

I patched the kernel with the arm1 patch (from the ARM website), the
board non-rt patch enabling serial and the macb ethernet controller and
finnally tried to apply the ipipe arm patch and resolving failures.

Finally I have a kernel oops at start_kernel just before enabling the
consoles :
Kernel zImage Magic: '016f2818' Start:Ox00000000 End:0x0007db5c
Setting Kernel Parameters : 'init=3D/bin/init user_debug=3D31 debug'
Starting Kernel 0x80308000 (Params:0xC0000100)
Uncompressing Linux.................................... done, booting
the kernel.
<5>Linux version 2.6.24-arm1-np4 (narmstrong@domain.hid) (gcc version 4.2.1
(CodeSourcery Sourcery G++ Lite 2007q3-53)) #6 Fri Mar 28 08:40:04 CET 20=
08
CPU: ARM926EJ-S [41069265] revision 5 (ARMv5TEJ), cr=3D00057177
Machine: Neotion NP4+
Memory policy: ECC disabled, Data cache writeback
<7>On node 0 totalpages: 4096
<7>  DMA zone: 32 pages used for memmap
<7>  DMA zone: 0 pages reserved
<7>  DMA zone: 4064 pages, LIFO batch:0
<7>  Normal zone: 0 pages used for memmap
<7>  Movable zone: 0 pages used for memmap
np4: IO Mapping Init.
CPU0: D VIVT write-back cache
CPU0: I cache: 16384 bytes, associativity 4, 32 byte lines, 128 sets
CPU0: D cache: 16384 bytes, associativity 4, 32 byte lines, 128 sets
Built 1 zonelists in Zone order, mobility grouping off.  Total pages: 406=
4
<5>Kernel command line: init=3D/bin/init user_debug=3D31 debug
np4: IRQ Init: 32
PID hash table entries: 64 (order: 6, 256 bytes)
np4: Timer 0 Init. : Freq 144000000 Prescaler 256 Period 563 HZ 1000
<6>I-pipe 1.9-01: pipeline enabled.
<1>Unable <1>pgd =3D c0004000
<1>[ffffffff] *pgd=3D80002031, *pte=3D00000000, *ppte=3D00000000
Internal error: Oops: 17 [#1]
CPU: 0    Not tainted  (2.6.24-arm1-np4 #6)
PC is at vsnprintf+0x578/0x5c8
LR is at panic+0x3c/0x10c
pc : [<c00c0518>]    lr : [<c0026f9c>]    psr: 80000053
sp : c0103ef8  ip : c0103f48  fp : c0103f44
r10: 8001339c  r9 : c010b2e8  r8 : 800133d0
r7 : c0103f64  r6 : c010aee8  r5 : c0103fa4  r4 : c010aeb8
r3 : ffffffff  r2 : ffffffff  r1 : 00000400  r0 : c010aee8
Flags: Nzcv  IRQs on  FIQs off  Mode SVC_32  ISA ARM  Segment kernel
Control: 0005717f  Table: 80004000  DAC: 00000017
Process swapper (pid: 0, stack limit =3D 0xc0102270)
Stack: (0xc0103ef8 to 0xc0104000)
3ee0:                                                       00000001
c014dec4
3f00: 41069265 8001339c c0103f34 00000400 c010aee8 ffffffff c0103f34
c010aeb8
3f20: c0103fa4 00000001 c0105928 800133d0 41069265 8001339c c0103f5c
c0103f48
3f40: c0026f9c c00bffb0 c0103f6c c0103f64 c0103fc4 c0103f70 c0008cb0
c0026f74
3f60: ffffffff c0103ff4 c0107370 c0013764 00000024 00000000 c0107370
60000053
3f80: c0014f00 c010a260 c0107400 c0105928 800133d0 41069265 8001339c
c0103fc4
3fa0: c0103fc8 c0103fb8 c0008c98 c0046760 60000053 ffffffff c0103ff4
c0103fc8
3fc0: c0008c98 c0046728 c0008544 00000000 00000000 c0014f00 00000000
00057175
3fe0: c010a7a0 c0014efc 00000000 c0103ff8 80008034 c0008af4 00000000
00000000
Backtrace:
[<c00bffa0>] (vsnprintf+0x0/0x5c8) from [<c0026f9c>] (panic+0x3c/0x10c)
[<c0026f60>] (panic+0x0/0x10c) from [<c0008cb0>] (start_kernel+0x1cc/0x2c=
c)
 r3:c0013764 r2:c0107370 r1:c0103ff4 r0:ffffffff
[<c0046718>] (__ipipe_unstall_root+0x0/0x50) from [<c0008c98>]
(start_kernel+0x1b4/0x2cc)
[<c0008ae4>] (start_kernel+0x0/0x2cc) from [<80008034>] (0x80008034)
 r6:c0014efc r5:c010a7a0 r4:00057175
Code: e51b3030 e2833001 e50b3030 e51b3030 (e5d33000)
<1>Unhandled fault: alignment exception (0x001) at 0x0000000f
<1<1>pgd =3D c01060e8
<1>[00000000] *pgd=3Dc01060e8<1>Unable to handle kernel paging request at=

virtual address 00106800
<1>pgd =3D c01060e8

I just can't find where the error is, the modified ipipe patch and
kernel config is joined. (the board code is in the arch/arm/mach-np4
directory)
Thanks,
Neil

--
Neil Armstrong
Neotion Sophia Antipolis
Stagiaire Mars-Septembre 2008 Polytech'Nice-Sophia
narmstrong@domain.hid (PGP:0x1166F485)

--------------030600010007060101040903
Content-Type: text/x-patch;
 name="ipipe-2.6.24-arm1-np4.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="ipipe-2.6.24-arm1-np4.patch"

Index: kernel/exit.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- kernel/exit.c	(revision 91)
+++ kernel/exit.c	(working copy)
@@ -994,6 +994,7 @@
=20
 	if (group_dead)
 		acct_process();
+ 	ipipe_exit_notify(tsk);
 	exit_sem(tsk);
 	__exit_files(tsk);
 	__exit_fs(tsk);
Index: kernel/Makefile
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- kernel/Makefile	(revision 91)
+++ kernel/Makefile	(working copy)
@@ -53,6 +53,7 @@
 obj-$(CONFIG_SECCOMP) +=3D seccomp.o
 obj-$(CONFIG_RCU_TORTURE_TEST) +=3D rcutorture.o
 obj-$(CONFIG_RELAY) +=3D relay.o
+obj-$(CONFIG_IPIPE) +=3D ipipe/
 obj-$(CONFIG_SYSCTL) +=3D utsname_sysctl.o
 obj-$(CONFIG_TASK_DELAY_ACCT) +=3D delayacct.o
 obj-$(CONFIG_TASKSTATS) +=3D taskstats.o tsacct.o
Index: kernel/power/swsusp.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- kernel/power/swsusp.c	(revision 91)
+++ kernel/power/swsusp.c	(working copy)
@@ -275,6 +275,7 @@
 	int error;
=20
 	local_irq_disable();
+	local_irq_disable_hw_cond();
 	/* NOTE:  device_power_down() is just a suspend() with irqs off;
 	 * it has no special "power things down" semantics
 	 */
@@ -301,6 +302,7 @@
 	restore_processor_state();
 	touch_softlockup_watchdog();
 	device_power_up();
+	local_irq_enable_hw_cond();
 	local_irq_enable();
 	return error;
 }
Index: kernel/power/disk.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- kernel/power/disk.c	(revision 91)
+++ kernel/power/disk.c	(working copy)
@@ -154,6 +154,7 @@
 		return error;
=20
 	local_irq_disable();
+ 	local_irq_disable_hw_cond();
 	/* At this point, device_suspend() has been called, but *not*
 	 * device_power_down(). We *must* call device_power_down() now.
 	 * Otherwise, drivers for some devices (e.g. interrupt controllers)
@@ -180,6 +181,7 @@
 	 */
 	device_power_up();
  Enable_irqs:
+ 	local_irq_enable_hw_cond();
 	local_irq_enable();
 	return error;
 }
Index: kernel/fork.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- kernel/fork.c	(revision 91)
+++ kernel/fork.c	(working copy)
@@ -403,6 +403,7 @@
 	if (atomic_dec_and_test(&mm->mm_users)) {
 		exit_aio(mm);
 		exit_mmap(mm);
+		ipipe_cleanup_notify(mm);
 		if (!list_empty(&mm->mmlist)) {
 			spin_lock(&mmlist_lock);
 			list_del(&mm->mmlist);
@@ -938,7 +939,7 @@
 {
 	unsigned long new_flags =3D p->flags;
=20
-	new_flags &=3D ~PF_SUPERPRIV;
+ 	new_flags &=3D ~(PF_SUPERPRIV | PF_EVNOTIFY);
 	new_flags |=3D PF_FORKNOEXEC;
 	if (!(clone_flags & CLONE_PTRACE))
 		p->ptrace =3D 0;
@@ -1312,6 +1313,9 @@
 	write_unlock_irq(&tasklist_lock);
 	proc_fork_connector(p);
 	cgroup_post_fork(p);
+#ifdef CONFIG_IPIPE
+	memset(p->ptd, 0, sizeof(p->ptd));
+#endif /* CONFIG_IPIPE */
 	return p;
=20
 bad_fork_free_pid:
Index: kernel/printk.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- kernel/printk.c	(revision 91)
+++ kernel/printk.c	(working copy)
@@ -590,6 +590,41 @@
 	return 0;
 }
=20
+#ifdef CONFIG_IPIPE
+
+static ipipe_spinlock_t __ipipe_printk_lock =3D IPIPE_SPIN_LOCK_UNLOCKED=
;
+
+static int __ipipe_printk_fill;
+
+static char __ipipe_printk_buf[__LOG_BUF_LEN];
+
+void __ipipe_flush_printk (unsigned virq, void *cookie)
+{
+	char *p =3D __ipipe_printk_buf;
+	int len, lmax, out =3D 0;
+	unsigned long flags;
+
+	goto start;
+
+	do {
+		spin_unlock_irqrestore(&__ipipe_printk_lock, flags);
+ start:
+		lmax =3D __ipipe_printk_fill;
+		while (out < lmax) {
+			len =3D strlen(p) + 1;
+			printk("%s",p);
+			p +=3D len;
+			out +=3D len;
+		}
+		spin_lock_irqsave(&__ipipe_printk_lock, flags);
+	}
+	while (__ipipe_printk_fill !=3D lmax);
+
+	__ipipe_printk_fill =3D 0;
+
+	spin_unlock_irqrestore(&__ipipe_printk_lock, flags);
+}
+
 /**
  * printk - print a kernel message
  * @fmt: format string
@@ -615,7 +650,48 @@
=20
 asmlinkage int printk(const char *fmt, ...)
 {
+  	int r, fbytes, oldcount, cs =3D -1;
+    	unsigned long flags;
 	va_list args;
+
+	va_start(args, fmt);
+
+	if (test_bit(IPIPE_SPRINTK_FLAG,&ipipe_current_domain->flags) ||
+	    oops_in_progress)
+		cs =3D ipipe_disable_context_check(ipipe_processor_id());
+
+	if (ipipe_current_domain =3D=3D ipipe_root_domain || cs !=3D -1) {
+		r =3D vprintk(fmt, args);
+		if (cs !=3D -1)
+			ipipe_restore_context_check(ipipe_processor_id(), cs);
+		goto out;
+	}
+
+	spin_lock_irqsave(&__ipipe_printk_lock, flags);
+
+	oldcount =3D __ipipe_printk_fill;
+	fbytes =3D __LOG_BUF_LEN - oldcount;
+
+	if (fbytes > 1)	{
+		r =3D vscnprintf(__ipipe_printk_buf + __ipipe_printk_fill,
+			       fbytes, fmt, args) + 1; /* account for the null byte */
+		__ipipe_printk_fill +=3D r;
+	} else
+		r =3D 0;
+
+	spin_unlock_irqrestore(&__ipipe_printk_lock, flags);
+
+	if (oldcount =3D=3D 0)
+		ipipe_trigger_irq(__ipipe_printk_virq);
+out:
+	va_end(args);
+
+	return r;
+}
+#else /* !CONFIG_IPIPE */
+asmlinkage int printk(const char *fmt, ...)
+{
+	va_list args;
 	int r;
=20
 	va_start(args, fmt);
@@ -624,6 +700,7 @@
=20
 	return r;
 }
+#endif /* CONFIG_IPIPE */
=20
 /* cpu currently holding logbuf_lock */
 static volatile unsigned int printk_cpu =3D UINT_MAX;
Index: kernel/irq/chip.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- kernel/irq/chip.c	(revision 91)
+++ kernel/irq/chip.c	(working copy)
@@ -335,7 +335,9 @@
 	irqreturn_t action_ret;
=20
 	spin_lock(&desc->lock);
+#ifndef CONFIG_IPIPE
 	mask_ack_irq(desc, irq);
+#endif /* CONFIG_IPIPE */
=20
 	if (unlikely(desc->status & IRQ_INPROGRESS))
 		goto out_unlock;
@@ -412,8 +414,13 @@
=20
 	spin_lock(&desc->lock);
 	desc->status &=3D ~IRQ_INPROGRESS;
+#ifdef CONFIG_IPIPE
+	desc->chip->unmask(irq);
 out:
+#else
+out:
 	desc->chip->eoi(irq);
+#endif
=20
 	spin_unlock(&desc->lock);
 }
@@ -457,8 +464,10 @@
=20
 	kstat_cpu(cpu).irqs[irq]++;
=20
+#ifndef CONFIG_IPIPE
 	/* Start handling the irq */
 	desc->chip->ack(irq);
+#endif /* CONFIG_IPIPE */
=20
 	/* Mark the IRQ currently in progress.*/
 	desc->status |=3D IRQ_INPROGRESS;
@@ -498,6 +507,120 @@
 	spin_unlock(&desc->lock);
 }
=20
+#ifdef CONFIG_IPIPE
+
+void fastcall __ipipe_ack_simple_irq(unsigned irq, struct irq_desc *desc=
)
+{
+}
+
+void fastcall __ipipe_end_simple_irq(unsigned irq, struct irq_desc *desc=
)
+{
+}
+
+void fastcall __ipipe_ack_level_irq(unsigned irq, struct irq_desc *desc)=

+{
+	mask_ack_irq(desc, irq);
+}
+
+void fastcall __ipipe_end_level_irq(unsigned irq, struct irq_desc *desc)=

+{
+	if (desc->chip->unmask)
+		desc->chip->unmask(irq);
+}
+
+void fastcall __ipipe_ack_fasteoi_irq(unsigned irq, struct irq_desc *des=
c)
+{
+	desc->chip->eoi(irq);
+}
+
+void fastcall __ipipe_end_fasteoi_irq(unsigned irq, struct irq_desc *des=
c)
+{
+	desc->chip->unmask(irq);
+}
+
+void fastcall __ipipe_ack_edge_irq(unsigned irq, struct irq_desc *desc)
+{
+	desc->chip->ack(irq);
+}
+
+void fastcall __ipipe_ack_percpu_irq(unsigned irq, struct irq_desc *desc=
)
+{
+	if (desc->chip->ack)
+		desc->chip->ack(irq);
+}
+
+void fastcall __ipipe_end_percpu_irq(unsigned irq, struct irq_desc *desc=
)
+{
+	if (desc->chip->eoi)
+		desc->chip->eoi(irq);
+}
+
+void fastcall __ipipe_end_edge_irq(unsigned irq, struct irq_desc *desc)
+{
+}
+
+void fastcall __ipipe_ack_demux_irq(unsigned irq, struct irq_desc *desc)=

+{
+	/*
+	 * Handling is delegated to some demultiplexer routine,
+	 * e.g. GPIO. We mask_ack it, then call back into the demux
+	 * handler, which should decode the interrupt and feed the
+	 * pipeline as needed.
+	 */
+	if (desc->chip->mask)
+		desc->chip->mask(irq);
+	desc->ipipe_demux(irq, desc);
+}
+
+void fastcall __ipipe_end_demux_irq(unsigned irq, struct irq_desc *desc)=

+{
+	if (desc->chip->unmask)
+		desc->chip->unmask(irq);
+}
+
+void fastcall
+handle_demux_irq(unsigned int irq, struct irq_desc *desc)
+{
+	/*
+	 * The regular IRQ handler will run last of all GPIO handlers,
+	 * to unmask the demux IRQ.
+	 */
+	__ipipe_end_demux_irq(irq, desc);
+}
+
+void __set_irq_demux_handler(unsigned int irq,
+			     void fastcall (*decode)(unsigned int, struct irq_desc *),
+			     int is_chained,
+			     const char *name)
+{
+	struct irq_desc *desc =3D irq_desc + irq;
+	__set_irq_handler(irq, &handle_demux_irq, is_chained, name);
+	desc->ipipe_demux =3D decode;
+}
+
+void fastcall __ipipe_ack_bad_irq(unsigned irq, struct irq_desc *desc)
+{
+	static int done;
+
+	handle_bad_irq(irq, desc);
+
+	if (!done) {
+		printk(KERN_WARNING "%s: unknown flow handler for IRQ %d\n",
+		       __FUNCTION__, irq);
+		done =3D 1;
+	}
+}
+
+void fastcall __ipipe_noack_irq(unsigned irq, struct irq_desc *desc)
+{
+}
+
+void fastcall __ipipe_noend_irq(unsigned irq, struct irq_desc *desc)
+{
+}
+
+#endif /* CONFIG_IPIPE */
+
 /**
  *	handle_percpu_IRQ - Per CPU local irq handler
  *	@irq:	the interrupt number
@@ -512,8 +635,10 @@
=20
 	kstat_this_cpu.irqs[irq]++;
=20
+#ifndef CONFIG_IPIPE
 	if (desc->chip->ack)
 		desc->chip->ack(irq);
+#endif /* CONFIG_IPIPE */
=20
 	action_ret =3D handle_IRQ_event(irq, desc->action);
 	if (!noirqdebug)
@@ -540,6 +665,34 @@
=20
 	if (!handle)
 		handle =3D handle_bad_irq;
+#ifdef CONFIG_IPIPE
+	else if (handle =3D=3D &handle_simple_irq) {
+		desc->ipipe_ack =3D &__ipipe_ack_simple_irq;
+		desc->ipipe_end =3D &__ipipe_end_simple_irq;
+	}
+	else if (handle =3D=3D &handle_level_irq) {
+		desc->ipipe_ack =3D &__ipipe_ack_level_irq;
+		desc->ipipe_end =3D &__ipipe_end_level_irq;
+	}
+	else if (handle =3D=3D &handle_edge_irq) {
+		desc->ipipe_ack =3D &__ipipe_ack_edge_irq;
+		desc->ipipe_end =3D &__ipipe_end_edge_irq;
+	}
+	else if (handle =3D=3D &handle_fasteoi_irq) {
+		desc->ipipe_ack =3D &__ipipe_ack_fasteoi_irq;
+		desc->ipipe_end =3D &__ipipe_end_fasteoi_irq;
+	}
+#ifdef CONFIG_SMP
+	else if (handle =3D=3D &handle_percpu_irq) {
+		desc->ipipe_ack =3D &__ipipe_ack_percpu_irq;
+		desc->ipipe_end =3D &__ipipe_end_percpu_irq;
+	}
+#endif /* CONFIG_SMP */
+	else if (handle =3D=3D &handle_demux_irq) {
+		desc->ipipe_ack =3D &__ipipe_ack_demux_irq;
+		desc->ipipe_end =3D &__ipipe_end_demux_irq;
+	}
+#endif /* CONFIG_IPIPE */
 	else if (desc->chip =3D=3D &no_irq_chip) {
 		printk(KERN_WARNING "Trying to install %sinterrupt handler "
 		       "for IRQ%d\n", is_chained ? "chained " : "", irq);
@@ -551,7 +704,17 @@
 		 * dummy_irq_chip for easy transition.
 		 */
 		desc->chip =3D &dummy_irq_chip;
+#ifdef CONFIG_IPIPE
+		desc->ipipe_ack =3D &__ipipe_noack_irq;
+		desc->ipipe_end =3D &__ipipe_noend_irq;
+#endif /* CONFIG_IPIPE */
 	}
+#ifdef CONFIG_IPIPE
+ 	else {
+ 		desc->ipipe_ack =3D &__ipipe_ack_bad_irq;
+ 		desc->ipipe_end =3D &__ipipe_noend_irq;
+ 	}
+#endif /* CONFIG_IPIPE */
=20
 	spin_lock_irqsave(&desc->lock, flags);
=20
@@ -561,6 +724,10 @@
 			mask_ack_irq(desc, irq);
 		desc->status |=3D IRQ_DISABLED;
 		desc->depth =3D 1;
+#ifdef CONFIG_IPIPE
+		desc->ipipe_ack =3D &__ipipe_ack_bad_irq;
+		desc->ipipe_end =3D &__ipipe_noend_irq;
+#endif /* CONFIG_IPIPE */
 	}
 	desc->handle_irq =3D handle;
 	desc->name =3D name;
Index: kernel/spinlock.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- kernel/spinlock.c	(revision 91)
+++ kernel/spinlock.c	(working copy)
@@ -88,7 +88,7 @@
 	 * _raw_spin_lock_flags() code, because lockdep assumes
 	 * that interrupts are not re-enabled during lock-acquire:
 	 */
-#ifdef CONFIG_LOCKDEP
+#if defined(CONFIG_LOCKDEP) || defined(CONFIG_IPIPE)
 	LOCK_CONTENDED(lock, _raw_spin_trylock, _raw_spin_lock);
 #else
 	_raw_spin_lock_flags(lock, &flags);
@@ -305,7 +305,7 @@
 	 * _raw_spin_lock_flags() code, because lockdep assumes
 	 * that interrupts are not re-enabled during lock-acquire:
 	 */
-#ifdef CONFIG_LOCKDEP
+#if defined(CONFIG_LOCKDEP) || defined(CONFIG_IPIPE)
 	LOCK_CONTENDED(lock, _raw_spin_trylock, _raw_spin_lock);
 #else
 	_raw_spin_lock_flags(lock, &flags);
Index: kernel/ipipe/Kconfig
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- kernel/ipipe/Kconfig	(revision 0)
+++ kernel/ipipe/Kconfig	(revision 0)
@@ -0,0 +1,25 @@
+config IPIPE
+	bool "Interrupt pipeline"
+	default y
+	---help---
+	  Activate this option if you want the interrupt pipeline to be
+	  compiled in.
+
+config IPIPE_DOMAINS
+	int "Max domains"
+	depends on IPIPE
+	default 4
+	---help---
+	The maximum number of I-pipe domains to run concurrently.
+
+config IPIPE_COMPAT
+	bool "Maintain code compatibility with older releases"
+	depends on IPIPE
+	default y
+	---help---
+	Activate this option if you want the compatibility code to be
+	defined, so that older I-pipe clients may use obsolete
+	constructs. WARNING: obsolete code will be eventually
+	deprecated in future I-pipe releases, and removed from the
+	compatibility support as time passes. Please fix I-pipe
+	clients to get rid of such uses as soon as possible.
Index: kernel/ipipe/tracer.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- kernel/ipipe/tracer.c	(revision 0)
+++ kernel/ipipe/tracer.c	(revision 0)
@@ -0,0 +1,1336 @@
+/* -*- linux-c -*-
+ * kernel/ipipe/tracer.c
+ *
+ * Copyright (C) 2005 Luotao Fu.
+ *               2005-2008 Jan Kiszka.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation, Inc., 675 Mass Ave, Cambridge MA 02139,=

+ * USA; either version 2 of the License, or (at your option) any later
+ * version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307,=
 USA.
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/version.h>
+#include <linux/kallsyms.h>
+#include <linux/seq_file.h>
+#include <linux/proc_fs.h>
+#include <linux/ctype.h>
+#include <linux/vmalloc.h>
+#include <linux/utsrelease.h>
+#include <linux/sched.h>
+#include <linux/ipipe.h>
+#include <asm/uaccess.h>
+
+#define IPIPE_TRACE_PATHS           4 /* <!> Do not lower below 3 */
+#define IPIPE_DEFAULT_ACTIVE        0
+#define IPIPE_DEFAULT_MAX           1
+#define IPIPE_DEFAULT_FROZEN        2
+
+#define IPIPE_TRACE_POINTS          (1 << CONFIG_IPIPE_TRACE_SHIFT)
+#define WRAP_POINT_NO(point)        ((point) & (IPIPE_TRACE_POINTS-1))
+
+#define IPIPE_DEFAULT_PRE_TRACE     10
+#define IPIPE_DEFAULT_POST_TRACE    10
+#define IPIPE_DEFAULT_BACK_TRACE    100
+
+#define IPIPE_DELAY_NOTE            1000  /* in nanoseconds */
+#define IPIPE_DELAY_WARN            10000 /* in nanoseconds */
+
+#define IPIPE_TFLG_NMI_LOCK         0x0001
+#define IPIPE_TFLG_NMI_HIT          0x0002
+#define IPIPE_TFLG_NMI_FREEZE_REQ   0x0004
+
+#define IPIPE_TFLG_HWIRQ_OFF        0x0100
+#define IPIPE_TFLG_FREEZING         0x0200
+#define IPIPE_TFLG_CURRDOM_SHIFT    10   /* bits 10..11: current domain =
*/
+#define IPIPE_TFLG_CURRDOM_MASK     0x0C00
+#define IPIPE_TFLG_DOMSTATE_SHIFT   12   /* bits 12..15: domain stalled?=
 */
+#define IPIPE_TFLG_DOMSTATE_BITS    3
+
+#define IPIPE_TFLG_DOMAIN_STALLED(point, n) \
+	(point->flags & (1 << (n + IPIPE_TFLG_DOMSTATE_SHIFT)))
+#define IPIPE_TFLG_CURRENT_DOMAIN(point) \
+	((point->flags & IPIPE_TFLG_CURRDOM_MASK) >> IPIPE_TFLG_CURRDOM_SHIFT)
+
+struct ipipe_trace_point {
+	short type;
+	short flags;
+	unsigned long eip;
+	unsigned long parent_eip;
+	unsigned long v;
+	unsigned long long timestamp;
+};
+
+struct ipipe_trace_path {
+	volatile int flags;
+	int dump_lock; /* separated from flags due to cross-cpu access */
+	int trace_pos; /* next point to fill */
+	int begin, end; /* finalised path begin and end */
+	int post_trace; /* non-zero when in post-trace phase */
+	unsigned long long length; /* max path length in cycles */
+	unsigned long nmi_saved_eip; /* for deferred requests from NMIs */
+	unsigned long nmi_saved_parent_eip;
+	unsigned long nmi_saved_v;
+	struct ipipe_trace_point point[IPIPE_TRACE_POINTS];
+} ____cacheline_aligned_in_smp;
+
+enum ipipe_trace_type
+{
+	IPIPE_TRACE_FUNC =3D 0,
+	IPIPE_TRACE_BEGIN,
+	IPIPE_TRACE_END,
+	IPIPE_TRACE_FREEZE,
+	IPIPE_TRACE_SPECIAL,
+	IPIPE_TRACE_PID,
+};
+
+#define IPIPE_TYPE_MASK             0x0007
+#define IPIPE_TYPE_BITS             3
+
+#ifdef CONFIG_IPIPE_TRACE_VMALLOC
+static DEFINE_PER_CPU(struct ipipe_trace_path *, trace_path);
+#else /* !CONFIG_IPIPE_TRACE_VMALLOC */
+static DEFINE_PER_CPU(struct ipipe_trace_path, trace_path[IPIPE_TRACE_PA=
THS]) =3D
+	{ [0 ... IPIPE_TRACE_PATHS-1] =3D { .begin =3D -1, .end =3D -1 } };
+#endif /* CONFIG_IPIPE_TRACE_VMALLOC */
+
+int ipipe_trace_enable =3D 0;
+
+static DEFINE_PER_CPU(int, active_path) =3D { IPIPE_DEFAULT_ACTIVE };
+static DEFINE_PER_CPU(int, max_path) =3D { IPIPE_DEFAULT_MAX };
+static DEFINE_PER_CPU(int, frozen_path) =3D { IPIPE_DEFAULT_FROZEN };
+static IPIPE_DEFINE_SPINLOCK(global_path_lock);
+static int pre_trace =3D IPIPE_DEFAULT_PRE_TRACE;
+static int post_trace =3D IPIPE_DEFAULT_POST_TRACE;
+static int back_trace =3D IPIPE_DEFAULT_BACK_TRACE;
+static int verbose_trace =3D 1;
+static unsigned long trace_overhead;
+
+static unsigned long trigger_begin;
+static unsigned long trigger_end;
+
+static DEFINE_MUTEX(out_mutex);
+static struct ipipe_trace_path *print_path;
+#ifdef CONFIG_IPIPE_TRACE_PANIC
+static struct ipipe_trace_path *panic_path;
+#endif /* CONFIG_IPIPE_TRACE_PANIC */
+static int print_pre_trace;
+static int print_post_trace;
+
+
+static long __ipipe_signed_tsc2us(long long tsc);
+static void
+__ipipe_trace_point_type(char *buf, struct ipipe_trace_point *point);
+static void __ipipe_print_symname(struct seq_file *m, unsigned long eip)=
;
+
+
+static notrace void
+__ipipe_store_domain_states(struct ipipe_trace_point *point)
+{
+	struct ipipe_domain *ipd;
+	struct list_head *pos;
+	int i =3D 0;
+
+	list_for_each_prev(pos, &__ipipe_pipeline) {
+		ipd =3D list_entry(pos, struct ipipe_domain, p_link);
+
+		if (test_bit(IPIPE_STALL_FLAG, &ipipe_cpudom_var(ipd, status)))
+			point->flags |=3D 1 << (i + IPIPE_TFLG_DOMSTATE_SHIFT);
+
+		if (ipd =3D=3D ipipe_current_domain)
+			point->flags |=3D i << IPIPE_TFLG_CURRDOM_SHIFT;
+
+		if (++i > IPIPE_TFLG_DOMSTATE_BITS)
+			break;
+	}
+}
+
+static notrace int __ipipe_get_free_trace_path(int old, int cpu)
+{
+	int new_active =3D old;
+	struct ipipe_trace_path *tp;
+
+	do {
+		if (++new_active =3D=3D IPIPE_TRACE_PATHS)
+			new_active =3D 0;
+		tp =3D &per_cpu(trace_path, cpu)[new_active];
+	} while (new_active =3D=3D per_cpu(max_path, cpu) ||
+	         new_active =3D=3D per_cpu(frozen_path, cpu) ||
+	         tp->dump_lock);
+
+	return new_active;
+}
+
+static notrace void
+__ipipe_migrate_pre_trace(struct ipipe_trace_path *new_tp,
+                          struct ipipe_trace_path *old_tp, int old_pos)
+{
+	int i;
+
+	new_tp->trace_pos =3D pre_trace+1;
+
+	for (i =3D new_tp->trace_pos; i > 0; i--)
+		memcpy(&new_tp->point[WRAP_POINT_NO(new_tp->trace_pos-i)],
+		       &old_tp->point[WRAP_POINT_NO(old_pos-i)],
+		       sizeof(struct ipipe_trace_point));
+
+	/* mark the end (i.e. the point before point[0]) invalid */
+	new_tp->point[IPIPE_TRACE_POINTS-1].eip =3D 0;
+}
+
+static notrace struct ipipe_trace_path *
+__ipipe_trace_end(int cpu, struct ipipe_trace_path *tp, int pos)
+{
+	struct ipipe_trace_path *old_tp =3D tp;
+	long active =3D per_cpu(active_path, cpu);
+	unsigned long long length;
+
+	/* do we have a new worst case? */
+	length =3D tp->point[tp->end].timestamp -
+	         tp->point[tp->begin].timestamp;
+	if (length > per_cpu(trace_path, cpu)[per_cpu(max_path, cpu)].length) {=

+		/* we need protection here against other cpus trying
+		   to start a proc dump */
+		spin_lock(&global_path_lock);
+
+		/* active path holds new worst case */
+		tp->length =3D length;
+		per_cpu(max_path, cpu) =3D active;
+
+		/* find next unused trace path */
+		active =3D __ipipe_get_free_trace_path(active, cpu);
+
+		spin_unlock(&global_path_lock);
+
+		tp =3D &per_cpu(trace_path, cpu)[active];
+
+		/* migrate last entries for pre-tracing */
+		__ipipe_migrate_pre_trace(tp, old_tp, pos);
+	}
+
+	return tp;
+}
+
+static notrace struct ipipe_trace_path *
+__ipipe_trace_freeze(int cpu, struct ipipe_trace_path *tp, int pos)
+{
+	struct ipipe_trace_path *old_tp =3D tp;
+	long active =3D per_cpu(active_path, cpu);
+	int n;
+
+	/* frozen paths have no core (begin=3Dend) */
+	tp->begin =3D tp->end;
+
+	/* we need protection here against other cpus trying
+	 * to set their frozen path or to start a proc dump */
+	spin_lock(&global_path_lock);
+
+	per_cpu(frozen_path, cpu) =3D active;
+
+	/* find next unused trace path */
+	active =3D __ipipe_get_free_trace_path(active, cpu);
+
+	/* check if this is the first frozen path */
+	for_each_possible_cpu(n) {
+		if (n !=3D cpu &&
+		    per_cpu(trace_path, n)[per_cpu(frozen_path, n)].end >=3D 0)
+			tp->end =3D -1;
+	}
+
+	spin_unlock(&global_path_lock);
+
+	tp =3D &per_cpu(trace_path, cpu)[active];
+
+	/* migrate last entries for pre-tracing */
+	__ipipe_migrate_pre_trace(tp, old_tp, pos);
+
+	return tp;
+}
+
+void notrace
+__ipipe_trace(enum ipipe_trace_type type, unsigned long eip,
+              unsigned long parent_eip, unsigned long v)
+{
+	struct ipipe_trace_path *tp, *old_tp;
+	int pos, next_pos, begin;
+	struct ipipe_trace_point *point;
+	unsigned long flags;
+	int cpu;
+
+	local_irq_save_hw_notrace(flags);
+
+	cpu =3D ipipe_processor_id();
+ restart:
+	tp =3D old_tp =3D &per_cpu(trace_path, cpu)[per_cpu(active_path, cpu)];=

+
+	/* here starts a race window with NMIs - catched below */
+
+	/* check for NMI recursion */
+	if (unlikely(tp->flags & IPIPE_TFLG_NMI_LOCK)) {
+		tp->flags |=3D IPIPE_TFLG_NMI_HIT;
+
+		/* first freeze request from NMI context? */
+		if ((type =3D=3D IPIPE_TRACE_FREEZE) &&
+		    !(tp->flags & IPIPE_TFLG_NMI_FREEZE_REQ)) {
+			/* save arguments and mark deferred freezing */
+			tp->flags |=3D IPIPE_TFLG_NMI_FREEZE_REQ;
+			tp->nmi_saved_eip =3D eip;
+			tp->nmi_saved_parent_eip =3D parent_eip;
+			tp->nmi_saved_v =3D v;
+		}
+		return; /* no need for restoring flags inside IRQ */
+	}
+
+	/* clear NMI events and set lock (atomically per cpu) */
+	tp->flags =3D (tp->flags & ~(IPIPE_TFLG_NMI_HIT |
+	                           IPIPE_TFLG_NMI_FREEZE_REQ))
+	                       | IPIPE_TFLG_NMI_LOCK;
+
+	/* check active_path again - some nasty NMI may have switched
+	 * it meanwhile */
+	if (unlikely(tp !=3D
+		     &per_cpu(trace_path, cpu)[per_cpu(active_path, cpu)])) {
+		/* release lock on wrong path and restart */
+		tp->flags &=3D ~IPIPE_TFLG_NMI_LOCK;
+
+		/* there is no chance that the NMI got deferred
+		 * =3D> no need to check for pending freeze requests */
+		goto restart;
+	}
+
+	/* get the point buffer */
+	pos =3D tp->trace_pos;
+	point =3D &tp->point[pos];
+
+	/* store all trace point data */
+	point->type =3D type;
+	point->flags =3D raw_irqs_disabled_flags(flags) ? IPIPE_TFLG_HWIRQ_OFF =
: 0;
+	point->eip =3D eip;
+	point->parent_eip =3D parent_eip;
+	point->v =3D v;
+	ipipe_read_tsc(point->timestamp);
+
+	__ipipe_store_domain_states(point);
+
+	/* forward to next point buffer */
+	next_pos =3D WRAP_POINT_NO(pos+1);
+	tp->trace_pos =3D next_pos;
+
+	/* only mark beginning if we haven't started yet */
+	begin =3D tp->begin;
+	if (unlikely(type =3D=3D IPIPE_TRACE_BEGIN) && (begin < 0))
+		tp->begin =3D pos;
+
+	/* end of critical path, start post-trace if not already started */
+	if (unlikely(type =3D=3D IPIPE_TRACE_END) &&
+	    (begin >=3D 0) && !tp->post_trace)
+		tp->post_trace =3D post_trace + 1;
+
+	/* freeze only if the slot is free and we are not already freezing */
+	if ((unlikely(type =3D=3D IPIPE_TRACE_FREEZE) ||
+	     (unlikely(eip >=3D trigger_begin && eip <=3D trigger_end) &&
+	     type =3D=3D IPIPE_TRACE_FUNC)) &&
+	    per_cpu(trace_path, cpu)[per_cpu(frozen_path, cpu)].begin < 0 &&
+	    !(tp->flags & IPIPE_TFLG_FREEZING)) {
+		tp->post_trace =3D post_trace + 1;
+		tp->flags |=3D IPIPE_TFLG_FREEZING;
+	}
+
+	/* enforce end of trace in case of overflow */
+	if (unlikely(WRAP_POINT_NO(next_pos + 1) =3D=3D begin)) {
+		tp->end =3D pos;
+		goto enforce_end;
+	}
+
+	/* stop tracing this path if we are in post-trace and
+	 *  a) that phase is over now or
+	 *  b) a new TRACE_BEGIN came in but we are not freezing this path */
+	if (unlikely((tp->post_trace > 0) && ((--tp->post_trace =3D=3D 0) ||
+	             ((type =3D=3D IPIPE_TRACE_BEGIN) &&
+	              !(tp->flags & IPIPE_TFLG_FREEZING))))) {
+		/* store the path's end (i.e. excluding post-trace) */
+		tp->end =3D WRAP_POINT_NO(pos - post_trace + tp->post_trace);
+
+ enforce_end:
+		if (tp->flags & IPIPE_TFLG_FREEZING)
+			tp =3D __ipipe_trace_freeze(cpu, tp, pos);
+		else
+			tp =3D __ipipe_trace_end(cpu, tp, pos);
+
+		/* reset the active path, maybe already start a new one */
+		tp->begin =3D (type =3D=3D IPIPE_TRACE_BEGIN) ?
+			WRAP_POINT_NO(tp->trace_pos - 1) : -1;
+		tp->end =3D -1;
+		tp->post_trace =3D 0;
+		tp->flags =3D 0;
+
+		/* update active_path not earlier to avoid races with NMIs */
+		per_cpu(active_path, cpu) =3D tp - per_cpu(trace_path, cpu);
+	}
+
+	/* we still have old_tp and point,
+	 * let's reset NMI lock and check for catches */
+	old_tp->flags &=3D ~IPIPE_TFLG_NMI_LOCK;
+	if (unlikely(old_tp->flags & IPIPE_TFLG_NMI_HIT)) {
+		/* well, this late tagging may not immediately be visible for
+		 * other cpus already dumping this path - a minor issue */
+		point->flags |=3D IPIPE_TFLG_NMI_HIT;
+
+		/* handle deferred freezing from NMI context */
+		if (old_tp->flags & IPIPE_TFLG_NMI_FREEZE_REQ)
+			__ipipe_trace(IPIPE_TRACE_FREEZE, old_tp->nmi_saved_eip,
+			              old_tp->nmi_saved_parent_eip,
+			              old_tp->nmi_saved_v);
+	}
+
+	local_irq_restore_hw_notrace(flags);
+}
+
+static unsigned long __ipipe_global_path_lock(void)
+{
+	unsigned long flags;
+	int cpu;
+	struct ipipe_trace_path *tp;
+
+	spin_lock_irqsave(&global_path_lock, flags);
+
+	cpu =3D ipipe_processor_id();
+ restart:
+	tp =3D &per_cpu(trace_path, cpu)[per_cpu(active_path, cpu)];
+
+	/* here is small race window with NMIs - catched below */
+
+	/* clear NMI events and set lock (atomically per cpu) */
+	tp->flags =3D (tp->flags & ~(IPIPE_TFLG_NMI_HIT |
+	                           IPIPE_TFLG_NMI_FREEZE_REQ))
+	                       | IPIPE_TFLG_NMI_LOCK;
+
+	/* check active_path again - some nasty NMI may have switched
+	 * it meanwhile */
+	if (tp !=3D &per_cpu(trace_path, cpu)[per_cpu(active_path, cpu)]) {
+		/* release lock on wrong path and restart */
+		tp->flags &=3D ~IPIPE_TFLG_NMI_LOCK;
+
+		/* there is no chance that the NMI got deferred
+		 * =3D> no need to check for pending freeze requests */
+		goto restart;
+	}
+
+	return flags;
+}
+
+static void __ipipe_global_path_unlock(unsigned long flags)
+{
+	int cpu;
+	struct ipipe_trace_path *tp;
+
+	/* release spinlock first - it's not involved in the NMI issue */
+	__ipipe_spin_unlock_irqbegin(&global_path_lock);
+
+	cpu =3D ipipe_processor_id();
+	tp =3D &per_cpu(trace_path, cpu)[per_cpu(active_path, cpu)];
+
+	tp->flags &=3D ~IPIPE_TFLG_NMI_LOCK;
+
+	/* handle deferred freezing from NMI context */
+	if (tp->flags & IPIPE_TFLG_NMI_FREEZE_REQ)
+		__ipipe_trace(IPIPE_TRACE_FREEZE, tp->nmi_saved_eip,
+		              tp->nmi_saved_parent_eip, tp->nmi_saved_v);
+
+	/* See __ipipe_spin_lock_irqsave() and friends. */
+	__ipipe_spin_unlock_irqcomplete(flags);
+}
+
+void notrace ipipe_trace_begin(unsigned long v)
+{
+	if (!ipipe_trace_enable)
+		return;
+	__ipipe_trace(IPIPE_TRACE_BEGIN, __BUILTIN_RETURN_ADDRESS0,
+	              __BUILTIN_RETURN_ADDRESS1, v);
+}
+EXPORT_SYMBOL(ipipe_trace_begin);
+
+void notrace ipipe_trace_end(unsigned long v)
+{
+	if (!ipipe_trace_enable)
+		return;
+	__ipipe_trace(IPIPE_TRACE_END, __BUILTIN_RETURN_ADDRESS0,
+	              __BUILTIN_RETURN_ADDRESS1, v);
+}
+EXPORT_SYMBOL(ipipe_trace_end);
+
+void notrace ipipe_trace_freeze(unsigned long v)
+{
+	if (!ipipe_trace_enable)
+		return;
+	__ipipe_trace(IPIPE_TRACE_FREEZE, __BUILTIN_RETURN_ADDRESS0,
+	              __BUILTIN_RETURN_ADDRESS1, v);
+}
+EXPORT_SYMBOL(ipipe_trace_freeze);
+
+void notrace ipipe_trace_special(unsigned char id, unsigned long v)
+{
+	if (!ipipe_trace_enable)
+		return;
+	__ipipe_trace(IPIPE_TRACE_SPECIAL | (id << IPIPE_TYPE_BITS),
+	              __BUILTIN_RETURN_ADDRESS0,
+	              __BUILTIN_RETURN_ADDRESS1, v);
+}
+EXPORT_SYMBOL(ipipe_trace_special);
+
+void notrace ipipe_trace_pid(pid_t pid, short prio)
+{
+	if (!ipipe_trace_enable)
+		return;
+	__ipipe_trace(IPIPE_TRACE_PID | (prio << IPIPE_TYPE_BITS),
+	              __BUILTIN_RETURN_ADDRESS0,
+	              __BUILTIN_RETURN_ADDRESS1, pid);
+}
+EXPORT_SYMBOL(ipipe_trace_pid);
+
+int ipipe_trace_max_reset(void)
+{
+	int cpu;
+	unsigned long flags;
+	struct ipipe_trace_path *path;
+	int ret =3D 0;
+
+	flags =3D __ipipe_global_path_lock();
+
+	for_each_possible_cpu(cpu) {
+		path =3D &per_cpu(trace_path, cpu)[per_cpu(max_path, cpu)];
+
+		if (path->dump_lock) {
+			ret =3D -EBUSY;
+			break;
+		}
+
+		path->begin     =3D -1;
+		path->end       =3D -1;
+		path->trace_pos =3D 0;
+		path->length    =3D 0;
+	}
+
+	__ipipe_global_path_unlock(flags);
+
+	return ret;
+}
+EXPORT_SYMBOL(ipipe_trace_max_reset);
+
+int ipipe_trace_frozen_reset(void)
+{
+	int cpu;
+	unsigned long flags;
+	struct ipipe_trace_path *path;
+	int ret =3D 0;
+
+	flags =3D __ipipe_global_path_lock();
+
+	for_each_online_cpu(cpu) {
+		path =3D &per_cpu(trace_path, cpu)[per_cpu(frozen_path, cpu)];
+
+		if (path->dump_lock) {
+			ret =3D -EBUSY;
+			break;
+		}
+
+		path->begin =3D -1;
+		path->end =3D -1;
+		path->trace_pos =3D 0;
+		path->length    =3D 0;
+	}
+
+	__ipipe_global_path_unlock(flags);
+
+	return ret;
+}
+EXPORT_SYMBOL(ipipe_trace_frozen_reset);
+
+static void
+__ipipe_get_task_info(char *task_info, struct ipipe_trace_point *point,
+                      int trylock)
+{
+	struct task_struct *task =3D NULL;
+	char buf[8];
+	int i;
+	int locked =3D 1;
+
+	if (trylock) {
+		if (!read_trylock(&tasklist_lock))
+			locked =3D 0;
+	} else
+		read_lock(&tasklist_lock);
+
+	if (locked)
+		task =3D find_task_by_pid((pid_t)point->v);
+
+	if (task)
+		strncpy(task_info, task->comm, 11);
+	else
+		strcpy(task_info, "-<?>-");
+
+	if (locked)
+		read_unlock(&tasklist_lock);
+
+	for (i =3D strlen(task_info); i < 11; i++)
+		task_info[i] =3D ' ';
+
+	sprintf(buf, " %d ", point->type >> IPIPE_TYPE_BITS);
+	strcpy(task_info + (11 - strlen(buf)), buf);
+}
+
+#ifdef CONFIG_IPIPE_TRACE_PANIC
+void ipipe_trace_panic_freeze(void)
+{
+	unsigned long flags;
+	int cpu;
+
+	if (!ipipe_trace_enable)
+		return;
+
+	ipipe_trace_enable =3D 0;
+	local_irq_save_hw_notrace(flags);
+
+	cpu =3D ipipe_processor_id();
+
+	panic_path =3D &per_cpu(trace_path, cpu)[per_cpu(active_path, cpu)];
+
+	local_irq_restore_hw(flags);
+}
+EXPORT_SYMBOL(ipipe_trace_panic_freeze);
+
+void ipipe_trace_panic_dump(void)
+{
+	int cnt =3D back_trace;
+	int start, pos;
+	char task_info[12];
+
+	if (!panic_path)
+		return;
+
+	ipipe_context_check_off();
+
+	printk("I-pipe tracer log (%d points):\n", cnt);
+
+	start =3D pos =3D WRAP_POINT_NO(panic_path->trace_pos-1);
+
+	while (cnt-- > 0) {
+		struct ipipe_trace_point *point =3D &panic_path->point[pos];
+		long time;
+		char buf[16];
+		int i;
+
+		printk(" %c",
+		       (point->flags & IPIPE_TFLG_HWIRQ_OFF) ? '|' : ' ');
+
+		for (i =3D IPIPE_TFLG_DOMSTATE_BITS; i >=3D 0; i--)
+			printk("%c",
+			       (IPIPE_TFLG_CURRENT_DOMAIN(point) =3D=3D i) ?
+				(IPIPE_TFLG_DOMAIN_STALLED(point, i) ?
+					'#' : '+') :
+				(IPIPE_TFLG_DOMAIN_STALLED(point, i) ?
+					'*' : ' '));
+
+		if (!point->eip)
+			printk("-<invalid>-\n");
+		else {
+			__ipipe_trace_point_type(buf, point);
+			printk(buf);
+
+			switch (point->type & IPIPE_TYPE_MASK) {
+				case IPIPE_TRACE_FUNC:
+					printk("           ");
+					break;
+
+				case IPIPE_TRACE_PID:
+					__ipipe_get_task_info(task_info,
+							      point, 1);
+					printk(task_info);
+					break;
+
+				default:
+					printk("0x%08lx ", point->v);
+			}
+
+			time =3D __ipipe_signed_tsc2us(point->timestamp -
+				panic_path->point[start].timestamp);
+			printk(" %5ld ", time);
+
+			__ipipe_print_symname(NULL, point->eip);
+			printk(" (");
+			__ipipe_print_symname(NULL, point->parent_eip);
+			printk(")\n");
+		}
+		pos =3D WRAP_POINT_NO(pos - 1);
+	}
+
+	panic_path =3D NULL;
+}
+EXPORT_SYMBOL(ipipe_trace_panic_dump);
+#endif /* CONFIG_IPIPE_TRACE_PANIC */
+
+
+/* --- /proc output --- */
+
+static notrace int __ipipe_in_critical_trpath(long point_no)
+{
+	return ((WRAP_POINT_NO(point_no-print_path->begin) <
+	         WRAP_POINT_NO(print_path->end-print_path->begin)) ||
+	        ((print_path->end =3D=3D print_path->begin) &&
+	         (WRAP_POINT_NO(point_no-print_path->end) >
+	          print_post_trace)));
+}
+
+static long __ipipe_signed_tsc2us(long long tsc)
+{
+        unsigned long long abs_tsc;
+        long us;
+
+	/* ipipe_tsc2us works on unsigned =3D> handle sign separately */
+        abs_tsc =3D (tsc >=3D 0) ? tsc : -tsc;
+        us =3D ipipe_tsc2us(abs_tsc);
+        if (tsc < 0)
+                return -us;
+        else
+                return us;
+}
+
+static void
+__ipipe_trace_point_type(char *buf, struct ipipe_trace_point *point)
+{
+	switch (point->type & IPIPE_TYPE_MASK) {
+		case IPIPE_TRACE_FUNC:
+			strcpy(buf, "func    ");
+			break;
+
+		case IPIPE_TRACE_BEGIN:
+			strcpy(buf, "begin   ");
+			break;
+
+		case IPIPE_TRACE_END:
+			strcpy(buf, "end     ");
+			break;
+
+		case IPIPE_TRACE_FREEZE:
+			strcpy(buf, "freeze  ");
+			break;
+
+		case IPIPE_TRACE_SPECIAL:
+			sprintf(buf, "(0x%02x)  ",
+				point->type >> IPIPE_TYPE_BITS);
+			break;
+
+		case IPIPE_TRACE_PID:
+			sprintf(buf, "[%5d] ", (pid_t)point->v);
+			break;
+	}
+}
+
+static void
+__ipipe_print_pathmark(struct seq_file *m, struct ipipe_trace_point *poi=
nt)
+{
+	char mark =3D ' ';
+	int point_no =3D point - print_path->point;
+	int i;
+
+	if (print_path->end =3D=3D point_no)
+		mark =3D '<';
+	else if (print_path->begin =3D=3D point_no)
+		mark =3D '>';
+	else if (__ipipe_in_critical_trpath(point_no))
+		mark =3D ':';
+	seq_printf(m, "%c%c", mark,
+	           (point->flags & IPIPE_TFLG_HWIRQ_OFF) ? '|' : ' ');
+
+	if (!verbose_trace)
+		return;
+
+	for (i =3D IPIPE_TFLG_DOMSTATE_BITS; i >=3D 0; i--)
+		seq_printf(m, "%c",
+			(IPIPE_TFLG_CURRENT_DOMAIN(point) =3D=3D i) ?
+			    (IPIPE_TFLG_DOMAIN_STALLED(point, i) ?
+				'#' : '+') :
+			(IPIPE_TFLG_DOMAIN_STALLED(point, i) ? '*' : ' '));
+}
+
+static void
+__ipipe_print_delay(struct seq_file *m, struct ipipe_trace_point *point)=

+{
+	unsigned long delay =3D 0;
+	int next;
+	char *mark =3D "  ";
+
+	next =3D WRAP_POINT_NO(point+1 - print_path->point);
+
+	if (next !=3D print_path->trace_pos)
+		delay =3D ipipe_tsc2ns(print_path->point[next].timestamp -
+		                     point->timestamp);
+
+	if (__ipipe_in_critical_trpath(point - print_path->point)) {
+		if (delay > IPIPE_DELAY_WARN)
+			mark =3D "! ";
+		else if (delay > IPIPE_DELAY_NOTE)
+			mark =3D "+ ";
+	}
+	seq_puts(m, mark);
+
+	if (verbose_trace)
+		seq_printf(m, "%3lu.%03lu%c ", delay/1000, delay%1000,
+		           (point->flags & IPIPE_TFLG_NMI_HIT) ? 'N' : ' ');
+	else
+		seq_puts(m, " ");
+}
+
+static void __ipipe_print_symname(struct seq_file *m, unsigned long eip)=

+{
+	char namebuf[KSYM_NAME_LEN+1];
+	unsigned long size, offset;
+	const char *sym_name;
+	char *modname;
+
+	sym_name =3D kallsyms_lookup(eip, &size, &offset, &modname, namebuf);
+
+#ifdef CONFIG_IPIPE_TRACE_PANIC
+	if (!m) {
+		/* panic dump */
+		if (sym_name) {
+			printk("%s+0x%lx", sym_name, offset);
+			if (modname)
+				printk(" [%s]", modname);
+		}
+	} else
+#endif /* CONFIG_IPIPE_TRACE_PANIC */
+	{
+		if (sym_name) {
+			if (verbose_trace) {
+				seq_printf(m, "%s+0x%lx", sym_name, offset);
+				if (modname)
+					seq_printf(m, " [%s]", modname);
+			} else
+				seq_puts(m, sym_name);
+		} else
+			seq_printf(m, "<%08lx>", eip);
+	}
+}
+
+static void __ipipe_print_headline(struct seq_file *m)
+{
+	seq_printf(m, "Calibrated minimum trace-point overhead: %lu.%03lu "
+		   "us\n\n", trace_overhead/1000, trace_overhead%1000);
+
+	if (verbose_trace) {
+		const char *name[4] =3D { [0 ... 3] =3D "<unused>" };
+		struct list_head *pos;
+		int i =3D 0;
+
+		list_for_each_prev(pos, &__ipipe_pipeline) {
+			struct ipipe_domain *ipd =3D
+				list_entry(pos, struct ipipe_domain, p_link);
+
+			name[i] =3D ipd->name;
+			if (++i > 3)
+				break;
+		}
+
+		seq_printf(m,
+		           " +----- Hard IRQs ('|': locked)\n"
+		           " |+---- %s\n"
+		           " ||+--- %s\n"
+		           " |||+-- %s\n"
+		           " ||||+- %s%s\n"
+		           " |||||                        +---------- "
+		               "Delay flag ('+': > %d us, '!': > %d us)\n"
+		           " |||||                        |        +- "
+		               "NMI noise ('N')\n"
+		           " |||||                        |        |\n"
+		           "      Type    User Val.   Time    Delay  Function "
+		               "(Parent)\n",
+		           name[3], name[2], name[1], name[0],
+		           name[0] ? " ('*': domain stalled, '+': current, "
+		               "'#': current+stalled)" : "",
+		           IPIPE_DELAY_NOTE/1000, IPIPE_DELAY_WARN/1000);
+	} else
+		seq_printf(m,
+		           " +--------------- Hard IRQs ('|': locked)\n"
+		           " |             +- Delay flag "
+		               "('+': > %d us, '!': > %d us)\n"
+		           " |             |\n"
+		           "  Type     Time   Function (Parent)\n",
+		           IPIPE_DELAY_NOTE/1000, IPIPE_DELAY_WARN/1000);
+}
+
+static void *__ipipe_max_prtrace_start(struct seq_file *m, loff_t *pos)
+{
+	loff_t n =3D *pos;
+
+	mutex_lock(&out_mutex);
+
+	if (!n) {
+		struct ipipe_trace_path *tp;
+		unsigned long length_usecs;
+		int points, cpu;
+		unsigned long flags;
+
+		/* protect against max_path/frozen_path updates while we
+		 * haven't locked our target path, also avoid recursively
+		 * taking global_path_lock from NMI context */
+		flags =3D __ipipe_global_path_lock();
+
+		/* find the longest of all per-cpu paths */
+		print_path =3D NULL;
+		for_each_online_cpu(cpu) {
+			tp =3D &per_cpu(trace_path, cpu)[per_cpu(max_path, cpu)];
+			if ((print_path =3D=3D NULL) ||
+			    (tp->length > print_path->length)) {
+				print_path =3D tp;
+				break;
+			}
+		}
+		print_path->dump_lock =3D 1;
+
+		__ipipe_global_path_unlock(flags);
+
+		/* does this path actually contain data? */
+		if (print_path->end =3D=3D print_path->begin)
+			return NULL;
+
+		/* number of points inside the critical path */
+		points =3D WRAP_POINT_NO(print_path->end-print_path->begin+1);
+
+		/* pre- and post-tracing length, post-trace length was frozen
+		   in __ipipe_trace, pre-trace may have to be reduced due to
+		   buffer overrun */
+		print_pre_trace  =3D pre_trace;
+		print_post_trace =3D WRAP_POINT_NO(print_path->trace_pos -
+		                                 print_path->end - 1);
+		if (points+pre_trace+print_post_trace > IPIPE_TRACE_POINTS - 1)
+			print_pre_trace =3D IPIPE_TRACE_POINTS - 1 - points -
+				print_post_trace;
+
+		length_usecs =3D ipipe_tsc2us(print_path->length);
+		seq_printf(m, "I-pipe worst-case tracing service on %s/ipipe-%s\n"
+			"------------------------------------------------------------\n",
+			UTS_RELEASE, IPIPE_ARCH_STRING);
+		seq_printf(m, "CPU: %d, Begin: %lld cycles, Trace Points: "
+			"%d (-%d/+%d), Length: %lu us\n",
+			cpu, print_path->point[print_path->begin].timestamp,
+			points, print_pre_trace, print_post_trace, length_usecs);
+		__ipipe_print_headline(m);
+	}
+
+	/* check if we are inside the trace range */
+	if (n >=3D WRAP_POINT_NO(print_path->end - print_path->begin + 1 +
+	                       print_pre_trace + print_post_trace))
+		return NULL;
+
+	/* return the next point to be shown */
+	return &print_path->point[WRAP_POINT_NO(print_path->begin -
+	                                        print_pre_trace + n)];
+}
+
+static void *__ipipe_prtrace_next(struct seq_file *m, void *p, loff_t *p=
os)
+{
+	loff_t n =3D ++*pos;
+
+	/* check if we are inside the trace range with the next entry */
+	if (n >=3D WRAP_POINT_NO(print_path->end - print_path->begin + 1 +
+	                       print_pre_trace + print_post_trace))
+		return NULL;
+
+	/* return the next point to be shown */
+	return &print_path->point[WRAP_POINT_NO(print_path->begin -
+	                                        print_pre_trace + *pos)];
+}
+
+static void __ipipe_prtrace_stop(struct seq_file *m, void *p)
+{
+	if (print_path)
+		print_path->dump_lock =3D 0;
+	mutex_unlock(&out_mutex);
+}
+
+static int __ipipe_prtrace_show(struct seq_file *m, void *p)
+{
+	long time;
+	struct ipipe_trace_point *point =3D p;
+	char buf[16];
+
+	if (!point->eip) {
+		seq_puts(m, "-<invalid>-\n");
+		return 0;
+	}
+
+	__ipipe_print_pathmark(m, point);
+	__ipipe_trace_point_type(buf, point);
+	seq_puts(m, buf);
+	if (verbose_trace)
+		switch (point->type & IPIPE_TYPE_MASK) {
+			case IPIPE_TRACE_FUNC:
+				seq_puts(m, "           ");
+				break;
+
+			case IPIPE_TRACE_PID:
+				__ipipe_get_task_info(buf, point, 0);
+				seq_puts(m, buf);
+				break;
+
+			default:
+				seq_printf(m, "0x%08lx ", point->v);
+		}
+
+	time =3D __ipipe_signed_tsc2us(point->timestamp -
+		print_path->point[print_path->begin].timestamp);
+	seq_printf(m, "%5ld", time);
+
+	__ipipe_print_delay(m, point);
+	__ipipe_print_symname(m, point->eip);
+	seq_puts(m, " (");
+	__ipipe_print_symname(m, point->parent_eip);
+	seq_puts(m, ")\n");
+
+	return 0;
+}
+
+static struct seq_operations __ipipe_max_ptrace_ops =3D {
+	.start =3D __ipipe_max_prtrace_start,
+	.next  =3D __ipipe_prtrace_next,
+	.stop  =3D __ipipe_prtrace_stop,
+	.show  =3D __ipipe_prtrace_show
+};
+
+static int __ipipe_max_prtrace_open(struct inode *inode, struct file *fi=
le)
+{
+	return seq_open(file, &__ipipe_max_ptrace_ops);
+}
+
+static ssize_t
+__ipipe_max_reset(struct file *file, const char __user *pbuffer,
+                  size_t count, loff_t *data)
+{
+	mutex_lock(&out_mutex);
+	ipipe_trace_max_reset();
+	mutex_unlock(&out_mutex);
+
+	return count;
+}
+
+struct file_operations __ipipe_max_prtrace_fops =3D {
+	.open       =3D __ipipe_max_prtrace_open,
+	.read       =3D seq_read,
+	.write      =3D __ipipe_max_reset,
+	.llseek     =3D seq_lseek,
+	.release    =3D seq_release,
+};
+
+static void *__ipipe_frozen_prtrace_start(struct seq_file *m, loff_t *po=
s)
+{
+	loff_t n =3D *pos;
+
+	mutex_lock(&out_mutex);
+
+	if (!n) {
+		struct ipipe_trace_path *tp;
+		int cpu;
+		unsigned long flags;
+
+		/* protect against max_path/frozen_path updates while we
+		 * haven't locked our target path, also avoid recursively
+		 * taking global_path_lock from NMI context */
+		flags =3D __ipipe_global_path_lock();
+
+		/* find the first of all per-cpu frozen paths */
+		print_path =3D NULL;
+		for_each_online_cpu(cpu) {
+			tp =3D &per_cpu(trace_path, cpu)[per_cpu(frozen_path, cpu)];
+			if (tp->end >=3D 0) {
+				print_path =3D tp;
+				break;
+			}
+		}
+		if (print_path)
+			print_path->dump_lock =3D 1;
+
+		__ipipe_global_path_unlock(flags);
+
+		if (!print_path)
+			return NULL;
+
+		/* back- and post-tracing length, post-trace length was frozen
+		   in __ipipe_trace, back-trace may have to be reduced due to
+		   buffer overrun */
+		print_pre_trace  =3D back_trace-1; /* substract freeze point */
+		print_post_trace =3D WRAP_POINT_NO(print_path->trace_pos -
+		                                 print_path->end - 1);
+		if (1+pre_trace+print_post_trace > IPIPE_TRACE_POINTS - 1)
+			print_pre_trace =3D IPIPE_TRACE_POINTS - 2 -
+				print_post_trace;
+
+		seq_printf(m, "I-pipe frozen back-tracing service on %s/ipipe-%s\n"
+			"------------------------------------------------------"
+			"------\n",
+			UTS_RELEASE, IPIPE_ARCH_STRING);
+		seq_printf(m, "CPU: %d, Freeze: %lld cycles, Trace Points: %d (+%d)\n"=
,
+			cpu, print_path->point[print_path->begin].timestamp,
+			print_pre_trace+1, print_post_trace);
+		__ipipe_print_headline(m);
+	}
+
+	/* check if we are inside the trace range */
+	if (n >=3D print_pre_trace + 1 + print_post_trace)
+		return NULL;
+
+	/* return the next point to be shown */
+	return &print_path->point[WRAP_POINT_NO(print_path->begin-
+	                                        print_pre_trace+n)];
+}
+
+static struct seq_operations __ipipe_frozen_ptrace_ops =3D {
+	.start =3D __ipipe_frozen_prtrace_start,
+	.next  =3D __ipipe_prtrace_next,
+	.stop  =3D __ipipe_prtrace_stop,
+	.show  =3D __ipipe_prtrace_show
+};
+
+static int __ipipe_frozen_prtrace_open(struct inode *inode, struct file =
*file)
+{
+	return seq_open(file, &__ipipe_frozen_ptrace_ops);
+}
+
+static ssize_t
+__ipipe_frozen_ctrl(struct file *file, const char __user *pbuffer,
+                    size_t count, loff_t *data)
+{
+	char *end, buf[16];
+	int val;
+	int n;
+
+	n =3D (count > sizeof(buf) - 1) ? sizeof(buf) - 1 : count;
+
+	if (copy_from_user(buf, pbuffer, n))
+		return -EFAULT;
+
+	buf[n] =3D '\0';
+	val =3D simple_strtol(buf, &end, 0);
+
+	if (((*end !=3D '\0') && !isspace(*end)) || (val < 0))
+		return -EINVAL;
+
+	mutex_lock(&out_mutex);
+	ipipe_trace_frozen_reset();
+	if (val > 0)
+		ipipe_trace_freeze(-1);
+	mutex_unlock(&out_mutex);
+
+	return count;
+}
+
+struct file_operations __ipipe_frozen_prtrace_fops =3D {
+	.open       =3D __ipipe_frozen_prtrace_open,
+	.read       =3D seq_read,
+	.write      =3D __ipipe_frozen_ctrl,
+	.llseek     =3D seq_lseek,
+	.release    =3D seq_release,
+};
+
+static int __ipipe_rd_proc_val(char *page, char **start, off_t off,
+                               int count, int *eof, void *data)
+{
+	int len;
+
+	len =3D sprintf(page, "%u\n", *(int *)data);
+	len -=3D off;
+	if (len <=3D off + count)
+		*eof =3D 1;
+	*start =3D page + off;
+	if (len > count)
+		len =3D count;
+	if (len < 0)
+		len =3D 0;
+
+	return len;
+}
+
+static int __ipipe_wr_proc_val(struct file *file, const char __user *buf=
fer,
+                               unsigned long count, void *data)
+{
+	char *end, buf[16];
+	int val;
+	int n;
+
+	n =3D (count > sizeof(buf) - 1) ? sizeof(buf) - 1 : count;
+
+	if (copy_from_user(buf, buffer, n))
+		return -EFAULT;
+
+	buf[n] =3D '\0';
+	val =3D simple_strtol(buf, &end, 0);
+
+	if (((*end !=3D '\0') && !isspace(*end)) || (val < 0))
+		return -EINVAL;
+
+	mutex_lock(&out_mutex);
+	*(int *)data =3D val;
+	mutex_unlock(&out_mutex);
+
+	return count;
+}
+
+static int __ipipe_rd_trigger(char *page, char **start, off_t off, int c=
ount,
+			      int *eof, void *data)
+{
+	int len;
+
+	if (!trigger_begin)
+		return 0;
+
+	len =3D sprint_symbol(page, trigger_begin);
+	page[len++] =3D '\n';
+
+	len -=3D off;
+	if (len <=3D off + count)
+		*eof =3D 1;
+	*start =3D page + off;
+	if (len > count)
+		len =3D count;
+	if (len < 0)
+		len =3D 0;
+
+	return len;
+}
+
+static int __ipipe_wr_trigger(struct file *file, const char __user *buff=
er,
+			      unsigned long count, void *data)
+{
+	char buf[KSYM_SYMBOL_LEN];
+	unsigned long begin, end;
+
+	if (count > sizeof(buf) - 1)
+		count =3D sizeof(buf) - 1;
+	if (copy_from_user(buf, buffer, count))
+		return -EFAULT;
+	buf[count] =3D 0;
+	if (buf[count-1] =3D=3D '\n')
+		buf[count-1] =3D 0;
+
+	begin =3D kallsyms_lookup_name(buf);
+	if (!begin || !kallsyms_lookup_size_offset(begin, &end, NULL))
+		return -ENOENT;
+	end +=3D begin - 1;
+
+	mutex_lock(&out_mutex);
+	/* invalidate the current range before setting a new one */
+	trigger_end =3D 0;
+	wmb();
+	ipipe_trace_frozen_reset();
+
+	/* set new range */
+	trigger_begin =3D begin;
+	wmb();
+	trigger_end =3D end;
+	mutex_unlock(&out_mutex);
+
+	return count;
+}
+
+extern struct proc_dir_entry *ipipe_proc_root;
+
+static void __init
+__ipipe_create_trace_proc_val(struct proc_dir_entry *trace_dir,
+                              const char *name, int *value_ptr)
+{
+	struct proc_dir_entry *entry;
+
+	entry =3D create_proc_entry(name, 0644, trace_dir);
+	if (entry) {
+		entry->data =3D value_ptr;
+		entry->read_proc =3D __ipipe_rd_proc_val;
+		entry->write_proc =3D __ipipe_wr_proc_val;
+		entry->owner =3D THIS_MODULE;
+	}
+}
+
+void __init __ipipe_init_tracer(void)
+{
+	struct proc_dir_entry *trace_dir;
+	struct proc_dir_entry *entry;
+	unsigned long long start, end, min =3D ULLONG_MAX;
+	int i;
+#ifdef CONFIG_IPIPE_TRACE_VMALLOC
+	int cpu, path;
+
+	for_each_possible_cpu(cpu) {
+		struct ipipe_trace_path *tp_buf;
+
+		tp_buf =3D vmalloc_node(sizeof(struct ipipe_trace_path) *
+				      IPIPE_TRACE_PATHS, cpu_to_node(cpu));
+		if (!tp_buf) {
+			printk(KERN_ERR "I-pipe: "
+			       "insufficient memory for trace buffer.\n");
+			return;
+		}
+		memset(tp_buf, 0,
+		       sizeof(struct ipipe_trace_path) * IPIPE_TRACE_PATHS);
+		for (path =3D 0; path < IPIPE_TRACE_PATHS; path++) {
+			tp_buf[path].begin =3D -1;
+			tp_buf[path].end   =3D -1;
+		}
+		per_cpu(trace_path, cpu) =3D tp_buf;
+	}
+#endif /* CONFIG_IPIPE_TRACE_VMALLOC */
+	ipipe_trace_enable =3D CONFIG_IPIPE_TRACE_ENABLE_VALUE;
+
+	/* Calculate minimum overhead of __ipipe_trace() */
+	local_irq_disable_hw();
+	for (i =3D 0; i < 100; i++) {
+		ipipe_read_tsc(start);
+		__ipipe_trace(IPIPE_TRACE_FUNC, __BUILTIN_RETURN_ADDRESS0,
+			      __BUILTIN_RETURN_ADDRESS1, 0);
+		ipipe_read_tsc(end);
+
+		end -=3D start;
+		if (end < min)
+			min =3D end;
+	}
+	local_irq_enable_hw();
+	trace_overhead =3D ipipe_tsc2ns(min);
+
+	trace_dir =3D create_proc_entry("trace", S_IFDIR, ipipe_proc_root);
+
+	entry =3D create_proc_entry("max", 0644, trace_dir);
+	if (entry)
+		entry->proc_fops =3D &__ipipe_max_prtrace_fops;
+
+	entry =3D create_proc_entry("frozen", 0644, trace_dir);
+	if (entry)
+		entry->proc_fops =3D &__ipipe_frozen_prtrace_fops;
+
+	entry =3D create_proc_entry("trigger", 0644, trace_dir);
+	if (entry) {
+		entry->read_proc =3D __ipipe_rd_trigger;
+		entry->write_proc =3D __ipipe_wr_trigger;
+		entry->owner =3D THIS_MODULE;
+	}
+
+	__ipipe_create_trace_proc_val(trace_dir, "pre_trace_points",
+	                              &pre_trace);
+	__ipipe_create_trace_proc_val(trace_dir, "post_trace_points",
+	                              &post_trace);
+	__ipipe_create_trace_proc_val(trace_dir, "back_trace_points",
+	                              &back_trace);
+	__ipipe_create_trace_proc_val(trace_dir, "verbose",
+	                              &verbose_trace);
+	__ipipe_create_trace_proc_val(trace_dir, "enable",
+	                              &ipipe_trace_enable);
+}
Index: kernel/ipipe/Kconfig.debug
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- kernel/ipipe/Kconfig.debug	(revision 0)
+++ kernel/ipipe/Kconfig.debug	(revision 0)
@@ -0,0 +1,88 @@
+config IPIPE_DEBUG
+	bool "I-pipe debugging"
+	depends on IPIPE
+
+config IPIPE_DEBUG_CONTEXT
+	bool "Check for illicit cross-domain calls"
+	depends on IPIPE_DEBUG
+	default y
+	---help---
+	  Enable this feature to arm checkpoints in the kernel that
+	  verify the correct invocation context. On entry of critical
+	  Linux services a warning is issued if the caller is not
+	  running over the root domain.
+
+config IPIPE_TRACE
+	bool "Latency tracing"
+	depends on IPIPE_DEBUG
+	select FRAME_POINTER
+	select KALLSYMS
+	select PROC_FS
+	---help---
+	  Activate this option if you want to use per-function tracing of
+	  the kernel. The tracer will collect data via instrumentation
+	  features like the one below or with the help of explicite calls
+	  of ipipe_trace_xxx(). See include/linux/ipipe_trace.h for the
+	  in-kernel tracing API. The collected data and runtime control
+	  is available via /proc/ipipe/trace/*.
+
+if IPIPE_TRACE
+
+config IPIPE_TRACE_ENABLE
+	bool "Enable tracing on boot"
+	default y
+	---help---
+	  Disable this option if you want to arm the tracer after booting
+	  manually ("echo 1 > /proc/ipipe/tracer/enable"). This can reduce
+	  boot time on slow embedded devices due to the tracer overhead.
+
+config IPIPE_TRACE_MCOUNT
+	bool "Instrument function entries"
+	default y
+	---help---
+	  When enabled, records every kernel function entry in the tracer
+	  log. While this slows down the system noticeably, it provides
+	  the highest level of information about the flow of events.
+	  However, it can be switch off in order to record only explicit
+	  I-pipe trace points.
+
+config IPIPE_TRACE_IRQSOFF
+	bool "Trace IRQs-off times"
+	default y
+	---help---
+	  Activate this option if I-pipe shall trace the longest path
+	  with hard-IRQs switched off.
+
+config IPIPE_TRACE_SHIFT
+	int "Depth of trace log (14 =3D> 16Kpoints, 15 =3D> 32Kpoints)"
+	range 10 18
+	default 14
+	---help---
+	  The number of trace points to hold tracing data for each
+	  trace path, as a power of 2.
+
+config IPIPE_TRACE_VMALLOC
+	bool "Use vmalloc'ed trace buffer"
+	default y if EMBEDDED
+	---help---
+	  Instead of reserving static kernel data, the required buffer
+	  is allocated via vmalloc during boot-up when this option is
+	  enabled. This can help to start systems that are low on memory,
+	  but it slightly degrades overall performance. Try this option
+	  when a traced kernel hangs unexpectedly at boot time.
+
+config IPIPE_TRACE_PANIC
+	bool "Enable panic back traces"
+	default y
+	---help---
+	  Provides services to freeze and dump a back trace on panic
+	  situations. This is used on IPIPE_DEBUG_CONTEXT exceptions
+	  as well as ordinary kernel oopses. You can control the number
+	  of printed back trace points via /proc/ipipe/trace.
+
+config IPIPE_TRACE_ENABLE_VALUE
+	int
+	default 0 if !IPIPE_TRACE_ENABLE
+	default 1 if IPIPE_TRACE_ENABLE
+
+endif
Index: kernel/ipipe/core.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- kernel/ipipe/core.c	(revision 0)
+++ kernel/ipipe/core.c	(revision 0)
@@ -0,0 +1,1632 @@
+/* -*- linux-c -*-
+ * linux/kernel/ipipe/core.c
+ *
+ * Copyright (C) 2002-2005 Philippe Gerum.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation, Inc., 675 Mass Ave, Cambridge MA 02139,=

+ * USA; either version 2 of the License, or (at your option) any later
+ * version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307,=
 USA.
+ *
+ * Architecture-independent I-PIPE core support.
+ */
+
+#include <linux/version.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/sched.h>
+#include <linux/sched.h>
+#include <linux/kallsyms.h>
+#include <linux/interrupt.h>
+#include <linux/bitops.h>
+#include <linux/tick.h>
+#ifdef CONFIG_PROC_FS
+#include <linux/proc_fs.h>
+#include <linux/seq_file.h>
+#endif	/* CONFIG_PROC_FS */
+#include <linux/ipipe_trace.h>
+#include <linux/ipipe_tickdev.h>
+#include <linux/irq.h>
+
+static int __ipipe_ptd_key_count;
+
+static unsigned long __ipipe_ptd_key_map;
+
+static unsigned long __ipipe_domain_slot_map;
+
+struct ipipe_domain ipipe_root;
+
+#ifndef CONFIG_SMP
+/*
+ * Create an alias to the unique root status, so that arch-dep code
+ * may get simple and easy access to this percpu variable.  We also
+ * create an array of pointers to the percpu domain data; this tends
+ * to produce a better code when reaching non-root domains. We make
+ * sure that the early boot code would be able to dereference the
+ * pointer to the root domain data safely by statically initializing
+ * its value (local_irq*() routines depend on this).
+ */
+#if __GNUC__ >=3D 4
+extern unsigned long __ipipe_root_status
+__attribute__((alias(__stringify(__raw_get_cpu_var(ipipe_percpu_darray))=
)));
+EXPORT_SYMBOL(__ipipe_root_status);
+#else /* __GNUC__ < 4 */
+/*
+ * Work around a GCC 3.x issue making alias symbols unusable as
+ * constant initializers.
+ */
+unsigned long *const __ipipe_root_status_addr =3D &__raw_get_cpu_var(ipi=
pe_percpu_darray)[0].status;
+EXPORT_SYMBOL(__ipipe_root_status_addr);
+#endif /* __GNUC__ < 4 */
+
+DEFINE_PER_CPU(struct ipipe_percpu_domain_data *, ipipe_percpu_daddr[CON=
FIG_IPIPE_DOMAINS]) =3D
+{ [0] =3D (struct ipipe_percpu_domain_data *)&__raw_get_cpu_var(ipipe_pe=
rcpu_darray) };
+EXPORT_PER_CPU_SYMBOL(ipipe_percpu_daddr);
+#endif /* !CONFIG_SMP */
+
+DEFINE_PER_CPU(struct ipipe_percpu_domain_data, ipipe_percpu_darray[CONF=
IG_IPIPE_DOMAINS]) =3D
+{ [0] =3D { .status =3D IPIPE_STALL_MASK } }; /* Root domain stalled on =
each CPU at startup. */
+
+DEFINE_PER_CPU(struct ipipe_domain *, ipipe_percpu_domain) =3D { &ipipe_=
root };
+
+static IPIPE_DEFINE_SPINLOCK(__ipipe_pipelock);
+
+LIST_HEAD(__ipipe_pipeline);
+
+unsigned long __ipipe_virtual_irq_map;
+
+#ifdef CONFIG_PRINTK
+unsigned __ipipe_printk_virq;
+#endif /* CONFIG_PRINTK */
+
+int __ipipe_event_monitors[IPIPE_NR_EVENTS];
+
+#ifdef CONFIG_GENERIC_CLOCKEVENTS
+
+DECLARE_PER_CPU(struct tick_device, tick_cpu_device);
+
+static DEFINE_PER_CPU(struct ipipe_tick_device, ipipe_tick_cpu_device);
+
+int ipipe_request_tickdev(const char *devname,
+			  void (*emumode)(enum clock_event_mode mode,
+					  struct clock_event_device *cdev),
+			  int (*emutick)(unsigned long delta,
+					 struct clock_event_device *cdev),
+			  int cpu, unsigned long *tmfreq)
+{
+	struct ipipe_tick_device *itd;
+	struct tick_device *slave;
+	struct clock_event_device *evtdev;
+	unsigned long long freq;
+	unsigned long flags;
+	int status;
+
+	flags =3D ipipe_critical_enter(NULL);
+
+	itd =3D &per_cpu(ipipe_tick_cpu_device, cpu);
+
+	if (itd->slave !=3D NULL) {
+		status =3D -EBUSY;
+		goto out;
+	}
+
+	slave =3D &per_cpu(tick_cpu_device, cpu);
+
+	if (strcmp(slave->evtdev->name, devname)) {
+		/*
+		 * No conflict so far with the current tick device,
+		 * check whether the requested device is sane and has
+		 * been blessed by the kernel.
+		 */
+		status =3D __ipipe_check_tickdev(devname) ?
+			CLOCK_EVT_MODE_UNUSED : CLOCK_EVT_MODE_SHUTDOWN;
+		goto out;
+	}
+
+	/*
+	 * Our caller asks for using the same clock event device for
+	 * ticking than we do, let's create a tick emulation device to
+	 * interpose on the set_next_event() method, so that we may
+	 * both manage the device in oneshot mode. Only the tick
+	 * emulation code will actually program the clockchip hardware
+	 * for the next shot, though.
+	 *
+	 * CAUTION: we still have to grab the tick device even when it
+	 * current runs in periodic mode, since the kernel may switch
+	 * to oneshot dynamically (highres/no_hz tick mode).
+	 */
+
+	evtdev =3D slave->evtdev;
+	status =3D evtdev->mode;
+
+        if (status =3D=3D CLOCK_EVT_MODE_SHUTDOWN)
+                goto out;
+
+	itd->slave =3D slave;
+	itd->emul_set_mode =3D emumode;
+	itd->emul_set_tick =3D emutick;
+	itd->real_set_mode =3D evtdev->set_mode;
+	itd->real_set_tick =3D evtdev->set_next_event;
+	itd->real_max_delta_ns =3D evtdev->max_delta_ns;
+	itd->real_mult =3D evtdev->mult;
+	itd->real_shift =3D evtdev->shift;
+	freq =3D (1000000000ULL * evtdev->mult) >> evtdev->shift;
+	*tmfreq =3D (unsigned long)freq;
+	evtdev->set_mode =3D emumode;
+	evtdev->set_next_event =3D emutick;
+	evtdev->max_delta_ns =3D ULONG_MAX;
+	evtdev->mult =3D 1;
+	evtdev->shift =3D 0;
+out:
+	ipipe_critical_exit(flags);
+
+	return status;
+}
+
+void ipipe_release_tickdev(int cpu)
+{
+	struct ipipe_tick_device *itd;
+	struct tick_device *slave;
+	struct clock_event_device *evtdev;
+	unsigned long flags;
+
+	flags =3D ipipe_critical_enter(NULL);
+
+	itd =3D &per_cpu(ipipe_tick_cpu_device, cpu);
+
+	if (itd->slave !=3D NULL) {
+		slave =3D &per_cpu(tick_cpu_device, cpu);
+		evtdev =3D slave->evtdev;
+		evtdev->set_mode =3D itd->real_set_mode;
+		evtdev->set_next_event =3D itd->real_set_tick;
+		evtdev->max_delta_ns =3D itd->real_max_delta_ns;
+		evtdev->mult =3D itd->real_mult;
+		evtdev->shift =3D itd->real_shift;
+		itd->slave =3D NULL;
+	}
+
+	ipipe_critical_exit(flags);
+}
+
+#endif /* CONFIG_GENERIC_CLOCKEVENTS */
+
+/*
+ * ipipe_init() -- Initialization routine of the IPIPE layer. Called
+ * by the host kernel early during the boot procedure.
+ */
+void __init ipipe_init(void)
+{
+	struct ipipe_domain *ipd =3D &ipipe_root;
+
+	__ipipe_check_platform();	/* Do platform dependent checks first. */
+
+	/*
+	 * A lightweight registration code for the root domain. We are
+	 * running on the boot CPU, hw interrupts are off, and
+	 * secondary CPUs are still lost in space.
+	 */
+
+	/* Reserve percpu data slot #0 for the root domain. */
+	ipd->slot =3D 0;
+	set_bit(0, &__ipipe_domain_slot_map);
+
+	ipd->name =3D "Linux";
+	ipd->domid =3D IPIPE_ROOT_ID;
+	ipd->priority =3D IPIPE_ROOT_PRIO;
+
+	__ipipe_init_stage(ipd);
+
+	INIT_LIST_HEAD(&ipd->p_link);
+	list_add_tail(&ipd->p_link, &__ipipe_pipeline);
+
+	__ipipe_init_platform();
+
+#ifdef CONFIG_PRINTK
+	__ipipe_printk_virq =3D ipipe_alloc_virq();	/* Cannot fail here. */
+	ipd->irqs[__ipipe_printk_virq].handler =3D &__ipipe_flush_printk;
+	ipd->irqs[__ipipe_printk_virq].cookie =3D NULL;
+	ipd->irqs[__ipipe_printk_virq].acknowledge =3D NULL;
+	ipd->irqs[__ipipe_printk_virq].control =3D IPIPE_HANDLE_MASK;
+#endif /* CONFIG_PRINTK */
+
+	__ipipe_enable_pipeline();
+
+	printk(KERN_INFO "I-pipe %s: pipeline enabled.\n",
+	       IPIPE_VERSION_STRING);
+}
+
+void __ipipe_init_stage(struct ipipe_domain *ipd)
+{
+	int cpu, n;
+
+	for_each_online_cpu(cpu) {
+
+		ipipe_percpudom(ipd, irqpend_himask, cpu) =3D 0;
+
+		for (n =3D 0; n < IPIPE_IRQ_IWORDS; n++) {
+			ipipe_percpudom(ipd, irqpend_lomask, cpu)[n] =3D 0;
+			ipipe_percpudom(ipd, irqheld_mask, cpu)[n] =3D 0;
+		}
+
+		for (n =3D 0; n < IPIPE_NR_IRQS; n++)
+			ipipe_percpudom(ipd, irqall, cpu)[n] =3D 0;
+
+		ipipe_percpudom(ipd, evsync, cpu) =3D 0;
+	}
+
+	for (n =3D 0; n < IPIPE_NR_IRQS; n++) {
+		ipd->irqs[n].acknowledge =3D NULL;
+		ipd->irqs[n].handler =3D NULL;
+		ipd->irqs[n].control =3D IPIPE_PASS_MASK;	/* Pass but don't handle */
+	}
+
+	for (n =3D 0; n < IPIPE_NR_EVENTS; n++)
+		ipd->evhand[n] =3D NULL;
+
+	ipd->evself =3D 0LL;
+	mutex_init(&ipd->mutex);
+
+	__ipipe_hook_critical_ipi(ipd);
+}
+
+void __ipipe_cleanup_domain(struct ipipe_domain *ipd)
+{
+	ipipe_unstall_pipeline_from(ipd);
+
+#ifdef CONFIG_SMP
+	{
+		int cpu;
+
+		for_each_online_cpu(cpu) {
+			while (ipipe_percpudom(ipd, irqpend_himask, cpu) !=3D 0)
+				cpu_relax();
+		}
+	}
+#else
+	__raw_get_cpu_var(ipipe_percpu_daddr)[ipd->slot] =3D NULL;
+#endif
+
+	clear_bit(ipd->slot, &__ipipe_domain_slot_map);
+}
+
+void __ipipe_unstall_root(void)
+{
+#ifndef CONFIG_IPIPE_DEBUG_CONTEXT
+	BUG_ON(!ipipe_root_domain_p);
+#endif
+
+        local_irq_disable_hw();
+
+        __clear_bit(IPIPE_STALL_FLAG, &ipipe_root_cpudom_var(status));
+
+        if (unlikely(ipipe_root_cpudom_var(irqpend_himask) !=3D 0))
+                __ipipe_sync_pipeline(IPIPE_IRQMASK_ANY);
+
+        local_irq_enable_hw();
+}
+
+void __ipipe_restore_root(unsigned long x)
+{
+#ifndef CONFIG_IPIPE_DEBUG_CONTEXT
+	BUG_ON(!ipipe_root_domain_p);
+#endif
+
+	if (x)
+		__ipipe_stall_root();
+	else
+		__ipipe_unstall_root();
+}
+
+void fastcall ipipe_stall_pipeline_from(struct ipipe_domain *ipd)
+{
+	set_bit_safe(IPIPE_STALL_FLAG, &ipipe_cpudom_var(ipd, status));
+
+	if (__ipipe_pipeline_head_p(ipd))
+		local_irq_disable_hw();
+}
+
+unsigned long fastcall ipipe_test_and_stall_pipeline_from(struct ipipe_d=
omain *ipd)
+{
+	unsigned long x;
+
+	x =3D test_and_set_bit_safe(IPIPE_STALL_FLAG, &ipipe_cpudom_var(ipd, st=
atus));
+
+	if (__ipipe_pipeline_head_p(ipd))
+		local_irq_disable_hw();
+
+	return x;
+}
+
+/*
+ * ipipe_unstall_pipeline_from() -- Unstall the pipeline and
+ * synchronize pending interrupts for a given domain. See
+ * __ipipe_walk_pipeline() for more information.
+ */
+void fastcall ipipe_unstall_pipeline_from(struct ipipe_domain *ipd)
+{
+	struct list_head *pos;
+	unsigned long flags;
+
+	local_irq_save_hw(flags);
+
+	__clear_bit(IPIPE_STALL_FLAG, &ipipe_cpudom_var(ipd, status));
+
+	if (ipd =3D=3D ipipe_current_domain)
+		pos =3D &ipd->p_link;
+	else
+		pos =3D __ipipe_pipeline.next;
+
+	__ipipe_walk_pipeline(pos);
+
+	if (likely(__ipipe_pipeline_head_p(ipd)))
+		local_irq_enable_hw();
+	else
+		local_irq_restore_hw(flags);
+}
+
+unsigned long fastcall ipipe_test_and_unstall_pipeline_from(struct ipipe=
_domain *ipd)
+{
+	unsigned long x;
+
+	x =3D test_bit(IPIPE_STALL_FLAG, &ipipe_cpudom_var(ipd, status));
+	ipipe_unstall_pipeline_from(ipd);
+
+	return x;
+}
+
+void fastcall ipipe_restore_pipeline_from(struct ipipe_domain *ipd,
+					  unsigned long x)
+{
+	if (x)
+		ipipe_stall_pipeline_from(ipd);
+	else
+		ipipe_unstall_pipeline_from(ipd);
+}
+
+void ipipe_unstall_pipeline_head(void)
+{
+	struct ipipe_domain *head_domain;
+
+	local_irq_disable_hw();
+
+	head_domain =3D __ipipe_pipeline_head();
+	__clear_bit(IPIPE_STALL_FLAG, &ipipe_cpudom_var(head_domain, status));
+
+	if (unlikely(ipipe_cpudom_var(head_domain, irqpend_himask) !=3D 0)) {
+		if (likely(head_domain =3D=3D ipipe_current_domain))
+			__ipipe_sync_pipeline(IPIPE_IRQMASK_ANY);
+		else
+			__ipipe_walk_pipeline(&head_domain->p_link);
+        }
+
+	local_irq_enable_hw();
+}
+
+void fastcall __ipipe_restore_pipeline_head(struct ipipe_domain *head_do=
main, unsigned long x)
+{
+	local_irq_disable_hw();
+
+	if (x) {
+#ifdef CONFIG_DEBUG_KERNEL
+		static int warned;
+		if (!warned && test_and_set_bit(IPIPE_STALL_FLAG, &ipipe_cpudom_var(he=
ad_domain, status))) {
+			/*
+			 * Already stalled albeit ipipe_restore_pipeline_head()
+			 * should have detected it? Send a warning once.
+			 */
+			warned =3D 1;
+			printk(KERN_WARNING
+				   "I-pipe: ipipe_restore_pipeline_head() optimization failed.\n");
+			dump_stack();
+		}
+#else /* !CONFIG_DEBUG_KERNEL */
+		set_bit(IPIPE_STALL_FLAG, &ipipe_cpudom_var(head_domain, status));
+#endif /* CONFIG_DEBUG_KERNEL */
+	}
+	else {
+		__clear_bit(IPIPE_STALL_FLAG, &ipipe_cpudom_var(head_domain, status));=

+		if (unlikely(ipipe_cpudom_var(head_domain, irqpend_himask) !=3D 0)) {
+			if (likely(head_domain =3D=3D ipipe_current_domain))
+				__ipipe_sync_pipeline(IPIPE_IRQMASK_ANY);
+			else
+				__ipipe_walk_pipeline(&head_domain->p_link);
+		}
+		local_irq_enable_hw();
+	}
+}
+
+void fastcall __ipipe_spin_lock_irq(raw_spinlock_t *lock)
+{
+	local_irq_disable_hw();
+	__raw_spin_lock(lock);
+	__set_bit(IPIPE_STALL_FLAG, &ipipe_this_cpudom_var(status));
+}
+
+void fastcall __ipipe_spin_unlock_irq(raw_spinlock_t *lock)
+{
+	__raw_spin_unlock(lock);
+	__clear_bit(IPIPE_STALL_FLAG, &ipipe_this_cpudom_var(status));
+	local_irq_enable_hw();
+}
+
+unsigned long fastcall __ipipe_spin_lock_irqsave(raw_spinlock_t *lock)
+{
+	unsigned long flags;
+	int s;
+
+	local_irq_save_hw(flags);
+	__raw_spin_lock(lock);
+	s =3D __test_and_set_bit(IPIPE_STALL_FLAG, &ipipe_this_cpudom_var(statu=
s));
+
+	return raw_mangle_irq_bits(s, flags);
+}
+
+void fastcall __ipipe_spin_unlock_irqrestore(raw_spinlock_t *lock, unsig=
ned long x)
+{
+	__raw_spin_unlock(lock);
+	if (!raw_demangle_irq_bits(&x))
+		__clear_bit(IPIPE_STALL_FLAG, &ipipe_this_cpudom_var(status));
+	local_irq_restore_hw(x);
+}
+
+void fastcall __ipipe_spin_unlock_irqbegin(ipipe_spinlock_t *lock)
+{
+	__raw_spin_unlock(&lock->__raw_lock);
+}
+
+void fastcall __ipipe_spin_unlock_irqcomplete(unsigned long x)
+{
+	if (!raw_demangle_irq_bits(&x))
+		__clear_bit(IPIPE_STALL_FLAG, &ipipe_this_cpudom_var(status));
+	local_irq_restore_hw(x);
+}
+
+/* Must be called hw IRQs off. */
+void fastcall __ipipe_set_irq_pending(struct ipipe_domain *ipd, unsigned=
 irq)
+{
+	int level =3D irq >> IPIPE_IRQ_ISHIFT, rank =3D irq & IPIPE_IRQ_IMASK;
+
+	if (likely(!test_bit(IPIPE_LOCK_FLAG, &ipd->irqs[irq].control))) {
+		__set_bit(rank, &ipipe_cpudom_var(ipd, irqpend_lomask)[level]);
+		__set_bit(level,&ipipe_cpudom_var(ipd, irqpend_himask));
+	} else
+		__set_bit(rank, &ipipe_cpudom_var(ipd, irqheld_mask)[level]);
+
+	ipipe_cpudom_var(ipd, irqall)[irq]++;
+}
+
+/* Must be called hw IRQs off. */
+void fastcall __ipipe_lock_irq(struct ipipe_domain *ipd, int cpu, unsign=
ed irq)
+{
+	if (likely(!test_and_set_bit(IPIPE_LOCK_FLAG, &ipd->irqs[irq].control))=
) {
+		int level =3D irq >> IPIPE_IRQ_ISHIFT, rank =3D irq & IPIPE_IRQ_IMASK;=

+		if (__test_and_clear_bit(rank, &ipipe_percpudom(ipd, irqpend_lomask, c=
pu)[level]))
+			__set_bit(rank, &ipipe_cpudom_var(ipd, irqheld_mask)[level]);
+		if (ipipe_percpudom(ipd, irqpend_lomask, cpu)[level] =3D=3D 0)
+			__clear_bit(level, &ipipe_percpudom(ipd, irqpend_himask, cpu));
+	}
+}
+
+/* Must be called hw IRQs off. */
+void fastcall __ipipe_unlock_irq(struct ipipe_domain *ipd, unsigned irq)=

+{
+	int cpu;
+
+	if (likely(test_and_clear_bit(IPIPE_LOCK_FLAG, &ipd->irqs[irq].control)=
)) {
+		int level =3D irq >> IPIPE_IRQ_ISHIFT, rank =3D irq & IPIPE_IRQ_IMASK;=

+		for_each_online_cpu(cpu) {
+			if (test_and_clear_bit(rank, &ipipe_percpudom(ipd, irqheld_mask, cpu)=
[level])) {
+				/* We need atomic ops here: */
+				set_bit(rank, &ipipe_percpudom(ipd, irqpend_lomask, cpu)[level]);
+				set_bit(level, &ipipe_percpudom(ipd, irqpend_himask, cpu));
+			}
+		}
+	}
+}
+
+/* __ipipe_walk_pipeline(): Plays interrupts pending in the log. Must
+   be called with local hw interrupts disabled. */
+
+void fastcall __ipipe_walk_pipeline(struct list_head *pos)
+{
+	struct ipipe_domain *this_domain =3D ipipe_current_domain, *next_domain=
;
+
+	while (pos !=3D &__ipipe_pipeline) {
+
+		next_domain =3D list_entry(pos, struct ipipe_domain, p_link);
+
+		if (test_bit(IPIPE_STALL_FLAG, &ipipe_cpudom_var(next_domain, status))=
)
+			break;	/* Stalled stage -- do not go further. */
+
+		if (ipipe_cpudom_var(next_domain, irqpend_himask) !=3D 0) {
+
+			if (next_domain =3D=3D this_domain)
+				__ipipe_sync_pipeline(IPIPE_IRQMASK_ANY);
+			else {
+
+				ipipe_cpudom_var(this_domain, evsync) =3D 0;
+				ipipe_current_domain =3D next_domain;
+				ipipe_suspend_domain();	/* Sync stage and propagate interrupts. */
+
+				if (ipipe_current_domain =3D=3D next_domain)
+					ipipe_current_domain =3D this_domain;
+				/*
+				 * Otherwise, something changed the current domain under our
+				 * feet recycling the register set; do not override the new
+				 * domain.
+				 */
+
+				if (ipipe_cpudom_var(this_domain, irqpend_himask) !=3D 0 &&
+				    !test_bit(IPIPE_STALL_FLAG,
+					      &ipipe_cpudom_var(this_domain, status)))
+					__ipipe_sync_pipeline(IPIPE_IRQMASK_ANY);
+			}
+
+			break;
+		} else if (next_domain =3D=3D this_domain)
+			break;
+
+		pos =3D next_domain->p_link.next;
+	}
+}
+
+/*
+ * ipipe_suspend_domain() -- Suspend the current domain, switching to
+ * the next one which has pending work down the pipeline.
+ */
+void ipipe_suspend_domain(void)
+{
+	struct ipipe_domain *this_domain, *next_domain;
+	struct list_head *ln;
+	unsigned long flags;
+
+	local_irq_save_hw(flags);
+
+	this_domain =3D next_domain =3D ipipe_current_domain;
+
+	__clear_bit(IPIPE_STALL_FLAG, &ipipe_cpudom_var(this_domain, status));
+
+	if (ipipe_cpudom_var(this_domain, irqpend_himask) !=3D 0)
+		goto sync_stage;
+
+	for (;;) {
+		ln =3D next_domain->p_link.next;
+
+		if (ln =3D=3D &__ipipe_pipeline)
+			break;
+
+		next_domain =3D list_entry(ln, struct ipipe_domain, p_link);
+
+		if (test_bit(IPIPE_STALL_FLAG,
+			     &ipipe_cpudom_var(next_domain, status)) !=3D 0)
+			break;
+
+		if (ipipe_cpudom_var(next_domain, irqpend_himask) =3D=3D 0)
+			continue;
+
+		ipipe_current_domain =3D next_domain;
+
+sync_stage:
+		__ipipe_sync_pipeline(IPIPE_IRQMASK_ANY);
+
+		if (ipipe_current_domain !=3D next_domain)
+			/*
+			 * Something has changed the current domain under our
+			 * feet, recycling the register set; take note.
+			 */
+			this_domain =3D ipipe_current_domain;
+	}
+
+	ipipe_current_domain =3D this_domain;
+
+	local_irq_restore_hw(flags);
+}
+
+/* ipipe_alloc_virq() -- Allocate a pipelined virtual/soft interrupt.
+ * Virtual interrupts are handled in exactly the same way than their
+ * hw-generated counterparts wrt pipelining.
+ */
+unsigned ipipe_alloc_virq(void)
+{
+	unsigned long flags, irq =3D 0;
+	int ipos;
+
+	spin_lock_irqsave(&__ipipe_pipelock, flags);
+
+	if (__ipipe_virtual_irq_map !=3D ~0) {
+		ipos =3D ffz(__ipipe_virtual_irq_map);
+		set_bit(ipos, &__ipipe_virtual_irq_map);
+		irq =3D ipos + IPIPE_VIRQ_BASE;
+	}
+
+	spin_unlock_irqrestore(&__ipipe_pipelock, flags);
+
+	return irq;
+}
+
+/* ipipe_virtualize_irq() -- Attach a handler (and optionally a hw
+   acknowledge routine) to an interrupt for a given domain. */
+
+int ipipe_virtualize_irq(struct ipipe_domain *ipd,
+			 unsigned irq,
+			 ipipe_irq_handler_t handler,
+			 void *cookie,
+			 ipipe_irq_ackfn_t acknowledge,
+			 unsigned modemask)
+{
+	unsigned long flags;
+	int err;
+
+	if (irq >=3D IPIPE_NR_IRQS)
+		return -EINVAL;
+
+	if (ipd->irqs[irq].control & IPIPE_SYSTEM_MASK)
+		return -EPERM;
+
+	if (!test_bit(IPIPE_AHEAD_FLAG, &ipd->flags))
+		/* Silently unwire interrupts for non-heading domains. */
+		modemask &=3D ~IPIPE_WIRED_MASK;
+
+	spin_lock_irqsave(&__ipipe_pipelock, flags);
+
+	if (handler !=3D NULL) {
+		if (handler =3D=3D IPIPE_SAME_HANDLER) {
+			handler =3D ipd->irqs[irq].handler;
+			cookie =3D ipd->irqs[irq].cookie;
+
+			if (handler =3D=3D NULL) {
+				err =3D -EINVAL;
+				goto unlock_and_exit;
+			}
+		} else if ((modemask & IPIPE_EXCLUSIVE_MASK) !=3D 0 &&
+			   ipd->irqs[irq].handler !=3D NULL) {
+			err =3D -EBUSY;
+			goto unlock_and_exit;
+		}
+
+		/* Wired interrupts can only be delivered to domains
+		 * always heading the pipeline, and using dynamic
+		 * propagation. */
+
+		if ((modemask & IPIPE_WIRED_MASK) !=3D 0) {
+			if ((modemask & (IPIPE_PASS_MASK | IPIPE_STICKY_MASK)) !=3D 0) {
+				err =3D -EINVAL;
+				goto unlock_and_exit;
+			}
+			modemask |=3D (IPIPE_HANDLE_MASK);
+		}
+
+		if ((modemask & IPIPE_STICKY_MASK) !=3D 0)
+			modemask |=3D IPIPE_HANDLE_MASK;
+	} else
+		modemask &=3D
+		    ~(IPIPE_HANDLE_MASK | IPIPE_STICKY_MASK |
+		      IPIPE_EXCLUSIVE_MASK | IPIPE_WIRED_MASK);
+
+	if (acknowledge =3D=3D NULL && !ipipe_virtual_irq_p(irq))
+		/* Acknowledge handler unspecified for a hw interrupt:
+		   use the Linux-defined handler instead. */
+		acknowledge =3D ipipe_root_domain->irqs[irq].acknowledge;
+
+	ipd->irqs[irq].handler =3D handler;
+	ipd->irqs[irq].cookie =3D cookie;
+	ipd->irqs[irq].acknowledge =3D acknowledge;
+	ipd->irqs[irq].control =3D modemask;
+
+	if (irq < NR_IRQS && handler !=3D NULL && !ipipe_virtual_irq_p(irq)) {
+		__ipipe_enable_irqdesc(ipd, irq);
+
+		if ((modemask & IPIPE_ENABLE_MASK) !=3D 0) {
+			if (ipd !=3D ipipe_current_domain) {
+				/* IRQ enable/disable state is domain-sensitive, so we may
+				   not change it for another domain. What is allowed
+				   however is forcing some domain to handle an interrupt
+				   source, by passing the proper 'ipd' descriptor which
+				   thus may be different from ipipe_current_domain. */
+				err =3D -EPERM;
+				goto unlock_and_exit;
+			}
+			__ipipe_enable_irq(irq);
+		}
+	}
+
+	err =3D 0;
+
+      unlock_and_exit:
+
+	spin_unlock_irqrestore(&__ipipe_pipelock, flags);
+
+	return err;
+}
+
+/* ipipe_control_irq() -- Change modes of a pipelined interrupt for
+ * the current domain. */
+
+int ipipe_control_irq(unsigned irq, unsigned clrmask, unsigned setmask)
+{
+	struct ipipe_domain *ipd;
+	unsigned long flags;
+
+	if (irq >=3D IPIPE_NR_IRQS)
+		return -EINVAL;
+
+	ipd =3D ipipe_current_domain;
+
+	if (ipd->irqs[irq].control & IPIPE_SYSTEM_MASK)
+		return -EPERM;
+
+	if (ipd->irqs[irq].handler =3D=3D NULL)
+		setmask &=3D ~(IPIPE_HANDLE_MASK | IPIPE_STICKY_MASK);
+
+	if ((setmask & IPIPE_STICKY_MASK) !=3D 0)
+		setmask |=3D IPIPE_HANDLE_MASK;
+
+	if ((clrmask & (IPIPE_HANDLE_MASK | IPIPE_STICKY_MASK)) !=3D 0)	/* If o=
ne goes, both go. */
+		clrmask |=3D (IPIPE_HANDLE_MASK | IPIPE_STICKY_MASK);
+
+	spin_lock_irqsave(&__ipipe_pipelock, flags);
+
+	ipd->irqs[irq].control &=3D ~clrmask;
+	ipd->irqs[irq].control |=3D setmask;
+
+	if ((setmask & IPIPE_ENABLE_MASK) !=3D 0)
+		__ipipe_enable_irq(irq);
+	else if ((clrmask & IPIPE_ENABLE_MASK) !=3D 0)
+		__ipipe_disable_irq(irq);
+
+	spin_unlock_irqrestore(&__ipipe_pipelock, flags);
+
+	return 0;
+}
+
+/* __ipipe_dispatch_event() -- Low-level event dispatcher. */
+
+int fastcall __ipipe_dispatch_event (unsigned event, void *data)
+{
+	struct ipipe_domain *start_domain, *this_domain, *next_domain;
+	ipipe_event_handler_t evhand;
+	struct list_head *pos, *npos;
+	unsigned long flags;
+	int propagate =3D 1;
+
+	local_irq_save_hw(flags);
+
+	start_domain =3D this_domain =3D ipipe_current_domain;
+
+	list_for_each_safe(pos, npos, &__ipipe_pipeline) {
+		/*
+		 * Note: Domain migration may occur while running
+		 * event or interrupt handlers, in which case the
+		 * current register set is going to be recycled for a
+		 * different domain than the initiating one. We do
+		 * care for that, always tracking the current domain
+		 * descriptor upon return from those handlers.
+		 */
+		next_domain =3D list_entry(pos, struct ipipe_domain, p_link);
+
+		/*
+		 * Keep a cached copy of the handler's address since
+		 * ipipe_catch_event() may clear it under our feet.
+		 */
+		evhand =3D next_domain->evhand[event];
+
+		if (evhand !=3D NULL) {
+			ipipe_current_domain =3D next_domain;
+			ipipe_cpudom_var(next_domain, evsync) |=3D (1LL << event);
+			local_irq_restore_hw(flags);
+			propagate =3D !evhand(event, start_domain, data);
+			local_irq_save_hw(flags);
+			ipipe_cpudom_var(next_domain, evsync) &=3D ~(1LL << event);
+			if (ipipe_current_domain !=3D next_domain)
+				this_domain =3D ipipe_current_domain;
+		}
+
+		if (next_domain !=3D ipipe_root_domain &&	/* NEVER sync the root stage=
 here. */
+		    ipipe_cpudom_var(next_domain, irqpend_himask) !=3D 0 &&
+		    !test_bit(IPIPE_STALL_FLAG, &ipipe_cpudom_var(next_domain, status)=
)) {
+			ipipe_current_domain =3D next_domain;
+			__ipipe_sync_pipeline(IPIPE_IRQMASK_ANY);
+			if (ipipe_current_domain !=3D next_domain)
+				this_domain =3D ipipe_current_domain;
+		}
+
+		ipipe_current_domain =3D this_domain;
+
+		if (next_domain =3D=3D this_domain || !propagate)
+			break;
+	}
+
+	local_irq_restore_hw(flags);
+
+	return !propagate;
+}
+
+/*
+ * __ipipe_dispatch_wired -- Wired interrupt dispatcher. Wired
+ * interrupts are immediately and unconditionally delivered to the
+ * domain heading the pipeline upon receipt, and such domain must have
+ * been registered as an invariant head for the system (priority =3D=3D
+ * IPIPE_HEAD_PRIORITY). The motivation for using wired interrupts is
+ * to get an extra-fast dispatching path for those IRQs, by relying on
+ * a straightforward logic based on assumptions that must always be
+ * true for invariant head domains.  The following assumptions are
+ * made when dealing with such interrupts:
+ *
+ * 1- Wired interrupts are purely dynamic, i.e. the decision to
+ * propagate them down the pipeline must be done from the head domain
+ * ISR.
+ * 2- Wired interrupts cannot be shared or sticky.
+ * 3- The root domain cannot be an invariant pipeline head, in
+ * consequence of what the root domain cannot handle wired
+ * interrupts.
+ * 4- Wired interrupts must have a valid acknowledge handler for the
+ * head domain (if needed), and in any case, must not rely on handlers
+ * provided by lower priority domains during the acknowledge cycle
+ * (see __ipipe_handle_irq).
+ *
+ * Called with hw interrupts off.
+ */
+
+int fastcall __ipipe_dispatch_wired(struct ipipe_domain *head_domain, un=
signed irq)
+{
+	struct ipipe_domain *old;
+
+	if (test_bit(IPIPE_LOCK_FLAG, &head_domain->irqs[irq].control)) {
+		/* If we can't process this IRQ right now, we must
+		 * mark it as held, so that it will get played during
+		 * normal log sync when the corresponding interrupt
+		 * source is eventually unlocked. */
+		ipipe_cpudom_var(head_domain, irqall)[irq]++;
+		__set_bit(irq & IPIPE_IRQ_IMASK, &ipipe_cpudom_var(head_domain, irqhel=
d_mask)[irq >> IPIPE_IRQ_ISHIFT]);
+		return 0;
+	}
+
+	if (test_bit(IPIPE_STALL_FLAG, &ipipe_cpudom_var(head_domain, status)))=
 {
+		__ipipe_set_irq_pending(head_domain, irq);
+		return 0;
+	}
+
+	old =3D ipipe_current_domain;
+	ipipe_current_domain =3D head_domain; /* Switch to the head domain. */
+
+	ipipe_cpudom_var(head_domain, irqall)[irq]++;
+	__set_bit(IPIPE_STALL_FLAG, &ipipe_cpudom_var(head_domain, status));
+	head_domain->irqs[irq].handler(irq, head_domain->irqs[irq].cookie); /* =
Call the ISR. */
+	__ipipe_run_irqtail();
+	__clear_bit(IPIPE_STALL_FLAG, &ipipe_cpudom_var(head_domain, status));
+
+	/* We expect the caller to start a complete pipeline walk upon
+	 * return, so that propagated interrupts will get played. */
+
+	if (ipipe_current_domain =3D=3D head_domain)
+		ipipe_current_domain =3D old; /* Back to the preempted domain. */
+
+	return 1;
+}
+
+/*
+ * __ipipe_sync_stage() -- Flush the pending IRQs for the current
+ * domain (and processor). This routine flushes the interrupt log
+ * (see "Optimistic interrupt protection" from D. Stodolsky et al. for
+ * more on the deferred interrupt scheme). Every interrupt that
+ * occurred while the pipeline was stalled gets played. WARNING:
+ * callers on SMP boxen should always check for CPU migration on
+ * return of this routine. One can control the kind of interrupts
+ * which are going to be sync'ed using the syncmask
+ * parameter. IPIPE_IRQMASK_ANY plays them all, IPIPE_IRQMASK_VIRT
+ * plays virtual interrupts only.
+ *
+ * This routine must be called with hw interrupts off.
+ */
+void fastcall __ipipe_sync_stage(unsigned long syncmask)
+{
+	unsigned long mask, submask;
+	struct ipipe_domain *ipd;
+	int level, rank, cpu;
+	unsigned irq;
+
+	if (__test_and_set_bit(IPIPE_SYNC_FLAG, &ipipe_this_cpudom_var(status))=
)
+		return;
+
+	ipd =3D ipipe_current_domain;
+	cpu =3D ipipe_processor_id();
+
+	/*
+	 * The policy here is to keep the dispatching code interrupt-free
+	 * by stalling the current stage. If the upper domain handler
+	 * (which we call) wants to re-enable interrupts while in a safe
+	 * portion of the code (e.g. SA_INTERRUPT flag unset for Linux's
+	 * sigaction()), it will have to unstall (then stall again before
+	 * returning to us!) the stage when it sees fit.
+	 */
+	while ((mask =3D (ipipe_this_cpudom_var(irqpend_himask) & syncmask)) !=3D=
 0) {
+		level =3D __ipipe_ffnz(mask);
+
+		while ((submask =3D ipipe_this_cpudom_var(irqpend_lomask)[level]) !=3D=
 0) {
+			rank =3D __ipipe_ffnz(submask);
+			irq =3D (level << IPIPE_IRQ_ISHIFT) + rank;
+
+			if (test_bit(IPIPE_LOCK_FLAG, &ipd->irqs[irq].control)) {
+				__clear_bit(rank, &ipipe_this_cpudom_var(irqpend_lomask)[level]);
+				continue;
+			}
+
+			__clear_bit(rank, &ipipe_this_cpudom_var(irqpend_lomask)[level]);
+
+			if (ipipe_this_cpudom_var(irqpend_lomask)[level] =3D=3D 0)
+				__clear_bit(level, &ipipe_this_cpudom_var(irqpend_himask));
+
+			__set_bit(IPIPE_STALL_FLAG, &ipipe_this_cpudom_var(status));
+
+			if (ipd =3D=3D ipipe_root_domain)
+				trace_hardirqs_off();
+
+			__ipipe_run_isr(ipd, irq);
+#ifdef CONFIG_SMP
+			{
+				int newcpu =3D ipipe_processor_id();
+
+				if (newcpu !=3D cpu) {	/* Handle CPU migration. */
+					/*
+					 * We expect any domain to clear the SYNC bit each
+					 * time it switches in a new task, so that preemptions
+					 * and/or CPU migrations (in the SMP case) over the
+					 * ISR do not lock out the log syncer for some
+					 * indefinite amount of time. In the Linux case,
+					 * schedule() handles this (see kernel/sched.c). For
+					 * this reason, we don't bother clearing it here for
+					 * the source CPU in the migration handling case,
+					 * since it must have scheduled another task in by
+					 * now.
+					 */
+					__set_bit(IPIPE_SYNC_FLAG, &ipipe_this_cpudom_var(status));
+					cpu =3D newcpu;
+				}
+			}
+#endif	/* CONFIG_SMP */
+			if (ipd =3D=3D ipipe_root_domain &&
+			    test_bit(IPIPE_STALL_FLAG, &ipipe_this_cpudom_var(status)))
+				trace_hardirqs_on();
+
+			__clear_bit(IPIPE_STALL_FLAG, &ipipe_this_cpudom_var(status));
+		}
+	}
+
+	__clear_bit(IPIPE_SYNC_FLAG, &ipipe_this_cpudom_var(status));
+}
+
+/* ipipe_register_domain() -- Link a new domain to the pipeline. */
+
+int ipipe_register_domain(struct ipipe_domain *ipd,
+			  struct ipipe_domain_attr *attr)
+{
+	struct ipipe_domain *_ipd;
+	struct list_head *pos;
+	unsigned long flags;
+
+	if (!ipipe_root_domain_p) {
+		printk(KERN_WARNING
+		       "I-pipe: Only the root domain may register a new domain.\n");
+		return -EPERM;
+	}
+
+	if (attr->priority =3D=3D IPIPE_HEAD_PRIORITY &&
+	    test_bit(IPIPE_AHEAD_FLAG,&__ipipe_pipeline_head()->flags))
+		return -EAGAIN;	/* Cannot override current head. */
+
+	flags =3D ipipe_critical_enter(NULL);
+
+	pos =3D NULL;
+	ipd->slot =3D ffz(__ipipe_domain_slot_map);
+
+	if (ipd->slot < CONFIG_IPIPE_DOMAINS) {
+		set_bit(ipd->slot, &__ipipe_domain_slot_map);
+		list_for_each(pos, &__ipipe_pipeline) {
+			_ipd =3D list_entry(pos, struct ipipe_domain, p_link);
+			if (_ipd->domid =3D=3D attr->domid)
+				break;
+		}
+	}
+
+	ipipe_critical_exit(flags);
+
+	if (pos !=3D &__ipipe_pipeline) {
+		if (ipd->slot < CONFIG_IPIPE_DOMAINS)
+			clear_bit(ipd->slot, &__ipipe_domain_slot_map);
+		return -EBUSY;
+	}
+
+#ifndef CONFIG_SMP
+	/*
+	 * Set up the perdomain pointers for direct access to the
+	 * percpu domain data. This saves a costly multiply each time
+	 * we need to refer to the contents of the percpu domain data
+	 * array.
+	 */
+	__raw_get_cpu_var(ipipe_percpu_daddr)[ipd->slot] =3D &__raw_get_cpu_var=
(ipipe_percpu_darray)[ipd->slot];
+#endif
+
+	ipd->name =3D attr->name;
+	ipd->domid =3D attr->domid;
+	ipd->pdd =3D attr->pdd;
+	ipd->flags =3D 0;
+
+	if (attr->priority =3D=3D IPIPE_HEAD_PRIORITY) {
+		ipd->priority =3D INT_MAX;
+		__set_bit(IPIPE_AHEAD_FLAG,&ipd->flags);
+	}
+	else
+		ipd->priority =3D attr->priority;
+
+	__ipipe_init_stage(ipd);
+
+	INIT_LIST_HEAD(&ipd->p_link);
+
+#ifdef CONFIG_PROC_FS
+	__ipipe_add_domain_proc(ipd);
+#endif /* CONFIG_PROC_FS */
+
+	flags =3D ipipe_critical_enter(NULL);
+
+	list_for_each(pos, &__ipipe_pipeline) {
+		_ipd =3D list_entry(pos, struct ipipe_domain, p_link);
+		if (ipd->priority > _ipd->priority)
+			break;
+	}
+
+	list_add_tail(&ipd->p_link, pos);
+
+	ipipe_critical_exit(flags);
+
+	printk(KERN_INFO "I-pipe: Domain %s registered.\n", ipd->name);
+
+	/*
+	 * Finally, allow the new domain to perform its initialization
+	 * chores.
+	 */
+
+	if (attr->entry !=3D NULL) {
+		ipipe_current_domain =3D ipd;
+		attr->entry();
+		ipipe_current_domain =3D ipipe_root_domain;
+
+		local_irq_save_hw(flags);
+
+		if (ipipe_root_cpudom_var(irqpend_himask) !=3D 0 &&
+		    !test_bit(IPIPE_STALL_FLAG, &ipipe_root_cpudom_var(status)))
+			__ipipe_sync_pipeline(IPIPE_IRQMASK_ANY);
+
+		local_irq_restore_hw(flags);
+	}
+
+	return 0;
+}
+
+/* ipipe_unregister_domain() -- Remove a domain from the pipeline. */
+
+int ipipe_unregister_domain(struct ipipe_domain *ipd)
+{
+	unsigned long flags;
+
+	if (!ipipe_root_domain_p) {
+		printk(KERN_WARNING
+		       "I-pipe: Only the root domain may unregister a domain.\n");
+		return -EPERM;
+	}
+
+	if (ipd =3D=3D ipipe_root_domain) {
+		printk(KERN_WARNING
+		       "I-pipe: Cannot unregister the root domain.\n");
+		return -EPERM;
+	}
+#ifdef CONFIG_SMP
+	{
+		unsigned irq;
+		int cpu;
+
+		/*
+		 * In the SMP case, wait for the logged events to drain on
+		 * other processors before eventually removing the domain
+		 * from the pipeline.
+		 */
+
+		ipipe_unstall_pipeline_from(ipd);
+
+		flags =3D ipipe_critical_enter(NULL);
+
+		for (irq =3D 0; irq < IPIPE_NR_IRQS; irq++) {
+			clear_bit(IPIPE_HANDLE_FLAG, &ipd->irqs[irq].control);
+			clear_bit(IPIPE_STICKY_FLAG, &ipd->irqs[irq].control);
+			set_bit(IPIPE_PASS_FLAG, &ipd->irqs[irq].control);
+		}
+
+		ipipe_critical_exit(flags);
+
+		for_each_online_cpu(cpu) {
+			while (ipipe_percpudom(ipd, irqpend_himask, cpu) > 0)
+				cpu_relax();
+		}
+	}
+#endif	/* CONFIG_SMP */
+
+	mutex_lock(&ipd->mutex);
+
+#ifdef CONFIG_PROC_FS
+	__ipipe_remove_domain_proc(ipd);
+#endif /* CONFIG_PROC_FS */
+
+	/*
+	 * Simply remove the domain from the pipeline and we are almost done.
+	 */
+
+	flags =3D ipipe_critical_enter(NULL);
+	list_del_init(&ipd->p_link);
+	ipipe_critical_exit(flags);
+
+	__ipipe_cleanup_domain(ipd);
+
+	mutex_unlock(&ipd->mutex);
+
+	printk(KERN_INFO "I-pipe: Domain %s unregistered.\n", ipd->name);
+
+	return 0;
+}
+
+/*
+ * ipipe_propagate_irq() -- Force a given IRQ propagation on behalf of
+ * a running interrupt handler to the next domain down the pipeline.
+ * ipipe_schedule_irq() -- Does almost the same as above, but attempts
+ * to pend the interrupt for the current domain first.
+ */
+int fastcall __ipipe_schedule_irq(unsigned irq, struct list_head *head)
+{
+	struct ipipe_domain *ipd;
+	struct list_head *ln;
+	unsigned long flags;
+
+	if (irq >=3D IPIPE_NR_IRQS ||
+	    (ipipe_virtual_irq_p(irq)
+	     && !test_bit(irq - IPIPE_VIRQ_BASE, &__ipipe_virtual_irq_map)))
+		return -EINVAL;
+
+	local_irq_save_hw(flags);
+
+	ln =3D head;
+
+	while (ln !=3D &__ipipe_pipeline) {
+
+		ipd =3D list_entry(ln, struct ipipe_domain, p_link);
+
+		if (test_bit(IPIPE_HANDLE_FLAG, &ipd->irqs[irq].control)) {
+			__ipipe_set_irq_pending(ipd, irq);
+			local_irq_restore_hw(flags);
+			return 1;
+		}
+
+		ln =3D ipd->p_link.next;
+	}
+
+	local_irq_restore_hw(flags);
+
+	return 0;
+}
+
+/* ipipe_free_virq() -- Release a virtual/soft interrupt. */
+
+int ipipe_free_virq(unsigned virq)
+{
+	if (!ipipe_virtual_irq_p(virq))
+		return -EINVAL;
+
+	clear_bit(virq - IPIPE_VIRQ_BASE, &__ipipe_virtual_irq_map);
+
+	return 0;
+}
+
+void ipipe_init_attr(struct ipipe_domain_attr *attr)
+{
+	attr->name =3D "anon";
+	attr->domid =3D 1;
+	attr->entry =3D NULL;
+	attr->priority =3D IPIPE_ROOT_PRIO;
+	attr->pdd =3D NULL;
+}
+
+/*
+ * ipipe_catch_event() -- Interpose or remove an event handler for a
+ * given domain.
+ */
+ipipe_event_handler_t ipipe_catch_event(struct ipipe_domain *ipd,
+					unsigned event,
+					ipipe_event_handler_t handler)
+{
+	ipipe_event_handler_t old_handler;
+	unsigned long flags;
+	int self =3D 0, cpu;
+
+	if (event & IPIPE_EVENT_SELF) {
+		event &=3D ~IPIPE_EVENT_SELF;
+		self =3D 1;
+	}
+
+	if (event >=3D IPIPE_NR_EVENTS)
+		return NULL;
+
+	flags =3D ipipe_critical_enter(NULL);
+
+	if (!(old_handler =3D xchg(&ipd->evhand[event],handler)))	{
+		if (handler) {
+			if (self)
+				ipd->evself |=3D (1LL << event);
+			else
+				__ipipe_event_monitors[event]++;
+		}
+	}
+	else if (!handler) {
+		if (ipd->evself & (1LL << event))
+			ipd->evself &=3D ~(1LL << event);
+		else
+			__ipipe_event_monitors[event]--;
+	} else if ((ipd->evself & (1LL << event)) && !self) {
+			__ipipe_event_monitors[event]++;
+			ipd->evself &=3D ~(1LL << event);
+	} else if (!(ipd->evself & (1LL << event)) && self) {
+			__ipipe_event_monitors[event]--;
+			ipd->evself |=3D (1LL << event);
+	}
+
+	ipipe_critical_exit(flags);
+
+	if (!handler && ipipe_root_domain_p) {
+		/*
+		 * If we cleared a handler on behalf of the root
+		 * domain, we have to wait for any current invocation
+		 * to drain, since our caller might subsequently unmap
+		 * the target domain. To this aim, this code
+		 * synchronizes with __ipipe_dispatch_event(),
+		 * guaranteeing that either the dispatcher sees a null
+		 * handler in which case it discards the invocation
+		 * (which also prevents from entering a livelock), or
+		 * finds a valid handler and calls it. Symmetrically,
+		 * ipipe_catch_event() ensures that the called code
+		 * won't be unmapped under our feet until the event
+		 * synchronization flag is cleared for the given event
+		 * on all CPUs.
+		 */
+
+		for_each_online_cpu(cpu) {
+			while (ipipe_percpudom(ipd, evsync, cpu) & (1LL << event))
+				schedule_timeout_interruptible(HZ / 50);
+		}
+	}
+
+	return old_handler;
+}
+
+cpumask_t ipipe_set_irq_affinity (unsigned irq, cpumask_t cpumask)
+{
+#ifdef CONFIG_SMP
+	if (irq >=3D IPIPE_NR_XIRQS)
+		/* Allow changing affinity of external IRQs only. */
+		return CPU_MASK_NONE;
+
+	if (num_online_cpus() > 1)
+		return __ipipe_set_irq_affinity(irq,cpumask);
+#endif /* CONFIG_SMP */
+
+	return CPU_MASK_NONE;
+}
+
+int fastcall ipipe_send_ipi (unsigned ipi, cpumask_t cpumask)
+
+{
+#ifdef CONFIG_SMP
+	return __ipipe_send_ipi(ipi,cpumask);
+#else /* !CONFIG_SMP */
+	return -EINVAL;
+#endif /* CONFIG_SMP */
+}
+
+int ipipe_alloc_ptdkey (void)
+{
+	unsigned long flags;
+	int key =3D -1;
+
+	spin_lock_irqsave(&__ipipe_pipelock,flags);
+
+	if (__ipipe_ptd_key_count < IPIPE_ROOT_NPTDKEYS) {
+		key =3D ffz(__ipipe_ptd_key_map);
+		set_bit(key,&__ipipe_ptd_key_map);
+		__ipipe_ptd_key_count++;
+	}
+
+	spin_unlock_irqrestore(&__ipipe_pipelock,flags);
+
+	return key;
+}
+
+int ipipe_free_ptdkey (int key)
+{
+	unsigned long flags;
+
+	if (key < 0 || key >=3D IPIPE_ROOT_NPTDKEYS)
+		return -EINVAL;
+
+	spin_lock_irqsave(&__ipipe_pipelock,flags);
+
+	if (test_and_clear_bit(key,&__ipipe_ptd_key_map))
+		__ipipe_ptd_key_count--;
+
+	spin_unlock_irqrestore(&__ipipe_pipelock,flags);
+
+	return 0;
+}
+
+int fastcall ipipe_set_ptd (int key, void *value)
+
+{
+	if (key < 0 || key >=3D IPIPE_ROOT_NPTDKEYS)
+		return -EINVAL;
+
+	current->ptd[key] =3D value;
+
+	return 0;
+}
+
+void fastcall *ipipe_get_ptd (int key)
+
+{
+	if (key < 0 || key >=3D IPIPE_ROOT_NPTDKEYS)
+		return NULL;
+
+	return current->ptd[key];
+}
+
+#ifdef CONFIG_PROC_FS
+
+struct proc_dir_entry *ipipe_proc_root;
+
+static int __ipipe_version_info_proc(char *page,
+				     char **start,
+				     off_t off, int count, int *eof, void *data)
+{
+	int len =3D sprintf(page, "%s\n", IPIPE_VERSION_STRING);
+
+	len -=3D off;
+
+	if (len <=3D off + count)
+		*eof =3D 1;
+
+	*start =3D page + off;
+
+	if(len > count)
+		len =3D count;
+
+	if(len < 0)
+		len =3D 0;
+
+	return len;
+}
+
+static int __ipipe_common_info_show(struct seq_file *p, void *data)
+{
+	struct ipipe_domain *ipd =3D (struct ipipe_domain *)p->private;
+	char handling, stickiness, lockbit, exclusive, virtuality;
+
+	unsigned long ctlbits;
+	unsigned irq;
+
+	seq_printf(p, "       +----- Handling ([A]ccepted, [G]rabbed, [W]ired, =
[D]iscarded)\n");
+	seq_printf(p, "       |+---- Sticky\n");
+	seq_printf(p, "       ||+--- Locked\n");
+	seq_printf(p, "       |||+-- Exclusive\n");
+	seq_printf(p, "       ||||+- Virtual\n");
+	seq_printf(p, "[IRQ]  |||||\n");
+
+	mutex_lock(&ipd->mutex);
+
+	for (irq =3D 0; irq < IPIPE_NR_IRQS; irq++) {
+		/* Remember to protect against
+		 * ipipe_virtual_irq/ipipe_control_irq if more fields
+		 * get involved. */
+		ctlbits =3D ipd->irqs[irq].control;
+
+		if (irq >=3D IPIPE_NR_XIRQS && !ipipe_virtual_irq_p(irq))
+			/*
+			 * There might be a hole between the last external
+			 * IRQ and the first virtual one; skip it.
+			 */
+			continue;
+
+		if (ipipe_virtual_irq_p(irq)
+		    && !test_bit(irq - IPIPE_VIRQ_BASE, &__ipipe_virtual_irq_map))
+			/* Non-allocated virtual IRQ; skip it. */
+			continue;
+
+		/*
+		 * Statuses are as follows:
+		 * o "accepted" means handled _and_ passed down the pipeline.
+		 * o "grabbed" means handled, but the interrupt might be
+		 * terminated _or_ passed down the pipeline depending on
+		 * what the domain handler asks for to the I-pipe.
+		 * o "wired" is basically the same as "grabbed", except that
+		 * the interrupt is unconditionally delivered to an invariant
+		 * pipeline head domain.
+		 * o "passed" means unhandled by the domain but passed
+		 * down the pipeline.
+		 * o "discarded" means unhandled and _not_ passed down the
+		 * pipeline. The interrupt merely disappears from the
+		 * current domain down to the end of the pipeline.
+		 */
+		if (ctlbits & IPIPE_HANDLE_MASK) {
+			if (ctlbits & IPIPE_PASS_MASK)
+				handling =3D 'A';
+			else if (ctlbits & IPIPE_WIRED_MASK)
+				handling =3D 'W';
+			else
+				handling =3D 'G';
+		} else if (ctlbits & IPIPE_PASS_MASK)
+			/* Do not output if no major action is taken. */
+			continue;
+		else
+			handling =3D 'D';
+
+		if (ctlbits & IPIPE_STICKY_MASK)
+			stickiness =3D 'S';
+		else
+			stickiness =3D '.';
+
+		if (ctlbits & IPIPE_LOCK_MASK)
+			lockbit =3D 'L';
+		else
+			lockbit =3D '.';
+
+		if (ctlbits & IPIPE_EXCLUSIVE_MASK)
+			exclusive =3D 'X';
+		else
+			exclusive =3D '.';
+
+		if (ipipe_virtual_irq_p(irq))
+			virtuality =3D 'V';
+		else
+			virtuality =3D '.';
+
+		seq_printf(p, " %3u:  %c%c%c%c%c\n",
+			     irq, handling, stickiness, lockbit, exclusive, virtuality);
+	}
+
+	seq_printf(p, "[Domain info]\n");
+
+	seq_printf(p, "id=3D0x%.8x\n", ipd->domid);
+
+	if (test_bit(IPIPE_AHEAD_FLAG,&ipd->flags))
+		seq_printf(p, "priority=3Dtopmost\n");
+	else
+		seq_printf(p, "priority=3D%d\n", ipd->priority);
+
+	mutex_unlock(&ipd->mutex);
+
+	return 0;
+}
+
+static int __ipipe_common_info_open(struct inode *inode, struct file *fi=
le)
+{
+	return single_open(file, __ipipe_common_info_show, PROC_I(inode)->pde->=
data);
+}
+
+static struct file_operations __ipipe_info_proc_ops =3D {
+	.owner		=3D THIS_MODULE,
+	.open		=3D __ipipe_common_info_open,
+	.read		=3D seq_read,
+	.llseek		=3D seq_lseek,
+	.release	=3D single_release,
+};
+
+void __ipipe_add_domain_proc(struct ipipe_domain *ipd)
+{
+	struct proc_dir_entry *e =3D create_proc_entry(ipd->name, 0444, ipipe_p=
roc_root);
+	if (e) {
+		e->proc_fops =3D &__ipipe_info_proc_ops;
+		e->data =3D (void*) ipd;
+	}
+}
+
+void __ipipe_remove_domain_proc(struct ipipe_domain *ipd)
+{
+	remove_proc_entry(ipd->name,ipipe_proc_root);
+}
+
+void __init ipipe_init_proc(void)
+{
+	ipipe_proc_root =3D create_proc_entry("ipipe",S_IFDIR, 0);
+	create_proc_read_entry("version",0444,ipipe_proc_root,&__ipipe_version_=
info_proc,NULL);
+	__ipipe_add_domain_proc(ipipe_root_domain);
+
+	__ipipe_init_tracer();
+}
+
+#endif	/* CONFIG_PROC_FS */
+
+#ifdef CONFIG_IPIPE_DEBUG_CONTEXT
+
+DEFINE_PER_CPU(int, ipipe_percpu_context_check) =3D { 1 };
+
+void ipipe_check_context(struct ipipe_domain *border_ipd)
+{
+	/* Note: We don't make the per_cpu access atomic. We assume that code
+	   which temporarily disables the check does this in atomic context
+	   only. */
+	if (likely(ipipe_current_domain->priority <=3D border_ipd->priority) ||=

+	    !per_cpu(ipipe_percpu_context_check, ipipe_processor_id()))
+		return;
+
+	ipipe_context_check_off();
+
+	ipipe_trace_panic_freeze();
+	ipipe_set_printk_sync(ipipe_current_domain);
+	printk(KERN_ERR "I-pipe: Detected illicit call from domain '%s'\n"
+	       KERN_ERR "        into a service reserved for domain '%s' and "
+			"below.\n",
+	       ipipe_current_domain->name, border_ipd->name);
+	dump_stack();
+	ipipe_trace_panic_dump();
+}
+
+EXPORT_SYMBOL(ipipe_check_context);
+#endif /* CONFIG_IPIPE_DEBUG_CONTEXT */
+
+EXPORT_SYMBOL(ipipe_virtualize_irq);
+EXPORT_SYMBOL(ipipe_control_irq);
+EXPORT_SYMBOL(ipipe_suspend_domain);
+EXPORT_SYMBOL(ipipe_alloc_virq);
+EXPORT_PER_CPU_SYMBOL(ipipe_percpu_domain);
+EXPORT_PER_CPU_SYMBOL(ipipe_percpu_darray);
+EXPORT_SYMBOL(ipipe_root);
+EXPORT_SYMBOL(ipipe_stall_pipeline_from);
+EXPORT_SYMBOL(ipipe_test_and_stall_pipeline_from);
+EXPORT_SYMBOL(ipipe_unstall_pipeline_from);
+EXPORT_SYMBOL(ipipe_restore_pipeline_from);
+EXPORT_SYMBOL(ipipe_test_and_unstall_pipeline_from);
+EXPORT_SYMBOL(ipipe_unstall_pipeline_head);
+EXPORT_SYMBOL(__ipipe_restore_pipeline_head);
+EXPORT_SYMBOL(__ipipe_unstall_root);
+EXPORT_SYMBOL(__ipipe_restore_root);
+EXPORT_SYMBOL(__ipipe_spin_lock_irq);
+EXPORT_SYMBOL(__ipipe_spin_unlock_irq);
+EXPORT_SYMBOL(__ipipe_spin_lock_irqsave);
+EXPORT_SYMBOL(__ipipe_spin_unlock_irqrestore);
+EXPORT_SYMBOL(__ipipe_pipeline);
+EXPORT_SYMBOL(__ipipe_lock_irq);
+EXPORT_SYMBOL(__ipipe_unlock_irq);
+EXPORT_SYMBOL(ipipe_register_domain);
+EXPORT_SYMBOL(ipipe_unregister_domain);
+EXPORT_SYMBOL(ipipe_free_virq);
+EXPORT_SYMBOL(ipipe_init_attr);
+EXPORT_SYMBOL(ipipe_catch_event);
+EXPORT_SYMBOL(ipipe_alloc_ptdkey);
+EXPORT_SYMBOL(ipipe_free_ptdkey);
+EXPORT_SYMBOL(ipipe_set_ptd);
+EXPORT_SYMBOL(ipipe_get_ptd);
+EXPORT_SYMBOL(ipipe_set_irq_affinity);
+EXPORT_SYMBOL(ipipe_send_ipi);
+EXPORT_SYMBOL(__ipipe_schedule_irq);
+#ifdef CONFIG_GENERIC_CLOCKEVENTS
+EXPORT_SYMBOL(ipipe_request_tickdev);
+EXPORT_SYMBOL(ipipe_release_tickdev);
+#endif
+
+EXPORT_SYMBOL(ipipe_critical_enter);
+EXPORT_SYMBOL(ipipe_critical_exit);
+EXPORT_SYMBOL(ipipe_trigger_irq);
+EXPORT_SYMBOL(ipipe_get_sysinfo);
Index: kernel/ipipe/Makefile
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- kernel/ipipe/Makefile	(revision 0)
+++ kernel/ipipe/Makefile	(revision 0)
@@ -0,0 +1,3 @@
+
+obj-$(CONFIG_IPIPE)	+=3D core.o
+obj-$(CONFIG_IPIPE_TRACE) +=3D tracer.o
Index: kernel/sched.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- kernel/sched.c	(revision 91)
+++ kernel/sched.c	(working copy)
@@ -1518,7 +1518,7 @@
=20
 	rq =3D task_rq_lock(p, &flags);
 	old_state =3D p->state;
-	if (!(old_state & state))
+	if (!(old_state & state) || (old_state & TASK_NOWAKEUP))
 		goto out;
=20
 	if (p->se.on_rq)
@@ -1920,13 +1920,15 @@
 #endif
 	if (current->set_child_tid)
 		put_user(task_pid_vnr(current), current->set_child_tid);
+
+ 	ipipe_init_notify(current);
 }
=20
 /*
  * context_switch - switch to the new MM and the new
  * thread's register state.
  */
-static inline void
+static inline int
 context_switch(struct rq *rq, struct task_struct *prev,
 	       struct task_struct *next)
 {
@@ -1967,12 +1969,17 @@
 	switch_to(prev, next, prev);
=20
 	barrier();
+
+	if (task_hijacked(prev))
+		return 1;
 	/*
 	 * this_rq must be evaluated again because prev may have moved
 	 * CPUs since it called schedule(), thus the 'rq' on its stack
 	 * frame will be invalid.
 	 */
 	finish_task_switch(this_rq(), prev);
+
+	return 0;
 }
=20
 /*
@@ -3503,6 +3510,7 @@
=20
 void fastcall add_preempt_count(int val)
 {
+	ipipe_check_context(ipipe_root_domain);
 	/*
 	 * Underflow?
 	 */
@@ -3519,6 +3527,7 @@
=20
 void fastcall sub_preempt_count(int val)
 {
+	ipipe_check_context(ipipe_root_domain);
 	/*
 	 * Underflow?
 	 */
@@ -3630,6 +3639,11 @@
 	rcu_qsctr_inc(cpu);
 	prev =3D rq->curr;
 	switch_count =3D &prev->nivcsw;
+ 	if (unlikely(prev->state & TASK_ATOMICSWITCH)) {
+ 		prev->state &=3D ~TASK_ATOMICSWITCH;
+		/* Pop one disable level -- one still remains. */
+		preempt_enable();
+ 	}
=20
 	release_kernel_lock(prev);
 need_resched_nonpreemptible:
@@ -3667,7 +3681,8 @@
 		rq->curr =3D next;
 		++*switch_count;
=20
-		context_switch(rq, prev, next); /* unlocks the rq */
+		if (context_switch(rq, prev, next)) /* unlocks the rq unless hijacked =
*/
+			return;
 	} else
 		spin_unlock_irq(&rq->lock);
=20
@@ -3695,6 +3710,7 @@
 	struct task_struct *task =3D current;
 	int saved_lock_depth;
 #endif
+	ipipe_check_context(ipipe_root_domain);
 	/*
 	 * If there is a non-zero preempt_count or interrupts are disabled,
 	 * we do not want to preempt the current task. Just return..
@@ -4347,6 +4363,7 @@
=20
 	oldprio =3D p->prio;
 	__setscheduler(rq, p, policy, param->sched_priority);
+ 	ipipe_setsched_notify(p);
=20
 	if (on_rq) {
 		if (running)
@@ -7402,3 +7419,66 @@
 	.subsys_id =3D cpuacct_subsys_id,
 };
 #endif	/* CONFIG_CGROUP_CPUACCT */
+
+#ifdef CONFIG_IPIPE
+
+int ipipe_setscheduler_root (struct task_struct *p, int policy, int prio=
)
+{
+	int oldprio, on_rq, running;
+	unsigned long flags;
+	struct rq *rq;
+
+	spin_lock_irqsave(&p->pi_lock, flags);
+	rq =3D __task_rq_lock(p);
+	update_rq_clock(rq);
+	on_rq =3D p->se.on_rq;
+	running =3D task_running(rq, p);
+
+	if (on_rq) {
+		deactivate_task(rq, p, 0);
+		if (running)
+			p->sched_class->put_prev_task(rq, p);
+	}
+
+	oldprio =3D p->prio;
+	__setscheduler(rq, p, policy, prio);
+	ipipe_setsched_notify(p);
+
+	if (on_rq) {
+		if (running)
+			p->sched_class->set_curr_task(rq);
+		activate_task(rq, p, 0);
+
+		if (running) {
+			if (p->prio > oldprio)
+				resched_task(rq->curr);
+		} else {
+			check_preempt_curr(rq, p);
+		}
+	}
+	__task_rq_unlock(rq);
+	spin_unlock_irqrestore(&p->pi_lock, flags);
+
+	rt_mutex_adjust_pi(p);
+
+	return 0;
+}
+
+EXPORT_SYMBOL(ipipe_setscheduler_root);
+
+int ipipe_reenter_root (struct task_struct *prev, int policy, int prio)
+{
+	finish_task_switch(this_rq(), prev);
+
+	(void)reacquire_kernel_lock(current);
+	preempt_enable_no_resched();
+
+	if (current->policy !=3D policy || current->rt_priority !=3D prio)
+		return ipipe_setscheduler_root(current, policy, prio);
+
+	return 0;
+}
+
+EXPORT_SYMBOL(ipipe_reenter_root);
+
+#endif /* CONFIG_IPIPE */
Index: kernel/signal.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- kernel/signal.c	(revision 91)
+++ kernel/signal.c	(working copy)
@@ -454,6 +454,7 @@
 	unsigned int mask;
=20
 	set_tsk_thread_flag(t, TIF_SIGPENDING);
+	ipipe_sigwake_notify(t); /* TIF_SIGPENDING must be set first. */
=20
 	/*
 	 * For SIGKILL, we want to wake it up in the stopped/traced case.
Index: include/asm-arm/arch-at91/hardware.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- include/asm-arm/arch-at91/hardware.h	(revision 91)
+++ include/asm-arm/arch-at91/hardware.h	(working copy)
@@ -59,6 +59,25 @@
 #define AT91_VA_BASE_SYS	AT91_IO_P2V(AT91_BASE_SYS)
 #define AT91_VA_BASE_EMAC	AT91_IO_P2V(AT91RM9200_BASE_EMAC)
=20
+#ifdef CONFIG_IPIPE
+#if defined(CONFIG_ARCH_AT91RM9200)
+#define AT91_BASE_TCB0 AT91RM9200_BASE_TCB0
+#elif defined(CONFIG_ARCH_AT91SAM9260)
+#define AT91_BASE_TCB0 AT91SAM9260_BASE_TCB0
+#elif defined(CONFIG_ARCH_AT91SAM9261)
+#define AT91_BASE_TCB0 AT91SAM9261_BASE_TCB0
+#elif defined(CONFIG_ARCH_AT91SAM9263)
+#define AT91_BASE_TCB0 AT91SAM9263_BASE_TCB0
+#elif defined(CONFIG_ARCH_AT91SAM9RL)
+#define AT91_BASE_TCB0 AT91SAM9RL_BASE_TCB0
+#elif defined(CONFIG_ARCH_AT91X40)
+#define AT91_BASE_TCB0 (AT91_BASE_SYS + AT91_TC)
+#else
+#error "AT91 processor unsupported by Adeos"
+#endif
+#define AT91_VA_BASE_TCB0 AT91_IO_P2V(AT91_BASE_TCB0)
+#endif
+
  /* Internal SRAM is mapped below the IO devices */
 #define AT91_SRAM_MAX		SZ_1M
 #define AT91_VIRT_BASE		(AT91_IO_VIRT_BASE - AT91_SRAM_MAX)
Index: include/asm-arm/arch-at91/irqs.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- include/asm-arm/arch-at91/irqs.h	(revision 91)
+++ include/asm-arm/arch-at91/irqs.h	(working copy)
@@ -45,4 +45,35 @@
 /* FIQ is AIC source 0. */
 #define FIQ_START AT91_ID_FIQ
=20
+#if defined(CONFIG_IPIPE) && !defined(__ASSEMBLY__)
+extern unsigned __ipipe_at91_gpio_banks;
+
+#if defined(CONFIG_ARCH_AT91RM9200)
+#define __ipipe_mach_irq_mux_p(irq)					\
+	((unsigned) (irq - AT91RM9200_ID_PIOA) < __ipipe_at91_gpio_banks)
+
+#elif defined(CONFIG_ARCH_AT91SAM9260)
+#define __ipipe_mach_irq_mux_p(irq)					\
+	((unsigned) (irq - AT91SAM9260_ID_PIOA) < __ipipe_at91_gpio_banks)
+
+#elif defined(CONFIG_ARCH_AT91SAM9261)
+#define __ipipe_mach_irq_mux_p(irq)					\
+	((unsigned) (irq - AT91SAM9261_ID_PIOA) < __ipipe_at91_gpio_banks)
+
+#elif defined(CONFIG_ARCH_AT91SAM9263)
+#define __ipipe_mach_irq_mux_p(irq)					\
+	((unsigned) (irq - AT91SAM9263_ID_PIOA) < __ipipe_at91_gpio_banks)
+
+#elif defined(CONFIG_ARCH_AT91SAM9RL)
+#define __ipipe_mach_irq_mux_p(irq)					\
+	((unsigned) (irq - AT91SAM9RL_ID_PIOA) < __ipipe_at91_gpio_banks)
+
+#elif defined(CONFIG_ARCH_AT91X40)
+#define __ipipe_mach_irq_mux_p(irq)					\
+	((unsigned) (irq - AT91X40_ID_PIOA) < __ipipe_at91_gpio_banks)
+
+#endif /* CONFIG_ARCH_AT91X40 */
+
+#endif /* CONFIG_IPIPE && !__ASSEMBLY__ */
+
 #endif
Index: include/asm-arm/arch-at91/timex.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- include/asm-arm/arch-at91/timex.h	(revision 91)
+++ include/asm-arm/arch-at91/timex.h	(working copy)
@@ -23,6 +23,8 @@
=20
 #include <asm/hardware.h>
=20
+#ifndef CONFIG_IPIPE
+
 #if defined(CONFIG_ARCH_AT91RM9200)
=20
 #define CLOCK_TICK_RATE		(AT91_SLOW_CLOCK)
@@ -47,6 +49,12 @@
 #define AT91X40_MASTER_CLOCK	40000000
 #define CLOCK_TICK_RATE		(AT91X40_MASTER_CLOCK)
=20
-#endif
+#endif /* arch specific */
=20
+#else /* !CONFIG_IPIPE */
+
+#define CLOCK_TICK_RATE         (CONFIG_IPIPE_AT91_MCK / 32)
+
+#endif /* !CONFIG_IPIPE */
+
 #endif
Index: include/asm-arm/arch-imx/imx-regs.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- include/asm-arm/arch-imx/imx-regs.h	(revision 91)
+++ include/asm-arm/arch-imx/imx-regs.h	(working copy)
@@ -347,7 +347,16 @@
 #define IMX_INTDISNUM      __REG(IMX_AITC_BASE+0x0c)
 #define IMX_INTENABLEH     __REG(IMX_AITC_BASE+0x10)
 #define IMX_INTENABLEL     __REG(IMX_AITC_BASE+0x14)
+#define IMX_PRIO7          __REG(IMX_AITC_BASE+0x20)
+#define IMX_PRIO6          __REG(IMX_AITC_BASE+0x24)
+#define IMX_PRIO5          __REG(IMX_AITC_BASE+0x28)
+#define IMX_PRIO4          __REG(IMX_AITC_BASE+0x2C)
+#define IMX_PRIO3          __REG(IMX_AITC_BASE+0x30)
+#define IMX_PRIO2          __REG(IMX_AITC_BASE+0x34)
+#define IMX_PRIO1          __REG(IMX_AITC_BASE+0x38)
+#define IMX_PRIO0          __REG(IMX_AITC_BASE+0x3C)
=20
+#define IMX_PRIO(x)	   __REG2(IMX_AITC_BASE+0x20,((7-((x)>>3)) <<2) )=20
 /*
  *  General purpose timers
  */
@@ -417,6 +426,7 @@
 #define PCR_BPIX_8      (3<<25)
 #define PCR_BPIX_12     (4<<25)
 #define PCR_BPIX_16     (4<<25)
+#define PCR_BPIX_MASK   (7<<25)
 #define PCR_PIXPOL      (1<<24)
 #define PCR_FLMPOL      (1<<23)
 #define PCR_LPPOL       (1<<22)
Index: include/asm-arm/arch-imx/irqs.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- include/asm-arm/arch-imx/irqs.h	(revision 91)
+++ include/asm-arm/arch-imx/irqs.h	(working copy)
@@ -113,4 +113,17 @@
=20
 #define NR_IRQS (IRQ_GPIOD(32) + 1)
 #define IRQ_GPIO(x)
+
+#ifdef CONFIG_IPIPE
+#define __ipipe_irqbit(irq) (1ULL << (irq))
+
+#define __ipipe_muxed_irqmask (__ipipe_irqbit(GPIO_INT_PORTA) | \
+                               __ipipe_irqbit(GPIO_INT_PORTB) | \
+                               __ipipe_irqbit(GPIO_INT_PORTC) | \
+                               __ipipe_irqbit(GPIO_INT_PORTD))
+
+#define __ipipe_mach_irq_mux_p(irq) (__ipipe_irqbit(irq) \
+                                     & __ipipe_muxed_irqmask)
+#endif /* CONFIG_IPIPE */        =20
+
 #endif
Index: include/asm-arm/arch-ixp4xx/irqs.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- include/asm-arm/arch-ixp4xx/irqs.h	(revision 91)
+++ include/asm-arm/arch-ixp4xx/irqs.h	(working copy)
@@ -70,6 +70,10 @@
=20
 #define	XSCALE_PMU_IRQ		(IRQ_IXP4XX_XSCALE_PMU)
=20
+#ifdef CONFIG_IPIPE
+#define __ipipe_mach_irq_mux_p(irq) 0 /* We have no cascaded interrupts.=
 */
+#endif
+
 /*
  * IXDP425 board IRQs
  */
Index: include/asm-arm/bitops.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- include/asm-arm/bitops.h	(revision 91)
+++ include/asm-arm/bitops.h	(working copy)
@@ -41,9 +41,9 @@
=20
 	p +=3D bit >> 5;
=20
-	raw_local_irq_save(flags);
+	local_irq_save_hw(flags);
 	*p |=3D mask;
-	raw_local_irq_restore(flags);
+	local_irq_restore_hw(flags);
 }
=20
 static inline void ____atomic_clear_bit(unsigned int bit, volatile unsig=
ned long *p)
@@ -53,9 +53,9 @@
=20
 	p +=3D bit >> 5;
=20
-	raw_local_irq_save(flags);
+	local_irq_save_hw(flags);
 	*p &=3D ~mask;
-	raw_local_irq_restore(flags);
+	local_irq_restore_hw(flags);
 }
=20
 static inline void ____atomic_change_bit(unsigned int bit, volatile unsi=
gned long *p)
@@ -65,9 +65,9 @@
=20
 	p +=3D bit >> 5;
=20
-	raw_local_irq_save(flags);
+	local_irq_save_hw(flags);
 	*p ^=3D mask;
-	raw_local_irq_restore(flags);
+	local_irq_restore_hw(flags);
 }
=20
 static inline int
@@ -79,10 +79,10 @@
=20
 	p +=3D bit >> 5;
=20
-	raw_local_irq_save(flags);
+	local_irq_save_hw(flags);
 	res =3D *p;
 	*p =3D res | mask;
-	raw_local_irq_restore(flags);
+	local_irq_restore_hw(flags);
=20
 	return res & mask;
 }
@@ -96,10 +96,10 @@
=20
 	p +=3D bit >> 5;
=20
-	raw_local_irq_save(flags);
+	local_irq_save_hw(flags);
 	res =3D *p;
 	*p =3D res & ~mask;
-	raw_local_irq_restore(flags);
+	local_irq_restore_hw(flags);
=20
 	return res & mask;
 }
@@ -113,10 +113,10 @@
=20
 	p +=3D bit >> 5;
=20
-	raw_local_irq_save(flags);
+	local_irq_save_hw(flags);
 	res =3D *p;
 	*p =3D res ^ mask;
-	raw_local_irq_restore(flags);
+	local_irq_restore_hw(flags);
=20
 	return res & mask;
 }
Index: include/asm-arm/mmu_context.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- include/asm-arm/mmu_context.h	(revision 91)
+++ include/asm-arm/mmu_context.h	(working copy)
@@ -97,7 +97,7 @@
 	  struct task_struct *tsk)
 {
 #ifdef CONFIG_MMU
-	unsigned int cpu =3D smp_processor_id();
+    unsigned int cpu =3D smp_processor_id_hw();
=20
 	/* check for possible thread migration */
 	if (!cpus_empty(next->cpu_vm_mask) && !cpu_isset(cpu, next->cpu_vm_mask=
))
@@ -108,8 +108,19 @@
=20
 	if (!cpu_test_and_set(cpu, next->cpu_vm_mask) || prev !=3D next) {
 		check_context(next);
-		cpu_switch_mm(next->pgd, next);
-		if (cache_is_vivt())
+#if defined(CONFIG_IPIPE)
+ 		if (ipipe_current_domain =3D=3D ipipe_root_domain) {
+ 			do {
+ 				per_cpu(ipipe_active_mm, cpu) =3D NULL; /* mm state is undefined. *=
/
+ 				barrier();
+ 				cpu_switch_mm(next->pgd, next);
+ 				barrier();
+ 				per_cpu(ipipe_active_mm, cpu) =3D next;
+ 			} while (test_and_clear_thread_flag(TIF_MMSWITCH_INT));
+ 		} else
+#endif /* CONFIG_IPIPE */
+ 			cpu_switch_mm(next->pgd, next);
+ 		if (cache_is_vivt() && prev)
 			cpu_clear(cpu, prev->cpu_vm_mask);
 	}
 #endif
Index: include/asm-arm/arch-pxa/irqs.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- include/asm-arm/arch-pxa/irqs.h	(revision 91)
+++ include/asm-arm/arch-pxa/irqs.h	(working copy)
@@ -82,6 +82,10 @@
 #define IRQ_TO_GPIO_2_x(i)	((i) - PXA_GPIO_IRQ_BASE)
 #define IRQ_TO_GPIO(i)	(((i) < IRQ_GPIO(2)) ? ((i) - IRQ_GPIO0) : IRQ_TO=
_GPIO_2_x(i))
=20
+#ifdef CONFIG_IPIPE
+#define __ipipe_mach_irq_mux_p(irq) ((irq) =3D=3D IRQ_GPIO_2_x)
+#endif /* CONFIG_IPIPE */
+
 /*
  * The next 16 interrupts are for board specific purposes.  Since
  * the kernel can only run on one machine at a time, we can re-use
Index: include/asm-arm/thread_info.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- include/asm-arm/thread_info.h	(revision 91)
+++ include/asm-arm/thread_info.h	(working copy)
@@ -150,6 +150,9 @@
 #define TIF_USING_IWMMXT	17
 #define TIF_MEMDIE		18
 #define TIF_FREEZE		19
+#ifdef CONFIG_IPIPE
+#define TIF_MMSWITCH_INT        20
+#endif /* CONFIG_IPIPE */
=20
 #define _TIF_SIGPENDING		(1 << TIF_SIGPENDING)
 #define _TIF_NEED_RESCHED	(1 << TIF_NEED_RESCHED)
@@ -157,6 +160,9 @@
 #define _TIF_POLLING_NRFLAG	(1 << TIF_POLLING_NRFLAG)
 #define _TIF_USING_IWMMXT	(1 << TIF_USING_IWMMXT)
 #define _TIF_FREEZE		(1 << TIF_FREEZE)
+#ifdef CONFIG_IPIPE
+#define _TIF_MMSWITCH_INT       (1 << TIF_MMSWITCH_INT)
+#endif /* CONFIG_IPIPE */
=20
 /*
  * Change these and you break ASM code in entry-common.S
Index: include/asm-arm/system.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- include/asm-arm/system.h	(revision 91)
+++ include/asm-arm/system.h	(working copy)
@@ -264,7 +264,9 @@
=20
 #define switch_to(prev,next,last)					\
 do {									\
-	last =3D __switch_to(prev,task_thread_info(prev), task_thread_info(next=
));	\
+	local_irq_disable_hw_cond();					\
+	last =3D __switch_to(prev,task_thread_info(prev), task_thread_info(next=
)); \
+	local_irq_enable_hw_cond();					\
 } while (0)
=20
 #if defined(CONFIG_CPU_SA1100) || defined(CONFIG_CPU_SA110)
@@ -324,17 +326,17 @@
 #error SMP is not supported on this platform
 #endif
 	case 1:
-		raw_local_irq_save(flags);
+		local_irq_save_hw(flags);
 		ret =3D *(volatile unsigned char *)ptr;
 		*(volatile unsigned char *)ptr =3D x;
-		raw_local_irq_restore(flags);
+		local_irq_restore_hw(flags);
 		break;
=20
 	case 4:
-		raw_local_irq_save(flags);
+		local_irq_save_hw(flags);
 		ret =3D *(volatile unsigned long *)ptr;
 		*(volatile unsigned long *)ptr =3D x;
-		raw_local_irq_restore(flags);
+		local_irq_restore_hw(flags);
 		break;
 #else
 	case 1:
Index: include/asm-arm/arch-np4/irqs.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- include/asm-arm/arch-np4/irqs.h	(revision 91)
+++ include/asm-arm/arch-np4/irqs.h	(working copy)
@@ -25,4 +25,8 @@
=20
 #define NR_IRQS N_IRQ
=20
+#ifdef CONFIG_IPIPE
+#define __ipipe_mach_irq_mux_p(irq) (0)
 #endif
+
+#endif
Index: include/asm-arm/irqflags.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- include/asm-arm/irqflags.h	(revision 91)
+++ include/asm-arm/irqflags.h	(working copy)
@@ -10,30 +10,30 @@
  */
 #if __LINUX_ARM_ARCH__ >=3D 6
=20
-#define raw_local_irq_save(x)					\
+#define local_irq_save_hw_notrace(x)					\
 	({							\
 	__asm__ __volatile__(					\
-	"mrs	%0, cpsr		@ local_irq_save\n"	\
+	"mrs	%0, cpsr		@ local_irq_save_hw\n"	\
 	"cpsid	i"						\
 	: "=3Dr" (x) : : "memory", "cc");				\
 	})
=20
-#define raw_local_irq_enable()  __asm__("cpsie i	@ __sti" : : : "memory"=
, "cc")
-#define raw_local_irq_disable() __asm__("cpsid i	@ __cli" : : : "memory"=
, "cc")
-#define local_fiq_enable()  __asm__("cpsie f	@ __stf" : : : "memory", "c=
c")
-#define local_fiq_disable() __asm__("cpsid f	@ __clf" : : : "memory", "c=
c")
+#define local_irq_enable_hw_notrace()  __asm__("cpsie i	@ __sti" : : : "=
memory", "cc")
+#define local_irq_disable_hw_notrace() __asm__("cpsid i	@ __cli" : : : "=
memory", "cc")
+#define local_fiq_enable_hw_notrace()  __asm__("cpsie f	@ __stf" : : : "=
memory", "cc")
+#define local_fiq_disable_hw_notrace() __asm__("cpsid f	@ __clf" : : : "=
memory", "cc")
=20
 #else
=20
 /*
  * Save the current interrupt enable state & disable IRQs
  */
-#define raw_local_irq_save(x)					\
+#define local_irq_save_hw_notrace(x)					\
 	({							\
 		unsigned long temp;				\
 		(void) (&temp =3D=3D &x);				\
 	__asm__ __volatile__(					\
-	"mrs	%0, cpsr		@ local_irq_save\n"	\
+	"mrs	%0, cpsr		@ local_irq_save_hw\n"	\
 "	orr	%1, %0, #128\n"					\
 "	msr	cpsr_c, %1"					\
 	: "=3Dr" (x), "=3Dr" (temp)					\
@@ -44,11 +44,11 @@
 /*
  * Enable IRQs
  */
-#define raw_local_irq_enable()					\
+#define local_irq_enable_hw_notrace()				\
 	({							\
 		unsigned long temp;				\
 	__asm__ __volatile__(					\
-	"mrs	%0, cpsr		@ local_irq_enable\n"	\
+	"mrs	%0, cpsr		@ local_irq_enable_hw\n"	\
 "	bic	%0, %0, #128\n"					\
 "	msr	cpsr_c, %0"					\
 	: "=3Dr" (temp)						\
@@ -59,11 +59,11 @@
 /*
  * Disable IRQs
  */
-#define raw_local_irq_disable()					\
+#define local_irq_disable_hw_notrace()				\
 	({							\
 		unsigned long temp;				\
 	__asm__ __volatile__(					\
-	"mrs	%0, cpsr		@ local_irq_disable\n"	\
+	"mrs	%0, cpsr		@ local_irq_disable_hw\n"	\
 "	orr	%0, %0, #128\n"					\
 "	msr	cpsr_c, %0"					\
 	: "=3Dr" (temp)						\
@@ -74,7 +74,7 @@
 /*
  * Enable FIQs
  */
-#define local_fiq_enable()					\
+#define local_fiq_enable_hw_notrace()				\
 	({							\
 		unsigned long temp;				\
 	__asm__ __volatile__(					\
@@ -89,7 +89,7 @@
 /*
  * Disable FIQs
  */
-#define local_fiq_disable()					\
+#define local_fiq_disable_hw_notrace()				\
 	({							\
 		unsigned long temp;				\
 	__asm__ __volatile__(					\
@@ -106,19 +106,19 @@
 /*
  * Save the current interrupt enable state.
  */
-#define raw_local_save_flags(x)					\
+#define local_save_flags_hw(x)					\
 	({							\
 	__asm__ __volatile__(					\
-	"mrs	%0, cpsr		@ local_save_flags"	\
+	"mrs	%0, cpsr		@ local_save_flags_hw"	\
 	: "=3Dr" (x) : : "memory", "cc");				\
 	})
=20
 /*
  * restore saved IRQ & FIQ state
  */
-#define raw_local_irq_restore(x)				\
+#define local_irq_restore_hw_notrace(x)				\
 	__asm__ __volatile__(					\
-	"msr	cpsr_c, %0		@ local_irq_restore\n"	\
+	"msr	cpsr_c, %0		@ local_irq_restore_hw\n"	\
 	:							\
 	: "r" (x)						\
 	: "memory", "cc")
@@ -128,5 +128,99 @@
 	(int)((flags) & PSR_I_BIT);	\
 })
=20
+#define irqs_disabled_hw()			\
+({						\
+	unsigned long flags;			\
+	local_save_flags_hw(flags);		\
+	raw_irqs_disabled_flags(flags);		\
+})
+
+static inline unsigned long raw_mangle_irq_bits(int virt, unsigned long =
real)
+{
+	/* Merge virtual and real interrupt mask bits into a single
+	   32bit word. */
+	return (real & ~(1L << 8)) | ((virt !=3D 0) << 8);
+}
+
+static inline int raw_demangle_irq_bits(unsigned long *x)
+{
+	int virt =3D (*x & (1 << 8)) !=3D 0;
+	*x &=3D ~(1L << 8);
+	return virt;
+}
+
+#ifdef CONFIG_IPIPE
+
+void __ipipe_unstall_root(void);
+void __ipipe_restore_root(unsigned long flags);
+
+/* PSR_I_BIT is bit no. 7 and is set if interrupts are _disabled_ */
+#define raw_local_irq_save(flags)		((flags) =3D __ipipe_test_and_stall_r=
oot() << 7)
+#define raw_local_irq_enable()		__ipipe_unstall_root()
+#define raw_local_irq_disable()		__ipipe_stall_root()
+#define local_fiq_enable()		__ipipe_unstall_root()
+#define local_fiq_disable()		__ipipe_stall_root()
+#define raw_local_save_flags(flags)	((flags) =3D __ipipe_test_root() << =
7)
+#define raw_local_irq_restore(flags)	__ipipe_restore_root(flags & (1 << =
7))
+
+#ifdef CONFIG_IPIPE_TRACE_IRQSOFF
+
+#include <linux/ipipe_trace.h>
+
+#define local_irq_disable_hw() do { \
+	if (!irqs_disabled_hw()) { \
+		local_irq_disable_hw_notrace(); \
+		ipipe_trace_begin(0x80000000); \
+	} \
+} while (0)
+#define local_irq_enable_hw() do { \
+	if (irqs_disabled_hw()) { \
+		ipipe_trace_end(0x80000000); \
+		local_irq_enable_hw_notrace(); \
+	} \
+} while (0)
+#define local_irq_save_hw(x) do { \
+	local_save_flags_hw(x); \
+	if (!raw_irqs_disabled_flags(x)) { \
+		local_irq_disable_hw_notrace(); \
+		ipipe_trace_begin(0x80000001); \
+	} \
+} while (0)
+#define local_irq_restore_hw(x) do { \
+	if (!raw_irqs_disabled_flags(x)) \
+		ipipe_trace_end(0x80000001); \
+	local_irq_restore_hw_notrace(x); \
+} while (0)
+
+#else /* !CONFIG_IPIPE_TRACE_IRQSOFF */
+
+#define local_irq_save_hw(flags)	local_irq_save_hw_notrace(flags)
+#define local_irq_enable_hw()		local_irq_enable_hw_notrace()
+#define local_irq_disable_hw()		local_irq_disable_hw_notrace()
+#define local_fiq_enable_hw()		local_fiq_enable_hw_notrace()
+#define local_fiq_disable_hw()		local_fiq_disable_hw_notrace()
+#define local_irq_restore_hw(flags)	local_irq_restore_hw_notrace(flags)
+
+#endif /* CONFIG_IPIPE_TRACE_IRQSOFF */
+
+#else /* !CONFIG_IPIPE */
+
+#define raw_local_irq_save(flags)	local_irq_save_hw_notrace(flags)
+#define raw_local_irq_enable()		local_irq_enable_hw_notrace()
+#define raw_local_irq_disable()		local_irq_disable_hw_notrace()
+#define local_fiq_enable()		local_fiq_enable_hw_notrace()
+#define local_fiq_disable()		local_fiq_disable_hw_notrace()
+#define raw_local_save_flags(flags)	local_save_flags_hw(flags)
+#define raw_local_irq_restore(flags)	local_irq_restore_hw_notrace(flags)=

+
+#define local_irq_save_hw(flags)	local_irq_save_hw_notrace(flags)
+#define local_irq_enable_hw()		local_irq_enable_hw_notrace()
+#define local_irq_disable_hw()		local_irq_disable_hw_notrace()
+#define local_fiq_enable_hw()		local_fiq_enable_hw_notrace()
+#define local_fiq_disable_hw()		local_fiq_disable_hw_notrace()
+#define local_irq_restore_hw(flags)	local_irq_restore_hw_notrace(flags)
+
+#endif /* CONFIG_IPIPE */
+
 #endif
 #endif
Index: include/asm-arm/arch-sa1100/irqs.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- include/asm-arm/arch-sa1100/irqs.h	(revision 91)
+++ include/asm-arm/arch-sa1100/irqs.h	(working copy)
@@ -144,6 +144,10 @@
 #define IRQ_LOCOMO_SPI_OVRN	(IRQ_BOARD_END + 20)
 #define IRQ_LOCOMO_SPI_TEND	(IRQ_BOARD_END + 21)
=20
+#ifdef CONFIG_IPIPE
+#define __ipipe_mach_irq_mux_p(irq) ((irq) =3D=3D IRQ_GPIO11_27)
+#endif /* CONFIG_IPIPE */
+
 /*
  * Figure out the MAX IRQ number.
  *
Index: include/asm-arm/ipipe_base.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- include/asm-arm/ipipe_base.h	(revision 0)
+++ include/asm-arm/ipipe_base.h	(revision 0)
@@ -0,0 +1,103 @@
+/* -*- linux-c -*-
+ * include/asm-arm/ipipe_base.h
+ *
+ * Copyright (C) 2007 Gilles Chanteperdrix.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation, Inc., 675 Mass Ave, Cambridge MA 02139,=

+ * USA; either version 2 of the License, or (at your option) any later
+ * version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307,=
 USA.
+ */
+
+#ifndef __ARM_IPIPE_BASE_H
+#define __ARM_IPIPE_BASE_H
+
+#include <linux/threads.h>
+#include <asm/irq.h>
+
+#define IPIPE_NR_XIRQS		NR_IRQS
+#define IPIPE_IRQ_ISHIFT	5	/* 25 for 32bits arch. */
+
+/* ARM traps */
+#define IPIPE_TRAP_ACCESS	 0	/* Data or instruction access exception */
+#define IPIPE_TRAP_SECTION	 1	/* Section fault */
+#define IPIPE_TRAP_DABT		 2	/* Generic data abort */
+#define IPIPE_TRAP_UNKNOWN	 3	/* Unknown exception */
+#define IPIPE_TRAP_BREAK	 4	/* Instruction breakpoint */
+#define IPIPE_TRAP_FPU		 5	/* Floating point exception */
+#define IPIPE_TRAP_VFP		 6	/* VFP floating point exception */
+#define IPIPE_TRAP_UNDEFINSTR	 7	/* Undefined instruction */
+#define IPIPE_TRAP_ALIGNMENT	 8	/* Unaligned access exception */
+#define IPIPE_NR_FAULTS		 9
+
+/* Pseudo-vectors used for kernel events */
+#define IPIPE_FIRST_EVENT	IPIPE_NR_FAULTS
+#define IPIPE_EVENT_SYSCALL	(IPIPE_FIRST_EVENT)
+#define IPIPE_EVENT_SCHEDULE	(IPIPE_FIRST_EVENT + 1)
+#define IPIPE_EVENT_SIGWAKE	(IPIPE_FIRST_EVENT + 2)
+#define IPIPE_EVENT_SETSCHED	(IPIPE_FIRST_EVENT + 3)
+#define IPIPE_EVENT_INIT	(IPIPE_FIRST_EVENT + 4)
+#define IPIPE_EVENT_EXIT	(IPIPE_FIRST_EVENT + 5)
+#define IPIPE_EVENT_CLEANUP	(IPIPE_FIRST_EVENT + 6)
+#define IPIPE_LAST_EVENT	IPIPE_EVENT_CLEANUP
+#define IPIPE_NR_EVENTS		(IPIPE_LAST_EVENT + 1)
+
+#ifndef __ASSEMBLY__
+
+#include <asm/irqflags.h>
+
+#ifdef CONFIG_SMP
+#error "SMP not implemented."
+#define __ipipe_root_status ipipe_root_cpudom_var(status)
+
+#else /* !CONFIG_SMP */
+
+#if __GNUC__ >=3D 4
+/* Alias to ipipe_root_cpudom_var(status) */
+extern unsigned long __ipipe_root_status;
+#else
+extern unsigned long *const __ipipe_root_status_addr;
+#define __ipipe_root_status	(*__ipipe_root_status_addr)
+#endif
+
+static inline void __ipipe_stall_root(void)
+{
+	unsigned long flags;
+
+	local_irq_save_hw(flags);
+	__ipipe_root_status |=3D 1;
+	local_irq_restore_hw(flags);
+}
+
+static inline unsigned __ipipe_test_root(void)
+{
+	return __ipipe_root_status & 1;
+}
+
+static inline unsigned __ipipe_test_and_stall_root(void)
+{
+	unsigned long flags, res;
+
+	local_irq_save_hw(flags);
+	res =3D __ipipe_root_status;
+	__ipipe_root_status =3D res | 1;
+	local_irq_restore_hw(flags);
+
+	return res & 1;
+}
+
+#endif	/* CONFIG_SMP */
+
+#endif /* !__ASSEMBLY__ */
+
+#endif /* __ARM_IPIPE_BASE_H */
Index: include/asm-arm/atomic.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- include/asm-arm/atomic.h	(revision 91)
+++ include/asm-arm/atomic.h	(working copy)
@@ -151,10 +151,10 @@
 	unsigned long flags;
 	int val;
=20
-	raw_local_irq_save(flags);
+	local_irq_save_hw(flags);
 	val =3D v->counter;
 	v->counter =3D val +=3D i;
-	raw_local_irq_restore(flags);
+	local_irq_restore_hw(flags);
=20
 	return val;
 }
@@ -164,10 +164,10 @@
 	unsigned long flags;
 	int val;
=20
-	raw_local_irq_save(flags);
+	local_irq_save_hw(flags);
 	val =3D v->counter;
 	v->counter =3D val -=3D i;
-	raw_local_irq_restore(flags);
+	local_irq_restore_hw(flags);
=20
 	return val;
 }
@@ -177,11 +177,11 @@
 	int ret;
 	unsigned long flags;
=20
-	raw_local_irq_save(flags);
+	local_irq_save_hw(flags);
 	ret =3D v->counter;
 	if (likely(ret =3D=3D old))
 		v->counter =3D new;
-	raw_local_irq_restore(flags);
+	local_irq_restore_hw(flags);
=20
 	return ret;
 }
@@ -190,9 +190,9 @@
 {
 	unsigned long flags;
=20
-	raw_local_irq_save(flags);
+	local_irq_save_hw(flags);
 	*addr &=3D ~mask;
-	raw_local_irq_restore(flags);
+	local_irq_restore_hw(flags);
 }
=20
 #endif /* __LINUX_ARM_ARCH__ */
Index: include/asm-arm/arch-s3c2410/irqs.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- include/asm-arm/arch-s3c2410/irqs.h	(revision 91)
+++ include/asm-arm/arch-s3c2410/irqs.h	(working copy)
@@ -3,6 +3,8 @@
  * Copyright (c) 2003-2005 Simtec Electronics
  *   Ben Dooks <ben@domain.hid>
  *
+ * Copyright (C) 2006, 2007 Sebastian Smolorz <ssmolorz@domain.hid>, emli=
x GmbH
+ *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
@@ -160,4 +162,38 @@
 #define NR_IRQS (IRQ_S3C2440_AC97+1)
 #endif
=20
+#ifdef CONFIG_IPIPE
+#define __ipipe_irqbit(irq)	(1 << ((irq) - S3C2410_CPUIRQ_OFFSET))
+
+#ifdef CONFIG_CPU_S3C2440
+#define __ipipe_muxed_irqmask	(__ipipe_irqbit(IRQ_UART0)	|	\
+				 __ipipe_irqbit(IRQ_UART1)	|	\
+				 __ipipe_irqbit(IRQ_UART2)	|	\
+				 __ipipe_irqbit(IRQ_ADCPARENT)	|	\
+				 __ipipe_irqbit(IRQ_WDT)	|	\
+				 __ipipe_irqbit(IRQ_CAM)	|	\
+				 __ipipe_irqbit(IRQ_EINT4t7)	|	\
+				 __ipipe_irqbit(IRQ_EINT8t23))
+#elif defined CONFIG_CPU_S3C244X
+#define __ipipe_muxed_irqmask	(__ipipe_irqbit(IRQ_UART0)	|	\
+				 __ipipe_irqbit(IRQ_UART1)	|	\
+				 __ipipe_irqbit(IRQ_UART2)	|	\
+				 __ipipe_irqbit(IRQ_ADCPARENT)	|	\
+				 __ipipe_irqbit(IRQ_CAM)	|	\
+				 __ipipe_irqbit(IRQ_EINT4t7)	|	\
+				 __ipipe_irqbit(IRQ_EINT8t23))
+#else
+#define __ipipe_muxed_irqmask	(__ipipe_irqbit(IRQ_UART0)	|	\
+				 __ipipe_irqbit(IRQ_UART1)	|	\
+				 __ipipe_irqbit(IRQ_UART2)	|	\
+				 __ipipe_irqbit(IRQ_ADCPARENT)	|	\
+				 __ipipe_irqbit(IRQ_EINT4t7)	|	\
+				 __ipipe_irqbit(IRQ_EINT8t23))
+#endif
+
+#define __ipipe_mach_irq_mux_p(irq)	((irq) <=3D IRQ_ADCPARENT  &&	\
+					 (__ipipe_irqbit(irq) &		\
+					  __ipipe_muxed_irqmask))
+#endif /* CONFIG_IPIPE */
+
 #endif /* __ASM_ARCH_IRQ_H */
Index: include/asm-arm/arch-integrator/entry-macro.S
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- include/asm-arm/arch-integrator/entry-macro.S	(revision 91)
+++ include/asm-arm/arch-integrator/entry-macro.S	(working copy)
@@ -29,7 +29,11 @@
 		itt	eq
 		ldreq	\irqstat, [\base, #(INTEGRATOR_HDR_IC_OFFSET+IRQ_STATUS)]
 		moveq	\irqnr, #IRQ_CIC_START
-
+#ifdef CONFIG_IPIPE
+		tst	\irqstat, #0x00000040			@ check IRQ_TIMERINT1 first
+		movne	\irqnr, #6
+		bne	1003f
+#endif /* CONFIG_IPIPE */
 1001:		tst	\irqstat, #15
 		bne	1002f
 		add	\irqnr, \irqnr, #4
Index: include/asm-arm/arch-integrator/irqs.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- include/asm-arm/arch-integrator/irqs.h	(revision 91)
+++ include/asm-arm/arch-integrator/irqs.h	(working copy)
@@ -80,3 +80,6 @@
=20
 #define NR_IRQS                         47
=20
+#ifdef CONFIG_IPIPE
+#define __ipipe_mach_irq_mux_p(irq) ((irq) =3D=3D IRQ_CP_CPPLDINT)
+#endif /* CONFIG_IPIPE */
Index: include/asm-arm/arch-integrator/platform.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- include/asm-arm/arch-integrator/platform.h	(revision 91)
+++ include/asm-arm/arch-integrator/platform.h	(working copy)
@@ -26,7 +26,7 @@
  * 	NOTE: This is a multi-hosted header file for use with uHAL and
  * 	      supported debuggers.
  *
- * 	$Id: platform.s,v 1.32 2000/02/18 10:51:39 asims Exp $
+ * 	$Id: platform.h,v 1.2 2006/02/20 13:54:22 rpm Exp $
  *
  * *********************************************************************=
**/
=20
@@ -436,7 +436,7 @@
  *  Timer definitions
  *
  *  Only use timer 1 & 2
- *  (both run at 24MHz and will need the clock divider set to 16).
+ *  (both run at 1MHZ on /CP and at 24MHz on /AP)
  *
  *  Timer 0 runs at bus frequency and therefore could vary and currently=

  *  uHAL can't handle that.
@@ -449,7 +449,12 @@
=20
 #define MAX_TIMER                       2
 #define MAX_PERIOD                      699050
+
+#ifdef CONFIG_ARCH_INTEGRATOR_CP
+#define TICKS_PER_uSEC                  1
+#else
 #define TICKS_PER_uSEC                  24
+#endif
=20
 /*
  *  These are useconds NOT ticks.
Index: include/asm-arm/arch-integrator/timex.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- include/asm-arm/arch-integrator/timex.h	(revision 91)
+++ include/asm-arm/arch-integrator/timex.h	(working copy)
@@ -21,6 +21,6 @@
  */
=20
 /*
- * ??
+ * Timer rate
  */
-#define CLOCK_TICK_RATE		(50000000 / 16)
+#define CLOCK_TICK_RATE		(1000000)
Index: include/asm-arm/ipipe.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- include/asm-arm/ipipe.h	(revision 0)
+++ include/asm-arm/ipipe.h	(revision 0)
@@ -0,0 +1,194 @@
+/* -*- linux-c -*-
+ * include/asm-arm/ipipe.h
+ *
+ * Copyright (C) 2002-2005 Philippe Gerum.
+ * Copyright (C) 2005 Stelian Pop.
+ * Copyright (C) 2006-2008 Gilles Chanteperdrix.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation, Inc., 675 Mass Ave, Cambridge MA 02139,=

+ * USA; either version 2 of the License, or (at your option) any later
+ * version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307,=
 USA.
+ */
+
+#ifndef __ARM_IPIPE_H
+#define __ARM_IPIPE_H
+
+#ifdef CONFIG_IPIPE
+
+#include <linux/ipipe_percpu.h>
+
+#define IPIPE_ARCH_STRING	"1.9-01"
+#define IPIPE_MAJOR_NUMBER	1
+#define IPIPE_MINOR_NUMBER	9
+#define IPIPE_PATCH_NUMBER	1
+
+#ifdef CONFIG_SMP
+#error "I-pipe/arm: SMP not yet implemented"
+#define ipipe_processor_id()	(current_thread_info()->cpu)
+#else /* !CONFIG_SMP */
+#define ipipe_processor_id()	0
+#endif	/* CONFIG_SMP */
+
+#define smp_processor_id_hw() ipipe_processor_id()
+
+#define prepare_arch_switch(next) ipipe_schedule_notify(current, next)
+
+/* We would need to clear the SYNC flag for the root domain */
+/* over the current processor in SMP mode. */
+#define task_hijacked(p) !ipipe_root_domain_p
+
+extern unsigned long arm_return_addr(int level);
+
+#define BROKEN_BUILTIN_RETURN_ADDRESS
+#define __BUILTIN_RETURN_ADDRESS0 arm_return_addr(0)
+#define __BUILTIN_RETURN_ADDRESS1 arm_return_addr(1)
+
+
+struct ipipe_domain;
+
+#define IPIPE_TSC_TYPE_NONE        0
+#define IPIPE_TSC_TYPE_FREERUNNING 1
+#define IPIPE_TSC_TYPE_DECREMENTER 2
+
+struct __ipipe_tscinfo {
+        unsigned type;
+        union {
+                struct {
+                        unsigned *counter; /* Hw counter physical addres=
s */
+                        unsigned mask; /* Significant bits in the hw cou=
nter. */
+                        unsigned long long *tsc; /* 64 bits tsc value. *=
/
+                } fr;
+                struct {
+			unsigned *counter; /* Hw counter physical address */
+			unsigned mask; /* Significant bits in the hw counter. */
+			unsigned *last_cnt; /* Counter value when updating
+						tsc value. */
+			unsigned long long *tsc; /* 64 bits tsc value. */
+                } dec;
+        } u;
+};
+
+struct ipipe_sysinfo {
+
+	int ncpus;		/* Number of CPUs on board */
+	u64 cpufreq;		/* CPU frequency (in Hz) */
+
+	/* Arch-dependent block */
+
+	struct {
+		unsigned tmirq;	/* Timer tick IRQ */
+		u64 tmfreq;	/* Timer frequency */
+                struct __ipipe_tscinfo tsc; /* exported data for u.s. ts=
c */
+	} archdep;
+};
+
+DECLARE_PER_CPU(struct mm_struct *,ipipe_active_mm);
+/* arch specific stuff */
+extern void *__ipipe_tsc_area;
+extern int __ipipe_mach_timerint;
+extern int __ipipe_mach_timerstolen;
+extern unsigned int __ipipe_mach_ticks_per_jiffy;
+extern void __ipipe_mach_acktimer(void);
+extern unsigned long long __ipipe_mach_get_tsc(void);
+extern void __ipipe_mach_set_dec(unsigned long);
+extern void __ipipe_mach_release_timer(void);
+extern unsigned long __ipipe_mach_get_dec(void);
+extern void __ipipe_mach_demux_irq(unsigned irq, struct pt_regs *regs);
+void __ipipe_mach_get_tscinfo(struct __ipipe_tscinfo *info);
+int __ipipe_check_tickdev(const char *devname);
+
+#define ipipe_read_tsc(t)		do { t =3D __ipipe_mach_get_tsc(); } while (0=
)
+#define __ipipe_read_timebase()		__ipipe_mach_get_tsc()
+
+#define ipipe_cpu_freq()	(HZ * __ipipe_mach_ticks_per_jiffy)
+#define ipipe_tsc2ns(t) \
+({ \
+	unsigned long long delta =3D (t)*1000; \
+	do_div(delta, ipipe_cpu_freq() / 1000000 + 1); \
+	(unsigned long)delta; \
+})
+#define ipipe_tsc2us(t) \
+({ \
+	unsigned long long delta =3D (t); \
+	do_div(delta, ipipe_cpu_freq() / 1000000 + 1); \
+	(unsigned long)delta; \
+})
+
+/* Private interface -- Internal use only */
+
+#define __ipipe_check_platform()	do { } while(0)
+
+#define __ipipe_init_platform()		do { } while(0)
+
+#define __ipipe_enable_irq(irq)	irq_desc[irq].chip->enable(irq)
+
+#define __ipipe_disable_irq(irq)	irq_desc[irq].chip->disable(irq)
+
+#define __ipipe_hook_critical_ipi(ipd) do { } while(0)
+
+void __ipipe_enable_irqdesc(struct ipipe_domain *ipd, unsigned irq);
+
+void __ipipe_enable_pipeline(void);
+
+void __ipipe_do_critical_sync(unsigned irq,
+			      void *cookie);
+
+DECLARE_PER_CPU(struct pt_regs, __ipipe_tick_regs);
+
+int __ipipe_handle_irq(int irq,
+                       struct pt_regs *regs);
+
+#define __ipipe_tick_irq	__ipipe_mach_timerint
+
+static inline unsigned long __ipipe_ffnz(unsigned long ul)
+{
+	return ffs(ul) - 1;
+}
+
+/* When running handlers, enable hw interrupts for all domains but the
+ * one heading the pipeline, so that IRQs can never be significantly
+ * deferred for the latter. */
+#define __ipipe_run_isr(ipd, irq)                                       =
\
+do {                                                                    =
\
+	local_irq_enable_nohead(ipd);                                   \
+	if (ipd =3D=3D ipipe_root_domain) {                                 \
+                if (likely(!ipipe_virtual_irq_p(irq)))                  =
\
+                        ((void (*)(unsigned, struct pt_regs *))         =
\
+                         ipd->irqs[irq].handler) (irq,                  =
\
+                                                  &__raw_get_cpu_var(__i=
pipe_tick_regs)); \
+                else {                                                  =
\
+                        irq_enter();                                    =
\
+                        ipd->irqs[irq].handler(irq,ipd->irqs[irq].cookie=
); \
+                        irq_exit();                                     =
\
+                }                                                       =
\
+	} else {							\
+		__clear_bit(IPIPE_SYNC_FLAG, &ipipe_cpudom_var(ipd, status)); \
+		ipd->irqs[irq].handler(irq,ipd->irqs[irq].cookie);	\
+		__set_bit(IPIPE_SYNC_FLAG, &ipipe_cpudom_var(ipd, status)); \
+	}								\
+	local_irq_disable_hw();                                         \
+} while(0)
+
+#define __ipipe_syscall_watched_p(p, sc)                                =
\
+	(((p)->flags & PF_EVNOTIFY) || (unsigned long)sc >=3D __ARM_NR_BASE + 6=
4)
+
+#else /* !CONFIG_IPIPE */
+
+#define task_hijacked(p)		0
+
+#define smp_processor_id_hw()		smp_processor_id()
+
+#endif /* CONFIG_IPIPE */
+
+#endif	/* !__ARM_IPIPE_H */
Index: include/linux/spinlock.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- include/linux/spinlock.h	(revision 91)
+++ include/linux/spinlock.h	(working copy)
@@ -89,10 +89,14 @@
 # include <linux/spinlock_up.h>
 #endif
=20
+#undef TYPE_EQUAL
+#define TYPE_EQUAL(lock, type) \
+	__builtin_types_compatible_p(typeof(lock), type *)
+
 #ifdef CONFIG_DEBUG_SPINLOCK
   extern void __spin_lock_init(spinlock_t *lock, const char *name,
 			       struct lock_class_key *key);
-# define spin_lock_init(lock)					\
+# define _spin_lock_init(lock)				\
 do {								\
 	static struct lock_class_key __key;			\
 								\
@@ -100,10 +104,21 @@
 } while (0)
=20
 #else
-# define spin_lock_init(lock)					\
+# define _spin_lock_init(lock)				\
 	do { *(lock) =3D SPIN_LOCK_UNLOCKED; } while (0)
 #endif
=20
+# define spin_lock_init(lock)						\
+	do {								\
+		if (TYPE_EQUAL((lock), __ipipe_spinlock_t))		\
+			do {						\
+				IPIPE_DEFINE_SPINLOCK(__lock__);	\
+				*((ipipe_spinlock_t *)lock) =3D __lock__; \
+			} while(0);					\
+		else							\
+			_spin_lock_init((spinlock_t *)lock);		\
+	} while(0)
+
 #ifdef CONFIG_DEBUG_SPINLOCK
   extern void __rwlock_init(rwlock_t *lock, const char *name,
 			    struct lock_class_key *key);
@@ -172,8 +187,87 @@
 #define read_trylock(lock)		__cond_lock(lock, _read_trylock(lock))
 #define write_trylock(lock)		__cond_lock(lock, _write_trylock(lock))
=20
-#define spin_lock(lock)			_spin_lock(lock)
+#define PICK_SPINOP(op, lock)						\
+do {									\
+	if (TYPE_EQUAL((lock), __ipipe_spinlock_t))			\
+		__raw_spin##op(&((__ipipe_spinlock_t *)(lock))->__raw_lock); \
+	else if (TYPE_EQUAL(lock, spinlock_t))				\
+		_spin##op((spinlock_t *)(lock));			\
+} while (0)
=20
+#define PICK_SPINOP_RAW(op, lock)					\
+do {									\
+	if (TYPE_EQUAL((lock), __ipipe_spinlock_t))			\
+		__raw_spin##op(&((__ipipe_spinlock_t *)(lock))->__raw_lock); \
+	else if (TYPE_EQUAL(lock, spinlock_t))				\
+		__raw_spin##op(&((spinlock_t *)(lock))->raw_lock);	\
+} while (0)
+
+#define PICK_SPINLOCK_IRQ(lock)						\
+do {									\
+	if (TYPE_EQUAL((lock), __ipipe_spinlock_t)) {			\
+		__ipipe_spin_lock_irq(&((__ipipe_spinlock_t *)(lock))->__raw_lock); \
+	} else if (TYPE_EQUAL(lock, spinlock_t))			\
+		_spin_lock_irq((spinlock_t *)(lock));			\
+} while (0)
+
+#define PICK_SPINUNLOCK_IRQ(lock)					\
+do {									\
+	if (TYPE_EQUAL((lock), __ipipe_spinlock_t)) {			\
+		__ipipe_spin_unlock_irq(&((__ipipe_spinlock_t *)(lock))->__raw_lock); =
\
+	} else if (TYPE_EQUAL(lock, spinlock_t))			\
+		_spin_unlock_irq((spinlock_t *)(lock));			\
+} while (0)
+
+#define PICK_SPINLOCK_IRQ_RAW(lock)					\
+do {									\
+	if (TYPE_EQUAL((lock), __ipipe_spinlock_t)) {			\
+		__ipipe_spin_lock_irq(&((__ipipe_spinlock_t *)(lock))->__raw_lock); \
+	} else if (TYPE_EQUAL(lock, spinlock_t))			\
+		local_irq_disable();					\
+		__raw_spin_lock(&((spinlock_t *)(lock))->raw_lock);	\
+} while (0)
+
+#define PICK_SPINUNLOCK_IRQ_RAW(lock)					\
+do {									\
+	if (TYPE_EQUAL((lock), __ipipe_spinlock_t)) {			\
+		__ipipe_spin_unlock_irq(&((__ipipe_spinlock_t *)(lock))->__raw_lock); =
\
+	} else if (TYPE_EQUAL(lock, spinlock_t))			\
+		__raw_spin_unlock(&((spinlock_t *)(lock))->raw_lock);	\
+		local_irq_enable();					\
+} while (0)
+
+#if defined(CONFIG_SMP) || defined(CONFIG_DEBUG_SPINLOCK)
+extern int __bad_spinlock_type(void);
+
+#define PICK_SPINLOCK_IRQSAVE(lock, flags)				\
+do {									\
+	if (TYPE_EQUAL((lock), __ipipe_spinlock_t)) {			\
+		(flags) =3D __ipipe_spin_lock_irqsave(&((__ipipe_spinlock_t *)(lock))-=
>__raw_lock); \
+	} else if (TYPE_EQUAL(lock, spinlock_t))			\
+		flags =3D _spin_lock_irqsave((spinlock_t *)(lock));	\
+	else __bad_spinlock_type();					\
+} while (0)
+#else
+#define PICK_SPINLOCK_IRQSAVE(lock, flags)				\
+do {									\
+	if (TYPE_EQUAL((lock), __ipipe_spinlock_t)) {			\
+		(flags) =3D __ipipe_spin_lock_irqsave(&((__ipipe_spinlock_t *)(lock))-=
>__raw_lock); \
+	} else if (TYPE_EQUAL(lock, spinlock_t))			\
+		_spin_lock_irqsave((spinlock_t *)(lock), flags);	\
+} while (0)
+#endif
+
+#define PICK_SPINUNLOCK_IRQRESTORE(lock, flags)				\
+	do {								\
+	if (TYPE_EQUAL((lock), __ipipe_spinlock_t)) {			\
+		__ipipe_spin_unlock_irqrestore(&((__ipipe_spinlock_t *)(lock))->__raw_=
lock, flags); \
+	} else if (TYPE_EQUAL(lock, spinlock_t))			\
+		_spin_unlock_irqrestore((spinlock_t *)(lock), flags);	\
+} while (0)
+
+#define spin_lock(lock)	PICK_SPINOP(_lock, lock)
+
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 # define spin_lock_nested(lock, subclass) _spin_lock_nested(lock, subcla=
ss)
 #else
@@ -185,7 +279,7 @@
=20
 #if defined(CONFIG_SMP) || defined(CONFIG_DEBUG_SPINLOCK)
=20
-#define spin_lock_irqsave(lock, flags)	flags =3D _spin_lock_irqsave(lock=
)
+#define spin_lock_irqsave(lock, flags)	PICK_SPINLOCK_IRQSAVE(lock, flags=
)
 #define read_lock_irqsave(lock, flags)	flags =3D _read_lock_irqsave(lock=
)
 #define write_lock_irqsave(lock, flags)	flags =3D _write_lock_irqsave(lo=
ck)
=20
@@ -199,7 +293,7 @@
=20
 #else
=20
-#define spin_lock_irqsave(lock, flags)	_spin_lock_irqsave(lock, flags)
+#define spin_lock_irqsave(lock, flags)	PICK_SPINLOCK_IRQSAVE(lock, flags=
)
 #define read_lock_irqsave(lock, flags)	_read_lock_irqsave(lock, flags)
 #define write_lock_irqsave(lock, flags)	_write_lock_irqsave(lock, flags)=

 #define spin_lock_irqsave_nested(lock, flags, subclass)	\
@@ -207,7 +301,7 @@
=20
 #endif
=20
-#define spin_lock_irq(lock)		_spin_lock_irq(lock)
+#define spin_lock_irq(lock)		PICK_SPINLOCK_IRQ(lock)
 #define spin_lock_bh(lock)		_spin_lock_bh(lock)
=20
 #define read_lock_irq(lock)		_read_lock_irq(lock)
@@ -221,32 +315,40 @@
  */
 #if defined(CONFIG_DEBUG_SPINLOCK) || defined(CONFIG_PREEMPT) || \
 	!defined(CONFIG_SMP)
-# define spin_unlock(lock)		_spin_unlock(lock)
+#define spin_unlock(lock)		PICK_SPINOP(_unlock, lock)
 # define read_unlock(lock)		_read_unlock(lock)
 # define write_unlock(lock)		_write_unlock(lock)
-# define spin_unlock_irq(lock)		_spin_unlock_irq(lock)
-# define read_unlock_irq(lock)		_read_unlock_irq(lock)
-# define write_unlock_irq(lock)		_write_unlock_irq(lock)
+# define spin_unlock_irq(lock)	PICK_SPINUNLOCK_IRQ(lock)
+# define read_unlock_irq(lock)	_read_unlock_irq(lock)
+# define write_unlock_irq(lock)	_write_unlock_irq(lock)
 #else
-# define spin_unlock(lock) \
-    do {__raw_spin_unlock(&(lock)->raw_lock); __release(lock); } while (=
0)
-# define read_unlock(lock) \
-    do {__raw_read_unlock(&(lock)->raw_lock); __release(lock); } while (=
0)
-# define write_unlock(lock) \
-    do {__raw_write_unlock(&(lock)->raw_lock); __release(lock); } while =
(0)
-# define spin_unlock_irq(lock)			\
+# define spin_unlock(lock)			\
 do {						\
-	__raw_spin_unlock(&(lock)->raw_lock);	\
+	PICK_SPINOP_RAW(_unlock, lock); 	\
 	__release(lock);			\
-	local_irq_enable();			\
+} while(0)
+# define read_unlock(lock)			\
+do {						\
+	__raw_read_unlock(&(lock)->raw_lock);	\
+	__release(lock);			\
 } while (0)
-# define read_unlock_irq(lock)			\
+# define write_unlock(lock)			\
 do {						\
+	__raw_write_unlock(&(lock)->raw_lock);	\
+	__release(lock);			\
+} while (0)
+# define spin_unlock_irq(lock)		\
+do {						\
+	PICK_SPINUNLOCK_IRQ_RAW(lock);		\
+	__release(lock);			\
+} while(0)
+# define read_unlock_irq(lock)		\
+do {						\
 	__raw_read_unlock(&(lock)->raw_lock);	\
 	__release(lock);			\
 	local_irq_enable();			\
 } while (0)
-# define write_unlock_irq(lock)			\
+# define write_unlock_irq(lock)		\
 do {						\
 	__raw_write_unlock(&(lock)->raw_lock);	\
 	__release(lock);			\
@@ -254,8 +356,8 @@
 } while (0)
 #endif
=20
-#define spin_unlock_irqrestore(lock, flags) \
-					_spin_unlock_irqrestore(lock, flags)
+#define spin_unlock_irqrestore(lock, flags)	\
+					PICK_SPINUNLOCK_IRQRESTORE(lock, flags)
 #define spin_unlock_bh(lock)		_spin_unlock_bh(lock)
=20
 #define read_unlock_irqrestore(lock, flags) \
@@ -346,4 +448,29 @@
  */
 #define spin_can_lock(lock)	(!spin_is_locked(lock))
=20
+#ifdef CONFIG_IPIPE
+void fastcall __ipipe_spin_lock_irq(raw_spinlock_t *lock);
+void fastcall __ipipe_spin_unlock_irq(raw_spinlock_t *lock);
+unsigned long fastcall __ipipe_spin_lock_irqsave(raw_spinlock_t *lock);
+void fastcall __ipipe_spin_unlock_irqrestore(raw_spinlock_t *lock,
+					     unsigned long x);
+void fastcall __ipipe_spin_unlock_irqbegin(ipipe_spinlock_t *lock);
+void fastcall __ipipe_spin_unlock_irqcomplete(unsigned long x);
+#define spin_lock_irqsave_cond(lock, flags) \
+	spin_lock_irqsave(lock, flags)
+#define spin_unlock_irqrestore_cond(lock, flags) \
+	spin_unlock_irqrestore(lock, flags)
+#else
+#define spin_lock_irqsave_cond(lock, flags) \
+	do { (void)(flags); spin_lock(lock); } while(0)
+#define spin_unlock_irqrestore_cond(lock, flags) \
+	spin_unlock(lock)
+#define __ipipe_spin_lock_irq(lock)		do { } while(0)
+#define __ipipe_spin_unlock_irq(lock)		do { } while(0)
+#define __ipipe_spin_lock_irqsave(lock)		0
+#define __ipipe_spin_unlock_irqrestore(lock, x)	do { (void)(x); } while(=
0)
+#define __ipipe_spin_unlock_irqbegin(lock)	do { } while(0)
+#define __ipipe_spin_unlock_irqcomplete(x)	do { (void)(x); } while(0)
+#endif
+
 #endif /* __LINUX_SPINLOCK_H */
Index: include/linux/ipipe_tickdev.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- include/linux/ipipe_tickdev.h	(revision 0)
+++ include/linux/ipipe_tickdev.h	(revision 0)
@@ -0,0 +1,58 @@
+/* -*- linux-c -*-
+ * include/linux/ipipe_tickdev.h
+ *
+ * Copyright (C) 2007 Philippe Gerum.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation, Inc., 675 Mass Ave, Cambridge MA 02139,=

+ * USA; either version 2 of the License, or (at your option) any later
+ * version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307,=
 USA.
+ */
+
+#ifndef __LINUX_IPIPE_TICKDEV_H
+#define __LINUX_IPIPE_TICKDEV_H
+
+#if defined(CONFIG_IPIPE) && defined(CONFIG_GENERIC_CLOCKEVENTS)
+
+#include <linux/clockchips.h>
+
+struct tick_device;
+
+struct ipipe_tick_device {
+
+	void (*emul_set_mode)(enum clock_event_mode,
+			      struct clock_event_device *cdev);
+	int (*emul_set_tick)(unsigned long delta,
+			     struct clock_event_device *cdev);
+	void (*real_set_mode)(enum clock_event_mode mode,
+			      struct clock_event_device *cdev);
+	int (*real_set_tick)(unsigned long delta,
+			     struct clock_event_device *cdev);
+	struct tick_device *slave;
+	unsigned long real_max_delta_ns;
+	unsigned long real_mult;
+	int real_shift;
+};
+
+int ipipe_request_tickdev(const char *devname,
+			  void (*emumode)(enum clock_event_mode mode,
+					  struct clock_event_device *cdev),
+			  int (*emutick)(unsigned long evt,
+					 struct clock_event_device *cdev),
+			  int cpu, unsigned long *tmfreq);
+
+void ipipe_release_tickdev(int cpu);
+
+#endif /* CONFIG_IPIPE && CONFIG_GENERIC_CLOCKEVENTS */
+
+#endif /* !__LINUX_IPIPE_TICKDEV_H */
Index: include/linux/autoconf.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- include/linux/autoconf.h	(revision 0)
+++ include/linux/autoconf.h	(revision 0)
@@ -0,0 +1,126 @@
+/*
+ * Automatically generated C config: don't edit
+ * Linux kernel version: 2.6.24-arm1-np4
+ * Thu Mar 27 11:23:15 2008
+ */
+#define AUTOCONF_INCLUDED
+#define CONFIG_CPU_COPY_V4WB 1
+#define CONFIG_DEBUG_USER 1
+#define CONFIG_FLATMEM 1
+#define CONFIG_ENABLE_MUST_CHECK 1
+#define CONFIG_BROKEN_ON_SMP 1
+#define CONFIG_HAS_DMA 1
+#define CONFIG_SERIO_SERPORT 1
+#define CONFIG_MACB 1
+#define CONFIG_HAS_IOPORT 1
+#define CONFIG_CPU_ARM926T 1
+#define CONFIG_TINY_SHMEM 1
+#define CONFIG_PREEMPT 1
+#define CONFIG_ARCH "arm"
+#define CONFIG_GENERIC_IRQ_PROBE 1
+#define CONFIG_RTC_LIB 1
+#define CONFIG_DEFCONFIG_LIST "/lib/modules/$UNAME_RELEASE/.config"
+#define CONFIG_DETECT_SOFTLOCKUP 1
+#define CONFIG_ZBOOT_ROM_BSS 0x0
+#define CONFIG_SLAB 1
+#define CONFIG_FLATMEM_MANUAL 1
+#define CONFIG_FLAT_NODE_MEM_MAP 1
+#define CONFIG_EMBEDDED 1
+#define CONFIG_PROC_FS 1
+#define CONFIG_SCHED_DEBUG 1
+#define CONFIG_INET 1
+#define CONFIG_RT_MUTEXES 1
+#define CONFIG_SYSVIPC 1
+#define CONFIG_TCP_CONG_CUBIC 1
+#define CONFIG_ALIGNMENT_TRAP 1
+#define CONFIG_CC_OPTIMIZE_FOR_SIZE 1
+#define CONFIG_SYS_SUPPORTS_APM_EMULATION 1
+#define CONFIG_CPU_ABRT_EV5TJ 1
+#define CONFIG_OABI_COMPAT 1
+#define CONFIG_CPU_CP15 1
+#define CONFIG_BLK_DEV_INITRD 1
+#define CONFIG_CPU_CACHE_VIVT 1
+#define CONFIG_UNIX 1
+#define CONFIG_SERIAL_CORE 1
+#define CONFIG_UID16 1
+#define CONFIG_LOCK_KERNEL 1
+#define CONFIG_IP_FIB_HASH 1
+#define CONFIG_DEBUG_SHIRQ 1
+#define CONFIG_SLABINFO 1
+#define CONFIG_ARCH_NP4 1
+#define CONFIG_SPLIT_PTLOCK_CPUS 4096
+#define CONFIG_AEABI 1
+#define CONFIG_CPU_32v5 1
+#define CONFIG_CPU_CACHE_ROUND_ROBIN 1
+#define CONFIG_UNUSED_SYMBOLS 1
+#define CONFIG_SERIAL_NP4_CONSOLE 1
+#define CONFIG_PRINTK_TIME 1
+#define CONFIG_DEBUG_VM 1
+#define CONFIG_FORCED_INLINING 1
+#define CONFIG_GENERIC_HWEIGHT 1
+#define CONFIG_ZONE_DMA 1
+#define CONFIG_ENABLE_WARN_DEPRECATED 1
+#define CONFIG_IPIPE 1
+#define CONFIG_ZBOOT_ROM_TEXT 0x0
+#define CONFIG_STACKTRACE_SUPPORT 1
+#define CONFIG_SERIO 1
+#define CONFIG_INITRAMFS_ROOT_GID 0
+#define CONFIG_SMSC_PHY 1
+#define CONFIG_FAIR_USER_SCHED 1
+#define CONFIG_DEBUG_KERNEL 1
+#define CONFIG_HARDIRQS_SW_RESEND 1
+#define CONFIG_PLIST 1
+#define CONFIG_FUTEX 1
+#define CONFIG_CPU_CP15_MMU 1
+#define CONFIG_MACH_NP4PLUS 1
+#define CONFIG_EXPERIMENTAL 1
+#define CONFIG_INPUT 1
+#define CONFIG_VIRT_TO_BUS 1
+#define CONFIG_INITRAMFS_ROOT_UID 0
+#define CONFIG_LOCALVERSION ""
+#define CONFIG_INIT_ENV_ARG_LIMIT 32
+#define CONFIG_IPIPE_COMPAT 1
+#define CONFIG_LOCKDEP_SUPPORT 1
+#define CONFIG_VECTORS_BASE 0xffff0000
+#define CONFIG_HZ 1000
+#define CONFIG_NET_ETHERNET 1
+#define CONFIG_SSB_POSSIBLE 1
+#define CONFIG_CPU_32 1
+#define CONFIG_RWSEM_GENERIC_SPINLOCK 1
+#define CONFIG_IP_MULTICAST 1
+#define CONFIG_PREVENT_FIRMWARE_BUILD 1
+#define CONFIG_GENERIC_CALIBRATE_DELAY 1
+#define CONFIG_HAS_IOMEM 1
+#define CONFIG_PACKET 1
+#define CONFIG_SERIAL_CORE_CONSOLE 1
+#define CONFIG_GENERIC_HARDIRQS 1
+#define CONFIG_TRACE_IRQFLAGS_SUPPORT 1
+#define CONFIG_PHYLIB 1
+#define CONFIG_SELECT_MEMORY_MODEL 1
+#define CONFIG_DEFAULT_TCP_CONG "cubic"
+#define CONFIG_NP4_HZ 1000
+#define CONFIG_FAIR_GROUP_SCHED 1
+#define CONFIG_UNAME_RELEASE "2.6.22-14-generic"
+#define CONFIG_PRINTK 1
+#define CONFIG_INITRAMFS_SOURCE "initramfs.txt"
+#define CONFIG_CPU_PABRT_NOIFAR 1
+#define CONFIG_BUG 1
+#define CONFIG_MII 1
+#define CONFIG_ARM 1
+#define CONFIG_IPIPE_DOMAINS 4
+#define CONFIG_DEBUG_PREEMPT 1
+#define CONFIG_SUSPEND_UP_POSSIBLE 1
+#define CONFIG_ZONE_DMA_FLAG 1
+#define CONFIG_NET 1
+#define CONFIG_KERNELVERSION "2.6.24-arm1-np4"
+#define CONFIG_STANDALONE 1
+#define CONFIG_NETDEVICES 1
+#define CONFIG_FRAME_POINTER 1
+#define CONFIG_MMU 1
+#define CONFIG_SERIAL_NP4 1
+#define CONFIG_DEBUG_INFO 1
+#define CONFIG_BASE_SMALL 1
+#define CONFIG_CPU_TLB_V4WBI 1
+#define CONFIG_BINFMT_ELF 1
+#define CONFIG_LOG_BUF_SHIFT 17
+#define CONFIG_CMDLINE ""
Index: include/linux/ipipe_percpu.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- include/linux/ipipe_percpu.h	(revision 0)
+++ include/linux/ipipe_percpu.h	(revision 0)
@@ -0,0 +1,69 @@
+/*   -*- linux-c -*-
+ *   include/linux/ipipe_percpu.h
+ *
+ *   Copyright (C) 2007 Philippe Gerum.
+ *
+ *   This program is free software; you can redistribute it and/or modif=
y
+ *   it under the terms of the GNU General Public License as published b=
y
+ *   the Free Software Foundation, Inc., 675 Mass Ave, Cambridge MA 0213=
9,
+ *   USA; either version 2 of the License, or (at your option) any later=

+ *   version.
+ *
+ *   This program is distributed in the hope that it will be useful,
+ *   but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *   GNU General Public License for more details.
+ *
+ *   You should have received a copy of the GNU General Public License
+ *   along with this program; if not, write to the Free Software
+ *   Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-130=
7, USA.
+ */
+
+#ifndef __LINUX_IPIPE_PERCPU_H
+#define __LINUX_IPIPE_PERCPU_H
+
+#include <asm/percpu.h>
+#include <asm/ptrace.h>
+
+struct ipipe_domain;
+
+struct ipipe_percpu_domain_data {
+	unsigned long status;	/* <=3D Must be first in struct. */
+	unsigned long irqpend_himask;
+	unsigned long irqpend_lomask[IPIPE_IRQ_IWORDS];
+	unsigned long irqheld_mask[IPIPE_IRQ_IWORDS];
+	unsigned long irqall[IPIPE_NR_IRQS];
+	u64 evsync;
+};
+
+#ifdef CONFIG_SMP
+#define ipipe_percpudom(ipd, var, cpu)	\
+	(per_cpu(ipipe_percpu_darray, cpu)[(ipd)->slot].var)
+#define ipipe_cpudom_var(ipd, var)	\
+	(__raw_get_cpu_var(ipipe_percpu_darray)[(ipd)->slot].var)
+#else
+DECLARE_PER_CPU(struct ipipe_percpu_domain_data *, ipipe_percpu_daddr[CO=
NFIG_IPIPE_DOMAINS]);
+#define ipipe_percpudom(ipd, var, cpu)	\
+	(per_cpu(ipipe_percpu_daddr, cpu)[(ipd)->slot]->var)
+#define ipipe_cpudom_var(ipd, var)	\
+	(__raw_get_cpu_var(ipipe_percpu_daddr)[(ipd)->slot]->var)
+#endif
+
+DECLARE_PER_CPU(struct ipipe_percpu_domain_data, ipipe_percpu_darray[CON=
FIG_IPIPE_DOMAINS]);
+
+DECLARE_PER_CPU(struct ipipe_domain *, ipipe_percpu_domain);
+
+#ifdef CONFIG_IPIPE_DEBUG_CONTEXT
+DECLARE_PER_CPU(int, ipipe_percpu_context_check);
+#endif
+
+#define ipipe_percpu(var, cpu)		per_cpu(var, cpu)
+#define ipipe_cpu_var(var)		__raw_get_cpu_var(var)
+
+#define ipipe_root_cpudom_var(var)	\
+	__raw_get_cpu_var(ipipe_percpu_darray)[0].var
+
+#define ipipe_this_cpudom_var(var)	\
+	ipipe_cpudom_var(ipipe_current_domain, var)
+
+#endif	/* !__LINUX_IPIPE_PERCPU_H */
Index: include/linux/ipipe_trace.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- include/linux/ipipe_trace.h	(revision 0)
+++ include/linux/ipipe_trace.h	(revision 0)
@@ -0,0 +1,70 @@
+/* -*- linux-c -*-
+ * include/linux/ipipe_trace.h
+ *
+ * Copyright (C) 2005 Luotao Fu.
+ *               2005-2007 Jan Kiszka.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation, Inc., 675 Mass Ave, Cambridge MA 02139,=

+ * USA; either version 2 of the License, or (at your option) any later
+ * version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307,=
 USA.
+ */
+
+#ifndef _LINUX_IPIPE_TRACE_H
+#define _LINUX_IPIPE_TRACE_H
+
+#ifdef CONFIG_IPIPE_TRACE
+
+#include <linux/types.h>
+
+void ipipe_trace_begin(unsigned long v);
+void ipipe_trace_end(unsigned long v);
+void ipipe_trace_freeze(unsigned long v);
+void ipipe_trace_special(unsigned char special_id, unsigned long v);
+void ipipe_trace_pid(pid_t pid, short prio);
+int ipipe_trace_max_reset(void);
+int ipipe_trace_frozen_reset(void);
+
+#else /* !CONFIG_IPIPE_TRACE */
+
+#define ipipe_trace_begin(v)		do { (void)(v); } while(0)
+#define ipipe_trace_end(v)		do { (void)(v); } while(0)
+#define ipipe_trace_freeze(v)		do { (void)(v); } while(0)
+#define ipipe_trace_special(id, v)	do { (void)(id); (void)(v); } while(0=
)
+#define ipipe_trace_pid(pid, prio)	do { (void)(pid); (void)(prio); } whi=
le(0)
+#define ipipe_trace_max_reset()		do { } while(0)
+#define ipipe_trace_froze_reset()	do { } while(0)
+
+#endif /* !CONFIG_IPIPE_TRACE */
+
+#ifdef CONFIG_IPIPE_TRACE_PANIC
+void ipipe_trace_panic_freeze(void);
+void ipipe_trace_panic_dump(void);
+#else
+static inline void ipipe_trace_panic_freeze(void) { }
+static inline void ipipe_trace_panic_dump(void) { }
+#endif
+
+#ifdef CONFIG_IPIPE_TRACE_IRQSOFF
+#define ipipe_trace_irq_entry(irq)	ipipe_trace_begin(irq)
+#define ipipe_trace_irq_exit(irq)	ipipe_trace_end(irq)
+#define ipipe_trace_irqsoff()		ipipe_trace_begin(0x80000000UL)
+#define ipipe_trace_irqson()		ipipe_trace_end(0x80000000UL)
+#else
+#define ipipe_trace_irq_entry(irq)	do { (void)(irq);} while(0)
+#define ipipe_trace_irq_exit(irq)	do { (void)(irq);} while(0)
+#define ipipe_trace_irqsoff()		do { } while(0)
+#define ipipe_trace_irqson()		do { } while(0)
+#endif
+
+#endif	/* !__LINUX_IPIPE_TRACE_H */
Index: include/linux/ipipe.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- include/linux/ipipe.h	(revision 0)
+++ include/linux/ipipe.h	(revision 0)
@@ -0,0 +1,585 @@
+/* -*- linux-c -*-
+ * include/linux/ipipe.h
+ *
+ * Copyright (C) 2002-2007 Philippe Gerum.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation, Inc., 675 Mass Ave, Cambridge MA 02139,=

+ * USA; either version 2 of the License, or (at your option) any later
+ * version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307,=
 USA.
+ */
+
+#ifndef __LINUX_IPIPE_H
+#define __LINUX_IPIPE_H
+
+#include <linux/spinlock.h>
+#include <linux/cache.h>
+#include <linux/percpu.h>
+#include <linux/mutex.h>
+#include <linux/linkage.h>
+#include <linux/ipipe_base.h>
+#include <linux/ipipe_compat.h>
+#include <asm/ipipe.h>
+
+#ifdef CONFIG_IPIPE
+
+/*
+ * Sanity check: IPIPE_VIRQ_BASE depends on CONFIG_NR_CPUS, and if the
+ * latter gets too large, we fail to map the virtual interrupts.
+ */
+#if IPIPE_VIRQ_BASE / BITS_PER_LONG > BITS_PER_LONG
+#error "CONFIG_NR_CPUS is too large, please lower it."
+#endif
+
+#define IPIPE_VERSION_STRING	IPIPE_ARCH_STRING
+#define IPIPE_RELEASE_NUMBER	((IPIPE_MAJOR_NUMBER << 16) | \
+				 (IPIPE_MINOR_NUMBER <<  8) | \
+				 (IPIPE_PATCH_NUMBER))
+
+#ifndef BROKEN_BUILTIN_RETURN_ADDRESS
+#define __BUILTIN_RETURN_ADDRESS0 ((unsigned long)__builtin_return_addre=
ss(0))
+#define __BUILTIN_RETURN_ADDRESS1 ((unsigned long)__builtin_return_addre=
ss(1))
+#endif /* !BUILTIN_RETURN_ADDRESS */
+
+#define IPIPE_ROOT_PRIO		100
+#define IPIPE_ROOT_ID		0
+#define IPIPE_ROOT_NPTDKEYS	4	/* Must be <=3D BITS_PER_LONG */
+
+#define IPIPE_RESET_TIMER	0x1
+#define IPIPE_GRAB_TIMER	0x2
+
+/* Global domain flags */
+#define IPIPE_SPRINTK_FLAG	0	/* Synchronous printk() allowed */
+#define IPIPE_AHEAD_FLAG	1	/* Domain always heads the pipeline */
+
+/* Interrupt control bits */
+#define IPIPE_HANDLE_FLAG	0
+#define IPIPE_PASS_FLAG		1
+#define IPIPE_ENABLE_FLAG	2
+#define IPIPE_DYNAMIC_FLAG	IPIPE_HANDLE_FLAG
+#define IPIPE_STICKY_FLAG	3
+#define IPIPE_SYSTEM_FLAG	4
+#define IPIPE_LOCK_FLAG		5
+#define IPIPE_WIRED_FLAG	6
+#define IPIPE_EXCLUSIVE_FLAG	7
+
+#define IPIPE_HANDLE_MASK	(1 << IPIPE_HANDLE_FLAG)
+#define IPIPE_PASS_MASK		(1 << IPIPE_PASS_FLAG)
+#define IPIPE_ENABLE_MASK	(1 << IPIPE_ENABLE_FLAG)
+#define IPIPE_DYNAMIC_MASK	IPIPE_HANDLE_MASK
+#define IPIPE_STICKY_MASK	(1 << IPIPE_STICKY_FLAG)
+#define IPIPE_SYSTEM_MASK	(1 << IPIPE_SYSTEM_FLAG)
+#define IPIPE_LOCK_MASK		(1 << IPIPE_LOCK_FLAG)
+#define IPIPE_WIRED_MASK	(1 << IPIPE_WIRED_FLAG)
+#define IPIPE_EXCLUSIVE_MASK	(1 << IPIPE_EXCLUSIVE_FLAG)
+
+#define IPIPE_DEFAULT_MASK	(IPIPE_HANDLE_MASK|IPIPE_PASS_MASK)
+#define IPIPE_STDROOT_MASK	(IPIPE_HANDLE_MASK|IPIPE_PASS_MASK|IPIPE_SYST=
EM_MASK)
+
+#define IPIPE_EVENT_SELF        0x80000000
+
+#define IPIPE_NR_CPUS		NR_CPUS
+
+#define ipipe_current_domain	ipipe_cpu_var(ipipe_percpu_domain)
+
+#define ipipe_virtual_irq_p(irq)	((irq) >=3D IPIPE_VIRQ_BASE && \
+					 (irq) < IPIPE_NR_IRQS)
+
+#define IPIPE_SAME_HANDLER	((ipipe_irq_handler_t)(-1))
+
+typedef int (*ipipe_irq_ackfn_t)(unsigned irq);
+
+typedef int (*ipipe_event_handler_t)(unsigned event,
+				     struct ipipe_domain *from,
+				     void *data);
+struct ipipe_domain {
+
+	int slot;			/* Slot number in percpu domain data array. */
+	struct list_head p_link;	/* Link in pipeline */
+	ipipe_event_handler_t evhand[IPIPE_NR_EVENTS]; /* Event handlers. */
+	unsigned long long evself;	/* Self-monitored event bits. */
+
+	struct {
+		unsigned long control;
+		ipipe_irq_ackfn_t acknowledge;
+		ipipe_irq_handler_t handler;
+		void *cookie;
+	} ____cacheline_aligned irqs[IPIPE_NR_IRQS];
+
+	int priority;
+	void *pdd;
+	unsigned long flags;
+	unsigned domid;
+	const char *name;
+	struct mutex mutex;
+};
+
+#define IPIPE_HEAD_PRIORITY	(-1) /* For domains always heading the pipel=
ine */
+
+struct ipipe_domain_attr {
+
+	unsigned domid;		/* Domain identifier -- Magic value set by caller */
+	const char *name;	/* Domain name -- Warning: won't be dup'ed! */
+	int priority;		/* Priority in interrupt pipeline */
+	void (*entry) (void);	/* Domain entry point */
+	void *pdd;		/* Per-domain (opaque) data pointer */
+};
+
+#ifdef CONFIG_SMP
+/* These ops must start and complete on the same CPU: care for
+ * migration. */
+#define set_bit_safe(b, a)						\
+		({ unsigned long __flags;				\
+		local_irq_save_hw_notrace(__flags);			\
+		__set_bit(b, a);					\
+		local_irq_restore_hw_notrace(__flags); })
+#define test_and_set_bit_safe(b, a)					\
+		({ unsigned long __flags, __x;				\
+		local_irq_save_hw_notrace(__flags);			\
+		__x =3D __test_and_set_bit(b, a);				\
+		local_irq_restore_hw_notrace(__flags); __x; })
+#define clear_bit_safe(b, a)						\
+		({ unsigned long __flags;				\
+		local_irq_save_hw_notrace(__flags);			\
+		__clear_bit(b, a);					\
+		local_irq_restore_hw_notrace(__flags); })
+#else
+#define set_bit_safe(b, a)		set_bit(b, a)
+#define test_and_set_bit_safe(b, a)	test_and_set_bit(b, a)
+#define clear_bit_safe(b, a)		clear_bit(b, a)
+#endif
+
+#define __ipipe_irq_cookie(ipd, irq)		(ipd)->irqs[irq].cookie
+#define __ipipe_irq_handler(ipd, irq)		(ipd)->irqs[irq].handler
+#define __ipipe_cpudata_irq_hits(ipd, cpu, irq)	ipipe_percpudom(ipd, irq=
all, cpu)[irq]
+
+extern unsigned __ipipe_printk_virq;
+
+extern unsigned long __ipipe_virtual_irq_map;
+
+extern struct list_head __ipipe_pipeline;
+
+extern int __ipipe_event_monitors[];
+
+/* Private interface */
+
+void ipipe_init(void);
+
+#ifdef CONFIG_PROC_FS
+void ipipe_init_proc(void);
+
+#ifdef CONFIG_IPIPE_TRACE
+void __ipipe_init_tracer(void);
+#else /* !CONFIG_IPIPE_TRACE */
+#define __ipipe_init_tracer()       do { } while(0)
+#endif /* CONFIG_IPIPE_TRACE */
+
+#else	/* !CONFIG_PROC_FS */
+#define ipipe_init_proc()	do { } while(0)
+#endif	/* CONFIG_PROC_FS */
+
+void __ipipe_init_stage(struct ipipe_domain *ipd);
+
+void __ipipe_cleanup_domain(struct ipipe_domain *ipd);
+
+void __ipipe_add_domain_proc(struct ipipe_domain *ipd);
+
+void __ipipe_remove_domain_proc(struct ipipe_domain *ipd);
+
+void __ipipe_flush_printk(unsigned irq, void *cookie);
+
+void fastcall __ipipe_walk_pipeline(struct list_head *pos);
+
+int fastcall __ipipe_schedule_irq(unsigned irq, struct list_head *head);=

+
+int fastcall __ipipe_dispatch_event(unsigned event, void *data);
+
+int fastcall __ipipe_dispatch_wired(struct ipipe_domain *head_domain, un=
signed irq);
+
+void fastcall __ipipe_sync_stage(unsigned long syncmask);
+
+void fastcall __ipipe_set_irq_pending(struct ipipe_domain *ipd, unsigned=
 irq);
+
+void fastcall __ipipe_lock_irq(struct ipipe_domain *ipd, int cpu, unsign=
ed irq);
+
+void fastcall __ipipe_unlock_irq(struct ipipe_domain *ipd, unsigned irq)=
;
+
+void __ipipe_pin_range_globally(unsigned long start, unsigned long end);=

+
+/* Must be called hw IRQs off. */
+static inline void ipipe_irq_lock(unsigned irq)
+{
+	__ipipe_lock_irq(ipipe_current_domain, ipipe_processor_id(), irq);
+}
+
+/* Must be called hw IRQs off. */
+static inline void ipipe_irq_unlock(unsigned irq)
+{
+	__ipipe_unlock_irq(ipipe_current_domain, irq);
+}
+
+#ifndef __ipipe_sync_pipeline
+#define __ipipe_sync_pipeline(syncmask) __ipipe_sync_stage(syncmask)
+#endif
+
+#ifndef __ipipe_run_irqtail
+#define __ipipe_run_irqtail() do { } while(0)
+#endif
+
+#define __ipipe_pipeline_head_p(ipd) (&(ipd)->p_link =3D=3D __ipipe_pipe=
line.next)
+
+/*
+ * Keep the following as a macro, so that client code could check for
+ * the support of the invariant pipeline head optimization.
+ */
+#define __ipipe_pipeline_head() list_entry(__ipipe_pipeline.next,struct =
ipipe_domain,p_link)
+
+#define __ipipe_event_monitored_p(ev) \
+	(__ipipe_event_monitors[ev] > 0 || (ipipe_current_domain->evself & (1LL=
 << ev)))
+
+#ifdef CONFIG_SMP
+
+cpumask_t __ipipe_set_irq_affinity(unsigned irq,
+				   cpumask_t cpumask);
+
+int fastcall __ipipe_send_ipi(unsigned ipi,
+			      cpumask_t cpumask);
+
+#endif /* CONFIG_SMP */
+
+#define ipipe_sigwake_notify(p)	\
+do {					\
+	if (((p)->flags & PF_EVNOTIFY) && __ipipe_event_monitored_p(IPIPE_EVENT=
_SIGWAKE)) \
+		__ipipe_dispatch_event(IPIPE_EVENT_SIGWAKE,p);		\
+} while(0)
+
+#define ipipe_exit_notify(p)	\
+do {				\
+	if (((p)->flags & PF_EVNOTIFY) && __ipipe_event_monitored_p(IPIPE_EVENT=
_EXIT)) \
+		__ipipe_dispatch_event(IPIPE_EVENT_EXIT,p);		\
+} while(0)
+
+#define ipipe_setsched_notify(p)	\
+do {					\
+	if (((p)->flags & PF_EVNOTIFY) && __ipipe_event_monitored_p(IPIPE_EVENT=
_SETSCHED)) \
+		__ipipe_dispatch_event(IPIPE_EVENT_SETSCHED,p);		\
+} while(0)
+
+#define ipipe_schedule_notify(prev, next)				\
+do {									\
+	if ((((prev)->flags|(next)->flags) & PF_EVNOTIFY) &&		\
+	    __ipipe_event_monitored_p(IPIPE_EVENT_SCHEDULE))		\
+		__ipipe_dispatch_event(IPIPE_EVENT_SCHEDULE,next);	\
+} while(0)
+
+#define ipipe_trap_notify(ex, regs)		\
+({						\
+	int ret =3D 0;				\
+	if ((test_bit(IPIPE_NOSTACK_FLAG, &ipipe_this_cpudom_var(status)) || \
+	     ((current)->flags & PF_EVNOTIFY)) &&			\
+	    __ipipe_event_monitored_p(ex))				\
+		ret =3D __ipipe_dispatch_event(ex, regs);			\
+	ret;								\
+})
+
+static inline void ipipe_init_notify(struct task_struct *p)
+{
+	if (__ipipe_event_monitored_p(IPIPE_EVENT_INIT))
+		__ipipe_dispatch_event(IPIPE_EVENT_INIT,p);
+}
+
+struct mm_struct;
+
+static inline void ipipe_cleanup_notify(struct mm_struct *mm)
+{
+	if (__ipipe_event_monitored_p(IPIPE_EVENT_CLEANUP))
+		__ipipe_dispatch_event(IPIPE_EVENT_CLEANUP,mm);
+}
+
+/* Public interface */
+
+int ipipe_register_domain(struct ipipe_domain *ipd,
+			  struct ipipe_domain_attr *attr);
+
+int ipipe_unregister_domain(struct ipipe_domain *ipd);
+
+void ipipe_suspend_domain(void);
+
+int ipipe_virtualize_irq(struct ipipe_domain *ipd,
+			 unsigned irq,
+			 ipipe_irq_handler_t handler,
+			 void *cookie,
+			 ipipe_irq_ackfn_t acknowledge,
+			 unsigned modemask);
+
+int ipipe_control_irq(unsigned irq,
+		      unsigned clrmask,
+		      unsigned setmask);
+
+unsigned ipipe_alloc_virq(void);
+
+int ipipe_free_virq(unsigned virq);
+
+int fastcall ipipe_trigger_irq(unsigned irq);
+
+static inline int ipipe_propagate_irq(unsigned irq)
+{
+	return __ipipe_schedule_irq(irq, ipipe_current_domain->p_link.next);
+}
+
+static inline int ipipe_schedule_irq(unsigned irq)
+{
+	return __ipipe_schedule_irq(irq, &ipipe_current_domain->p_link);
+}
+
+void fastcall ipipe_stall_pipeline_from(struct ipipe_domain *ipd);
+
+unsigned long fastcall ipipe_test_and_stall_pipeline_from(struct ipipe_d=
omain *ipd);
+
+void fastcall ipipe_unstall_pipeline_from(struct ipipe_domain *ipd);
+
+unsigned long fastcall ipipe_test_and_unstall_pipeline_from(struct ipipe=
_domain *ipd);
+
+void fastcall ipipe_restore_pipeline_from(struct ipipe_domain *ipd,
+					  unsigned long x);
+
+static inline unsigned long ipipe_test_pipeline_from(struct ipipe_domain=
 *ipd)
+{
+	return test_bit(IPIPE_STALL_FLAG, &ipipe_cpudom_var(ipd, status));
+}
+
+static inline void ipipe_stall_pipeline_head(void)
+{
+	local_irq_disable_hw();
+	__set_bit(IPIPE_STALL_FLAG, &ipipe_cpudom_var(__ipipe_pipeline_head(), =
status));
+}
+
+static inline unsigned long ipipe_test_and_stall_pipeline_head(void)
+{
+	local_irq_disable_hw();
+	return __test_and_set_bit(IPIPE_STALL_FLAG, &ipipe_cpudom_var(__ipipe_p=
ipeline_head(), status));
+}
+
+void ipipe_unstall_pipeline_head(void);
+
+void fastcall __ipipe_restore_pipeline_head(struct ipipe_domain *head_do=
main,
+					    unsigned long x);
+
+static inline void ipipe_restore_pipeline_head(unsigned long x)
+{
+	struct ipipe_domain *head_domain =3D __ipipe_pipeline_head();
+	/* On some archs, __test_and_set_bit() might return different
+	 * truth value than test_bit(), so we test the exclusive OR of
+	 * both statuses, assuming that the lowest bit is always set in
+	 * the truth value (if this is wrong, the failed optimization will
+	 * be caught in __ipipe_restore_pipeline_head() if
+	 * CONFIG_DEBUG_KERNEL is set). */
+	if ((x ^ test_bit(IPIPE_STALL_FLAG, &ipipe_cpudom_var(head_domain, stat=
us))) & 1)
+		__ipipe_restore_pipeline_head(head_domain, x);
+}
+
+#define ipipe_unstall_pipeline() \
+	ipipe_unstall_pipeline_from(ipipe_current_domain)
+
+#define ipipe_test_and_unstall_pipeline() \
+	ipipe_test_and_unstall_pipeline_from(ipipe_current_domain)
+
+#define ipipe_test_pipeline() \
+	ipipe_test_pipeline_from(ipipe_current_domain)
+
+#define ipipe_test_and_stall_pipeline() \
+	ipipe_test_and_stall_pipeline_from(ipipe_current_domain)
+
+#define ipipe_stall_pipeline() \
+	ipipe_stall_pipeline_from(ipipe_current_domain)
+
+#define ipipe_restore_pipeline(x) \
+	ipipe_restore_pipeline_from(ipipe_current_domain, (x))
+
+void ipipe_init_attr(struct ipipe_domain_attr *attr);
+
+int ipipe_get_sysinfo(struct ipipe_sysinfo *sysinfo);
+
+unsigned long ipipe_critical_enter(void (*syncfn) (void));
+
+void ipipe_critical_exit(unsigned long flags);
+
+static inline void ipipe_set_printk_sync(struct ipipe_domain *ipd)
+{
+	set_bit(IPIPE_SPRINTK_FLAG, &ipd->flags);
+}
+
+static inline void ipipe_set_printk_async(struct ipipe_domain *ipd)
+{
+	clear_bit(IPIPE_SPRINTK_FLAG, &ipd->flags);
+}
+
+static inline void ipipe_set_foreign_stack(struct ipipe_domain *ipd)
+{
+	/* Must be called hw interrupts off. */
+	__set_bit(IPIPE_NOSTACK_FLAG, &ipipe_cpudom_var(ipd, status));
+}
+
+static inline void ipipe_clear_foreign_stack(struct ipipe_domain *ipd)
+{
+	/* Must be called hw interrupts off. */
+	__clear_bit(IPIPE_NOSTACK_FLAG, &ipipe_cpudom_var(ipd, status));
+}
+
+#ifndef ipipe_safe_current
+#define ipipe_safe_current()					\
+({								\
+	struct task_struct *p;					\
+	p =3D test_bit(IPIPE_NOSTACK_FLAG,			\
+		     &ipipe_this_cpudom_var(status)) ? &init_task : current; \
+	p; \
+})
+#endif
+
+ipipe_event_handler_t ipipe_catch_event(struct ipipe_domain *ipd,
+					unsigned event,
+					ipipe_event_handler_t handler);
+
+cpumask_t ipipe_set_irq_affinity(unsigned irq,
+				 cpumask_t cpumask);
+
+int fastcall ipipe_send_ipi(unsigned ipi,
+			    cpumask_t cpumask);
+
+int ipipe_setscheduler_root(struct task_struct *p,
+			    int policy,
+			    int prio);
+
+int ipipe_reenter_root(struct task_struct *prev,
+		       int policy,
+		       int prio);
+
+int ipipe_alloc_ptdkey(void);
+
+int ipipe_free_ptdkey(int key);
+
+int fastcall ipipe_set_ptd(int key,
+			   void *value);
+
+void fastcall *ipipe_get_ptd(int key);
+
+int ipipe_disable_ondemand_mappings(struct task_struct *tsk);
+
+#define local_irq_enable_hw_cond()		local_irq_enable_hw()
+#define local_irq_disable_hw_cond()		local_irq_disable_hw()
+#define local_irq_save_hw_cond(flags)		local_irq_save_hw(flags)
+#define local_irq_restore_hw_cond(flags)	local_irq_restore_hw(flags)
+#define local_irq_disable_head()		ipipe_stall_pipeline_head()
+
+#define local_irq_enable_nohead(ipd)			\
+	do {						\
+		if (!__ipipe_pipeline_head_p(ipd))	\
+			local_irq_enable_hw();		\
+	} while(0)
+
+#define local_irq_disable_nohead(ipd)		\
+	do {						\
+		if (!__ipipe_pipeline_head_p(ipd))	\
+			local_irq_disable_hw();		\
+	} while(0)
+
+#define local_irq_save_full(vflags, rflags)		\
+	do {						\
+		local_irq_save(vflags);			\
+		local_irq_save_hw(rflags);		\
+	} while(0)
+
+#define local_irq_restore_full(vflags, rflags)		\
+	do {						\
+		local_irq_restore_hw(rflags);		\
+		local_irq_restore(vflags);		\
+	} while(0)
+
+static inline void local_irq_restore_nosync(unsigned long x)
+{
+	if (x)
+		set_bit(IPIPE_STALL_FLAG, &ipipe_cpudom_var(ipipe_root_domain, status)=
);
+	else
+		clear_bit(IPIPE_STALL_FLAG, &ipipe_cpudom_var(ipipe_root_domain, statu=
s));
+}
+
+#define ipipe_root_domain_p		(ipipe_current_domain =3D=3D ipipe_root_dom=
ain)
+
+#else	/* !CONFIG_IPIPE */
+
+#define ipipe_init()			do { } while(0)
+#define ipipe_suspend_domain()		do { } while(0)
+#define ipipe_sigwake_notify(p)		do { } while(0)
+#define ipipe_setsched_notify(p)	do { } while(0)
+#define ipipe_init_notify(p)		do { } while(0)
+#define ipipe_exit_notify(p)		do { } while(0)
+#define ipipe_cleanup_notify(mm)	do { } while(0)
+#define ipipe_trap_notify(t,r)		0
+#define ipipe_init_proc()		do { } while(0)
+#define __ipipe_pin_range_globally(start, end)	do { } while(0)
+
+#define local_irq_enable_hw_cond()		do { } while(0)
+#define local_irq_disable_hw_cond()		do { } while(0)
+#define local_irq_save_hw_cond(flags)		do { (void)(flags); } while(0)
+#define local_irq_restore_hw_cond(flags)	do { } while(0)
+
+#define ipipe_irq_lock(irq)		do { } while(0)
+#define ipipe_irq_unlock(irq)		do { } while(0)
+
+#define ipipe_root_domain_p		1
+#define ipipe_safe_current		current
+
+#define local_irq_disable_head()	local_irq_disable()
+
+#define local_irq_save_full(vflags, rflags)	do { (void)(vflags); local_i=
rq_save(rflags); } while(0)
+#define local_irq_restore_full(vflags, rflags)	do { (void)(vflags); loca=
l_irq_restore(rflags); } while(0)
+#define local_irq_restore_nosync(vflags)	local_irq_restore(vflags)
+
+#endif	/* CONFIG_IPIPE */
+
+#ifdef CONFIG_IPIPE_DEBUG_CONTEXT
+
+#include <linux/cpumask.h>
+#include <asm/system.h>
+
+static inline int ipipe_disable_context_check(int cpu)
+{
+	return xchg(&per_cpu(ipipe_percpu_context_check, cpu), 0);
+}
+
+static inline void ipipe_restore_context_check(int cpu, int old_state)
+{
+	per_cpu(ipipe_percpu_context_check, cpu) =3D old_state;
+}
+
+static inline void ipipe_context_check_off(void)
+{
+	int cpu;
+	for_each_online_cpu(cpu)
+		per_cpu(ipipe_percpu_context_check, cpu) =3D 0;
+}
+
+#else	/* !CONFIG_IPIPE_DEBUG_CONTEXT */
+
+static inline int ipipe_disable_context_check(int cpu)
+{
+	return 0;
+}
+
+static inline void ipipe_restore_context_check(int cpu, int old_state) {=
 }
+
+static inline void ipipe_context_check_off(void) { }
+
+#endif	/* !CONFIG_IPIPE_DEBUG_CONTEXT */
+
+#endif	/* !__LINUX_IPIPE_H */
Index: include/linux/utsrelease.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- include/linux/utsrelease.h	(revision 0)
+++ include/linux/utsrelease.h	(revision 0)
@@ -0,0 +1 @@
+#define UTS_RELEASE "2.6.24-arm1-np4"
Index: include/linux/kernel.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- include/linux/kernel.h	(revision 91)
+++ include/linux/kernel.h	(working copy)
@@ -14,6 +14,7 @@
 #include <linux/compiler.h>
 #include <linux/bitops.h>
 #include <linux/log2.h>
+#include <linux/ipipe_base.h>
 #include <asm/byteorder.h>
 #include <asm/bug.h>
=20
@@ -106,9 +107,12 @@
  */
 #ifdef CONFIG_PREEMPT_VOLUNTARY
 extern int cond_resched(void);
-# define might_resched() cond_resched()
+# define might_resched() do { \
+		ipipe_check_context(ipipe_root_domain); \
+		cond_resched(); \
+	} while (0)
 #else
-# define might_resched() do { } while (0)
+# define might_resched() ipipe_check_context(ipipe_root_domain)
 #endif
=20
 #ifdef CONFIG_DEBUG_SPINLOCK_SLEEP
Index: include/linux/preempt.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- include/linux/preempt.h	(revision 91)
+++ include/linux/preempt.h	(working copy)
@@ -9,13 +9,20 @@
 #include <linux/thread_info.h>
 #include <linux/linkage.h>
 #include <linux/list.h>
+#include <linux/ipipe_base.h>
=20
 #ifdef CONFIG_DEBUG_PREEMPT
   extern void fastcall add_preempt_count(int val);
   extern void fastcall sub_preempt_count(int val);
 #else
-# define add_preempt_count(val)	do { preempt_count() +=3D (val); } while=
 (0)
-# define sub_preempt_count(val)	do { preempt_count() -=3D (val); } while=
 (0)
+# define add_preempt_count(val)	do { \
+	ipipe_check_context(ipipe_root_domain); \
+	preempt_count() +=3D (val); \
+  } while (0)
+# define sub_preempt_count(val)	do { \
+	ipipe_check_context(ipipe_root_domain); \
+	preempt_count() -=3D (val); \
+  } while (0)
 #endif
=20
 #define inc_preempt_count() add_preempt_count(1)
Index: include/linux/spinlock_types.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- include/linux/spinlock_types.h	(revision 91)
+++ include/linux/spinlock_types.h	(working copy)
@@ -31,6 +31,10 @@
 #endif
 } spinlock_t;
=20
+typedef struct {
+	raw_spinlock_t __raw_lock;
+} __ipipe_spinlock_t;
+
 #define SPINLOCK_MAGIC		0xdead4ead
=20
 typedef struct {
@@ -92,9 +96,21 @@
  * __SPIN_LOCK_UNLOCKED()/__RW_LOCK_UNLOCKED() as appropriate.
  */
 #define SPIN_LOCK_UNLOCKED	__SPIN_LOCK_UNLOCKED(old_style_spin_init)
+#define IPIPE_SPIN_LOCK_UNLOCKED					\
+	(__ipipe_spinlock_t) {	.__raw_lock =3D __RAW_SPIN_LOCK_UNLOCKED }
 #define RW_LOCK_UNLOCKED	__RW_LOCK_UNLOCKED(old_style_rw_init)
=20
 #define DEFINE_SPINLOCK(x)	spinlock_t x =3D __SPIN_LOCK_UNLOCKED(x)
 #define DEFINE_RWLOCK(x)	rwlock_t x =3D __RW_LOCK_UNLOCKED(x)
=20
+#ifdef CONFIG_IPIPE
+# define ipipe_spinlock_t		__ipipe_spinlock_t
+# define IPIPE_DEFINE_SPINLOCK(x)	ipipe_spinlock_t x =3D IPIPE_SPIN_LOCK=
_UNLOCKED
+# define IPIPE_DECLARE_SPINLOCK(x)	extern ipipe_spinlock_t x
+#else
+# define ipipe_spinlock_t		spinlock_t
+# define IPIPE_DEFINE_SPINLOCK(x)	DEFINE_SPINLOCK(x)
+# define IPIPE_DECLARE_SPINLOCK(x)	extern spinlock_t x
+#endif
+
 #endif /* __LINUX_SPINLOCK_TYPES_H */
Index: include/linux/hardirq.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- include/linux/hardirq.h	(revision 91)
+++ include/linux/hardirq.h	(working copy)
@@ -146,7 +146,7 @@
  */
 extern void irq_exit(void);
=20
-#define nmi_enter()		do { lockdep_off(); __irq_enter(); } while (0)
-#define nmi_exit()		do { __irq_exit(); lockdep_on(); } while (0)
+#define nmi_enter()		do { if (ipipe_root_domain_p) { lockdep_off(); __ir=
q_enter(); } } while (0)
+#define nmi_exit()		do { if (ipipe_root_domain_p) { __irq_exit(); lockde=
p_on(); } } while (0)
=20
 #endif /* LINUX_HARDIRQ_H */
Index: include/linux/ipipe_compat.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- include/linux/ipipe_compat.h	(revision 0)
+++ include/linux/ipipe_compat.h	(revision 0)
@@ -0,0 +1,54 @@
+/* -*- linux-c -*-
+ * include/linux/ipipe_compat.h
+ *
+ * Copyright (C) 2007 Philippe Gerum.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation, Inc., 675 Mass Ave, Cambridge MA 02139,=

+ * USA; either version 2 of the License, or (at your option) any later
+ * version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307,=
 USA.
+ */
+
+#ifndef __LINUX_IPIPE_COMPAT_H
+#define __LINUX_IPIPE_COMPAT_H
+
+#ifdef CONFIG_IPIPE_COMPAT
+/*
+ * OBSOLETE: defined only for backward compatibility. Will be removed
+ * in future releases, please update client code accordingly.
+ */
+
+#ifdef CONFIG_SMP
+#define ipipe_declare_cpuid	int cpuid
+#define ipipe_load_cpuid()	do { \
+					cpuid =3D ipipe_processor_id();	\
+				} while(0)
+#define ipipe_lock_cpu(flags)	do { \
+					local_irq_save_hw(flags); \
+					cpuid =3D ipipe_processor_id(); \
+				} while(0)
+#define ipipe_unlock_cpu(flags)	local_irq_restore_hw(flags)
+#define ipipe_get_cpu(flags)	ipipe_lock_cpu(flags)
+#define ipipe_put_cpu(flags)	ipipe_unlock_cpu(flags)
+#else /* !CONFIG_SMP */
+#define ipipe_declare_cpuid	const int cpuid =3D 0
+#define ipipe_load_cpuid()	do { } while(0)
+#define ipipe_lock_cpu(flags)	local_irq_save_hw(flags)
+#define ipipe_unlock_cpu(flags)	local_irq_restore_hw(flags)
+#define ipipe_get_cpu(flags)	do { (void)(flags); } while(0)
+#define ipipe_put_cpu(flags)	do { } while(0)
+#endif /* CONFIG_SMP */
+
+#endif /* CONFIG_IPIPE_COMPAT */
+
+#endif	/* !__LINUX_IPIPE_COMPAT_H */
Index: include/linux/ipipe_base.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- include/linux/ipipe_base.h	(revision 0)
+++ include/linux/ipipe_base.h	(revision 0)
@@ -0,0 +1,86 @@
+/* -*- linux-c -*-
+ * include/linux/ipipe_base.h
+ *
+ * Copyright (C) 2002-2007 Philippe Gerum.
+ *               2007 Jan Kiszka.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation, Inc., 675 Mass Ave, Cambridge MA 02139,=

+ * USA; either version 2 of the License, or (at your option) any later
+ * version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307,=
 USA.
+ */
+
+#ifndef __LINUX_IPIPE_BASE_H
+#define __LINUX_IPIPE_BASE_H
+
+#ifdef CONFIG_IPIPE
+
+#include <linux/bitops.h>
+#include <asm/ipipe_base.h>
+
+/* Number of virtual IRQs */
+#define IPIPE_NR_VIRQS		BITS_PER_LONG
+/* First virtual IRQ # */
+#define IPIPE_VIRQ_BASE		(((IPIPE_NR_XIRQS + BITS_PER_LONG - 1) / BITS_P=
ER_LONG) * BITS_PER_LONG)
+/* Total number of IRQ slots */
+#define IPIPE_NR_IRQS		(IPIPE_VIRQ_BASE + IPIPE_NR_VIRQS)
+/* Number of indirect words needed to map the whole IRQ space. */
+#define IPIPE_IRQ_IWORDS	((IPIPE_NR_IRQS + BITS_PER_LONG - 1) / BITS_PER=
_LONG)
+#define IPIPE_IRQ_IMASK		(BITS_PER_LONG - 1)
+#define IPIPE_IRQMASK_ANY	(~0L)
+#define IPIPE_IRQMASK_VIRT	(IPIPE_IRQMASK_ANY << (IPIPE_VIRQ_BASE / BITS=
_PER_LONG))
+
+/* Per-cpu pipeline status */
+#define IPIPE_STALL_FLAG	0	/* Stalls a pipeline stage -- guaranteed at b=
it #0 */
+#define IPIPE_SYNC_FLAG		1	/* The interrupt syncer is running for the do=
main */
+#define IPIPE_NOSTACK_FLAG	2	/* Domain currently runs on a foreign stack=
 */
+
+#define IPIPE_STALL_MASK	(1L << IPIPE_STALL_FLAG)
+#define IPIPE_SYNC_MASK		(1L << IPIPE_SYNC_FLAG)
+
+typedef void (*ipipe_irq_handler_t)(unsigned irq,
+				    void *cookie);
+
+extern struct ipipe_domain ipipe_root;
+
+#define ipipe_root_domain (&ipipe_root)
+
+void __ipipe_unstall_root(void);
+
+void __ipipe_restore_root(unsigned long x);
+
+#define ipipe_preempt_disable(flags)	local_irq_save_hw(flags)
+#define ipipe_preempt_enable(flags)	local_irq_restore_hw(flags)
+=20
+#ifdef CONFIG_IPIPE_DEBUG_CONTEXT
+void ipipe_check_context(struct ipipe_domain *border_ipd);
+#else /* !CONFIG_IPIPE_DEBUG_CONTEXT */
+static inline void ipipe_check_context(struct ipipe_domain *border_ipd) =
{ }
+#endif /* !CONFIG_IPIPE_DEBUG_CONTEXT */
+
+/* Generic features */
+
+#ifdef CONFIG_GENERIC_CLOCKEVENTS
+#define __IPIPE_FEATURE_REQUEST_TICKDEV  1
+#endif
+
+#else /* !CONFIG_IPIPE */
+#define ipipe_preempt_disable(flags)	do { \
+						preempt_disable(); \
+						(void)(flags); \
+					} while (0)
+#define ipipe_preempt_enable(flags)	preempt_enable()
+#define ipipe_check_context(ipd)	do { } while(0)
+#endif	/* CONFIG_IPIPE */
+
+#endif	/* !__LINUX_IPIPE_BASE_H */
Index: include/linux/version.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- include/linux/version.h	(revision 0)
+++ include/linux/version.h	(revision 0)
@@ -0,0 +1,2 @@
+#define LINUX_VERSION_CODE 132632
+#define KERNEL_VERSION(a,b,c) (((a) << 16) + ((b) << 8) + (c))
Index: include/linux/linkage.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- include/linux/linkage.h	(revision 91)
+++ include/linux/linkage.h	(working copy)
@@ -70,4 +70,8 @@
 #define fastcall
 #endif
=20
+#ifndef notrace
+#define notrace		__attribute__((no_instrument_function))
 #endif
+
+#endif
Index: include/linux/irq.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- include/linux/irq.h	(revision 91)
+++ include/linux/irq.h	(working copy)
@@ -150,6 +150,14 @@
  * @name:		flow handler name for /proc/interrupts output
  */
 struct irq_desc {
+#ifdef CONFIG_IPIPE
+	void			fastcall (*ipipe_ack)(unsigned int irq,
+						      struct irq_desc *desc);
+	void			fastcall (*ipipe_demux)(unsigned int irq,
+							struct irq_desc *desc);
+	void			fastcall (*ipipe_end)(unsigned int irq,
+						      struct irq_desc *desc);
+#endif /* CONFIG_IPIPE */
 	irq_flow_handler_t	handle_irq;
 	struct irq_chip		*chip;
 	struct msi_desc		*msi_desc;
@@ -367,6 +375,14 @@
 	__set_irq_handler(irq, handle, 1, NULL);
 }
=20
+#ifdef CONFIG_IPIPE
+extern void
+__set_irq_demux_handler(unsigned int irq,
+			void fastcall (*decode)(unsigned int, struct irq_desc *),
+			int is_chained,
+			const char *name);
+#endif /* CONFIG_IPIPE */
+
 /* Handle dynamic irq creation and destruction */
 extern int create_irq(void);
 extern void destroy_irq(unsigned int irq);
Index: include/linux/mm.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- include/linux/mm.h	(revision 91)
+++ include/linux/mm.h	(working copy)
@@ -104,6 +104,7 @@
 #define VM_MAPPED_COPY	0x01000000	/* T if mapped copy of data (nommu mma=
p) */
 #define VM_INSERTPAGE	0x02000000	/* The vma has had "vm_insert_page()" d=
one on it */
 #define VM_ALWAYSDUMP	0x04000000	/* Always include in core dumps */
+#define VM_PINNED	0x08000000	/* Disable faults for the vma */
=20
 #define VM_CAN_NONLINEAR 0x08000000	/* Has ->fault & does nonlinear page=
s */
=20
Index: include/linux/sched.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- include/linux/sched.h	(revision 91)
+++ include/linux/sched.h	(working copy)
@@ -58,6 +58,7 @@
 #include <linux/errno.h>
 #include <linux/nodemask.h>
 #include <linux/mm_types.h>
+#include <linux/ipipe.h>
=20
 #include <asm/system.h>
 #include <asm/semaphore.h>
@@ -177,6 +178,13 @@
 #define EXIT_DEAD		32
 /* in tsk->state again */
 #define TASK_DEAD		64
+#ifdef CONFIG_IPIPE
+#define TASK_ATOMICSWITCH	512
+#define TASK_NOWAKEUP		1024
+#else  /* !CONFIG_IPIPE */
+#define TASK_ATOMICSWITCH	0
+#define TASK_NOWAKEUP		0
+#endif /* CONFIG_IPIPE */
=20
 #define __set_task_state(tsk, state_value)		\
 	do { (tsk)->state =3D (state_value); } while (0)
@@ -1166,6 +1174,9 @@
 #endif
 	atomic_t fs_excl;	/* holding fs exclusive resources */
 	struct rcu_head rcu;
+#ifdef CONFIG_IPIPE
+	void *ptd[IPIPE_ROOT_NPTDKEYS];
+#endif
=20
 	/*
 	 * cache last used pipe for splice
@@ -1383,6 +1394,11 @@
 #define PF_MEMPOLICY	0x10000000	/* Non-default NUMA mempolicy */
 #define PF_MUTEX_TESTER	0x20000000	/* Thread belongs to the rt mutex tes=
ter */
 #define PF_FREEZER_SKIP	0x40000000	/* Freezer should not count it as fre=
ezeable */
+#ifdef CONFIG_IPIPE
+#define PF_EVNOTIFY	0x80000000	/* Notify other domains about internal ev=
ents */
+#else
+#define PF_EVNOTIFY	0
+#endif /* CONFIG_IPIPE */
=20
 /*
  * Only the _current_ task can read/write to tsk->flags, but other
Index: init/Kconfig
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- init/Kconfig	(revision 91)
+++ init/Kconfig	(working copy)
@@ -64,6 +64,7 @@
=20
 config LOCALVERSION
 	string "Local version - append to kernel release"
+	default "-ipipe"
 	help
 	  Append an extra string to the end of your kernel version.
 	  This will show up when you type uname, for example.
Index: init/main.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- init/main.c	(revision 91)
+++ init/main.c	(working copy)
@@ -519,7 +519,7 @@
 	lockdep_init();
 	cgroup_init_early();
=20
-	local_irq_disable();
+	local_irq_disable_hw();
 	early_boot_irqs_off();
 	early_init_irq_lock_class();
=20
@@ -572,6 +572,11 @@
 	softirq_init();
 	timekeeping_init();
 	time_init();
+	/*
+	 * We need to wait for the interrupt and time subsystems to be
+	 * initialized before enabling the pipeline.
+	 */
+ 	ipipe_init();
 	profile_init();
 	if (!irqs_disabled())
 		printk("start_kernel(): bug: interrupts were enabled early\n");
@@ -733,6 +738,7 @@
 	usermodehelper_init();
 	driver_init();
 	init_irq_proc();
+ 	ipipe_init_proc();
 	do_initcalls();
 }
=20
Index: lib/bust_spinlocks.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- lib/bust_spinlocks.c	(revision 91)
+++ lib/bust_spinlocks.c	(working copy)
@@ -12,16 +12,19 @@
 #include <linux/tty.h>
 #include <linux/wait.h>
 #include <linux/vt_kern.h>
+#include <linux/ipipe_trace.h>
=20
=20
 void __attribute__((weak)) bust_spinlocks(int yes)
 {
 	if (yes) {
+  		ipipe_trace_panic_freeze();
 		++oops_in_progress;
 	} else {
 #ifdef CONFIG_VT
 		unblank_screen();
 #endif
+ 		ipipe_trace_panic_dump();
 		if (--oops_in_progress =3D=3D 0)
 			wake_up_klogd();
 	}
Index: lib/smp_processor_id.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- lib/smp_processor_id.c	(revision 91)
+++ lib/smp_processor_id.c	(working copy)
@@ -13,10 +13,13 @@
 	int this_cpu =3D raw_smp_processor_id();
 	cpumask_t this_mask;
=20
+	if (!ipipe_root_domain_p)
+		goto out;
+
 	if (likely(preempt_count))
 		goto out;
=20
-	if (irqs_disabled())
+	if (irqs_disabled() || irqs_disabled_hw())
 		goto out;
=20
 	/*
Index: lib/spinlock_debug.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- lib/spinlock_debug.c	(revision 91)
+++ lib/spinlock_debug.c	(working copy)
@@ -133,6 +133,8 @@
 	debug_spin_lock_after(lock);
 }
=20
+EXPORT_SYMBOL(_raw_spin_lock);
+
 int _raw_spin_trylock(spinlock_t *lock)
 {
 	int ret =3D __raw_spin_trylock(&lock->raw_lock);
@@ -148,12 +150,16 @@
 	return ret;
 }
=20
+EXPORT_SYMBOL(_raw_spin_trylock);
+
 void _raw_spin_unlock(spinlock_t *lock)
 {
 	debug_spin_unlock(lock);
 	__raw_spin_unlock(&lock->raw_lock);
 }
=20
+EXPORT_SYMBOL(_raw_spin_unlock);
+
 static void rwlock_bug(rwlock_t *lock, const char *msg)
 {
 	if (!debug_locks_off())
@@ -199,6 +205,8 @@
 	__raw_read_lock(&lock->raw_lock);
 }
=20
+EXPORT_SYMBOL(_raw_read_lock);
+
 int _raw_read_trylock(rwlock_t *lock)
 {
 	int ret =3D __raw_read_trylock(&lock->raw_lock);
@@ -212,12 +220,16 @@
 	return ret;
 }
=20
+EXPORT_SYMBOL(_raw_read_trylock);
+
 void _raw_read_unlock(rwlock_t *lock)
 {
 	RWLOCK_BUG_ON(lock->magic !=3D RWLOCK_MAGIC, lock, "bad magic");
 	__raw_read_unlock(&lock->raw_lock);
 }
=20
+EXPORT_SYMBOL(_raw_read_unlock);
+
 static inline void debug_write_lock_before(rwlock_t *lock)
 {
 	RWLOCK_BUG_ON(lock->magic !=3D RWLOCK_MAGIC, lock, "bad magic");
@@ -275,6 +287,8 @@
 	debug_write_lock_after(lock);
 }
=20
+EXPORT_SYMBOL(_raw_write_lock);
+
 int _raw_write_trylock(rwlock_t *lock)
 {
 	int ret =3D __raw_write_trylock(&lock->raw_lock);
@@ -290,8 +304,12 @@
 	return ret;
 }
=20
+EXPORT_SYMBOL(_raw_write_trylock);
+
 void _raw_write_unlock(rwlock_t *lock)
 {
 	debug_write_unlock(lock);
 	__raw_write_unlock(&lock->raw_lock);
 }
+
+EXPORT_SYMBOL(_raw_write_unlock);
Index: lib/ioremap.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- lib/ioremap.c	(revision 91)
+++ lib/ioremap.c	(working copy)
@@ -85,8 +85,8 @@
 		if (err)
 			break;
 	} while (pgd++, addr =3D next, addr !=3D end);
+	__ipipe_pin_range_globally(start, end);
+ 	flush_cache_vmap(start, end);
=20
-	flush_cache_vmap(start, end);
-
 	return err;
 }
Index: lib/Kconfig.debug
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- lib/Kconfig.debug	(revision 91)
+++ lib/Kconfig.debug	(working copy)
@@ -79,6 +79,8 @@
 	  exported to $(INSTALL_HDR_PATH) (usually 'usr/include' in
 	  your build tree), to make sure they're suitable.
=20
+source "kernel/ipipe/Kconfig.debug"
+
 config DEBUG_KERNEL
 	bool "Kernel debugging"
 	help
Index: mm/mlock.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- mm/mlock.c	(revision 91)
+++ mm/mlock.c	(working copy)
@@ -173,10 +173,10 @@
 static int do_mlockall(int flags)
 {
 	struct vm_area_struct * vma, * prev =3D NULL;
-	unsigned int def_flags =3D 0;
+	unsigned int def_flags =3D current->mm->def_flags & VM_PINNED;
=20
 	if (flags & MCL_FUTURE)
-		def_flags =3D VM_LOCKED;
+		def_flags |=3D VM_LOCKED;
 	current->mm->def_flags =3D def_flags;
 	if (flags =3D=3D MCL_FUTURE)
 		goto out;
Index: mm/memory.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- mm/memory.c	(revision 91)
+++ mm/memory.c	(working copy)
@@ -50,6 +50,7 @@
 #include <linux/delayacct.h>
 #include <linux/init.h>
 #include <linux/writeback.h>
+#include <linux/vmalloc.h>
=20
 #include <asm/pgalloc.h>
 #include <asm/uaccess.h>
@@ -415,6 +416,34 @@
 	return pfn_to_page(pfn);
 }
=20
+static inline void cow_user_page(struct page *dst, struct page *src, uns=
igned long va, struct vm_area_struct *vma)
+{
+	/*
+	 * If the source page was a PFN mapping, we don't have
+	 * a "struct page" for it. We do a best-effort copy by
+	 * just copying from the original user address. If that
+	 * fails, we just zero-fill it. Live with it.
+	 */
+	if (unlikely(!src)) {
+		void *kaddr =3D kmap_atomic(dst, KM_USER0);
+		void __user *uaddr =3D (void __user *)(va & PAGE_MASK);
+
+		/*
+		 * This really shouldn't fail, because the page is there
+		 * in the page tables. But it might just be unreadable,
+		 * in which case we just give up and fill the result with
+		 * zeroes.
+		 */
+		if (__copy_from_user_inatomic(kaddr, uaddr, PAGE_SIZE))
+			memset(kaddr, 0, PAGE_SIZE);
+		kunmap_atomic(kaddr, KM_USER0);
+		flush_dcache_page(dst);
+		return;
+	=09
+	}
+	copy_user_highpage(dst, src, va, vma);
+}
+
 /*
  * copy one vm_area from one task to the other. Assumes the page tables
  * already present in the new task to be cleared in the whole range
@@ -423,8 +452,8 @@
=20
 static inline void
 copy_one_pte(struct mm_struct *dst_mm, struct mm_struct *src_mm,
-		pte_t *dst_pte, pte_t *src_pte, struct vm_area_struct *vma,
-		unsigned long addr, int *rss)
+	     pte_t *dst_pte, pte_t *src_pte, struct vm_area_struct *vma,
+	     unsigned long addr, int *rss, struct page *uncow_page)
 {
 	unsigned long vm_flags =3D vma->vm_flags;
 	pte_t pte =3D *src_pte;
@@ -463,6 +492,21 @@
 	 * in the parent and the child
 	 */
 	if (is_cow_mapping(vm_flags)) {
+#ifdef CONFIG_IPIPE
+		if (uncow_page) {
+			struct page *old_page =3D vm_normal_page(vma, addr, pte);
+			cow_user_page(uncow_page, old_page, addr, vma);
+			pte =3D mk_pte(uncow_page, vma->vm_page_prot);
+		=09
+			if (vm_flags & VM_SHARED)
+				pte =3D pte_mkclean(pte);
+			pte =3D pte_mkold(pte);
+
+			page_dup_rmap(uncow_page, vma, addr);
+			rss[!!PageAnon(uncow_page)]++;
+			goto out_set_pte;
+		}
+#endif /* CONFIG_IPIPE */
 		ptep_set_wrprotect(src_mm, addr, src_pte);
 		pte =3D pte_wrprotect(pte);
 	}
@@ -493,13 +537,27 @@
 	pte_t *src_pte, *dst_pte;
 	spinlock_t *src_ptl, *dst_ptl;
 	int progress =3D 0;
+	struct page *uncow_page =3D NULL;
 	int rss[2];
-
+#ifdef CONFIG_IPIPE
+	int do_cow_break =3D 0;
 again:
+	if (do_cow_break) {
+		uncow_page =3D alloc_page_vma(GFP_HIGHUSER, vma, addr);
+		if (!uncow_page)
+			return -ENOMEM;
+		do_cow_break =3D 0;
+	}
+#else
+again:
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
@@ -521,7 +579,20 @@
 			progress++;
 			continue;
 		}
-		copy_one_pte(dst_mm, src_mm, dst_pte, src_pte, vma, addr, rss);
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
+		copy_one_pte(dst_mm, src_mm, dst_pte,
+			     src_pte, vma, addr, rss, uncow_page);
+		uncow_page =3D NULL;
 		progress +=3D 8;
 	} while (dst_pte++, src_pte++, addr +=3D PAGE_SIZE, addr !=3D end);
=20
@@ -1496,34 +1567,6 @@
 	return pte;
 }
=20
-static inline void cow_user_page(struct page *dst, struct page *src, uns=
igned long va, struct vm_area_struct *vma)
-{
-	/*
-	 * If the source page was a PFN mapping, we don't have
-	 * a "struct page" for it. We do a best-effort copy by
-	 * just copying from the original user address. If that
-	 * fails, we just zero-fill it. Live with it.
-	 */
-	if (unlikely(!src)) {
-		void *kaddr =3D kmap_atomic(dst, KM_USER0);
-		void __user *uaddr =3D (void __user *)(va & PAGE_MASK);
-
-		/*
-		 * This really shouldn't fail, because the page is there
-		 * in the page tables. But it might just be unreadable,
-		 * in which case we just give up and fill the result with
-		 * zeroes.
-		 */
-		if (__copy_from_user_inatomic(kaddr, uaddr, PAGE_SIZE))
-			memset(kaddr, 0, PAGE_SIZE);
-		kunmap_atomic(kaddr, KM_USER0);
-		flush_dcache_page(dst);
-		return;
-
-	}
-	copy_user_highpage(dst, src, va, vma);
-}
-
 /*
  * This routine handles present pages, when users try to write
  * to a shared page. It is done by copying the page to a new address
@@ -2756,3 +2799,110 @@
=20
 	return buf - old_buf;
 }
+
+#ifdef CONFIG_IPIPE
+
+static inline int ipipe_pin_pte_range(struct mm_struct *mm, pmd_t *pmd,
+				      struct vm_area_struct *vma,
+				      unsigned long addr, unsigned long end)
+{
+	spinlock_t *ptl;
+	pte_t *pte;
+=09
+	do {
+		pte =3D pte_offset_map_lock(mm, pmd, addr, &ptl);
+		if (!pte)
+			continue;
+
+		if (!pte_present(*pte)) {
+			pte_unmap_unlock(pte, ptl);
+			continue;
+		}
+
+		if (do_wp_page(mm, vma, addr, pte, pmd, ptl, *pte) =3D=3D VM_FAULT_OOM=
)
+			return -ENOMEM;
+	} while (addr +=3D PAGE_SIZE, addr !=3D end);
+	return 0;
+}
+
+static inline int ipipe_pin_pmd_range(struct mm_struct *mm, pud_t *pud,
+				      struct vm_area_struct *vma,
+				      unsigned long addr, unsigned long end)
+{
+	unsigned long next;
+	pmd_t *pmd;
+
+	pmd =3D pmd_offset(pud, addr);
+	do {
+		next =3D pmd_addr_end(addr, end);
+		if (pmd_none_or_clear_bad(pmd))
+			continue;
+		if (ipipe_pin_pte_range(mm, pmd, vma, addr, next))
+			return -ENOMEM;
+	} while (pmd++, addr =3D next, addr !=3D end);
+	return 0;
+}
+
+static inline int ipipe_pin_pud_range(struct mm_struct *mm, pgd_t *pgd,
+				      struct vm_area_struct *vma,
+				      unsigned long addr, unsigned long end)
+{
+	unsigned long next;
+	pud_t *pud;
+
+	pud =3D pud_offset(pgd, addr);
+	do {
+		next =3D pud_addr_end(addr, end);
+		if (pud_none_or_clear_bad(pud))
+			continue;
+		if (ipipe_pin_pmd_range(mm, pud, vma, addr, next))
+			return -ENOMEM;
+	} while (pud++, addr =3D next, addr !=3D end);
+	return 0;
+}
+
+int ipipe_disable_ondemand_mappings(struct task_struct *tsk)
+{
+	unsigned long addr, next, end;
+	struct vm_area_struct *vma;
+	struct mm_struct *mm;
+	int result =3D 0;
+	pgd_t *pgd;
+
+	mm =3D get_task_mm(tsk);
+	if (!mm)
+		return -EPERM;
+
+	down_write(&mm->mmap_sem);
+	if (mm->def_flags & VM_PINNED)
+		goto done_mm;
+
+	for (vma =3D mm->mmap; vma; vma =3D vma->vm_next) {
+		if (!is_cow_mapping(vma->vm_flags))
+			continue;
+
+		addr =3D vma->vm_start;
+		end =3D vma->vm_end;
+	=09
+		pgd =3D pgd_offset(mm, addr);
+		do {
+			next =3D pgd_addr_end(addr, end);
+			if (pgd_none_or_clear_bad(pgd))
+				continue;
+			if (ipipe_pin_pud_range(mm, pgd, vma, addr, next)) {
+				result =3D -ENOMEM;
+				goto done_mm;
+			}
+		} while (pgd++, addr =3D next, addr !=3D end);
+	}
+	mm->def_flags |=3D VM_PINNED;
+
+  done_mm:
+	up_write(&mm->mmap_sem);
+	mmput(mm);
+	return result;
+}
+
+EXPORT_SYMBOL(ipipe_disable_ondemand_mappings);
+
+#endif
Index: mm/vmalloc.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- mm/vmalloc.c	(revision 91)
+++ mm/vmalloc.c	(working copy)
@@ -161,6 +161,7 @@
 		if (err)
 			break;
 	} while (pgd++, addr =3D next, addr !=3D end);
+	__ipipe_pin_range_globally((unsigned long) area->addr, end);
 	flush_cache_vmap((unsigned long) area->addr, end);
 	return err;
 }
Index: arch/arm/kernel/entry-header.S
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- arch/arm/kernel/entry-header.S	(revision 91)
+++ arch/arm/kernel/entry-header.S	(working copy)
@@ -100,6 +100,18 @@
 	rfeia	sp!
 	.endm
=20
+ 	.macro slow_restore_user_regs
+ 	/* perform architecture specific actions before user return */
+ 	arch_ret_to_user r1, lr
+ 	ldr	r1, [sp, #S_PSR]		@ get calling cpsr
+ 	ldr	lr, [sp, #S_PC]!		@ get pc
+ 	msr	spsr_cxsf, r1			@ save in spsr_svc
+ 	ldmdb	sp, {r0 - lr}^			@ get calling r1 - lr
+ 	mov	r0, r0
+ 	add	sp, sp, #S_FRAME_SIZE - S_PC
+ 	movs	pc, lr				@ return & move spsr_svc into cpsr
+ 	.endm
+
 /*
  * These are the registers used in the syscall handler, and allow us to
  * have in theory up to 7 arguments to a function - r0 to r6.
Index: arch/arm/kernel/entry-common.S
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- arch/arm/kernel/entry-common.S	(revision 91)
+++ arch/arm/kernel/entry-common.S	(working copy)
@@ -2,6 +2,7 @@
  *  linux/arch/arm/kernel/entry-common.S
  *
  *  Copyright (C) 2000 Russell King
+ *  Copyright (C) 2005 Stelian Pop.
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
@@ -22,6 +23,11 @@
  * possible here, and this includes saving r0 back into the SVC
  * stack.
  */
+#ifdef CONFIG_IPIPE
+    __ipipe_ret_fast_syscall:
+ 	ldr	r0, [sp, #S_R0+S_OFF]		@ returned r0
+ 	/* fall through */
+#endif
 ret_fast_syscall:
 	disable_irq				@ disable interrupts
 	ldr	r1, [tsk, #TI_FLAGS]
@@ -31,7 +37,7 @@
 	/* perform architecture specific actions before user return */
 	arch_ret_to_user r1, lr
=20
-	@ fast_restore_user_regs
+    fast_restore_user_regs:
  THUMB(	mov	r2, sp			     )
  THUMB(	load_user_sp_lr r2, r3, S_OFF + S_SP )	@ calling sp, lr
 	ldr	r1, [sp, #S_OFF + S_PSR]	@ get calling cpsr
@@ -46,6 +52,13 @@
  THUMB(	add	sp, sp, #S_FRAME_SIZE - S_R1 )
 	movs	pc, lr				@ return & move spsr_svc into cpsr
=20
+#ifdef CONFIG_IPIPE
+__ipipe_fast_exit_syscall:
+	ldr	r0, [sp, #S_R0+S_OFF]		@ returned r0
+	disable_irq				@ disable interrupts
+	b	fast_restore_user_regs
+#endif /* CONFIG_IPIPE */
+
 /*
  * Ok, we need to do extra processing, enter the slow path.
  */
@@ -56,13 +69,20 @@
 	bne	work_resched
 	tst	r1, #_TIF_SIGPENDING
 	beq	no_work_pending
+#ifdef CONFIG_IPIPE
+	enable_irq
+#endif /* CONFIG_IPIPE */
 	mov	r0, sp				@ 'regs'
 	mov	r2, why				@ 'syscall'
 	bl	do_notify_resume
 	b	ret_slow_syscall		@ Check work again
=20
 work_resched:
+#ifdef CONFIG_IPIPE
+	enable_irq
+#endif /* CONFIG_IPIPE */
 	bl	schedule
+
 /*
  * "slow" syscall return path.  "why" tells us if this was a real syscal=
l.
  */
@@ -73,28 +93,16 @@
 	tst	r1, #_TIF_WORK_MASK
 	bne	work_pending
 no_work_pending:
-	/* perform architecture specific actions before user return */
-	arch_ret_to_user r1, lr
-
-	@ slow_restore_user_regs
- THUMB(	mov	r2, sp			     )
- THUMB(	load_user_sp_lr r2, r3, S_SP	     )	@ calling sp, lr
-	ldr	r1, [sp, #S_PSR]		@ get calling cpsr
- ARM(	ldr	lr, [sp, #S_PC]!	     )	@ get pc
- THUMB(	ldr	lr, [sp, #S_PC]		     )	@ get pc
-	msr	spsr_cxsf, r1			@ save in spsr_svc
- ARM(	ldmdb	sp, {r0 - lr}^		     )	@ get calling r1 - lr
- THUMB(	ldmia	sp, {r0 - r12}		     )	@ get calling r0 - r12
-	mov	r0, r0
- ARM(	add	sp, sp, #S_FRAME_SIZE - S_PC )
- THUMB(	add	sp, sp, #S_FRAME_SIZE	     )
-	movs	pc, lr				@ return & move spsr_svc into cpsr
+    slow_restore_user_regs
 ENDPROC(ret_to_user)
=20
 /*
  * This is how we return from a fork.
  */
 ENTRY(ret_from_fork)
+#ifdef CONFIG_IPIPE
+ 	enable_irq
+#endif /* CONFIG_IPIPE */
 	bl	schedule_tail
 	get_thread_info tsk
 	ldr	r1, [tsk, #TI_FLAGS]		@ check for syscall tracing
@@ -223,6 +231,18 @@
 #endif
=20
 	stmdb	sp!, {r4, r5}			@ push fifth and sixth args
+#ifdef CONFIG_IPIPE
+	stmfd	sp!, {r0-r3, ip}
+	sub	sp, sp, #4
+	add	r1, sp, #S_OFF+24
+	mov	r0, scno
+	bl	__ipipe_syscall_root
+	cmp	r0, #0
+	add	sp, sp, #4
+	ldmfd	sp!, {r0-r3, ip}
+	blt	__ipipe_ret_fast_syscall
+	bgt	__ipipe_fast_exit_syscall
+#endif /* CONFIG_IPIPE */
 	tst	ip, #_TIF_SYSCALL_TRACE		@ are we tracing syscalls?
 	bne	__sys_trace
=20
@@ -272,6 +292,9 @@
 __cr_alignment:
 	.word	cr_alignment
 #endif
+#ifdef CONFIG_IPIPE
+	.word	__ipipe_syscall_root
+#endif
 	.ltorg
=20
 /*
@@ -448,3 +471,28 @@
=20
 #endif
=20
+
+#ifdef CONFIG_FRAME_POINTER
+
+	.text
+	.align 0
+	.type arm_return_addr %function
+	.global arm_return_addr
+
+arm_return_addr:
+	mov	ip, r0
+	mov	r0, fp
+3:
+	cmp	r0, #0
+	beq	1f		@ frame list hit end, bail
+	cmp	ip, #0
+	beq	2f		@ reached desired frame
+	ldr	r0, [r0, #-12]  @ else continue, get next fp
+	sub	ip, ip, #1
+	b	3b
+2:
+	ldr	r0, [r0, #-4]   @ get target return address
+1:
+	mov	pc, lr
+
+#endif
Index: arch/arm/kernel/process.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- arch/arm/kernel/process.c	(revision 91)
+++ arch/arm/kernel/process.c	(working copy)
@@ -137,6 +137,12 @@
 		local_irq_disable();
 		if (!need_resched()) {
 			timer_dyn_reprogram();
+#ifdef CONFIG_IPIPE
+			__ipipe_unstall_root();
+#ifdef CONFIG_IPIPE_TRACE_IRQSOFF
+			ipipe_trace_end(0x8000000E);
+#endif /* CONFIG_IPIPE_TRACE_IRQSOFF */
+#endif /* CONFIG_IPIPE */
 			arch_idle();
 		}
 		local_irq_enable();
@@ -165,6 +171,7 @@
=20
 		if (!idle)
 			idle =3D default_idle;
+ 		ipipe_suspend_domain();
 		leds_event(led_idle_start);
 		tick_nohz_stop_sched_tick();
 		while (!need_resched())
Index: arch/arm/kernel/entry-armv.S
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- arch/arm/kernel/entry-armv.S	(revision 91)
+++ arch/arm/kernel/entry-armv.S	(working copy)
@@ -4,6 +4,7 @@
  *  Copyright (C) 1996,1997,1998 Russell King.
  *  ARM700 fix by Matthew Godbolt (linux-user@domain.hid)
  *  nommu support by Hyok S. Choi (hyok.choi@domain.hid)
+ *  Copyright (C) 2005 Stelian Pop.
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
@@ -28,19 +29,27 @@
  * Interrupt handling.  Preserves r7, r8, r9
  */
 	.macro	irq_handler
+#ifdef CONFIG_IPIPE
+	mov r0, #2
+#endif
 	get_irqnr_preamble r5, lr
-1:	get_irqnr_and_base r0, r6, r5, lr
+1:	get_irqnr_and_base r1, r6, r5, lr
 	itt	ne
+    movne	r0, r1
 	movne	r1, sp
 	@
 	@ routine called with r0 =3D irq number, r1 =3D struct pt_regs *
 	@
+#ifdef CONFIG_IPIPE
+ 	bne	__ipipe_grab_irq
+#else
 #ifndef CONFIG_MACH_REALVIEW_EB
 	badr	lr, 1b, ne
 	bne	asm_do_IRQ
 #else
 	blne	asm_do_IRQ
 #endif
+#endif
=20
 #ifdef CONFIG_SMP
 	/*
@@ -49,20 +58,24 @@
 	 * this macro assumes that irqstat (r6) and base (r5) are
 	 * preserved from get_irqnr_and_base above
 	 */
-	test_for_ipi r0, r6, r5, lr
+	test_for_ipi r1, r6, r5, lr
 	ittt	ne
 	movne	r0, sp
 	badr	lr, 1b, ne
 	bne	do_IPI
=20
 #ifdef CONFIG_LOCAL_TIMERS
-	test_for_ltirq r0, r6, r5, lr
+	test_for_ltirq r1, r6, r5, lr
 	ittt	ne
 	movne	r0, sp
 	badr	lr, 1b, ne
 	bne	do_local_timer
 #endif
 #endif
+#ifdef CONFIG_IPIPE
+ 	cmp	r0, #2
+	bleq	__ipipe_check_root_interruptible
+#endif=09
=20
 	.endm
=20
@@ -215,14 +228,25 @@
 #endif
 #ifdef CONFIG_PREEMPT
 	get_thread_info tsk
+#ifndef CONFIG_IPIPE
 	ldr	r8, [tsk, #TI_PREEMPT]		@ get preempt count
 	add	r7, r8, #1			@ increment it
 	str	r7, [tsk, #TI_PREEMPT]
 #endif
+#endif
=20
 	irq_handler
+#ifdef CONFIG_IPIPE
+	cmp	r0, #0
+	beq	__ipipe_fast_svc_irq_exit
+#endif
+
 #ifdef CONFIG_PREEMPT
 	ldr	r0, [tsk, #TI_FLAGS]		@ get flags
+#ifdef CONFIG_IPIPE
+	ldr	r8, [tsk, #TI_PREEMPT]		@ get preempt count
+	mov     r7, r8
+#endif=09
 	tst	r0, #_TIF_NEED_RESCHED
 	blne	svc_preempt
 preempt_return:
@@ -232,6 +256,9 @@
 	it	ne
 	strne	r0, [r0, -r0]			@ bug()
 #endif
+#ifdef CONFIG_IPIPE
+__ipipe_fast_svc_irq_exit:
+#endif
 	ldr	r0, [sp, #S_PSR]		@ irqs are already disabled
  ARM(	msr	spsr_cxsf, r0	)
 #ifdef CONFIG_TRACE_IRQFLAGS
@@ -255,19 +282,33 @@
 	adds	r0, r0, r1
 	it	ne
 	movne	pc, lr
+#ifdef CONFIG_IPIPE
+	bl	__ipipe_fast_stall_root
+	enable_irq
+#endif
 	mov	r7, #0				@ preempt_schedule_irq
 	str	r7, [tsk, #TI_PREEMPT]		@ expects preempt_count =3D=3D 0
 1:	bl	preempt_schedule_irq		@ irq en/disable is done inside
 	ldr	r0, [tsk, #TI_FLAGS]		@ get new tasks TI_FLAGS
 	tst	r0, #_TIF_NEED_RESCHED
-	beq	preempt_return			@ go again
-	b	1b
+	bne	1b
+#ifdef CONFIG_IPIPE
+	disable_irq
+	bl	__ipipe_fast_unstall_root
 #endif
+	b	preempt_return			@ go again
+#endif
=20
 	.align	5
 __und_svc:
 	svc_entry
=20
+#ifdef CONFIG_IPIPE
+	mov	r1, sp				@ r0 =3D trapno, r1 =3D &regs
+	bl	__ipipe_dispatch_event		@ branch to trap handler
+	cmp	r0, #0
+	bne	1f
+#endif /* CONFIG_IPIPE */
 	@
 	@ call emulation code, which returns using r9 if it has emulated
 	@ the instruction, or the more conventional lr if we are to treat
@@ -452,18 +493,28 @@
 #endif
 	get_thread_info tsk
 #ifdef CONFIG_PREEMPT
+#ifndef CONFIG_IPIPE
 	ldr	r8, [tsk, #TI_PREEMPT]		@ get preempt count
 	add	r7, r8, #1			@ increment it
 	str	r7, [tsk, #TI_PREEMPT]
 #endif
+#endif
=20
 	irq_handler
+#ifdef CONFIG_IPIPE
+	cmp	r0, #0
+	bne	__ipipe_usr_irq_continue
+	slow_restore_user_regs			@ Fast exit path over non-root domains
+__ipipe_usr_irq_continue:
+#endif
 #ifdef CONFIG_PREEMPT
+#ifndef CONFIG_IPIPE
 	ldr	r0, [tsk, #TI_PREEMPT]
 	str	r8, [tsk, #TI_PREEMPT]
 	teq	r0, r7
 	strne	r0, [r0, -r0]
 #endif
+#endif
 #ifdef CONFIG_TRACE_IRQFLAGS
 	bl	trace_hardirqs_on
 #endif
@@ -612,8 +663,8 @@
 	W(mov)	pc, lr				@ CP#8
 	W(mov)	pc, lr				@ CP#9
 #ifdef CONFIG_VFP
-	W(b)	do_vfp				@ CP#10 (VFP)
-	W(b)	do_vfp				@ CP#11 (VFP)
+	W(b)	_do_vfp				@ CP#10 (VFP)
+	W(b)	_do_vfp				@ CP#11 (VFP)
 #else
 	W(mov)	pc, lr				@ CP#10 (VFP)
 	W(mov)	pc, lr				@ CP#11 (VFP)
@@ -638,11 +689,35 @@
 #endif
=20
 do_fpe:
+#ifdef CONFIG_IPIPE
+	mov	r4, r0
+	mov	r0, #5				@ =3D=3D IPIPE_TRAP_FPU
+	mov	r1, sp				@ r0 =3D trapno, r1 =3D &regs
+	bl	__ipipe_dispatch_event		@ branch to trap handler
+	cmp	r0, #0
+	ldrne	pc, [r9]
+	mov	r0, r4
+#endif
 	enable_irq
 	ldr	r4, .LCfp
 	add	r10, r10, #TI_FPSTATE		@ r10 =3D workspace
 	ldr	pc, [r4]			@ Call FP module USR entry point
=20
+#ifdef CONFIG_VFP
+_do_vfp:
+#ifdef CONFIG_IPIPE
+	mov	r4, r0
+	mov	r0, #6				@ =3D=3D IPIPE_TRAP_VFP
+	mov	r1, sp				@ r0 =3D trapno, r1 =3D &regs
+	bl	__ipipe_dispatch_event		@ branch to trap handler
+	cmp	r0, #0
+	ldrne	pc, [r9]
+	mov	r0, r4
+#endif
+	b	do_vfp
+#endif
+
+
 /*
  * The FP module is called with these registers set:
  *  r0  =3D instruction
@@ -687,6 +762,13 @@
  * This is the return code to user mode for abort handlers
  */
 ENTRY(ret_from_exception)
+#ifdef CONFIG_IPIPE
+	bl     __ipipe_check_root
+	cmp     r0, #0
+	bne     1f
+	slow_restore_user_regs          @ Fast exit path over non-root domains
+1:
+#endif /* CONFIG_IPIPE */
 	get_thread_info tsk
 	mov	why, #0
 	b	ret_to_user
@@ -768,6 +850,18 @@
  */
  THUMB(	.arm	)
=20
+#ifdef CONFIG_IPIPE
+/* We use the same mechanism as Linux user helpers to store variables re=
lated to
+   TSC emulation, so that they can be used in user-space. */
+	.align 5
+	.globl  __ipipe_tsc_area_start
+
+__ipipe_tsc_area_start:
+	.rep	12
+	.word	0
+	.endr
+#endif /* CONFIG_IPIPE */
+
 	.macro	usr_ret, reg
 #ifdef CONFIG_ARM_THUMB
 	bx	\reg
Index: arch/arm/kernel/irq.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- arch/arm/kernel/irq.c	(revision 91)
+++ arch/arm/kernel/irq.c	(working copy)
@@ -124,8 +124,10 @@
=20
 	desc_handle_irq(irq, desc);
=20
+#ifndef CONFIG_IPIPE
 	/* AT91 specific workaround */
 	irq_finish(irq);
+#endif /* !CONFIG_IPIPE */
=20
 	irq_exit();
 	set_irq_regs(old_regs);
Index: arch/arm/kernel/Makefile
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- arch/arm/kernel/Makefile	(revision 91)
+++ arch/arm/kernel/Makefile	(working copy)
@@ -20,6 +20,8 @@
 obj-$(CONFIG_SMP)		+=3D smp.o
 obj-$(CONFIG_KEXEC)		+=3D machine_kexec.o relocate_kernel.o
 obj-$(CONFIG_OABI_COMPAT)	+=3D sys_oabi-compat.o
+obj-$(CONFIG_IPIPE)		+=3D ipipe.o
+obj-$(CONFIG_IPIPE_TRACE_MCOUNT)	+=3D ipipe-mcount.o
=20
 obj-$(CONFIG_CRUNCH)		+=3D crunch.o crunch-bits.o
 AFLAGS_crunch-bits.o		:=3D -Wa,-mcpu=3Dep9312
Index: arch/arm/kernel/ipipe.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- arch/arm/kernel/ipipe.c	(revision 0)
+++ arch/arm/kernel/ipipe.c	(revision 0)
@@ -0,0 +1,454 @@
+/* -*- linux-c -*-
+ * linux/arch/arm/kernel/ipipe.c
+ *
+ * Copyright (C) 2002-2005 Philippe Gerum.
+ * Copyright (C) 2004 Wolfgang Grandegger (Adeos/arm port over 2.4).
+ * Copyright (C) 2005 Heikki Lindholm (PowerPC 970 fixes).
+ * Copyright (C) 2005 Stelian Pop.
+ * Copyright (C) 2006-2008 Gilles Chanteperdrix.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation, Inc., 675 Mass Ave, Cambridge MA 02139,=

+ * USA; either version 2 of the License, or (at your option) any later
+ * version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307,=
 USA.
+ *
+ * Architecture-dependent I-PIPE support for ARM.
+ */
+
+#include <linux/kernel.h>
+#include <linux/smp.h>
+#include <linux/sched.h>
+#include <linux/slab.h>
+#include <linux/bitops.h>
+#include <linux/interrupt.h>
+#include <linux/module.h>
+#include <linux/errno.h>
+#include <asm/system.h>
+#include <asm/atomic.h>
+#include <asm/hardirq.h>
+#include <asm/io.h>
+#include <asm/irq.h>
+#include <asm/unistd.h>
+#include <asm/mach/irq.h>
+#include <asm/mmu_context.h>
+
+/* Next tick date (timebase value). */
+DEFINE_PER_CPU(struct pt_regs, __ipipe_tick_regs);
+DEFINE_PER_CPU(struct mm_struct *,ipipe_active_mm);
+EXPORT_PER_CPU_SYMBOL(ipipe_active_mm);
+
+extern struct irq_desc irq_desc[];
+asmlinkage void asm_do_IRQ(unsigned int irq, struct pt_regs *regs);
+
+#ifdef CONFIG_SMP
+
+static cpumask_t __ipipe_cpu_sync_map;
+
+static cpumask_t __ipipe_cpu_lock_map;
+
+static IPIPE_DEFINE_SPINLOCK(__ipipe_cpu_barrier);
+
+static atomic_t __ipipe_critical_count =3D ATOMIC_INIT(0);
+
+static void (*__ipipe_cpu_sync) (void);
+
+/* Always called with hw interrupts off. */
+
+void __ipipe_do_critical_sync(unsigned irq)
+{
+	int cpu =3D ipipe_processor_id();
+
+	cpu_set(cpu, __ipipe_cpu_sync_map);
+
+	/*
+	 * Now we are in sync with the lock requestor running on another
+	 * CPU. Enter a spinning wait until he releases the global
+	 * lock.
+	 */
+	spin_lock(&__ipipe_cpu_barrier);
+
+	/* Got it. Now get out. */
+
+	if (__ipipe_cpu_sync)
+		/* Call the sync routine if any. */
+		__ipipe_cpu_sync();
+
+	spin_unlock(&__ipipe_cpu_barrier);
+
+	cpu_clear(cpu, __ipipe_cpu_sync_map);
+}
+
+#endif	/* CONFIG_SMP */
+
+/*
+ * ipipe_trigger_irq() -- Push the interrupt at front of the pipeline
+ * just like if it has been actually received from a hw source. Also
+ * works for virtual interrupts.
+ */
+int ipipe_trigger_irq(unsigned irq)
+{
+	unsigned long flags;
+
+	if (irq >=3D IPIPE_NR_IRQS ||
+	    (ipipe_virtual_irq_p(irq)
+	     && !test_bit(irq - IPIPE_VIRQ_BASE, &__ipipe_virtual_irq_map)))
+		return -EINVAL;
+
+	local_irq_save_hw(flags);
+
+	__ipipe_handle_irq(irq, NULL);
+
+	local_irq_restore_hw(flags);
+
+	return 1;
+}
+
+int ipipe_get_sysinfo(struct ipipe_sysinfo *info)
+{
+	info->ncpus =3D num_online_cpus();
+	info->cpufreq =3D ipipe_cpu_freq();
+	info->archdep.tmirq =3D __ipipe_mach_timerint;
+	info->archdep.tmfreq =3D info->cpufreq;
+        __ipipe_mach_get_tscinfo(&info->archdep.tsc);
+
+	return 0;
+}
+
+static int __ipipe_ack_irq(unsigned irq)
+{
+	irq_desc_t *desc =3D irq_desc + irq;
+	desc->ipipe_ack(irq, desc);
+#ifdef irq_finish
+ 	/* AT91 specific workaround */
+        irq_finish(irq);
+#endif /* irq_finish */
+	return 1;
+}
+
+static int __ipipe_ack_timerirq(unsigned irq)
+{
+	irq_desc_t *desc =3D irq_desc + irq;
+	desc->ipipe_ack(irq, desc);
+#ifdef irq_finish
+ 	/* AT91 specific workaround */
+	irq_finish(irq);
+#endif /* irq_finish */
+	__ipipe_mach_acktimer();
+	desc->ipipe_end(irq, desc);
+	return 1;
+}
+
+void __ipipe_enable_irqdesc(struct ipipe_domain *ipd, unsigned irq)
+{
+	irq_desc[irq].status &=3D ~IRQ_DISABLED;
+}
+
+/*
+ * __ipipe_enable_pipeline() -- We are running on the boot CPU, hw
+ * interrupts are off, and secondary CPUs are still lost in space.
+ */
+void __ipipe_enable_pipeline(void)
+{
+	unsigned long flags;
+	unsigned irq;
+
+	flags =3D ipipe_critical_enter(NULL);
+
+	/* First, virtualize all interrupts from the root domain. */
+
+	for (irq =3D 0; irq < NR_IRQS; irq++)
+		ipipe_virtualize_irq(ipipe_root_domain,
+				     irq,
+				     (ipipe_irq_handler_t)&asm_do_IRQ, NULL,
+				     ((irq =3D=3D __ipipe_mach_timerint)
+				      ? &__ipipe_ack_timerirq
+				      : &__ipipe_ack_irq),
+				     IPIPE_HANDLE_MASK | IPIPE_PASS_MASK);
+
+	ipipe_critical_exit(flags);
+}
+
+/*
+ * ipipe_critical_enter() -- Grab the superlock excluding all CPUs
+ * but the current one from a critical section. This lock is used when
+ * we must enforce a global critical section for a single CPU in a
+ * possibly SMP system whichever context the CPUs are running.
+ */
+unsigned long ipipe_critical_enter(void (*syncfn) (void))
+{
+	unsigned long flags;
+
+	local_irq_save_hw(flags);
+
+#ifdef CONFIG_SMP
+	if (num_online_cpus() > 1) {	/* We might be running a SMP-kernel on a U=
P box... */
+		int cpu =3D ipipe_processor_id();
+		cpumask_t lock_map;
+
+		if (!cpu_test_and_set(cpu, __ipipe_cpu_lock_map)) {
+			while (cpu_test_and_set(BITS_PER_LONG - 1,
+						__ipipe_cpu_lock_map)) {
+				int n =3D 0;
+				do {
+					cpu_relax();
+				} while (++n < cpu);
+			}
+
+			spin_lock(&__ipipe_cpu_barrier);
+
+			__ipipe_cpu_sync =3D syncfn;
+
+			/* Send the sync IPI to all processors but the current one. */
+			send_IPI_allbutself(IPIPE_CRITICAL_VECTOR);
+
+			cpus_andnot(lock_map, cpu_online_map,
+				    __ipipe_cpu_lock_map);
+
+			while (!cpus_equal(__ipipe_cpu_sync_map, lock_map))
+				cpu_relax();
+		}
+
+		atomic_inc(&__ipipe_critical_count);
+	}
+#endif	/* CONFIG_SMP */
+
+	return flags;
+}
+
+/* ipipe_critical_exit() -- Release the superlock. */
+
+void ipipe_critical_exit(unsigned long flags)
+{
+#ifdef CONFIG_SMP
+	if (num_online_cpus() > 1) {	/* We might be running a SMP-kernel on a U=
P box... */
+		if (atomic_dec_and_test(&__ipipe_critical_count)) {
+			spin_unlock(&__ipipe_cpu_barrier);
+
+			while (!cpus_empty(__ipipe_cpu_sync_map))
+				cpu_relax();
+
+			cpu_clear(ipipe_processor_id(), __ipipe_cpu_lock_map);
+			cpu_clear(BITS_PER_LONG - 1, __ipipe_cpu_lock_map);
+		}
+	}
+#endif	/* CONFIG_SMP */
+
+	local_irq_restore_hw(flags);
+}
+
+asmlinkage int __ipipe_check_root(void)
+{
+	return ipipe_root_domain_p;
+}
+
+asmlinkage int __ipipe_check_root_interruptible(void)
+{
+        return ipipe_root_domain_p && !__ipipe_test_root();
+}
+
+/* Called from entry-armv.S with hw interrupts off */
+asmlinkage void __ipipe_fast_stall_root(void)
+{
+        __set_bit(IPIPE_STALL_FLAG, &__ipipe_root_status);
+}
+
+/* Called from entry-armv.S with hw interrupts off */
+asmlinkage void __ipipe_fast_unstall_root(void)
+{
+	__clear_bit(IPIPE_STALL_FLAG, &__ipipe_root_status);
+}
+
+asmlinkage int __ipipe_syscall_root(unsigned long scno, struct pt_regs *=
regs)
+{
+	unsigned long flags, origr7;
+
+	/* We use r7 to pass the syscall number to the other domains */
+	origr7 =3D regs->ARM_r7;
+	regs->ARM_r7 =3D __NR_SYSCALL_BASE + scno;
+	/*
+	 * This routine either returns:
+	 * 0 -- if the syscall is to be passed to Linux;
+	 * >0 -- if the syscall should not be passed to Linux, and no
+	 * tail work should be performed;
+	 * <0 -- if the syscall should not be passed to Linux but the
+	 * tail work has to be performed (for handling signals etc).
+	 */
+
+	if (__ipipe_syscall_watched_p(current, regs->ARM_r7) &&
+	    __ipipe_event_monitored_p(IPIPE_EVENT_SYSCALL) &&
+	    __ipipe_dispatch_event(IPIPE_EVENT_SYSCALL,regs) > 0) {
+		if (ipipe_root_domain_p && !in_atomic()) {
+			/*
+			 * Sync pending VIRQs before _TIF_NEED_RESCHED
+			 * is tested.
+			 */
+			local_irq_save_hw(flags);
+			if ((ipipe_root_cpudom_var(irqpend_himask) & IPIPE_IRQMASK_VIRT) !=3D=
 0)
+				__ipipe_sync_pipeline(IPIPE_IRQMASK_VIRT);
+			local_irq_restore_hw(flags);
+			regs->ARM_r7 =3D origr7;
+			return -1;
+		}
+		regs->ARM_r7 =3D origr7;
+		return 1;
+	}
+
+	regs->ARM_r7 =3D origr7;
+	return 0;
+}
+
+/*
+ * __ipipe_handle_irq() -- IPIPE's generic IRQ handler. An optimistic
+ * interrupt protection log is maintained here for each domain. Hw
+ * interrupts are off on entry.
+ */
+int __ipipe_handle_irq(int irq, struct pt_regs *regs)
+{
+	struct ipipe_domain *this_domain, *next_domain;
+	struct list_head *head, *pos;
+	int m_ack;
+
+	m_ack =3D (regs =3D=3D NULL);
+
+	if (irq >=3D IPIPE_NR_IRQS) {
+		printk(KERN_ERR "I-pipe: spurious interrupt %d\n", irq);
+		goto finalize_nosync;
+	}
+
+	head =3D __ipipe_pipeline.next;
+	next_domain =3D list_entry(head, struct ipipe_domain, p_link);
+	if (likely(test_bit(IPIPE_WIRED_FLAG, &next_domain->irqs[irq].control))=
) {
+		if (!m_ack && next_domain->irqs[irq].acknowledge !=3D NULL)
+			next_domain->irqs[irq].acknowledge(irq);
+		if (likely(__ipipe_dispatch_wired(next_domain, irq))) {
+			goto finalize;
+		} else
+			goto finalize_nosync;
+	}
+
+	this_domain =3D ipipe_current_domain;
+
+	if (test_bit(IPIPE_STICKY_FLAG, &this_domain->irqs[irq].control))
+		head =3D &this_domain->p_link;
+
+	/* Ack the interrupt. */
+
+	pos =3D head;
+
+	while (pos !=3D &__ipipe_pipeline) {
+		next_domain =3D list_entry(pos, struct ipipe_domain, p_link);
+
+		/*
+		 * For each domain handling the incoming IRQ, mark it
+		 * as pending in its log.
+		 */
+		if (test_bit(IPIPE_HANDLE_FLAG, &next_domain->irqs[irq].control)) {
+			/*
+			 * Domains that handle this IRQ are polled for
+			 * acknowledging it by decreasing priority
+			 * order. The interrupt must be made pending
+			 * _first_ in the domain's status flags before
+			 * the PIC is unlocked.
+			 */
+			__ipipe_set_irq_pending(next_domain, irq);
+
+			if (!m_ack && next_domain->irqs[irq].acknowledge !=3D NULL)
+				m_ack =3D next_domain->irqs[irq].acknowledge(irq);
+		}
+
+		/*
+		 * If the domain does not want the IRQ to be passed
+		 * down the interrupt pipe, exit the loop now.
+		 */
+
+		if (!test_bit(IPIPE_PASS_FLAG, &next_domain->irqs[irq].control))
+			break;
+
+		pos =3D next_domain->p_link.next;
+	}
+
+finalize:
+
+	/*
+	 * Now walk the pipeline, yielding control to the highest
+	 * priority domain that has pending interrupt(s) or
+	 * immediately to the current domain if the interrupt has been
+	 * marked as 'sticky'. This search does not go beyond the
+	 * current domain in the pipeline.
+	 */
+
+	__ipipe_walk_pipeline(head);
+
+finalize_nosync:
+        if (!ipipe_root_domain_p || __ipipe_test_root())
+                return 0;
+
+#ifdef CONFIG_SMP
+	/*
+	 * Prevent a spurious rescheduling from being triggered on
+	 * preemptible kernels along the way out through
+	 * ret_from_intr.
+	 */
+        if (!regs)
+                __set_bit(IPIPE_STALL_FLAG, &ipipe_root_cpudom_var(statu=
s));
+#endif	/* CONFIG_SMP */
+
+        return 1;
+}
+
+asmlinkage int __ipipe_grab_irq(int irq, struct pt_regs *regs)
+{
+        int status;
+
+	if (irq =3D=3D __ipipe_mach_timerint) {
+                /*
+		 * Given our deferred dispatching model for regular IRQs, we
+                 * only record CPU regs for the last timer interrupt, so=
 that
+                 * the timer handler charges CPU times properly. It is a=
ssumed
+                 * that other interrupt handlers don't actually care for=
 such
+                 * information.
+		 */
+		__raw_get_cpu_var(__ipipe_tick_regs).ARM_cpsr =3D regs->ARM_cpsr;
+		__raw_get_cpu_var(__ipipe_tick_regs).ARM_pc =3D regs->ARM_pc;
+	}
+
+#ifdef CONFIG_IPIPE_TRACE_IRQSOFF
+	ipipe_trace_begin(regs->ARM_ORIG_r0);
+#endif
+
+	if (__ipipe_mach_irq_mux_p(irq)) {
+                __ipipe_mach_demux_irq(irq, regs);
+                status =3D ipipe_root_domain_p && !__ipipe_test_root();
+        } else
+		status =3D __ipipe_handle_irq(irq, regs);
+
+#ifdef CONFIG_IPIPE_TRACE_IRQSOFF
+	ipipe_trace_end(regs->ARM_ORIG_r0);
+#endif
+
+        return status;
+}
+
+EXPORT_SYMBOL_GPL(show_stack);
+#ifndef MULTI_CPU
+EXPORT_SYMBOL_GPL(cpu_do_switch_mm);
+#endif
+EXPORT_SYMBOL_GPL(__check_kvm_seq);
+#if defined(CONFIG_SMP) || defined(CONFIG_DEBUG_SPINLOCK)
+EXPORT_SYMBOL(tasklist_lock);
+#endif /* CONFIG_SMP || CONFIG_DEBUG_SPINLOCK */
+
+#ifdef CONFIG_IPIPE_TRACE_MCOUNT
+void notrace mcount(void);
+EXPORT_SYMBOL(mcount);
+#endif /* CONFIG_IPIPE_TRACE_MCOUNT */
Index: arch/arm/kernel/ptrace.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- arch/arm/kernel/ptrace.c	(revision 91)
+++ arch/arm/kernel/ptrace.c	(working copy)
@@ -481,6 +481,10 @@
=20
 static int break_trap(struct pt_regs *regs, unsigned int instr)
 {
+
+	if (ipipe_trap_notify(IPIPE_TRAP_BREAK,regs))
+		return 0;
+
 	ptrace_break(current, regs);
 	return 0;
 }
Index: arch/arm/kernel/traps.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- arch/arm/kernel/traps.c	(revision 91)
+++ arch/arm/kernel/traps.c	(working copy)
@@ -334,6 +334,9 @@
 	}
 	spin_unlock_irqrestore(&undef_lock, flags);
=20
+	if (ipipe_trap_notify(IPIPE_TRAP_UNDEFINSTR,regs))
+		return;
+
 #ifdef CONFIG_DEBUG_USER
 	if (user_debug & UDBG_UNDEFINED) {
 		printk(KERN_INFO "%s (%d): undefined instruction: pc=3D%p\n",
@@ -703,13 +706,22 @@
 }
 EXPORT_SYMBOL(abort);
=20
+#ifdef CONFIG_IPIPE
+void *__ipipe_tsc_area;
+#endif /* CONFIG_IPIPE */
+
 void __init trap_init(void)
 {
 	unsigned long vectors =3D CONFIG_VECTORS_BASE;
 	extern char __stubs_start[], __stubs_end[];
 	extern char __vectors_start[], __vectors_end[];
+#ifndef CONFIG_IPIPE
 	extern char __kuser_helper_start[], __kuser_helper_end[];
 	int kuser_sz =3D __kuser_helper_end - __kuser_helper_start;
+#else /* !CONFIG_IPIPE */
+	extern char __ipipe_tsc_area_start[], __kuser_helper_end[];
+	int kuser_sz =3D __kuser_helper_end - __ipipe_tsc_area_start;
+#endif /* !CONFIG_IPIPE */
=20
 	/*
 	 * Copy the vectors, stubs and kuser helpers (in entry-armv.S)
@@ -718,7 +730,13 @@
 	 */
 	memcpy((void *)vectors, __vectors_start, __vectors_end - __vectors_star=
t);
 	memcpy((void *)vectors + 0x200, __stubs_start, __stubs_end - __stubs_st=
art);
+#ifndef CONFIG_IPIPE
 	memcpy((void *)vectors + 0x1000 - kuser_sz, __kuser_helper_start, kuser=
_sz);
+#else /* !CONFIG_IPIPE */
+	BUG_ON(0x1000 - kuser_sz < 0x200 + __stubs_end - __stubs_start);
+	memcpy((void *)vectors + 0x1000 - kuser_sz, __ipipe_tsc_area_start, kus=
er_sz);
+	__ipipe_tsc_area =3D (void *)vectors + 0x1000 - kuser_sz;
+#endif /* !CONFIG_IPIPE */
=20
 	/*
 	 * Copy signal return handlers into the vector page, and
Index: arch/arm/kernel/ipipe-mcount.S
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- arch/arm/kernel/ipipe-mcount.S	(revision 0)
+++ arch/arm/kernel/ipipe-mcount.S	(revision 0)
@@ -0,0 +1,38 @@
+/*
+ *  linux/arch/arm/kernel/ipipe-mcount.S
+ *
+ *  Copyright (C) 2006 Sebastian Smolorz <ssmolorz@domain.hid>, emlix Gmb=
H
+ */
+
+#ifdef CONFIG_FRAME_POINTER
+
+	.text
+	.align 0
+	.type mcount %function
+	.global mcount
+
+mcount:
+
+	ldr	ip, =3Dipipe_trace_enable	@ leave early, if disabled
+	ldr	ip, [ip]
+	cmp	ip, #0
+	moveq	pc,lr
+
+	mov	ip,  sp
+	stmdb   sp!, {r0 - r3, fp, ip, lr, pc}	@ create stack frame
+
+	mov	r3, #0			@ no additional value (v)
+	ldr	r2, [fp, #-4]		@ get lr (the return address
+					@ of the caller of the
+					@ instrumented function)
+	mov	r1, lr			@ get lr - (the return address
+					@ of the instrumented function)
+	mov	r0, #0			@ IPIPE_TRACE_FN
+
+	sub	fp, ip, #4		@ point fp at this frame
+
+	bl	__ipipe_trace
+
+	ldmdb   fp, {r0 - r3, fp, sp, pc}	@ pop entry frame and return
+
+#endif
Index: arch/arm/Kconfig
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- arch/arm/Kconfig	(revision 91)
+++ arch/arm/Kconfig	(working copy)
@@ -189,6 +189,8 @@
 config ARCH_AT91
 	bool "Atmel AT91"
 	select GENERIC_GPIO
+	select GENERIC_TIME if IPIPE
+	select GENERIC_CLOCKEVENTS if IPIPE
 	help
 	  This enables support for systems based on the Atmel AT91RM9200
 	  and AT91SAM9xxx processors.
@@ -707,6 +709,8 @@
 	  accounting to be spread across the timer interval, preventing a
 	  "thundering herd" at every timer tick.
=20
+source "kernel/ipipe/Kconfig"
+
 config PREEMPT
 	bool "Preemptible Kernel (EXPERIMENTAL)"
 	depends on EXPERIMENTAL
Index: arch/arm/mach-imx/time.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- arch/arm/mach-imx/time.c	(revision 91)
+++ arch/arm/mach-imx/time.c	(working copy)
@@ -24,6 +24,54 @@
 #include <asm/irq.h>
 #include <asm/mach/time.h>
=20
+#ifdef CONFIG_IPIPE
+#ifdef CONFIG_NO_IDLE_HZ
+#error "dynamic tick timer not yet supported with IPIPE"
+#endif				/* CONFIG_NO_IDLE_HZ */
+int __ipipe_mach_timerint =3D TIM1_INT;
+EXPORT_SYMBOL(__ipipe_mach_timerint);
+
+int __ipipe_mach_timerstolen =3D 0;
+EXPORT_SYMBOL(__ipipe_mach_timerstolen);
+
+unsigned int __ipipe_mach_ticks_per_jiffy =3D LATCH;
+EXPORT_SYMBOL(__ipipe_mach_ticks_per_jiffy);
+
+static int imx_timer_initialized;
+union tsc_reg {
+#ifdef __BIG_ENDIAN
+	struct {
+		unsigned long high;
+		unsigned long low;
+	};
+#else				/* __LITTLE_ENDIAN */
+	struct {
+		unsigned long low;
+		unsigned long high;
+	};
+#endif				/* __LITTLE_ENDIAN */
+	unsigned long long full;
+};
+#ifdef CONFIG_SMP
+static union tsc_reg tsc[NR_CPUS];
+
+void __ipipe_mach_get_tscinfo(struct __ipipe_tscinfo *info)
+{
+	info->type =3D IPIPE_TSC_TYPE_NONE;
+}
+#else				/* !CONFIG_SMP */
+static union tsc_reg *tsc;
+
+void __ipipe_mach_get_tscinfo(struct __ipipe_tscinfo *info)
+{
+	info->type =3D IPIPE_TSC_TYPE_FREERUNNING;
+	info->u.fr.counter =3D (unsigned *)(0x10 + IMX_TIM1_BASE);
+	info->u.fr.mask =3D 0xffffffff;
+	info->u.fr.tsc =3D &tsc->full;
+}
+#endif				/* !CONFIG_SMP */
+#endif				/* CONFIG_IPIPE */
+
 /* Use timer 1 as system timer */
 #define TIMER_BASE IMX_TIM1_BASE
=20
@@ -37,6 +85,7 @@
 imx_timer_interrupt(int irq, void *dev_id)
 {
 	struct clock_event_device *evt =3D &clockevent_imx;
+#ifndef CONFIG_IPIPE
 	uint32_t tstat;
 	irqreturn_t ret =3D IRQ_NONE;
=20
@@ -50,6 +99,10 @@
 	}
=20
 	return ret;
+#else /* CONFIG_IPIPE */
+	evt->event_handler(evt);
+	return  IRQ_HANDLED;
+#endif /* CONFIG_IPIPE */
 }
=20
 static struct irqaction imx_timer_irq =3D {
@@ -123,7 +176,7 @@
 	 * The timer interrupt generation is disabled at least
 	 * for enough time to call imx_set_next_event()
 	 */
-	local_irq_save(flags);
+	local_irq_save_hw(flags);
 	/* Disable interrupt in GPT module */
 	IMX_TCTL(TIMER_BASE) &=3D ~TCTL_IRQEN;
 	if (mode !=3D clockevent_mode) {
@@ -140,7 +193,7 @@
=20
 	/* Remember timer mode */
 	clockevent_mode =3D mode;
-	local_irq_restore(flags);
+	local_irq_restore_hw(flags);
=20
 	switch (mode) {
 	case CLOCK_EVT_MODE_PERIODIC:
@@ -153,9 +206,9 @@
 		 * to call imx_set_next_event() or shutdown clock after
 		 * mode switching
 		 */
-		local_irq_save(flags);
+		local_irq_save_hw(flags);
 		IMX_TCTL(TIMER_BASE) |=3D TCTL_IRQEN;
-		local_irq_restore(flags);
+		local_irq_restore_hw(flags);
 		break;
 	case CLOCK_EVT_MODE_SHUTDOWN:
 	case CLOCK_EVT_MODE_UNUSED:
@@ -165,6 +218,13 @@
 	}
 }
=20
+#ifdef CONFIG_IPIPE
+int __ipipe_check_tickdev(const char *devname)
+{
+	return !strcmp(devname, clockevent_imx.name);
+}
+#endif /* CONFIG_IPIPE */
+
 static struct clock_event_device clockevent_imx =3D {
 	.name		=3D "imx_timer1",
 	.features	=3D CLOCK_EVT_FEAT_ONESHOT,
@@ -198,6 +258,14 @@
=20
 	imx_clockevent_init();
=20
+#ifdef CONFIG_IPIPE
+#ifndef CONFIG_SMP
+	tsc =3D (union tsc_reg *)__ipipe_tsc_area;
+	barrier();
+#endif				/* CONFIG_SMP */
+	imx_timer_initialized =3D 1;
+
+#endif				/* CONFIG_IPIPE */
 	/*
 	 * Make irqs happen for the system timer
 	 */
@@ -207,3 +275,76 @@
 struct sys_timer imx_timer =3D {
 	.init		=3D imx_timer_init,
 };
+
+#ifdef CONFIG_IPIPE
+void __ipipe_mach_acktimer(void)
+{
+	uint32_t tstat;
+	tstat =3D IMX_TSTAT(TIMER_BASE);
+	IMX_TSTAT(TIMER_BASE) =3D 0;
+	if (likely(tstat & TSTAT_COMP)) {
+		union tsc_reg *local_tsc;
+		unsigned long stamp, flags;
+
+		local_irq_save_hw(flags);
+		local_tsc =3D &tsc[ipipe_processor_id()];
+		stamp =3D IMX_TCN(TIMER_BASE);
+		if (unlikely(stamp < local_tsc->low))
+			/* 32 bit counter wrapped, increment high word. */
+			local_tsc->high++;
+		local_tsc->low =3D stamp;
+		local_irq_restore_hw(flags);
+	}
+}
+
+notrace unsigned long long __ipipe_mach_get_tsc(void)
+{
+	if (likely(imx_timer_initialized)) {
+		union tsc_reg *local_tsc, result;
+		unsigned long stamp;
+
+		local_tsc =3D &tsc[ipipe_processor_id()];
+
+	      __asm__("ldmia %1, %M0\n"
+		      : "=3Dr"(result.full), "+&r"(local_tsc)
+		      : "m"(*local_tsc));
+		barrier();
+		stamp =3D IMX_TCN(TIMER_BASE);
+		if (unlikely(stamp < result.low))
+			result.high++;
+		result.low =3D stamp;
+		return result.full;
+	}
+	return 0;
+}
+
+EXPORT_SYMBOL(__ipipe_mach_get_tsc);
+
+/*
+ * Reprogram the timer
+ */
+void __ipipe_mach_set_dec(unsigned long delay)
+{
+	unsigned long flags;
+	if (delay > 8) {
+		local_irq_save_hw(flags);
+		IMX_TCMP(TIMER_BASE) =3D IMX_TCN(TIMER_BASE) + delay;
+		local_irq_restore_hw(flags);
+	} else
+		ipipe_trigger_irq(TIM1_INT);
+}
+
+EXPORT_SYMBOL(__ipipe_mach_set_dec);
+
+void __ipipe_mach_release_timer(void)
+{
+	__ipipe_mach_set_dec(__ipipe_mach_ticks_per_jiffy);
+}
+
+EXPORT_SYMBOL(__ipipe_mach_release_timer);
+
+unsigned long __ipipe_mach_get_dec(void)
+{
+	return IMX_TCMP(TIMER_BASE) - IMX_TCN(TIMER_BASE);
+}
+#endif				/* CONFIG_IPIPE */
Index: arch/arm/mach-imx/irq.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- arch/arm/mach-imx/irq.c	(revision 91)
+++ arch/arm/mach-imx/irq.c	(working copy)
@@ -26,13 +26,88 @@
 #include <linux/init.h>
 #include <linux/list.h>
 #include <linux/timer.h>
+#ifdef CONFIG_IPIPE
+#include <linux/ipipe.h>
+#endif /* CONFIG_IPIPE */
=20
 #include <asm/hardware.h>
 #include <asm/irq.h>
 #include <asm/io.h>
=20
 #include <asm/mach/irq.h>
+#include <asm/arch/imx-regs.h>
=20
+/* Used for IMX INTERRUPT priority: Still Experimental */=20
+#ifdef CONFIG_IPIPE=20
+
+static unsigned int imx_default_irq_priority[IMX_IRQS] __initdata =3D {
+        0, /* unused */
+        0, /* unused */
+        0, /* unused */
+        0, /* unused */
+        0, /* unused */
+        0, /* unused */
+        5, /* Common Sensor Interface */
+        5, /* Multimedia Accelerator MAC */
+        5, /* Multimedia Accelerator */
+        0, /* unused */
+        5, /* MS */   =20
+        4, /* GPIO Port A */
+        4, /* GPIO Port B */
+        4, /* GPIO Port C */                =20
+        5,  /* LCDC */  =20
+        0, /* unused */
+        0, /* unused */
+        7, /* RTC */
+        7, /* RTC */
+        5, /* UART 2 PFerr*/
+        5, /* UART 2 RTS */
+        5, /* UART 2 DTR */
+        5, /* UART 2 UARTC*/
+        5, /* UART 2 Tx*/
+        5, /* UART 2 Rx*/
+        5, /* UART 1 PFerr*/
+        5, /* UART 1 RTS */
+        5, /* UART 1 DTR */
+        5, /* UART 1 UARTC*/
+        5, /* UART 1 Tx*/
+        5, /* UART 1 Rx*/
+        0, /* unused */
+        0, /* unused */
+        0, /* unused */
+        5,/* PWM */
+        5, /* MMC */
+        0, /* unused */
+        0, /* unused */
+        0, /* unused */
+        5, /* I2C */
+        5, /*SPI 2 */
+        5, /*SPI 1 */
+        5, /* SSI Tx*/
+        5, /* SSI Tx Err*/
+        5, /* SSI Rx */
+        5, /* SSI Rx Err*/
+        0, /* unused */
+        5, /* USB0 */
+        5, /* USB1 */
+        5, /* USB2 */
+        5, /* USB3 */
+        5, /* USB4 */
+        5, /* USB5 */
+        5, /* USB6 */
+        0, /* unused */
+        0, /* unused */
+        0, /* unused */
+        0, /* unused */
+        5, /* Timer2 */
+        15, /* Timer1 This is use by IPIPE */
+        12, /* DMA Err */
+        12, /* DMA */
+        4, /* GPIO D */
+        12 /* Watch dog */        /* Advanced Interrupt Controller (IRQ6=
) */
+        };
+#endif=20
+
 /*
  *
  * We simply use the ENABLE DISABLE registers inside of the IMX
@@ -249,6 +324,25 @@
 	.set_type =3D imx_gpio_irq_type,
 };
=20
+#ifdef CONFIG_IPIPE=20
+void __init imx_init_priority(void)
+{
+        unsigned int irq;=20
+        IMX_PRIO0=3D0;  =20
+        IMX_PRIO1=3D0;    =20
+        IMX_PRIO2=3D0;
+        IMX_PRIO3=3D0;  =20
+        IMX_PRIO4=3D0;    =20
+        IMX_PRIO5=3D0; =20
+        IMX_PRIO6=3D0;   =20
+        IMX_PRIO7=3D0;=20
+        printk(KERN_INFO "Initializing imx interrupt priorities\n");
+        for (irq =3D 0; irq < IMX_IRQS; irq++) {
+	        IMX_PRIO(irq)|=3D((imx_default_irq_priority[irq]&15)<<((irq%8)*=
4));
+        }            =20
+}
+#endif
+
 void __init
 imx_init_irq(void)
 {
@@ -278,7 +372,9 @@
 		set_irq_handler(irq, handle_edge_irq);
 		set_irq_flags(irq, IRQF_VALID);
 	}
-
+#ifdef CONFIG_IPIPE=20
+	imx_init_priority();=20
+#endif=20
 	set_irq_chained_handler(GPIO_INT_PORTA, imx_gpioa_demux_handler);
 	set_irq_chained_handler(GPIO_INT_PORTB, imx_gpiob_demux_handler);
 	set_irq_chained_handler(GPIO_INT_PORTC, imx_gpioc_demux_handler);
@@ -287,3 +383,29 @@
 	/* Release masking of interrupts according to priority */
 	__raw_writel(-1, IMX_AITC_NIMASK);
 }
+
+#ifdef CONFIG_IPIPE
+void __ipipe_mach_demux_irq(unsigned irq, struct pt_regs *regs)
+{
+        struct irq_desc *desc_unused =3D irq_desc + irq;
+        unsigned irq_unused =3D irq;
+        unsigned int i, mask;
+
+        /* GPPIOA, GPIOB, GPIOC, GPIOD are INT 11,12,13 and 62 */
+        i=3D((irq&7)-3);
+
+	/* Get all multiplexed ITs from given GPIO */
+        mask=3DISR(i);
+        irq=3D(i<<5)+IMX_IRQS;
+        do {
+        if (mask & 1 ) {
+		__ipipe_handle_irq(irq, regs);
+		// Ack multiplexed IT from given GPIO
+		ISR(i)=3D1<<(irq&0x1f);
+		}
+	mask >>=3D1;
+	irq++;
+	} while (mask);
+	desc_unused->chip->unmask(irq_unused);
+}
+#endif /* CONFIG_IPIPE */
Index: arch/arm/boot/compressed/head.S
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- arch/arm/boot/compressed/head.S	(revision 91)
+++ arch/arm/boot/compressed/head.S	(working copy)
@@ -965,6 +965,15 @@
 		mov	pc, r10
 #endif
=20
+#ifdef CONFIG_IPIPE_TRACE_MCOUNT
+                .text
+                .align 0
+                .type mcount %function
+                .global mcount
+mcount:
+		mov pc, lr	@ just return
+#endif
+
 		.ltorg
 reloc_end:
=20
Index: arch/arm/mach-s3c2440/irq.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- arch/arm/mach-s3c2440/irq.c	(revision 91)
+++ arch/arm/mach-s3c2440/irq.c	(working copy)
@@ -3,6 +3,8 @@
  * Copyright (c) 2003,2004 Simtec Electronics
  *	Ben Dooks <ben@domain.hid>
  *
+ * Copyright (C) 2006, 2007 Sebastian Smolorz <ssmolorz@domain.hid>, emli=
x GmbH
+ *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
  * the Free Software Foundation; either version 2 of the License, or
@@ -24,6 +26,7 @@
 #include <linux/interrupt.h>
 #include <linux/ioport.h>
 #include <linux/sysdev.h>
+#include <linux/ipipe.h>
=20
 #include <asm/hardware.h>
 #include <asm/irq.h>
@@ -95,6 +98,21 @@
 	.ack	    =3D s3c_irq_wdtac97_ack,
 };
=20
+#ifdef CONFIG_IPIPE
+void __ipipe_s3c_irq_demux_wdtac97(unsigned int subsrc, struct pt_regs *=
regs)
+{
+	subsrc >>=3D 13;
+	subsrc &=3D 3;
+
+	if (subsrc !=3D 0) {
+		if (subsrc & 1)
+			__ipipe_handle_irq(IRQ_S3C2440_WDT, regs);
+		if (subsrc & 2)
+			__ipipe_handle_irq(IRQ_S3C2440_AC97, regs);
+	}
+}
+#endif /* CONFIG_IPIPE */
+
 static int s3c2440_irq_add(struct sys_device *sysdev)
 {
 	unsigned int irqno;
Index: arch/arm/plat-s3c24xx/time.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- arch/arm/plat-s3c24xx/time.c	(revision 91)
+++ arch/arm/plat-s3c24xx/time.c	(working copy)
@@ -3,6 +3,8 @@
  * Copyright (C) 2003-2005 Simtec Electronics
  *	Ben Dooks, <ben@domain.hid>
  *
+ * Copyright (C) 2006, 2007 Sebastian Smolorz <ssmolorz@domain.hid>, emli=
x GmbH
+ *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
  * the Free Software Foundation; either version 2 of the License, or
@@ -25,6 +27,7 @@
 #include <linux/irq.h>
 #include <linux/err.h>
 #include <linux/clk.h>
+#include <linux/module.h>
=20
 #include <asm/system.h>
 #include <asm/leds.h>
@@ -40,7 +43,6 @@
 #include <asm/plat-s3c24xx/clock.h>
 #include <asm/plat-s3c24xx/cpu.h>
=20
-static unsigned long timer_startval;
 static unsigned long timer_usec_ticks;
=20
 #define TIMER_USEC_SHIFT 16
@@ -55,7 +57,40 @@
  * Original patch by Dimitry Andric, updated by Ben Dooks
 */
=20
+static unsigned long last_free_running_tcnt =3D 0;
+static unsigned long free_running_tcon =3D 0;
+static unsigned long timer_lxlost =3D 0;
=20
+#ifdef CONFIG_IPIPE
+
+#ifdef CONFIG_NO_IDLE_HZ
+#error "dynamic tick timer not yet supported with IPIPE"
+#endif /* CONFIG_NO_IDLE_HZ */
+
+unsigned int __ipipe_mach_ticks_per_jiffy;
+EXPORT_SYMBOL(__ipipe_mach_ticks_per_jiffy);
+
+int __ipipe_mach_timerint =3D IRQ_TIMER4;
+EXPORT_SYMBOL(__ipipe_mach_timerint);
+
+static unsigned long long *tsc;
+static unsigned *last_cnt;
+static unsigned long timer_ackval =3D 1UL << (IRQ_TIMER4 - IRQ_EINT0);
+static IPIPE_DEFINE_SPINLOCK(timer_lock);
+
+int __ipipe_mach_timerstolen =3D 0;
+EXPORT_SYMBOL(__ipipe_mach_timerstolen);
+
+void __ipipe_mach_get_tscinfo(struct __ipipe_tscinfo *info)
+{
+	info->type =3D IPIPE_TSC_TYPE_DECREMENTER;
+	info->u.dec.counter =3D (unsigned *)0x51000038;
+	info->u.dec.mask =3D 0xffff;
+	info->u.dec.last_cnt =3D last_cnt;
+	info->u.dec.tsc =3D tsc;
+}
+#endif /* CONFIG_IPIPE */
+
 /* timer_mask_usec_ticks
  *
  * given a clock and divisor, make the value to pass into timer_ticks_to=
_usec
@@ -85,45 +120,48 @@
 	return res >> TIMER_USEC_SHIFT;
 }
=20
-/***
- * Returns microsecond  since last clock interrupt.  Note that interrupt=
s
- * will have been disabled by do_gettimeoffset()
- * IRQs are disabled before entering here from do_gettimeofday()
- */
=20
-#define SRCPND_TIMER4 (1<<(IRQ_TIMER4 - IRQ_EINT0))
+static inline unsigned long timer_freerunning_getvalue(void)
+{
+	return __raw_readl(S3C2410_TCNTO(3));
+}
=20
-static unsigned long s3c2410_gettimeoffset (void)
+static inline unsigned long timer_freerunning_getticksoffset(unsigned lo=
ng tval)
 {
-	unsigned long tdone;
-	unsigned long irqpend;
-	unsigned long tval;
+	long tdone;
=20
-	/* work out how many ticks have gone since last timer interrupt */
+	tdone =3D  last_free_running_tcnt - tval;
+	if (tdone < 0)
+		tdone +=3D 0x10000;
=20
-        tval =3D  __raw_readl(S3C2410_TCNTO(4));
-	tdone =3D timer_startval - tval;
+	return tdone;
+}
=20
-	/* check to see if there is an interrupt pending */
+static inline unsigned long getticksoffset(void)
+{
+	return timer_freerunning_getticksoffset(timer_freerunning_getvalue());
+}
=20
-	irqpend =3D __raw_readl(S3C2410_SRCPND);
-	if (irqpend & SRCPND_TIMER4) {
-		/* re-read the timer, and try and fix up for the missed
-		 * interrupt. Note, the interrupt may go off before the
-		 * timer has re-loaded from wrapping.
-		 */
+#ifdef CONFIG_IPIPE
+static inline unsigned long getticksoffset_tscupdate(void)
+{
+	unsigned long tval;
+	unsigned long ticks;
=20
-		tval =3D  __raw_readl(S3C2410_TCNTO(4));
-		tdone =3D timer_startval - tval;
+	tval =3D timer_freerunning_getvalue();
+	ticks =3D timer_freerunning_getticksoffset(tval);
+	last_free_running_tcnt =3D tval;
+	*tsc +=3D ticks;
+	*last_cnt =3D last_free_running_tcnt;
+	return ticks;
+}
+#endif /* CONFIG_IPIPE */
=20
-		if (tval !=3D 0)
-			tdone +=3D timer_startval;
-	}
-
-	return timer_ticks_to_usec(tdone);
+static unsigned long s3c2410_gettimeoffset (void)
+{
+	return timer_ticks_to_usec(timer_lxlost + getticksoffset());
 }
=20
-
 /*
  * IRQ handler for the timer
  */
@@ -131,6 +169,14 @@
 s3c2410_timer_interrupt(int irq, void *dev_id)
 {
 	write_seqlock(&xtime_lock);
+
+#ifdef CONFIG_IPIPE
+	timer_lxlost =3D 0;
+
+	if (!__ipipe_mach_timerstolen)
+		getticksoffset_tscupdate();
+#endif /* CONFIG_IPIPE */
+
 	timer_tick();
 	write_sequnlock(&xtime_lock);
 	return IRQ_HANDLED;
@@ -149,10 +195,10 @@
 	machine_is_osiris() )
=20
 /*
- * Set up timer interrupt, and return the current time in seconds.
+ * Set up timer interrupt.
  *
- * Currently we only use timer4, as it is the only timer which has no
- * other function that can be exploited externally
+ * Currently we use timer4 as event timer and timer3 as tick counter whi=
ch
+ * permanently counts ticks without interrupt generation.
  */
 static void s3c2410_timer_setup (void)
 {
@@ -160,6 +206,7 @@
 	unsigned long tcnt;
 	unsigned long tcfg1;
 	unsigned long tcfg0;
+	unsigned long intmask;
=20
 	tcnt =3D 0xffff;  /* default value for tcnt */
=20
@@ -176,8 +223,8 @@
 		timer_usec_ticks =3D timer_mask_usec_ticks(1, 12000000);
 		tcnt =3D 12000000 / HZ;
=20
-		tcfg1 &=3D ~S3C2410_TCFG1_MUX4_MASK;
-		tcfg1 |=3D S3C2410_TCFG1_MUX4_TCLK1;
+		tcfg1 &=3D ~(S3C2410_TCFG1_MUX4_MASK | S3C2410_TCFG1_MUX3_MASK);
+		tcfg1 |=3D (S3C2410_TCFG1_MUX4_TCLK1 | S3C2410_TCFG1_MUX3_TCLK1);
 	} else {
 		unsigned long pclk;
 		struct clk *clk;
@@ -205,8 +252,8 @@
=20
 		timer_usec_ticks =3D timer_mask_usec_ticks(6, pclk);
=20
-		tcfg1 &=3D ~S3C2410_TCFG1_MUX4_MASK;
-		tcfg1 |=3D S3C2410_TCFG1_MUX4_DIV2;
+		tcfg1 &=3D ~(S3C2410_TCFG1_MUX4_MASK | S3C2410_TCFG1_MUX3_MASK);
+		tcfg1 |=3D (S3C2410_TCFG1_MUX4_DIV2 | S3C2410_TCFG1_MUX3_DIV2);
=20
 		tcfg0 &=3D ~S3C2410_TCFG_PRESCALER1_MASK;
 		tcfg0 |=3D ((6 - 1) / 2) << S3C2410_TCFG_PRESCALER1_SHIFT;
@@ -214,6 +261,14 @@
 		tcnt =3D (pclk / 6) / HZ;
 	}
=20
+#ifdef CONFIG_IPIPE
+	tsc =3D (unsigned long long *)__ipipe_tsc_area;
+	last_cnt =3D (unsigned *)(tsc + 1);		/* means: +8 bytes */
+	barrier();
+
+	__ipipe_mach_ticks_per_jiffy =3D tcnt;
+#endif /* CONFIG_IPIPE */
+
 	/* timers reload after counting zero, so reduce the count by 1 */
=20
 	tcnt--;
@@ -230,23 +285,37 @@
 	__raw_writel(tcfg1, S3C2410_TCFG1);
 	__raw_writel(tcfg0, S3C2410_TCFG0);
=20
-	timer_startval =3D tcnt;
+	/* ensure timers are stopped... */
+	tcon &=3D ~(0x3f<<17);
+	__raw_writel(tcon, S3C2410_TCON);
+
+	/* Mask timer3 interrupt. */
+	intmask =3D __raw_readl(S3C2410_INTMSK);
+	intmask |=3D 1UL << (IRQ_TIMER3 - IRQ_EINT0);
+	__raw_writel(intmask, S3C2410_INTMSK);
+
+	/* Set timer values */
 	__raw_writel(tcnt, S3C2410_TCNTB(4));
+	__raw_writel(tcnt, S3C2410_TCMPB(4));
+	__raw_writel(0xffff, S3C2410_TCNTB(3));
+	__raw_writel(0xffff, S3C2410_TCMPB(3));
=20
-	/* ensure timer is stopped... */
+	/* Set base tcon value for later programming of timer 4 by Xenomai. */
+	free_running_tcon =3D tcon |  S3C2410_TCON_T3RELOAD | S3C2410_TCON_T3ST=
ART;
=20
-	tcon &=3D ~(7<<20);
-	tcon |=3D S3C2410_TCON_T4RELOAD;
-	tcon |=3D S3C2410_TCON_T4MANUALUPD;
+	/* Set auto reloads for both timers. */
+	tcon |=3D S3C2410_TCON_T3RELOAD | S3C2410_TCON_T4RELOAD;
=20
+	/* Manual update */
+	__raw_writel(tcon | S3C2410_TCON_T3MANUALUPD
+			  | S3C2410_TCON_T4MANUALUPD, S3C2410_TCON);
+
+	tcon |=3D S3C2410_TCON_T3START | S3C2410_TCON_T4START;
+	/* Start timers.*/
 	__raw_writel(tcon, S3C2410_TCON);
-	__raw_writel(tcnt, S3C2410_TCNTB(4));
-	__raw_writel(tcnt, S3C2410_TCMPB(4));
=20
-	/* start the timer running */
-	tcon |=3D S3C2410_TCON_T4START;
-	tcon &=3D ~S3C2410_TCON_T4MANUALUPD;
-	__raw_writel(tcon, S3C2410_TCON);
+	/* Save start value of timer 3 as begining of first period. */
+	last_free_running_tcnt =3D 0xffff;
 }
=20
 static void __init s3c2410_timer_init (void)
@@ -260,3 +329,58 @@
 	.offset		=3D s3c2410_gettimeoffset,
 	.resume		=3D s3c2410_timer_setup
 };
+
+#ifdef CONFIG_IPIPE
+void __ipipe_mach_acktimer(void)
+{
+	__raw_writel(timer_ackval, S3C2410_SRCPND);
+	__raw_writel(timer_ackval, S3C2410_INTPND);
+}
+
+notrace unsigned long long __ipipe_mach_get_tsc(void)
+{
+	unsigned long long result;
+	unsigned long flags;
+
+	local_irq_save_hw_notrace(flags);
+	spin_lock(&timer_lock);
+	result =3D *tsc + getticksoffset();
+	spin_unlock(&timer_lock);
+	local_irq_restore_hw_notrace(flags);
+	return result;
+}
+EXPORT_SYMBOL(__ipipe_mach_get_tsc);
+
+static inline void set_dec(unsigned long reload)
+{
+	__raw_writel(reload, S3C2410_TCNTB(4));
+	/* Manual update */
+	__raw_writel(free_running_tcon | S3C2410_TCON_T4MANUALUPD, S3C2410_TCON=
);
+	/* Start timer */
+	__raw_writel(free_running_tcon | S3C2410_TCON_T4START, S3C2410_TCON);
+}
+
+void __ipipe_mach_set_dec(unsigned long reload)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&timer_lock, flags);
+	timer_lxlost +=3D getticksoffset_tscupdate();
+	set_dec(reload);
+	spin_unlock_irqrestore(&timer_lock, flags);
+}
+EXPORT_SYMBOL(__ipipe_mach_set_dec);
+
+void __ipipe_mach_release_timer(void)
+{
+	free_running_tcon |=3D S3C2410_TCON_T4RELOAD;
+	__ipipe_mach_set_dec(__ipipe_mach_ticks_per_jiffy - 1);
+	free_running_tcon &=3D ~S3C2410_TCON_T4RELOAD;
+}
+EXPORT_SYMBOL(__ipipe_mach_release_timer);
+
+unsigned long __ipipe_mach_get_dec(void)
+{
+	return __raw_readl(S3C2410_TCNTO(4));
+}
+#endif /* CONFIG_IPIPE */
Index: arch/arm/plat-s3c24xx/s3c244x-irq.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- arch/arm/plat-s3c24xx/s3c244x-irq.c	(revision 91)
+++ arch/arm/plat-s3c24xx/s3c244x-irq.c	(working copy)
@@ -3,6 +3,8 @@
  * Copyright (c) 2003,2004 Simtec Electronics
  *	Ben Dooks <ben@domain.hid>
  *
+ * Copyright (C) 2007 Sebastian Smolorz <ssmolorz@domain.hid>, emlix GmbH=

+ *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
  * the Free Software Foundation; either version 2 of the License, or
@@ -94,6 +96,21 @@
 	.ack	    =3D s3c_irq_cam_ack,
 };
=20
+#ifdef CONFIG_IPIPE
+void __ipipe_s3c_irq_demux_cam(unsigned int subsrc, struct pt_regs *regs=
)
+{
+	subsrc >>=3D 11;
+	subsrc &=3D 3;
+
+	if (subsrc !=3D 0) {
+		if (subsrc & 1)
+			__ipipe_handle_irq(IRQ_S3C2440_CAM_C, regs);
+		if (subsrc & 2)
+			__ipipe_handle_irq(IRQ_S3C2440_CAM_P, regs);
+	}
+}
+#endif /* CONFIG_IPIPE */
+
 static int s3c244x_irq_add(struct sys_device *sysdev)
 {
 	unsigned int irqno;
Index: arch/arm/plat-s3c24xx/irq.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- arch/arm/plat-s3c24xx/irq.c	(revision 91)
+++ arch/arm/plat-s3c24xx/irq.c	(working copy)
@@ -3,6 +3,8 @@
  * Copyright (c) 2003,2004 Simtec Electronics
  *	Ben Dooks <ben@domain.hid>
  *
+ * Copyright (C) 2006, 2007 Sebastian Smolorz <ssmolorz@domain.hid>, emli=
x GmbH
+ *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
  * the Free Software Foundation; either version 2 of the License, or
@@ -48,13 +50,17 @@
  *
  *   25-Jul-2005  Ben Dooks
  *		  Split the S3C2440 IRQ code to seperate file
-*/
+ *
+ *   30-Oct-2006  Sebastian Smolorz
+ *		  Added Adeos/I-pipe support
+ */
=20
 #include <linux/init.h>
 #include <linux/module.h>
 #include <linux/interrupt.h>
 #include <linux/ioport.h>
 #include <linux/sysdev.h>
+#include <linux/ipipe.h>
=20
 #include <asm/hardware.h>
 #include <asm/irq.h>
@@ -69,6 +75,14 @@
 #include <asm/plat-s3c24xx/pm.h>
 #include <asm/plat-s3c24xx/irq.h>
=20
+#ifdef CONFIG_IPIPE
+#ifdef CONFIG_CPU_S3C2440
+extern void __ipipe_s3c_irq_demux_wdtac97(unsigned int irq,
+					  struct pt_regs *regs);
+extern void __ipipe_s3c_irq_demux_cam(unsigned int irq, struct pt_regs *=
regs);
+#endif /* CONFIG_CPU_S3C2440 */
+#endif /* CONFIG_IPIPE */
+
 /* wakeup irq control */
=20
 #ifdef CONFIG_PM
@@ -652,6 +666,107 @@
 #define s3c24xx_irq_resume  NULL
 #endif
=20
+#ifdef CONFIG_IPIPE
+static void __ipipe_s3c_irq_demux_uart(unsigned int start,
+					unsigned int subsrc,
+					struct pt_regs *regs)
+{
+	unsigned int offset =3D start - IRQ_S3CUART_RX0;
+
+	subsrc >>=3D offset;
+	subsrc &=3D 7;
+
+	if (subsrc !=3D 0) {
+		if (subsrc & 1)
+			__ipipe_handle_irq(start, regs);
+		if (subsrc & 2)
+			__ipipe_handle_irq(start+1, regs);
+		if (subsrc & 4)
+			__ipipe_handle_irq(start+2, regs);
+	}
+}
+
+static void __ipipe_s3c_irq_demux_adc(unsigned int subsrc,
+					struct pt_regs *regs)
+{
+	subsrc >>=3D 9;
+	subsrc &=3D 3;
+
+	if (subsrc !=3D 0) {
+		if (subsrc & 1)
+			__ipipe_handle_irq(IRQ_TC, regs);
+		if (subsrc & 2)
+			__ipipe_handle_irq(IRQ_ADC, regs);
+	}
+}
+
+static void __ipipe_s3c_irq_demux_extint(unsigned long mask,
+						struct pt_regs *regs)
+{
+	unsigned int irq;
+	unsigned long eintpnd =3D __raw_readl(S3C24XX_EINTPEND);
+	unsigned long eintmsk =3D __raw_readl(S3C24XX_EINTMASK);
+
+	eintpnd &=3D ~eintmsk;
+	eintpnd &=3D mask;
+
+	while (eintpnd) {
+		irq =3D __ffs(eintpnd);
+		eintpnd &=3D ~(1<<irq);
+
+		irq +=3D (IRQ_EINT4 - 4);
+
+		__ipipe_handle_irq(irq, regs);
+	}
+}
+
+void __ipipe_mach_demux_irq(unsigned irq, struct pt_regs *regs)
+{
+	unsigned int subsrc, submsk;
+	struct irq_desc *desc_unused =3D irq_desc + irq;
+
+	/* read the current pending interrupts, and the mask
+	 * for what it is available */
+	subsrc =3D __raw_readl(S3C2410_SUBSRCPND);
+	submsk =3D __raw_readl(S3C2410_INTSUBMSK);
+
+	subsrc &=3D ~submsk;
+
+	switch (irq) {
+	case IRQ_UART0:
+		__ipipe_s3c_irq_demux_uart(IRQ_S3CUART_RX0, subsrc, regs);
+		break;
+	case IRQ_UART1:
+		__ipipe_s3c_irq_demux_uart(IRQ_S3CUART_RX1, subsrc, regs);
+		break;
+	case IRQ_UART2:
+		__ipipe_s3c_irq_demux_uart(IRQ_S3CUART_RX2, subsrc, regs);
+		break;
+	case IRQ_ADCPARENT:
+		__ipipe_s3c_irq_demux_adc(subsrc, regs);
+		break;
+	case IRQ_EINT4t7:
+		__ipipe_s3c_irq_demux_extint(0xff, regs);
+		break;
+	case IRQ_EINT8t23:
+		__ipipe_s3c_irq_demux_extint(0xffffff00, regs);
+		break;
+#ifdef CONFIG_CPU_S3C2440
+	case IRQ_WDT:
+		__ipipe_s3c_irq_demux_wdtac97(subsrc, regs);
+		break;
+#endif /* CONFIG_CPU_S3C2440 */
+#ifdef CONFIG_CPU_S3C244X
+	case IRQ_CAM:
+		__ipipe_s3c_irq_demux_cam(subsrc, regs);
+		break;
+#endif /* CONFIG_CPU_S3C244X */
+	}
+
+	desc_unused->chip->unmask(irq);
+}
+#endif /* CONFIG_IPIPE */
+
 /* s3c24xx_init_irq
  *
  * Initialise S3C2410 IRQ system
Index: arch/arm/mach-integrator/integrator_cp.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- arch/arm/mach-integrator/integrator_cp.c	(revision 91)
+++ arch/arm/mach-integrator/integrator_cp.c	(working copy)
@@ -2,6 +2,7 @@
  *  linux/arch/arm/mach-integrator/integrator_cp.c
  *
  *  Copyright (C) 2003 Deep Blue Solutions Ltd
+ *  Copyright (C) 2005 Stelian Pop.
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -19,6 +20,7 @@
 #include <linux/amba/bus.h>
 #include <linux/amba/kmi.h>
 #include <linux/amba/clcd.h>
+#include <linux/ipipe.h>
=20
 #include <asm/hardware.h>
 #include <asm/io.h>
@@ -222,6 +224,31 @@
 	} while (status);
 }
=20
+#ifdef CONFIG_IPIPE
+void __ipipe_mach_demux_irq(unsigned irq, struct pt_regs *regs)
+{
+	unsigned long status =3D sic_readl(INTCP_VA_SIC_BASE + IRQ_STATUS);
+	struct irq_desc *desc_unused =3D irq_desc + irq;
+	unsigned irq_unused =3D irq;
+
+	if (status =3D=3D 0) {
+		do_bad_IRQ(irq, desc_unused);
+		return;
+	}
+
+	do {
+		irq =3D ffs(status) - 1;
+		status &=3D ~(1 << irq);
+
+		irq +=3D IRQ_SIC_START;
+
+		__ipipe_handle_irq(irq, regs);
+	} while (status);
+
+	desc_unused->chip->unmask(irq_unused);
+}
+#endif /* CONFIG_IPIPE */
+
 static void __init intcp_init_irq(void)
 {
 	unsigned int i;
@@ -568,9 +595,14 @@
=20
 #define TIMER_CTRL_IE	(1 << 5)			/* Interrupt Enable */
=20
+#ifdef CONFIG_IPIPE
+unsigned int __ipipe_mach_ticks_per_jiffy =3D 1000000 * TICKS_PER_uSEC /=
 HZ;
+EXPORT_SYMBOL(__ipipe_mach_ticks_per_jiffy);
+#endif
+
 static void __init intcp_timer_init(void)
 {
-	integrator_time_init(1000000 / HZ, TIMER_CTRL_IE);
+	integrator_time_init(1000000 * TICKS_PER_uSEC / HZ, TIMER_CTRL_IE);
 }
=20
 static struct sys_timer cp_timer =3D {
Index: arch/arm/mach-integrator/core.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- arch/arm/mach-integrator/core.c	(revision 91)
+++ arch/arm/mach-integrator/core.c	(working copy)
@@ -2,6 +2,7 @@
  *  linux/arch/arm/mach-integrator/core.c
  *
  *  Copyright (C) 2000-2003 Deep Blue Solutions Ltd
+ *  Copyright (C) 2005 Stelian Pop.
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2, as
@@ -195,53 +196,62 @@
 /*
  * How long is the timer interval?
  */
-#define TIMER_INTERVAL	(TICKS_PER_uSEC * mSEC_10)
-#if TIMER_INTERVAL >=3D 0x100000
-#define TICKS2USECS(x)	(256 * (x) / TICKS_PER_uSEC)
-#elif TIMER_INTERVAL >=3D 0x10000
-#define TICKS2USECS(x)	(16 * (x) / TICKS_PER_uSEC)
-#else
 #define TICKS2USECS(x)	((x) / TICKS_PER_uSEC)
-#endif
=20
 static unsigned long timer_reload;
+static unsigned long timer_interval;
+static unsigned long timer_lxlost;
+static int tscok;
=20
+#ifdef CONFIG_IPIPE
+int __ipipe_mach_timerint =3D IRQ_TIMERINT1;
+static unsigned long long __ipipe_mach_tsc;
+static IPIPE_DEFINE_SPINLOCK(timer_lock);
+
+int __ipipe_mach_timerstolen =3D 0;
+EXPORT_SYMBOL(__ipipe_mach_timerstolen);
+
+void __ipipe_mach_get_tscinfo(struct __ipipe_tscinfo *info)
+{
+	info->type =3D IPIPE_TSC_TYPE_NONE;
+}
+#endif
+
 /*
- * Returns number of ms since last clock interrupt.  Note that interrupt=
s
- * will have been disabled by do_gettimeoffset()
+ * Called with IRQ disabled from do_gettimeofday().
  */
-unsigned long integrator_gettimeoffset(void)
+static inline unsigned long integrator_getticksoffset(void)
 {
-	unsigned long ticks1, ticks2, status;
+	unsigned long ticks;
=20
-	/*
-	 * Get the current number of ticks.  Note that there is a race
-	 * condition between us reading the timer and checking for
-	 * an interrupt.  We get around this by ensuring that the
-	 * counter has not reloaded between our two reads.
-	 */
-	ticks2 =3D readl(TIMER1_VA_BASE + TIMER_VALUE) & 0xffff;
-	do {
-		ticks1 =3D ticks2;
-		status =3D __raw_readl(VA_IC_BASE + IRQ_RAW_STATUS);
-		ticks2 =3D readl(TIMER1_VA_BASE + TIMER_VALUE) & 0xffff;
-	} while (ticks2 > ticks1);
+	if (!tscok)
+		return 0;
=20
-	/*
-	 * Number of ticks since last interrupt.
-	 */
-	ticks1 =3D timer_reload - ticks2;
+	ticks =3D readl(TIMER1_VA_BASE + TIMER_VALUE) & 0xffff;
=20
-	/*
-	 * Interrupt pending?  If so, we've reloaded once already.
-	 */
-	if (status & (1 << IRQ_TIMERINT1))
-		ticks1 +=3D timer_reload;
+	if (ticks > timer_reload)
+		ticks =3D 0xffff + timer_reload - ticks;
+	else
+		ticks =3D timer_reload - ticks;
=20
+	if (timer_interval < 0x10000)
+		return ticks;
+	else if (timer_interval < 0x100000)
+		return ticks * 16;
+	else
+		return ticks * 256;
+}
+
+/*
+ * Returns number of ms since last clock interrupt.  Note that interrupt=
s
+ * will have been disabled by do_gettimeoffset()
+ */
+unsigned long integrator_gettimeoffset(void)
+{
 	/*
 	 * Convert the ticks to usecs
 	 */
-	return TICKS2USECS(ticks1);
+	return TICKS2USECS(timer_lxlost + integrator_getticksoffset());
 }
=20
 /*
@@ -252,11 +262,23 @@
 {
 	write_seqlock(&xtime_lock);
=20
+	timer_lxlost =3D 0;
+
+#ifdef CONFIG_IPIPE
 	/*
-	 * clear the interrupt
+	 * If Linux is the only domain, ack the timer and reprogram it
 	 */
-	writel(1, TIMER1_VA_BASE + TIMER_INTCLR);
+	if (!__ipipe_mach_timerstolen) {
+		__ipipe_mach_tsc +=3D integrator_getticksoffset();
+#else
+		writel(1, TIMER1_VA_BASE + TIMER_INTCLR);
+#endif
=20
+		writel(timer_reload, TIMER1_VA_BASE + TIMER_LOAD);
+#ifdef CONFIG_IPIPE
+	}
+#endif
+
 	timer_tick();
=20
 	write_sequnlock(&xtime_lock);
@@ -270,24 +292,30 @@
 	.handler	=3D integrator_timer_interrupt,
 };
=20
-/*
- * Set up timer interrupt, and return the current time in seconds.
- */
-void __init integrator_time_init(unsigned long reload, unsigned int ctrl=
)
+static inline void set_dec(unsigned long reload)
 {
-	unsigned int timer_ctrl =3D TIMER_CTRL_ENABLE | TIMER_CTRL_PERIODIC;
+	unsigned int ctrl =3D TIMER_CTRL_ENABLE | TIMER_CTRL_IE;
=20
 	timer_reload =3D reload;
-	timer_ctrl |=3D ctrl;
+	timer_interval =3D reload;
=20
-	if (timer_reload > 0x100000) {
+	if (timer_reload >=3D 0x100000) {
 		timer_reload >>=3D 8;
-		timer_ctrl |=3D TIMER_CTRL_DIV256;
-	} else if (timer_reload > 0x010000) {
+		ctrl |=3D TIMER_CTRL_DIV256;
+	} else if (timer_reload >=3D 0x010000) {
 		timer_reload >>=3D 4;
-		timer_ctrl |=3D TIMER_CTRL_DIV16;
+		ctrl |=3D TIMER_CTRL_DIV16;
 	}
=20
+	writel(ctrl, TIMER1_VA_BASE + TIMER_CTRL);
+	writel(timer_reload, TIMER1_VA_BASE + TIMER_LOAD);
+}
+
+/*
+ * Set up timer interrupt, and return the current time in seconds.
+ */
+void __init integrator_time_init(unsigned long reload, unsigned int ctrl=
)
+{
 	/*
 	 * Initialise to a known state (all timers off)
 	 */
@@ -295,12 +323,60 @@
 	writel(0, TIMER1_VA_BASE + TIMER_CTRL);
 	writel(0, TIMER2_VA_BASE + TIMER_CTRL);
=20
-	writel(timer_reload, TIMER1_VA_BASE + TIMER_LOAD);
-	writel(timer_reload, TIMER1_VA_BASE + TIMER_VALUE);
-	writel(timer_ctrl, TIMER1_VA_BASE + TIMER_CTRL);
+	set_dec(reload);
=20
 	/*
 	 * Make irqs happen for the system timer
 	 */
 	setup_irq(IRQ_TIMERINT1, &integrator_timer_irq);
+
+	tscok =3D 1;
 }
+
+#ifdef CONFIG_IPIPE
+
+void __ipipe_mach_acktimer(void)
+{
+	writel(1, TIMER1_VA_BASE + TIMER_INTCLR);
+}
+
+notrace unsigned long long __ipipe_mach_get_tsc(void)
+{
+	unsigned long long result;
+	unsigned long flags;
+
+	local_irq_save_hw_notrace(flags);
+	spin_lock(&timer_lock);
+	result =3D __ipipe_mach_tsc + integrator_getticksoffset();
+	spin_unlock(&timer_lock);
+	local_irq_restore_hw_notrace(flags);
+	return result;
+}
+EXPORT_SYMBOL(__ipipe_mach_get_tsc);
+
+void __ipipe_mach_set_dec(unsigned long reload)
+{
+	unsigned long ticks;
+	unsigned long flags;
+
+	spin_lock_irqsave(&timer_lock, flags);
+	ticks =3D integrator_getticksoffset();
+	__ipipe_mach_tsc +=3D ticks;
+	timer_lxlost +=3D ticks;
+
+	set_dec(reload);
+	spin_unlock_irqrestore(&timer_lock, flags);
+}
+EXPORT_SYMBOL(__ipipe_mach_set_dec);
+
+void __ipipe_mach_release_timer(void)
+{
+       __ipipe_mach_set_dec(__ipipe_mach_ticks_per_jiffy);
+}
+EXPORT_SYMBOL(__ipipe_mach_release_timer);
+
+unsigned long __ipipe_mach_get_dec(void)
+{
+	return readl(TIMER1_VA_BASE + TIMER_VALUE);
+}
+#endif /* CONFIG_IPIPE */
Index: arch/arm/mach-at91/gpio.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- arch/arm/mach-at91/gpio.c	(revision 91)
+++ arch/arm/mach-at91/gpio.c	(working copy)
@@ -21,7 +21,12 @@
 #include <asm/hardware.h>
 #include <asm/arch/at91_pio.h>
 #include <asm/arch/gpio.h>
+#ifdef CONFIG_IPIPE
+#include <asm/irq.h>
=20
+unsigned __ipipe_at91_gpio_banks =3D 0;
+#endif /* CONFIG_IPIPE */
+
 #include "generic.h"
=20
=20
@@ -364,6 +369,9 @@
=20
 static struct irq_chip gpio_irqchip =3D {
 	.name		=3D "GPIO",
+#ifdef CONFIG_IPIPE
+	.ack            =3D gpio_irq_mask,
+#endif
 	.mask		=3D gpio_irq_mask,
 	.unmask		=3D gpio_irq_unmask,
 	.set_type	=3D gpio_irq_type,
@@ -412,6 +420,104 @@
 	/* now it may re-trigger */
 }
=20
+#ifdef CONFIG_IPIPE
+void __ipipe_mach_demux_irq(unsigned irq, struct pt_regs *regs)
+{
+/* CONFIG_AT91_TIMER_HZ is defined only if the AT91 patch is applied. */=

+#ifndef CONFIG_AT91_TIMER_HZ
+	struct irq_desc *desc =3D &irq_desc[irq];
+	unsigned	pin;
+	struct irq_desc	*gpio;
+	void __iomem	*pio;
+	u32		isr;
+
+	pio =3D get_irq_chip_data(irq);
+
+	/* temporarily mask (level sensitive) parent IRQ */
+	desc->chip->ack(irq);
+	for (;;) {
+		/* reading ISR acks the pending (edge triggered) GPIO interrupt */
+		isr =3D __raw_readl(pio + PIO_ISR) & __raw_readl(pio + PIO_IMR);
+		if (!isr)
+			break;
+
+		pin =3D (unsigned) get_irq_data(irq);
+		gpio =3D &irq_desc[pin];
+
+		while (isr) {
+			if (isr & 1) {
+				if (unlikely(gpio->depth)) {
+					/*
+					 * The core ARM interrupt handler lazily disables IRQs so
+					 * another IRQ must be generated before it actually gets
+					 * here to be disabled on the GPIO controller.
+					 */
+					gpio_irq_mask(pin);
+				}
+				else
+					__ipipe_handle_irq(pin, regs);
+			}
+			pin++;
+			gpio++;
+			isr >>=3D 1;
+		}
+	}
+	desc->chip->unmask(irq);
+	/* now it may re-trigger */
+#else /* defined(AT91_TIMER_HZ) */
+	struct irq_desc *desc =3D &irq_desc[irq];
+	unsigned	pin;
+	struct irq_desc	*gpio;
+	struct at91_gpio_bank *bank;
+	void __iomem	*pio;
+	u32		isr;
+
+	bank =3D get_irq_chip_data(irq);
+	pio =3D bank->regbase;
+
+	/* temporarily mask (level sensitive) parent IRQ */
+	desc->chip->ack(irq);
+	for (;;) {
+		/* Reading ISR acks pending (edge triggered) GPIO interrupts.
+		 * When there none are pending, we're finished unless we need
+		 * to process multiple banks (like ID_PIOCDE on sam9263).
+		 */
+		isr =3D __raw_readl(pio + PIO_ISR) & __raw_readl(pio + PIO_IMR);
+		if (!isr) {
+			if (!bank->next)
+				break;
+			bank =3D bank->next;
+			pio =3D bank->regbase;
+			continue;
+		}
+
+		pin =3D bank->chipbase;
+		gpio =3D &irq_desc[pin];
+
+		while (isr) {
+			if (isr & 1) {
+				if (unlikely(gpio->depth)) {
+					/*
+					 * The core ARM interrupt handler lazily disables IRQs so
+					 * another IRQ must be generated before it actually gets
+					 * here to be disabled on the GPIO controller.
+					 */
+					gpio_irq_mask(pin);
+				}
+				else
+					__ipipe_handle_irq(pin, regs);
+			}
+			pin++;
+			gpio++;
+			isr >>=3D 1;
+		}
+	}
+	desc->chip->unmask(irq);
+	/* now it may re-trigger */
+#endif /* defined(AT91_TIMER_HZ) */
+}
+#endif /* CONFIG_IPIPE */
+
 /*----------------------------------------------------------------------=
----*/
=20
 /*
@@ -449,6 +555,9 @@
 		set_irq_chained_handler(id, gpio_irq_handler);
 	}
 	pr_info("AT91: %d gpio irqs in %d banks\n", pin - PIN_BASE, gpio_banks)=
;
+#ifdef CONFIG_IPIPE
+	__ipipe_at91_gpio_banks =3D gpio_banks;
+#endif /* CONFIG_IPIPE */
 }
=20
 /*
Index: arch/arm/mach-at91/Kconfig
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- arch/arm/mach-at91/Kconfig	(revision 91)
+++ arch/arm/mach-at91/Kconfig	(working copy)
@@ -194,6 +194,31 @@
=20
 # ----------------------------------------------------------
=20
+comment "Adeos I-pipe Options"
+
+config IPIPE_AT91_TC
+	depends on IPIPE
+	int "AT91 TC used as time base by Adeos I-pipe"
+	default 0
+	help
+	When Adeos interrupt pipeline is enabled, TC0 is used by default
+	as time base, but you can use TC1 or TC2 by setting this variable to 1
+	or 2. This should only be needed to avoid conflicts with other drivers.=

+
+config IPIPE_AT91_MCK
+	depends on IPIPE
+	int "AT91 Master clock Frequency"
+	default 46080000 if MACH_CSB637
+	default 59904000 if MACH_AT91RM9200EK
+	default 99328000 if MACH_AT91SAM9260EK || MACH_AT91SAM9261EK
+	default 53000000
+	help
+	When Adeos interrupt pipeline is enabled, AT91 timer is based on
+	the AT91 master clock, whose frequency need hence to be known at
+	compilation time.
+
+# ----------------------------------------------------------
+
 comment "AT91 Board Options"
=20
 config MTD_AT91_DATAFLASH_CARD
Index: arch/arm/mach-at91/at91sam9260.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- arch/arm/mach-at91/at91sam9260.c	(revision 91)
+++ arch/arm/mach-at91/at91sam9260.c	(working copy)
@@ -28,6 +28,13 @@
 		.pfn		=3D __phys_to_pfn(AT91_BASE_SYS),
 		.length		=3D SZ_16K,
 		.type		=3D MT_DEVICE,
+#ifdef CONFIG_IPIPE
+	}, {
+		.virtual	=3D AT91_VA_BASE_TCB0,
+		.pfn		=3D __phys_to_pfn(AT91_BASE_TCB0),
+		.length		=3D SZ_16K,
+		.type		=3D MT_DEVICE,
+#endif /* CONFIG_IPIPE */
 	}
 };
=20
@@ -325,6 +332,7 @@
  * The default interrupt priority levels (0 =3D lowest, 7 =3D highest).
  */
 static unsigned int at91sam9260_default_irq_priority[NR_AIC_IRQS] __init=
data =3D {
+#ifndef CONFIG_IPIPE
 	7,	/* Advanced Interrupt Controller */
 	7,	/* System Peripherals */
 	0,	/* Parallel IO Controller A */
@@ -357,6 +365,42 @@
 	0,	/* Advanced Interrupt Controller */
 	0,	/* Advanced Interrupt Controller */
 	0,	/* Advanced Interrupt Controller */
+#else /* CONFIG_IPIPE */
+/* Give the highest priority to TC, since they are used as timer interru=
pt by
+   I-pipe. */
+	7,	/* Advanced Interrupt Controller */
+	7,	/* System Peripherals */
+	0,	/* Parallel IO Controller A */
+	0,	/* Parallel IO Controller B */
+	0,	/* Parallel IO Controller C */
+	0,	/* Analog-to-Digital Converter */
+	6,	/* USART 0 */
+	6,	/* USART 1 */
+	6,	/* USART 2 */
+	0,	/* Multimedia Card Interface */
+	4,	/* USB Device Port */
+	0,	/* Two-Wire Interface */
+	6,	/* Serial Peripheral Interface 0 */
+	6,	/* Serial Peripheral Interface 1 */
+	5,	/* Serial Synchronous Controller */
+	0,
+	0,
+	7,	/* Timer Counter 0 */
+	7,	/* Timer Counter 1 */
+	7,	/* Timer Counter 2 */
+	3,	/* USB Host port */
+	3,	/* Ethernet */
+	0,	/* Image Sensor Interface */
+	6,	/* USART 3 */
+	6,	/* USART 4 */
+	6,	/* USART 5 */
+	7,	/* Timer Counter 3 */
+	7,	/* Timer Counter 4 */
+	7,	/* Timer Counter 5 */
+	0,	/* Advanced Interrupt Controller */
+	0,	/* Advanced Interrupt Controller */
+	0,	/* Advanced Interrupt Controller */
+#endif /*CONFIG_IPIPE */
 };
=20
 void __init at91sam9260_init_interrupts(unsigned int priority[NR_AIC_IRQ=
S])
Index: arch/arm/mach-at91/at91sam9261.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- arch/arm/mach-at91/at91sam9261.c	(revision 91)
+++ arch/arm/mach-at91/at91sam9261.c	(working copy)
@@ -27,7 +27,14 @@
 		.pfn		=3D __phys_to_pfn(AT91_BASE_SYS),
 		.length		=3D SZ_16K,
 		.type		=3D MT_DEVICE,
+#ifdef CONFIG_IPIPE
 	}, {
+		.virtual	=3D AT91_VA_BASE_TCB0,
+		.pfn		=3D __phys_to_pfn(AT91_BASE_TCB0),
+		.length		=3D SZ_16K,
+		.type		=3D MT_DEVICE,
+#endif /* CONFIG_IPIPE */
+	}, {
 		.virtual	=3D AT91_IO_VIRT_BASE - AT91SAM9261_SRAM_SIZE,
 		.pfn		=3D __phys_to_pfn(AT91SAM9261_SRAM_BASE),
 		.length		=3D AT91SAM9261_SRAM_SIZE,
@@ -277,6 +284,7 @@
  * The default interrupt priority levels (0 =3D lowest, 7 =3D highest).
  */
 static unsigned int at91sam9261_default_irq_priority[NR_AIC_IRQS] __init=
data =3D {
+#ifndef CONFIG_IPIPE
 	7,	/* Advanced Interrupt Controller */
 	7,	/* System Peripherals */
 	0,	/* Parallel IO Controller A */
@@ -309,6 +317,42 @@
 	0,	/* Advanced Interrupt Controller */
 	0,	/* Advanced Interrupt Controller */
 	0,	/* Advanced Interrupt Controller */
+#else /* CONFIG_IPIPE */
+/* Give the highest priority to TC, since they are used as timer interru=
pt by
+   I-pipe. */
+	7,	/* Advanced Interrupt Controller */
+	7,	/* System Peripherals */
+	0,	/* Parallel IO Controller A */
+	0,	/* Parallel IO Controller B */
+	0,	/* Parallel IO Controller C */
+	0,
+	6,	/* USART 0 */
+	6,	/* USART 1 */
+	6,	/* USART 2 */
+	0,	/* Multimedia Card Interface */
+	4,	/* USB Device Port */
+	0,	/* Two-Wire Interface */
+	6,	/* Serial Peripheral Interface 0 */
+	6,	/* Serial Peripheral Interface 1 */
+	5,	/* Serial Synchronous Controller 0 */
+	5,	/* Serial Synchronous Controller 1 */
+	5,	/* Serial Synchronous Controller 2 */
+	7,	/* Timer Counter 0 */
+	7,	/* Timer Counter 1 */
+	7,	/* Timer Counter 2 */
+	3,	/* USB Host port */
+	3,	/* LCD Controller */
+	0,
+	0,
+	0,
+	0,
+	0,
+	0,
+	0,
+	0,	/* Advanced Interrupt Controller */
+	0,	/* Advanced Interrupt Controller */
+	0,	/* Advanced Interrupt Controller */
+#endif /*CONFIG_IPIPE */
 };
=20
 void __init at91sam9261_init_interrupts(unsigned int priority[NR_AIC_IRQ=
S])
Index: arch/arm/mach-at91/at91sam9263.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- arch/arm/mach-at91/at91sam9263.c	(revision 91)
+++ arch/arm/mach-at91/at91sam9263.c	(working copy)
@@ -27,7 +27,14 @@
 		.pfn		=3D __phys_to_pfn(AT91_BASE_SYS),
 		.length		=3D SZ_16K,
 		.type		=3D MT_DEVICE,
+#ifdef CONFIG_IPIPE
 	}, {
+		.virtual	=3D AT91_VA_BASE_TCB0,
+		.pfn		=3D __phys_to_pfn(AT91_BASE_TCB0),
+		.length		=3D SZ_16K,
+		.type		=3D MT_DEVICE,
+#endif /* CONFIG_IPIPE */
+	}, {
 		.virtual	=3D AT91_IO_VIRT_BASE - AT91SAM9263_SRAM0_SIZE,
 		.pfn		=3D __phys_to_pfn(AT91SAM9263_SRAM0_BASE),
 		.length		=3D AT91SAM9263_SRAM0_SIZE,
@@ -302,6 +309,7 @@
  * The default interrupt priority levels (0 =3D lowest, 7 =3D highest).
  */
 static unsigned int at91sam9263_default_irq_priority[NR_AIC_IRQS] __init=
data =3D {
+#ifndef CONFIG_IPIPE
 	7,	/* Advanced Interrupt Controller (FIQ) */
 	7,	/* System Peripherals */
 	0,	/* Parallel IO Controller A */
@@ -334,6 +342,42 @@
 	3,	/* USB Host port */
 	0,	/* Advanced Interrupt Controller (IRQ0) */
 	0,	/* Advanced Interrupt Controller (IRQ1) */
+#else /* CONFIG_IPIPE */
+/* Give the highest priority to TC, since they are used as timer interru=
pt by
+   I-pipe. */
+	7,	/* Advanced Interrupt Controller (FIQ) */
+	6,	/* System Peripherals */
+	0,	/* Parallel IO Controller A */
+	0,	/* Parallel IO Controller B */
+	0,	/* Parallel IO Controller C, D and E */
+	0,
+	0,
+	5,	/* USART 0 */
+	5,	/* USART 1 */
+	5,	/* USART 2 */
+	0,	/* Multimedia Card Interface 0 */
+	0,	/* Multimedia Card Interface 1 */
+	3,	/* CAN */
+	0,	/* Two-Wire Interface */
+	5,	/* Serial Peripheral Interface 0 */
+	5,	/* Serial Peripheral Interface 1 */
+	4,	/* Serial Synchronous Controller 0 */
+	4,	/* Serial Synchronous Controller 1 */
+	5,	/* AC97 Controller */
+	7,	/* Timer Counter 0, 1 and 2 */
+	0,	/* Pulse Width Modulation Controller */
+	2,	/* Ethernet */
+	0,
+	0,	/* 2D Graphic Engine */
+	2,	/* USB Device Port */
+	0,	/* Image Sensor Interface */
+	2,	/* LDC Controller */
+	0,	/* DMA Controller */
+	0,
+	2,	/* USB Host port */
+	0,	/* Advanced Interrupt Controller (IRQ0) */
+	0,	/* Advanced Interrupt Controller (IRQ1) */
+#endif /*CONFIG_IPIPE */
 };
=20
 void __init at91sam9263_init_interrupts(unsigned int priority[NR_AIC_IRQ=
S])
Index: arch/arm/mach-at91/at91rm9200.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- arch/arm/mach-at91/at91rm9200.c	(revision 91)
+++ arch/arm/mach-at91/at91rm9200.c	(working copy)
@@ -32,7 +32,14 @@
 		.pfn		=3D __phys_to_pfn(AT91RM9200_BASE_EMAC),
 		.length		=3D SZ_16K,
 		.type		=3D MT_DEVICE,
+#ifdef CONFIG_IPIPE
 	}, {
+		.virtual	=3D AT91_VA_BASE_TCB0,
+		.pfn		=3D __phys_to_pfn(AT91_BASE_TCB0),
+		.length		=3D SZ_16K,
+		.type		=3D MT_DEVICE,
+#endif /* CONFIG_IPIPE */
+        }, {
 		.virtual	=3D AT91_IO_VIRT_BASE - AT91RM9200_SRAM_SIZE,
 		.pfn		=3D __phys_to_pfn(AT91RM9200_SRAM_BASE),
 		.length		=3D AT91RM9200_SRAM_SIZE,
@@ -299,6 +306,7 @@
  * The default interrupt priority levels (0 =3D lowest, 7 =3D highest).
  */
 static unsigned int at91rm9200_default_irq_priority[NR_AIC_IRQS] __initd=
ata =3D {
+#ifndef CONFIG_IPIPE
 	7,	/* Advanced Interrupt Controller (FIQ) */
 	7,	/* System Peripherals */
 	0,	/* Parallel IO Controller A */
@@ -331,6 +339,42 @@
 	0,	/* Advanced Interrupt Controller (IRQ4) */
 	0,	/* Advanced Interrupt Controller (IRQ5) */
 	0	/* Advanced Interrupt Controller (IRQ6) */
+#else /* CONFIG_IPIPE */
+/* Give the highest priority to TC, since they are used as timer interru=
pt by
+   I-pipe. */
+	7,	/* Advanced Interrupt Controller */
+	6,	/* System Peripheral */
+	0,	/* Parallel IO Controller A */
+	0,	/* Parallel IO Controller B */
+	0,	/* Parallel IO Controller C */
+	0,	/* Parallel IO Controller D */
+	5,	/* USART 0 */
+	5,	/* USART 1 */
+	5,	/* USART 2 */
+	5,	/* USART 3 */
+	0,	/* Multimedia Card Interface */
+	3,	/* USB Device Port */
+	0,	/* Two-Wire Interface */
+	5,	/* Serial Peripheral Interface */
+	4,	/* Serial Synchronous Controller */
+	4,	/* Serial Synchronous Controller */
+	4,	/* Serial Synchronous Controller */
+	7,	/* Timer Counter 0 */
+	7,	/* Timer Counter 1 */
+	7,	/* Timer Counter 2 */
+	0,	/* Timer Counter 3 */
+	0,	/* Timer Counter 4 */
+	0,	/* Timer Counter 5 */
+	2,	/* USB Host port */
+	2,	/* Ethernet MAC */
+	0,	/* Advanced Interrupt Controller */
+	0,	/* Advanced Interrupt Controller */
+	0,	/* Advanced Interrupt Controller */
+	0,	/* Advanced Interrupt Controller */
+	0,	/* Advanced Interrupt Controller */
+	0,	/* Advanced Interrupt Controller */
+	0	/* Advanced Interrupt Controller */
+#endif /*CONFIG_IPIPE */
 };
=20
 void __init at91rm9200_init_interrupts(unsigned int priority[NR_AIC_IRQS=
])
Index: arch/arm/mach-at91/irq.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- arch/arm/mach-at91/irq.c	(revision 91)
+++ arch/arm/mach-at91/irq.c	(working copy)
@@ -122,6 +122,9 @@
 	.name		=3D "AIC",
 	.ack		=3D at91_aic_mask_irq,
 	.mask		=3D at91_aic_mask_irq,
+#ifdef CONFIG_IPIPE
+	.mask_ack       =3D at91_aic_mask_irq,
+#endif /* CONFIG_IPIPE */
 	.unmask		=3D at91_aic_unmask_irq,
 	.set_type	=3D at91_aic_set_type,
 	.set_wake	=3D at91_aic_set_wake,
Index: arch/arm/mach-at91/Makefile
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- arch/arm/mach-at91/Makefile	(revision 91)
+++ arch/arm/mach-at91/Makefile	(working copy)
@@ -60,3 +60,13 @@
 ifeq ($(CONFIG_PM_DEBUG),y)
 CFLAGS_pm.o +=3D -DDEBUG
 endif
+
+ifeq ($(CONFIG_IPIPE),y)
+obj-y :=3D $(filter-out at91rm9200_time.o at91sam926x_time.o at91x40_tim=
e.o, $(obj-y))
+obj-$(CONFIG_ARCH_AT91RM9200)   +=3D at91_ipipe_time.o
+obj-$(CONFIG_ARCH_AT91SAM9260)  +=3D at91_ipipe_time.o
+obj-$(CONFIG_ARCH_AT91SAM9261)  +=3D at91_ipipe_time.o
+obj-$(CONFIG_ARCH_AT91SAM9263)	+=3D at91_ipipe_time.o
+obj-$(CONFIG_ARCH_AT91SAM9RL)	+=3D at91_ipipe_time.o
+obj-$(CONFIG_ARCH_AT91X40)	+=3D at91_ipipe_time.o
+endif
Index: arch/arm/mach-at91/at91sam9rl.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- arch/arm/mach-at91/at91sam9rl.c	(revision 91)
+++ arch/arm/mach-at91/at91sam9rl.c	(working copy)
@@ -27,6 +27,13 @@
 		.pfn		=3D __phys_to_pfn(AT91_BASE_SYS),
 		.length		=3D SZ_16K,
 		.type		=3D MT_DEVICE,
+#ifdef CONFIG_IPIPE
+	}, {
+		.virtual	=3D AT91_VA_BASE_TCB0,
+		.pfn		=3D __phys_to_pfn(AT91_BASE_TCB0),
+		.length		=3D SZ_16K,
+		.type		=3D MT_DEVICE,
+#endif /* CONFIG_IPIPE */
 	},
 };
=20
@@ -294,6 +301,7 @@
  * The default interrupt priority levels (0 =3D lowest, 7 =3D highest).
  */
 static unsigned int at91sam9rl_default_irq_priority[NR_AIC_IRQS] __initd=
ata =3D {
+#ifndef CONFIG_IPIPE
 	7,	/* Advanced Interrupt Controller */
 	7,	/* System Peripherals */
 	1,	/* Parallel IO Controller A */
@@ -326,6 +334,42 @@
 	0,
 	0,
 	0,	/* Advanced Interrupt Controller */
+#else /* CONFIG_IPIPE */
+/* Give the highest priority to TC, since they are used as timer interru=
pt by
+   I-pipe. */
+	7,	/* Advanced Interrupt Controller */
+	6,	/* System Peripherals */
+	1,	/* Parallel IO Controller A */
+	1,	/* Parallel IO Controller B */
+	1,	/* Parallel IO Controller C */
+	1,	/* Parallel IO Controller D */
+	4,	/* USART 0 */
+	4,	/* USART 1 */
+	4,	/* USART 2 */
+	4,	/* USART 3 */
+	0,	/* Multimedia Card Interface */
+	5,	/* Two-Wire Interface 0 */
+	5,	/* Two-Wire Interface 1 */
+	4,	/* Serial Peripheral Interface */
+	3,	/* Serial Synchronous Controller 0 */
+	3,	/* Serial Synchronous Controller 1 */
+	7,	/* Timer Counter 0 */
+	7,	/* Timer Counter 1 */
+	7,	/* Timer Counter 2 */
+	0,
+	0,	/* Touch Screen Controller */
+	0,	/* DMA Controller */
+	2,	/* USB Device High speed port */
+	2,	/* LCD Controller */
+	5,	/* AC97 Controller */
+	0,
+	0,
+	0,
+	0,
+	0,
+	0,
+	0,	/* Advanced Interrupt Controller */
+#endif /*CONFIG_IPIPE */
 };
=20
 void __init at91sam9rl_init_interrupts(unsigned int priority[NR_AIC_IRQS=
])
Index: arch/arm/mach-at91/at91_ipipe_time.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- arch/arm/mach-at91/at91_ipipe_time.c	(revision 0)
+++ arch/arm/mach-at91/at91_ipipe_time.c	(revision 0)
@@ -0,0 +1,396 @@
+/*
+ * linux/arch/arm/mach-at91/at91_ipipe_time.c
+ *
+ * Copyright (C) 2007 Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org=
=2Enet>
+ *
+ * Adaptation to AT91SAM926x:
+ * Copyright (C) 2007 Gregory CLEMENT, Adeneo
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/kernel.h>
+#include <linux/clockchips.h>
+
+#include <asm/hardware.h>
+#include <asm/io.h>
+#include <asm/mach/time.h>
+
+#include <asm/arch/at91_st.h>
+
+#include <linux/clk.h>
+#include <linux/stringify.h>
+#include <linux/err.h>
+#include <linux/console.h>
+#include <linux/module.h>
+#include <asm/arch/at91_tc.h>
+#include <asm/arch/at91_pit.h>
+#include "clock.h"
+
+#if defined(CONFIG_ARCH_AT91RM9200)
+#define AT91_ID_TC0 AT91RM9200_ID_TC0
+#define AT91_ID_TC1 AT91RM9200_ID_TC1
+#define AT91_ID_TC2 AT91RM9200_ID_TC2
+#elif defined(CONFIG_ARCH_AT91SAM9260)
+#define AT91_ID_TC0 AT91SAM9260_ID_TC0
+#define AT91_ID_TC1 AT91SAM9260_ID_TC1
+#define AT91_ID_TC2 AT91SAM9260_ID_TC2
+#elif defined(CONFIG_ARCH_AT91SAM9261)
+#define AT91_ID_TC0 AT91SAM9261_ID_TC0
+#define AT91_ID_TC1 AT91SAM9261_ID_TC1
+#define AT91_ID_TC2 AT91SAM9261_ID_TC2
+#elif defined(CONFIG_ARCH_AT91SAM9263)
+#define AT91_ID_TC0 AT91SAM9263_ID_TCB
+#define AT91_ID_TC1 AT91SAM9263_ID_TCB
+#define AT91_ID_TC2 AT91SAM9263_ID_TCB
+#elif defined(CONFIG_ARCH_AT91SAM9RL)
+#define AT91_ID_TC0 AT91SAM9RL_ID_TC0
+#define AT91_ID_TC1 AT91SAM9RL_ID_TC1
+#define AT91_ID_TC2 AT91SAM9RL_ID_TC2
+#elif defined(CONFIG_ARCH_AT91X40)
+#define AT91_ID_TC0 AT91X40_ID_TC0
+#define AT91_ID_TC1 AT91X40_ID_TC1
+#define AT91_ID_TC2 AT91X40_ID_TC2
+#else
+#error "AT91 processor unsupported by Adeos"
+#endif
+
+#if (CONFIG_IPIPE_AT91_TC=3D=3D0)
+#   define KERNEL_TIMER_IRQ_NUM AT91_ID_TC0
+#elif (CONFIG_IPIPE_AT91_TC=3D=3D1)
+#   define KERNEL_TIMER_IRQ_NUM AT91_ID_TC1
+#elif (CONFIG_IPIPE_AT91_TC=3D=3D2)
+#   define KERNEL_TIMER_IRQ_NUM AT91_ID_TC2
+#else
+#error IPIPE_AT91_TC must be 0, 1 or 2.
+#endif
+
+#ifdef CONFIG_NO_IDLE_HZ
+#error "dynamic tick timer not yet supported with IPIPE"
+#endif /* CONFIG_NO_IDLE_HZ */
+
+#define TCNXCNS(timer,v) ((v) << ((timer)<<1))
+#define AT91_TC_REG_MASK (0xffff)
+
+static unsigned long last_CV;
+
+union tsc_reg {
+#ifdef __BIG_ENDIAN
+	struct {
+		unsigned long high;
+		unsigned short mid;
+		unsigned short low;
+	};
+#else /* __LITTLE_ENDIAN */
+	struct {
+		unsigned short low;
+		unsigned short mid;
+		unsigned long high;
+	};
+#endif /* __LITTLE_ENDIAN */
+	unsigned long long full;
+};
+static struct clock_event_device clkevt;
+
+#ifdef CONFIG_SMP
+static union tsc_reg tsc[NR_CPUS];
+
+void __ipipe_mach_get_tscinfo(struct __ipipe_tscinfo *info)
+{
+	info->type =3D IPIPE_TSC_TYPE_NONE;
+}
+
+#else /* !CONFIG_SMP */
+static union tsc_reg *tsc;
+
+void __ipipe_mach_get_tscinfo(struct __ipipe_tscinfo *info)
+{
+	info->type =3D IPIPE_TSC_TYPE_FREERUNNING;
+	info->u.fr.counter =3D
+		(unsigned *)
+		(AT91_BASE_TCB0 + 0x40 * CONFIG_IPIPE_AT91_TC + AT91_TC_CV);
+	info->u.fr.mask =3D AT91_TC_REG_MASK;
+	info->u.fr.tsc =3D &tsc->full;
+}
+#endif /* !CONFIG_SMP */
+
+static inline unsigned int at91_tc_read(unsigned int reg_offset)
+{
+	unsigned long addr =3D
+		(AT91_VA_BASE_TCB0 + 0x40 * CONFIG_IPIPE_AT91_TC);
+
+	return readl((void __iomem *)(addr + reg_offset));
+}
+
+static inline void at91_tc_write(unsigned int reg_offset, unsigned long =
value)
+{
+	unsigned long addr =3D
+		(AT91_VA_BASE_TCB0 + 0x40 * CONFIG_IPIPE_AT91_TC);
+
+	writel(value, (void __iomem *)(addr + reg_offset));
+}
+
+#define read_CV() at91_tc_read(AT91_TC_CV)
+#define read_RC() at91_tc_read(AT91_TC_RC)
+#define write_RC(value) at91_tc_write(AT91_TC_RC, value)
+
+int __ipipe_mach_timerint =3D KERNEL_TIMER_IRQ_NUM;
+EXPORT_SYMBOL(__ipipe_mach_timerint);
+
+int __ipipe_mach_timerstolen =3D 0;
+EXPORT_SYMBOL(__ipipe_mach_timerstolen);
+
+unsigned int __ipipe_mach_ticks_per_jiffy =3D LATCH;
+EXPORT_SYMBOL(__ipipe_mach_ticks_per_jiffy);
+
+static int at91_timer_initialized;
+
+/*
+ * IRQ handler for the timer.
+ */
+static irqreturn_t at91_timer_interrupt(int irq, void *dev_id)
+{
+	/*
+	 * - if Linux is running under ipipe, but it still has the control over=

+	 *   the timer (no Xenomai for example), then reprogram the timer (ipip=
e
+	 *   has already acked it)
+	 * - if some other domain has taken over the timer, then do nothing
+	 *   (ipipe has acked it, and the other domain has reprogramed it)
+	 */
+
+	write_seqlock(&xtime_lock);
+
+	while (((read_CV() - last_CV) & AT91_TC_REG_MASK) >=3D LATCH) {
+		clkevt.event_handler(&clkevt);
+		last_CV =3D (last_CV + LATCH) & AT91_TC_REG_MASK;
+	}
+	if (!__ipipe_mach_timerstolen)
+		write_RC((last_CV + LATCH) & AT91_TC_REG_MASK);
+
+	write_sequnlock(&xtime_lock);
+
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t at91_bad_freq(int irq, void *dev_id)
+{
+	static int ticks =3D 0;
+
+	if (++ticks !=3D HZ * 120) {
+		if (!console_drivers || try_acquire_console_sem())
+			return at91_timer_interrupt(irq, dev_id);
+=09
+		release_console_sem();
+	}
+
+	panic("AT91 clock rate incorrectly set.\n"
+	      "Please recompile with IPIPE_AT91_MCK set to %lu Hz.",
+	      clk_get_rate(clk_get(NULL, "mck")));
+}
+
+static struct irqaction at91_timer_irq =3D {
+	.name		=3D "at91_tick",
+	.flags		=3D IRQF_DISABLED | IRQF_TIMER,
+	.handler	=3D &at91_timer_interrupt
+};
+
+void __ipipe_mach_acktimer(void)
+{
+	union tsc_reg *local_tsc;
+	unsigned short stamp;
+	unsigned long flags;
+
+	at91_tc_read(AT91_TC_SR);
+
+	local_irq_save_hw(flags);
+	local_tsc =3D &tsc[ipipe_processor_id()];
+	stamp =3D read_CV();
+	if (unlikely(stamp < local_tsc->low))
+		local_tsc->full +=3D AT91_TC_REG_MASK + 1;
+	local_tsc->low =3D stamp;
+	local_irq_restore_hw(flags);
+}
+
+notrace unsigned long long __ipipe_mach_get_tsc(void)
+{
+	if (likely(at91_timer_initialized)) {
+		union tsc_reg *local_tsc, result;
+		unsigned long stamp;
+
+		local_tsc =3D &tsc[ipipe_processor_id()];
+
+		__asm__ ("ldmia %1, %M0\n"
+			 : "=3Dr"(result.full), "+&r"(local_tsc)
+			 : "m"(*local_tsc));
+		barrier();
+		stamp =3D read_CV();
+		if (unlikely(stamp < result.low))
+			result.full +=3D AT91_TC_REG_MASK + 1;
+		result.low =3D stamp;
+		return result.full;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL(__ipipe_mach_get_tsc);
+
+static struct clocksource clksrc =3D {
+	.name   =3D "at91_tc" __stringify(CONFIG_IPIPE_AT91_TC),
+	.rating =3D 250,
+	.read   =3D __ipipe_mach_get_tsc,
+	.mask   =3D CLOCKSOURCE_MASK(64),
+	.shift  =3D 20,
+	.flags  =3D CLOCK_SOURCE_IS_CONTINUOUS,
+};
+
+static void
+at91_tc_clkevt_mode(enum clock_event_mode mode, struct clock_event_devic=
e *dev)
+{
+	/* Disable the channel */
+	at91_tc_write(AT91_TC_CCR, AT91_TC_CLKDIS);
+
+	/* Disable all interrupts. */
+	at91_tc_write(AT91_TC_IDR, ~0ul);=09
+
+	if (mode =3D=3D CLOCK_EVT_MODE_PERIODIC) {
+		unsigned long v;
+
+		/* No Sync. */
+		at91_tc_write(AT91_TC_BCR, 0);
+
+		/* program NO signal on XCN */
+		v =3D readl((void __iomem *) (AT91_VA_BASE_TCB0 + AT91_TC_BMR));
+		v &=3D ~TCNXCNS(CONFIG_IPIPE_AT91_TC, 3);
+		v |=3D TCNXCNS(CONFIG_IPIPE_AT91_TC, 1); /* AT91_TC_TCNXCNS_NONE */
+		writel(v, (void __iomem *) (AT91_VA_BASE_TCB0 + AT91_TC_BMR));
+
+		/* Select TIMER_CLOCK3 (MCLK/32) as input frequency for TC. */
+		at91_tc_write(AT91_TC_CMR, AT91_TC_TIMER_CLOCK3);
+
+		/* Load the TC register C. */
+		last_CV =3D 0;
+		write_RC(LATCH);
+
+		/* Enable CPCS interrupt. */
+		at91_tc_write(AT91_TC_IER, AT91_TC_CPCS);
+
+		/* Enable the channel. */
+		at91_tc_write(AT91_TC_CCR, AT91_TC_CLKEN | AT91_TC_SWTRG);
+	}
+}
+
+/*
+ * Reprogram the timer
+ */
+void __ipipe_mach_set_dec(unsigned long delay)
+{
+	unsigned long flags;
+
+	if (delay > 2) {
+		local_irq_save_hw(flags);
+		write_RC((read_CV() + delay) & AT91_TC_REG_MASK);
+		local_irq_restore_hw(flags);
+	} else
+		ipipe_trigger_irq(KERNEL_TIMER_IRQ_NUM);
+}
+EXPORT_SYMBOL(__ipipe_mach_set_dec);
+
+int __ipipe_check_tickdev(const char *devname)
+{
+	return !strcmp(devname, clkevt.name);
+}
+
+static struct clock_event_device clkevt =3D {
+	.name		=3D "at91_tc" __stringify(CONFIG_IPIPE_AT91_TC),
+	.features	=3D CLOCK_EVT_FEAT_PERIODIC,
+	.shift		=3D 32,
+	.rating		=3D 250,
+	.cpumask	=3D CPU_MASK_CPU0,
+	.set_mode	=3D at91_tc_clkevt_mode,
+};
+
+void __ipipe_mach_release_timer(void)
+{
+	__ipipe_mach_set_dec(__ipipe_mach_ticks_per_jiffy);
+}
+EXPORT_SYMBOL(__ipipe_mach_release_timer);
+
+unsigned long __ipipe_mach_get_dec(void)
+{
+	return (read_RC() - read_CV()) & AT91_TC_REG_MASK;
+}
+
+static struct clk *tc, local_tc =3D {
+#ifndef CONFIG_ARCH_AT91SAM9263
+	.name		=3D "tc" __stringify(CONFIG_IPIPE_AT91_TC) "_clk",
+#else
+	/* at91sam9263 only has a single TCB clock. */
+	.name		=3D "tcb_clk",
+#endif
+	.users          =3D 0,
+	.type		=3D CLK_TYPE_PERIPHERAL,
+	.pmc_mask       =3D 1 << (KERNEL_TIMER_IRQ_NUM),
+};
+
+void __init at91_timer_init(void)
+{
+	/* Disable (boot loader) timer interrupts. */
+#if defined(CONFIG_ARCH_AT91RM9200)
+	at91_sys_write(AT91_ST_IDR, AT91_ST_PITS | AT91_ST_WDOVF | AT91_ST_RTTI=
NC | AT91_ST_ALMS);
+	(void) at91_sys_read(AT91_ST_SR);	/* Clear any pending interrupts */=09
+#elif defined(CONFIG_ARCH_AT91SAM9260) || defined(CONFIG_ARCH_AT91SAM926=
1) \
+	|| defined(CONFIG_ARCH_AT91SAM9263) || defined(CONFIG_ARCH_AT91SAM9RL)
+	at91_sys_write(AT91_PIT_MR, 0);
+
+	/* Clear any pending interrupts */
+	(void) at91_sys_read(AT91_PIT_PIVR);
+#endif /* CONFIG_ARCH_AT91SAM926x */
+
+	if (clk_get_rate(clk_get(NULL, "mck")) !=3D CONFIG_IPIPE_AT91_MCK)
+		at91_timer_irq.handler =3D &at91_bad_freq;
+
+	tc =3D clk_get(NULL, local_tc.name);
+	if (IS_ERR(tc)) {
+		tc =3D &local_tc;
+		clk_register(tc);
+	}
+	clk_enable(tc);
+
+	/* Set up the interrupt. */
+	setup_irq(KERNEL_TIMER_IRQ_NUM, &at91_timer_irq);
+
+#ifndef CONFIG_SMP
+	tsc =3D (union tsc_reg *) __ipipe_tsc_area;
+	barrier();
+#endif /* CONFIG_SMP */
+
+	at91_timer_initialized =3D 1;
+
+	clkevt.mult =3D div_sc(CLOCK_TICK_RATE, NSEC_PER_SEC, clkevt.shift);
+	clkevt.max_delta_ns =3D clockevent_delta2ns(AT91_TC_REG_MASK, &clkevt);=

+	clkevt.min_delta_ns =3D 0;
+	clkevt.cpumask =3D cpumask_of_cpu(0);
+	clockevents_register_device(&clkevt);
+
+	clksrc.mult =3D clocksource_hz2mult(CLOCK_TICK_RATE, clksrc.shift);
+	clocksource_register(&clksrc);
+}
+
+#ifdef CONFIG_ARCH_AT91RM9200
+struct sys_timer at91rm9200_timer =3D {
+#elif defined(CONFIG_ARCH_AT91SAM9260) || defined(CONFIG_ARCH_AT91SAM926=
1) \
+	|| defined(CONFIG_ARCH_AT91SAM9263) || defined(CONFIG_ARCH_AT91SAM9RL)
+struct sys_timer at91sam926x_timer =3D {
+#elif defined(CONFIG_ARCH_AT91X40)
+struct sys_timer at91x40_timer =3D {
+#else
+#error "Unknown machine"
+#endif
+	.init		=3D at91_timer_init,
+	.suspend	=3D NULL,
+	.resume		=3D NULL,
+};
Index: arch/arm/mach-pxa/leds-idp.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- arch/arm/mach-pxa/leds-idp.c	(revision 91)
+++ arch/arm/mach-pxa/leds-idp.c	(working copy)
@@ -13,6 +13,7 @@
=20
=20
 #include <linux/init.h>
+#include <linux/ipipe_base.h>
=20
 #include <asm/hardware.h>
 #include <asm/leds.h>
Index: arch/arm/mach-pxa/leds-trizeps4.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- arch/arm/mach-pxa/leds-trizeps4.c	(revision 91)
+++ arch/arm/mach-pxa/leds-trizeps4.c	(working copy)
@@ -11,6 +11,7 @@
  */
=20
 #include <linux/init.h>
+#include <linux/ipipe_base.h>
=20
 #include <asm/hardware.h>
 #include <asm/system.h>
Index: arch/arm/mach-pxa/irq.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- arch/arm/mach-pxa/irq.c	(revision 91)
+++ arch/arm/mach-pxa/irq.c	(working copy)
@@ -248,6 +248,38 @@
 	} while (loop);
 }
=20
+#ifdef CONFIG_IPIPE
+void __ipipe_mach_demux_irq(unsigned irq, struct pt_regs *regs)
+{
+	struct irq_desc *desc_unused =3D irq_desc + irq;
+	unsigned irq_unused =3D irq;
+	unsigned int i, mask[4];
+	int loop;
+
+	do {
+		loop =3D 0;
+
+		mask[0] =3D GEDR0 & ~3;
+		mask[1] =3D GEDR1;
+		mask[2] =3D GEDR2;
+		mask[3] =3D GEDR3;
+		i =3D 4;
+		for (; i; i--) {
+			loop |=3D mask[i - 1];
+			while (mask[i - 1]) {
+				irq =3D fls(mask[i - 1]) - 1;
+				mask[i - 1] &=3D ~(1 << irq);
+				irq =3D IRQ_GPIO((i - 1) * 32 + irq);
+
+				__ipipe_handle_irq(irq, regs);
+			}
+		}
+	} while (loop);
+
+	desc_unused->chip->unmask(irq_unused);
+}
+#endif /* CONFIG_IPIPE */
+
 static void pxa_ack_muxed_gpio(unsigned int irq)
 {
 	int gpio =3D irq - IRQ_GPIO(2) + 2;
Index: arch/arm/mach-pxa/time.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- arch/arm/mach-pxa/time.c	(revision 91)
+++ arch/arm/mach-pxa/time.c	(working copy)
@@ -25,6 +25,58 @@
 #include <asm/arch/pxa-regs.h>
 #include <asm/mach-types.h>
=20
+#ifdef CONFIG_IPIPE
+#ifdef CONFIG_NO_IDLE_HZ
+#error "dynamic tick timer not yet supported with IPIPE"
+#endif /* CONFIG_NO_IDLE_HZ */
+int __ipipe_mach_timerint =3D IRQ_OST0;
+EXPORT_SYMBOL(__ipipe_mach_timerint);
+
+int __ipipe_mach_timerstolen =3D 0;
+EXPORT_SYMBOL(__ipipe_mach_timerstolen);
+
+unsigned int __ipipe_mach_ticks_per_jiffy =3D LATCH;
+EXPORT_SYMBOL(__ipipe_mach_ticks_per_jiffy);
+
+static int pxa_timer_initialized;
+static unsigned long next_jiffy_time;
+
+union tsc_reg {
+#ifdef __BIG_ENDIAN
+	struct {
+		unsigned long high;
+		unsigned long low;
+	};
+#else /* __LITTLE_ENDIAN */
+	struct {
+		unsigned long low;
+		unsigned long high;
+	};
+#endif /* __LITTLE_ENDIAN */
+	unsigned long long full;
+};
+
+#ifdef CONFIG_SMP
+static union tsc_reg tsc[NR_CPUS];
+
+void __ipipe_mach_get_tscinfo(struct __ipipe_tscinfo *info)
+{
+	info->type =3D IPIPE_TSC_TYPE_NONE;
+}
+
+#else /* !CONFIG_SMP */
+static union tsc_reg *tsc;
+
+void __ipipe_mach_get_tscinfo(struct __ipipe_tscinfo *info)
+{
+	info->type =3D IPIPE_TSC_TYPE_FREERUNNING;
+	info->u.fr.counter =3D (unsigned *) 0x40A00010;
+	info->u.fr.mask =3D 0xffffffff;
+	info->u.fr.tsc =3D &tsc->full;
+}
+#endif /* !CONFIG_SMP */
+#endif /* CONFIG_IPIPE */
+
 /*
  * This is PXA's sched_clock implementation. This has a resolution
  * of at least 308 ns and a maximum value of 208 days.
@@ -67,8 +119,10 @@
=20
 	if (c->mode =3D=3D CLOCK_EVT_MODE_ONESHOT) {
 		/* Disarm the compare/match, signal the event. */
+#ifndef CONFIG_IPIPE
 		OIER &=3D ~OIER_E0;
 		OSSR =3D OSSR_M0;
+#endif /* !CONFIG_IPIPE */
 		c->event_handler(c);
 	} else if (c->mode =3D=3D CLOCK_EVT_MODE_PERIODIC) {
 		/* Call the event handler as many times as necessary
@@ -102,7 +156,14 @@
 	 */
 #define MIN_OSCR_DELTA 16
 		do {
+#ifndef CONFIG_IPIPE
 			OSSR =3D OSSR_M0;
+#else /* CONFIG_IPIPE */
+			next_jiffy_time +=3D LATCH;
+			if (__ipipe_mach_timerstolen)
+				next_match =3D next_jiffy_time;
+			else
+#endif /* !CONFIG_IPIPE */
 			next_match =3D (OSMR0 +=3D LATCH);
 			c->event_handler(c);
 		} while (((signed long)(next_match - OSCR) <=3D MIN_OSCR_DELTA)
@@ -138,6 +199,9 @@
 		OSSR =3D OSSR_M0;
 		OIER |=3D OIER_E0;
 		OSMR0 =3D OSCR + LATCH;
+#ifdef CONFIG_IPIPE
+		next_jiffy_time =3D OSMR0;
+#endif /* CONFIG_IPIPE */
 		raw_local_irq_restore(irqflags);
 		break;
=20
@@ -172,6 +236,13 @@
 	.set_mode	=3D pxa_osmr0_set_mode,
 };
=20
+#ifdef CONFIG_IPIPE
+int __ipipe_check_tickdev(const char *devname)
+{
+	return !strcmp(devname, ckevt_pxa_osmr0.name);
+}
+#endif /* CONFIG_IPIPE */
+
 static cycle_t pxa_read_oscr(void)
 {
 	return OSCR;
@@ -221,6 +292,15 @@
=20
 	setup_irq(IRQ_OST0, &pxa_ost0_irq);
=20
+#ifdef CONFIG_IPIPE
+#ifndef CONFIG_SMP
+	tsc =3D (union tsc_reg *) __ipipe_tsc_area;
+	barrier();
+#endif /* CONFIG_SMP */
+
+	pxa_timer_initialized =3D 1;
+#endif /* CONFIG_IPIPE */
+
 	clocksource_register(&cksrc_pxa_oscr0);
 	clockevents_register_device(&ckevt_pxa_osmr0);
 }
@@ -252,6 +332,7 @@
 	 * which is a handy value to restore to OSCR0.
 	 */
 	OSCR =3D OSMR0 - LATCH;
+=09
 }
 #else
 #define pxa_timer_suspend NULL
@@ -263,3 +344,77 @@
 	.suspend	=3D pxa_timer_suspend,
 	.resume		=3D pxa_timer_resume,
 };
+
+#ifdef CONFIG_IPIPE
+void __ipipe_mach_acktimer(void)
+{
+	union tsc_reg *local_tsc;
+	unsigned long stamp, flags;
+
+	OSSR =3D OSSR_M0;  /* Clear match on timer 0 */
+
+	local_irq_save_hw(flags);
+	local_tsc =3D &tsc[ipipe_processor_id()];
+	stamp =3D OSCR;
+	if (unlikely(stamp < local_tsc->low))
+		/* 32 bit counter wrapped, increment high word. */
+		local_tsc->high++;
+	local_tsc->low =3D stamp;
+	local_irq_restore_hw(flags);
+}
+
+notrace unsigned long long __ipipe_mach_get_tsc(void)
+{
+	if (likely(pxa_timer_initialized)) {
+		union tsc_reg *local_tsc, result;
+		unsigned long stamp;
+
+		local_tsc =3D &tsc[ipipe_processor_id()];
+
+		__asm__ ("ldmia %1, %M0\n"
+			 : "=3Dr"(result.full), "+&r"(local_tsc)
+			 : "m"(*local_tsc));
+		barrier();
+		stamp =3D OSCR;
+		if (unlikely(stamp < result.low))
+			/* 32 bit counter wrapped, increment high word. */
+			result.high++;
+		result.low =3D stamp;
+
+		return result.full;
+	}
+
+        return 0;
+}
+EXPORT_SYMBOL(__ipipe_mach_get_tsc);
+
+/*
+ * Reprogram the timer
+ */
+
+void __ipipe_mach_set_dec(unsigned long delay)
+{
+	if (delay > 16) {
+		unsigned long flags;
+
+		local_irq_save_hw(flags);
+		OSMR0 =3D delay + OSCR;
+		local_irq_restore_hw(flags);
+	} else
+		ipipe_trigger_irq(IRQ_OST0);
+}
+EXPORT_SYMBOL(__ipipe_mach_set_dec);
+
+void __ipipe_mach_release_timer(void)
+{
+	pxa_osmr0_set_mode(ckevt_pxa_osmr0.mode, &ckevt_pxa_osmr0);
+	if (ckevt_pxa_osmr0.mode =3D=3D CLOCK_EVT_MODE_ONESHOT)
+		pxa_osmr0_set_next_event(LATCH, &ckevt_pxa_osmr0);
+}
+EXPORT_SYMBOL(__ipipe_mach_release_timer);
+
+unsigned long __ipipe_mach_get_dec(void)
+{
+	return OSMR0 - OSCR;
+}
+#endif /* CONFIG_IPIPE */
Index: arch/arm/mach-pxa/leds-lubbock.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- arch/arm/mach-pxa/leds-lubbock.c	(revision 91)
+++ arch/arm/mach-pxa/leds-lubbock.c	(working copy)
@@ -12,6 +12,7 @@
  */
=20
 #include <linux/init.h>
+#include <linux/ipipe_base.h>
=20
 #include <asm/hardware.h>
 #include <asm/leds.h>
Index: arch/arm/mach-pxa/leds-mainstone.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- arch/arm/mach-pxa/leds-mainstone.c	(revision 91)
+++ arch/arm/mach-pxa/leds-mainstone.c	(working copy)
@@ -11,6 +11,7 @@
  */
=20
 #include <linux/init.h>
+#include <linux/ipipe_base.h>
=20
 #include <asm/hardware.h>
 #include <asm/leds.h>
Index: arch/arm/mach-np4/time.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- arch/arm/mach-np4/time.c	(revision 91)
+++ arch/arm/mach-np4/time.c	(working copy)
@@ -37,12 +37,116 @@
=20
 #include "time.h"
=20
+static unsigned long timer_period;
+
+static void set_np4_timer(unsigned long delay)
+{
+    //Set the static delay
+    timer_period =3D delay;
+    //First stop the timer
+    WRITE_REG(IO_ADDRESS(TMR0_CTRL_REG), TMR_STOP);
+    //Configure in autoreload mode with a prescaler of 256
+    WRITE_REG(IO_ADDRESS(TMR0_SETTINGS_REG), TMR_AUTORELOAD | TMR_PRESCA=
LER_256);
+    //Configure period of timer
+    WRITE_REG(IO_ADDRESS(TMR0_PERIOD_REG), delay);
+    //Clear pending interrupt
+    WRITE_REG(IO_ADDRESS(TMR0_IRQ_CLEAR_REG), TMR_IRQ_CLEAR);
+    //Enable timer interrupt
+    WRITE_REG(IO_ADDRESS(TMR0_IRQ_CTRL_REG), TMR_IRQ_ENABLE);
+    //Start the timer
+    WRITE_REG(IO_ADDRESS(TMR0_CTRL_REG), TMR_START);
+}
+
+#ifdef CONFIG_IPIPE
+static unsigned long timer_lxlost;
+static unsigned long long __ipipe_mach_tsc;
+
+int __ipipe_mach_timerint =3D TMR0_IRQ;
+EXPORT_SYMBOL(__ipipe_mach_timerint);
+
+int __ipipe_mach_timerstolen =3D 0;
+EXPORT_SYMBOL(__ipipe_mach_timerstolen);
+
+unsigned __ipipe_mach_ticks_per_jiffy =3D NP4_PERIOD;
+EXPORT_SYMBOL(__ipipe_mach_ticks_per_jiffy);
+
+/* IPIPE timer lock */
+static IPIPE_DEFINE_SPINLOCK(timer_lock);
+
+static inline unsigned long np4_getticksoffset(void)
+{
+    return (timer_period - (READ_REG(IO_ADDRESS(TMR0_TMR_REG)) & 0xFFFF)=
);
+}
+
+/* Acknoledge the hardware timer interrupt at hardware timer level. */
+void __ipipe_mach_acktimer(void)
+{
+    WRITE_REG(IO_ADDRESS(TMR0_IRQ_CLEAR_REG), TMR_IRQ_CLEAR);
+}
+
+/* High resolution counter, or its emulation using the hardware decremen=
ter or free-running counter */
+notrace unsigned long long __ipipe_mach_get_tsc(void)
+{
+    unsigned long long result;
+	unsigned long flags;
+
+	local_irq_save_hw_notrace(flags);
+	spin_lock(&timer_lock);
+	result =3D __ipipe_mach_tsc + np4_getticksoffset();
+	spin_unlock(&timer_lock);
+	local_irq_restore_hw_notrace(flags);
+	return result;
+}
+EXPORT_SYMBOL(__ipipe_mach_get_tsc);
+
+/* Fills a structure which will be used in user-space to emulate the tsc=
=2E*/
+void __ipipe_mach_get_tscinfo(struct __ipipe_tscinfo *info)
+{
+    info->type =3D IPIPE_TSC_TYPE_NONE;
+}
+
+/* Program the hardware timer to trig an interrupt in 'delay' hardware t=
imer ticks. */
+void __ipipe_mach_set_dec(unsigned long delay)
+{
+    	unsigned long ticks;
+	unsigned long flags;
+
+	spin_lock_irqsave(&timer_lock, flags);
+	ticks =3D np4_getticksoffset();
+	__ipipe_mach_tsc +=3D ticks;
+	timer_lxlost +=3D ticks;
+
+    set_np4_timer(delay);
+	spin_unlock_irqrestore(&timer_lock, flags);
+}
+EXPORT_SYMBOL(__ipipe_mach_set_dec);
+
+/* Called when Xenomai stops handling the hardware timer. */
+void __ipipe_mach_release_timer(void)
+{
+    __ipipe_mach_set_dec(__ipipe_mach_ticks_per_jiffy);
+}
+EXPORT_SYMBOL(__ipipe_mach_release_timer);
+
+/* Returns the count of hardware timer ticks remaining before the next t=
imer interrupt. */
+unsigned long __ipipe_mach_get_dec(void)
+{
+    return  READ_REG(IO_ADDRESS(TMR0_TMR_REG)) & 0xFFFF;
+}
+#endif
+
 static irqreturn_t np4_timer_interrupt(int irq, void *dev_id)
 {
     write_seqlock(&xtime_lock);
=20
+#ifndef CONFIG_IPIPE
     //Clear pending interrupt
     WRITE_REG(IO_ADDRESS(TMR0_IRQ_CLEAR_REG), TMR_IRQ_CLEAR);
+#else
+    timer_lxlost =3D 0;
+    if (!__ipipe_mach_timerstolen)
+        __ipipe_mach_tsc +=3D np4_getticksoffset();
+#endif
=20
     timer_tick();
=20
@@ -57,23 +161,13 @@
 	.handler	=3D np4_timer_interrupt,
 };
=20
-
 void __init np4_timer_init(void)
 {
     printk("np4: Timer 0 Init. : Freq %d Prescaler %d Period %d HZ %d\n"=
, NP4_FREQ, NP4_PRESCALER, NP4_PERIOD, HZ);
-    //First stop the timer
-    WRITE_REG(IO_ADDRESS(TMR0_CTRL_REG), TMR_STOP);
-    //Configure in autoreload mode with a prescaler of 256
-    WRITE_REG(IO_ADDRESS(TMR0_SETTINGS_REG), TMR_AUTORELOAD | TMR_PRESCA=
LER_256);
-    //Configure period of timer
-    WRITE_REG(IO_ADDRESS(TMR0_PERIOD_REG), NP4_PERIOD);
-    //Clear pending interrupt
-    WRITE_REG(IO_ADDRESS(TMR0_IRQ_CLEAR_REG), TMR_IRQ_CLEAR);
-    //Enable timer interrupt
-    WRITE_REG(IO_ADDRESS(TMR0_IRQ_CTRL_REG), TMR_IRQ_ENABLE);
-    //Start the timer
-    WRITE_REG(IO_ADDRESS(TMR0_CTRL_REG), TMR_START);
=20
+    //Set timer period
+    set_np4_timer(NP4_PERIOD);
+
     // Configure IRQ Handler
     setup_irq(TMR0_IRQ, &np4_timer_irq);
 }
@@ -85,7 +179,10 @@
=20
     value =3D READ_REG(IO_ADDRESS(TMR0_TMR_REG));
     value &=3D 0xFFFF; //Select only 16bits
-    elapsed =3D NP4_PERIOD - value;
+    elapsed =3D timer_period - value;
+#ifdef CONFIG_IPIPE
+    elapsed +=3D timer_lxlost;
+#endif
=20
     usec =3D (unsigned long)((elapsed * (1000000/HZ)) / NP4_PERIOD);
=20
Index: arch/arm/mach-np4/core.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- arch/arm/mach-np4/core.c	(revision 91)
+++ arch/arm/mach-np4/core.c	(working copy)
@@ -61,6 +61,10 @@
 }
 #endif
=20
+#ifdef CONFIG_IPIPE
+void __ipipe_mach_demux_irq(unsigned irq, struct pt_regs *regs) {}
+#endif
+
 static void np4_ack_irq(unsigned int irq)
 {
     // No need to acknowledge with our interrupt controller
Index: arch/arm/mm/fault.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- arch/arm/mm/fault.c	(revision 91)
+++ arch/arm/mm/fault.c	(working copy)
@@ -228,6 +228,9 @@
 	struct mm_struct *mm;
 	int fault, sig, code;
=20
+	if (ipipe_trap_notify(IPIPE_TRAP_ACCESS,regs))
+		return 0;
+
 	tsk =3D current;
 	mm  =3D tsk->mm;
=20
@@ -336,6 +339,9 @@
 	if (addr < TASK_SIZE)
 		return do_page_fault(addr, fsr, regs);
=20
+	if (ipipe_trap_notify(IPIPE_TRAP_ACCESS,regs))
+		return 0;
+
 	index =3D pgd_index(addr);
=20
 	/*
@@ -379,6 +385,10 @@
 static int
 do_sect_fault(unsigned long addr, unsigned int fsr, struct pt_regs *regs=
)
 {
+
+	if (ipipe_trap_notify(IPIPE_TRAP_SECTION,regs))
+		return 0;
+
 	do_bad_area(addr, fsr, regs);
 	return 0;
 }
@@ -389,6 +399,9 @@
 static int
 do_bad(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
 {
+	if (ipipe_trap_notify(IPIPE_TRAP_DABT,regs))
+		return 0;
+
 	return 1;
 }
=20
@@ -464,6 +477,9 @@
 	if (!inf->fn(addr, fsr, regs))
 		return;
=20
+	if (ipipe_trap_notify(IPIPE_TRAP_UNKNOWN,regs))
+		return;
+
 	printk(KERN_ALERT "Unhandled fault: %s (0x%03x) at 0x%08lx\n",
 		inf->name, fsr, addr);
=20
@@ -480,3 +496,42 @@
 	do_translation_fault(addr, 0, regs);
 }
=20
+#ifdef CONFIG_IPIPE
+extern spinlock_t pgd_lock;
+extern struct page *pgd_list;
+
+static void vmalloc_sync_one(pgd_t *pgd, unsigned long addr)
+{
+	unsigned int index =3D pgd_index(addr);
+	pgd_t *pgd_k;
+	pmd_t *pmd, *pmd_k;
+
+	pgd +=3D index;
+	pgd_k =3D init_mm.pgd + index;
+
+	if (!pgd_present(*pgd))
+		set_pgd(pgd, *pgd_k);
+
+	pmd_k =3D pmd_offset(pgd_k, addr);
+	pmd   =3D pmd_offset(pgd, addr);
+
+	copy_pmd(pmd, pmd_k);
+}
+
+void __ipipe_pin_range_globally(unsigned long start, unsigned long end)
+{
+	unsigned long next, addr =3D start;
+
+	do {
+		unsigned long flags;
+		struct page *page;
+
+		next =3D pgd_addr_end(addr, end);
+		spin_lock_irqsave(&pgd_lock, flags);
+		for (page =3D pgd_list; page; page =3D (struct page *)page->index)
+			vmalloc_sync_one(page_address(page), addr);
+		spin_unlock_irqrestore(&pgd_lock, flags);
+
+	} while (addr =3D next, addr !=3D end);
+}
+#endif /* CONFIG_IPIPE */
Index: arch/arm/mm/pgd.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- arch/arm/mm/pgd.c	(revision 91)
+++ arch/arm/mm/pgd.c	(working copy)
@@ -18,6 +18,41 @@
=20
 #define FIRST_KERNEL_PGD_NR	(FIRST_USER_PGD_NR + USER_PTRS_PER_PGD)
=20
+#ifdef CONFIG_IPIPE
+/* Copied from arch/i386/mm/pgdtable.c, maintains the list of pgds for t=
he
+   implementation of ipipe_pin_range_globally in arch/arm/mm/fault.c. */=

+DEFINE_SPINLOCK(pgd_lock);
+struct page *pgd_list;
+
+#define pgd_list_lock(flags) spin_lock_irqsave(&pgd_lock, flags)
+#define pgd_list_unlock(flags) spin_unlock_irqrestore(&pgd_lock, flags)
+
+static inline void pgd_list_add(pgd_t *pgd)
+{
+	struct page *page =3D virt_to_page(pgd);
+	page->index =3D (unsigned long)pgd_list;
+	if (pgd_list)
+		set_page_private(pgd_list, (unsigned long)&page->index);
+	pgd_list =3D page;
+	set_page_private(page, (unsigned long)&pgd_list);
+}
+
+static inline void pgd_list_del(pgd_t *pgd)
+{
+	struct page *next, **pprev, *page =3D virt_to_page(pgd);
+	next =3D (struct page *)page->index;
+	pprev =3D (struct page **)page_private(page);
+	*pprev =3D next;
+	if (next)
+		set_page_private(next, (unsigned long)pprev);
+}
+#else /* !CONFIG_IPIPE */
+#define pgd_list_lock(flags) (flags) =3D (flags)
+#define pgd_list_unlock(flags) (flags) =3D (flags)
+#define pgd_list_add(pgd) do { } while (0)
+#define pgd_list_del(pgd) do { } while (0)
+#endif /* !CONFIG_IPIPE */
+
 /*
  * need to get a 16k page for level 1
  */
@@ -26,6 +61,7 @@
 	pgd_t *new_pgd, *init_pgd;
 	pmd_t *new_pmd, *init_pmd;
 	pte_t *new_pte, *init_pte;
+	unsigned long flags;
=20
 	new_pgd =3D (pgd_t *)__get_free_pages(GFP_KERNEL, 2);
 	if (!new_pgd)
@@ -37,8 +73,11 @@
 	 * Copy over the kernel and IO PGD entries
 	 */
 	init_pgd =3D pgd_offset_k(0);
+	pgd_list_lock(flags);
 	memcpy(new_pgd + FIRST_KERNEL_PGD_NR, init_pgd + FIRST_KERNEL_PGD_NR,
 		       (PTRS_PER_PGD - FIRST_KERNEL_PGD_NR) * sizeof(pgd_t));
+	pgd_list_add(new_pgd);
+	pgd_list_unlock(flags);
=20
 	clean_dcache_area(new_pgd, PTRS_PER_PGD * sizeof(pgd_t));
=20
@@ -74,6 +113,7 @@
=20
 void free_pgd_slow(pgd_t *pgd)
 {
+	unsigned long flags;
 	pmd_t *pmd;
 	struct page *pte;
=20
@@ -97,5 +137,8 @@
 	pte_free(pte);
 	pmd_free(pmd);
 free:
+	pgd_list_lock(flags);
+	pgd_list_del(pgd);
+	pgd_list_unlock(flags);
 	free_pages((unsigned long) pgd, 2);
 }
Index: arch/arm/mm/copypage-xscale.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- arch/arm/mm/copypage-xscale.c	(revision 91)
+++ arch/arm/mm/copypage-xscale.c	(working copy)
@@ -42,7 +42,7 @@
  * Dcache aliasing issue.  The writes will be forwarded to the write buf=
fer,
  * and merged as appropriate.
  */
-static void __attribute__((naked))
+static void notrace __attribute__((naked))
 mc_copy_user_page(void *from, void *to)
 {
 	/*
@@ -110,7 +110,7 @@
 /*
  * XScale optimised clear_user_page
  */
-void __attribute__((naked))
+void notrace __attribute__((naked))
 xscale_mc_clear_user_page(void *kaddr, unsigned long vaddr)
 {
 	asm volatile(
Index: arch/arm/mm/alignment.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- arch/arm/mm/alignment.c	(revision 91)
+++ arch/arm/mm/alignment.c	(working copy)
@@ -637,6 +637,9 @@
 	unsigned int fault;
 	u16 tinstr =3D 0;
=20
+	if (ipipe_trap_notify(IPIPE_TRAP_ALIGNMENT,regs))
+		return 0;
+
 	instrptr =3D instruction_pointer(regs);
=20
 	fs =3D get_fs();
Index: arch/arm/mm/copypage-v4mc.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- arch/arm/mm/copypage-v4mc.c	(revision 91)
+++ arch/arm/mm/copypage-v4mc.c	(working copy)
@@ -44,7 +44,7 @@
  * instruction.  If your processor does not supply this, you have to wri=
te your
  * own copy_user_page that does the right thing.
  */
-static void __attribute__((naked))
+static void notrace __attribute__((naked))
 mc_copy_user_page(void *from, void *to)
 {
 	asm volatile(
@@ -88,7 +88,7 @@
 /*
  * ARMv4 optimised clear_user_page
  */
-void __attribute__((naked))
+void notrace __attribute__((naked))
 v4_mc_clear_user_page(void *kaddr, unsigned long vaddr)
 {
 	asm volatile(
Index: arch/arm/mach-ixp4xx/common.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- arch/arm/mach-ixp4xx/common.c	(revision 91)
+++ arch/arm/mach-ixp4xx/common.c	(working copy)
@@ -45,6 +45,66 @@
 static int __init ixp4xx_clockevent_init(void);
 static struct clock_event_device clockevent_ixp4xx;
=20
+#ifdef CONFIG_IPIPE
+#include <linux/ipipe.h>
+
+/* We have no cascaded interrupts. */
+void __ipipe_mach_demux_irq(unsigned irq, struct pt_regs *regs) {}
+
+#ifdef CONFIG_NO_IDLE_HZ
+#error "dynamic tick timer not yet supported with IPIPE"
+#endif
+
+int __ipipe_mach_timerint =3D IRQ_IXP4XX_TIMER1;
+int __ipipe_mach_timerstolen =3D 0;
+unsigned int __ipipe_mach_ticks_per_jiffy =3D LATCH;
+EXPORT_SYMBOL(__ipipe_mach_timerint);
+EXPORT_SYMBOL(__ipipe_mach_timerstolen);
+EXPORT_SYMBOL(__ipipe_mach_ticks_per_jiffy);
+
+static int ixp4xx_timer_initialized;
+
+#define ONE_SHOT_ENABLE (IXP4XX_OST_ENABLE|IXP4XX_OST_ONE_SHOT)
+
+union tsc_reg {
+#ifdef __BIG_ENDIAN
+	struct {
+		unsigned long high;
+		unsigned long low;
+	};
+#else /* __LITTLE_ENDIAN */
+	struct {
+		unsigned long low;
+		unsigned long high;
+	};
+#endif /* __LITTLE_ENDIAN */
+	unsigned long long full;
+};
+
+#ifdef CONFIG_SMP
+static union tsc_reg tsc[NR_CPUS];
+
+void __ipipe_mach_get_tscinfo(struct __ipipe_tscinfo *info)
+{
+	info->type =3D IPIPE_TSC_TYPE_NONE;
+}
+
+#else /* !CONFIG_SMP */
+static union tsc_reg *tsc;
+
+void __ipipe_mach_get_tscinfo(struct __ipipe_tscinfo *info)
+{
+	info->type =3D IPIPE_TSC_TYPE_FREERUNNING;
+	info->u.fr.counter =3D
+		(unsigned *)
+		(IXP4XX_TIMER_BASE_PHYS + IXP4XX_OSTS_OFFSET);
+	info->u.fr.mask =3D 0xffffffff;
+	info->u.fr.tsc =3D &tsc->full;
+}
+#endif /* !CONFIG_SMP */
+
+#endif /* CONFIG_IPIPE */
+
 /***********************************************************************=
**
  * IXP4xx chipset I/O mapping
  ***********************************************************************=
**/
@@ -269,8 +329,10 @@
 {
 	struct clock_event_device *evt =3D &clockevent_ixp4xx;
=20
+#ifndef CONFIG_IPIPE
 	/* Clear Pending Interrupt by writing '1' to it */
 	*IXP4XX_OSST =3D IXP4XX_OSST_TIMER_1_PEND;
+#endif /* CONFIG_IPIPE */
=20
 	evt->event_handler(evt);
=20
@@ -294,6 +356,14 @@
 	/* Reset time-stamp counter */
 	*IXP4XX_OSTS =3D 0;
=20
+#ifdef CONFIG_IPIPE
+#ifndef CONFIG_SMP
+	tsc =3D (union tsc_reg *) __ipipe_tsc_area;
+	barrier();
+#endif /* CONFIG_SMP */
+
+	ixp4xx_timer_initialized =3D 1;
+#endif
 	/* Connect the interrupt handler and enable the interrupt */
 	setup_irq(IRQ_IXP4XX_TIMER1, &ixp4xx_timer_irq);
=20
@@ -470,6 +540,13 @@
 	*IXP4XX_OSRT1 =3D osrt | opts;
 }
=20
+#ifdef CONFIG_IPIPE
+int __ipipe_check_tickdev(const char *devname)
+{
+	return !strcmp(devname, clockevent_ixp4xx.name);
+}
+#endif /* CONFIG_IPIPE */
+
 static struct clock_event_device clockevent_ixp4xx =3D {
 	.name		=3D "ixp4xx timer1",
 	.features       =3D CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT,
@@ -492,3 +569,97 @@
 	clockevents_register_device(&clockevent_ixp4xx);
 	return 0;
 }
+
+#ifdef CONFIG_IPIPE
+void __ipipe_mach_acktimer(void)
+{
+	union tsc_reg *local_tsc;
+	unsigned long stamp, flags;
+	/* Clear Pending Interrupt by writing '1' to it */
+	*IXP4XX_OSST =3D IXP4XX_OSST_TIMER_1_PEND;
+
+	local_irq_save_hw(flags);
+	local_tsc =3D &tsc[ipipe_processor_id()];
+	stamp =3D *IXP4XX_OSTS;
+	if (unlikely(stamp < local_tsc->low))
+		/* 32 bit counter wrapped, increment high word. */
+		local_tsc->high++;
+	local_tsc->low =3D stamp;
+	local_irq_restore_hw(flags);
+}
+
+EXPORT_SYMBOL(__ipipe_mach_acktimer);
+
+notrace unsigned long long __ipipe_mach_get_tsc(void)
+{
+	if (likely(ixp4xx_timer_initialized)) {
+		union tsc_reg *local_tsc, result;
+		unsigned long stamp;
+
+		local_tsc =3D &tsc[ipipe_processor_id()];
+
+		__asm__ ("ldmia %1, %M0\n"
+			 : "=3Dr"(result.full), "+&r"(local_tsc)
+			 : "m"(*local_tsc));
+		barrier();
+		stamp =3D *IXP4XX_OSTS;
+		if (unlikely(stamp < result.low))
+			/* 32 bit counter wrapped, increment high word. */
+			result.high++;
+		result.low =3D stamp;
+		return result.full;
+	}
+
+        return 0;
+}
+
+EXPORT_SYMBOL(__ipipe_mach_get_tsc);
+
+/*
+ * Reprogram the timer
+ *
+ * The timer is aperiodic (most of the time) when running Xenomai, so
+ * __ipipe_mach_set_dec is called for each timer tick and programs the
+ * timer hardware for the next tick.
+ *
+ */
+#define MIN_DELAY 333 /* 5 usec with the 66.66 MHz system clock */
+
+void __ipipe_mach_set_dec(unsigned long delay)
+{
+	unsigned long flags;
+	if (delay > MIN_DELAY) {
+		local_irq_save_hw(flags);
+		*IXP4XX_OSRT1 =3D delay | ONE_SHOT_ENABLE;
+		local_irq_restore_hw(flags);
+	} else {
+		ipipe_trigger_irq(IRQ_IXP4XX_TIMER1);
+	}
+}
+
+EXPORT_SYMBOL(__ipipe_mach_set_dec);
+
+/*
+ * This returns the number of clock ticks remaining.
+ */
+unsigned long __ipipe_mach_get_dec(void)
+{
+	return(*IXP4XX_OST1); /* remaining */
+}
+
+EXPORT_SYMBOL(__ipipe_mach_get_dec);
+
+void __ipipe_mach_release_timer(void)
+{
+	unsigned long flags;
+
+	local_irq_save_hw(flags);
+	ixp4xx_set_mode(clockevent_ixp4xx.mode, &clockevent_ixp4xx);
+	if (clockevent_ixp4xx.mode =3D=3D CLOCK_EVT_MODE_ONESHOT)
+		ixp4xx_set_next_event(LATCH, &clockevent_ixp4xx);
+	local_irq_restore_hw(flags);
+}
+
+EXPORT_SYMBOL(__ipipe_mach_release_timer);
+
+#endif /* CONFIG_IPIPE */
Index: arch/arm/mach-sa1100/leds-simpad.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- arch/arm/mach-sa1100/leds-simpad.c	(revision 91)
+++ arch/arm/mach-sa1100/leds-simpad.c	(working copy)
@@ -4,6 +4,7 @@
  * Author: Juergen Messerer <juergen.messerer@domain.hid>
  */
 #include <linux/init.h>
+#include <linux/ipipe_base.h>
=20
 #include <asm/hardware.h>
 #include <asm/leds.h>
Index: arch/arm/mach-sa1100/leds-hackkit.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- arch/arm/mach-sa1100/leds-hackkit.c	(revision 91)
+++ arch/arm/mach-sa1100/leds-hackkit.c	(working copy)
@@ -10,6 +10,7 @@
  * as cpu led, the green one is used as timer led.
  */
 #include <linux/init.h>
+#include <linux/ipipe_base.h>
=20
 #include <asm/hardware.h>
 #include <asm/leds.h>
Index: arch/arm/mach-sa1100/leds-assabet.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- arch/arm/mach-sa1100/leds-assabet.c	(revision 91)
+++ arch/arm/mach-sa1100/leds-assabet.c	(working copy)
@@ -10,6 +10,7 @@
  *   - Red   - on if system is not idle
  */
 #include <linux/init.h>
+#include <linux/ipipe_base.h>
=20
 #include <asm/hardware.h>
 #include <asm/leds.h>
Index: arch/arm/mach-sa1100/leds-lart.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- arch/arm/mach-sa1100/leds-lart.c	(revision 91)
+++ arch/arm/mach-sa1100/leds-lart.c	(working copy)
@@ -10,6 +10,7 @@
  *  pace of the LED.
  */
 #include <linux/init.h>
+#include <linux/ipipe_base.h>
=20
 #include <asm/hardware.h>
 #include <asm/leds.h>
Index: arch/arm/mach-sa1100/irq.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- arch/arm/mach-sa1100/irq.c	(revision 91)
+++ arch/arm/mach-sa1100/irq.c	(working copy)
@@ -15,6 +15,7 @@
 #include <linux/irq.h>
 #include <linux/ioport.h>
 #include <linux/sysdev.h>
+#include <linux/ipipe.h>
=20
 #include <asm/hardware.h>
 #include <asm/mach/irq.h>
@@ -136,6 +137,37 @@
 	} while (mask);
 }
=20
+#ifdef CONFIG_IPIPE
+void __ipipe_mach_demux_irq(unsigned irq, struct pt_regs *regs)
+{
+	struct irq_desc *desc_unused =3D irq_desc + irq;
+	unsigned irq_unused =3D irq;
+	unsigned int mask;
+
+	mask =3D GEDR & 0xfffff800;
+	do {
+		/*
+		 * clear down all currently active IRQ sources.
+		 * We will be processing them all.
+		 */
+		GEDR =3D mask;
+
+		irq =3D IRQ_GPIO11;
+		mask >>=3D 11;
+		do {
+			if (mask & 1)
+				__ipipe_handle_irq(irq, regs);
+			mask >>=3D 1;
+			irq++;
+		} while (mask);
+
+		mask =3D GEDR & 0xfffff800;
+	} while (mask);
+
+	desc_unused->chip->unmask(irq_unused);
+}
+#endif /* CONFIG_IPIPE */
+
 /*
  * Like GPIO0 to 10, GPIO11-27 IRQs need to be handled specially.
  * In addition, the IRQs are all collected up into one bit in the
Index: arch/arm/mach-sa1100/time.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- arch/arm/mach-sa1100/time.c	(revision 91)
+++ arch/arm/mach-sa1100/time.c	(working copy)
@@ -14,6 +14,7 @@
 #include <linux/irq.h>
 #include <linux/timex.h>
 #include <linux/signal.h>
+#include <linux/module.h>
=20
 #include <asm/mach/time.h>
 #include <asm/hardware.h>
@@ -21,6 +22,58 @@
 #define RTC_DEF_DIVIDER		(32768 - 1)
 #define RTC_DEF_TRIM            0
=20
+#ifdef CONFIG_IPIPE
+#ifdef CONFIG_NO_IDLE_HZ
+#error "dynamic tick timer not yet supported with IPIPE"
+#endif /* CONFIG_NO_IDLE_HZ */
+int __ipipe_mach_timerint =3D IRQ_OST0;
+EXPORT_SYMBOL(__ipipe_mach_timerint);
+
+int __ipipe_mach_timerstolen =3D 0;
+EXPORT_SYMBOL(__ipipe_mach_timerstolen);
+
+unsigned int __ipipe_mach_ticks_per_jiffy =3D LATCH;
+EXPORT_SYMBOL(__ipipe_mach_ticks_per_jiffy);
+
+static int sa1100_timer_initialized;
+static unsigned long last_jiffy_time;
+
+union tsc_reg {
+#ifdef __BIG_ENDIAN
+	struct {
+		unsigned long high;
+		unsigned long low;
+	};
+#else /* __LITTLE_ENDIAN */
+	struct {
+		unsigned long low;
+		unsigned long high;
+	};
+#endif /* __LITTLE_ENDIAN */
+	unsigned long long full;
+};
+
+#ifdef CONFIG_SMP
+static union tsc_reg tsc[NR_CPUS];
+
+void __ipipe_mach_get_tscinfo(struct __ipipe_tscinfo *info)
+{
+	info->type =3D IPIPE_TSC_TYPE_NONE;
+}
+
+#else /* !CONFIG_SMP */
+static union tsc_reg *tsc;
+
+void __ipipe_mach_get_tscinfo(struct __ipipe_tscinfo *info)
+{
+	info->type =3D IPIPE_TSC_TYPE_FREERUNNING;
+	info->u.fr.counter =3D (unsigned *)0x90000010;
+	info->u.fr.mask =3D 0xffffffff;
+	info->u.fr.tsc =3D &tsc->full;
+}
+#endif /* !CONFIG_SMP */
+#endif /* CONFIG_IPIPE */
+
 static int sa1100_set_rtc(void)
 {
 	unsigned long current_time =3D xtime.tv_sec;
@@ -40,11 +93,18 @@
 {
 	unsigned long ticks_to_match, elapsed, usec;
=20
+#ifdef CONFIG_IPIPE
+	if (!__ipipe_mach_timerstolen) {
+#endif
 	/* Get ticks before next timer match */
 	ticks_to_match =3D OSMR0 - OSCR;
=20
 	/* We need elapsed ticks since last match */
 	elapsed =3D LATCH - ticks_to_match;
+#ifdef CONFIG_IPIPE
+	} else
+		elapsed =3D OSCR - last_jiffy_time;
+#endif
=20
 	/* Now convert them to usec */
 	usec =3D (unsigned long)(elapsed * (tick_nsec / 1000))/LATCH;
@@ -79,9 +139,24 @@
 	 * ensured, hence we can use do_gettimeofday() from interrupt
 	 * handlers.
 	 */
+	/*
+	 * - if Linux is running natively (no ipipe), ack and reprogram the tim=
er
+	 * - if Linux is running under ipipe, but it still has the control over=

+	 *   the timer (no Xenomai for example), then reprogram the timer (ipip=
e
+	 *   has already acked it)
+	 * - if some other domain has taken over the timer, then do nothing
+	 *   (ipipe has acked it, and the other domain has reprogramed it)
+	 */
 	do {
 		timer_tick();
+#ifndef CONFIG_IPIPE
 		OSSR =3D OSSR_M0;  /* Clear match on timer 0 */
+#else /* CONFIG_IPIPE */
+		last_jiffy_time +=3D LATCH;
+		if (__ipipe_mach_timerstolen)
+			next_match =3D last_jiffy_time + LATCH;
+		else
+#endif /* CONFIG_IPIPE */
 		next_match =3D (OSMR0 +=3D LATCH);
 	} while ((signed long)(next_match - OSCR) <=3D 0);
=20
@@ -107,8 +182,21 @@
 	setup_irq(IRQ_OST0, &sa1100_timer_irq);
 	local_irq_save(flags);
 	OIER =3D OIER_E0;		/* enable match on timer 0 to cause interrupts */
+#ifndef CONFIG_IPIPE
 	OSMR0 =3D OSCR + LATCH;	/* set initial match */
+#else /* CONFIG_IPIPE */
+	last_jiffy_time =3D OSCR;
+	OSMR0 =3D last_jiffy_time + LATCH;
+#endif /* CONFIG_IPIPE */
 	local_irq_restore(flags);
+#ifdef CONFIG_IPIPE
+#ifndef CONFIG_SMP
+	tsc =3D (union tsc_reg *) __ipipe_tsc_area;
+	barrier();
+#endif /* CONFIG_SMP */
+
+	sa1100_timer_initialized =3D 1;
+#endif /* CONFIG_IPIPE */
 }
=20
 #ifdef CONFIG_NO_IDLE_HZ
@@ -187,3 +275,71 @@
 	.dyn_tick	=3D &sa1100_dyn_tick,
 #endif
 };
+
+#ifdef CONFIG_IPIPE
+void __ipipe_mach_acktimer(void)
+{
+	union tsc_reg *local_tsc;
+	unsigned long stamp, flags;
+
+	OSSR =3D OSSR_M0;  /* Clear match on timer 0 */
+
+	local_irq_save_hw(flags);
+	local_tsc =3D &tsc[ipipe_processor_id()];
+	stamp =3D OSCR;
+	if (unlikely(stamp < local_tsc->low))
+		/* 32 bit counter wrapped, increment high word. */
+		local_tsc->high++;
+	local_tsc->low =3D stamp;
+	local_irq_restore_hw(flags);
+}
+
+notrace unsigned long long __ipipe_mach_get_tsc(void)
+{
+	if (likely(sa1100_timer_initialized)) {
+		union tsc_reg *local_tsc, result;
+		unsigned long stamp;
+
+		local_tsc =3D &tsc[ipipe_processor_id()];
+
+		__asm__ ("ldmia %1, %M0\n"
+			 : "=3Dr"(result.full), "+&r"(local_tsc)
+			 : "m"(*local_tsc));
+		barrier();
+		stamp =3D OSCR;
+		if (unlikely(stamp < result.low))
+			/* 32 bit counter wrapped, increment high word. */
+			result.high++;
+		result.low =3D stamp;
+		return result.full;
+	}
+=09
+        return 0;
+}
+EXPORT_SYMBOL(__ipipe_mach_get_tsc);
+
+/*
+ * Reprogram the timer
+ */
+
+void __ipipe_mach_set_dec(unsigned long delay)
+{
+	unsigned long flags;
+
+	local_irq_save_hw(flags);
+        OSMR0 =3D delay + OSCR;
+	local_irq_restore_hw(flags);
+}
+EXPORT_SYMBOL(__ipipe_mach_set_dec);
+
+void __ipipe_mach_release_timer(void)
+{
+       __ipipe_mach_set_dec(__ipipe_mach_ticks_per_jiffy);
+}
+EXPORT_SYMBOL(__ipipe_mach_release_timer);
+
+unsigned long __ipipe_mach_get_dec(void)
+{
+	return OSMR0 - OSCR;
+}
+#endif /* CONFIG_IPIPE */
Index: arch/arm/mach-sa1100/leds-cerf.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- arch/arm/mach-sa1100/leds-cerf.c	(revision 91)
+++ arch/arm/mach-sa1100/leds-cerf.c	(working copy)
@@ -4,6 +4,7 @@
  * Author: ???
  */
 #include <linux/init.h>
+#include <linux/ipipe_base.h>
=20
 #include <asm/hardware.h>
 #include <asm/leds.h>
Index: arch/arm/mach-sa1100/leds-badge4.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- arch/arm/mach-sa1100/leds-badge4.c	(revision 91)
+++ arch/arm/mach-sa1100/leds-badge4.c	(working copy)
@@ -11,6 +11,7 @@
  */
=20
 #include <linux/init.h>
+#include <linux/ipipe_base.h>
=20
 #include <asm/hardware.h>
 #include <asm/leds.h>
Index: Makefile
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- Makefile	(revision 91)
+++ Makefile	(working copy)
@@ -509,6 +509,10 @@
=20
 include $(srctree)/arch/$(SRCARCH)/Makefile
=20
+ifdef CONFIG_IPIPE_TRACE_MCOUNT
+KBUILD_CFLAGS	+=3D -pg
+endif
+
 ifdef CONFIG_FRAME_POINTER
 KBUILD_CFLAGS	+=3D -fno-omit-frame-pointer -fno-optimize-sibling-calls
 else
Index: drivers/pci/htirq.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- drivers/pci/htirq.c	(revision 91)
+++ drivers/pci/htirq.c	(working copy)
@@ -21,7 +21,7 @@
  * With multiple simultaneous hypertransport irq devices it might pay
  * to make this more fine grained.  But start with simple, stupid, and c=
orrect.
  */
-static DEFINE_SPINLOCK(ht_irq_lock);
+static IPIPE_DEFINE_SPINLOCK(ht_irq_lock);
=20
 struct ht_irq_cfg {
 	struct pci_dev *dev;

--------------030600010007060101040903
Content-Type: text/plain;
 name=".config"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename=".config"

#
# Automatically generated make config: don't edit
# Linux kernel version: 2.6.24-arm1-np4
# Fri Mar 28 08:39:48 2008
#
CONFIG_ARM=3Dy
CONFIG_SYS_SUPPORTS_APM_EMULATION=3Dy
# CONFIG_GENERIC_GPIO is not set
# CONFIG_GENERIC_TIME is not set
# CONFIG_GENERIC_CLOCKEVENTS is not set
# CONFIG_NO_IOPORT is not set
CONFIG_GENERIC_HARDIRQS=3Dy
CONFIG_STACKTRACE_SUPPORT=3Dy
CONFIG_LOCKDEP_SUPPORT=3Dy
CONFIG_TRACE_IRQFLAGS_SUPPORT=3Dy
CONFIG_HARDIRQS_SW_RESEND=3Dy
CONFIG_GENERIC_IRQ_PROBE=3Dy
CONFIG_RWSEM_GENERIC_SPINLOCK=3Dy
# CONFIG_ARCH_HAS_ILOG2_U32 is not set
# CONFIG_ARCH_HAS_ILOG2_U64 is not set
CONFIG_GENERIC_HWEIGHT=3Dy
CONFIG_GENERIC_CALIBRATE_DELAY=3Dy
CONFIG_ZONE_DMA=3Dy
CONFIG_VECTORS_BASE=3D0xffff0000
CONFIG_DEFCONFIG_LIST=3D"/lib/modules/$UNAME_RELEASE/.config"

#
# General setup
#
CONFIG_EXPERIMENTAL=3Dy
CONFIG_BROKEN_ON_SMP=3Dy
CONFIG_INIT_ENV_ARG_LIMIT=3D32
CONFIG_LOCALVERSION=3D""
# CONFIG_LOCALVERSION_AUTO is not set
CONFIG_SYSVIPC=3Dy
# CONFIG_BSD_PROCESS_ACCT is not set
# CONFIG_USER_NS is not set
# CONFIG_PID_NS is not set
# CONFIG_IKCONFIG is not set
CONFIG_LOG_BUF_SHIFT=3D17
# CONFIG_CGROUPS is not set
CONFIG_FAIR_GROUP_SCHED=3Dy
CONFIG_FAIR_USER_SCHED=3Dy
# CONFIG_FAIR_CGROUP_SCHED is not set
# CONFIG_SYSFS_DEPRECATED is not set
# CONFIG_RELAY is not set
CONFIG_BLK_DEV_INITRD=3Dy
CONFIG_INITRAMFS_SOURCE=3D"initramfs.txt"
CONFIG_INITRAMFS_ROOT_UID=3D0
CONFIG_INITRAMFS_ROOT_GID=3D0
CONFIG_CC_OPTIMIZE_FOR_SIZE=3Dy
CONFIG_EMBEDDED=3Dy
CONFIG_UID16=3Dy
# CONFIG_SYSCTL_SYSCALL is not set
CONFIG_KALLSYMS=3Dy
CONFIG_KALLSYMS_ALL=3Dy
CONFIG_KALLSYMS_EXTRA_PASS=3Dy
# CONFIG_HOTPLUG is not set
CONFIG_PRINTK=3Dy
CONFIG_BUG=3Dy
# CONFIG_ELF_CORE is not set
CONFIG_BASE_FULL=3Dy
CONFIG_FUTEX=3Dy
# CONFIG_EPOLL is not set
# CONFIG_SIGNALFD is not set
# CONFIG_EVENTFD is not set
# CONFIG_SHMEM is not set
# CONFIG_VM_EVENT_COUNTERS is not set
CONFIG_SLAB=3Dy
# CONFIG_SLUB is not set
# CONFIG_SLOB is not set
CONFIG_SLABINFO=3Dy
CONFIG_RT_MUTEXES=3Dy
CONFIG_TINY_SHMEM=3Dy
CONFIG_BASE_SMALL=3D0
# CONFIG_MODULES is not set
# CONFIG_BLOCK is not set

#
# Real-time sub-system
#
CONFIG_XENOMAI=3Dy
CONFIG_XENO_GENERIC_STACKPOOL=3Dy
CONFIG_XENO_OPT_NUCLEUS=3Dy
CONFIG_XENO_OPT_PERVASIVE=3Dy
# CONFIG_XENO_OPT_ISHIELD is not set
CONFIG_XENO_OPT_PRIOCPL=3Dy
# CONFIG_XENO_OPT_PIPELINE_HEAD is not set
CONFIG_XENO_OPT_PIPE=3Dy
CONFIG_XENO_OPT_PIPE_NRDEV=3D32
CONFIG_XENO_OPT_REGISTRY=3Dy
CONFIG_XENO_OPT_REGISTRY_NRSLOTS=3D512
CONFIG_XENO_OPT_SYS_HEAPSZ=3D128
CONFIG_XENO_OPT_SYS_STACKPOOLSZ=3D32
# CONFIG_XENO_OPT_STATS is not set
CONFIG_XENO_OPT_DEBUG=3Dy
CONFIG_XENO_OPT_DEBUG_NUCLEUS=3Dy
# CONFIG_XENO_OPT_DEBUG_QUEUES is not set
# CONFIG_XENO_OPT_DEBUG_REGISTRY is not set
# CONFIG_XENO_OPT_DEBUG_TIMERS is not set
# CONFIG_XENO_OPT_WATCHDOG is not set
# CONFIG_XENO_OPT_SHIRQ is not set

#
# Timing
#
# CONFIG_XENO_OPT_TIMING_PERIODIC is not set
CONFIG_XENO_OPT_TIMING_SCHEDLAT=3D0

#
# Scalability
#
# CONFIG_XENO_OPT_SCALABLE_SCHED is not set
CONFIG_XENO_OPT_TIMER_LIST=3Dy
# CONFIG_XENO_OPT_TIMER_HEAP is not set
# CONFIG_XENO_OPT_TIMER_WHEEL is not set

#
# Machine
#
# CONFIG_XENO_HW_FPU is not set

#
# Interfaces
#
CONFIG_XENO_SKIN_NATIVE=3Dy
CONFIG_XENO_OPT_NATIVE_PERIOD=3D0
CONFIG_XENO_OPT_NATIVE_PIPE=3Dy
CONFIG_XENO_OPT_NATIVE_PIPE_BUFSZ=3D1024
CONFIG_XENO_OPT_NATIVE_REGISTRY=3Dy
CONFIG_XENO_OPT_NATIVE_SEM=3Dy
CONFIG_XENO_OPT_NATIVE_EVENT=3Dy
CONFIG_XENO_OPT_NATIVE_MUTEX=3Dy
CONFIG_XENO_OPT_NATIVE_COND=3Dy
CONFIG_XENO_OPT_NATIVE_QUEUE=3Dy
CONFIG_XENO_OPT_NATIVE_HEAP=3Dy
CONFIG_XENO_OPT_NATIVE_ALARM=3Dy
CONFIG_XENO_OPT_NATIVE_MPS=3Dy
# CONFIG_XENO_OPT_NATIVE_INTR is not set
CONFIG_XENO_OPT_DEBUG_NATIVE=3Dy
CONFIG_XENO_SKIN_POSIX=3Dy
CONFIG_XENO_OPT_POSIX_PERIOD=3D0
# CONFIG_XENO_OPT_POSIX_SHM is not set
# CONFIG_XENO_OPT_POSIX_INTR is not set
# CONFIG_XENO_OPT_POSIX_SELECT is not set
CONFIG_XENO_OPT_DEBUG_POSIX=3Dy
# CONFIG_XENO_SKIN_PSOS is not set
# CONFIG_XENO_SKIN_UITRON is not set
# CONFIG_XENO_SKIN_VRTX is not set
# CONFIG_XENO_SKIN_VXWORKS is not set
# CONFIG_XENO_SKIN_RTAI is not set
CONFIG_XENO_SKIN_RTDM=3Dy
CONFIG_XENO_OPT_RTDM_PERIOD=3D0
CONFIG_XENO_OPT_RTDM_FILDES=3D128
# CONFIG_XENO_OPT_RTDM_SELECT is not set
CONFIG_XENO_OPT_DEBUG_RTDM=3Dy

#
# Drivers
#

#
# Serial drivers
#
# CONFIG_XENO_DRIVERS_16550A is not set

#
# Testing drivers
#
# CONFIG_XENO_DRIVERS_TIMERBENCH is not set
# CONFIG_XENO_DRIVERS_IRQBENCH is not set
# CONFIG_XENO_DRIVERS_SWITCHTEST is not set

#
# CAN drivers
#
# CONFIG_XENO_DRIVERS_CAN is not set

#
# System Type
#
CONFIG_MMU=3Dy
# CONFIG_ARCH_AAEC2000 is not set
# CONFIG_ARCH_INTEGRATOR is not set
# CONFIG_ARCH_REALVIEW is not set
# CONFIG_ARCH_VERSATILE is not set
# CONFIG_ARCH_AT91 is not set
# CONFIG_ARCH_CLPS7500 is not set
# CONFIG_ARCH_CLPS711X is not set
# CONFIG_ARCH_CO285 is not set
# CONFIG_ARCH_EBSA110 is not set
# CONFIG_ARCH_EP93XX is not set
# CONFIG_ARCH_FOOTBRIDGE is not set
# CONFIG_ARCH_NETX is not set
# CONFIG_ARCH_H720X is not set
# CONFIG_ARCH_IMX is not set
# CONFIG_ARCH_IOP13XX is not set
# CONFIG_ARCH_IOP32X is not set
# CONFIG_ARCH_IOP33X is not set
# CONFIG_ARCH_IXP23XX is not set
# CONFIG_ARCH_IXP2000 is not set
# CONFIG_ARCH_IXP4XX is not set
# CONFIG_ARCH_L7200 is not set
# CONFIG_ARCH_KS8695 is not set
# CONFIG_ARCH_NS9XXX is not set
# CONFIG_ARCH_MXC is not set
# CONFIG_ARCH_PNX4008 is not set
# CONFIG_ARCH_PXA is not set
# CONFIG_ARCH_RPC is not set
# CONFIG_ARCH_SA1100 is not set
# CONFIG_ARCH_S3C2410 is not set
# CONFIG_ARCH_SHARK is not set
# CONFIG_ARCH_LH7A40X is not set
# CONFIG_ARCH_DAVINCI is not set
# CONFIG_ARCH_OMAP is not set
CONFIG_ARCH_NP4=3Dy

#
# Boot options
#

#
# Power management
#

#
# Neotion NP4 Boards
#
CONFIG_NP4_HZ=3D1000
CONFIG_MACH_NP4PLUS=3Dy
# CONFIG_NP4_UART1 is not set
# CONFIG_SERIAL_NP4_BASIC_CONSOLE is not set

#
# Processor Type
#
CONFIG_CPU_32=3Dy
CONFIG_CPU_ARM926T=3Dy
CONFIG_CPU_32v5=3Dy
CONFIG_CPU_ABRT_EV5TJ=3Dy
CONFIG_CPU_PABRT_NOIFAR=3Dy
CONFIG_CPU_CACHE_VIVT=3Dy
CONFIG_CPU_COPY_V4WB=3Dy
CONFIG_CPU_TLB_V4WBI=3Dy
CONFIG_CPU_CP15=3Dy
CONFIG_CPU_CP15_MMU=3Dy

#
# Processor Features
#
# CONFIG_ARM_THUMB is not set
# CONFIG_CPU_ICACHE_DISABLE is not set
# CONFIG_CPU_DCACHE_DISABLE is not set
# CONFIG_CPU_DCACHE_WRITETHROUGH is not set
CONFIG_CPU_CACHE_ROUND_ROBIN=3Dy
# CONFIG_OUTER_CACHE is not set

#
# Bus support
#
# CONFIG_PCI_SYSCALL is not set
# CONFIG_ARCH_SUPPORTS_MSI is not set

#
# Kernel Features
#
# CONFIG_TICK_ONESHOT is not set
CONFIG_IPIPE=3Dy
CONFIG_IPIPE_DOMAINS=3D4
# CONFIG_IPIPE_COMPAT is not set
# CONFIG_PREEMPT is not set
# CONFIG_NO_IDLE_HZ is not set
CONFIG_HZ=3D1000
# CONFIG_ARM_ASM_UNIFIED is not set
CONFIG_AEABI=3Dy
CONFIG_OABI_COMPAT=3Dy
# CONFIG_ARCH_DISCONTIGMEM_ENABLE is not set
CONFIG_SELECT_MEMORY_MODEL=3Dy
CONFIG_FLATMEM_MANUAL=3Dy
# CONFIG_DISCONTIGMEM_MANUAL is not set
# CONFIG_SPARSEMEM_MANUAL is not set
CONFIG_FLATMEM=3Dy
CONFIG_FLAT_NODE_MEM_MAP=3Dy
# CONFIG_SPARSEMEM_STATIC is not set
# CONFIG_SPARSEMEM_VMEMMAP_ENABLE is not set
CONFIG_SPLIT_PTLOCK_CPUS=3D4096
# CONFIG_RESOURCES_64BIT is not set
CONFIG_ZONE_DMA_FLAG=3D1
CONFIG_VIRT_TO_BUS=3Dy
CONFIG_ALIGNMENT_TRAP=3Dy

#
# Boot options
#
CONFIG_ZBOOT_ROM_TEXT=3D0x0
CONFIG_ZBOOT_ROM_BSS=3D0x0
CONFIG_CMDLINE=3D""
# CONFIG_XIP_KERNEL is not set
# CONFIG_KEXEC is not set

#
# Floating point emulation
#

#
# At least one emulation must be selected
#
# CONFIG_FPE_NWFPE is not set
# CONFIG_FPE_FASTFPE is not set
# CONFIG_VFP is not set

#
# Userspace binary formats
#
CONFIG_BINFMT_ELF=3Dy
# CONFIG_BINFMT_AOUT is not set
# CONFIG_BINFMT_MISC is not set

#
# Power management options
#
# CONFIG_PM is not set
CONFIG_SUSPEND_UP_POSSIBLE=3Dy

#
# Networking
#
# CONFIG_NET is not set

#
# Device Drivers
#

#
# Generic Driver Options
#
CONFIG_STANDALONE=3Dy
CONFIG_PREVENT_FIRMWARE_BUILD=3Dy
# CONFIG_DEBUG_DRIVER is not set
# CONFIG_DEBUG_DEVRES is not set
# CONFIG_SYS_HYPERVISOR is not set
# CONFIG_MTD is not set
# CONFIG_PARPORT is not set
# CONFIG_MISC_DEVICES is not set

#
# SCSI device support
#
# CONFIG_SCSI_DMA is not set
# CONFIG_SCSI_NETLINK is not set

#
# Input device support
#
CONFIG_INPUT=3Dy
# CONFIG_INPUT_FF_MEMLESS is not set
# CONFIG_INPUT_POLLDEV is not set

#
# Userland interfaces
#
# CONFIG_INPUT_MOUSEDEV is not set
# CONFIG_INPUT_JOYDEV is not set
# CONFIG_INPUT_EVDEV is not set
# CONFIG_INPUT_EVBUG is not set

#
# Input Device Drivers
#
# CONFIG_INPUT_KEYBOARD is not set
# CONFIG_INPUT_MOUSE is not set
# CONFIG_INPUT_JOYSTICK is not set
# CONFIG_INPUT_TABLET is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
# CONFIG_INPUT_MISC is not set

#
# Hardware I/O ports
#
CONFIG_SERIO=3Dy
CONFIG_SERIO_SERPORT=3Dy
# CONFIG_SERIO_LIBPS2 is not set
# CONFIG_SERIO_RAW is not set
# CONFIG_GAMEPORT is not set

#
# Character devices
#
# CONFIG_VT is not set
# CONFIG_SERIAL_NONSTANDARD is not set

#
# Serial drivers
#
# CONFIG_SERIAL_8250 is not set

#
# Non-8250 serial port support
#
CONFIG_SERIAL_NP4=3Dy
# CONFIG_SERIAL_NP4_CONSOLE is not set
CONFIG_SERIAL_CORE=3Dy
# CONFIG_UNIX98_PTYS is not set
# CONFIG_LEGACY_PTYS is not set
# CONFIG_IPMI_HANDLER is not set
# CONFIG_HW_RANDOM is not set
# CONFIG_NVRAM is not set
# CONFIG_R3964 is not set
# CONFIG_TCG_TPM is not set
# CONFIG_I2C is not set

#
# SPI support
#
# CONFIG_SPI is not set
# CONFIG_SPI_MASTER is not set
# CONFIG_W1 is not set
# CONFIG_POWER_SUPPLY is not set
# CONFIG_HWMON is not set
# CONFIG_WATCHDOG is not set

#
# Sonics Silicon Backplane
#
CONFIG_SSB_POSSIBLE=3Dy
# CONFIG_SSB is not set

#
# Multifunction device drivers
#
# CONFIG_MFD_SM501 is not set

#
# Multimedia devices
#
# CONFIG_VIDEO_DEV is not set
# CONFIG_DAB is not set

#
# Graphics support
#
# CONFIG_VGASTATE is not set
# CONFIG_VIDEO_OUTPUT_CONTROL is not set
# CONFIG_FB is not set
# CONFIG_BACKLIGHT_LCD_SUPPORT is not set

#
# Display device support
#
# CONFIG_DISPLAY_SUPPORT is not set

#
# Sound
#
# CONFIG_SOUND is not set
# CONFIG_HID_SUPPORT is not set
# CONFIG_USB_SUPPORT is not set
# CONFIG_MMC is not set
# CONFIG_NEW_LEDS is not set
CONFIG_RTC_LIB=3Dy
# CONFIG_RTC_CLASS is not set

#
# File systems
#
# CONFIG_INOTIFY is not set
# CONFIG_QUOTA is not set
# CONFIG_DNOTIFY is not set
# CONFIG_AUTOFS_FS is not set
# CONFIG_AUTOFS4_FS is not set
# CONFIG_FUSE_FS is not set

#
# Pseudo filesystems
#
CONFIG_PROC_FS=3Dy
# CONFIG_PROC_SYSCTL is not set
# CONFIG_SYSFS is not set
# CONFIG_TMPFS is not set
# CONFIG_HUGETLB_PAGE is not set

#
# Miscellaneous filesystems
#
# CONFIG_NLS is not set
# CONFIG_INSTRUMENTATION is not set

#
# Kernel hacking
#
# CONFIG_PRINTK_TIME is not set
# CONFIG_ENABLE_WARN_DEPRECATED is not set
# CONFIG_ENABLE_MUST_CHECK is not set
# CONFIG_MAGIC_SYSRQ is not set
# CONFIG_UNUSED_SYMBOLS is not set
# CONFIG_HEADERS_CHECK is not set
CONFIG_IPIPE_DEBUG=3Dy
CONFIG_IPIPE_DEBUG_CONTEXT=3Dy
# CONFIG_IPIPE_TRACE is not set
CONFIG_DEBUG_KERNEL=3Dy
# CONFIG_DEBUG_SHIRQ is not set
# CONFIG_DETECT_SOFTLOCKUP is not set
# CONFIG_SCHED_DEBUG is not set
# CONFIG_SCHEDSTATS is not set
# CONFIG_TIMER_STATS is not set
# CONFIG_DEBUG_SLAB is not set
# CONFIG_DEBUG_RT_MUTEXES is not set
# CONFIG_RT_MUTEX_TESTER is not set
# CONFIG_DEBUG_SPINLOCK is not set
# CONFIG_DEBUG_MUTEXES is not set
# CONFIG_DEBUG_LOCK_ALLOC is not set
# CONFIG_PROVE_LOCKING is not set
# CONFIG_LOCK_STAT is not set
# CONFIG_DEBUG_SPINLOCK_SLEEP is not set
# CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
CONFIG_DEBUG_KOBJECT=3Dy
CONFIG_DEBUG_BUGVERBOSE=3Dy
CONFIG_DEBUG_INFO=3Dy
CONFIG_DEBUG_VM=3Dy
# CONFIG_DEBUG_LIST is not set
# CONFIG_DEBUG_SG is not set
CONFIG_FRAME_POINTER=3Dy
CONFIG_FORCED_INLINING=3Dy
# CONFIG_BOOT_PRINTK_DELAY is not set
# CONFIG_FAULT_INJECTION is not set
# CONFIG_SAMPLES is not set
CONFIG_DEBUG_USER=3Dy
CONFIG_DEBUG_ERRORS=3Dy
CONFIG_DEBUG_LL=3Dy
# CONFIG_DEBUG_ICEDCC is not set

#
# Security options
#
# CONFIG_KEYS is not set
# CONFIG_SECURITY_FILE_CAPABILITIES is not set
# CONFIG_CRYPTO is not set

#
# Library routines
#
# CONFIG_CRC_CCITT is not set
# CONFIG_CRC16 is not set
# CONFIG_CRC_ITU_T is not set
# CONFIG_CRC32 is not set
# CONFIG_CRC7 is not set
# CONFIG_LIBCRC32C is not set
CONFIG_PLIST=3Dy
CONFIG_HAS_IOMEM=3Dy
CONFIG_HAS_IOPORT=3Dy
CONFIG_HAS_DMA=3Dy

--------------030600010007060101040903
Content-Type: text/x-vcard; charset=utf-8;
 name="narmstrong.vcf"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="narmstrong.vcf"

begin:vcard
fn:Neil Armstrong
n:Armstrong;Neil
org:Neotion;Neotion Sophia Antipolis
email;internet:narmstrong@domain.hid
title;quoted-printable:Ing=3DC3=3DA9nieur Software Embarqu=3DC3=3DA9
tel;cell:0667474169
note:PGP 0x1166F485
version:2.1
end:vcard


--------------030600010007060101040903--

--------------enig76C831770B0822F72AFD6941
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFH7Lyzb5rmahFm9IURAr18AKDfhI+569uaGRZFsmZQ6MIq1OdBCACeIHly
x1YZyJem8DNyUWHbIYSzwRo=
=Y2eX
-----END PGP SIGNATURE-----

--------------enig76C831770B0822F72AFD6941--

