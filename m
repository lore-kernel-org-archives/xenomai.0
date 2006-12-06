Message-ID: <4576842B.1090203@domain.hid>
Date: Wed, 06 Dec 2006 09:49:47 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig72E1B4A3D82280D8C2178A32"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] [RFC] type-based spinlock op selection
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
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig72E1B4A3D82280D8C2178A32
Content-Type: multipart/mixed; boundary="------------040004090601070008030904"

This is a multi-part message in MIME format.
--------------040004090601070008030904
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,

reading through the I-pipe patch I noticed that there are quite a few
spin_lock->spin_lock_hw and similar conversions. Having the conversion
mechanism of the -rt patch in mind, I wrote the attached I-pipe cleanup
that applies a similar pattern on this issue. Gives more than 10k patch
size reduction for x86 and a bit more safety against minor variations of
the patched code. Still, review of the lock usages keeps on being
required as the lock user could assume running IRQs off while I-pipe may
not guarantee this.

The required patch for Xenomai is attached as well.

Jan

--------------040004090601070008030904
Content-Type: text/x-patch;
 name="type-based-spinlocks.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="type-based-spinlocks.patch"

---
 arch/i386/kernel/apic.c                  |    4 -
 arch/i386/kernel/i8253.c                 |    6 -
 arch/i386/kernel/i8259.c                 |   24 +++----
 arch/i386/kernel/io_apic.c               |  100 +++++++++++++++---------=
-------
 arch/i386/kernel/ipipe.c                 |   10 +--
 arch/i386/kernel/time.c                  |    4 -
 arch/i386/mach-visws/visws_apic.c        |   24 +++----
 arch/i386/mach-voyager/voyager_basic.c   |    8 +-
 drivers/ide/legacy/hd.c                  |    4 -
 drivers/input/gameport/gameport.c        |    4 -
 drivers/input/joystick/analog.c          |    4 -
 drivers/pci/htirq.c                      |   10 +--
 include/asm-i386/i8253.h                 |    2=20
 include/asm-i386/i8259.h                 |    2=20
 include/asm-i386/mach-default/do_timer.h |    4 -
 include/linux/ipipe.h                    |   40 ------------
 include/linux/spinlock.h                 |   88 +++++++++++++++++++++++-=
---
 include/linux/spinlock_types.h           |   12 +++
 kernel/ipipe/core.c                      |   20 +++---
 kernel/ipipe/tracer.c                    |   14 ++--
 kernel/printk.c                          |   10 +--
 21 files changed, 216 insertions(+), 178 deletions(-)

Index: linux-2.6.19-ipipe/arch/i386/kernel/apic.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.19-ipipe.orig/arch/i386/kernel/apic.c
+++ linux-2.6.19-ipipe/arch/i386/kernel/apic.c
@@ -929,13 +929,13 @@ static unsigned int __devinit get_8254_t
=20
 	unsigned int count;
=20
-	spin_lock_irqsave_hw(&i8253_lock, flags);
+	spin_lock_irqsave(&i8253_lock, flags);
=20
 	outb_p(0x00, PIT_MODE);
 	count =3D inb_p(PIT_CH0);
 	count |=3D inb_p(PIT_CH0) << 8;
=20
-	spin_unlock_irqrestore_hw(&i8253_lock, flags);
+	spin_unlock_irqrestore(&i8253_lock, flags);
=20
 	return count;
 }
Index: linux-2.6.19-ipipe/arch/i386/kernel/i8253.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.19-ipipe.orig/arch/i386/kernel/i8253.c
+++ linux-2.6.19-ipipe/arch/i386/kernel/i8253.c
@@ -16,20 +16,20 @@
=20
 #include "io_ports.h"
=20
-DEFINE_SPINLOCK(i8253_lock);
+IPIPE_DEFINE_SPINLOCK(i8253_lock);
 EXPORT_SYMBOL(i8253_lock);
=20
 void setup_pit_timer(void)
 {
 	unsigned long flags;
=20
-	spin_lock_irqsave_hw(&i8253_lock, flags);
+	spin_lock_irqsave(&i8253_lock, flags);
 	outb_p(0x34,PIT_MODE);		/* binary, mode 2, LSB/MSB, ch 0 */
 	udelay(10);
 	outb_p(LATCH & 0xff , PIT_CH0);	/* LSB */
 	udelay(10);
 	outb(LATCH >> 8 , PIT_CH0);	/* MSB */
-	spin_unlock_irqrestore_hw(&i8253_lock, flags);
+	spin_unlock_irqrestore(&i8253_lock, flags);
 }
=20
 /*
Index: linux-2.6.19-ipipe/arch/i386/kernel/i8259.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.19-ipipe.orig/arch/i386/kernel/i8259.c
+++ linux-2.6.19-ipipe/arch/i386/kernel/i8259.c
@@ -35,7 +35,7 @@
  */
=20
 static int i8259A_auto_eoi;
-DEFINE_SPINLOCK(i8259A_lock);
+IPIPE_DEFINE_SPINLOCK(i8259A_lock);
 static void mask_and_ack_8259A(unsigned int);
=20
 #ifdef CONFIG_IPIPE
@@ -87,14 +87,14 @@ void disable_8259A_irq(unsigned int irq)
 	unsigned int mask =3D 1 << irq;
 	unsigned long flags;
=20
-	spin_lock_irqsave_hw(&i8259A_lock, flags);
+	spin_lock_irqsave(&i8259A_lock, flags);
 	ipipe_irq_lock(irq);
 	cached_irq_mask |=3D mask;
 	if (irq & 8)
 		outb(cached_slave_mask, PIC_SLAVE_IMR);
 	else
 		outb(cached_master_mask, PIC_MASTER_IMR);
-	spin_unlock_irqrestore_hw(&i8259A_lock, flags);
+	spin_unlock_irqrestore(&i8259A_lock, flags);
 }
=20
 void enable_8259A_irq(unsigned int irq)
@@ -102,7 +102,7 @@ void enable_8259A_irq(unsigned int irq)
 	unsigned int mask =3D (1 << irq);
 	unsigned long flags;
=20
-	spin_lock_irqsave_hw(&i8259A_lock, flags);
+	spin_lock_irqsave(&i8259A_lock, flags);
 	if (cached_irq_mask & mask) {
 		cached_irq_mask &=3D ~mask;
 		if (irq & 8)
@@ -111,7 +111,7 @@ void enable_8259A_irq(unsigned int irq)
 			outb(cached_master_mask, PIC_MASTER_IMR);
 		ipipe_irq_unlock(irq);
 	}
-	spin_unlock_irqrestore_hw(&i8259A_lock, flags);
+	spin_unlock_irqrestore(&i8259A_lock, flags);
 }
=20
 int i8259A_irq_pending(unsigned int irq)
@@ -120,12 +120,12 @@ int i8259A_irq_pending(unsigned int irq)
 	unsigned long flags;
 	int ret;
=20
-	spin_lock_irqsave_hw(&i8259A_lock, flags);
+	spin_lock_irqsave(&i8259A_lock, flags);
 	if (irq < 8)
 		ret =3D inb(PIC_MASTER_CMD) & mask;
 	else
 		ret =3D inb(PIC_SLAVE_CMD) & (mask >> 8);
-	spin_unlock_irqrestore_hw(&i8259A_lock, flags);
+	spin_unlock_irqrestore(&i8259A_lock, flags);
=20
 	return ret;
 }
@@ -173,7 +173,7 @@ static void mask_and_ack_8259A(unsigned=20
 	unsigned int irqmask =3D 1 << irq;
 	unsigned long flags;
=20
-	spin_lock_irqsave_hw(&i8259A_lock, flags);
+	spin_lock_irqsave(&i8259A_lock, flags);
 	/*
 	 * Lightweight spurious IRQ detection. We do not want
 	 * to overdo spurious IRQ handling - it's usually a sign
@@ -196,7 +196,7 @@ static void mask_and_ack_8259A(unsigned=20
 	    /* Fast timer ack -- don't mask (unless supposedly
 	      spurious) */
 	    outb(0x20,PIC_MASTER_CMD);
-	    spin_unlock_irqrestore_hw(&i8259A_lock, flags);
+	    spin_unlock_irqrestore(&i8259A_lock, flags);
 	    return;
 	}
 #endif /* CONFIG_IPIPE */
@@ -213,7 +213,7 @@ handle_real_irq:
 		outb(cached_master_mask, PIC_MASTER_IMR);
 		outb(0x60+irq,PIC_MASTER_CMD);	/* 'Specific EOI to master */
 	}
