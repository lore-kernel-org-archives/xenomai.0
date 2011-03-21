Message-ID: <4D87422C.7060001@domain.hid>
Date: Mon, 21 Mar 2011 13:18:52 +0100
From: Anders Blomdell <anders.blomdell@domain.hid>
MIME-Version: 1.0
References: <4D7E6CAC.6010703@domain.hid> <4D7FA754.9010308@domain.hid>
In-Reply-To: <4D7FA754.9010308@domain.hid>
Content-Type: multipart/mixed; boundary="------------030707020101040005000604"
Subject: Re: [Xenomai-core] Duplicate symbols in analogy
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai-core <xenomai@xenomai.org>

This is a multi-part message in MIME format.
--------------030707020101040005000604
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

On 2011-03-15 18.52, Anders Blomdell wrote:
> On 2011-03-14 20.29, Anders Blomdell wrote:
>> I think it would make sense to change the name conflicts between analogy and
>> comedi (range_unknown is one of them), to make it possible to have comedi and
>> analogy to coexist on the same machine, anybody in support of this?
> Anybody against then? IMHO it's a bad idea to have name conflicts with drivers
> in the kernel (even if they are still in the saging area). What prefix should I
> add to all modified exported symbols, would this make sense (a4ld == "Analogy
> for Linux Driver"):
> 
>   mite_unsetup -> a4ld_mite_unsetup
>   etc...
OK,

here are patches that makes it possible for comedi and analogy to coexist, I
decided on a4l_ as prefix. Also a small patch to rename the mite driver to
analogy_mite.

There is one small weirdness in the NI analogy drivers as I see it (regardless
of my patch or not):

The kernel module that reports interest in the NI card, is the
analogy_ni_pcimio, but the module that provides the driver is the
analogy_ni_mite. I don't think it is wrong, but pretty confusing (at least to me).

Regards

Anders Blomdell



-- 
Anders Blomdell                  Email: anders.blomdell@domain.hid
Department of Automatic Control
Lund University                  Phone:    +46 46 222 4625
P.O. Box 118                     Fax:      +46 46 138118
SE-221 00 Lund, Sweden

--------------030707020101040005000604
Content-Type: text/plain; x-mac-type="0"; x-mac-creator="0";
 name="a4l_rename.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="a4l_rename.patch"

--- xenomai-2.5.6/ksrc/drivers/analogy/subdevice.c.orig
+++ xenomai-2.5.6/ksrc/drivers/analogy/subdevice.c
@@ -38,32 +38,32 @@
 a4l_rngtab_t rng_bipolar10 = { 1, {
 		RANGE_V(-10, 10),
 	}};
-a4l_rngdesc_t range_bipolar10 = RNG_GLOBAL(rng_bipolar10);
+a4l_rngdesc_t a4l_range_bipolar10 = RNG_GLOBAL(rng_bipolar10);
 
 a4l_rngtab_t rng_bipolar5 = { 1, {
 		RANGE_V(-5, 5),
 	}};
-a4l_rngdesc_t range_bipolar5 = RNG_GLOBAL(rng_bipolar5);
+a4l_rngdesc_t a4l_range_bipolar5 = RNG_GLOBAL(rng_bipolar5);
 
 a4l_rngtab_t rng_unipolar10 = { 1, {
 		RANGE_V(0, 10),
 	}};
-a4l_rngdesc_t range_unipolar10 = RNG_GLOBAL(rng_unipolar10);
+a4l_rngdesc_t a4l_range_unipolar10 = RNG_GLOBAL(rng_unipolar10);
 
 a4l_rngtab_t rng_unipolar5 = { 1, {
 		RANGE_V(0, 5),
 	}};
-a4l_rngdesc_t range_unipolar5 = RNG_GLOBAL(rng_unipolar5);
+a4l_rngdesc_t a4l_range_unipolar5 = RNG_GLOBAL(rng_unipolar5);
 
 a4l_rngtab_t rng_unknown = { 1, {
 		RANGE(0, 1),
 	}};
-a4l_rngdesc_t range_unknown = RNG_GLOBAL(rng_unknown);
+a4l_rngdesc_t a4l_range_unknown = RNG_GLOBAL(rng_unknown);
 
 a4l_rngtab_t rng_fake = { 0, {
 		RANGE(0, 0),
 	}};
-a4l_rngdesc_t range_fake = RNG_GLOBAL(rng_fake);
+a4l_rngdesc_t a4l_range_fake = RNG_GLOBAL(rng_fake);
 
 /* --- Basic channel / range management functions --- */
 
@@ -290,7 +290,7 @@
 	}
 
 	if(rng_desc == NULL)
-		rng_desc = &range_fake;
+		rng_desc = &a4l_range_fake;
 
 	chan_info = rtdm_malloc(chan_desc->length * sizeof(a4l_chinfo_t));
 	if (chan_info == NULL)

--- xenomai-2.5.6/ksrc/drivers/analogy/driver_facilities.c.orig
+++ xenomai-2.5.6/ksrc/drivers/analogy/driver_facilities.c
@@ -134,12 +134,12 @@
  * @{
  */
 
-EXPORT_SYMBOL_GPL(range_bipolar10);
-EXPORT_SYMBOL_GPL(range_bipolar5);
-EXPORT_SYMBOL_GPL(range_unipolar10);
-EXPORT_SYMBOL_GPL(range_unipolar5);
-EXPORT_SYMBOL_GPL(range_unknown);
-EXPORT_SYMBOL_GPL(range_fake);
+EXPORT_SYMBOL_GPL(a4l_range_bipolar10);
+EXPORT_SYMBOL_GPL(a4l_range_bipolar5);
+EXPORT_SYMBOL_GPL(a4l_range_unipolar10);
+EXPORT_SYMBOL_GPL(a4l_range_unipolar5);
+EXPORT_SYMBOL_GPL(a4l_range_unknown);
+EXPORT_SYMBOL_GPL(a4l_range_fake);
 
 /**
  * @brief Allocate a subdevice descriptor

--- xenomai-2.5.6/ksrc/drivers/analogy/intel/8255.h.orig
+++ xenomai-2.5.6/ksrc/drivers/analogy/intel/8255.h
@@ -49,13 +49,13 @@
 #define CR_A_MODE(a)	((a)<<5)
 #define CR_CW		0x80
 
-void subdev_8255_init(a4l_subd_t *subd);
-void subdev_8255_interrupt(a4l_subd_t *subd);
+void a4l_subdev_8255_init(a4l_subd_t *subd);
+void a4l_subdev_8255_interrupt(a4l_subd_t *subd);
 
 #else /* !CONFIG_XENO_DRIVERS_ANALOGY_8255 */
 
-#define subdev_8255_init(x)		do { } while(0)
-#define subdev_8255_interrupt(x)	do { } while(0)
+#define a4l_subdev_8255_init(x)		do { } while(0)
+#define a4l_subdev_8255_interrupt(x)	do { } while(0)
 
 #endif /* CONFIG_XENO_DRIVERS_ANALOGY_8255 */
 

--- xenomai-2.5.6/ksrc/drivers/analogy/intel/8255.c.orig
+++ xenomai-2.5.6/ksrc/drivers/analogy/intel/8255.c
@@ -46,7 +46,7 @@
 	.stop_src = TRIG_NONE,
 };
 
-void subdev_8255_interrupt(a4l_subd_t *subd)
+void a4l_subdev_8255_interrupt(a4l_subd_t *subd)
 {
 	sampl_t d;
 
@@ -59,7 +59,7 @@
 
 	a4l_buf_evt(subd, 0);
 }
-EXPORT_SYMBOL_GPL(subdev_8255_interrupt);
+EXPORT_SYMBOL_GPL(a4l_subdev_8255_interrupt);
 
 static int subdev_8255_cb(int dir, int port, int data, unsigned long arg)
 {
@@ -199,7 +199,7 @@
 	return 0;
 }
 
-void subdev_8255_init(a4l_subd_t *subd)
+void a4l_subdev_8255_init(a4l_subd_t *subd)
 {
 	subd_8255_t *subd_8255 = (subd_8255_t *)subd->priv;
 	/* Initializes the subdevice structure */
@@ -227,7 +227,7 @@
 
 	do_config(subd);
 }
-EXPORT_SYMBOL_GPL(subdev_8255_init);
+EXPORT_SYMBOL_GPL(a4l_subdev_8255_init);
 
 /*
 
@@ -278,7 +278,7 @@
 		}
 		else {
 			subd_8255->cb_arg = addrs[i];
-			subdev_8255_init(subd);
+			a4l_subdev_8255_init(subd);
 		}
 
 		err = a4l_add_subd(dev, subd);

--- xenomai-2.5.6/ksrc/drivers/analogy/sensoray/s526.c.orig
+++ xenomai-2.5.6/ksrc/drivers/analogy/sensoray/s526.c
@@ -630,7 +630,7 @@
 {
 	subd->flags = A4L_SUBD_AI;
 	subd->chan_desc = &s526_chan_desc_ai;
-	subd->rng_desc = &range_bipolar10;
+	subd->rng_desc = &a4l_range_bipolar10;
 	subd->insn_read = s526_ai_rinsn;
 	subd->insn_config = s526_ai_insn_config;
 }
@@ -640,7 +640,7 @@
 {
 	subd->flags = A4L_SUBD_AO;
 	subd->chan_desc = &s526_chan_desc_ao;
-	subd->rng_desc = &range_bipolar10;
+	subd->rng_desc = &a4l_range_bipolar10;
 	subd->insn_write = s526_ao_winsn;
 	subd->insn_read = s526_ao_rinsn;
 }

--- xenomai-2.5.6/ksrc/drivers/analogy/national_instruments/tio_common.c.orig
+++ xenomai-2.5.6/ksrc/drivers/analogy/national_instruments/tio_common.c
@@ -59,7 +59,7 @@
 	return counter->counter_dev->read_register(counter, reg);
 }
 
-struct ni_gpct_device *ni_gpct_device_construct(a4l_dev_t * dev,
+struct ni_gpct_device *a4l_ni_gpct_device_construct(a4l_dev_t * dev,
 	void (*write_register) (struct ni_gpct * counter, unsigned int bits,
 		enum ni_gpct_register reg),
 	unsigned int (*read_register) (struct ni_gpct * counter,
@@ -94,7 +94,7 @@
 	return counter_dev;
 }
 
-void ni_gpct_device_destroy(struct ni_gpct_device *counter_dev)
+void a4l_ni_gpct_device_destroy(struct ni_gpct_device *counter_dev)
 {
 	if (counter_dev->counters == NULL)
 		return;
@@ -196,7 +196,7 @@
 		       NITIO_Gxx_Joint_Reset_Reg(counter->counter_index));
 }
 
-void ni_tio_init_counter(struct ni_gpct *counter)
+void a4l_ni_tio_init_counter(struct ni_gpct *counter)
 {
 	struct ni_gpct_device *counter_dev = counter->counter_dev;
 
@@ -1399,7 +1399,7 @@
 	return 0;
 }
 
-int ni_tio_insn_config(struct ni_gpct *counter, a4l_kinsn_t *insn)
+int a4l_ni_tio_insn_config(struct ni_gpct *counter, a4l_kinsn_t *insn)
 {
 	unsigned int *data = (unsigned int *)insn->data;
 
@@ -1445,7 +1445,7 @@
 	return -EINVAL;
 }
 
-int ni_tio_rinsn(struct ni_gpct *counter, a4l_kinsn_t *insn)
+int a4l_ni_tio_rinsn(struct ni_gpct *counter, a4l_kinsn_t *insn)
 {
 	struct ni_gpct_device *counter_dev = counter->counter_dev;
 	const unsigned int channel = CR_CHAN(insn->chan_desc);
@@ -1514,7 +1514,7 @@
 	}
 }
 
-int ni_tio_winsn(struct ni_gpct *counter, a4l_kinsn_t *insn)
+int a4l_ni_tio_winsn(struct ni_gpct *counter, a4l_kinsn_t *insn)
 {
 	struct ni_gpct_device *counter_dev = counter->counter_dev;
 	const unsigned int channel = CR_CHAN(insn->chan_desc);
@@ -1604,9 +1604,9 @@
 	}
 }
 
-/* TODO: ni_tio_input_inttrig is left unused because the trigger
+/* TODO: a4l_ni_tio_input_inttrig is left unused because the trigger
    callback cannot be changed at run time */
