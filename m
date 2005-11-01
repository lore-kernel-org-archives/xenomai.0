Message-ID: <436735C9.30607@domain.hid>
Date: Tue, 01 Nov 2005 10:30:49 +0100
From: Jan Kiszka <kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Re: [Xenomai-help] General Xenomai / RTAI Skin
	Usage Questions
References: <OF8F0700EC.A1D80BF4-ONC12570AB.004AE3CB-C12570AB.005254F3@domain.hid>
	<200511011227.03173.rlenglet@domain.hid>
	<436718FB.8090207@domain.hid>
	<200511011652.24312.rlenglet@domain.hid>
In-Reply-To: <200511011652.24312.rlenglet@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigF7618563968A3CEB3D1A3A23"
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Romain Lenglet <rlenglet@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigF7618563968A3CEB3D1A3A23
Content-Type: multipart/mixed; boundary="------------070905060208080609010407"

This is a multi-part message in MIME format.
--------------070905060208080609010407
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Romain Lenglet wrote:
>> Actually, Dmitry and I are discussing IRQ sharing between
>> real-time driver, not across the RT/non-RT border.
>=20
> Sorry, I misunderstood.
>=20
>> The latter case almost always a no-go and should rather be
>> solved at hardware level by rearranging the IRQ usage (where
>> possible...). The problem is that the non-RT IRQ handler has
>> to be called just after the RT handler to make the non-RT
>> hardware release the IRQ line. But this cannot be guaranteed
>> due to other RT activity and creates an ugly priority
>> inversion.
>>
>> That your system just crashes is likely due to the RT driver
>> not being prepared to share IRQs with non-RT. What driver are
>> you using?
>=20
> RTnet's 8169 gigabit ethernet driver, and RTnet's tulip driver.

Could you try if returning RTDM_IRQ_PROPAGATE from the involved
RT-driver improves the situation? Only enable the devices sharing IRQs
in this case as I'm afraid returning this value in a non-shared case
will also cause troubles as well. Note that this patch may solve the
crashes but will not solve prio inversion.

As I indicated, the problem is more complex. I once started a discussion
about this with Philippe, my original mail is attached (I didn't find
any RTAI-dev mailing list archive). We didn't really solve this issue,
especially as a clean solution would require patched non-RT drivers.

>=20
> The problem, on common x86 hardware, is that with only one PCI=20
> bus and several devices (e.g. I use 4 PCI network cards drived=20
> by RTnet, in one PC), sharing IRQ seems unavoidable.
> The only possible workaround on my test machine is to disable as=20
> much as I can (USB, sound, serial ports, non-rt ethernet cards,=20
> etc.) to avoid sharing.
>=20

Yea, I do understand. Wolfgang Grandegger recently reported me about a
similar issue on a PPC board: 4 NICs built-in, but all sharing the same
IRQ. If you want to create some RTnet gateway with such a really nice
system, you are in the same troubles. I personally preferred to stop
tormenting my brain with this after we solved our issue with some jumper
(PC104+ board where NOT the jumper named "IRQ" but some other has to be
changed...).

Jan


--------------070905060208080609010407
Content-Type: message/rfc822;
 name="Attached Message"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="Attached Message"

Message-ID: <3FD5DCB6.1040402@domain.hid>
Date: Tue, 09 Dec 2003 15:31:18 +0100
From: Jan Kiszka <kiszka@domain.hid>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; de-AT;
	rv:1.5) Gecko/20031007
X-Accept-Language: de-de, en, en-us
MIME-Version: 1.0
To: RTAI developers <rtai-dev@domain.hid>
Subject: Proposal: Sharing RT and non-RT IRQs
Content-Type: multipart/mixed; boundary="------------060505040107080205020401"

This is a multi-part message in MIME format.
--------------060505040107080205020401
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

last week I already mentioned that I was thinking about a concept to 
allow real-time safe IRQ sharing between Linux and RTAI drivers (or in 
other words: between different ADEOS domains). The problem many 
(PC-)users have is that it is not always possible to separate the IRQ 
lines of extension cards and especially on-board components cleanly.

I now found some time to write a proof-of-concept which you find 
attached to this mail. It consists of a rt-module which provides 
extended versions of the Linux functions request_irq/free_irq. Besides 
calling the old request_irq, request_shared_rtirq also registers a 
so-called IRQ suspend handler. In contrast to the normal interrupt 
handler, the suspend routine runs in the context of the RTAI IRQ 
routine. Its job is to disable any further IRQs from the registered 
device and release the IRQ line (i.e. acknowledge the IRQ sources in the 
device hardware). free_shared_irq unregisters such handlers again.