-	spin_unlock_irqrestore_hw(&i8259A_lock, flags);
+	spin_unlock_irqrestore(&i8259A_lock, flags);
 	return;
=20
 spurious_8259A_irq:
@@ -316,7 +316,7 @@ void init_8259A(int auto_eoi)
=20
 	i8259A_auto_eoi =3D auto_eoi;
=20
-	spin_lock_irqsave_hw(&i8259A_lock, flags);
+	spin_lock_irqsave(&i8259A_lock, flags);
=20
 	outb(0xff, PIC_MASTER_IMR);	/* mask all of 8259A-1 */
 	outb(0xff, PIC_SLAVE_IMR);	/* mask all of 8259A-2 */
@@ -350,7 +350,7 @@ void init_8259A(int auto_eoi)
 	outb(cached_master_mask, PIC_MASTER_IMR); /* restore master IRQ mask */=

 	outb(cached_slave_mask, PIC_SLAVE_IMR);	  /* restore slave IRQ mask */
=20
-	spin_unlock_irqrestore_hw(&i8259A_lock, flags);
+	spin_unlock_irqrestore(&i8259A_lock, flags);
 }
=20
 /*
Index: linux-2.6.19-ipipe/arch/i386/kernel/io_apic.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.19-ipipe.orig/arch/i386/kernel/io_apic.c
+++ linux-2.6.19-ipipe/arch/i386/kernel/io_apic.c
@@ -55,8 +55,8 @@ atomic_t irq_mis_count;
 /* Where if anywhere is the i8259 connect in external int mode */
 static struct { int pin, apic; } ioapic_i8259 =3D { -1, -1 };
=20
-static DEFINE_SPINLOCK(ioapic_lock);
-static DEFINE_SPINLOCK(vector_lock);
+static IPIPE_DEFINE_SPINLOCK(ioapic_lock);
+static IPIPE_DEFINE_SPINLOCK(vector_lock);
=20
 int timer_over_8254 __initdata =3D 1;
=20
@@ -140,10 +140,10 @@ static struct IO_APIC_route_entry ioapic
 {
 	union entry_union eu;
 	unsigned long flags;
-	spin_lock_irqsave_hw(&ioapic_lock, flags);
+	spin_lock_irqsave(&ioapic_lock, flags);
 	eu.w1 =3D io_apic_read(apic, 0x10 + 2 * pin);
 	eu.w2 =3D io_apic_read(apic, 0x11 + 2 * pin);
-	spin_unlock_irqrestore_hw(&ioapic_lock, flags);
+	spin_unlock_irqrestore(&ioapic_lock, flags);
 	return eu.entry;
 }
=20
@@ -158,10 +158,10 @@ static void ioapic_write_entry(int apic,
 	unsigned long flags;
 	union entry_union eu;
 	eu.entry =3D e;
-	spin_lock_irqsave_hw(&ioapic_lock, flags);
+	spin_lock_irqsave(&ioapic_lock, flags);
 	io_apic_write(apic, 0x11 + 2*pin, eu.w2);
 	io_apic_write(apic, 0x10 + 2*pin, eu.w1);
-	spin_unlock_irqrestore_hw(&ioapic_lock, flags);
+	spin_unlock_irqrestore(&ioapic_lock, flags);
 }
=20
 /*
@@ -174,10 +174,10 @@ static void ioapic_mask_entry(int apic,=20
 	unsigned long flags;
 	union entry_union eu =3D { .entry.mask =3D 1 };
=20
-	spin_lock_irqsave_hw(&ioapic_lock, flags);
+	spin_lock_irqsave(&ioapic_lock, flags);
 	io_apic_write(apic, 0x10 + 2*pin, eu.w1);
 	io_apic_write(apic, 0x11 + 2*pin, eu.w2);
-	spin_unlock_irqrestore_hw(&ioapic_lock, flags);
+	spin_unlock_irqrestore(&ioapic_lock, flags);
 }
=20
 /*
@@ -270,20 +270,20 @@ static void mask_IO_APIC_irq (unsigned i
 {
 	unsigned long flags;
=20
-	spin_lock_irqsave_hw(&ioapic_lock, flags);
+	spin_lock_irqsave(&ioapic_lock, flags);
 	ipipe_irq_lock(irq);
 	__mask_IO_APIC_irq(irq);
-	spin_unlock_irqrestore_hw(&ioapic_lock, flags);
+	spin_unlock_irqrestore(&ioapic_lock, flags);
 }
=20
 static void unmask_IO_APIC_irq (unsigned int irq)
 {
 	unsigned long flags;
=20
-	spin_lock_irqsave_hw(&ioapic_lock, flags);
+	spin_lock_irqsave(&ioapic_lock, flags);
 	__unmask_IO_APIC_irq(irq);
 	ipipe_irq_unlock(irq);
-	spin_unlock_irqrestore_hw(&ioapic_lock, flags);
+	spin_unlock_irqrestore(&ioapic_lock, flags);
 }
=20
 static void clear_IO_APIC_pin(unsigned int apic, unsigned int pin)
@@ -328,7 +328,7 @@ static void set_ioapic_affinity_irq(unsi
 	apicid_value =3D cpu_mask_to_apicid(cpumask);
 	/* Prepare to do the io_apic_write */
 	apicid_value =3D apicid_value << 24;
-	spin_lock_irqsave_hw(&ioapic_lock, flags);
+	spin_lock_irqsave(&ioapic_lock, flags);
 	for (;;) {
 		pin =3D entry->pin;
 		if (pin =3D=3D -1)
@@ -339,7 +339,7 @@ static void set_ioapic_affinity_irq(unsi
 		entry =3D irq_2_pin + entry->next;
 	}
 	set_native_irq_info(irq, cpumask);
-	spin_unlock_irqrestore_hw(&ioapic_lock, flags);
+	spin_unlock_irqrestore(&ioapic_lock, flags);
 }
=20
 #if defined(CONFIG_IRQBALANCE)
@@ -1274,9 +1274,9 @@ static int assign_irq_vector(int irq)
 	unsigned long flags;
 	int vector;
=20
-	spin_lock_irqsave_hw(&vector_lock, flags);
+	spin_lock_irqsave(&vector_lock, flags);
 	vector =3D __assign_irq_vector(irq);
-	spin_unlock_irqrestore_hw(&vector_lock, flags);
+	spin_unlock_irqrestore(&vector_lock, flags);
=20
 	return vector;
 }
@@ -1366,9 +1366,9 @@ static void __init setup_IO_APIC_irqs(vo
 				disable_8259A_irq(irq);
 		}
 		ioapic_write_entry(apic, pin, entry);
-		spin_lock_irqsave_hw(&ioapic_lock, flags);
+		spin_lock_irqsave(&ioapic_lock, flags);
 		set_native_irq_info(irq, TARGET_CPUS);
-		spin_unlock_irqrestore_hw(&ioapic_lock, flags);
+		spin_unlock_irqrestore(&ioapic_lock, flags);
 	}
 	}