-int ni_tio_input_inttrig(struct ni_gpct *counter, lsampl_t trignum)
+int a4l_ni_tio_input_inttrig(struct ni_gpct *counter, lsampl_t trignum)
 {
 	unsigned long flags;
 	int retval = 0;
@@ -1617,7 +1617,7 @@
 
 	a4l_lock_irqsave(&counter->lock, flags);
 	if (counter->mite_chan)
-		mite_dma_arm(counter->mite_chan);
+		a4l_mite_dma_arm(counter->mite_chan);
 	else
 		retval = -EIO;
 	a4l_unlock_irqrestore(&counter->lock, flags);
@@ -1642,10 +1642,10 @@
 	switch (counter_dev->variant) {
 	case ni_gpct_variant_m_series:
 	case ni_gpct_variant_660x:
-		mite_prep_dma(counter->mite_chan, 32, 32);
+		a4l_mite_prep_dma(counter->mite_chan, 32, 32);
 		break;
 	case ni_gpct_variant_e_series:
-		mite_prep_dma(counter->mite_chan, 16, 32);
+		a4l_mite_prep_dma(counter->mite_chan, 16, 32);
 		break;
 	default:
 		BUG();
@@ -1656,16 +1656,16 @@
 	ni_tio_configure_dma(counter, 1, 1);
 	switch (cmd->start_src) {
 	case TRIG_NOW:
-		mite_dma_arm(counter->mite_chan);
+		a4l_mite_dma_arm(counter->mite_chan);
 		retval = ni_tio_arm(counter, 1, NI_GPCT_ARM_IMMEDIATE);
 		break;
 	case TRIG_INT:
 		break;
 	case TRIG_EXT:
-		mite_dma_arm(counter->mite_chan);
+		a4l_mite_dma_arm(counter->mite_chan);
 		retval = ni_tio_arm(counter, 1, cmd->start_arg);
 	case TRIG_OTHER:
-		mite_dma_arm(counter->mite_chan);
+		a4l_mite_dma_arm(counter->mite_chan);
 		break;
 	default:
 		BUG();
@@ -1704,14 +1704,14 @@
 	return retval;
 }
 
-int ni_tio_cmd(struct ni_gpct *counter, a4l_cmd_t *cmd)
+int a4l_ni_tio_cmd(struct ni_gpct *counter, a4l_cmd_t *cmd)
 {
 	int retval = 0;
 	unsigned long flags;
 
 	a4l_lock_irqsave(&counter->lock, flags);
 	if (counter->mite_chan == NULL) {
-		__a4l_err("ni_tio_cmd: commands only supported with DMA."
+		__a4l_err("a4l_ni_tio_cmd: commands only supported with DMA."
 			     " Interrupt-driven commands not yet implemented.\n");
 		retval = -EIO;
 	} else {
@@ -1728,7 +1728,7 @@
 	return retval;
 }
 
-a4l_cmd_t ni_tio_cmd_mask = {
+a4l_cmd_t a4l_ni_tio_cmd_mask = {
 	.idx_subd = 0,
 	.start_src = TRIG_NOW | TRIG_INT | TRIG_OTHER | TRIG_EXT,
 	.scan_begin_src = TRIG_FOLLOW | TRIG_EXT | TRIG_OTHER,
@@ -1737,7 +1737,7 @@
 	.stop_src = TRIG_NONE,
 };
 
-int ni_tio_cmdtest(struct ni_gpct *counter, a4l_cmd_t *cmd)
+int a4l_ni_tio_cmdtest(struct ni_gpct *counter, a4l_cmd_t *cmd)
 {
 	/* Make sure trigger sources are trivially valid */
 
@@ -1783,14 +1783,14 @@
 	return 0;
 }
 
-int ni_tio_cancel(struct ni_gpct *counter)
+int a4l_ni_tio_cancel(struct ni_gpct *counter)
 {
 	unsigned long flags;
 
 	ni_tio_arm(counter, 0, 0);
 	a4l_lock_irqsave(&counter->lock, flags);
 	if (counter->mite_chan) {
-		mite_dma_disarm(counter->mite_chan);
+		a4l_mite_dma_disarm(counter->mite_chan);
 	}
 	a4l_unlock_irqrestore(&counter->lock, flags);
 	ni_tio_configure_dma(counter, 0, 0);
@@ -1822,7 +1822,7 @@
 		{
 			if (counter->mite_chan == NULL ||
 				counter->mite_chan->dir != A4L_INPUT ||
-				(mite_done(counter->mite_chan))) {
+				(a4l_mite_done(counter->mite_chan))) {
 				retval = 1;
 			}
 		}
@@ -1832,7 +1832,7 @@
 	return retval;
 }
 
-void ni_tio_acknowledge_and_confirm(struct ni_gpct *counter,
+void a4l_ni_tio_acknowledge_and_confirm(struct ni_gpct *counter,
 				    int *gate_error,
 				    int *tc_error,
 				    int *perm_stale_data, int *stale_data)
@@ -1900,7 +1900,7 @@
 }
 
 /* TODO: to be adapted after a4l_buf_evt review */
-void ni_tio_handle_interrupt(struct ni_gpct *counter, a4l_dev_t *dev)
+void a4l_ni_tio_handle_interrupt(struct ni_gpct *counter, a4l_dev_t *dev)
 {
 	unsigned gpct_mite_status;
 	unsigned long flags;
@@ -1910,7 +1910,7 @@
 	a4l_subd_t *subd =
 		a4l_get_subd(dev, NI_GPCT_SUBDEV(counter->counter_index));
 
-	ni_tio_acknowledge_and_confirm(counter, &gate_error, &tc_error,
+	a4l_ni_tio_acknowledge_and_confirm(counter, &gate_error, &tc_error,
 		&perm_stale_data, NULL);
 	if (gate_error) {
 		__a4l_err("%s: Gi_Gate_Error detected.\n", __FUNCTION__);
@@ -1937,17 +1937,17 @@
 		a4l_unlock_irqrestore(&counter->lock, flags);
 		return;
 	}
-	gpct_mite_status = mite_get_status(counter->mite_chan);
+	gpct_mite_status = a4l_mite_get_status(counter->mite_chan);
 	if (gpct_mite_status & CHSR_LINKC) {
 		writel(CHOR_CLRLC,
 			counter->mite_chan->mite->mite_io_addr +
 			MITE_CHOR(counter->mite_chan->channel));
 	}
-	mite_sync_input_dma(counter->mite_chan, subd);
+	a4l_mite_sync_input_dma(counter->mite_chan, subd);
 	a4l_unlock_irqrestore(&counter->lock, flags);
 }
 
-void ni_tio_set_mite_channel(struct ni_gpct *counter,
+void a4l_ni_tio_set_mite_channel(struct ni_gpct *counter,
 			     struct mite_channel *mite_chan)
 {
 	unsigned long flags;
@@ -1974,23 +1974,23 @@
 module_init(ni_tio_init_module);
 module_exit(ni_tio_cleanup_module);
 
-EXPORT_SYMBOL_GPL(ni_tio_rinsn);
-EXPORT_SYMBOL_GPL(ni_tio_winsn);
-EXPORT_SYMBOL_GPL(ni_tio_insn_config);
-EXPORT_SYMBOL_GPL(ni_tio_init_counter);
-EXPORT_SYMBOL_GPL(ni_gpct_device_construct);
-EXPORT_SYMBOL_GPL(ni_gpct_device_destroy);
+EXPORT_SYMBOL_GPL(a4l_ni_tio_rinsn);
+EXPORT_SYMBOL_GPL(a4l_ni_tio_winsn);
+EXPORT_SYMBOL_GPL(a4l_ni_tio_insn_config);
+EXPORT_SYMBOL_GPL(a4l_ni_tio_init_counter);
+EXPORT_SYMBOL_GPL(a4l_ni_gpct_device_construct);
+EXPORT_SYMBOL_GPL(a4l_ni_gpct_device_destroy);
 
 #if (defined(CONFIG_XENO_DRIVERS_ANALOGY_NI_MITE) || \
      defined(CONFIG_XENO_DRIVERS_ANALOGY_NI_MITE_MODULE))
 
-EXPORT_SYMBOL_GPL(ni_tio_input_inttrig);
-EXPORT_SYMBOL_GPL(ni_tio_cmd);
-EXPORT_SYMBOL_GPL(ni_tio_cmd_mask);
-EXPORT_SYMBOL_GPL(ni_tio_cmdtest);
-EXPORT_SYMBOL_GPL(ni_tio_cancel);
-EXPORT_SYMBOL_GPL(ni_tio_handle_interrupt);
-EXPORT_SYMBOL_GPL(ni_tio_set_mite_channel);
-EXPORT_SYMBOL_GPL(ni_tio_acknowledge_and_confirm);
+EXPORT_SYMBOL_GPL(a4l_ni_tio_input_inttrig);
+EXPORT_SYMBOL_GPL(a4l_ni_tio_cmd);
+EXPORT_SYMBOL_GPL(a4l_ni_tio_cmd_mask);
+EXPORT_SYMBOL_GPL(a4l_ni_tio_cmdtest);
+EXPORT_SYMBOL_GPL(a4l_ni_tio_cancel);
+EXPORT_SYMBOL_GPL(a4l_ni_tio_handle_interrupt);
+EXPORT_SYMBOL_GPL(a4l_ni_tio_set_mite_channel);
+EXPORT_SYMBOL_GPL(a4l_ni_tio_acknowledge_and_confirm);
 
 #endif /* CONFIG_XENO_DRIVERS_ANALOGY_NI_MITE */

--- xenomai-2.5.6/ksrc/drivers/analogy/national_instruments/mio_common.c.orig
+++ xenomai-2.5.6/ksrc/drivers/analogy/national_instruments/mio_common.c
@@ -91,7 +91,7 @@
 	RANGE_V(0, 0.2),
 	RANGE_V(0, 0.1),
 }};
-a4l_rngdesc_t range_ni_E_ai =
+a4l_rngdesc_t a4l_range_ni_E_ai =
 	RNG_GLOBAL(rng_ni_E_ai);
 
 a4l_rngtab_t rng_ni_E_ai_limited = {8, {
@@ -104,7 +104,7 @@
 	RANGE_V(0, 1),
 	RANGE_V(0, 0.1),
 }};
-a4l_rngdesc_t range_ni_E_ai_limited =
+a4l_rngdesc_t a4l_range_ni_E_ai_limited =
 	RNG_GLOBAL(rng_ni_E_ai_limited);
 
 a4l_rngtab_t rng_ni_E_ai_limited14 = {14, {
@@ -123,7 +123,7 @@
 	RANGE_V(0, 0.2),
 	RANGE_V(0, 0.1),
 }};
-a4l_rngdesc_t range_ni_E_ai_limited14 =
+a4l_rngdesc_t a4l_range_ni_E_ai_limited14 =
 	RNG_GLOBAL(rng_ni_E_ai_limited14);
 
 a4l_rngtab_t rng_ni_E_ai_bipolar4 = {4, {
@@ -132,7 +132,7 @@
 	RANGE_V(-0.5, 0.5),
 	RANGE_V(-0.05, 0.05),
 }};
-a4l_rngdesc_t range_ni_E_ai_bipolar4 =
+a4l_rngdesc_t a4l_range_ni_E_ai_bipolar4 =
 	RNG_GLOBAL(rng_ni_E_ai_bipolar4);
 
 a4l_rngtab_t rng_ni_E_ai_611x = {8, {
@@ -145,7 +145,7 @@
 	RANGE_V(-0.5, 0.5),
 	RANGE_V(-0.2, 0.2),
 }};
-a4l_rngdesc_t range_ni_E_ai_611x =
+a4l_rngdesc_t a4l_range_ni_E_ai_611x =
 	RNG_GLOBAL(rng_ni_E_ai_611x);
 
 a4l_rngtab_t rng_ni_M_ai_622x = {4, {
@@ -154,7 +154,7 @@
 	RANGE_V(-1, 1),
 	RANGE_V(-0.2, 0.2),
 }};
-a4l_rngdesc_t range_ni_M_ai_622x =
+a4l_rngdesc_t a4l_range_ni_M_ai_622x =
 	RNG_GLOBAL(rng_ni_M_ai_622x);
 
 a4l_rngtab_t rng_ni_M_ai_628x = {7, {
@@ -166,13 +166,13 @@
 	RANGE_V(-0.2, 0.2),
 	RANGE_V(-0.1, 0.1),
 }};
-a4l_rngdesc_t range_ni_M_ai_628x =
+a4l_rngdesc_t a4l_range_ni_M_ai_628x =
 	RNG_GLOBAL(rng_ni_M_ai_628x);
 
 a4l_rngtab_t rng_ni_S_ai_6143 = {1, {
 	RANGE_V(-5, 5),
 }};
-a4l_rngdesc_t range_ni_S_ai_6143 =
+a4l_rngdesc_t a4l_range_ni_S_ai_6143 =
 	RNG_GLOBAL(rng_ni_S_ai_6143);
 
 
@@ -182,18 +182,18 @@
 	RANGE_ext(-1, 1),
 	RANGE_ext(0, 1),
 }};
-a4l_rngdesc_t range_ni_E_ao_ext =
+a4l_rngdesc_t a4l_range_ni_E_ao_ext =
 	RNG_GLOBAL(rng_ni_E_ao_ext);
 
 a4l_rngdesc_t *ni_range_lkup[] = {
-	&range_ni_E_ai,
-	&range_ni_E_ai_limited,
-	&range_ni_E_ai_limited14,
-	&range_ni_E_ai_bipolar4,
-	&range_ni_E_ai_611x,
-	&range_ni_M_ai_622x,
-	&range_ni_M_ai_628x,
-	&range_ni_S_ai_6143
+	&a4l_range_ni_E_ai,
+	&a4l_range_ni_E_ai_limited,
+	&a4l_range_ni_E_ai_limited14,
+	&a4l_range_ni_E_ai_bipolar4,
+	&a4l_range_ni_E_ai_611x,
+	&a4l_range_ni_M_ai_622x,
+	&a4l_range_ni_M_ai_628x,
+	&a4l_range_ni_S_ai_6143
 };
 
 static const int num_adc_stages_611x = 3;
@@ -392,7 +392,7 @@
 		return -EBUSY;
 	}
 	mite_chan->dir = direction;
-	ni_tio_set_mite_channel(devpriv->counter_dev->counters[gpct_index],
+	a4l_ni_tio_set_mite_channel(devpriv->counter_dev->counters[gpct_index],
 				mite_chan);
 	ni_set_gpct_dma_channel(dev, gpct_index, mite_chan->channel);
 	a4l_unlock_irqrestore(&devpriv->mite_channel_lock, flags);
@@ -435,7 +435,7 @@
 	a4l_lock_irqsave(&devpriv->mite_channel_lock, flags);
 	if (devpriv->ai_mite_chan) {
 		ni_set_ai_dma_channel(dev, -1);
-		mite_release_channel(devpriv->ai_mite_chan);
+		a4l_mite_release_channel(devpriv->ai_mite_chan);
 		devpriv->ai_mite_chan = NULL;
 	}
 	a4l_unlock_irqrestore(&devpriv->mite_channel_lock, flags);
@@ -449,7 +449,7 @@
 	a4l_lock_irqsave(&devpriv->mite_channel_lock, flags);
 	if (devpriv->ao_mite_chan) {
 		ni_set_ao_dma_channel(dev, -1);
-		mite_release_channel(devpriv->ao_mite_chan);
+		a4l_mite_release_channel(devpriv->ao_mite_chan);
 		devpriv->ao_mite_chan = NULL;
 	}
 	a4l_unlock_irqrestore(&devpriv->mite_channel_lock, flags);
@@ -467,9 +467,9 @@
 			devpriv->counter_dev->counters[gpct_index]->mite_chan;
 
 		ni_set_gpct_dma_channel(dev, gpct_index, -1);
-		ni_tio_set_mite_channel(devpriv->counter_dev->
+		a4l_ni_tio_set_mite_channel(devpriv->counter_dev->
 					counters[gpct_index], NULL);
-		mite_release_channel(mite_chan);
+		a4l_mite_release_channel(mite_chan);
 	}
 	a4l_unlock_irqrestore(&devpriv->mite_channel_lock, flags);
 
@@ -482,7 +482,7 @@
 	a4l_lock_irqsave(&devpriv->mite_channel_lock, flags);
 	if (devpriv->cdo_mite_chan) {
 		ni_set_cdo_dma_channel(dev, -1);
-		mite_release_channel(devpriv->cdo_mite_chan);
+		a4l_mite_release_channel(devpriv->cdo_mite_chan);
 		devpriv->cdo_mite_chan = NULL;
 	}
 	a4l_unlock_irqrestore(&devpriv->mite_channel_lock, flags);
@@ -496,7 +496,7 @@
 
 	a4l_lock_irqsave(&devpriv->mite_channel_lock, flags);
 	if (devpriv->ai_mite_chan)
-		mite_sync_input_dma(devpriv->ai_mite_chan, subd);
+		a4l_mite_sync_input_dma(devpriv->ai_mite_chan, subd);
 	a4l_unlock_irqrestore(&devpriv->mite_channel_lock, flags);
 }
 
@@ -507,7 +507,7 @@
 
 	a4l_lock_irqsave(&devpriv->mite_channel_lock, flags);
 	if (devpriv->ao_mite_chan)
-		mite_sync_output_dma(devpriv->ao_mite_chan, subd);
+		a4l_mite_sync_output_dma(devpriv->ao_mite_chan, subd);
 	a4l_unlock_irqrestore(&devpriv->mite_channel_lock, flags);
 }
 
@@ -747,7 +747,7 @@
 {
 #if (defined(CONFIG_XENO_DRIVERS_ANALOGY_NI_MITE) || \
      defined(CONFIG_XENO_DRIVERS_ANALOGY_NI_MITE_MODULE))
-	ni_tio_handle_interrupt(devpriv->counter_dev->counters[counter_index],
+	a4l_ni_tio_handle_interrupt(devpriv->counter_dev->counters[counter_index],
 				dev);
 #endif /* CONFIG_XENO_DRIVERS_ANALOGY_NI_MITE */
 }
@@ -1022,7 +1022,7 @@
 	ni_event(subd);
 }
 