As an example of an ADEOS/RTAI-aware Linux driver, I attached a patch 
for the eepro100 NIC driver. You can see, it is not that complicated to 
create such "special" drivers.

The rt-module also contains a demo real-time IRQ handler (see comments 
how it may be integrated into arti.c) which simply triggers a real-time 
load task on every call. Together with the patched eepro100 you can run 
a test which will effectively delay every NIC IRQ by 50 ms, spent in the 
RTAI context.

My suggestion is that this extension should become part of the ADEOS 
layer. It only causes very slight additional latency in case no suspend 
handler is registered, and of course a bit more when there is actually a 
bit of hardware to suspend. I measured about 5 us additional worst-case 
latency between the beginning of rt_irq_handler and rt_enable_irq (i.e. 
the later call of the real-time handler) on a Pentium MMX 266 MHz 
running the patched eepro100.

One to-do remains for RTAI drivers (RTnet included...): many of them 
startup/shutdown or disable/enable IRQs in an inappropriate way. For 
instance, spdrv first disables its IRQ in init_module, then requests it, 
and re-enables it again not before the user program open the COM port. 
We need some kind of driver-writing-howto...

Question: Does a RTAI driver require rt_startup_irq/rt_shutdown_irq at 
all? Or is this done by Linux and/or ADEOS/RTAI during bootup? We use it 
in RTnet, I think to remember, because we discovered some issues on PPC 
when rt_startup_irq was missing. Is this out-of-date?

Jan


--------------060505040107080205020401
Content-Type: text/x-csrc;
 name="rt_test_module.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="rt_test_module.c"

/***************************************************************************
                              rt_test_module.c
                             -------------------
    begin                : Thr Dec 04 2003
    copyright            : (C) 2003 by Jan Kiszka
    email                : Jan.Kiszka@domain.hid
 ***************************************************************************/

/***************************************************************************
 *                                                                         *
 *   This program is free software; you can redistribute it and/or modify  *
 *   it under the terms of the GNU General Public License as published by  *
 *   the Free Software Foundation; either version 2 of the License, or     *
 *   (at your option) any later version.                                   *
 *                                                                         *
 ***************************************************************************/


#include <linux/kernel.h>
#include <linux/list.h>
#include <linux/module.h>
#include <linux/sched.h>
#include <linux/slab.h>

#include <rtai.h>
#include <rtai_sched.h>
#include <rtai_proc_fs.h>


static int irq_no = -1;
MODULE_PARM(irq_no, "i");

SEM sem;
RT_TASK delay_task;

/* begin shared RT-IRQ stuff */
struct suspend_handler {
    struct list_head chain;
    void (*suspend_handler)(int, void*);
    void *dev_id;
};

static struct list_head susp_handler[NR_IRQS];
static spinlock_t susp_handler_lock = SPIN_LOCK_UNLOCKED;



int request_shared_rtirq(unsigned int irq,
                         void (*irq_handler)(int, void *, struct pt_regs *),
                         void (*suspend_handler)(int, void *),
                         unsigned long flags, char *dev_name, void *dev_id)
{
    struct suspend_handler *new_handler;
    unsigned long cpu_flags;
    int result;


    new_handler = kmalloc(sizeof(struct suspend_handler), GFP_KERNEL);
    if (!new_handler)
        return -ENOMEM;

    new_handler->suspend_handler = suspend_handler;
    new_handler->dev_id          = dev_id;

    result = request_irq(irq, irq_handler, flags, dev_name, dev_id);
    if (result < 0) {
        kfree(new_handler);
        return result;
    }

    cpu_flags = rt_spin_lock_irqsave(&susp_handler_lock);
    list_add_tail(&new_handler->chain, &susp_handler[irq]);
    rt_spin_unlock_irqrestore(cpu_flags, &susp_handler_lock);

    return 0;
}



void free_shared_rtirq(unsigned int irq, void *dev_id)
{
    struct list_head *entry;
    struct suspend_handler *handler;
    unsigned long flags;


    flags = rt_spin_lock_irqsave(&susp_handler_lock);
    list_for_each(entry, &susp_handler[irq]) {
        handler = list_entry(entry, struct suspend_handler, chain);
        if (handler->dev_id == dev_id) {
            list_del(entry);

            rt_spin_unlock_irqrestore(flags, &susp_handler_lock);

            kfree(handler);
            goto out;
        }
    }
    rt_spin_unlock_irqrestore(flags, &susp_handler_lock);

  out:
    free_irq(irq, dev_id);
}



