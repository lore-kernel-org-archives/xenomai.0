Message-ID: <4E8B0AC7.60508@domain.hid>
Date: Tue, 04 Oct 2011 15:31:51 +0200
From: Daniele Nicolodi <daniele@domain.hid>
MIME-Version: 1.0
References: <4E81D866.5000504@domain.hid>
	<CAMesUR40qfwCK0HARML05E+1a3DwaiqZGmEJYY-Nn2pRsc4UyA@mail.gmail.com>
	<4E8756EA.1060700@domain.hid> <4E8ABC9A.4070604@domain.hid>
	<4E8AEB66.9030500@domain.hid>
In-Reply-To: <4E8AEB66.9030500@domain.hid>
Content-Type: multipart/mixed; boundary="------------090704080101030802050004"
Subject: Re: [Xenomai-core] Analogy: idx_write_subd field in a4l_desc_t
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

This is a multi-part message in MIME format.
--------------090704080101030802050004
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 04/10/11 13:17, Gilles Chanteperdrix wrote:
> If you want things merged, send the patches, they will reach
> xenomai-head repository through Alex.

Of course. Here is my simple patch.

Thank you. Cheers,
-- 
Daniele

--------------090704080101030802050004
Content-Type: text/x-diff;
 name="0001-analogy-demote-some-messages-logged-in-mio_common-dr.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-analogy-demote-some-messages-logged-in-mio_common-dr.pa";
 filename*1="tch"

>From 6944fe7465e1eb614cf9db3eccceb93d77bf95f1 Mon Sep 17 00:00:00 2001
From: Daniele Nicolodi <nicolodi@domain.hid>
Date: Tue, 4 Oct 2011 14:49:27 +0200
Subject: [PATCH 1/3] analogy: demote some messages logged in mio_common
 driver code to debug level

---
 .../analogy/national_instruments/mio_common.c      |   24 ++++++++++----------
 1 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/ksrc/drivers/analogy/national_instruments/mio_common.c b/ksrc/drivers/analogy/national_instruments/mio_common.c
index a68cf2c..4303934 100644
--- a/ksrc/drivers/analogy/national_instruments/mio_common.c
+++ b/ksrc/drivers/analogy/national_instruments/mio_common.c
@@ -835,8 +835,8 @@ static void handle_a_interrupt(a4l_dev_t *dev,
 	if((subd->flags & A4L_SUBD_TYPES) == A4L_SUBD_UNUSED)
 		return;
 
-	a4l_info(dev, "ni_mio_common: interrupt: "
-		 "a_status=%04x ai_mite_status=%08x\n",status, ai_mite_status);
+	a4l_dbg(1, drv_dbg, dev, "ni_mio_common: interrupt: "
+		"a_status=%04x ai_mite_status=%08x\n",status, ai_mite_status);
 	ni_mio_print_status_a(status);
 
 #if (defined(CONFIG_XENO_DRIVERS_ANALOGY_NI_MITE) || \
@@ -847,9 +847,9 @@ static void handle_a_interrupt(a4l_dev_t *dev,
 	if (ai_mite_status & ~(CHSR_INT | CHSR_LINKC | CHSR_DONE | CHSR_MRDY |
 			       CHSR_DRDY | CHSR_DRQ1 | CHSR_DRQ0 | CHSR_ERROR |
 			       CHSR_SABORT | CHSR_XFERR | CHSR_LxERR_mask)) {
-		a4l_info(dev, "ni_mio_common: interrupt: "
-			 "unknown mite interrupt, ack! (ai_mite_status=%08x)\n",
-			 ai_mite_status);
+		a4l_dbg(1, drv_dbg, dev, "ni_mio_common: interrupt: "
+			"unknown mite interrupt, ack! (ai_mite_status=%08x)\n",
+			ai_mite_status);
 		a4l_buf_evt(subd, A4L_BUF_ERROR);
 	}
 #endif /* CONFIG_XENO_DRIVERS_ANALOGY_NI_MITE */
@@ -858,8 +858,8 @@ static void handle_a_interrupt(a4l_dev_t *dev,
 	if (status & (AI_Overrun_St | AI_Overflow_St | AI_SC_TC_Error_St |
 		      AI_SC_TC_St | AI_START1_St)) {
 		if (status == 0xffff) {
-			a4l_info(dev, "ni_mio_common: interrupt: "
-				 "a_status=0xffff.  Card removed?\n");
+			a4l_dbg(1, drv_dbg, dev, "ni_mio_common: interrupt: "
+				"a_status=0xffff.  Card removed?\n");
 			/* TODO: we probably aren't even running a command now,
 			   so it's a good idea to be careful.
 			   we should check the transfer status */
@@ -869,8 +869,8 @@ static void handle_a_interrupt(a4l_dev_t *dev,
 		}
 		if (status & (AI_Overrun_St | AI_Overflow_St |
 			      AI_SC_TC_Error_St)) {
-			a4l_info(dev, "ni_mio_common: interrupt: "
-				 "ai error a_status=%04x\n", status);
+			a4l_dbg(1, drv_dbg, dev, "ni_mio_common: interrupt: "
+				"ai error a_status=%04x\n", status);
 			ni_mio_print_status_a(status);
 
 			shutdown_ai_command(subd);
@@ -881,7 +881,7 @@ static void handle_a_interrupt(a4l_dev_t *dev,
 			return;
 		}
 		if (status & AI_SC_TC_St) {
-			a4l_info(dev, "ni_mio_common: SC_TC interrupt\n");
+			a4l_dbg(1, drv_dbg, dev, "ni_mio_common: SC_TC interrupt\n");
 			if (!devpriv->ai_continuous) {
 				shutdown_ai_command(subd);
 			}
@@ -914,8 +914,8 @@ static void handle_a_interrupt(a4l_dev_t *dev,
 
 	status = devpriv->stc_readw(dev, AI_Status_1_Register);
 	if (status & Interrupt_A_St)
-		a4l_info(dev, "ni_mio_common: interrupt: "
-			 " didn't clear interrupt? status=0x%x\n", status);
+		a4l_dbg(1, drv_dbg, dev, "ni_mio_common: interrupt: "
+			" didn't clear interrupt? status=0x%x\n", status);
 }
 
 static void ack_b_interrupt(a4l_dev_t *dev, unsigned short b_status)
-- 
1.7.6.3


--------------090704080101030802050004--

