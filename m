MIME-Version: 1.0
Sender: alexis.berlemont@domain.hid
In-Reply-To: <9c789a000909130535j4dc046a1h3af2976ab504a000@domain.hid>
References: <9c789a000909130535j4dc046a1h3af2976ab504a000@domain.hid>
Date: Wed, 16 Sep 2009 00:42:52 +0200
Message-ID: <72cf3fb0909151542h163e7c03h1a393a969caf0c58@domain.hid>
From: Alexis Berlemont <berlemont.hauw@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Subject: Re: [Xenomai-help] Comedi port over Xenomai fault question !
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Cristian Axenie <cristian.axenie@domain.hid>
Cc: xenomai@xenomai.org

Hi,

> I've took a snapshot of the xenomai-abe (Comedi port related) git repos
> pointing to the last update and tried it up and it seems that are some
> errors.

That is very nice of you to test the driver on your board. I had read
your former mail and was about to ask you to test the code on your
configuration.

>
> /usr/xenomai/sbin # ./comedi_config -v comedi0 comedi_pcimio
> Comedi: comedi_pcimio: pcimio_attach: found pci-6024e board
> Comedi: MITE: 0x90000000 mapped to c907a000 <6>Comedi: DAQ: 0x90001000
> mapped to c907c000
> Comedi: MITE: version = 2, type = 1, mite mode = 1, interface mode = 3
> Comedi: MITE: num channels = 1, write post fifo depth = 1, wins = 0, iowins
> = 2
> Comedi: comedi_pcimio: pcimio_attach: found irq 48
> Unable to handle kernel paging request for data at address 0x00012400
> Faulting instruction address: 0xc023dd08
> Oops: Kernel access of bad area, sig: 11 [#1]
> MPC831x RDB
> Modules linked in:
> NIP: c023dd08 LR: c0246b70 CTR: 00000000
> REGS: c7a51c30 TRAP: 0300   Not tainted  (2.6.24.2)
> MSR: 00001032 <ME,IR,DR>  CR: 84008422  XER: 00000000
> DAR: 00012400, DSISR: 20000000
> TASK = c7864430[898] 'comedi_config' THREAD: c7a50000
> GPR00: c0246b70 c7a51ce0 c7864430 00012400 00000001 00000000 c79062c0
> c03c0000
> GPR08: 00000000 c7900a00 c03d6144 c03a37e8 c7906200 1004a5b8 c033e0b8
> c03c0000
> GPR16: c03ba578 c03d1a00 c02464fc c03b4d60 c0244e5c c024509c c024535c
> c0245380
> GPR24: c03da628 c02453a4 20001040 00000000 00000000 c03a2e50 c03c0000
> 00012400
> Call Trace:
> [c7a51ce0] [c024bae0]  (unreliable)
> [c7a51d00] [c0246b70]
> [c7a51d20] [c0246bdc]
> [c7a51d40] [c024b88c]
> [c7a51d90] [c024c69c]
> [c7a51dc0] [c0238b2c]
> [c7a51de0] [c0238c64]
> [c7a51e20] [c0239094]
> [c7a51e40] [c023ba00]
> [c7a51e70] [c008b404]
> [c7a51eb0] [c008d634]
> [c7a51ec0] [c0059eb8]
> [c7a51ee0] [c004ad5c]
> [c7a51f30] [c0009644]
> [c7a51f40] [c0010ca4]
> --- Exception: c01Instruction dump:
> 7d6b1a14 39290010 38000001 7fe34a14 900b00b0 90ff0010 4bffff9c 9421ffe0
> 7c0802a6 bf61000c 7c7f1b78 90010024 <83c30000> 7c0000a6 5400045e 7c000124
> ---[ end trace f35e90f95f5de008 ]---
>
>
> A quick disassembly shows that the error is generated in the mite driver as
> pointed next,
>
> c023dcf4 <mite_release_channel>:
> mite_release_channel():
> /home/haustiq/development/eldk/ppc_6xx/usr/src/linux-2.6.24-xc1/drivers/xenomai/comedi/national_instruments/mite.c:308
> c023dcf4:    94 21 ff e0     stwu    r1,-32(r1)
> c023dcf8:    7c 08 02 a6     mflr    r0
> c023dcfc:    bf 61 00 0c     stmw    r27,12(r1)
> c023dd00:    7c 7f 1b 78     mr      r31,r3
> c023dd04:    90 01 00 24     stw     r0,36(r1)
> /home/haustiq/development/eldk/ppc_6xx/usr/src/linux-2.6.24-xc1/drivers/xenomai/comedi/national_instruments/mite.c:309
> c023dd08:    83 c3 00 00     lwz     r30,0(r3)
>

Without any access on you board, I have no other solution but to ask
you to add some debug traces in the driver so as to locate the
problem:

Could you try these two patches and send me the results. On my side,
this driver (partly) works on the NI 6221 board plugged into some x86
motherboard. Your configuration (6024e + PPC) is not that close but it
is just a segfault, we will figure this out quite quickly with ugly
printks.


diff --git a/ksrc/drivers/comedi/national_instruments/mite.c
b/ksrc/drivers/comedi/national_instruments/mite.c
index 8f1ccd7..56013d0 100644
--- a/ksrc/drivers/comedi/national_instruments/mite.c
+++ b/ksrc/drivers/comedi/national_instruments/mite.c
@@ -309,6 +309,22 @@ void mite_release_channel(struct mite_channel *mite_chan)
       struct mite_struct *mite = mite_chan->mite;
       unsigned long flags;

+#if 1 /* debug */
+       int i;
+
+       printk("mite_release_channel: mite_chan = %p\n", mite_chan);
+       printk("mite_release_channel: mite_chan->channel = %p\n",
+              mite_chan->channel);
+       printk("mite_release_channel: mite = %p\n", mite);
+       printk("mite_release_channel: mite->mite_io_addr = %p\n",
+              mite->mite_io_addr);
+       for (i = 0; i < MAX_MITE_DMA_CHANNELS; i++) {
+               printk("mite_release_channel: \talloc[%d] = %u\n",
+                      i, mite->channel_allocated[i]);
+       }
+
+#endif /* debug */
+
       // spin lock to prevent races with mite_request_channel
       comedi_lock_irqsave(&mite->lock, flags);
       if (mite->channel_allocated[mite_chan->channel]) {
@@ -318,13 +334,24 @@ void mite_release_channel(struct mite_channel *mite_chan)
                       CHCR_CLR_MRDY_IE | CHCR_CLR_DRDY_IE |
                       CHCR_CLR_LC_IE | CHCR_CLR_CONT_RB_IE,
                       mite->mite_io_addr + MITE_CHCR(mite_chan->channel));
+#if 1 /* debug */
+               printk("mite_release_channel: before disarm\n");
+#endif /* debug */
               mite_dma_disarm(mite_chan);
+#if 1 /* debug */
+               printk("mite_release_channel: before reset\n");
+#endif /* debug */
               mite_dma_reset(mite_chan);
+
               mite->channel_allocated[mite_chan->channel] = 0;
               mite_chan->ring = NULL;
               mmiowb();
       }
       comedi_unlock_irqrestore(&mite->lock, flags);
