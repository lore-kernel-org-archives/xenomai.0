References: <40BB3CA5-0698-44C5-9975-43179C812260@voidptr.dev>
From: Philippe Gerum <rpm@xenomai.org>
Subject: Re: Async DMA operations with Xenomai 3.1
In-reply-to: <40BB3CA5-0698-44C5-9975-43179C812260@voidptr.dev>
Date: Thu, 08 Jul 2021 09:55:59 +0200
Message-ID: <87bl7di6i8.fsf@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Sylvan Williams <sylvan@voidptr.dev>
Cc: xenomai@xenomai.org


Sylvan Williams via Xenomai <xenomai@xenomai.org> writes:

> Hi everyone,
>
> I have some questions about which approach I should take to allow OOB exe=
cution of DMA completion handlers when running kernel 4.14.110 + IPipe + Xe=
nomai 3.1.
>
> The system is a Zynq (dual ARM Cortex A-9), and I have a UDD driver which=
 registers a hardware GPIO interrupt that=E2=80=99s incoming from the FPGA.=
 The UDD driver also performs mmap=E2=80=99ing of some memory regions that =
are mapped to DMA, and those regions are submitted to the dmaengine for tra=
nsfer into FPGA block RAM inside the interrupt handler of the UDD driver. T=
he DMA controller also has an interrupt which is tied into the GIC to signa=
l the completion of an operation
>
> This works, for a while, but eventually I end up with a system hang that =
I=E2=80=99m (guessing) is due to deadlock between the head and root stages =
for calling the completion handler inside the xilinx-dma driver.
>
> I stumbled upon the EVL project and Dovetail just last week, and it appea=
rs Dovetail addresses this issue with the introduction of the IRQF_OOB flag=
. I=E2=80=99m in the process of attempting to add the same functionality to=
 IPipe, but now I=E2=80=99m looking for advice for the best approach since =
I feel like I=E2=80=99m about to get myself into a pretty intense code tang=
le.
>
> So my question is:
> Should I continue with this approach? or
> Scrap it, and create an RTDM version of the xilinx DMA driver?

You could reasonably do this only if the DMA chip was reserved for oob
operations. If you need to share the DMA controller with other DMA
business triggered by the common kernel code, this would be a problem.

