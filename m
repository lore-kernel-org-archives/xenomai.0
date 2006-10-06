Message-ID: <4526B48F.50705@domain.hid>
Date: Fri, 06 Oct 2006 21:54:55 +0200
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] rtcan_mscan compilation.
References: <ac3922a00610060437i4735bf7at85ca11beb12ab1be@domain.hid>
In-Reply-To: <ac3922a00610060437i4735bf7at85ca11beb12ab1be@domain.hid>
Content-Type: multipart/mixed; boundary="------------000705080307070306030103"
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Syed Amer Gilani <amg@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>

This is a multi-part message in MIME format.
--------------000705080307070306030103
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Syed Amer Gilani wrote:
> I wanted to test rtcan but the mscan Driver fails to compile:
> 
>  CC      drivers/xenomai/can/mscan/rtcan_mscan.o
> drivers/xenomai/can/mscan/rtcan_mscan.c:85: error: syntax error before
> string constant
> drivers/xenomai/can/mscan/rtcan_mscan.c:85: warning: type defaults to
> 'int' in declaration of 'MODULE_PARM'
> drivers/xenomai/can/mscan/rtcan_mscan.c:85: warning: function
> declaration isn't a prototype
> drivers/xenomai/can/mscan/rtcan_mscan.c:85: warning: data definition
> has no type or storage class
> drivers/xenomai/can/mscan/rtcan_mscan.c:89: error: syntax error before
> string constant
> drivers/xenomai/can/mscan/rtcan_mscan.c:89: warning: type defaults to
> 'int' in declaration of 'MODULE_PARM'
> drivers/xenomai/can/mscan/rtcan_mscan.c:89: warning: function
> declaration isn't a prototype
> drivers/xenomai/can/mscan/rtcan_mscan.c:89: warning: data definition
> has no type or storage class
> make[4]: *** [drivers/xenomai/can/mscan/rtcan_mscan.o] Fehler 1
> 
> When i understand the Sources correct it has something to do with the
> value of the config variables. But i left them all on the default
> values:
> 
> CONFIG_XENO_DRIVERS_RTCAN_MSCAN=y
> CONFIG_XENO_DRIVERS_RTCAN_MSCAN_1=y
> CONFIG_XENO_DRIVERS_RTCAN_MSCAN_2=y
> CONFIG_XENO_DRIVERS_RTCAN_MSCAN_CLOCK=66000000
> CONFIG_XENO_DRIVERS_RTCAN_MSCAN_ALT=y
> # CONFIG_XENO_DRIVERS_RTCAN_MSCAN_PSC2 is not set

It did at least compile under Linux 2.6.14, but MODULE_PARM has been 
removed in 2.6.17 :-(. Attached is a patch to get the MSCAN driver 
working under Linux 2.6.17. Philippe or Jan, could you please apply it, 
thanks.

Also be aware that on the MPC5200B the MSCAN clock source used is the 
oscillator clock (SYS_XTAL_IN) while on the MPC5200 it is the IP bus 
clock (IP_CLK) due to hardware bugs (see chip errata). Likely 
SYS_XTAL_IN runs at 33 MHz on your system.

Wolfgang.

--------------000705080307070306030103
Content-Type: text/x-patch;
 name="xenomai-rtcan-mscan-2.6.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="xenomai-rtcan-mscan-2.6.patch"

Index: ChangeLog
===================================================================
--- ChangeLog	(revision 1695)
+++ ChangeLog	(working copy)
@@ -1,3 +1,18 @@
+2006-10-06  Wolfgang Grandegger  <wg@domain.hid>
+
+	* ksrc/drivers/can/rtcan_module.c (rtcan_dev_get_state_name): Bug
+	fix. Function did return invalid state name.
+
+	* ksrc/drivers/can/rtcan_internal.h: MODULE_PARM has been removed
+	in Linux 2.6.17. Replaced with compat_module_*_param definitions.
+	
+	* ksrc/drivers/can/mscan/rtcan_mscan.c: Use compat_module_*
+	functions in the MSCAN driver as well.
+
+	* ksrc/drivers/can/mscan/rtcan_mscan_regs.h: Fix invalid address
+	for MPC5200 GPIO registers. Now the MSCAN driver works for Linux
+	2.6.17.
+	
 2006-10-06  Jan Kiszka  <jan.kiszka@domain.hid>
 
 	* src/testsuite/cyclic/cyclictest.c: Align to latest v0.11,
Index: ksrc/drivers/can/rtcan_internal.h
===================================================================
--- ksrc/drivers/can/rtcan_internal.h	(revision 1695)
+++ ksrc/drivers/can/rtcan_internal.h	(working copy)
@@ -111,6 +111,10 @@
 
 #ifndef compat_module_int_param_array
 #if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,10)
+# define compat_module_int_param(name) \
+    MODULE_PARM(name, "i")
+# define compat_module_charp_param(name) \
+    MODULE_PARM(name, "s")
 # define compat_module_byte_param_array(name, count) \
     MODULE_PARM(name, "1-" __MODULE_STRING(count) "b")
 # define compat_module_short_param_array(name, count) \
@@ -118,6 +122,10 @@
 # define compat_module_int_param_array(name, count) \
     MODULE_PARM(name, "1-" __MODULE_STRING(count) "i")
 #else
+# define compat_module_int_param(name) \
+    module_param(name, int, 0444)
+# define compat_module_charp_param(name) \
+    module_param(name, charp, 0444)
 # define compat_module_byte_param_array(name, count) \
     module_param_array(name, byte, NULL, 0444)
 # define compat_module_short_param_array(name, count) \
Index: ksrc/drivers/can/rtcan_module.c
===================================================================
--- ksrc/drivers/can/rtcan_module.c	(revision 1695)
+++ ksrc/drivers/can/rtcan_module.c	(working copy)
@@ -54,15 +54,15 @@
 }
 
 static char *rtcan_state_names[] = {
-    "active", "stopped", "sleeping", "warning", 
-    "passive" , "bus-off", "scanning"
+    "active", "warning", "passive" , "bus-off", 
+    "scanning", "stopped", "sleeping"
 };
 
 static void rtcan_dev_get_state_name(can_state_t state, 
 				     char* name, int max_len)
 {
     if (state >= CAN_STATE_ACTIVE && 
-	state <= CAN_STATE_SCANNING_BAUDRATE)
+	state <= CAN_STATE_SLEEPING)
 	strncpy(name, rtcan_state_names[state], max_len);
     else
 	strncpy(name, "unknown", max_len);