+
+#if 1 /* debug */
+               printk("mite_release_channel: out\n");
+#endif /* debug */
 }

 void mite_dma_arm(struct mite_channel *mite_chan)


diff --git a/ksrc/drivers/comedi/national_instruments/mio_common.c
b/ksrc/drivers/comedi/national_instruments/mio_common.c
index 3f70c3e..e29c2c5 100644
--- a/ksrc/drivers/comedi/national_instruments/mio_common.c
+++ b/ksrc/drivers/comedi/national_instruments/mio_common.c
@@ -424,6 +424,10 @@ void ni_release_ai_mite_channel(comedi_dev_t *dev)

       unsigned long flags;

+#if 1 /* debug */
+       printk("ni_release_ai_mite_channel: in\n");
+#endif /* debug */
+
       comedi_lock_irqsave(&devpriv->mite_channel_lock, flags);
       if (devpriv->ai_mite_chan) {
               ni_set_ai_dma_channel(dev, -1);
@@ -432,6 +436,10 @@ void ni_release_ai_mite_channel(comedi_dev_t *dev)
       }
       comedi_unlock_irqrestore(&devpriv->mite_channel_lock, flags);

+#if 1 /* debug */
+       printk("ni_release_ai_mite_channel: out\n");
+#endif /* debug */
+
 }

 void ni_release_ao_mite_channel(comedi_dev_t *dev)


Regards.

Alexis.