> Is there an easier approach I haven=E2=80=99t thought of?
>
> For more context, below is a snippet of the DMA transaction which is call=
ed from the udd_device.handler. Again, I believe the problem lies in the fa=
ct dmaengine_submit() and dma_async_issue_pending are called from OOB conte=
xt, while the completion handler inside the xilinx DMA driver needs to run =
on receipt of the hardware interrupt from the DMA controller.
>
> Also, this is a closed system, so the solution doesn=E2=80=99t necessaril=
y have/need to fit into the kernel in an upstreamable fashion, if that make=
s sense.
>
> There=E2=80=99s also the possibility that I=E2=80=99m completely incorrec=
t in my theory, so no harm in pointing that out if it=E2=80=99s the case.
>
> Any advice will be much appreciated!
>
> Thanks,
>
> Sylvan
>
>
> static int dma_tx(fermi_tx_buf_t buf)
> {
>     int err;
>     struct dma_async_tx_descriptor* txd;
>     dma_addr_t dma_handle_src;
>     dma_addr_t dma_handle_dest;
>     size_t transaction_len;
>     int active_bank;
>
>     /* The MSB of the BRAM address bus is connected to the EMIO interface=
 of the processor.
>        Reading the value will indicate which half of the BRAM buffer is c=
urrently being written
>        to the CV DAC array. Transfers need to occur into the _inactive_ b=
uffer. Read the value
>        add set the destination address accordingly
>     */
>     active_bank =3D gpio_get_value(zynq_emio_active_bank);
>
>     /* MSB high - transfer to low buffer */
>     if (active_bank =3D=3D true)
>     {
>         dma_handle_dest =3D (dma_addr_t)soundengine_params_dest_addr;
>     }
>     /* MSB low - transfer to high buffer */
>     else
>     {
>         dma_handle_dest =3D (dma_addr_t)(soundengine_params_dest_addr + s=
oundengine_buf_len);
>     }
>
>     /* Set DDR RAM source address and transaction length depending on the=
 value passed through the ioctl */
>     if (buf =3D=3D BUF_A)
>     {
>         transaction_len =3D fermi_platform_dev->tx.transaction_len;
>         dma_handle_src =3D dma_map_single(fermi_platform_dev->tx.chan->de=
vice->dev, fermi_platform_dev->tx.dma_buf_src, transaction_len, DMA_TO_DEVI=
CE);
>     }
>     else if (buf =3D=3D BUF_B)
>     {
>         transaction_len =3D fermi_platform_dev->tx.transaction_len;
>         dma_handle_src =3D dma_map_single(fermi_platform_dev->tx.chan->de=
vice->dev,
>                                                          (void*)((uint8_t=
*)fermi_platform_dev->tx.dma_buf_src + soundengine_buf_len), transaction_le=
n, DMA_TO_DEVICE);
>     }
>     else
>     {
>         dev_err(&fermi_platform_dev->pdev->dev, "Cyclic TX DMA - unknown =
argument!\n");
>         goto fail;
>     }
>
>     fermi_platform_dev->tx.transaction_addr =3D dma_handle_src;
>     fermi_platform_dev->tx.transaction_len =3D transaction_len;
>     reinit_completion(&fermi_platform_dev->tx.cmd_complete);
>
>     txd =3D dmaengine_prep_dma_memcpy(fermi_platform_dev->tx.chan, dma_ha=
ndle_dest, dma_handle_src, transaction_len, DMA_PREP_INTERRUPT | DMA_CTRL_A=
CK);
>
>     if (!txd)
>     {
>         dev_err(&fermi_platform_dev->pdev->dev, "Unable to prepare cyclic=
 TX DMA transaction!\n");
>         //dmaengine_terminate_all(fermi_platform_dev->tx.chan);
>         err =3D -ENOMEM;
>         goto fail;
>     }
>
>     txd->callback =3D tx_dma_callback;
>     txd->callback_param =3D &fermi_platform_dev->tx;
>
>     dmaengine_submit(txd);
>     dma_async_issue_pending(fermi_platform_dev->tx.chan);
>
>     return 0;
>
> fail:
>     return err;
> }

Your analysis is correct, you need the IRQ handler to run oob, but then
there is a problem in kicking the new xfer from that context using the
generic DMA engine API.

I'm pasting some code below (based on kernel 4.14), which illustrates
the way you could do this. The example code is composed of two parts:
one which introduces the "pulsable DMA transfer" API in the dmaengine
layer, another one which enables this feature in the SDMA driver (NXP
i.MX series). The code should be adapted to fit the Xilinx DMA driver.

The basic idea in this patch is to receive all DMA IRQs from the
oob/head stage, fire an optional oob callback immediately if mentioned
for the channel (that would be your UDD handler), acknowledging the
event appropriately. Events on regular channels without oob handling are
relayed to a virtual IRQ handler for execution on the in-band/root
stage, in order to perform the usual business there instead (i.e. the
regular IRQ handler stripped from the acknowledge code which already
took place in the oob handler).

Dovetail already implements this logic [1] as you already noticed, which
is leveraged by the EVL core to run high-frequency, low-jitter closed
loops over SPI for instance [2]. The pasted code was an early prototype
of this scheme for i.MX6 based on the I-pipe. It evolved into a more
generic implementation in Dovetail developed with EVL in mind,
particularly in making the virtual DMA channel interface oob-capable
(many DMA backend drivers are based on it these days).

HTH,

[1] https://evlproject.org/core/oob-drivers/dma/
[2] https://evlproject.org/core/oob-drivers/spi/

--

diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index a67ec1bdc4e0..ab5ef38267e4 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -329,10 +329,15 @@ struct sdma_channel {
 	unsigned int			chn_count;
 	unsigned int			chn_real_count;
 	struct tasklet_struct		tasklet;
+#ifdef CONFIG_IPIPE=09
+	void (*oob_callback)(void *arg);
+	void				*oob_arg;
+#endif
 	struct imx_dma_data		data;
 };
=20
 #define IMX_DMA_SG_LOOP		BIT(0)
+#define IMX_DMA_OOB		BIT(1)
=20
 #define MAX_DMA_CHANNELS 32
 #define MXC_SDMA_DEFAULT_PRIORITY 1
@@ -389,6 +394,9 @@ struct sdma_engine {
 	u32				spba_start_addr;
 	u32				spba_end_addr;
 	unsigned int			irq;
+#ifdef CONFIG_IPIPE
+	u32				pending_stat;
+#endif
 };
=20
 static struct sdma_driver_data sdma_imx31 =3D {
@@ -748,16 +756,8 @@ static void mxc_sdma_handle_channel_normal(unsigned lo=
ng data)
 	dmaengine_desc_get_callback_invoke(&sdmac->desc, NULL);
 }
=20
-static irqreturn_t sdma_int_handler(int irq, void *dev_id)
+static void handle_sdma_int(struct sdma_engine *sdma, unsigned long stat)
 {
-	struct sdma_engine *sdma =3D dev_id;
-	unsigned long stat;
-
-	stat =3D readl_relaxed(sdma->regs + SDMA_H_INTR);
-	writel_relaxed(stat, sdma->regs + SDMA_H_INTR);
-	/* channel 0 is special and not handled here, see run_channel0() */
-	stat &=3D ~1;
-
 	while (stat) {
 		int channel =3D fls(stat) - 1;
 		struct sdma_channel *sdmac =3D &sdma->channel[channel];
@@ -769,10 +769,72 @@ static irqreturn_t sdma_int_handler(int irq, void *de=
v_id)
=20
 		__clear_bit(channel, &stat);
 	}
+}
+
+#ifdef CONFIG_IPIPE
+
+static void sdma_int_oob_handler(unsigned int irq, void *cookie)
+{
+	struct sdma_engine *sdma =3D cookie;
+	unsigned long stat, oob =3D 0;
+	struct sdma_channel *sdmac;
+	int channel;
+
+	stat =3D readl_relaxed(sdma->regs + SDMA_H_INTR);
+	writel_relaxed(stat, sdma->regs + SDMA_H_INTR);
+	/* channel 0 is special and not handled here, see run_channel0() */
+	sdma->pending_stat =3D stat & ~1;
+
+	ipipe_end_irq(irq);
+
+	stat =3D sdma->pending_stat;
+	while (stat) {
+		channel =3D fls(stat) - 1;
+		sdmac =3D &sdma->channel[channel];
+		if (sdmac->flags & IMX_DMA_OOB) {
+			if (sdmac->oob_callback)
+				sdmac->oob_callback(sdmac->oob_arg);
+			oob |=3D BIT(channel);
+		}
+		stat &=3D ~BIT(channel);
+	}
+
+	sdma->pending_stat &=3D ~oob;
+=09
+	if (sdma->pending_stat)
+		/* We have work to pass down to inband context. */
+		ipipe_post_irq_root(irq);
+}
+
+static irqreturn_t sdma_int_inband_handler(int irq, void *dev_id)
+{
+	struct sdma_engine *sdma =3D dev_id;
+	unsigned long stat =3D sdma->pending_stat;
+
+	handle_sdma_int(sdma, stat);
=20
 	return IRQ_HANDLED;
 }
=20
+#else
+
+static irqreturn_t sdma_int_handler(int irq, void *dev_id)
+{
+	struct sdma_engine *sdma =3D dev_id;
+	unsigned long stat;
+
+	stat =3D readl_relaxed(sdma->regs + SDMA_H_INTR);
+	writel_relaxed(stat, sdma->regs + SDMA_H_INTR);
+	/* channel 0 is special and not handled here, see run_channel0() */
+	stat &=3D ~1;
+
+	handle_sdma_int(sdma, stat);
+
+	return IRQ_HANDLED;
+}
+
+#endif
+
 /*
  * sets the pc of SDMA script according to the peripheral type
  */
@@ -1310,7 +1372,7 @@ static struct dma_async_tx_descriptor *sdma_prep_dma_=
cyclic(
 	sdmac->chn_real_count =3D 0;
 	sdmac->period_len =3D period_len;
=20
-	sdmac->flags |=3D IMX_DMA_SG_LOOP;
+	sdmac->flags =3D IMX_DMA_SG_LOOP;
 	sdmac->direction =3D direction;
 	ret =3D sdma_load_context(sdmac);
 	if (ret)
@@ -1369,6 +1431,90 @@ static struct dma_async_tx_descriptor *sdma_prep_dma=
_cyclic(
 	return NULL;
 }
=20
+#ifdef CONFIG_IPIPE
+
+static int sdma_prep_slave_oob(
+		struct dma_chan *chan, dma_addr_t dma_addr, size_t buf_len,
+		struct dma_slave_config *dmaconfig,
+		void (*callback)(void *arg), void *arg)
+{
+	struct sdma_channel *sdmac =3D to_sdma_chan(chan);
+	struct sdma_engine *sdma =3D sdmac->sdma;
+	struct sdma_buffer_descriptor *bd;
+	int channel =3D sdmac->channel, ret;
+
+	dev_dbg(sdma->dev, "%s channel: %d\n", __func__, channel);
+
+	if (sdmac->status =3D=3D DMA_IN_PROGRESS)
+		return -EBUSY;
+
+	if (sdmac->word_size > DMA_SLAVE_BUSWIDTH_4_BYTES)
+		return -EINVAL;
+
+	ret =3D dmaengine_slave_config(chan, dmaconfig);
+	if (ret)
+		return ret;
+
+	sdmac->status =3D DMA_IN_PROGRESS;
+	sdmac->buf_tail =3D 0;
+	sdmac->buf_ptail =3D 0;
+	sdmac->chn_real_count =3D 0;
+	sdmac->period_len =3D buf_len;
+	sdmac->flags =3D IMX_DMA_OOB;
+	sdmac->direction =3D dmaconfig->direction;
+	sdmac->oob_callback =3D callback;
+	sdmac->oob_arg =3D arg;
+
+	ret =3D sdma_load_context(sdmac);
+	if (ret) {
+		sdmac->status =3D DMA_ERROR;
+		return ret;
+	}
+
+	bd =3D &sdmac->bd[0];
+	bd->buffer_addr =3D dma_addr;
+	bd->mode.count =3D buf_len;
+
+	if (sdmac->word_size =3D=3D DMA_SLAVE_BUSWIDTH_4_BYTES)
+		bd->mode.command =3D 0;
+	else
+		bd->mode.command =3D sdmac->word_size;
+
+	bd->mode.status =3D BD_DONE | BD_EXTD | BD_INTR | BD_WRAP;
+	sdmac->num_bd =3D 1;
+	sdma->channel_control[channel].current_bd_ptr =3D sdmac->bd_phys;
+
+	dev_dbg(sdma->dev, "pulse count: %d dma: %pad wrap intr\n",
+		buf_len, &dma_addr);
+
+	return 0;
+}
+
+static void sdma_issue_pending(struct dma_chan *chan);
+
+static void __sdma_chan_pulse(struct dma_chan *chan)
+{
+	struct sdma_channel *sdmac =3D to_sdma_chan(chan);
+	struct sdma_buffer_descriptor *bd;
+	int n;
+
+	for (n =3D 0; n < sdmac->num_bd; n++) {
+		bd =3D &sdmac->bd[n];
+		bd->mode.status |=3D BD_DONE;
+	}
+
+	sdma_issue_pending(chan);
+}
+
+static void sdma_chan_pulse(struct dma_chan *txchan, struct dma_chan *rxch=
an)
+{
+	if (rxchan)
+		__sdma_chan_pulse(rxchan);
+	__sdma_chan_pulse(txchan);
+}
+
+#endif
+
 static int sdma_config(struct dma_chan *chan,
 		       struct dma_slave_config *dmaengine_cfg)
 {
@@ -1698,6 +1844,53 @@ static struct dma_chan *sdma_xlate(struct of_phandle=
_args *dma_spec,
 	return dma_request_channel(mask, sdma_filter_fn, &data);
 }
=20
+#ifdef CONFIG_IPIPE
+
+static int request_sdma_irq(struct platform_device *pdev, int irq,
+			    struct sdma_engine *sdma)
+{
+	int ret;
+
+	ret =3D devm_request_irq(&pdev->dev, irq, sdma_int_inband_handler,
+				0, "sdma", sdma);
+	if (ret)
+		return ret;
+
+	if (ipipe_head_domain !=3D ipipe_root_domain) {
+		ret =3D ipipe_request_irq(ipipe_head_domain, irq,
+					sdma_int_oob_handler, sdma, NULL);
+		if (ret)
+			return ret;
+	}
+
+	return irq;
+}
+
+static void free_sdma_irq(struct platform_device *pdev,
+			  struct sdma_engine *sdma)
+{
+	if (ipipe_head_domain !=3D ipipe_root_domain)
+		ipipe_free_irq(ipipe_head_domain, sdma->irq);
+	devm_free_irq(&pdev->dev, sdma->irq, sdma);
+}
+
+#else
+
+static int request_sdma_irq(struct platform_device *pdev, int irq,
+			    struct sdma_engine *sdma)
+{
+	return devm_request_irq(&pdev->dev, irq, sdma_int_handler,
+				0, "sdma", sdma);
+}
+
+static void free_sdma_irq(struct platform_device *pdev,
+			  struct sdma_engine *sdma)
+{
+	devm_free_irq(&pdev->dev, sdma->irq, sdma);
+}
+
+#endif
+
 static int sdma_probe(struct platform_device *pdev)
 {
 	const struct of_device_id *of_id =3D
@@ -1763,9 +1956,8 @@ static int sdma_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_clk;
=20
-	ret =3D devm_request_irq(&pdev->dev, irq, sdma_int_handler, 0, "sdma",
-			       sdma);
-	if (ret)
+	irq =3D request_sdma_irq(pdev, irq, sdma);
+	if (irq < 0)
 		goto err_irq;
=20
 	sdma->irq =3D irq;
@@ -1783,6 +1975,9 @@ static int sdma_probe(struct platform_device *pdev)
=20
 	dma_cap_set(DMA_SLAVE, sdma->dma_device.cap_mask);
 	dma_cap_set(DMA_CYCLIC, sdma->dma_device.cap_mask);
+#ifdef CONFIG_IPIPE
+	dma_cap_set(DMA_SLAVE_OOB, sdma->dma_device.cap_mask);
+#endif
=20
 	INIT_LIST_HEAD(&sdma->dma_device.channels);
 	/* Initialize channel parameters */
@@ -1849,6 +2044,10 @@ static int sdma_probe(struct platform_device *pdev)
 	sdma->dma_device.device_tx_status =3D sdma_tx_status;
 	sdma->dma_device.device_prep_slave_sg =3D sdma_prep_slave_sg;
 	sdma->dma_device.device_prep_dma_cyclic =3D sdma_prep_dma_cyclic;
+#ifdef CONFIG_IPIPE
+	sdma->dma_device.device_prep_dma_slave_oob =3D sdma_prep_slave_oob;
+	sdma->dma_device.device_pulse =3D sdma_chan_pulse;
+#endif
 	sdma->dma_device.device_config =3D sdma_config;
 	sdma->dma_device.device_terminate_all =3D sdma_disable_channel_with_delay;
 	sdma->dma_device.src_addr_widths =3D BIT(DMA_SLAVE_BUSWIDTH_4_BYTES);
@@ -1890,6 +2089,7 @@ static int sdma_probe(struct platform_device *pdev)
 err_init:
 	kfree(sdma->script_addrs);
 err_irq:
+	free_sdma_irq(pdev, sdma);
 	clk_unprepare(sdma->clk_ahb);
 err_clk:
 	clk_unprepare(sdma->clk_ipg);
@@ -1901,7 +2101,7 @@ static int sdma_remove(struct platform_device *pdev)
 	struct sdma_engine *sdma =3D platform_get_drvdata(pdev);
 	int i;
=20
-	devm_free_irq(&pdev->dev, sdma->irq, sdma);
+	free_sdma_irq(pdev, sdma);
 	dma_async_device_unregister(&sdma->dma_device);
 	kfree(sdma->script_addrs);
 	clk_unprepare(sdma->clk_ahb);
diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
index 8319101170fc..e8483caf93da 100644
--- a/include/linux/dmaengine.h
+++ b/include/linux/dmaengine.h
@@ -71,6 +71,7 @@ enum dma_transaction_type {
 	DMA_PRIVATE,
 	DMA_ASYNC_TX,
 	DMA_SLAVE,
+	DMA_SLAVE_OOB,
 	DMA_CYCLIC,
 	DMA_INTERLEAVE,
 /* last transaction type for creation of the capabilities mask */
@@ -789,6 +790,10 @@ struct dma_device {
 	struct dma_async_tx_descriptor *(*device_prep_dma_imm_data)(
 		struct dma_chan *chan, dma_addr_t dst, u64 data,
 		unsigned long flags);
+	int (*device_prep_dma_slave_oob)(
+		struct dma_chan *chan, dma_addr_t buf_addr, size_t buf_len,
+		struct dma_slave_config *dmaconfig,
+		void (*callback)(void *arg), void *arg);
=20
 	int (*device_config)(struct dma_chan *chan,
 			     struct dma_slave_config *config);
@@ -801,8 +806,16 @@ struct dma_device {
 					    dma_cookie_t cookie,
 					    struct dma_tx_state *txstate);
 	void (*device_issue_pending)(struct dma_chan *chan);
+	void (*device_pulse)(struct dma_chan *txchan, struct dma_chan *rxchan);
 };
=20
+static inline void dmaengine_device_pulse(struct dma_chan *txchan,
+					  struct dma_chan *rxchan)
+{
+	if (txchan->device->device_pulse)
+		txchan->device->device_pulse(txchan, rxchan);
+}
+
 static inline int dmaengine_slave_config(struct dma_chan *chan,
 					  struct dma_slave_config *config)
 {
@@ -871,6 +884,18 @@ static inline struct dma_async_tx_descriptor *dmaengin=
e_prep_dma_cyclic(
 						period_len, dir, flags);
 }
=20
+static inline int dmaengine_prep_dma_slave_oob(
+		struct dma_chan *chan, dma_addr_t buf_addr, size_t buf_len,
+		struct dma_slave_config *dmaconfig,
+		void (*callback)(void *arg), void *arg)
+{
+	if (!chan || !chan->device || !chan->device->device_prep_dma_slave_oob)
+		return -ENODEV;
+
+	return chan->device->device_prep_dma_slave_oob(chan, buf_addr, buf_len,
+				       dmaconfig, callback, arg);
+}
+
 static inline struct dma_async_tx_descriptor *dmaengine_prep_interleaved_d=
ma(
 		struct dma_chan *chan, struct dma_interleaved_template *xt,
 		unsigned long flags)

--=20
Philippe.

