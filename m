Message-ID: <4A6C6101.5050707@domain.hid>
Date: Sun, 26 Jul 2009 15:58:25 +0200
From: Matteo Facchinetti <matteo.facchinetti@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------030809040307090101050009"
Subject: [Xenomai-core] socket can compile broken
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
--------------030809040307090101050009
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

I've upgrade xenomai to the last 2.4.8 (git) version.
I'm using kernel 2.6.24powerpc and for compile socket-can module, need 
to change MPC5xxx_GPIO define.
In this kernel version I havn't mpc5xxx_gpio_find_and_map() function but 
only mpc52xx_find_and_map("mpc5200-gpio").

Regards.

Matteo Facchinetti
Sirius Electronic Systems



--------------030809040307090101050009
Content-Type: text/x-diff;
 name="Fix-MPC5xxx_GPIO_x_kern2.6.24.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="Fix-MPC5xxx_GPIO_x_kern2.6.24.patch"

diff --git a/ksrc/drivers/can/mscan/rtcan_mscan_regs.h b/ksrc/drivers/can/mscan/rtcan_mscan_regs.h
index ad996ad..e6fd7ed 100644
--- a/ksrc/drivers/can/mscan/rtcan_mscan_regs.h
+++ b/ksrc/drivers/can/mscan/rtcan_mscan_regs.h
@@ -42,8 +42,10 @@ static inline void __iomem *mpc5xxx_gpio_find_and_map(void)
 	    ofn = of_find_compatible_node(NULL, NULL, "fsl,mpc5200-gpio");
 	return ofn ? of_iomap(ofn, 0) : NULL;
 }
-#endif
 #define MPC5xxx_GPIO    mpc5xxx_gpio_find_and_map()
+#else
+#define MPC5xxx_GPIO    mpc52xx_find_and_map("mpc5200-gpio")
+#endif
 #define mpc5xxx_gpio	mpc52xx_gpio
 #elif LINUX_VERSION_CODE < KERNEL_VERSION(2,6,10)
 #include <asm/mpc5xxx.h>

--------------030809040307090101050009--