=20
@@ -1446,14 +1446,14 @@ void __init print_IO_APIC(void)
=20
 	for (apic =3D 0; apic < nr_ioapics; apic++) {
=20
-	spin_lock_irqsave_hw(&ioapic_lock, flags);
+	spin_lock_irqsave(&ioapic_lock, flags);
 	reg_00.raw =3D io_apic_read(apic, 0);
 	reg_01.raw =3D io_apic_read(apic, 1);
 	if (reg_01.bits.version >=3D 0x10)
 		reg_02.raw =3D io_apic_read(apic, 2);
 	if (reg_01.bits.version >=3D 0x20)
 		reg_03.raw =3D io_apic_read(apic, 3);
-	spin_unlock_irqrestore_hw(&ioapic_lock, flags);
+	spin_unlock_irqrestore(&ioapic_lock, flags);
=20
 	printk(KERN_DEBUG "IO APIC #%d......\n", mp_ioapics[apic].mpc_apicid);
 	printk(KERN_DEBUG ".... register #00: %08X\n", reg_00.raw);
@@ -1683,7 +1683,7 @@ void /*__init*/ print_PIC(void)
=20
 	printk(KERN_DEBUG "\nprinting PIC contents\n");
=20
-	spin_lock_irqsave_hw(&i8259A_lock, flags);
+	spin_lock_irqsave(&i8259A_lock, flags);
=20
 	v =3D inb(0xa1) << 8 | inb(0x21);
 	printk(KERN_DEBUG "... PIC  IMR: %04x\n", v);
@@ -1697,7 +1697,7 @@ void /*__init*/ print_PIC(void)
 	outb(0x0a,0xa0);
 	outb(0x0a,0x20);
=20
-	spin_unlock_irqrestore_hw(&i8259A_lock, flags);
+	spin_unlock_irqrestore(&i8259A_lock, flags);
=20
 	printk(KERN_DEBUG "... PIC  ISR: %04x\n", v);
=20
@@ -1726,9 +1726,9 @@ static void __init enable_IO_APIC(void)
 	 * The number of IO-APIC IRQ registers (=3D=3D #pins):
 	 */
 	for (apic =3D 0; apic < nr_ioapics; apic++) {
-		spin_lock_irqsave_hw(&ioapic_lock, flags);
+		spin_lock_irqsave(&ioapic_lock, flags);
 		reg_01.raw =3D io_apic_read(apic, 1);
-		spin_unlock_irqrestore_hw(&ioapic_lock, flags);
+		spin_unlock_irqrestore(&ioapic_lock, flags);
 		nr_ioapic_registers[apic] =3D reg_01.bits.entries+1;
 	}
 	for(apic =3D 0; apic < nr_ioapics; apic++) {
@@ -1850,9 +1850,9 @@ static void __init setup_ioapic_ids_from
 	for (apic =3D 0; apic < nr_ioapics; apic++) {
=20
 		/* Read the register 0 value */
-		spin_lock_irqsave_hw(&ioapic_lock, flags);
+		spin_lock_irqsave(&ioapic_lock, flags);
 		reg_00.raw =3D io_apic_read(apic, 0);
-		spin_unlock_irqrestore_hw(&ioapic_lock, flags);
+		spin_unlock_irqrestore(&ioapic_lock, flags);
 	=09
 		old_id =3D mp_ioapics[apic].mpc_apicid;
=20
@@ -1911,16 +1911,16 @@ static void __init setup_ioapic_ids_from
 			mp_ioapics[apic].mpc_apicid);
=20
 		reg_00.bits.ID =3D mp_ioapics[apic].mpc_apicid;
-		spin_lock_irqsave_hw(&ioapic_lock, flags);
+		spin_lock_irqsave(&ioapic_lock, flags);
 		io_apic_write(apic, 0, reg_00.raw);
-		spin_unlock_irqrestore_hw(&ioapic_lock, flags);
+		spin_unlock_irqrestore(&ioapic_lock, flags);
=20
 		/*
 		 * Sanity check
 		 */
-		spin_lock_irqsave_hw(&ioapic_lock, flags);
+		spin_lock_irqsave(&ioapic_lock, flags);
 		reg_00.raw =3D io_apic_read(apic, 0);
-		spin_unlock_irqrestore_hw(&ioapic_lock, flags);
+		spin_unlock_irqrestore(&ioapic_lock, flags);
 		if (reg_00.bits.ID !=3D mp_ioapics[apic].mpc_apicid)
 			printk("could not set ID!\n");
 		else
@@ -1991,7 +1991,7 @@ static unsigned int startup_ioapic_irq(u
 	int was_pending =3D 0;
 	unsigned long flags;
=20
-	spin_lock_irqsave_hw(&ioapic_lock, flags);
+	spin_lock_irqsave(&ioapic_lock, flags);
 	if (irq < 16) {
 		disable_8259A_irq(irq);
 		if (i8259A_irq_pending(irq))
@@ -1999,7 +1999,7 @@ static unsigned int startup_ioapic_irq(u
 	}
 	__unmask_IO_APIC_irq(irq);
 	ipipe_irq_unlock(irq);
-	spin_unlock_irqrestore_hw(&ioapic_lock, flags);
+	spin_unlock_irqrestore(&ioapic_lock, flags);
=20
 	return was_pending;
 }
@@ -2047,10 +2047,10 @@ static void ack_ioapic_quirk_irq(unsigne
=20
 	if (!(v & (1 << (i & 0x1f)))) {
 		atomic_inc(&irq_mis_count);
-		spin_lock_hw(&ioapic_lock);
+		spin_lock(&ioapic_lock);
 		__mask_and_edge_IO_APIC_irq(irq);
 		__unmask_and_level_IO_APIC_irq(irq);
-		spin_unlock_hw(&ioapic_lock);
+		spin_unlock(&ioapic_lock);
 	}
 }
=20
@@ -2143,22 +2143,22 @@ static void mask_lapic_irq (unsigned int
 {
 	unsigned long v, flags;
=20
-	spin_lock_irqsave_hw(&ioapic_lock, flags);
+	spin_lock_irqsave(&ioapic_lock, flags);
 	ipipe_irq_lock(irq);
 	v =3D apic_read(APIC_LVT0);
 	apic_write_around(APIC_LVT0, v | APIC_LVT_MASKED);
-	spin_unlock_irqrestore_hw(&ioapic_lock, flags);
+	spin_unlock_irqrestore(&ioapic_lock, flags);
 }
=20
 static void unmask_lapic_irq (unsigned int irq)
 {
 	unsigned long v, flags;
=20
-	spin_lock_irqsave_hw(&ioapic_lock, flags);
+	spin_lock_irqsave(&ioapic_lock, flags);
 	v =3D apic_read(APIC_LVT0);
 	apic_write_around(APIC_LVT0, v & ~APIC_LVT_MASKED);
 	ipipe_irq_unlock(irq);
-	spin_unlock_irqrestore_hw(&ioapic_lock, flags);
+	spin_unlock_irqrestore(&ioapic_lock, flags);
 }
=20
 #ifdef CONFIG_IPIPE
@@ -2475,13 +2475,13 @@ static int ioapic_resume(struct sys_devi
 	data =3D container_of(dev, struct sysfs_ioapic_data, dev);
 	entry =3D data->entry;
=20
-	spin_lock_irqsave_hw(&ioapic_lock, flags);
+	spin_lock_irqsave(&ioapic_lock, flags);
 	reg_00.raw =3D io_apic_read(dev->id, 0);
 	if (reg_00.bits.ID !=3D mp_ioapics[dev->id].mpc_apicid) {
 		reg_00.bits.ID =3D mp_ioapics[dev->id].mpc_apicid;
 		io_apic_write(dev->id, 0, reg_00.raw);
 	}
-	spin_unlock_irqrestore_hw(&ioapic_lock, flags);
+	spin_unlock_irqrestore(&ioapic_lock, flags);
 	for (i =3D 0; i < nr_ioapic_registers[dev->id]; i ++)
 		ioapic_write_entry(dev->id, i, entry[i]);
=20
@@ -2823,9 +2823,9 @@ int __init io_apic_get_unique_id (int io
 	if (physids_empty(apic_id_map))
 		apic_id_map =3D ioapic_phys_id_map(phys_cpu_present_map);
=20
-	spin_lock_irqsave_hw(&ioapic_lock, flags);
+	spin_lock_irqsave(&ioapic_lock, flags);
 	reg_00.raw =3D io_apic_read(ioapic, 0);
-	spin_unlock_irqrestore_hw(&ioapic_lock, flags);
+	spin_unlock_irqrestore(&ioapic_lock, flags);
=20
 	if (apic_id >=3D get_physical_broadcast()) {
 		printk(KERN_WARNING "IOAPIC[%d]: Invalid apic_id %d, trying "
@@ -2859,10 +2859,10 @@ int __init io_apic_get_unique_id (int io
 	if (reg_00.bits.ID !=3D apic_id) {
 		reg_00.bits.ID =3D apic_id;
=20
-		spin_lock_irqsave_hw(&ioapic_lock, flags);
+		spin_lock_irqsave(&ioapic_lock, flags);
 		io_apic_write(ioapic, 0, reg_00.raw);
 		reg_00.raw =3D io_apic_read(ioapic, 0);
-		spin_unlock_irqrestore_hw(&ioapic_lock, flags);
+		spin_unlock_irqrestore(&ioapic_lock, flags);
=20
 		/* Sanity check */
 		if (reg_00.bits.ID !=3D apic_id) {
@@ -2883,9 +2883,9 @@ int __init io_apic_get_version (int ioap
 	union IO_APIC_reg_01	reg_01;
 	unsigned long flags;
=20
-	spin_lock_irqsave_hw(&ioapic_lock, flags);
+	spin_lock_irqsave(&ioapic_lock, flags);
 	reg_01.raw =3D io_apic_read(ioapic, 1);
-	spin_unlock_irqrestore_hw(&ioapic_lock, flags);
+	spin_unlock_irqrestore(&ioapic_lock, flags);
=20
 	return reg_01.bits.version;
 }
@@ -2896,9 +2896,9 @@ int __init io_apic_get_redir_entries (in
 	union IO_APIC_reg_01	reg_01;
 	unsigned long flags;
=20
-	spin_lock_irqsave_hw(&ioapic_lock, flags);
+	spin_lock_irqsave(&ioapic_lock, flags);
 	reg_01.raw =3D io_apic_read(ioapic, 1);
-	spin_unlock_irqrestore_hw(&ioapic_lock, flags);
+	spin_unlock_irqrestore(&ioapic_lock, flags);
=20
 	return reg_01.bits.entries;
 }
@@ -2949,9 +2949,9 @@ int io_apic_set_pci_routing (int ioapic,
 		disable_8259A_irq(irq);
=20
 	ioapic_write_entry(ioapic, pin, entry);
-	spin_lock_irqsave_hw(&ioapic_lock, flags);
+	spin_lock_irqsave(&ioapic_lock, flags);
 	set_native_irq_info(irq, TARGET_CPUS);
-	spin_unlock_irqrestore_hw(&ioapic_lock, flags);
+	spin_unlock_irqrestore(&ioapic_lock, flags);
=20
 	return 0;
 }
Index: linux-2.6.19-ipipe/arch/i386/kernel/time.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.19-ipipe.orig/arch/i386/kernel/time.c
+++ linux-2.6.19-ipipe/arch/i386/kernel/time.c
@@ -181,11 +181,11 @@ irqreturn_t timer_interrupt(int irq, voi
 		 * on an 82489DX-based system.
 		 */
 		unsigned long flags;
-		spin_lock_irqsave_hw_cond(&i8259A_lock,flags);
+		spin_lock_irqsave_cond(&i8259A_lock,flags);
 		outb(0x0c, PIC_MASTER_OCW3);
 		/* Ack the IRQ; AEOI will end it automatically. */
 		inb(PIC_MASTER_POLL);
-		spin_unlock_irqrestore_hw_cond(&i8259A_lock,flags);
+		spin_unlock_irqrestore_cond(&i8259A_lock,flags);
 	}
 #endif
=20
Index: linux-2.6.19-ipipe/include/asm-i386/mach-default/do_timer.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.19-ipipe.orig/include/asm-i386/mach-default/do_timer.h
+++ linux-2.6.19-ipipe/include/asm-i386/mach-default/do_timer.h
@@ -56,13 +56,13 @@ static inline int do_timer_overflow(int=20
 	int i;
 	unsigned long flags;
=20
-	spin_lock_irqsave_hw(&i8259A_lock, flags);
+	spin_lock_irqsave(&i8259A_lock, flags);
 	/*
 	 * This is tricky when I/O APICs are used;
 	 * see do_timer_interrupt().
 	 */
 	i =3D inb(0x20);
-	spin_unlock_irqrestore_hw(&i8259A_lock, flags);
+	spin_unlock_irqrestore(&i8259A_lock, flags);
 =09
 	/* assumption about timer being IRQ0 */
 	if (i & 0x01) {
Index: linux-2.6.19-ipipe/include/linux/ipipe.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.19-ipipe.orig/include/linux/ipipe.h
+++ linux-2.6.19-ipipe/include/linux/ipipe.h
@@ -229,9 +229,6 @@ do { \
 	} \
 } while(0)
=20
-#define spin_lock_hw(x)		__raw_spin_lock(&(x)->raw_lock)
-#define spin_trylock_hw(x)		__raw_spin_trylock(&(x)->raw_lock)
-#define spin_unlock_hw(x)		__raw_spin_unlock(&(x)->raw_lock)
 #if defined(CONFIG_SMP) || defined(CONFIG_DEBUG_SPINLOCK)
 #define write_lock_hw(x)		__raw_write_lock(&(x)->raw_lock)
 #define write_trylock_hw(x)		__raw_write_trylock(&(x)->raw_lock)
@@ -248,35 +245,9 @@ do { \
 #define read_unlock_hw(lock)		do { (void)(lock); } while (0)
 #endif /* CONFIG_SMP || CONFIG_DEBUG_SPINLOCK */
=20
-typedef spinlock_t			ipipe_spinlock_t;
 typedef rwlock_t			ipipe_rwlock_t;
-#define IPIPE_SPIN_LOCK_UNLOCKED	SPIN_LOCK_UNLOCKED
 #define IPIPE_RW_LOCK_UNLOCKED		RW_LOCK_UNLOCKED
=20
-#define spin_lock_irqsave_hw(x,flags)		\
-do {						\
-	local_irq_save_hw(flags);		\
-	spin_lock_hw(x);			\
-} while (0)
-
-#define spin_unlock_irqrestore_hw(x,flags)	\
-do {						\
-	spin_unlock_hw(x);			\
-	local_irq_restore_hw(flags);		\
-} while (0)
-
-#define spin_lock_irq_hw(x)			\
-do {						\
-	local_irq_disable_hw();			\
-	spin_lock_hw(x);			\
-} while (0)
-
-#define spin_unlock_irq_hw(x)			\
-do {						\
-	spin_unlock_hw(x);			\
-	local_irq_enable_hw();			\
-} while (0)
-
 #define read_lock_irqsave_hw(lock, flags)	\
 do {						\
 	local_irq_save_hw(flags);		\
@@ -688,8 +659,6 @@ void fastcall *ipipe_get_ptd(int key);
 			local_irq_disable_hw();		\
 	} while(0)
=20
-#define spin_lock_irqsave_hw_cond(lock,flags)	spin_lock_irqsave_hw(lock,=
flags)
-#define spin_unlock_irqrestore_hw_cond(lock,flags)	spin_unlock_irqrestor=
e_hw(lock,flags)
 #define smp_processor_id_hw()				ipipe_processor_id()
=20
 #define ipipe_irq_lock(irq)						\
@@ -720,19 +689,10 @@ void fastcall *ipipe_get_ptd(int key);
 #define ipipe_trap_notify(t,r)	0
 #define ipipe_init_proc()		do { } while(0)
=20
-#define spin_lock_hw(lock)			spin_lock(lock)
-#define spin_unlock_hw(lock)			spin_unlock(lock)
-#define spin_lock_irq_hw(lock)		spin_lock_irq(lock)
-#define spin_unlock_irq_hw(lock)		spin_unlock_irq(lock)
-#define spin_lock_irqsave_hw(lock,flags)	spin_lock_irqsave(lock, flags)
-#define spin_unlock_irqrestore_hw(lock,flags)	spin_unlock_irqrestore(loc=
k, flags)
-
 #define local_irq_enable_hw_cond()		do { } while(0)
 #define local_irq_disable_hw_cond()		do { } while(0)
 #define local_irq_save_hw_cond(flags)	do { (void)(flags); } while(0)
 #define local_irq_restore_hw_cond(flags)	do { } while(0)
-#define spin_lock_irqsave_hw_cond(lock,flags)	do { (void)(flags); spin_l=
ock(lock); } while(0)
-#define spin_unlock_irqrestore_hw_cond(lock,flags)	spin_unlock(lock)
 #define smp_processor_id_hw()			smp_processor_id()
=20
 #define ipipe_irq_lock(irq)		do { } while(0)
Index: linux-2.6.19-ipipe/include/linux/spinlock.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.19-ipipe.orig/include/linux/spinlock.h
+++ linux-2.6.19-ipipe/include/linux/spinlock.h
@@ -171,7 +171,15 @@ do {								\
 #define read_trylock(lock)		__cond_lock(lock, _read_trylock(lock))
 #define write_trylock(lock)		__cond_lock(lock, _write_trylock(lock))
=20
-#define spin_lock(lock)			_spin_lock(lock)
+#define __IS_LOCKTYPE(lock, type) \
+	__builtin_types_compatible_p(typeof(lock), type *)
+
+#define spin_lock(lock) do { \
+	if (__IS_LOCKTYPE(lock, ipipe_spinlock_t)) \
+		__raw_spin_lock(&((ipipe_spinlock_t *)lock)->__raw_lock); \
+	else \
+		_spin_lock(lock); \
+} while (0)
=20
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 # define spin_lock_nested(lock, subclass) _spin_lock_nested(lock, subcla=
ss)
@@ -184,7 +192,13 @@ do {								\
=20
 #if defined(CONFIG_SMP) || defined(CONFIG_DEBUG_SPINLOCK)
=20
-#define spin_lock_irqsave(lock, flags)	flags =3D _spin_lock_irqsave(lock=
)
+#define spin_lock_irqsave(lock, flags) do { \
+	if (__IS_LOCKTYPE(lock, ipipe_spinlock_t)) { \
+		local_irq_save_hw(flags); \
+		__raw_spin_lock(&((ipipe_spinlock_t *)lock)->__raw_lock); \
+	} else \
+		flags =3D _spin_lock_irqsave(lock); \
+} while (0)
 #define read_lock_irqsave(lock, flags)	flags =3D _read_lock_irqsave(lock=
)
 #define write_lock_irqsave(lock, flags)	flags =3D _write_lock_irqsave(lo=
ck)
=20
@@ -198,7 +212,13 @@ do {								\
=20
 #else
=20
-#define spin_lock_irqsave(lock, flags)	_spin_lock_irqsave(lock, flags)
+#define spin_lock_irqsave(lock, flags) do { \
+	if (__IS_LOCKTYPE(lock, ipipe_spinlock_t)) { \
+		local_irq_save_hw(flags); \
+		__raw_spin_lock(&((ipipe_spinlock_t *)lock)->__raw_lock); \
+	} else \
+		_spin_lock_irqsave(lock, flags); \
+} while (0)
 #define read_lock_irqsave(lock, flags)	_read_lock_irqsave(lock, flags)
 #define write_lock_irqsave(lock, flags)	_write_lock_irqsave(lock, flags)=

 #define spin_lock_irqsave_nested(lock, flags, subclass)	\
@@ -206,7 +226,13 @@ do {								\
=20
 #endif
=20
-#define spin_lock_irq(lock)		_spin_lock_irq(lock)
+#define spin_lock_irq(lock) do { \
+	if (__IS_LOCKTYPE(lock, ipipe_spinlock_t)) { \
+		local_irq_disable_hw(); \
+		__raw_spin_lock(&((ipipe_spinlock_t *)lock)->__raw_lock); \
+	} else \
+		_spin_lock_irq(lock); \
+} while (0)
 #define spin_lock_bh(lock)		_spin_lock_bh(lock)
=20
 #define read_lock_irq(lock)		_read_lock_irq(lock)
@@ -220,26 +246,54 @@ do {								\
  */
 #if defined(CONFIG_DEBUG_SPINLOCK) || defined(CONFIG_PREEMPT) || \
 	!defined(CONFIG_SMP)
-# define spin_unlock(lock)		_spin_unlock(lock)
+#define spin_unlock(lock) do { \
+	if (__IS_LOCKTYPE(lock, ipipe_spinlock_t)) \
+		__raw_spin_unlock(&((ipipe_spinlock_t *)lock)->__raw_lock); \
+	else \
+		_spin_unlock(lock); \
+} while (0)
 # define read_unlock(lock)		_read_unlock(lock)
 # define write_unlock(lock)		_write_unlock(lock)
-# define spin_unlock_irq(lock)		_spin_unlock_irq(lock)
+# define spin_unlock_irq(lock) do { \
+	if (__IS_LOCKTYPE(lock, ipipe_spinlock_t)) { \
+		__raw_spin_unlock(&((ipipe_spinlock_t *)lock)->__raw_lock); \
+		local_irq_enable_hw(); \
+	} else \
+		_spin_unlock_irq(lock); \
+} while (0)
 # define read_unlock_irq(lock)		_read_unlock_irq(lock)
 # define write_unlock_irq(lock)		_write_unlock_irq(lock)
 #else
-# define spin_unlock(lock)		__raw_spin_unlock(&(lock)->raw_lock)
+# define spin_unlock(lock) do { \
+	if (__IS_LOCKTYPE(lock, ipipe_spinlock_t)) \
+		__raw_spin_unlock(&((ipipe_spinlock_t *)lock)->__raw_lock); \
+	else \
+		__raw_spin_unlock(&(lock)->raw_lock); \
+} while (0)
 # define read_unlock(lock)		__raw_read_unlock(&(lock)->raw_lock)
 # define write_unlock(lock)		__raw_write_unlock(&(lock)->raw_lock)
-# define spin_unlock_irq(lock) \
-    do { __raw_spin_unlock(&(lock)->raw_lock); local_irq_enable(); } whi=
le (0)
+# define spin_unlock_irq(lock) do { \
+	if (__IS_LOCKTYPE(lock, ipipe_spinlock_t)) { \
+		__raw_spin_unlock(&((ipipe_spinlock_t *)lock)->__raw_lock); \
+		local_irq_enable_hw(); \
+	} else { \
+		__raw_spin_unlock(&(lock)->raw_lock); \
+		local_irq_enable(); \
+	} \
+} while (0)
 # define read_unlock_irq(lock) \
     do { __raw_read_unlock(&(lock)->raw_lock); local_irq_enable(); } whi=
le (0)
 # define write_unlock_irq(lock) \
     do { __raw_write_unlock(&(lock)->raw_lock); local_irq_enable(); } wh=
ile (0)
 #endif
=20
-#define spin_unlock_irqrestore(lock, flags) \
-					_spin_unlock_irqrestore(lock, flags)
+#define spin_unlock_irqrestore(lock, flags) do { \
+	if (__IS_LOCKTYPE(lock, ipipe_spinlock_t)) { \
+		__raw_spin_unlock(&((ipipe_spinlock_t *)lock)->__raw_lock); \
+		local_irq_restore_hw(flags); \
+	} else \
+		_spin_unlock_irqrestore(lock, flags); \
+} while (0)
 #define spin_unlock_bh(lock)		_spin_unlock_bh(lock)
=20
 #define read_unlock_irqrestore(lock, flags) \
@@ -286,4 +340,16 @@ extern int _atomic_dec_and_lock(atomic_t
  */
 #define spin_can_lock(lock)	(!spin_is_locked(lock))
=20
+#ifdef CONFIG_IPIPE
+#define spin_lock_irqsave_cond(lock, flags) \
+	spin_lock_irqsave(lock,flags)
+#define spin_unlock_irqrestore_cond(lock, flags) \
+	spin_unlock_irqrestore(lock,flags)
+#else
+#define spin_lock_irqsave_cond(lock, flags) \
+	do { (void)(flags); spin_lock(lock); } while(0)
+#define spin_unlock_irqrestore_cond(lock, flags) \
+	spin_unlock(lock)
+#endif
+
 #endif /* __LINUX_SPINLOCK_H */
Index: linux-2.6.19-ipipe/include/linux/spinlock_types.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.19-ipipe.orig/include/linux/spinlock_types.h
+++ linux-2.6.19-ipipe/include/linux/spinlock_types.h
@@ -31,6 +31,10 @@ typedef struct {
 #endif
 } spinlock_t;
=20
+typedef struct {
+	raw_spinlock_t __raw_lock;
+} ipipe_spinlock_t;
+
 #define SPINLOCK_MAGIC		0xdead4ead
=20
 typedef struct {
@@ -86,9 +90,17 @@ typedef struct {
 #endif
=20
 #define SPIN_LOCK_UNLOCKED	__SPIN_LOCK_UNLOCKED(old_style_spin_init)
+#define IPIPE_SPIN_LOCK_UNLOCKED					\
+	(ipipe_spinlock_t) {	.__raw_lock =3D __RAW_SPIN_LOCK_UNLOCKED }
 #define RW_LOCK_UNLOCKED	__RW_LOCK_UNLOCKED(old_style_rw_init)
=20
 #define DEFINE_SPINLOCK(x)	spinlock_t x =3D __SPIN_LOCK_UNLOCKED(x)
 #define DEFINE_RWLOCK(x)	rwlock_t x =3D __RW_LOCK_UNLOCKED(x)
=20
+#ifdef CONFIG_IPIPE
+#define IPIPE_DEFINE_SPINLOCK(x) ipipe_spinlock_t x =3D IPIPE_SPIN_LOCK_=
UNLOCKED
+#else
+#define IPIPE_DEFINE_SPINLOCK(x) DEFINE_SPINLOCK(x)
+#endif
+
 #endif /* __LINUX_SPINLOCK_TYPES_H */
Index: linux-2.6.19-ipipe/arch/i386/mach-visws/visws_apic.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.19-ipipe.orig/arch/i386/mach-visws/visws_apic.c
+++ linux-2.6.19-ipipe/arch/i386/mach-visws/visws_apic.c
@@ -29,7 +29,7 @@
 #include "irq_vectors.h"
=20
=20
-static DEFINE_SPINLOCK(cobalt_lock);
+static IPIPE_DEFINE_SPINLOCK(cobalt_lock);
=20
 /*
  * Set the given Cobalt APIC Redirection Table entry to point
@@ -94,11 +94,11 @@ static unsigned int startup_cobalt_irq(u
 {
 	unsigned long flags;
=20
-	spin_lock_irqsave_hw(&cobalt_lock, flags);
+	spin_lock_irqsave(&cobalt_lock, flags);
 	if ((irq_desc[irq].status & (IRQ_DISABLED | IRQ_INPROGRESS | IRQ_WAITIN=
G)))
 		irq_desc[irq].status &=3D ~(IRQ_DISABLED | IRQ_INPROGRESS | IRQ_WAITIN=
G);
 	enable_cobalt_irq(irq);
-	spin_unlock_irqrestore_hw(&cobalt_lock, flags);
+	spin_unlock_irqrestore(&cobalt_lock, flags);
 	return 0;
 }
=20
@@ -106,20 +106,20 @@ static void ack_cobalt_irq(unsigned int=20
 {
 	unsigned long flags;
=20
-	spin_lock_irqsave_hw(&cobalt_lock, flags);
+	spin_lock_irqsave(&cobalt_lock, flags);
 	disable_cobalt_irq(irq);
 	apic_write(APIC_EOI, APIC_EIO_ACK);
-	spin_unlock_irqrestore_hw(&cobalt_lock, flags);
+	spin_unlock_irqrestore(&cobalt_lock, flags);
 }
=20
 static void end_cobalt_irq(unsigned int irq)
 {
 	unsigned long flags;
=20
-	spin_lock_irqsave_hw(&cobalt_lock, flags);
+	spin_lock_irqsave(&cobalt_lock, flags);
 	if (!(irq_desc[irq].status & (IRQ_DISABLED | IRQ_INPROGRESS)))
 		enable_cobalt_irq(irq);
-	spin_unlock_irqrestore_hw(&cobalt_lock, flags);
+	spin_unlock_irqrestore(&cobalt_lock, flags);
 }
=20
 #ifdef CONFIG_IPIPE
@@ -174,9 +174,9 @@ static void end_piix4_master_irq(unsigne
 {
 	unsigned long flags;
=20
-	spin_lock_irqsave_hw(&cobalt_lock, flags);
+	spin_lock_irqsave(&cobalt_lock, flags);
 	enable_cobalt_irq(irq);
-	spin_unlock_irqrestore_hw(&cobalt_lock, flags);
+	spin_unlock_irqrestore(&cobalt_lock, flags);
 }
=20
 static struct irq_chip piix4_master_irq_type =3D {
@@ -216,7 +216,7 @@ static irqreturn_t piix4_master_intr(int
 	irq_desc_t *desc;
 	unsigned long flags;
=20
-	spin_lock_irqsave_hw(&i8259A_lock, flags);
+	spin_lock_irqsave(&i8259A_lock, flags);
=20
 	/* Find out what's interrupting in the PIIX4 master 8259 */
 	outb(0x0c, 0x20);		/* OCW3 Poll command */
@@ -253,7 +253,7 @@ static irqreturn_t piix4_master_intr(int
 		outb(0x60 + realirq, 0x20);
 	}
=20
-	spin_unlock_irqrestore_hw(&i8259A_lock, flags);
+	spin_unlock_irqrestore(&i8259A_lock, flags);
=20
 	desc =3D irq_desc + realirq;
=20
@@ -271,7 +271,7 @@ static irqreturn_t piix4_master_intr(int
 	return IRQ_HANDLED;
=20
 out_unlock:
-	spin_unlock_irqrestore_hw(&i8259A_lock, flags);
+	spin_unlock_irqrestore(&i8259A_lock, flags);
 	return IRQ_NONE;
 }
=20
Index: linux-2.6.19-ipipe/arch/i386/mach-voyager/voyager_basic.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.19-ipipe.orig/arch/i386/mach-voyager/voyager_basic.c
+++ linux-2.6.19-ipipe/arch/i386/mach-voyager/voyager_basic.c
@@ -185,20 +185,20 @@ voyager_timer_interrupt(void)
 		 * pointy.  */
 		__u16 val;
=20
-		spin_lock_irqsave_hw(&i8253_lock);
+		spin_lock_irqsave(&i8253_lock);
 	=09
 		outb_p(0x00, 0x43);
 		val =3D inb_p(0x40);
 		val |=3D inb(0x40) << 8;
-		spin_unlock_irqrestore_hw(&i8253_lock);
+		spin_unlock_irqrestore(&i8253_lock);
=20
 		if(val > LATCH) {
 			printk("\nVOYAGER: countdown timer value too high (%d), resetting\n\n=
", val);
-			spin_lock_irqsave_hw(&i8253_lock);
+			spin_lock_irqsave(&i8253_lock);
 			outb(0x34,0x43);
 			outb_p(LATCH & 0xff , 0x40);	/* LSB */
 			outb(LATCH >> 8 , 0x40);	/* MSB */
-			spin_unlock_irqrestore_hw(&i8253_lock);
+			spin_unlock_irqrestore(&i8253_lock);
 		}
 	}
 #ifdef CONFIG_SMP
Index: linux-2.6.19-ipipe/drivers/ide/legacy/hd.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.19-ipipe.orig/drivers/ide/legacy/hd.c
+++ linux-2.6.19-ipipe/drivers/ide/legacy/hd.c
@@ -166,12 +166,12 @@ unsigned long read_timer(void)
 	unsigned long t, flags;
 	int i;
=20
-	spin_lock_irqsave_hw(&i8253_lock, flags);
+	spin_lock_irqsave(&i8253_lock, flags);
 	t =3D jiffies * 11932;
     	outb_p(0, 0x43);
 	i =3D inb_p(0x40);
 	i |=3D inb(0x40) << 8;
-	spin_unlock_irqrestore_hw(&i8253_lock, flags);
+	spin_unlock_irqrestore(&i8253_lock, flags);
 	return(t - i);
 }
 #endif
Index: linux-2.6.19-ipipe/drivers/input/gameport/gameport.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.19-ipipe.orig/drivers/input/gameport/gameport.c
+++ linux-2.6.19-ipipe/drivers/input/gameport/gameport.c
@@ -71,11 +71,11 @@ static unsigned int get_time_pit(void)
 	unsigned long flags;
 	unsigned int count;
=20
-	spin_lock_irqsave_hw(&i8253_lock, flags);
+	spin_lock_irqsave(&i8253_lock, flags);
 	outb_p(0x00, 0x43);
 	count =3D inb_p(0x40);
 	count |=3D inb_p(0x40) << 8;
-	spin_unlock_irqrestore_hw(&i8253_lock, flags);
+	spin_unlock_irqrestore(&i8253_lock, flags);
=20
 	return count;
 }
Index: linux-2.6.19-ipipe/drivers/input/joystick/analog.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.19-ipipe.orig/drivers/input/joystick/analog.c
+++ linux-2.6.19-ipipe/drivers/input/joystick/analog.c
@@ -151,11 +151,11 @@ static unsigned int get_time_pit(void)
         unsigned long flags;
         unsigned int count;
=20
-        spin_lock_irqsave_hw(&i8253_lock, flags);
+        spin_lock_irqsave(&i8253_lock, flags);
         outb_p(0x00, 0x43);
         count =3D inb_p(0x40);
         count |=3D inb_p(0x40) << 8;
-        spin_unlock_irqrestore_hw(&i8253_lock, flags);
+        spin_unlock_irqrestore(&i8253_lock, flags);
=20
         return count;
 }
Index: linux-2.6.19-ipipe/drivers/pci/htirq.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.19-ipipe.orig/drivers/pci/htirq.c
+++ linux-2.6.19-ipipe/drivers/pci/htirq.c
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
@@ -37,7 +37,7 @@ void write_ht_irq_msg(unsigned int irq,=20
 {
 	struct ht_irq_cfg *cfg =3D get_irq_data(irq);
 	unsigned long flags;
-	spin_lock_irqsave_hw(&ht_irq_lock, flags);
+	spin_lock_irqsave(&ht_irq_lock, flags);
 	if (cfg->msg.address_lo !=3D msg->address_lo) {
 		pci_write_config_byte(cfg->dev, cfg->pos + 2, cfg->idx);
 		pci_write_config_dword(cfg->dev, cfg->pos + 4, msg->address_lo);
@@ -48,7 +48,7 @@ void write_ht_irq_msg(unsigned int irq,=20
 	}
 	if (cfg->update)
 		cfg->update(cfg->dev, irq, msg);
-	spin_unlock_irqrestore_hw(&ht_irq_lock, flags);
+	spin_unlock_irqrestore(&ht_irq_lock, flags);
 	cfg->msg =3D *msg;
 }
=20
@@ -111,10 +111,10 @@ int __ht_create_irq(struct pci_dev *dev,
 		return -EINVAL;
=20
 	/* Verify the idx I want to use is in range */
-	spin_lock_irqsave_hw(&ht_irq_lock, flags);
+	spin_lock_irqsave(&ht_irq_lock, flags);
 	pci_write_config_byte(dev, pos + 2, 1);
 	pci_read_config_dword(dev, pos + 4, &data);
-	spin_unlock_irqrestore_hw(&ht_irq_lock, flags);
+	spin_unlock_irqrestore(&ht_irq_lock, flags);
=20
 	max_irq =3D (data >> 16) & 0xff;
 	if ( idx > max_irq)
Index: linux-2.6.19-ipipe/include/asm-i386/i8253.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.19-ipipe.orig/include/asm-i386/i8253.h
+++ linux-2.6.19-ipipe/include/asm-i386/i8253.h
@@ -1,6 +1,6 @@
 #ifndef __ASM_I8253_H__
 #define __ASM_I8253_H__
=20
-extern spinlock_t i8253_lock;
+extern ipipe_spinlock_t i8253_lock;
=20
 #endif	/* __ASM_I8253_H__ */
Index: linux-2.6.19-ipipe/include/asm-i386/i8259.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.19-ipipe.orig/include/asm-i386/i8259.h
+++ linux-2.6.19-ipipe/include/asm-i386/i8259.h
@@ -7,7 +7,7 @@ extern unsigned int cached_irq_mask;
 #define cached_master_mask	(__byte(0, cached_irq_mask))
 #define cached_slave_mask	(__byte(1, cached_irq_mask))
=20
-extern spinlock_t i8259A_lock;
+extern ipipe_spinlock_t i8259A_lock;
=20
 extern void init_8259A(int auto_eoi);
 extern void enable_8259A_irq(unsigned int irq);
Index: linux-2.6.19-ipipe/kernel/ipipe/core.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.19-ipipe.orig/kernel/ipipe/core.c
+++ linux-2.6.19-ipipe/kernel/ipipe/core.c
@@ -460,7 +460,7 @@ unsigned ipipe_alloc_virq(void)
 	unsigned long flags, irq =3D 0;
 	int ipos;
=20
-	spin_lock_irqsave_hw(&__ipipe_pipelock, flags);
+	spin_lock_irqsave(&__ipipe_pipelock, flags);
=20
 	if (__ipipe_virtual_irq_map !=3D ~0) {
 		ipos =3D ffz(__ipipe_virtual_irq_map);
@@ -468,7 +468,7 @@ unsigned ipipe_alloc_virq(void)
 		irq =3D ipos + IPIPE_VIRQ_BASE;
 	}
=20
-	spin_unlock_irqrestore_hw(&__ipipe_pipelock, flags);
+	spin_unlock_irqrestore(&__ipipe_pipelock, flags);
=20
 	return irq;
 }
@@ -496,7 +496,7 @@ int ipipe_virtualize_irq(struct ipipe_do
 		/* Silently unwire interrupts for non-heading domains. */
 		modemask &=3D ~IPIPE_WIRED_MASK;
=20
-	spin_lock_irqsave_hw(&__ipipe_pipelock, flags);
+	spin_lock_irqsave(&__ipipe_pipelock, flags);
=20
 	if (handler !=3D NULL) {
=20
@@ -565,7 +565,7 @@ int ipipe_virtualize_irq(struct ipipe_do
=20
       unlock_and_exit:
=20
-	spin_unlock_irqrestore_hw(&__ipipe_pipelock, flags);
+	spin_unlock_irqrestore(&__ipipe_pipelock, flags);
=20
 	return err;
 }
@@ -595,7 +595,7 @@ int ipipe_control_irq(unsigned irq, unsi
 	if ((clrmask & (IPIPE_HANDLE_MASK | IPIPE_STICKY_MASK)) !=3D 0)	/* If o=
ne goes, both go. */
 		clrmask |=3D (IPIPE_HANDLE_MASK | IPIPE_STICKY_MASK);
=20
-	spin_lock_irqsave_hw(&__ipipe_pipelock, flags);
+	spin_lock_irqsave(&__ipipe_pipelock, flags);
=20
 	ipd->irqs[irq].control &=3D ~clrmask;
 	ipd->irqs[irq].control |=3D setmask;
@@ -605,7 +605,7 @@ int ipipe_control_irq(unsigned irq, unsi
 	else if ((clrmask & IPIPE_ENABLE_MASK) !=3D 0)
 		__ipipe_disable_irq(irq);
=20
-	spin_unlock_irqrestore_hw(&__ipipe_pipelock, flags);
+	spin_unlock_irqrestore(&__ipipe_pipelock, flags);
=20
 	return 0;
 }
@@ -1163,7 +1163,7 @@ int ipipe_alloc_ptdkey (void)
 	unsigned long flags;
 	int key =3D -1;
=20
-	spin_lock_irqsave_hw(&__ipipe_pipelock,flags);
+	spin_lock_irqsave(&__ipipe_pipelock,flags);
=20
 	if (__ipipe_ptd_key_count < IPIPE_ROOT_NPTDKEYS) {
 		key =3D ffz(__ipipe_ptd_key_map);
@@ -1171,7 +1171,7 @@ int ipipe_alloc_ptdkey (void)
 		__ipipe_ptd_key_count++;
 	}
=20
-	spin_unlock_irqrestore_hw(&__ipipe_pipelock,flags);
+	spin_unlock_irqrestore(&__ipipe_pipelock,flags);
=20
 	return key;
 }
@@ -1183,12 +1183,12 @@ int ipipe_free_ptdkey (int key)
 	if (key < 0 || key >=3D IPIPE_ROOT_NPTDKEYS)
 		return -EINVAL;
=20
-	spin_lock_irqsave_hw(&__ipipe_pipelock,flags);
+	spin_lock_irqsave(&__ipipe_pipelock,flags);
=20
 	if (test_and_clear_bit(key,&__ipipe_ptd_key_map))
 		__ipipe_ptd_key_count--;
=20
-	spin_unlock_irqrestore_hw(&__ipipe_pipelock,flags);
+	spin_unlock_irqrestore(&__ipipe_pipelock,flags);
=20
 	return 0;
 }
Index: linux-2.6.19-ipipe/kernel/ipipe/tracer.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.19-ipipe.orig/kernel/ipipe/tracer.c
+++ linux-2.6.19-ipipe/kernel/ipipe/tracer.c
@@ -124,7 +124,7 @@ static int max_path[NR_CPUS] =3D
 	{ [0 ... NR_CPUS-1] =3D IPIPE_DEFAULT_MAX };
 static int frozen_path[NR_CPUS] =3D
 	{ [0 ... NR_CPUS-1] =3D IPIPE_DEFAULT_FROZEN };
-static ipipe_spinlock_t global_path_lock =3D IPIPE_SPIN_LOCK_UNLOCKED;
+static IPIPE_DEFINE_SPINLOCK(global_path_lock);
 static int pre_trace =3D IPIPE_DEFAULT_PRE_TRACE;
 static int post_trace =3D IPIPE_DEFAULT_POST_TRACE;
 static int back_trace =3D IPIPE_DEFAULT_BACK_TRACE;
@@ -210,7 +210,7 @@ __ipipe_trace_end(int cpu_id, struct ipi
 	if (length > (trace_paths[cpu_id][max_path[cpu_id]]).length) {
 		/* we need protection here against other cpus trying
 		   to start a proc dump */
-		spin_lock_hw(&global_path_lock);
+		spin_lock(&global_path_lock);
=20
 		/* active path holds new worst case */
 		tp->length =3D length;
@@ -219,7 +219,7 @@ __ipipe_trace_end(int cpu_id, struct ipi
 		/* find next unused trace path */
 		active =3D __ipipe_get_free_trace_path(active, cpu_id);
=20
-		spin_unlock_hw(&global_path_lock);
+		spin_unlock(&global_path_lock);
=20
 		tp =3D &trace_paths[cpu_id][active];
=20
@@ -242,7 +242,7 @@ __ipipe_trace_freeze(int cpu_id, struct=20
=20
 	/* we need protection here against other cpus trying
 	 * to set their frozen path or to start a proc dump */
-	spin_lock_hw(&global_path_lock);
+	spin_lock(&global_path_lock);
=20
 	frozen_path[cpu_id] =3D active;
=20
@@ -256,7 +256,7 @@ __ipipe_trace_freeze(int cpu_id, struct=20
 			tp->end =3D -1;
 	}
=20
-	spin_unlock_hw(&global_path_lock);
+	spin_unlock(&global_path_lock);
=20
 	tp =3D &trace_paths[cpu_id][active];
=20
@@ -408,7 +408,7 @@ static unsigned long __ipipe_global_path
 	int cpu_id;
 	struct ipipe_trace_path *tp;
=20
-	spin_lock_irqsave_hw(&global_path_lock, flags);
+	spin_lock_irqsave(&global_path_lock, flags);
=20
 	cpu_id =3D ipipe_processor_id();
 restart:
@@ -441,7 +441,7 @@ static void __ipipe_global_path_unlock(u
 	struct ipipe_trace_path *tp;
=20
 	/* release spinlock first - it's not involved in the NMI issue */
-	spin_unlock_hw(&global_path_lock);
+	spin_unlock(&global_path_lock);
=20
 	cpu_id =3D ipipe_processor_id();
 	tp =3D &trace_paths[cpu_id][active_path[cpu_id]];
Index: linux-2.6.19-ipipe/kernel/printk.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.19-ipipe.orig/kernel/printk.c
+++ linux-2.6.19-ipipe/kernel/printk.c
@@ -506,7 +506,7 @@ void __ipipe_flush_printk (unsigned virq
 	goto start;
=20
 	do {
-		spin_unlock_irqrestore_hw(&__ipipe_printk_lock,flags);
+		spin_unlock_irqrestore(&__ipipe_printk_lock, flags);
  start:
 		lmax =3D __ipipe_printk_fill;
 		while (out < lmax) {
@@ -515,13 +515,13 @@ void __ipipe_flush_printk (unsigned virq
 			p +=3D len;
 			out +=3D len;
 		}
-		spin_lock_irqsave_hw(&__ipipe_printk_lock,flags);
+		spin_lock_irqsave(&__ipipe_printk_lock, flags);
 	}
 	while (__ipipe_printk_fill !=3D lmax);
=20
 	__ipipe_printk_fill =3D 0;
=20
-	spin_unlock_irqrestore_hw(&__ipipe_printk_lock,flags);
+	spin_unlock_irqrestore(&__ipipe_printk_lock, flags);
 }
=20
 asmlinkage int printk(const char *fmt, ...)
@@ -539,7 +539,7 @@ asmlinkage int printk(const char *fmt, .
 		goto out;
 	}
=20
-	spin_lock_irqsave_hw(&__ipipe_printk_lock,flags);
+	spin_lock_irqsave(&__ipipe_printk_lock, flags);
=20
 	oldcount =3D __ipipe_printk_fill;
 	fbytes =3D __LOG_BUF_LEN - oldcount;
@@ -551,7 +551,7 @@ asmlinkage int printk(const char *fmt, .
 	} else
 		r =3D 0;
=20
-	spin_unlock_irqrestore_hw(&__ipipe_printk_lock,flags);
+	spin_unlock_irqrestore(&__ipipe_printk_lock, flags);
=20
 	if (oldcount =3D=3D 0)
 		ipipe_trigger_irq(__ipipe_printk_virq);
Index: linux-2.6.19-ipipe/arch/i386/kernel/ipipe.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.19-ipipe.orig/arch/i386/kernel/ipipe.c
+++ linux-2.6.19-ipipe/arch/i386/kernel/ipipe.c
@@ -57,7 +57,7 @@ static cpumask_t __ipipe_cpu_sync_map;
=20
 static cpumask_t __ipipe_cpu_lock_map;
=20
-static ipipe_spinlock_t __ipipe_cpu_barrier =3D IPIPE_SPIN_LOCK_UNLOCKED=
;
+static IPIPE_DEFINE_SPINLOCK(__ipipe_cpu_barrier);
=20
 static atomic_t __ipipe_critical_count =3D ATOMIC_INIT(0);
=20
@@ -399,7 +399,7 @@ void __ipipe_do_critical_sync(unsigned i
 	/* Now we are in sync with the lock requestor running on another
 	   CPU. Enter a spinning wait until he releases the global
 	   lock. */
-	spin_lock_hw(&__ipipe_cpu_barrier);
+	spin_lock(&__ipipe_cpu_barrier);
=20
 	/* Got it. Now get out. */
=20
@@ -407,7 +407,7 @@ void __ipipe_do_critical_sync(unsigned i
 		/* Call the sync routine if any. */
 		__ipipe_cpu_sync();
=20
-	spin_unlock_hw(&__ipipe_cpu_barrier);
+	spin_unlock(&__ipipe_cpu_barrier);
=20
 	cpu_clear(cpuid, __ipipe_cpu_sync_map);
 }
@@ -451,7 +451,7 @@ unsigned long ipipe_critical_enter(void=20
 				} while (++n < cpuid);
 			}
=20
-			spin_lock_hw(&__ipipe_cpu_barrier);
+			spin_lock(&__ipipe_cpu_barrier);
=20
 			__ipipe_cpu_sync =3D syncfn;
=20
@@ -483,7 +483,7 @@ void ipipe_critical_exit(unsigned long f
 		ipipe_load_cpuid();
=20
 		if (atomic_dec_and_test(&__ipipe_critical_count)) {
-			spin_unlock_hw(&__ipipe_cpu_barrier);
+			spin_unlock(&__ipipe_cpu_barrier);
=20
 			while (!cpus_empty(__ipipe_cpu_sync_map))
 				cpu_relax();

--------------040004090601070008030904
Content-Type: text/x-patch;
 name="map-ipipe-spinlocks.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="map-ipipe-spinlocks.patch"

---
 include/asm-generic/hal.h  |   10 +++++++++-
 include/rtdm/rtdm_driver.h |    6 +++---
 2 files changed, 12 insertions(+), 4 deletions(-)

Index: xenomai/include/asm-generic/hal.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/include/asm-generic/hal.h
+++ xenomai/include/asm-generic/hal.h
@@ -135,8 +135,16 @@ typedef rwlock_t rthal_rwlock_t;
 #define rthal_write_unlock(lock)	write_unlock_hw(lock)
 #define rthal_read_lock(lock)		read_lock_hw(lock)
 #define rthal_read_unlock(lock)	read_unlock_hw(lock)
+
+#ifdef spin_lock_hw
+#define rthal_spin_lock_init(lock)	spin_lock_init(lock)
 #define rthal_spin_lock(lock)		spin_lock_hw(lock)
-#define rthal_spin_unlock(lock)	spin_unlock_hw(lock)
+#define rthal_spin_unlock(lock)		spin_unlock_hw(lock)
+#else /* !spin_lock_hw */
+#define rthal_spin_lock_init(lock)	*(lock) =3D IPIPE_SPIN_LOCK_UNLOCKED
+#define rthal_spin_lock(lock)		spin_lock(lock)
+#define rthal_spin_unlock(lock)		spin_unlock(lock)
+#endif /* !spin_lock_hw */
=20
 #define rthal_root_domain		ipipe_root_domain
 #define rthal_current_domain		ipipe_current_domain
Index: xenomai/include/rtdm/rtdm_driver.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/include/rtdm/rtdm_driver.h
+++ xenomai/include/rtdm/rtdm_driver.h
@@ -546,10 +546,10 @@ static inline nanosecs_abs_t rtdm_clock_
 /**
  * Static lock initialisation
  */
-#define RTDM_LOCK_UNLOCKED          SPIN_LOCK_UNLOCKED
+#define RTDM_LOCK_UNLOCKED          RTHAL_SPIN_LOCK_UNLOCKED
=20
 /** Lock variable */
-typedef spinlock_t                  rtdm_lock_t;
+typedef rthal_spinlock_t            rtdm_lock_t;
=20
 /** Variable to save the context while holding a lock */
 typedef unsigned long               rtdm_lockctx_t;
@@ -569,7 +569,7 @@ typedef unsigned long               rtdm
  *
  * Rescheduling: never.
  */
-#define rtdm_lock_init(lock)        spin_lock_init(lock)
+#define rtdm_lock_init(lock)        rthal_spin_lock_init(lock)
=20
 /**
  * Acquire lock from non-preemptible contexts

--------------040004090601070008030904--

--------------enig72E1B4A3D82280D8C2178A32
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFFdoQrniDOoMHTA+kRAgDWAJ4xbwczOqGqnGpbeD9DiGEDObaU3QCff7O6
FKkPDtWFFbKCi2qtGTTgxTY=
=7qNi
-----END PGP SIGNATURE-----

--------------enig72E1B4A3D82280D8C2178A32--