EXPORT_SYMBOL(request_shared_rtirq);
EXPORT_SYMBOL(free_shared_rtirq);
/* end shared RT-IRQ stuff */



/* REPLACE: */
static void rt_irq_handler(int irq, unsigned long data)
/* WITH: static void arti_irq_trampoline (unsigned irq) */
{
    struct list_head *entry;
    struct suspend_handler *cur_handler;
    int shared;

    /* ADD:
    TRACE_RTAI_GLOBAL_IRQ_ENTRY(irq,0);

    if (arti_realtime_irq[irq].handler)
    {
    */
        shared = 0;

        spin_lock(&susp_handler_lock);

        list_for_each(entry, &susp_handler[irq]) {
            cur_handler = list_entry(entry, struct suspend_handler, chain);
            cur_handler->suspend_handler(irq, cur_handler->dev_id);
            shared = 1;
        }

        spin_unlock(&susp_handler_lock);

        /* REPLACE: */
        rt_enable_irq(irq);
        rt_sem_signal(&sem);
        /* WITH: arti_realtime_irq[irq].handler(irq,arti_realtime_irq[irq].cookie); */

        if (shared)
            adeos_propagate_irq(irq);
    /* ADD:
    }
    else
        adeos_propagate_irq(irq);

    TRACE_RTAI_GLOBAL_IRQ_EXIT();
    */
}



void rt_delay_task(int arg)
{
    while (1) {
        rt_sem_wait(&sem);
        rt_busy_sleep(50000000ll); /* freeze system for 50 ms */
    }
}



int init_module()
{
    int i;


    printk("Shared RT-IRQ test loaded\n");

    for (i = 0; i < NR_IRQS; i++)
        INIT_LIST_HEAD(&susp_handler[i]);

    if (rt_request_global_irq_ext(irq_no, (void(*)(void))rt_irq_handler, 0) < 0) {
        printk("Failed to alloc irq %d.\n", irq_no);
        return 1;
    }

    rt_sem_init(&sem, 0);
    rt_task_init(&delay_task, rt_delay_task, 0, 4096, 10, 0, 0);
    rt_task_resume(&delay_task);

    return 0;
}



void cleanup_module()
{
    rt_free_global_irq(irq_no);

    rt_task_delete(&delay_task);
    rt_sem_delete(&sem);
}

--------------060505040107080205020401
Content-Type: text/plain;
 name="eepro100-shirq.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="eepro100-shirq.patch"

--- /usr/src/spb_packages_v0.1/src/linux-2.4.22/drivers/net/eepro100.c	2003-08-25 13:44:42.000000000 +0200
+++ eepro100-shirq.c	2003-12-08 17:46:44.000000000 +0100
@@ -120,6 +120,14 @@
 #include <linux/ethtool.h>
 #include <linux/mii.h>
 
+#include <rtai.h>
+/* should be #include <something.h> */
+int request_shared_rtirq(unsigned int irq,
+                         void (*irq_handler)(int, void *, struct pt_regs *),
+                         void (*suspend_handler)(int, void *),
+                         unsigned long flags, char *dev_name, void *dev_id);
+void free_shared_rtirq(unsigned int irq, void *dev_id);
+
 /* enable PIO instead of MMIO, if CONFIG_EEPRO100_PIO is selected */
 #ifdef CONFIG_EEPRO100_PIO
 #define USE_IO 1
@@ -499,6 +507,10 @@
 #ifdef CONFIG_PM
 	u32 pm_state[16];
 #endif
+	spinlock_t rt_lock;
+	long saved_mask;
+	long saved_status;
+	long irq_suspended;
 };
 
 /* The parameters for a CmdConfigure operation.
@@ -542,6 +554,7 @@
 static void speedo_refill_rx_buffers(struct net_device *dev, int force);
 static int speedo_rx(struct net_device *dev);
 static void speedo_tx_buffer_gc(struct net_device *dev);
+static void speedo_suspend_interrupt(int irq, void *dev_instance);
 static void speedo_interrupt(int irq, void *dev_instance, struct pt_regs *regs);
 static int speedo_close(struct net_device *dev);
 static struct net_device_stats *speedo_get_stats(struct net_device *dev);
@@ -843,6 +856,7 @@
 	sp->lstats_dma = TX_RING_ELEM_DMA(sp, TX_RING_SIZE);
 	init_timer(&sp->timer); /* used in ioctl() */
 	spin_lock_init(&sp->lock);