-int ni_E_interrupt(unsigned int irq, void *d)
+int a4l_ni_E_interrupt(unsigned int irq, void *d)
 {
 	a4l_dev_t *dev = d;
 	unsigned short a_status;
@@ -1045,14 +1045,14 @@
      defined(CONFIG_XENO_DRIVERS_ANALOGY_NI_MITE_MODULE))
  		a4l_lock(&devpriv->mite_channel_lock);
 		if (devpriv->ai_mite_chan) {
-			ai_mite_status = mite_get_status(devpriv->ai_mite_chan);
+			ai_mite_status = a4l_mite_get_status(devpriv->ai_mite_chan);
 			if (ai_mite_status & CHSR_LINKC)
 				writel(CHOR_CLRLC,
 				       devpriv->mite->mite_io_addr +
 				       MITE_CHOR(devpriv->ai_mite_chan->channel));
 		}
 		if (devpriv->ao_mite_chan) {
-			ao_mite_status = mite_get_status(devpriv->ao_mite_chan);
+			ao_mite_status = a4l_mite_get_status(devpriv->ao_mite_chan);
 			if (ao_mite_status & CHSR_LINKC)
 				writel(CHOR_CLRLC,
 				       mite->mite_io_addr +
@@ -1257,7 +1257,7 @@
 			if ((devpriv->stc_readw(dev,
 						AI_Status_1_Register) &
 			     AI_FIFO_Empty_St)
-			    && mite_bytes_in_transit(devpriv->
+			    && a4l_mite_bytes_in_transit(devpriv->
 						     ai_mite_chan) == 0)
 				break;
 			a4l_udelay(5);
@@ -1268,9 +1268,9 @@
 				 "wait for dma drain timed out\n");
 
 			a4l_info(dev,
-				 "mite_bytes_in_transit=%i, "
+				 "a4l_mite_bytes_in_transit=%i, "
 				 "AI_Status1_Register=0x%x\n",
-				 mite_bytes_in_transit(devpriv->ai_mite_chan),
+				 a4l_mite_bytes_in_transit(devpriv->ai_mite_chan),
 				 devpriv->stc_readw(dev, AI_Status_1_Register));
 			retval = -1;
 		}
@@ -1437,7 +1437,7 @@
 	if (err < 0)
 		return err;
 
-	err = mite_buf_change(devpriv->ai_mite_chan->ring, subd);
+	err = a4l_mite_buf_change(devpriv->ai_mite_chan->ring, subd);
 	if (err < 0)
 		return err;
 
@@ -1446,18 +1446,18 @@
 	switch (boardtype.reg_type) {
 	case ni_reg_611x:
 	case ni_reg_6143:
-		mite_prep_dma(devpriv->ai_mite_chan, 32, 16);
+		a4l_mite_prep_dma(devpriv->ai_mite_chan, 32, 16);
 		break;
 	case ni_reg_628x:
-		mite_prep_dma(devpriv->ai_mite_chan, 32, 32);
+		a4l_mite_prep_dma(devpriv->ai_mite_chan, 32, 32);
 		break;
 	default:
-		mite_prep_dma(devpriv->ai_mite_chan, 16, 16);
+		a4l_mite_prep_dma(devpriv->ai_mite_chan, 16, 16);
 		break;
 	};
 
 	/* start the MITE */
-	mite_dma_arm(devpriv->ai_mite_chan);
+	a4l_mite_dma_arm(devpriv->ai_mite_chan);
 
 	a4l_unlock_irqrestore(&devpriv->mite_channel_lock, flags);
 
@@ -1474,7 +1474,7 @@
 	if (err < 0)
 		return err;
 
-	err = mite_buf_change(devpriv->ao_mite_chan->ring, subd);
+	err = a4l_mite_buf_change(devpriv->ao_mite_chan->ring, subd);
 	if (err < 0)
 		return err;
 
@@ -1483,14 +1483,14 @@
 	if (devpriv->ao_mite_chan) {
 
 		if (boardtype.reg_type & (ni_reg_611x | ni_reg_6713)) {
-			mite_prep_dma(devpriv->ao_mite_chan, 32, 32);
+			a4l_mite_prep_dma(devpriv->ao_mite_chan, 32, 32);
 		} else {
 			/* Doing 32 instead of 16 bit wide transfers
 			   from memory makes the mite do 32 bit pci
 			   transfers, doubling pci bandwidth. */
-			mite_prep_dma(devpriv->ao_mite_chan, 16, 32);
+			a4l_mite_prep_dma(devpriv->ao_mite_chan, 16, 32);
 		}
-		mite_dma_arm(devpriv->ao_mite_chan);
+		a4l_mite_dma_arm(devpriv->ao_mite_chan);
 	} else
 		err = -EIO;
 
@@ -1510,7 +1510,7 @@
 		return err;
 
 	/* No need to get a lock to setup the ring buffer */
-	err = mite_buf_change(devpriv->cdo_mite_chan->ring, subd);
+	err = a4l_mite_buf_change(devpriv->cdo_mite_chan->ring, subd);
 	if (err < 0)
 		return err;
 
@@ -1519,8 +1519,8 @@
 	/* This test should be useless but one never knows */
 	if (devpriv->cdo_mite_chan) {
 		/* Configure the DMA transfer */
-		mite_prep_dma(devpriv->cdo_mite_chan, 32, 32);
-		mite_dma_arm(devpriv->cdo_mite_chan);
+		a4l_mite_prep_dma(devpriv->cdo_mite_chan, 32, 32);
+		a4l_mite_dma_arm(devpriv->cdo_mite_chan);
 	} else
 		err = -EIO;
 
@@ -3537,13 +3537,13 @@
 	a4l_lock_irqsave(&devpriv->mite_channel_lock, flags);
 	if (devpriv->cdo_mite_chan) {
 		unsigned cdo_mite_status =
-			mite_get_status(devpriv->cdo_mite_chan);
+			a4l_mite_get_status(devpriv->cdo_mite_chan);
 		if (cdo_mite_status & CHSR_LINKC) {
 			writel(CHOR_CLRLC,
 			       devpriv->mite->mite_io_addr +
 			       MITE_CHOR(devpriv->cdo_mite_chan->channel));
 		}
-		mite_sync_output_dma(devpriv->cdo_mite_chan, subd);
+		a4l_mite_sync_output_dma(devpriv->cdo_mite_chan, subd);
 	}
 	a4l_unlock_irqrestore(&devpriv->mite_channel_lock, flags);
 
@@ -3774,7 +3774,7 @@
 {
 	if (dev->priv) {
 		if (devpriv->counter_dev) {
-			ni_gpct_device_destroy(devpriv->counter_dev);
+			a4l_ni_gpct_device_destroy(devpriv->counter_dev);
 		}
 	}
 }
@@ -4463,19 +4463,19 @@
 static int ni_gpct_insn_config(a4l_subd_t *subd, a4l_kinsn_t *insn)
 {
 	struct ni_gpct *counter = (struct ni_gpct *)subd->priv;
-	return ni_tio_insn_config(counter, insn);
+	return a4l_ni_tio_insn_config(counter, insn);
 }
 
 static int ni_gpct_insn_read(a4l_subd_t *subd, a4l_kinsn_t *insn)
 {
 	struct ni_gpct *counter = (struct ni_gpct *)subd->priv;
-	return ni_tio_rinsn(counter, insn);
+	return a4l_ni_tio_rinsn(counter, insn);
 }
 
 static int ni_gpct_insn_write(a4l_subd_t *subd, a4l_kinsn_t *insn)
 {
 	struct ni_gpct *counter = (struct ni_gpct *)subd->priv;
-	return ni_tio_winsn(counter, insn);
+	return a4l_ni_tio_winsn(counter, insn);
 }
 
 #if (defined(CONFIG_XENO_DRIVERS_ANALOGY_NI_MITE) || \
@@ -4499,7 +4499,7 @@
 	}
 
 	ring = devpriv->gpct_mite_ring[counter->counter_index];
