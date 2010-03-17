Message-ID: <4BA0E8D9.4060901@domain.hid>
Date: Wed, 17 Mar 2010 15:36:09 +0100
From: Daniele Nicolodi <daniele@domain.hid>
MIME-Version: 1.0
References: <4B991999.1070406@domain.hid>
In-Reply-To: <4B991999.1070406@domain.hid>
Content-Type: multipart/mixed; boundary="------------070107000903010202060203"
Subject: Re: [Xenomai-core] Analogy a4l_ioctl_bufinfo() bug?
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

This is a multi-part message in MIME format.
--------------070107000903010202060203
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Daniele Nicolodi wrote:
> Hello. As reported in the xenomai-help mailing list I'm investigating
> why a4l_mmap() is not supported for the ni pcimio driver. Hacking on the
> driver I discovered that, apparently, the only problem in supporting
> mmap of the device buffer is in the a4l_ioctl_bufinfo() function.

The atached patch solves the problem. My solution is to avoid to mess
with the subdevice buffer if a transmission is not occouring. This makes
ni pcimio driver work as expected. The second patch enables mmapping for
the ni pcimio driver.

Cheers,
-- 
Daniele


--------------070107000903010202060203
Content-Type: text/x-diff;
 name="analogy03.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="analogy03.patch"

commit d0bbc69a106012a2152ff8ff8fe4897ae0c34bcd
Author: Daniele Nicolodi <nicolodi@domain.hid>
Date:   Wed Mar 17 15:24:22 2010 +0100

    Fix a4i_ioctl_bufinfo to do not try to copy data from the subdevice buffer if a transfer is not occuring.

diff --git a/ksrc/drivers/analogy/buffer.c b/ksrc/drivers/analogy/buffer.c
index 0c66b4a..1a8acf7 100644
--- a/ksrc/drivers/analogy/buffer.c
+++ b/ksrc/drivers/analogy/buffer.c
@@ -560,6 +560,14 @@ int a4l_ioctl_bufinfo(a4l_cxt_t * cxt, void *arg)
 
 	buf = dev->transfer.bufs[info.idx_subd];
 
+	/* If a transfer is not occuring, simply return buffer
+	   informations, otherwise make the transfer progress */
+	if (! test_bit(A4L_TSF_BUSY,
+		       &(dev->transfer.status[info.idx_subd]))) {
+		info.rw_count = 0;
+		goto a4l_ioctl_bufinfo_out;
+	}
+
 	ret = __handle_event(buf);
 
 	if (info.idx_subd == dev->transfer.idx_read_subd) {
@@ -621,6 +629,8 @@ int a4l_ioctl_bufinfo(a4l_cxt_t * cxt, void *arg)
 		buf->mng_count += tmp_cnt;
 	}
 
+a4l_ioctl_bufinfo_out:	
+
 	/* Sets the buffer size */
 	info.buf_size = buf->size;
 

--------------070107000903010202060203
Content-Type: text/x-diff;
 name="analogy02.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="analogy02.patch"

commit 230e1c7da63e2324e25ae9bf959f5c10d3d8c3ec
Author: Daniele Nicolodi <nicolodi@domain.hid>
Date:   Wed Mar 17 15:26:26 2010 +0100

    Enable subdevice buffer mmapping for ni pcimio driver.

diff --git a/ksrc/drivers/analogy/national_instruments/mio_common.c b/ksrc/drivers/analogy/national_instruments/mio_common.c
index 1a39206..a51a3cd 100644
--- a/ksrc/drivers/analogy/national_instruments/mio_common.c
+++ b/ksrc/drivers/analogy/national_instruments/mio_common.c
@@ -4913,7 +4913,7 @@ int ni_E_init(a4l_dev_t *dev)
 		a4l_dbg(1, drv_dbg, dev, 
 			"mio_common: AI: %d channels\n", boardtype.n_adchan);
 
-		subd->flags = A4L_SUBD_AI | A4L_SUBD_CMD;
+		subd->flags = A4L_SUBD_AI | A4L_SUBD_CMD | A4L_SUBD_MMAP;
 		subd->rng_desc = ni_range_lkup[boardtype.gainlkup];
 
 		subd->chan_desc = kmalloc(sizeof(a4l_chdesc_t) + 
@@ -4981,7 +4981,7 @@ int ni_E_init(a4l_dev_t *dev)
 		
 
 		if (boardtype.ao_fifo_depth) {
-			subd->flags |= A4L_SUBD_CMD;
+			subd->flags |= A4L_SUBD_CMD | A4L_SUBD_MMAP;
 			subd->do_cmd = &ni_ao_cmd;
 			subd->cmd_mask = &mio_ao_cmd_mask;
 			subd->do_cmdtest = &ni_ao_cmdtest;

--------------070107000903010202060203--