Index: ksrc/drivers/can/mscan/rtcan_mscan.c
===================================================================
--- ksrc/drivers/can/mscan/rtcan_mscan.c	(revision 1695)
+++ ksrc/drivers/can/mscan/rtcan_mscan.c	(working copy)
@@ -37,6 +37,7 @@
 #include <rtdm/rtcan.h>
 #include "rtcan_dev.h"
 #include "rtcan_raw.h"
+#include "rtcan_internal.h"
 #include "rtcan_mscan_regs.h"
 
 extern int rtcan_mscan_create_proc(struct rtcan_device* dev);
@@ -56,7 +57,7 @@
 
 /** Module parameter for the CAN controllers' */
 
-static int port[RTCAN_MSCAN_DEVS] = {
+int port[RTCAN_MSCAN_DEVS] = {
 #ifdef CONFIG_XENO_DRIVERS_RTCAN_MSCAN_1
 #ifdef CONFIG_XENO_DRIVERS_RTCAN_MSCAN_2
 	1, 2  /* Enable CAN 1 and 2 */
@@ -71,22 +72,20 @@
 #endif
 #endif
 };
-
-static int port_count = RTCAN_MSCAN_DEVS;
-
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,10)
-module_param_array(port, int, &port_count, 0400);
-#else
-MODULE_PARM(port, "2" __MODULE_STRING(RTCAN_MSCAN_DEVS) "i");
-#endif
+compat_module_int_param_array(port, RTCAN_MSCAN_DEVS);
 MODULE_PARM_DESC(port, "Port numbers of enabled controllers, e.g. 1,2");
 
-unsigned long mscan_clock = CONFIG_XENO_DRIVERS_RTCAN_MSCAN_CLOCK;
-MODULE_PARM(mscan_clock,"i");
+/* 
+ * Note: on the MPC5200 the MSCAN clock source is the IP bus 
+ * clock (IP_CLK) while on the MPC5200B it is the oscillator 
+ * clock (SYS_XTAL_IN).
+ */
+unsigned int mscan_clock = CONFIG_XENO_DRIVERS_RTCAN_MSCAN_CLOCK;
+compat_module_int_param(mscan_clock);
 MODULE_PARM_DESC(mscan_clock, "Clock frequency in Hz");
 
 char *mscan_pins = NULL;
-MODULE_PARM(mscan_pins,"s");
+compat_module_charp_param(mscan_pins);
 MODULE_PARM_DESC(mscan_pins, "Routing to GPIO pins (PSC2 or I2C1/TMR01)");
 
  
@@ -739,7 +738,6 @@
     }
 }
 
-/** Init module */
 int __init rtcan_mscan_init_one(int idx)
 {
     int ret, irq;
@@ -836,7 +834,6 @@
 
 }
 
-/** Init module */
 static int __init rtcan_mscan_init(void)
 {
     int i, ret;
@@ -854,14 +851,12 @@
     return 0;
 }
 
-
-/** Cleanup module */
 static void __exit rtcan_mscan_exit(void)
 {
     int i;
     struct rtcan_device *dev;
 
-    for (i = 0; i < port_count; i++) {
+    for (i = 0; i < RTCAN_MSCAN_DEVS; i++) {
 	if ((dev = rtcan_mscan_devs[i]) == NULL)
 	    continue;
 	
Index: ksrc/drivers/can/mscan/rtcan_mscan_regs.h
===================================================================
--- ksrc/drivers/can/mscan/rtcan_mscan_regs.h	(revision 1695)
+++ ksrc/drivers/can/mscan/rtcan_mscan_regs.h	(working copy)
@@ -35,7 +35,7 @@
 #define MSCAN_MBAR	MPC52xx_MBAR
 #define MSCAN_CAN1_IRQ	MPC52xx_MSCAN1_IRQ
 #define MSCAN_CAN2_IRQ	MPC52xx_MSCAN2_IRQ
-#define MPC5xxx_GPIO	MPC52xx_GPIO_OFFSET 
+#define MPC5xxx_GPIO	MPC52xx_VA(MPC52xx_GPIO_OFFSET) 
 #define mpc5xxx_gpio	mpc52xx_gpio
 #endif
 

--------------000705080307070306030103--