-	retval = mite_buf_change(ring, subd);
+	retval = a4l_mite_buf_change(ring, subd);
 	if (retval) {
 		a4l_err(dev,
 			"ni_gpct_cmd: "
@@ -4508,9 +4508,9 @@
 
 	}
 
-	ni_tio_acknowledge_and_confirm(counter, NULL, NULL, NULL, NULL);
+	a4l_ni_tio_acknowledge_and_confirm(counter, NULL, NULL, NULL, NULL);
 	ni_e_series_enable_second_irq(dev, counter->counter_index, 1);
-	retval = ni_tio_cmd(counter, cmd);
+	retval = a4l_ni_tio_cmd(counter, cmd);
 
 	return retval;
 }
@@ -4518,7 +4518,7 @@
 static int ni_gpct_cmdtest(a4l_subd_t *subd, a4l_cmd_t *cmd)
 {
 	struct ni_gpct *counter = (struct ni_gpct *)subd->priv;
-	return ni_tio_cmdtest(counter, cmd);
+	return a4l_ni_tio_cmdtest(counter, cmd);
 }
 
 static int ni_gpct_cancel(a4l_subd_t *subd)
@@ -4527,7 +4527,7 @@
 	struct ni_gpct *counter = (struct ni_gpct *)subd->priv;
 	int retval;
 
-	retval = ni_tio_cancel(counter);
+	retval = a4l_ni_tio_cancel(counter);
 	ni_e_series_enable_second_irq(dev, counter->counter_index, 0);
 	ni_release_gpct_mite_channel(dev, counter->counter_index);
 	return retval;
@@ -4932,7 +4932,7 @@
 			    RTSI_Trig_B_Output_Register);
 }
 
-int ni_E_init(a4l_dev_t *dev)
+int a4l_ni_E_init(a4l_dev_t *dev)
 {
 	int ret;
 	unsigned int j, counter_variant;
@@ -5125,7 +5125,7 @@
 	if (boardtype.has_8255) {
 		devpriv->subd_8255.cb_arg = (unsigned long)dev;
 		devpriv->subd_8255.cb_func = ni_8255_callback;
-		subdev_8255_init(subd);
+		a4l_subdev_8255_init(subd);
 	} else {
 		a4l_dbg(1, drv_dbg, dev,
 			"mio_common: 8255 subdevice not present\n");
@@ -5277,7 +5277,7 @@
 		subd->chan_desc->chans[0].nb_bits = 16;
 
 		/* one channel for each analog output channel */
-		subd->rng_desc = &range_unknown;	/* XXX */
+		subd->rng_desc = &a4l_range_unknown;	/* XXX */
 		s->insn_read = cs5529_ai_insn_read;
 		init_cs5529(dev);
 	} else
@@ -5350,7 +5350,7 @@
 	} else {
 		counter_variant = ni_gpct_variant_e_series;
 	}