+	spin_lock_init(&sp->rt_lock);
 
 	sp->mii_if.full_duplex = option >= 0 && (option & 0x10) ? 1 : 0;
 	if (card_idx >= 0) {
@@ -995,9 +1009,12 @@
 	sp->last_cmd = 0;
 	sp->tx_full = 0;
 	sp->in_interrupt = 0;
+	sp->saved_status = 0;
+	sp->saved_mask = 0;
 
 	/* .. we can safely take handler calls during init. */
-	retval = request_irq(dev->irq, &speedo_interrupt, SA_SHIRQ, dev->name, dev);
+	retval = request_shared_rtirq(dev->irq, &speedo_interrupt,
+	                              &speedo_suspend_interrupt, SA_SHIRQ, dev->name, dev);
 	if (retval) {
 		return retval;
 	}
@@ -1562,6 +1579,28 @@
 	sp->dirty_tx = dirty_tx;
 }
 
+/* Switch off and acknowledge all IRQ sources in realtime context,
+ * speedo_interrupt will handle them later. */
+static void speedo_suspend_interrupt(int irq, void *dev_instance)
+{
+	struct net_device *dev = (struct net_device *)dev_instance;
+	struct speedo_private *sp = (struct speedo_private *)dev->priv;
+	long ioaddr = dev->base_addr;
+
+	rt_spin_lock(&sp->rt_lock);
+
+	if (test_and_set_bit(0, &sp->irq_suspended))
+		return;
+
+	sp->saved_mask = inw(ioaddr + SCBCmd) & SCBMaskAll;
+	outw(SCBMaskAll, ioaddr + SCBCmd);
+
+	sp->saved_status = inw(ioaddr + SCBStatus);
+	outw(sp->saved_status & 0xfc00, ioaddr + SCBStatus);
+
+	rt_spin_unlock(&sp->rt_lock);
+}
+
 /* The interrupt handler does all of the Rx thread work and cleans up
    after the Tx thread. */
 static void speedo_interrupt(int irq, void *dev_instance, struct pt_regs *regs)
@@ -1570,6 +1609,7 @@
 	struct speedo_private *sp;
 	long ioaddr, boguscnt = max_interrupt_work;
 	unsigned short status;
+	unsigned long flags;
 
 	ioaddr = dev->base_addr;
 	sp = (struct speedo_private *)dev->priv;
@@ -1584,8 +1624,20 @@
 	}
 #endif
 
+	status = inw(ioaddr + SCBStatus);
+
+	flags = rt_spin_lock_irqsave(&sp->rt_lock);
+
+	if (test_and_clear_bit(0, &sp->irq_suspended)) {
+		outw(sp->saved_mask, ioaddr + SCBCmd);
+		sp->saved_mask = 0;
+
+		status |= sp->saved_status;
+	}
+
+	rt_spin_unlock_irqrestore(flags, &sp->rt_lock);
+
 	do {
-		status = inw(ioaddr + SCBStatus);
 		/* Acknowledge all of the current interrupt sources ASAP. */
 		/* Will change from 0xfc00 to 0xff00 when we start handling
 		   FCP and ER interrupts --Dragan */
@@ -1651,6 +1703,7 @@
 			outw(0xfc00, ioaddr + SCBStatus);
 			break;
 		}
+		status = inw(ioaddr + SCBStatus);
 	} while (1);
 
 	if (netif_msg_intr(sp))
@@ -1892,7 +1945,7 @@
 	 */
 	udelay(10);
 
-	free_irq(dev->irq, dev);
+	free_shared_rtirq(dev->irq, dev);
 	speedo_show_state(dev);
 
     /* Free all the skbuffs in the Rx and Tx queues. */

--------------060505040107080205020401--


--------------070905060208080609010407--

--------------enigF7618563968A3CEB3D1A3A23
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFDZzXJncNeS9Q0k+IRAicoAKC58oxeUJZRxxQ+RebpHWJkwHSTowCgj1C6
Tt6VHm38u6FGRziom8+7Juc=
=xUzW
-----END PGP SIGNATURE-----

--------------enigF7618563968A3CEB3D1A3A23--

