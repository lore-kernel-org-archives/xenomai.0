Message-ID: <4D21A5CF.9000107@domain.hid>
Date: Mon, 03 Jan 2011 11:32:47 +0100
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
References: <4D20D7A7.2090003@domain.hid>
In-Reply-To: <4D20D7A7.2090003@domain.hid>
Content-Type: multipart/mixed; boundary="------------030405070005060505000707"
Subject: Re: [Xenomai-core] Build issue with rtcan and I-pipe for linux
 2.6.36 on powerpc.
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai core <Xenomai-core@domain.hid>, Wolfgang Grandegger <wg@domain.hid>

This is a multi-part message in MIME format.
--------------030405070005060505000707
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi Gilles,

the attached patch fixes the issue.

On 01/02/2011 08:53 PM, Gilles Chanteperdrix wrote:
> 
> Hi Wolfgang,
> 
> It seems we have an issue building rtcan for mpc5xxx with Linux 2.6.36.
> As far as I understood the of_device structure disappeared and the
> "device tree" bits were integrated in the device structure, which causes
> several errors when building ksrc/drivers/can/mscan/rtcan_mscan_mpc5xxx.c
> 
> Build log details here:
> http://sisyphus.hd.free.fr/~gilles/bx/lite5200/2.6.36-ppc_6xx-gcc-4.2.2/log.html#1

Wolfgang.

--------------030405070005060505000707
Content-Type: text/x-diff;
 name="0001-wrappers-fixup-struct-of_device-for-RTCAN-MPC5xxx-dr.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-wrappers-fixup-struct-of_device-for-RTCAN-MPC5xxx-dr.pa";
 filename*1="tch"

>From 94e2e92946a74bed44b9be208a3cef43e3e52477 Mon Sep 17 00:00:00 2001
From: Wolfgang Grandegger <wg@domain.hid>
Date: Mon, 3 Jan 2011 10:59:09 +0100
Subject: [PATCH] wrappers: fixup "struct of_device" for RTCAN MPC5xxx driver

Since 2.6.36, of_device is just an alias for platform_device.

Signed-off-by: Wolfgang Grandegger <wg@domain.hid>
---
 include/asm-powerpc/wrappers.h |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/include/asm-powerpc/wrappers.h b/include/asm-powerpc/wrappers.h
index 7f1214a..fb49307 100644
--- a/include/asm-powerpc/wrappers.h
+++ b/include/asm-powerpc/wrappers.h
@@ -191,4 +191,8 @@ typedef irq_handler_t rthal_irq_host_handler_t;
 #define mpc5xxx_get_bus_frequency(node)	mpc52xx_find_ipb_freq(node)
 #endif
 
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,36)
+#define of_device platform_device
+#endif
+
 #endif /* _XENO_ASM_POWERPC_WRAPPERS_H */
-- 
1.7.2.3


--------------030405070005060505000707--

