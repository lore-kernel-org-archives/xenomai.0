Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCAF1823CA
	for <xenomai@lists.linux.dev>; Tue, 26 Mar 2024 06:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711434681; cv=none; b=JhYXmhmrepA/RPbd9PFvhwJQy/vtL6EB0cZuBuyav9egof8q5D7iTfAJPFT+kDAy+zehiw6pGMnvC3ySBD9VUQEAejQ7VcRPvcm21MueXJsaYfaSdGRQow2Iuzp5VJMX1f5ki0VNGLFQibceU5vvW8GLdWzqIortfP4RMahig1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711434681; c=relaxed/simple;
	bh=M9LNoyqc4y/4hQ4S4jvZjI+ADC1/5xCxK/cJ6EZNWNw=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lzmUVVuDqv4sj/M0VXY3V0TtxSHfgPrB8aKUExxoGsCOa1XidS2gqjamexDOuYd8Cy4k10pmtQiid6qm4L3Ci7Fg0cRAfW9n+lEDA6IunHb2q10iNr/220VY4CVitr+x9TCpEW2nWBVvDvrAUhxFyuYeKkqJ/qbnYmANLdnzhLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (1024-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b=qerUDPbR; arc=none smtp.client-ip=185.136.64.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b="qerUDPbR"
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 202403260631074a79408328074fd0c6
        for <xenomai@lists.linux.dev>;
        Tue, 26 Mar 2024 07:31:08 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=WHFLNl1TyFU0H9OOpOeufZnvrGdYEvNbx5Mshgd5Shg=;
 b=qerUDPbR8gUOmHb4uIzQfmeKrWs5gL4t3Y6B9Y5An+a6cdmzpXuoxvOQa6FOZY9TO6Z+GI
 Lolv8L5fYjCo7iivTvk5qzQdhj7hut70RrMDpkp1Q69IyDne2zFpYC2IhknCZiRubbGSek2h
 BdL+W2ZwTNNqovzeGzaBQwL8wPc6I=;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: xenomai@lists.linux.dev
Subject: [PATCH 09/25] drivers/analogy: Make private functions static
Date: Tue, 26 Mar 2024 07:30:48 +0100
Message-Id: <999494d9d9bf0e4ceb5fc2c002395c79e1ed244c.1711434664.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1711434664.git.jan.kiszka@siemens.com>
References: <cover.1711434664.git.jan.kiszka@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer

From: Jan Kiszka <jan.kiszka@siemens.com>

Addresses missing prototype warnings with kernel 6.8.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 kernel/drivers/analogy/buffer.c               |  4 +-
 kernel/drivers/analogy/command.c              | 10 ++-
 kernel/drivers/analogy/device.c               | 25 +++---
 kernel/drivers/analogy/instruction.c          | 25 +++---
 kernel/drivers/analogy/intel/8255.c           | 13 +--
 .../analogy/national_instruments/mio_common.c | 81 +++++++++++--------
 .../analogy/national_instruments/mite.c       |  2 +-
 kernel/drivers/analogy/rtdm_interface.c       | 20 ++---
 kernel/drivers/analogy/testing/fake.c         | 32 ++++----
 9 files changed, 120 insertions(+), 92 deletions(-)

diff --git a/kernel/drivers/analogy/buffer.c b/kernel/drivers/analogy/buffer.c
index df228943ff..3a58bb7dc2 100644
--- a/kernel/drivers/analogy/buffer.c
+++ b/kernel/drivers/analogy/buffer.c
@@ -462,13 +462,13 @@ unsigned long a4l_buf_count(struct a4l_subdevice *subd)
 
 /* --- Mmap functions --- */
 
-void a4l_map(struct vm_area_struct *area)
+static void a4l_map(struct vm_area_struct *area)
 {
 	unsigned long *status = (unsigned long *)area->vm_private_data;
 	set_bit(A4L_BUF_MAP_NR, status);
 }
 
-void a4l_unmap(struct vm_area_struct *area)
+static void a4l_unmap(struct vm_area_struct *area)
 {
 	unsigned long *status = (unsigned long *)area->vm_private_data;
 	clear_bit(A4L_BUF_MAP_NR, status);
diff --git a/kernel/drivers/analogy/command.c b/kernel/drivers/analogy/command.c
index 7420bc51ed..9b3c82bd6c 100644
--- a/kernel/drivers/analogy/command.c
+++ b/kernel/drivers/analogy/command.c
@@ -26,8 +26,9 @@
 #include <rtdm/analogy/device.h>
 
 /* --- Command descriptor management functions --- */
-int a4l_fill_cmddesc(struct a4l_device_context *cxt, struct a4l_cmd_desc *desc,
-		     unsigned int **chan_descs, void *arg)
+static int a4l_fill_cmddesc(struct a4l_device_context *cxt,
+			    struct a4l_cmd_desc *desc,
+			    unsigned int **chan_descs, void *arg)
 {
 	unsigned int *tmpchans = NULL;
 	int ret = 0;
@@ -124,7 +125,7 @@ int a4l_check_cmddesc(struct a4l_device_context * cxt, struct a4l_cmd_desc * des
 
 /* --- Command checking functions --- */
 
-int a4l_check_generic_cmdcnt(struct a4l_cmd_desc * desc)
+static int a4l_check_generic_cmdcnt(struct a4l_cmd_desc * desc)
 {
 	unsigned int tmp1, tmp2;
 
@@ -226,7 +227,8 @@ int a4l_check_generic_cmdcnt(struct a4l_cmd_desc * desc)
 	return 0;
 }
 
-int a4l_check_specific_cmdcnt(struct a4l_device_context * cxt, struct a4l_cmd_desc * desc)
+static int a4l_check_specific_cmdcnt(struct a4l_device_context * cxt,
+				     struct a4l_cmd_desc * desc)
 {
 	unsigned int tmp1, tmp2;
 	struct a4l_device *dev = a4l_get_dev(cxt);
diff --git a/kernel/drivers/analogy/device.c b/kernel/drivers/analogy/device.c
index 69492b96b6..18c7361a4f 100644
--- a/kernel/drivers/analogy/device.c
+++ b/kernel/drivers/analogy/device.c
@@ -101,7 +101,7 @@ static const DEFINE_PROC_OPS(a4l_proc_transfer_ops,
 			seq_read,
 			NULL);
 
-int a4l_proc_attach(struct a4l_device_context * cxt)
+static int a4l_proc_attach(struct a4l_device_context * cxt)
 {
 	int ret = 0;
 	struct a4l_device *dev = a4l_get_dev(cxt);
@@ -134,7 +134,7 @@ int a4l_proc_attach(struct a4l_device_context * cxt)
 	return ret;
 }
 
-void a4l_proc_detach(struct a4l_device_context * cxt)
+static void a4l_proc_detach(struct a4l_device_context * cxt)
 {
 	struct a4l_device *dev = a4l_get_dev(cxt);
 	char *entry_name;
@@ -156,12 +156,12 @@ void a4l_proc_detach(struct a4l_device_context * cxt)
 
 #else /* !CONFIG_PROC_FS */
 
-int a4l_proc_attach(struct a4l_device_context * cxt)
+static int a4l_proc_attach(struct a4l_device_context * cxt)
 {
 	return 0;
 }
 
-void a4l_proc_detach(struct a4l_device_context * cxt)
+static void a4l_proc_detach(struct a4l_device_context * cxt)
 {
 }
 
@@ -169,8 +169,8 @@ void a4l_proc_detach(struct a4l_device_context * cxt)
 
 /* --- Attach / detach section --- */
 
-int a4l_fill_lnkdesc(struct a4l_device_context * cxt,
-		     a4l_lnkdesc_t * link_arg, void *arg)
+static int a4l_fill_lnkdesc(struct a4l_device_context * cxt,
+			    a4l_lnkdesc_t * link_arg, void *arg)
 {
 	struct rtdm_fd *fd = rtdm_private_to_fd(cxt);
 	int ret;
@@ -249,7 +249,8 @@ int a4l_fill_lnkdesc(struct a4l_device_context * cxt,
 	return ret;
 }
 
-void a4l_free_lnkdesc(struct a4l_device_context * cxt, a4l_lnkdesc_t * link_arg)
+static void a4l_free_lnkdesc(struct a4l_device_context * cxt,
+			     a4l_lnkdesc_t * link_arg)
 {
 	if (link_arg->bname != NULL)
 		rtdm_free(link_arg->bname);
@@ -258,8 +259,8 @@ void a4l_free_lnkdesc(struct a4l_device_context * cxt, a4l_lnkdesc_t * link_arg)
 		rtdm_free(link_arg->opts);
 }
 
-int a4l_assign_driver(struct a4l_device_context * cxt,
-			 struct a4l_driver * drv, a4l_lnkdesc_t * link_arg)
+static int a4l_assign_driver(struct a4l_device_context * cxt,
+			     struct a4l_driver * drv, a4l_lnkdesc_t * link_arg)
 {
 	int ret = 0;
 	struct a4l_device *dev = a4l_get_dev(cxt);
@@ -307,7 +308,7 @@ out_assign_driver:
 	return ret;
 }
 
-int a4l_release_driver(struct a4l_device_context * cxt)
+static int a4l_release_driver(struct a4l_device_context * cxt)
 {
 	struct a4l_device *dev = a4l_get_dev(cxt);
 	struct a4l_subdevice *subd, *tmp;
@@ -335,7 +336,7 @@ out_release_driver:
 	return ret;
 }
 
-int a4l_device_attach(struct a4l_device_context * cxt, void *arg)
+static int a4l_device_attach(struct a4l_device_context * cxt, void *arg)
 {
 	int ret = 0;
 	a4l_lnkdesc_t link_arg;
@@ -358,7 +359,7 @@ int a4l_device_attach(struct a4l_device_context * cxt, void *arg)
 	return ret;
 }
 
-int a4l_device_detach(struct a4l_device_context * cxt)
+static int a4l_device_detach(struct a4l_device_context * cxt)
 {
 	struct a4l_device *dev = a4l_get_dev(cxt);
 
diff --git a/kernel/drivers/analogy/instruction.c b/kernel/drivers/analogy/instruction.c
index 1cbdb14ad4..e7a761a5c9 100644
--- a/kernel/drivers/analogy/instruction.c
+++ b/kernel/drivers/analogy/instruction.c
@@ -27,7 +27,7 @@
 #include <asm/errno.h>
 #include <rtdm/analogy/device.h>
 
-int a4l_do_insn_gettime(struct a4l_kernel_instruction * dsc)
+static int a4l_do_insn_gettime(struct a4l_kernel_instruction * dsc)
 {
 	nanosecs_abs_t ns;
 	uint32_t ns2;
@@ -51,7 +51,7 @@ int a4l_do_insn_gettime(struct a4l_kernel_instruction * dsc)
 	return 0;
 }
 
-int a4l_do_insn_wait(struct a4l_kernel_instruction * dsc)
+static int a4l_do_insn_wait(struct a4l_kernel_instruction * dsc)
 {
 	unsigned int us;
 	unsigned int *data = (unsigned int *)dsc->data;
@@ -81,7 +81,8 @@ int a4l_do_insn_wait(struct a4l_kernel_instruction * dsc)
 	return 0;
 }
 
-int a4l_do_insn_trig(struct a4l_device_context * cxt, struct a4l_kernel_instruction * dsc)
+static int a4l_do_insn_trig(struct a4l_device_context * cxt,
+			    struct a4l_kernel_instruction * dsc)
 {
 	struct a4l_subdevice *subd;
 	struct a4l_device *dev = a4l_get_dev(cxt);
@@ -115,7 +116,8 @@ int a4l_do_insn_trig(struct a4l_device_context * cxt, struct a4l_kernel_instruct
 	return subd->trigger(subd, trignum);
 }
 
-int a4l_fill_insndsc(struct a4l_device_context * cxt, struct a4l_kernel_instruction * dsc, void *arg)
+static int a4l_fill_insndsc(struct a4l_device_context * cxt,
+			    struct a4l_kernel_instruction * dsc, void *arg)
 {
 	struct rtdm_fd *fd = rtdm_private_to_fd(cxt);
 	int ret = 0;
@@ -159,7 +161,8 @@ out_insndsc:
 	return ret;
 }
 
-int a4l_free_insndsc(struct a4l_device_context * cxt, struct a4l_kernel_instruction * dsc)
+static int a4l_free_insndsc(struct a4l_device_context * cxt,
+			    struct a4l_kernel_instruction * dsc)
 {
 	struct rtdm_fd *fd = rtdm_private_to_fd(cxt);
 	int ret = 0;
@@ -175,7 +178,8 @@ int a4l_free_insndsc(struct a4l_device_context * cxt, struct a4l_kernel_instruct
 	return ret;
 }
 
-int a4l_do_special_insn(struct a4l_device_context * cxt, struct a4l_kernel_instruction * dsc)
+static int a4l_do_special_insn(struct a4l_device_context * cxt,
+			       struct a4l_kernel_instruction * dsc)
 {
 	int ret = 0;
 
@@ -203,7 +207,8 @@ int a4l_do_special_insn(struct a4l_device_context * cxt, struct a4l_kernel_instr
 	return ret;
 }
 
-int a4l_do_insn(struct a4l_device_context * cxt, struct a4l_kernel_instruction * dsc)
+static int a4l_do_insn(struct a4l_device_context * cxt,
+		       struct a4l_kernel_instruction * dsc)
 {
 	int ret = 0;
 	struct a4l_subdevice *subd;
@@ -326,7 +331,8 @@ err_ioctl_insn:
 	return ret;
 }
 
-int a4l_fill_ilstdsc(struct a4l_device_context * cxt, struct a4l_kernel_instruction_list * dsc, void *arg)
+static int a4l_fill_ilstdsc(struct a4l_device_context * cxt,
+			    struct a4l_kernel_instruction_list * dsc, void *arg)
 {
 	struct rtdm_fd *fd = rtdm_private_to_fd(cxt);
 	int i, ret = 0;
@@ -366,7 +372,8 @@ int a4l_fill_ilstdsc(struct a4l_device_context * cxt, struct a4l_kernel_instruct
 	return ret;
 }
 
-int a4l_free_ilstdsc(struct a4l_device_context * cxt, struct a4l_kernel_instruction_list * dsc)
+static int a4l_free_ilstdsc(struct a4l_device_context * cxt,
+			    struct a4l_kernel_instruction_list * dsc)
 {
 	int i, ret = 0;
 
diff --git a/kernel/drivers/analogy/intel/8255.c b/kernel/drivers/analogy/intel/8255.c
index 1abe250e0c..049c5d2a47 100644
--- a/kernel/drivers/analogy/intel/8255.c
+++ b/kernel/drivers/analogy/intel/8255.c
@@ -90,13 +90,14 @@ static void do_config(struct a4l_subdevice *subd)
 	CALLBACK_FUNC(1, _8255_CR, config, CALLBACK_ARG);
 }
 
-int subd_8255_cmd(struct a4l_subdevice *subd, struct a4l_cmd_desc *cmd)
+static int subd_8255_cmd(struct a4l_subdevice *subd, struct a4l_cmd_desc *cmd)
 {
 	/* FIXME */
 	return 0;
 }
 
-int subd_8255_cmdtest(struct a4l_subdevice *subd, struct a4l_cmd_desc *cmd)
+static int subd_8255_cmdtest(struct a4l_subdevice *subd,
+			     struct a4l_cmd_desc *cmd)
 {
 	if (cmd->start_arg != 0) {
 		cmd->start_arg = 0;
@@ -122,12 +123,13 @@ int subd_8255_cmdtest(struct a4l_subdevice *subd, struct a4l_cmd_desc *cmd)
 	return 0;
 }
 
-void subd_8255_cancel(struct a4l_subdevice *subd)
+static void subd_8255_cancel(struct a4l_subdevice *subd)
 {
 	/* FIXME */
 }
 
-int subd_8255_insn_bits(struct a4l_subdevice *subd, struct a4l_kernel_instruction *insn)
+static int subd_8255_insn_bits(struct a4l_subdevice *subd,
+			       struct a4l_kernel_instruction *insn)
 {
 	subd_8255_t *subd_8255 = (subd_8255_t *)subd->priv;
 	uint32_t *data = (uint32_t *)insn->data;
@@ -157,7 +159,8 @@ int subd_8255_insn_bits(struct a4l_subdevice *subd, struct a4l_kernel_instructio
 	return 0;
 }
 
-int subd_8255_insn_config(struct a4l_subdevice *subd, struct a4l_kernel_instruction *insn)
+static int subd_8255_insn_config(struct a4l_subdevice *subd,
+				 struct a4l_kernel_instruction *insn)
 {
 	unsigned int mask;
 	unsigned int bits;
diff --git a/kernel/drivers/analogy/national_instruments/mio_common.c b/kernel/drivers/analogy/national_instruments/mio_common.c
index c41ec506c7..7cd57ecf27 100644
--- a/kernel/drivers/analogy/national_instruments/mio_common.c
+++ b/kernel/drivers/analogy/national_instruments/mio_common.c
@@ -426,7 +426,7 @@ static int ni_request_cdo_mite_channel(struct a4l_device *dev)
 	return err;
 }
 
-void ni_release_ai_mite_channel(struct a4l_device *dev)
+static void ni_release_ai_mite_channel(struct a4l_device *dev)
 {
 	unsigned long flags;
 
@@ -440,7 +440,7 @@ void ni_release_ai_mite_channel(struct a4l_device *dev)
 
 }
 
-void ni_release_ao_mite_channel(struct a4l_device *dev)
+static void ni_release_ao_mite_channel(struct a4l_device *dev)
 {
 	unsigned long flags;
 
@@ -454,7 +454,8 @@ void ni_release_ao_mite_channel(struct a4l_device *dev)
 
 }
 
-void ni_release_gpct_mite_channel(struct a4l_device *dev, unsigned gpct_index)
+static void ni_release_gpct_mite_channel(struct a4l_device *dev,
+					 unsigned gpct_index)
 {
 	unsigned long flags;
 
@@ -473,7 +474,7 @@ void ni_release_gpct_mite_channel(struct a4l_device *dev, unsigned gpct_index)
 
 }
 
-void ni_release_cdo_mite_channel(struct a4l_device *dev)
+static void ni_release_cdo_mite_channel(struct a4l_device *dev)
 {
 	unsigned long flags;
 
@@ -487,7 +488,7 @@ void ni_release_cdo_mite_channel(struct a4l_device *dev)
 
 }
 
-void ni_sync_ai_dma(struct a4l_subdevice *subd)
+static void ni_sync_ai_dma(struct a4l_subdevice *subd)
 {
 	struct a4l_device *dev = subd->dev;
 	unsigned long flags;
@@ -498,7 +499,7 @@ void ni_sync_ai_dma(struct a4l_subdevice *subd)
 	rtdm_lock_put_irqrestore(&devpriv->mite_channel_lock, flags);
 }
 
-void mite_handle_b_linkc(struct a4l_subdevice *subd)
+static void mite_handle_b_linkc(struct a4l_subdevice *subd)
 {
 	struct a4l_device *dev = subd->dev;
 	unsigned long flags;
@@ -592,8 +593,8 @@ static inline int ni_ao_wait_for_dma_load(struct a4l_subdevice *subd)
 
 /* E-series boards use the second irq signals to generate dma requests
    for their counters */
-void ni_e_series_enable_second_irq(struct a4l_device *dev,
-				   unsigned gpct_index, short enable)
+static void ni_e_series_enable_second_irq(struct a4l_device *dev,
+					  unsigned gpct_index, short enable)
 {
 	if (boardtype.reg_type & ni_reg_m_series_mask)
 		return;
@@ -622,7 +623,7 @@ void ni_e_series_enable_second_irq(struct a4l_device *dev,
 	}
 }
 
-void ni_clear_ai_fifo(struct a4l_device *dev)
+static void ni_clear_ai_fifo(struct a4l_device *dev)
 {
 	if (boardtype.reg_type == ni_reg_6143) {
 		/* Flush the 6143 data FIFO */
@@ -1714,7 +1715,7 @@ static int ni_ai_insn_read(struct a4l_subdevice *subd, struct a4l_kernel_instruc
 	return 0;
 }
 
-void ni_prime_channelgain_list(struct a4l_device *dev)
+static void ni_prime_channelgain_list(struct a4l_device *dev)
 {
 	int i;
 	devpriv->stc_writew(dev, AI_CONVERT_Pulse, AI_Command_1_Register);
@@ -2012,7 +2013,7 @@ static struct a4l_cmd_desc mio_ai_cmd_mask = {
 	.stop_src = TRIG_COUNT | TRIG_NONE,
 };
 
-int ni_ai_inttrig(struct a4l_subdevice *subd, lsampl_t trignum)
+static int ni_ai_inttrig(struct a4l_subdevice *subd, lsampl_t trignum)
 {
 	struct a4l_device *dev = subd->dev;
 
@@ -2584,7 +2585,8 @@ static int ni_ai_cmd(struct a4l_subdevice *subd, struct a4l_cmd_desc *cmd)
 	return 0;
 }
 
-int ni_ai_config_analog_trig(struct a4l_subdevice *subd, struct a4l_kernel_instruction *insn)
+static int ni_ai_config_analog_trig(struct a4l_subdevice *subd,
+				    struct a4l_kernel_instruction *insn)
 {
 	struct a4l_device *dev = subd->dev;
 	unsigned int a, b, modebits;
@@ -2684,7 +2686,8 @@ int ni_ai_config_analog_trig(struct a4l_subdevice *subd, struct a4l_kernel_instr
 	return 0;
 }
 
-int ni_ai_insn_config(struct a4l_subdevice *subd, struct a4l_kernel_instruction *insn)
+static int ni_ai_insn_config(struct a4l_subdevice *subd,
+			     struct a4l_kernel_instruction *insn)
 {
 	struct a4l_device *dev = subd->dev;
 	unsigned int *data = (unsigned int *)insn->data;
@@ -2896,7 +2899,8 @@ static int ni_ao_config_chan_descs(struct a4l_subdevice *subd,
 		return ni_old_ao_config_chan_descs(subd, chanspec, n_chans);
 }
 
-int ni_ao_insn_read(struct a4l_subdevice *subd, struct a4l_kernel_instruction *insn)
+static int ni_ao_insn_read(struct a4l_subdevice *subd,
+			   struct a4l_kernel_instruction *insn)
 {
 	struct a4l_device *dev = subd->dev;
 	uint16_t *data = (uint16_t *)insn->data;
@@ -2906,7 +2910,8 @@ int ni_ao_insn_read(struct a4l_subdevice *subd, struct a4l_kernel_instruction *i
 	return 0;
 }
 
-int ni_ao_insn_write(struct a4l_subdevice *subd, struct a4l_kernel_instruction *insn)
+static int ni_ao_insn_write(struct a4l_subdevice *subd,
+			    struct a4l_kernel_instruction *insn)
 {
 	struct a4l_device *dev = subd->dev;
 	unsigned int chan = CR_CHAN(insn->chan_desc);
@@ -2927,7 +2932,8 @@ int ni_ao_insn_write(struct a4l_subdevice *subd, struct a4l_kernel_instruction *
 	return 0;
 }
 
-int ni_ao_insn_write_671x(struct a4l_subdevice *subd, struct a4l_kernel_instruction *insn)
+static int ni_ao_insn_write_671x(struct a4l_subdevice *subd,
+				 struct a4l_kernel_instruction *insn)
 {
 	struct a4l_device *dev = subd->dev;
 	unsigned int chan = CR_CHAN(insn->chan_desc);
@@ -2945,7 +2951,7 @@ int ni_ao_insn_write_671x(struct a4l_subdevice *subd, struct a4l_kernel_instruct
 	return 0;
 }
 
-int ni_ao_inttrig(struct a4l_subdevice *subd, lsampl_t trignum)
+static int ni_ao_inttrig(struct a4l_subdevice *subd, lsampl_t trignum)
 {
 	struct a4l_device *dev = subd->dev;
 	int ret, interrupt_b_bits, i;
@@ -3019,7 +3025,7 @@ int ni_ao_inttrig(struct a4l_subdevice *subd, lsampl_t trignum)
 	return 0;
 }
 
-int ni_ao_cmd(struct a4l_subdevice *subd, struct a4l_cmd_desc *cmd)
+static int ni_ao_cmd(struct a4l_subdevice *subd, struct a4l_cmd_desc *cmd)
 {
 	struct a4l_device *dev = subd->dev;
 
@@ -3205,7 +3211,7 @@ struct a4l_cmd_desc mio_ao_cmd_mask = {
 	.stop_src = TRIG_COUNT | TRIG_NONE,
 };
 
-int ni_ao_cmdtest(struct a4l_subdevice *subd, struct a4l_cmd_desc *cmd)
+static int ni_ao_cmdtest(struct a4l_subdevice *subd, struct a4l_cmd_desc *cmd)
 {
 	struct a4l_device *dev = subd->dev;
 
@@ -3269,7 +3275,7 @@ int ni_ao_cmdtest(struct a4l_subdevice *subd, struct a4l_cmd_desc *cmd)
 	return 0;
 }
 
-void ni_ao_reset(struct a4l_subdevice *subd)
+static void ni_ao_reset(struct a4l_subdevice *subd)
 {
 	struct a4l_device *dev = subd->dev;
 
@@ -3309,7 +3315,8 @@ void ni_ao_reset(struct a4l_subdevice *subd)
 
 /* digital io */
 
-int ni_dio_insn_config(struct a4l_subdevice *subd, struct a4l_kernel_instruction *insn)
+static int ni_dio_insn_config(struct a4l_subdevice *subd,
+			      struct a4l_kernel_instruction *insn)
 {
 	struct a4l_device *dev = subd->dev;
 	unsigned int *data = (unsigned int *)insn->data;
@@ -3342,7 +3349,8 @@ int ni_dio_insn_config(struct a4l_subdevice *subd, struct a4l_kernel_instruction
 	return 1;
 }
 
-int ni_dio_insn_bits(struct a4l_subdevice *subd, struct a4l_kernel_instruction *insn)
+static int ni_dio_insn_bits(struct a4l_subdevice *subd,
+			    struct a4l_kernel_instruction *insn)
 {
 	struct a4l_device *dev = subd->dev;
 	uint8_t *data = (uint8_t *)insn->data;
@@ -3376,7 +3384,8 @@ int ni_dio_insn_bits(struct a4l_subdevice *subd, struct a4l_kernel_instruction *
 	return 0;
 }
 
-int ni_m_series_dio_insn_config(struct a4l_subdevice *subd, struct a4l_kernel_instruction *insn)
+static int ni_m_series_dio_insn_config(struct a4l_subdevice *subd,
+				       struct a4l_kernel_instruction *insn)
 {
 	struct a4l_device *dev = subd->dev;
 	unsigned int *data = (unsigned int *)insn->data;
@@ -3406,7 +3415,8 @@ int ni_m_series_dio_insn_config(struct a4l_subdevice *subd, struct a4l_kernel_in
 	return 0;
 }
 
-int ni_m_series_dio_insn_bits_8(struct a4l_subdevice *subd, struct a4l_kernel_instruction *insn)
+static int ni_m_series_dio_insn_bits_8(struct a4l_subdevice *subd,
+				       struct a4l_kernel_instruction *insn)
 {
 	struct a4l_device *dev = subd->dev;
 	uint8_t *data = (uint8_t *)insn->data;
@@ -3429,7 +3439,8 @@ int ni_m_series_dio_insn_bits_8(struct a4l_subdevice *subd, struct a4l_kernel_in
 	return 0;
 }
 
-int ni_m_series_dio_insn_bits_32(struct a4l_subdevice *subd, struct a4l_kernel_instruction *insn)
+static int ni_m_series_dio_insn_bits_32(struct a4l_subdevice *subd,
+					struct a4l_kernel_instruction *insn)
 {
 	struct a4l_device *dev = subd->dev;
 	uint32_t *data = (uint32_t *)insn->data;
@@ -3464,7 +3475,7 @@ struct a4l_cmd_desc mio_dio_cmd_mask = {
 	.stop_src = TRIG_NONE,
 };
 
-int ni_cdio_cmdtest(struct a4l_subdevice *subd, struct a4l_cmd_desc *cmd)
+static int ni_cdio_cmdtest(struct a4l_subdevice *subd, struct a4l_cmd_desc *cmd)
 {
 	unsigned int i;
 
@@ -3505,7 +3516,7 @@ int ni_cdio_cmdtest(struct a4l_subdevice *subd, struct a4l_cmd_desc *cmd)
 	return 0;
 }
 
-int ni_cdio_cmd(struct a4l_subdevice *subd, struct a4l_cmd_desc *cmd)
+static int ni_cdio_cmd(struct a4l_subdevice *subd, struct a4l_cmd_desc *cmd)
 {
 	struct a4l_device *dev = subd->dev;
 	unsigned cdo_mode_bits = CDO_FIFO_Mode_Bit | CDO_Halt_On_Error_Bit;
@@ -3539,7 +3550,7 @@ int ni_cdio_cmd(struct a4l_subdevice *subd, struct a4l_cmd_desc *cmd)
 	return 0;
 }
 
-void ni_cdio_cancel(struct a4l_subdevice *subd)
+static void ni_cdio_cancel(struct a4l_subdevice *subd)
 {
 	struct a4l_device *dev = subd->dev;
 	ni_writel(CDO_Disarm_Bit | CDO_Error_Interrupt_Enable_Clear_Bit |
@@ -3551,7 +3562,7 @@ void ni_cdio_cancel(struct a4l_subdevice *subd)
 	ni_release_cdo_mite_channel(dev);
 }
 
-int ni_cdo_inttrig(struct a4l_subdevice *subd, lsampl_t trignum)
+static int ni_cdo_inttrig(struct a4l_subdevice *subd, lsampl_t trignum)
 {
 	struct a4l_device *dev = subd->dev;
 	int err;
@@ -3737,7 +3748,8 @@ static int ni_serial_sw_readwrite8(struct a4l_device * dev,
 	return 0;
 }
 
-int ni_serial_insn_config(struct a4l_subdevice *subd, struct a4l_kernel_instruction *insn)
+static int ni_serial_insn_config(struct a4l_subdevice *subd,
+				 struct a4l_kernel_instruction *insn)
 {
 	struct a4l_device *dev = subd->dev;
 	int err = 0;
@@ -4040,7 +4052,8 @@ static unsigned int ni_gpct_read_register(struct ni_gpct *counter,
 	return 0;
 }
 
-int ni_freq_out_insn_read(struct a4l_subdevice *subd, struct a4l_kernel_instruction *insn)
+static int ni_freq_out_insn_read(struct a4l_subdevice *subd,
+				 struct a4l_kernel_instruction *insn)
 {
 	struct a4l_device *dev = subd->dev;
 	uint8_t *data = (uint8_t *)insn->data;
@@ -4050,7 +4063,8 @@ int ni_freq_out_insn_read(struct a4l_subdevice *subd, struct a4l_kernel_instruct
 	return 0;
 }
 
-int ni_freq_out_insn_write(struct a4l_subdevice *subd, struct a4l_kernel_instruction *insn)
+static int ni_freq_out_insn_write(struct a4l_subdevice *subd,
+				  struct a4l_kernel_instruction *insn)
 {
 	struct a4l_device *dev = subd->dev;
 	uint8_t *data = (uint8_t *)insn->data;
@@ -4098,7 +4112,8 @@ static void ni_get_freq_out_clock(struct a4l_device * dev,
 	}
 }
 
-int ni_freq_out_insn_config(struct a4l_subdevice *subd, struct a4l_kernel_instruction *insn)
+static int ni_freq_out_insn_config(struct a4l_subdevice *subd,
+				   struct a4l_kernel_instruction *insn)
 {
 	struct a4l_device *dev = subd->dev;
 	unsigned int *data = (unsigned int *)insn->data;
diff --git a/kernel/drivers/analogy/national_instruments/mite.c b/kernel/drivers/analogy/national_instruments/mite.c
index ad1a8dded6..2f2014bcdb 100644
--- a/kernel/drivers/analogy/national_instruments/mite.c
+++ b/kernel/drivers/analogy/national_instruments/mite.c
@@ -515,7 +515,7 @@ void a4l_mite_prep_dma(struct mite_channel *mite_chan,
 	MDPRINTK("exit a4l_mite_prep_dma\n");
 }
 
-u32 mite_device_bytes_transferred(struct mite_channel *mite_chan)
+static u32 mite_device_bytes_transferred(struct mite_channel *mite_chan)
 {
 	struct mite_struct *mite = mite_chan->mite;
 	return readl(mite->mite_io_addr + MITE_DAR(mite_chan->channel));
diff --git a/kernel/drivers/analogy/rtdm_interface.c b/kernel/drivers/analogy/rtdm_interface.c
index 765c176c0b..914b2e1b78 100644
--- a/kernel/drivers/analogy/rtdm_interface.c
+++ b/kernel/drivers/analogy/rtdm_interface.c
@@ -75,7 +75,7 @@ static const DEFINE_PROC_OPS(a4l_proc_drvs_ops,
 			seq_read,
 			NULL);
 
-int a4l_init_proc(void)
+static int a4l_init_proc(void)
 {
 	int ret = 0;
 	struct proc_dir_entry *entry;
@@ -116,7 +116,7 @@ err_proc_init:
 	return ret;
 }
 
-void a4l_cleanup_proc(void)
+static void a4l_cleanup_proc(void)
 {
 	remove_proc_entry("drivers", a4l_proc_root);
 	remove_proc_entry("devices", a4l_proc_root);
@@ -130,7 +130,7 @@ void a4l_cleanup_proc(void)
 
 #endif /* CONFIG_PROC_FS */
 
-int a4l_open(struct rtdm_fd *fd, int flags)
+static int a4l_open(struct rtdm_fd *fd, int flags)
 {
 	struct a4l_device_context *cxt = (struct a4l_device_context *)rtdm_fd_to_private(fd);
 
@@ -154,7 +154,7 @@ int a4l_open(struct rtdm_fd *fd, int flags)
 	return 0;
 }
 
-void a4l_close(struct rtdm_fd *fd)
+static void a4l_close(struct rtdm_fd *fd)
 {
 	struct a4l_device_context *cxt = (struct a4l_device_context *)rtdm_fd_to_private(fd);
 
@@ -171,7 +171,7 @@ void a4l_close(struct rtdm_fd *fd)
 	rtdm_free(cxt->buffer);
 }
 
-ssize_t a4l_read(struct rtdm_fd *fd, void *buf, size_t nbytes)
+static ssize_t a4l_read(struct rtdm_fd *fd, void *buf, size_t nbytes)
 {
 	struct a4l_device_context *cxt = (struct a4l_device_context *)rtdm_fd_to_private(fd);
 
@@ -185,7 +185,7 @@ ssize_t a4l_read(struct rtdm_fd *fd, void *buf, size_t nbytes)
 	return a4l_read_buffer(cxt, buf, nbytes);
 }
 
-ssize_t a4l_write(struct rtdm_fd *fd, const void *buf, size_t nbytes)
+static ssize_t a4l_write(struct rtdm_fd *fd, const void *buf, size_t nbytes)
 {
 	struct a4l_device_context *cxt = (struct a4l_device_context *)rtdm_fd_to_private(fd);
 
@@ -199,14 +199,14 @@ ssize_t a4l_write(struct rtdm_fd *fd, const void *buf, size_t nbytes)
 	return a4l_write_buffer(cxt, buf, nbytes);
 }
 
-int a4l_ioctl(struct rtdm_fd *fd, unsigned int request, void *arg)
+static int a4l_ioctl(struct rtdm_fd *fd, unsigned int request, void *arg)
 {
 	struct a4l_device_context *cxt = (struct a4l_device_context *)rtdm_fd_to_private(fd);
 
 	return a4l_ioctl_functions[_IOC_NR(request)] (cxt, arg);
 }
 
-int a4l_rt_select(struct rtdm_fd *fd,
+static int a4l_rt_select(struct rtdm_fd *fd,
 		  rtdm_selector_t *selector,
 		  enum rtdm_selecttype type, unsigned fd_index)
 {
@@ -243,7 +243,7 @@ static struct rtdm_device rtdm_devs[A4L_NB_DEVICES] = {
 	}
 };
 
-int a4l_register(void)
+static int a4l_register(void)
 {
 	int i, ret;
 
@@ -261,7 +261,7 @@ fail:
 	return ret;
 }
 
-void a4l_unregister(void)
+static void a4l_unregister(void)
 {
 	int i;
 	for (i = 0; i < A4L_NB_DEVICES; i++)
diff --git a/kernel/drivers/analogy/testing/fake.c b/kernel/drivers/analogy/testing/fake.c
index c80c1cc183..cae0998be5 100644
--- a/kernel/drivers/analogy/testing/fake.c
+++ b/kernel/drivers/analogy/testing/fake.c
@@ -132,7 +132,7 @@ static inline uint16_t ai_value_output(struct ai_priv *priv)
 	return output_tab[idx] / priv->amplitude_div;
 }
 
-int ai_push_values(struct a4l_subdevice *subd)
+static int ai_push_values(struct a4l_subdevice *subd)
 {
 	uint64_t now_ns, elapsed_ns = 0;
 	struct a4l_cmd_desc *cmd;
@@ -175,7 +175,7 @@ int ai_push_values(struct a4l_subdevice *subd)
 
 /* --- Data retrieval for AO --- */
 
-int ao_pull_values(struct a4l_subdevice *subd)
+static int ao_pull_values(struct a4l_subdevice *subd)
 {
 	struct ao_ai2_priv *priv = (struct ao_ai2_priv *)subd->priv;
 	int err;
@@ -205,7 +205,7 @@ int ao_pull_values(struct a4l_subdevice *subd)
 
 /* --- Data redirection for 2nd AI (from AO) --- */
 
-int ai2_push_values(struct a4l_subdevice *subd)
+static int ai2_push_values(struct a4l_subdevice *subd)
 {
 	struct ao_ai2_priv *priv = *((struct ao_ai2_priv **)subd->priv);
 	int err = 0;
@@ -290,13 +290,13 @@ static void ai_munge(struct a4l_subdevice *subd, void *buf, unsigned long size)
 
 /* --- Asynchronous A0 functions --- */
 
-int ao_cmd(struct a4l_subdevice *subd, struct a4l_cmd_desc *cmd)
+static int ao_cmd(struct a4l_subdevice *subd, struct a4l_cmd_desc *cmd)
 {
 	a4l_info(subd->dev, "(subd=%d)\n", subd->idx);
 	return 0;
 }
 
-int ao_trigger(struct a4l_subdevice *subd, lsampl_t trignum)
+static int ao_trigger(struct a4l_subdevice *subd, lsampl_t trignum)
 {
 	struct fake_priv *priv = (struct fake_priv *)subd->dev->priv;
 
@@ -305,7 +305,7 @@ int ao_trigger(struct a4l_subdevice *subd, lsampl_t trignum)
 	return 0;
 }
 
-void ao_cancel(struct a4l_subdevice *subd)
+static void ao_cancel(struct a4l_subdevice *subd)
 {
 	struct fake_priv *priv = (struct fake_priv *)subd->dev->priv;
 	struct ao_ai2_priv *ao_priv = (struct ao_ai2_priv *)subd->priv;
@@ -333,7 +333,7 @@ void ao_cancel(struct a4l_subdevice *subd)
 
 /* --- Asynchronous 2nd AI functions --- */
 
-int ai2_cmd(struct a4l_subdevice *subd, struct a4l_cmd_desc *cmd)
+static int ai2_cmd(struct a4l_subdevice *subd, struct a4l_cmd_desc *cmd)
 {
 	struct fake_priv *priv = (struct fake_priv *)subd->dev->priv;
 
@@ -342,7 +342,7 @@ int ai2_cmd(struct a4l_subdevice *subd, struct a4l_cmd_desc *cmd)
 	return 0;
 }
 
-void ai2_cancel(struct a4l_subdevice *subd)
+static void ai2_cancel(struct a4l_subdevice *subd)
 {
 	struct fake_priv *priv = (struct fake_priv *)subd->dev->priv;
 	struct ao_ai2_priv *ai2_priv = *((struct ao_ai2_priv **)subd->priv);
@@ -407,7 +407,7 @@ static int dio_insn_bits(struct a4l_subdevice *subd, struct a4l_kernel_instructi
 
 /* --- Synchronous AO + AI2 functions --- */
 
-int ao_insn_write(struct a4l_subdevice *subd, struct a4l_kernel_instruction *insn)
+static int ao_insn_write(struct a4l_subdevice *subd, struct a4l_kernel_instruction *insn)
 {
 	struct ao_ai2_priv *priv = (struct ao_ai2_priv *)subd->priv;
 	uint16_t *data = (uint16_t *)insn->data;
@@ -422,7 +422,7 @@ int ao_insn_write(struct a4l_subdevice *subd, struct a4l_kernel_instruction *ins
 	return 0;
 }
 
-int ai2_insn_read(struct a4l_subdevice *subd, struct a4l_kernel_instruction *insn)
+static int ai2_insn_read(struct a4l_subdevice *subd, struct a4l_kernel_instruction *insn)
 {
 	struct ao_ai2_priv *priv = *((struct ao_ai2_priv **)subd->priv);
 	uint16_t *data = (uint16_t *)insn->data;
@@ -495,7 +495,7 @@ static void task_proc(void *arg)
 
 /* --- Initialization functions --- */
 
-void setup_ai_subd(struct a4l_subdevice *subd)
+static void setup_ai_subd(struct a4l_subdevice *subd)
 {
 	/* Fill the subdevice structure */
 	subd->flags |= A4L_SUBD_AI;
@@ -511,7 +511,7 @@ void setup_ai_subd(struct a4l_subdevice *subd)
 	subd->insn_read = ai_insn_read;
 }
 
-void setup_dio_subd(struct a4l_subdevice *subd)
+static void setup_dio_subd(struct a4l_subdevice *subd)
 {
 	/* Fill the subdevice structure */
 	subd->flags |= A4L_SUBD_DIO;
@@ -520,7 +520,7 @@ void setup_dio_subd(struct a4l_subdevice *subd)
 	subd->insn_bits = dio_insn_bits;
 }
 
-void setup_ao_subd(struct a4l_subdevice *subd)
+static void setup_ao_subd(struct a4l_subdevice *subd)
 {
 	/* Fill the subdevice structure */
 	subd->flags |= A4L_SUBD_AO;
@@ -535,7 +535,7 @@ void setup_ao_subd(struct a4l_subdevice *subd)
 	subd->insn_write = ao_insn_write;
 }
 
-void setup_ai2_subd(struct a4l_subdevice *subd)
+static void setup_ai2_subd(struct a4l_subdevice *subd)
 {
 	/* Fill the subdevice structure */
 	subd->flags |= A4L_SUBD_AI;
@@ -551,7 +551,7 @@ void setup_ai2_subd(struct a4l_subdevice *subd)
 
 /* --- Attach / detach functions ---  */
 
-int test_attach(struct a4l_device *dev, a4l_lnkdesc_t *arg)
+static int test_attach(struct a4l_device *dev, a4l_lnkdesc_t *arg)
 {
 	typedef void (*setup_subd_function) (struct a4l_subdevice *subd);
 	struct fake_priv *priv = (struct fake_priv *) dev->priv;
@@ -648,7 +648,7 @@ int test_attach(struct a4l_device *dev, a4l_lnkdesc_t *arg)
 	return ret;
 }
 
-int test_detach(struct a4l_device *dev)
+static int test_detach(struct a4l_device *dev)
 {
 	struct fake_priv *priv = (struct fake_priv *)dev->priv;
 
-- 
2.35.3