-	devpriv->counter_dev = ni_gpct_device_construct(dev,
+	devpriv->counter_dev = a4l_ni_gpct_device_construct(dev,
 							&ni_gpct_write_register, &ni_gpct_read_register,
 							counter_variant, NUM_GPCT);
 
@@ -5392,7 +5392,7 @@
 		a4l_dbg(1, drv_dbg, dev,
 			"mio_common: GPCT[%d]: command feature available\n", j);
 		subd->flags |= A4L_SUBD_CMD;
-		subd->cmd_mask = &ni_tio_cmd_mask;
+		subd->cmd_mask = &a4l_ni_tio_cmd_mask;
 		subd->do_cmd = ni_gpct_cmd;
 		subd->do_cmdtest = ni_gpct_cmdtest;
 		subd->cancel = ni_gpct_cancel;
@@ -5405,7 +5405,7 @@
 		counter->counter_dev = devpriv->counter_dev;
 		devpriv->counter_dev->counters[j] = counter;
 
-		ni_tio_init_counter(counter);
+		a4l_ni_tio_init_counter(counter);
 
 		ret = a4l_add_subd(dev, subd);
 		if(ret != NI_GPCT_SUBDEV(j))
@@ -5510,14 +5510,14 @@
 MODULE_DESCRIPTION("Analogy support for NI DAQ-STC based boards");
 MODULE_LICENSE("GPL");
 
-EXPORT_SYMBOL_GPL(range_ni_E_ai);
-EXPORT_SYMBOL_GPL(range_ni_E_ai_limited);
-EXPORT_SYMBOL_GPL(range_ni_E_ai_limited14);
-EXPORT_SYMBOL_GPL(range_ni_E_ai_bipolar4);
-EXPORT_SYMBOL_GPL(range_ni_E_ai_611x);
-EXPORT_SYMBOL_GPL(range_ni_M_ai_622x);
-EXPORT_SYMBOL_GPL(range_ni_M_ai_628x);
-EXPORT_SYMBOL_GPL(range_ni_S_ai_6143);
-EXPORT_SYMBOL_GPL(range_ni_E_ao_ext);
-EXPORT_SYMBOL_GPL(ni_E_interrupt);
-EXPORT_SYMBOL_GPL(ni_E_init);
+EXPORT_SYMBOL_GPL(a4l_range_ni_E_ai);
+EXPORT_SYMBOL_GPL(a4l_range_ni_E_ai_limited);
+EXPORT_SYMBOL_GPL(a4l_range_ni_E_ai_limited14);
+EXPORT_SYMBOL_GPL(a4l_range_ni_E_ai_bipolar4);
+EXPORT_SYMBOL_GPL(a4l_range_ni_E_ai_611x);
+EXPORT_SYMBOL_GPL(a4l_range_ni_M_ai_622x);
+EXPORT_SYMBOL_GPL(a4l_range_ni_M_ai_628x);
+EXPORT_SYMBOL_GPL(a4l_range_ni_S_ai_6143);
+EXPORT_SYMBOL_GPL(a4l_range_ni_E_ao_ext);
+EXPORT_SYMBOL_GPL(a4l_ni_E_interrupt);
+EXPORT_SYMBOL_GPL(a4l_ni_E_init);

--- xenomai-2.5.6/ksrc/drivers/analogy/national_instruments/ni_mio.h.orig
+++ xenomai-2.5.6/ksrc/drivers/analogy/national_instruments/ni_mio.h
@@ -105,20 +105,20 @@
 
 /* Ranges declarations */
 
-extern a4l_rngdesc_t range_ni_E_ai;
-extern a4l_rngdesc_t range_ni_E_ai_limited;
-extern a4l_rngdesc_t range_ni_E_ai_limited14;
-extern a4l_rngdesc_t range_ni_E_ai_bipolar4;
-extern a4l_rngdesc_t range_ni_E_ai_611x;
+extern a4l_rngdesc_t a4l_range_ni_E_ai;
+extern a4l_rngdesc_t a4l_range_ni_E_ai_limited;
+extern a4l_rngdesc_t a4l_range_ni_E_ai_limited14;
+extern a4l_rngdesc_t a4l_range_ni_E_ai_bipolar4;
+extern a4l_rngdesc_t a4l_range_ni_E_ai_611x;
 extern a4l_rngdesc_t range_ni_E_ai_622x;
 extern a4l_rngdesc_t range_ni_E_ai_628x;
-extern a4l_rngdesc_t range_ni_S_ai_6143;
-extern a4l_rngdesc_t range_ni_E_ao_ext;
+extern a4l_rngdesc_t a4l_range_ni_S_ai_6143;
+extern a4l_rngdesc_t a4l_range_ni_E_ao_ext;
 
 /* Misc functions declarations */
 
-int ni_E_interrupt(unsigned int irq, void *d);
-int ni_E_init(a4l_dev_t *dev);
+int a4l_ni_E_interrupt(unsigned int irq, void *d);
+int a4l_ni_E_init(a4l_dev_t *dev);
 
 
 #endif /* !__ANALOGY_NI_MIO_H__ */

--- xenomai-2.5.6/ksrc/drivers/analogy/national_instruments/ni_tio.h.orig
+++ xenomai-2.5.6/ksrc/drivers/analogy/national_instruments/ni_tio.h
@@ -1158,33 +1158,33 @@
 #define NI_RTSI_OUTPUT_RTSI_BRD(x) (NI_RTSI_OUTPUT_RTSI_BRD_0 + (x))
 
 
-int ni_tio_rinsn(struct ni_gpct *counter, a4l_kinsn_t *insn);
-int ni_tio_winsn(struct ni_gpct *counter, a4l_kinsn_t *insn);
-int ni_tio_insn_config(struct ni_gpct *counter, a4l_kinsn_t *insn);
-void ni_tio_init_counter(struct ni_gpct *counter);
+int a4l_ni_tio_rinsn(struct ni_gpct *counter, a4l_kinsn_t *insn);
+int a4l_ni_tio_winsn(struct ni_gpct *counter, a4l_kinsn_t *insn);
+int a4l_ni_tio_insn_config(struct ni_gpct *counter, a4l_kinsn_t *insn);
+void a4l_ni_tio_init_counter(struct ni_gpct *counter);
 
-struct ni_gpct_device *ni_gpct_device_construct(a4l_dev_t * dev,
+struct ni_gpct_device *a4l_ni_gpct_device_construct(a4l_dev_t * dev,
 	void (*write_register) (struct ni_gpct * counter, unsigned int bits,
 		enum ni_gpct_register reg),
 	unsigned int (*read_register) (struct ni_gpct * counter,
 		enum ni_gpct_register reg), enum ni_gpct_variant variant,
 	unsigned int num_counters);
-void ni_gpct_device_destroy(struct ni_gpct_device *counter_dev);
+void a4l_ni_gpct_device_destroy(struct ni_gpct_device *counter_dev);
 
 #if (defined(CONFIG_XENO_DRIVERS_ANALOGY_NI_MITE) || \
      defined(CONFIG_XENO_DRIVERS_ANALOGY_NI_MITE_MODULE))
 
-extern a4l_cmd_t ni_tio_cmd_mask;
+extern a4l_cmd_t a4l_ni_tio_cmd_mask;
 
-int ni_tio_input_inttrig(struct ni_gpct *counter, lsampl_t trignum);
-int ni_tio_cmd(struct ni_gpct *counter, a4l_cmd_t *cmd);
-int ni_tio_cmdtest(struct ni_gpct *counter, a4l_cmd_t *cmd);
-int ni_tio_cancel(struct ni_gpct *counter);
+int a4l_ni_tio_input_inttrig(struct ni_gpct *counter, lsampl_t trignum);
+int a4l_ni_tio_cmd(struct ni_gpct *counter, a4l_cmd_t *cmd);
+int a4l_ni_tio_cmdtest(struct ni_gpct *counter, a4l_cmd_t *cmd);
+int a4l_ni_tio_cancel(struct ni_gpct *counter);
 
-void ni_tio_handle_interrupt(struct ni_gpct *counter, a4l_dev_t *dev);
-void ni_tio_set_mite_channel(struct ni_gpct *counter,
+void a4l_ni_tio_handle_interrupt(struct ni_gpct *counter, a4l_dev_t *dev);
+void a4l_ni_tio_set_mite_channel(struct ni_gpct *counter,
 			     struct mite_channel *mite_chan);
-void ni_tio_acknowledge_and_confirm(struct ni_gpct *counter,
+void a4l_ni_tio_acknowledge_and_confirm(struct ni_gpct *counter,
 				    int *gate_error,
 				    int *tc_error,
 				    int *perm_stale_data, int *stale_data);

--- xenomai-2.5.6/ksrc/drivers/analogy/national_instruments/mite.c.orig
+++ xenomai-2.5.6/ksrc/drivers/analogy/national_instruments/mite.c
@@ -107,7 +107,7 @@
 	.remove = mite_remove,
 };
 
-int mite_setup(struct mite_struct *mite, int use_iodwbsr_1)
+int a4l_mite_setup(struct mite_struct *mite, int use_iodwbsr_1)
 {
 	unsigned long length;
 	resource_size_t addr;
@@ -232,7 +232,7 @@
 	return 0;
 }
 
-void mite_unsetup(struct mite_struct *mite)
+void a4l_mite_unsetup(struct mite_struct *mite)
 {
 	if (!mite)
 		return;
@@ -253,7 +253,7 @@
 	mite->used = 0;
 }
 
-void mite_list_devices(void)
+void a4l_mite_list_devices(void)
 {
 	struct list_head *this;
 
@@ -272,7 +272,7 @@
 
 
 
-struct mite_struct * mite_find_device(int bus, int slot, unsigned short device_id)
+struct mite_struct * a4l_mite_find_device(int bus, int slot, unsigned short device_id)
 {
 	struct list_head *this;
 
@@ -291,9 +291,9 @@
 
 	return NULL;
 }
-EXPORT_SYMBOL_GPL(mite_find_device);
+EXPORT_SYMBOL_GPL(a4l_mite_find_device);
 
-struct mite_channel *mite_request_channel_in_range(struct mite_struct *mite,
+struct mite_channel *a4l_mite_request_channel_in_range(struct mite_struct *mite,
 						   struct mite_dma_descriptor_ring *ring,
 						   unsigned min_channel,
 						   unsigned max_channel)
@@ -303,16 +303,16 @@
 	struct mite_channel *channel = NULL;
 
 	__a4l_dbg(1, drv_dbg,
-		  "mite: mite_request_channel_in_range: "
+		  "mite: a4l_mite_request_channel_in_range: "
 		  "min_channel = %u, max_channel = %u\n",
 		  min_channel, max_channel);
 
-	/* spin lock so mite_release_channel can be called safely from interrupts */
+	/* spin lock so a4l_mite_release_channel can be called safely from interrupts */
 	a4l_lock_irqsave(&mite->lock, flags);
 	for (i = min_channel; i <= max_channel; ++i) {
 
 	__a4l_dbg(1, drv_dbg,
-		  "mite: mite_request_channel_in_range: "
+		  "mite: a4l_mite_request_channel_in_range: "
 		  "channel[%d] allocated = %d\n",
 		  i, mite->channel_allocated[i]);
 
@@ -327,7 +327,7 @@
 	return channel;
 }
 
-void mite_release_channel(struct mite_channel *mite_chan)
+void a4l_mite_release_channel(struct mite_channel *mite_chan)
 {
 	struct mite_struct *mite = mite_chan->mite;
 	unsigned long flags;
@@ -341,7 +341,7 @@
 		       CHCR_CLR_MRDY_IE | CHCR_CLR_DRDY_IE |
 		       CHCR_CLR_LC_IE | CHCR_CLR_CONT_RB_IE,
 		       mite->mite_io_addr + MITE_CHCR(mite_chan->channel));
-		mite_dma_disarm(mite_chan);
+		a4l_mite_dma_disarm(mite_chan);
 		mite_dma_reset(mite_chan);
 		mite->channel_allocated[mite_chan->channel] = 0;
 		mite_chan->ring = NULL;
@@ -350,13 +350,13 @@
 	a4l_unlock_irqrestore(&mite->lock, flags);
 }
 
-void mite_dma_arm(struct mite_channel *mite_chan)
+void a4l_mite_dma_arm(struct mite_channel *mite_chan)
 {
 	struct mite_struct *mite = mite_chan->mite;
 	int chor;
 	unsigned long flags;
 
-	MDPRINTK("mite_dma_arm ch%i\n", mite_chan->channel);
+	MDPRINTK("a4l_mite_dma_arm ch%i\n", mite_chan->channel);
 	/* Memory barrier is intended to insure any twiddling with the buffer
 	   is done before writing to the mite to arm dma transfer */
 	smp_mb();
@@ -369,7 +369,7 @@
 	a4l_unlock_irqrestore(&mite->lock, flags);
 }
 
-void mite_dma_disarm(struct mite_channel *mite_chan)
+void a4l_mite_dma_disarm(struct mite_channel *mite_chan)
 {
 	struct mite_struct *mite = mite_chan->mite;
 	unsigned chor;
@@ -379,7 +379,7 @@
 	writel(chor, mite->mite_io_addr + MITE_CHOR(mite_chan->channel));
 }
 
-int mite_buf_change(struct mite_dma_descriptor_ring *ring, a4l_subd_t *subd)
+int a4l_mite_buf_change(struct mite_dma_descriptor_ring *ring, a4l_subd_t *subd)
 {
 	a4l_buf_t *buf = subd->buf;
 	unsigned int n_links;
@@ -429,13 +429,13 @@
 	return 0;
 }
 
-void mite_prep_dma(struct mite_channel *mite_chan,
+void a4l_mite_prep_dma(struct mite_channel *mite_chan,
 		   unsigned int num_device_bits, unsigned int num_memory_bits)
 {
 	unsigned int chor, chcr, mcr, dcr, lkcr;
 	struct mite_struct *mite = mite_chan->mite;
 
-	MDPRINTK("mite_prep_dma ch%i\n", mite_chan->channel);
+	MDPRINTK("a4l_mite_prep_dma ch%i\n", mite_chan->channel);
 
 	/* reset DMA and FIFO */
 	chor = CHOR_DMARESET | CHOR_FRESET;
@@ -519,7 +519,7 @@
 	writel(mite_chan->ring->descriptors_dma_addr,
 	       mite->mite_io_addr + MITE_LKAR(mite_chan->channel));
 
-	MDPRINTK("exit mite_prep_dma\n");
+	MDPRINTK("exit a4l_mite_prep_dma\n");
 }
 
 u32 mite_device_bytes_transferred(struct mite_channel *mite_chan)
@@ -528,7 +528,7 @@
 	return readl(mite->mite_io_addr + MITE_DAR(mite_chan->channel));
 }
 
-u32 mite_bytes_in_transit(struct mite_channel * mite_chan)
+u32 a4l_mite_bytes_in_transit(struct mite_channel * mite_chan)
 {
 	struct mite_struct *mite = mite_chan->mite;
 	return readl(mite->mite_io_addr +
@@ -536,47 +536,47 @@
 }
 
 /* Returns lower bound for number of bytes transferred from device to memory */
-u32 mite_bytes_written_to_memory_lb(struct mite_channel * mite_chan)
+u32 a4l_mite_bytes_written_to_memory_lb(struct mite_channel * mite_chan)
 {
 	u32 device_byte_count;
 
 	device_byte_count = mite_device_bytes_transferred(mite_chan);
-	return device_byte_count - mite_bytes_in_transit(mite_chan);
+	return device_byte_count - a4l_mite_bytes_in_transit(mite_chan);
 }
 
 /* Returns upper bound for number of bytes transferred from device to memory */
-u32 mite_bytes_written_to_memory_ub(struct mite_channel * mite_chan)
+u32 a4l_mite_bytes_written_to_memory_ub(struct mite_channel * mite_chan)
 {
 	u32 in_transit_count;
 
-	in_transit_count = mite_bytes_in_transit(mite_chan);
+	in_transit_count = a4l_mite_bytes_in_transit(mite_chan);
 	return mite_device_bytes_transferred(mite_chan) - in_transit_count;
 }
 
 /* Returns lower bound for number of bytes read from memory for transfer to device */
-u32 mite_bytes_read_from_memory_lb(struct mite_channel * mite_chan)
+u32 a4l_mite_bytes_read_from_memory_lb(struct mite_channel * mite_chan)
 {
 	u32 device_byte_count;
 
 	device_byte_count = mite_device_bytes_transferred(mite_chan);
-	return device_byte_count + mite_bytes_in_transit(mite_chan);
+	return device_byte_count + a4l_mite_bytes_in_transit(mite_chan);
 }
 
 /* Returns upper bound for number of bytes read from memory for transfer to device */
-u32 mite_bytes_read_from_memory_ub(struct mite_channel * mite_chan)
+u32 a4l_mite_bytes_read_from_memory_ub(struct mite_channel * mite_chan)
 {
 	u32 in_transit_count;
 
-	in_transit_count = mite_bytes_in_transit(mite_chan);
+	in_transit_count = a4l_mite_bytes_in_transit(mite_chan);
 	return mite_device_bytes_transferred(mite_chan) + in_transit_count;
 }
 
-int mite_sync_input_dma(struct mite_channel *mite_chan, a4l_subd_t *subd)
+int a4l_mite_sync_input_dma(struct mite_channel *mite_chan, a4l_subd_t *subd)
 {
 	unsigned int nbytes_lb, nbytes_ub;
 
-	nbytes_lb = mite_bytes_written_to_memory_lb(mite_chan);
-	nbytes_ub = mite_bytes_written_to_memory_ub(mite_chan);
+	nbytes_lb = a4l_mite_bytes_written_to_memory_lb(mite_chan);
+	nbytes_ub = a4l_mite_bytes_written_to_memory_ub(mite_chan);
 
 	if(a4l_buf_prepare_absput(subd, nbytes_ub) != 0) {
 		__a4l_err("MITE: DMA overwrite of free area\n");
@@ -586,14 +586,14 @@
 	return a4l_buf_commit_absput(subd, nbytes_lb);
 }
 
-int mite_sync_output_dma(struct mite_channel *mite_chan, a4l_subd_t *subd)
+int a4l_mite_sync_output_dma(struct mite_channel *mite_chan, a4l_subd_t *subd)
 {
 	a4l_buf_t *buf = subd->buf;
 	unsigned int nbytes_ub, nbytes_lb;
 	int err;
 
-	nbytes_lb = mite_bytes_read_from_memory_lb(mite_chan);
-	nbytes_ub = mite_bytes_read_from_memory_ub(mite_chan);
+	nbytes_lb = a4l_mite_bytes_read_from_memory_lb(mite_chan);
+	nbytes_ub = a4l_mite_bytes_read_from_memory_ub(mite_chan);
 
 	err = a4l_buf_prepare_absget(subd, nbytes_ub);
 	if(err < 0) {
@@ -613,7 +613,7 @@
 	return err;
 }
 
-u32 mite_get_status(struct mite_channel *mite_chan)
+u32 a4l_mite_get_status(struct mite_channel *mite_chan)
 {
 	struct mite_struct *mite = mite_chan->mite;
 	u32 status;
@@ -631,13 +631,13 @@
 	return status;
 }
 
-int mite_done(struct mite_channel *mite_chan)
+int a4l_mite_done(struct mite_channel *mite_chan)
 {
 	struct mite_struct *mite = mite_chan->mite;
 	unsigned long flags;
 	int done;
 
-	mite_get_status(mite_chan);
+	a4l_mite_get_status(mite_chan);
 	a4l_lock_irqsave(&mite->lock, flags);
 	done = mite_chan->done;
 	a4l_unlock_irqrestore(&mite->lock, flags);
@@ -646,7 +646,7 @@
 
 #ifdef CONFIG_DEBUG_MITE
 
-static void mite_decode(const char *const bit_str[], unsigned int bits);
+static void a4l_mite_decode(const char *const bit_str[], unsigned int bits);
 
 /* names of bits in mite registers */
 
@@ -717,31 +717,31 @@
 	"28", "lpauses", "30", "int",
 };
 
-void mite_dump_regs(struct mite_channel *mite_chan)
+void a4l_mite_dump_regs(struct mite_channel *mite_chan)
 {
 	unsigned long mite_io_addr =
 		(unsigned long)mite_chan->mite->mite_io_addr;
 	unsigned long addr = 0;
 	unsigned long temp = 0;
 
-	printk("mite_dump_regs ch%i\n", mite_chan->channel);
+	printk("a4l_mite_dump_regs ch%i\n", mite_chan->channel);
 	printk("mite address is  =0x%08lx\n", mite_io_addr);
 
 	addr = mite_io_addr + MITE_CHOR(mite_chan->channel);
 	printk("mite status[CHOR]at 0x%08lx =0x%08lx\n", addr, temp =
 	       readl((void *)addr));
-	mite_decode(mite_CHOR_strings, temp);
+	a4l_mite_decode(mite_CHOR_strings, temp);
 	addr = mite_io_addr + MITE_CHCR(mite_chan->channel);
 	printk("mite status[CHCR]at 0x%08lx =0x%08lx\n", addr, temp =
 	       readl((void *)addr));
-	mite_decode(mite_CHCR_strings, temp);
+	a4l_mite_decode(mite_CHCR_strings, temp);
 	addr = mite_io_addr + MITE_TCR(mite_chan->channel);
 	printk("mite status[TCR] at 0x%08lx =0x%08x\n", addr,
 	       readl((void *)addr));
 	addr = mite_io_addr + MITE_MCR(mite_chan->channel);
 	printk("mite status[MCR] at 0x%08lx =0x%08lx\n", addr, temp =
 	       readl((void *)addr));
-	mite_decode(mite_MCR_strings, temp);
+	a4l_mite_decode(mite_MCR_strings, temp);
 
 	addr = mite_io_addr + MITE_MAR(mite_chan->channel);
 	printk("mite status[MAR] at 0x%08lx =0x%08x\n", addr,
@@ -749,14 +749,14 @@
 	addr = mite_io_addr + MITE_DCR(mite_chan->channel);
 	printk("mite status[DCR] at 0x%08lx =0x%08lx\n", addr, temp =
 	       readl((void *)addr));
-	mite_decode(mite_DCR_strings, temp);
+	a4l_mite_decode(mite_DCR_strings, temp);
 	addr = mite_io_addr + MITE_DAR(mite_chan->channel);
 	printk("mite status[DAR] at 0x%08lx =0x%08x\n", addr,
 	       readl((void *)addr));
 	addr = mite_io_addr + MITE_LKCR(mite_chan->channel);
 	printk("mite status[LKCR]at 0x%08lx =0x%08lx\n", addr, temp =
 	       readl((void *)addr));
-	mite_decode(mite_LKCR_strings, temp);
+	a4l_mite_decode(mite_LKCR_strings, temp);
 	addr = mite_io_addr + MITE_LKAR(mite_chan->channel);
 	printk("mite status[LKAR]at 0x%08lx =0x%08x\n", addr,
 	       readl((void *)addr));
@@ -764,14 +764,14 @@
 	addr = mite_io_addr + MITE_CHSR(mite_chan->channel);
 	printk("mite status[CHSR]at 0x%08lx =0x%08lx\n", addr, temp =
 	       readl((void *)addr));
-	mite_decode(mite_CHSR_strings, temp);
+	a4l_mite_decode(mite_CHSR_strings, temp);
 	addr = mite_io_addr + MITE_FCR(mite_chan->channel);
 	printk("mite status[FCR] at 0x%08lx =0x%08x\n\n", addr,
 	       readl((void *)addr));
 }
 
 
-static void mite_decode(const char *const bit_str[], unsigned int bits)
+static void a4l_mite_decode(const char *const bit_str[], unsigned int bits)
 {
 	int i;
 
@@ -794,7 +794,7 @@
 	err = pci_register_driver(&mite_driver);
 
 	if(err == 0)
-		mite_list_devices();
+		a4l_mite_list_devices();
 
 	return err;
 }
@@ -820,25 +820,25 @@
 module_init(mite_init);
 module_exit(mite_cleanup);
 
-EXPORT_SYMBOL_GPL(mite_dma_arm);
-EXPORT_SYMBOL_GPL(mite_dma_disarm);
-EXPORT_SYMBOL_GPL(mite_sync_input_dma);
-EXPORT_SYMBOL_GPL(mite_sync_output_dma);
-EXPORT_SYMBOL_GPL(mite_setup);
-EXPORT_SYMBOL_GPL(mite_unsetup);
-EXPORT_SYMBOL_GPL(mite_list_devices);
-EXPORT_SYMBOL_GPL(mite_request_channel_in_range);
-EXPORT_SYMBOL_GPL(mite_release_channel);
-EXPORT_SYMBOL_GPL(mite_prep_dma);
-EXPORT_SYMBOL_GPL(mite_buf_change);
-EXPORT_SYMBOL_GPL(mite_bytes_written_to_memory_lb);
-EXPORT_SYMBOL_GPL(mite_bytes_written_to_memory_ub);
-EXPORT_SYMBOL_GPL(mite_bytes_read_from_memory_lb);
-EXPORT_SYMBOL_GPL(mite_bytes_read_from_memory_ub);
-EXPORT_SYMBOL_GPL(mite_bytes_in_transit);
-EXPORT_SYMBOL_GPL(mite_get_status);
-EXPORT_SYMBOL_GPL(mite_done);
+EXPORT_SYMBOL_GPL(a4l_mite_dma_arm);
+EXPORT_SYMBOL_GPL(a4l_mite_dma_disarm);
+EXPORT_SYMBOL_GPL(a4l_mite_sync_input_dma);
+EXPORT_SYMBOL_GPL(a4l_mite_sync_output_dma);
+EXPORT_SYMBOL_GPL(a4l_mite_setup);
+EXPORT_SYMBOL_GPL(a4l_mite_unsetup);
+EXPORT_SYMBOL_GPL(a4l_mite_list_devices);
+EXPORT_SYMBOL_GPL(a4l_mite_request_channel_in_range);
+EXPORT_SYMBOL_GPL(a4l_mite_release_channel);
+EXPORT_SYMBOL_GPL(a4l_mite_prep_dma);
+EXPORT_SYMBOL_GPL(a4l_mite_buf_change);
+EXPORT_SYMBOL_GPL(a4l_mite_bytes_written_to_memory_lb);
+EXPORT_SYMBOL_GPL(a4l_mite_bytes_written_to_memory_ub);
+EXPORT_SYMBOL_GPL(a4l_mite_bytes_read_from_memory_lb);
+EXPORT_SYMBOL_GPL(a4l_mite_bytes_read_from_memory_ub);
+EXPORT_SYMBOL_GPL(a4l_mite_bytes_in_transit);
+EXPORT_SYMBOL_GPL(a4l_mite_get_status);
+EXPORT_SYMBOL_GPL(a4l_mite_done);
 #ifdef CONFIG_DEBUG_MITE
-EXPORT_SYMBOL_GPL(mite_decode);
-EXPORT_SYMBOL_GPL(mite_dump_regs);
+EXPORT_SYMBOL_GPL(a4l_mite_decode);
+EXPORT_SYMBOL_GPL(a4l_mite_dump_regs);
 #endif /* CONFIG_DEBUG_MITE */

--- xenomai-2.5.6/ksrc/drivers/analogy/national_instruments/pcimio.c.orig
+++ xenomai-2.5.6/ksrc/drivers/analogy/national_instruments/pcimio.c
@@ -198,7 +198,7 @@
 		n_aochan:       2,
 		aobits:         12,
 		ao_fifo_depth:  0,
-		.ao_range_table = &range_bipolar10,
+		.ao_range_table = &a4l_range_bipolar10,
 		ao_unipolar:    0,
 		ao_speed:	50000,
 		.num_p0_dio_channels = 8,
@@ -216,7 +216,7 @@
 		n_aochan:       2,
 		aobits:         16,
 		ao_fifo_depth:  2048,
-		.ao_range_table = &range_ni_E_ao_ext,
+		.ao_range_table = &a4l_range_ni_E_ao_ext,
 		ao_unipolar:    1,
 		ao_speed:	10000,
 		.num_p0_dio_channels = 8,
@@ -234,7 +234,7 @@
 		n_aochan:       2,
 		aobits:         16,
 		ao_fifo_depth:  0,
-		.ao_range_table = &range_bipolar10,
+		.ao_range_table = &a4l_range_bipolar10,
 		ao_unipolar:    0,
 		ao_speed:	100000,
 		.num_p0_dio_channels = 8,
@@ -252,7 +252,7 @@
 		n_aochan:       2,
 		aobits:         16,
 		ao_fifo_depth:  2048,
-		.ao_range_table = &range_ni_E_ao_ext,
+		.ao_range_table = &a4l_range_ni_E_ao_ext,
 		ao_unipolar:    1,
 		ao_speed:	10000,
 		.num_p0_dio_channels = 8,
@@ -271,7 +271,7 @@
 		n_aochan:       2,
 		aobits:         12,
 		ao_fifo_depth:  2048,
-		.ao_range_table = &range_ni_E_ao_ext,
+		.ao_range_table = &a4l_range_ni_E_ao_ext,
 		ao_unipolar:    1,
 		ao_speed:	1000,
 		.num_p0_dio_channels = 8,
@@ -291,7 +291,7 @@
 		n_aochan:       2,
 		aobits:         12,
 		ao_fifo_depth:  512,
-		.ao_range_table = &range_ni_E_ao_ext,
+		.ao_range_table = &a4l_range_ni_E_ao_ext,
 		ao_unipolar:    1,
 		ao_speed:	1000,
 		.num_p0_dio_channels = 8,
@@ -309,7 +309,7 @@
 		n_aochan:       2,
 		aobits:         12,
 		ao_fifo_depth:  512,
-		.ao_range_table = &range_ni_E_ao_ext,
+		.ao_range_table = &a4l_range_ni_E_ao_ext,
 		ao_unipolar:    1,
 		ao_speed:	1000,
 		.num_p0_dio_channels = 8,
@@ -328,7 +328,7 @@
 		n_aochan:       2,
 		aobits:         16,
 		ao_fifo_depth:  2048,
-		.ao_range_table = &range_ni_E_ao_ext,
+		.ao_range_table = &a4l_range_ni_E_ao_ext,
 		ao_unipolar:    1,
 		ao_speed:	10000,
 		.num_p0_dio_channels = 8,
@@ -378,7 +378,7 @@
 		n_aochan:       2,
 		aobits:         12,
 		ao_fifo_depth:  2048,
-		.ao_range_table = &range_ni_E_ao_ext,
+		.ao_range_table = &a4l_range_ni_E_ao_ext,
 		ao_unipolar:    1,
 		ao_speed:	1000,
 		.num_p0_dio_channels = 8,
@@ -411,7 +411,7 @@
 		n_aochan:       2,
 		aobits:         12,
 		ao_fifo_depth:  0,
-		.ao_range_table = &range_bipolar10,
+		.ao_range_table = &a4l_range_bipolar10,
 		ao_unipolar:    0,
 		ao_speed:	100000,
 		.num_p0_dio_channels = 8,
@@ -429,7 +429,7 @@
 		n_aochan:       2,
 		aobits:         12,
 		ao_fifo_depth:  0,
-		.ao_range_table = &range_bipolar10,
+		.ao_range_table = &a4l_range_bipolar10,
 		ao_unipolar:    0,
 		ao_speed:	100000,
 		.num_p0_dio_channels = 8,
@@ -447,7 +447,7 @@
 		n_aochan:       2,
 		aobits:         12,
 		ao_fifo_depth:  0,
-		.ao_range_table = &range_ni_E_ao_ext,
+		.ao_range_table = &a4l_range_ni_E_ao_ext,
 		ao_unipolar:    1,
 		ao_speed:	100000,
 		.num_p0_dio_channels = 8,
@@ -482,7 +482,7 @@
 		n_aochan:       2,
 		aobits:         12,
 		ao_fifo_depth:  0,
-		.ao_range_table = &range_bipolar10,
+		.ao_range_table = &a4l_range_bipolar10,
 		ao_unipolar:    0,
 		ao_speed:	100000,
 		.num_p0_dio_channels = 8,
@@ -501,7 +501,7 @@
 		aobits:         16,
 		ao_unipolar:    1,
 		ao_fifo_depth:  2048,
-		.ao_range_table = &range_ni_E_ao_ext,
+		.ao_range_table = &a4l_range_ni_E_ao_ext,
 		ao_speed:	3000,
 		.num_p0_dio_channels = 8,
 		caldac:         {ad8804_debug,ad8804_debug,ad8522}, /* manual is wrong */
@@ -517,7 +517,7 @@
 		n_aochan:       2,
 		aobits:         16,
 		reg_type:	ni_reg_611x,
-		.ao_range_table = &range_bipolar10,
+		.ao_range_table = &a4l_range_bipolar10,
 		ao_unipolar:    0,
 		ao_fifo_depth:  2048,
 		ao_speed:	250,
@@ -535,7 +535,7 @@
 		n_aochan:       2,
 		aobits:         16,
 		reg_type:	ni_reg_611x,
-		.ao_range_table = &range_bipolar10,
+		.ao_range_table = &a4l_range_bipolar10,
 		ao_unipolar:    0,
 		ao_fifo_depth:  2048,
 		ao_speed:	250,
@@ -590,7 +590,7 @@
 		aobits:         12,
 		ao_unipolar:    0,
 		ao_fifo_depth:  16384, /* data sheet says 8192, but fifo really holds 16384 samples */
-		.ao_range_table = &range_bipolar10,
+		.ao_range_table = &a4l_range_bipolar10,
 		ao_speed:	1000,
 		.num_p0_dio_channels = 8,
 		reg_type:	ni_reg_6711,
@@ -603,7 +603,7 @@
 		aobits:         12,
 		ao_unipolar:    0,
 		ao_fifo_depth:  16384,
-		.ao_range_table = &range_bipolar10,
+		.ao_range_table = &a4l_range_bipolar10,
 		ao_speed:	1000,
 		.num_p0_dio_channels = 8,
 		reg_type:	ni_reg_6711,
@@ -616,7 +616,7 @@
 		aobits:         12,
 		ao_unipolar:    0,
 		ao_fifo_depth:  16384,
-		.ao_range_table = &range_bipolar10,
+		.ao_range_table = &a4l_range_bipolar10,
 		ao_speed:	1000,
 		.num_p0_dio_channels = 8,
 		reg_type:	ni_reg_6713,
@@ -629,7 +629,7 @@
 		aobits:         12,
 		ao_unipolar:    0,
 		ao_fifo_depth:  16384,
-		.ao_range_table = &range_bipolar10,
+		.ao_range_table = &a4l_range_bipolar10,
 		ao_speed:	1000,
 		.num_p0_dio_channels = 8,
 		reg_type:	ni_reg_6713,
@@ -642,7 +642,7 @@
 		aobits:         16,
 		ao_unipolar:    0,
 		ao_fifo_depth:  8192,
-		.ao_range_table = &range_bipolar10,
+		.ao_range_table = &a4l_range_bipolar10,
 		ao_speed:	1000,
 		.num_p0_dio_channels = 8,
 		reg_type:	ni_reg_6711,
@@ -656,7 +656,7 @@
 		aobits:         16,
 		ao_unipolar:    0,
 		ao_fifo_depth:  8192,
-		.ao_range_table = &range_bipolar10,
+		.ao_range_table = &a4l_range_bipolar10,
 		.num_p0_dio_channels = 8,
 		reg_type:	ni_reg_6711,
 		caldac:         {ad8804_debug},
@@ -669,7 +669,7 @@
 		aobits:         16,
 		ao_unipolar:    0,
 		ao_fifo_depth:  16384,
-		.ao_range_table = &range_bipolar10,
+		.ao_range_table = &a4l_range_bipolar10,
 		ao_speed:	1000,
 		.num_p0_dio_channels = 8,
 		reg_type:	ni_reg_6713,
@@ -682,7 +682,7 @@
 		aobits:         16,
 		ao_unipolar:    0,
 		ao_fifo_depth:  16384,
-		.ao_range_table = &range_bipolar10,
+		.ao_range_table = &a4l_range_bipolar10,
 		ao_speed:	1000,
 		.num_p0_dio_channels = 8,
 		reg_type:	ni_reg_6713,
@@ -699,7 +699,7 @@
 		n_aochan:       2,
 		aobits:         12,
 		ao_fifo_depth:  2048,
-		.ao_range_table = &range_ni_E_ao_ext,
+		.ao_range_table = &a4l_range_ni_E_ao_ext,
 		ao_unipolar:    1,
 		ao_speed:	1000,
 		.num_p0_dio_channels = 8,
@@ -717,7 +717,7 @@
 		n_aochan:       2,
 		aobits:         12,
 		ao_fifo_depth:  2048,
-		.ao_range_table = &range_ni_E_ao_ext,
+		.ao_range_table = &a4l_range_ni_E_ao_ext,
 		ao_unipolar:    1,
 		ao_speed:	1000,
 		.num_p0_dio_channels = 8,
@@ -736,7 +736,7 @@
 		aobits:         16,
 		ao_unipolar:    1,
 		ao_fifo_depth:  2048,
-		.ao_range_table = &range_ni_E_ao_ext,
+		.ao_range_table = &a4l_range_ni_E_ao_ext,
 		ao_speed:	3000,
 		.num_p0_dio_channels = 8,
 		caldac:         {mb88341,mb88341,ad8522},
@@ -752,7 +752,7 @@
 		n_aochan:       2,
 		aobits:         16,
 		ao_fifo_depth:  2048,
-		.ao_range_table = &range_ni_E_ao_ext,
+		.ao_range_table = &a4l_range_ni_E_ao_ext,
 		ao_unipolar:    1,
 		ao_speed:	10000,
 		.num_p0_dio_channels = 8,
@@ -769,7 +769,7 @@
 		n_aochan:       2,
 		aobits:         16,
 		ao_fifo_depth:  0,
-		.ao_range_table = &range_bipolar10,
+		.ao_range_table = &a4l_range_bipolar10,
 		ao_unipolar:    0,
 		ao_speed:	100000,
 		.num_p0_dio_channels = 8,
@@ -1482,7 +1482,7 @@
 	}
 
 	for(i = 0; i < n_pcimio_boards && mite == NULL; i++) {
-		mite = mite_find_device(bus, slot, ni_boards[i].device_id);
+		mite = a4l_mite_find_device(bus, slot, ni_boards[i].device_id);
 		board = &ni_boards[i];
 	}
 
@@ -1524,7 +1524,7 @@
 		devpriv->stc_readl = &win_in2;
 	}
 
-	ret = mite_setup(devpriv->mite, 0);
+	ret = a4l_mite_setup(devpriv->mite, 0);
 	if(ret < 0)
 	{
 		a4l_err(dev, "pcmio_attach: error setting up mite\n");
@@ -1544,12 +1544,12 @@
 		a4l_info(dev, "pcimio_attach: found irq %u\n", irq);
 		ret = a4l_request_irq(dev,
 					 irq,
-					 ni_E_interrupt, A4L_IRQ_SHARED, dev);
+					 a4l_ni_E_interrupt, A4L_IRQ_SHARED, dev);
 		if(ret < 0)
 			a4l_err(dev, "pcimio_attach: irq not available\n");
 	}
 
-	ret = ni_E_init(dev);
+	ret = a4l_ni_E_init(dev);
 	if(ret < 0)
 		return ret;
 
@@ -1568,7 +1568,7 @@
 		mite_free_ring(devpriv->ao_mite_ring);
 		mite_free_ring(devpriv->gpct_mite_ring[0]);
 		mite_free_ring(devpriv->gpct_mite_ring[1]);
-		mite_unsetup(devpriv->mite);
+		a4l_mite_unsetup(devpriv->mite);
 	}
 
 	return 0;

--- xenomai-2.5.6/ksrc/drivers/analogy/national_instruments/mite.h.orig
+++ xenomai-2.5.6/ksrc/drivers/analogy/national_instruments/mite.h
@@ -115,40 +115,40 @@
 	return mite->pcidev->device;
 };
 
-int mite_setup(struct mite_struct *mite, int use_iodwbsr_1);
-void mite_unsetup(struct mite_struct *mite);
-void mite_list_devices(void);
-struct mite_struct * mite_find_device(int bus,
+int a4l_mite_setup(struct mite_struct *mite, int use_iodwbsr_1);
+void a4l_mite_unsetup(struct mite_struct *mite);
+void a4l_mite_list_devices(void);
+struct mite_struct * a4l_mite_find_device(int bus,
 				      int slot, unsigned short device_id);
-struct mite_channel *mite_request_channel_in_range(struct mite_struct *mite,
+struct mite_channel *a4l_mite_request_channel_in_range(struct mite_struct *mite,
 	struct mite_dma_descriptor_ring *ring, unsigned min_channel,
 	unsigned max_channel);
 static inline struct mite_channel *mite_request_channel(struct mite_struct
 	*mite, struct mite_dma_descriptor_ring *ring)
 {
-	return mite_request_channel_in_range(mite, ring, 0,
+	return a4l_mite_request_channel_in_range(mite, ring, 0,
 		mite->num_channels - 1);
 }
-void mite_release_channel(struct mite_channel *mite_chan);
+void a4l_mite_release_channel(struct mite_channel *mite_chan);
 
-void mite_dma_arm(struct mite_channel *mite_chan);
-void mite_dma_disarm(struct mite_channel *mite_chan);
-int mite_sync_input_dma(struct mite_channel *mite_chan, a4l_subd_t *subd);
-int mite_sync_output_dma(struct mite_channel *mite_chan, a4l_subd_t *subd);
-u32 mite_bytes_written_to_memory_lb(struct mite_channel *mite_chan);
-u32 mite_bytes_written_to_memory_ub(struct mite_channel *mite_chan);
-u32 mite_bytes_read_from_memory_lb(struct mite_channel *mite_chan);
-u32 mite_bytes_read_from_memory_ub(struct mite_channel *mite_chan);
-u32 mite_bytes_in_transit(struct mite_channel *mite_chan);
-u32 mite_get_status(struct mite_channel *mite_chan);
-int mite_done(struct mite_channel *mite_chan);
-void mite_prep_dma(struct mite_channel *mite_chan,
+void a4l_mite_dma_arm(struct mite_channel *mite_chan);
+void a4l_mite_dma_disarm(struct mite_channel *mite_chan);
+int a4l_mite_sync_input_dma(struct mite_channel *mite_chan, a4l_subd_t *subd);
+int a4l_mite_sync_output_dma(struct mite_channel *mite_chan, a4l_subd_t *subd);
+u32 a4l_mite_bytes_written_to_memory_lb(struct mite_channel *mite_chan);
+u32 a4l_mite_bytes_written_to_memory_ub(struct mite_channel *mite_chan);
+u32 a4l_mite_bytes_read_from_memory_lb(struct mite_channel *mite_chan);
+u32 a4l_mite_bytes_read_from_memory_ub(struct mite_channel *mite_chan);
+u32 a4l_mite_bytes_in_transit(struct mite_channel *mite_chan);
+u32 a4l_mite_get_status(struct mite_channel *mite_chan);
+int a4l_mite_done(struct mite_channel *mite_chan);
+void a4l_mite_prep_dma(struct mite_channel *mite_chan,
 		   unsigned int num_device_bits, unsigned int num_memory_bits);
-int mite_buf_change(struct mite_dma_descriptor_ring *ring, a4l_subd_t *subd);
+int a4l_mite_buf_change(struct mite_dma_descriptor_ring *ring, a4l_subd_t *subd);
 
 #ifdef CONFIG_DEBUG_MITE
 void mite_print_chsr(unsigned int chsr);
-void mite_dump_regs(struct mite_channel *mite_chan);
+void a4l_mite_dump_regs(struct mite_channel *mite_chan);
 #endif
 
 static inline int CHAN_OFFSET(int channel)

--- xenomai-2.5.6/include/analogy/channel_range.h.orig
+++ xenomai-2.5.6/include/analogy/channel_range.h
@@ -299,14 +299,14 @@
 	.length =  1,				\
 	.rngtabs = {&(x)}, }
 
-extern a4l_rngdesc_t range_bipolar10;
-extern a4l_rngdesc_t range_bipolar5;
-extern a4l_rngdesc_t range_unipolar10;
-extern a4l_rngdesc_t range_unipolar5;
-extern a4l_rngdesc_t range_unknown;
-extern a4l_rngdesc_t range_fake;
+extern a4l_rngdesc_t a4l_range_bipolar10;
+extern a4l_rngdesc_t a4l_range_bipolar5;
+extern a4l_rngdesc_t a4l_range_unipolar10;
+extern a4l_rngdesc_t a4l_range_unipolar5;
+extern a4l_rngdesc_t a4l_range_unknown;
+extern a4l_rngdesc_t a4l_range_fake;
 
-#define range_digital range_unipolar5
+#define range_digital a4l_range_unipolar5
 
 	  /*! @} channelrange */
 


--------------030707020101040005000604
Content-Type: text/plain; x-mac-type="0"; x-mac-creator="0";
 name="mite.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="mite.patch"

--- xenomai-2.5.6/ksrc/drivers/analogy/national_instruments/mite.c.orig	2011-03-18 15:56:07.067306544 +0100
+++ xenomai-2.5.6/ksrc/drivers/analogy/national_instruments/mite.c	2011-03-18 15:56:35.712580882 +0100
@@ -101,7 +101,7 @@
 }
 
 static struct pci_driver mite_driver = {
-	.name = "mite",
+	.name = "analogy_mite",
 	.id_table = mite_id,
 	.probe = mite_probe,
 	.remove = mite_remove,

--------------030707020101040005000604--

