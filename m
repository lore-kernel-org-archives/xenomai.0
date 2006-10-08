Message-ID: <4528B83D.2020803@domain.hid>
Date: Sun, 08 Oct 2006 10:35:09 +0200
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] rtcan_mscan compilation.
References: <ac3922a00610060437i4735bf7at85ca11beb12ab1be@domain.hid>
	<4526B48F.50705@domain.hid> <452767E0.3050107@domain.hid>
	<4527B59B.1030109@domain.hid> <4527E457.705@domain.hid>
In-Reply-To: <4527E457.705@domain.hid>
Content-Type: multipart/mixed; boundary="------------030708080603020108080903"
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>

This is a multi-part message in MIME format.
--------------030708080603020108080903
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Ji Jan,

Jan Kiszka wrote:
> Wolfgang Grandegger wrote:
>> Jan Kiszka wrote:
>>> Wolfgang Grandegger wrote:
>>>> ...
>>>> Index: ksrc/drivers/can/rtcan_internal.h
>>>> ===================================================================
>>>> --- ksrc/drivers/can/rtcan_internal.h    (revision 1695)
>>>> +++ ksrc/drivers/can/rtcan_internal.h    (working copy)
>>>> @@ -111,6 +111,10 @@
>>>>  
>>>>  #ifndef compat_module_int_param_array
>>>>  #if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,10)
>>>> +# define compat_module_int_param(name) \
>>>> +    MODULE_PARM(name, "i")
>>>> +# define compat_module_charp_param(name) \
>>>> +    MODULE_PARM(name, "s")
>>>>  # define compat_module_byte_param_array(name, count) \
>>>>      MODULE_PARM(name, "1-" __MODULE_STRING(count) "b")
>>>>  # define compat_module_short_param_array(name, count) \
>>>> @@ -118,6 +122,10 @@
>>>>  # define compat_module_int_param_array(name, count) \
>>>>      MODULE_PARM(name, "1-" __MODULE_STRING(count) "i")
>>>>  #else
>>>> +# define compat_module_int_param(name) \
>>>> +    module_param(name, int, 0444)
>>>> +# define compat_module_charp_param(name) \
>>>> +    module_param(name, charp, 0444)
>>>>  # define compat_module_byte_param_array(name, count) \
>>>>      module_param_array(name, byte, NULL, 0444)
>>>>  # define compat_module_short_param_array(name, count) \
>>> No need, module_param comes even with 2.4. We only need wrapping for
>>> parameter arrays (due to different semantics of the macro arguments).
>> But with limitations, unfortunately:
>>
>>   /* type is byte, short, ushort, int, uint, long, ulong, bool. (2.6
>>      has more, but they are not supported).  perm is permissions when
>>      it appears in sysfs: 0 means doens't appear, 0444 means read-only
>>      by everyone, 0644 means changable dynamically by root, etc.  name
>>      must be in scope (unlike MODULE_PARM).
>>   */
>>   #define module_param(name, type, perm) \
>>         static inline void *__check_existence_##name(void) { return
>>              &name; } \
>>         MODULE_PARM(name, _MODULE_PARM_STRING_ ## type)
>>
>>   #define _MODULE_PARM_STRING_byte "b"
>>   #define _MODULE_PARM_STRING_short "h"
>>   #define _MODULE_PARM_STRING_ushort "h"
>>   #define _MODULE_PARM_STRING_int "i"
>>   #define _MODULE_PARM_STRING_uint "i"
>>   #define _MODULE_PARM_STRING_long "l"
>>   #define _MODULE_PARM_STRING_ulong "l"
>>   #define _MODULE_PARM_STRING_bool "i"
>>
>> Especially "s" is missing. But it could be wrapped with:
>>
>>   #define _MODULE_PARM_STRING_charp "s"
>>
>> Any idea why this is not already done?
> 
> Likely because you mostly don't need it? I think mscan is an exception
> here, at least from my experience.

Well, a "find . -name '*.c'|xargs grep charp|grep module" reveals plenty 
of references. And in 2.6 there is "module_param_string* as well, which 
will copy the string directly into the preallocated array.

> When _MODULE_PARM_STRING_charp helps to enhance module_param on 2.4,
> lets put it in Xenomai's wrapping header. I think we should also move
> the parameter array over (directing it officially through the RTDM layer
> can still be done later, at the latest when providing user-space
> support). I would support a patch doing this as well.

With the proposed modifications almost all module parameter use cases 
can be handled in a portable way, including strings and arrays of 
strings. I have moved it to the Xenomai's wrapping header file, 
including compat_module_param_array ...

>> I also want to replace the compat_module_*_param_array functions with
>> the attached code snippet.
> 
> Ok, I'm awaiting a revised patch.

... and updated the ISA and MEM driver as well in the attached revised 
patch.

Wolfgang.



--------------030708080603020108080903
Content-Type: text/x-patch;
 name="xenomai-rtcan-mscan-2.6-2.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="xenomai-rtcan-mscan-2.6-2.patch"

Index: include/asm-generic/wrappers.h
===================================================================
--- include/asm-generic/wrappers.h	(revision 1695)
+++ include/asm-generic/wrappers.h	(working copy)
@@ -46,6 +46,10 @@
 #endif
 
 #define module_param_named(name,var,type,mode)  module_param(var,type,mode)
+#define _MODULE_PARM_STRING_charp "s"
+#define compat_module_param_array(name, type, count, perm) \
+	static inline void *__check_existence_##name(void) { return &name; } \
+	MODULE_PARM(name, "1-" __MODULE_STRING(count) _MODULE_PARM_STRING_##type)
 
 #define container_of(ptr, type, member) ({			\
 	const typeof( ((type *)0)->member ) *__mptr = (ptr);	\
@@ -176,6 +180,9 @@
 
 #else /* LINUX_VERSION_CODE >= KERNEL_VERSION(2,5,0) */
 
+#define compat_module_param_array(name, type, count, perm) \
+	module_param_array(name, type, NULL, perm)
+
 /* VM */
 
 #ifdef CONFIG_MMU
Index: ChangeLog
===================================================================
--- ChangeLog	(revision 1695)
+++ ChangeLog	(working copy)
@@ -1,3 +1,24 @@
+2006-10-08  Wolfgang Grandegger  <wg@domain.hid>
+
+	* include/asm-generic/wrappers.h: MODULE_PARM has been removed
+	in Linux 2.6.17. Module parameter compatibility functions 
+	reimplemented and moved to Xenomai's wrapping header. 
+	
+	* ksrc/drivers/can/mscan/rtcan_mscan.c, 
+	ksrc/drivers/can/sja1000/rtcan_isa.c,
+	ksrc/drivers/can/sja1000/rtcan_mem.c: Use new module parameter 
+	compatibility functions. 	
+	
+	* ksrc/drivers/can/mscan/rtcan_mscan.c (rtcan_mscan_init): Error 
+	handling corrected.
+
+	* ksrc/drivers/can/mscan/rtcan_mscan_regs.h: Fix invalid address
+	for MPC5200 GPIO registers. Now the MSCAN driver works for Linux
+	2.6.17.
+
+	* ksrc/drivers/can/rtcan_module.c (rtcan_dev_get_state_name): Bug
+	fix. Function did return invalid state name.
+
 2006-10-06  Jan Kiszka  <jan.kiszka@domain.hid>
 
 	* src/testsuite/cyclic/cyclictest.c: Align to latest v0.11,
Index: ksrc/drivers/can/rtcan_internal.h
===================================================================
--- ksrc/drivers/can/rtcan_internal.h	(revision 1695)
+++ ksrc/drivers/can/rtcan_internal.h	(working copy)
@@ -108,25 +108,6 @@
 
 #endif /* CONFIG_PROC_FS */
 
-
-#ifndef compat_module_int_param_array
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,10)
-# define compat_module_byte_param_array(name, count) \
-    MODULE_PARM(name, "1-" __MODULE_STRING(count) "b")
-# define compat_module_short_param_array(name, count) \
-    MODULE_PARM(name, "1-" __MODULE_STRING(count) "h")
-# define compat_module_int_param_array(name, count) \
-    MODULE_PARM(name, "1-" __MODULE_STRING(count) "i")
-#else
-# define compat_module_byte_param_array(name, count) \
-    module_param_array(name, byte, NULL, 0444)
-# define compat_module_short_param_array(name, count) \
-    module_param_array(name, short, NULL, 0444)
-# define compat_module_int_param_array(name, count) \
-    module_param_array(name, int, NULL, 0444)
-#endif
-#endif
-
 #ifdef CONFIG_XENO_DRIVERS_RTCAN_DEBUG
 # define RTCAN_DBG(fmt,args...) do { printk(fmt ,##args); } while (0)
 # define RTCAN_RTDM_DBG(fmt,args...) do { rtdm_printk(fmt ,##args); } while (0)
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
@@ -71,24 +72,21 @@
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
+compat_module_param_array(port, int, RTCAN_MSCAN_DEVS, 0444);
 MODULE_PARM_DESC(port, "Port numbers of enabled controllers, e.g. 1,2");
 
-unsigned long mscan_clock = CONFIG_XENO_DRIVERS_RTCAN_MSCAN_CLOCK;
-MODULE_PARM(mscan_clock,"i");
+/* 
+ * Note: on the MPC5200 the MSCAN clock source is the IP bus 
+ * clock (IP_CLK) while on the MPC5200B it is the oscillator 
+ * clock (SYS_XTAL_IN).
+ */
+unsigned int mscan_clock = CONFIG_XENO_DRIVERS_RTCAN_MSCAN_CLOCK;
+module_param(mscan_clock, int, 0444);
 MODULE_PARM_DESC(mscan_clock, "Clock frequency in Hz");
 
 char *mscan_pins = NULL;
-MODULE_PARM(mscan_pins,"s");
+module_param(mscan_pins, charp, 0444);
 MODULE_PARM_DESC(mscan_pins, "Routing to GPIO pins (PSC2 or I2C1/TMR01)");
-
  
 struct rtcan_device *rtcan_mscan_devs[RTCAN_MSCAN_DEVS];
 
@@ -739,7 +737,6 @@
     }
 }
 
-/** Init module */
 int __init rtcan_mscan_init_one(int idx)
 {
     int ret, irq;
@@ -836,32 +833,13 @@
 
 }
 
-/** Init module */
-static int __init rtcan_mscan_init(void)
-{
-    int i, ret;
-
-    mscan_gpio_config();
-
-    for (i = 0; i < RTCAN_MSCAN_DEVS; i++) {
-	if (port[i] < 1 || port[i] > RTCAN_MSCAN_DEVS)
-	    continue;
-
-	if ((ret = rtcan_mscan_init_one(i) != 0))
-	    return ret;
-    }
-
-    return 0;
-}
-
-
-/** Cleanup module */
 static void __exit rtcan_mscan_exit(void)
 {
     int i;
     struct rtcan_device *dev;
 
-    for (i = 0; i < port_count; i++) {
+    for (i = 0; i < RTCAN_MSCAN_DEVS; i++) {
+
 	if ((dev = rtcan_mscan_devs[i]) == NULL)
 	    continue;
 	
@@ -876,5 +854,24 @@
 
 }
 
+static int __init rtcan_mscan_init(void)
+{
+    int i, err;
+
+    mscan_gpio_config();
+
+    for (i = 0; i < RTCAN_MSCAN_DEVS; i++) {
+	if (port[i] < 1 || port[i] > RTCAN_MSCAN_DEVS)
+	    continue;
+
+	if ((err = rtcan_mscan_init_one(i) != 0)) {
+	    rtcan_mscan_exit();
+	    return err;
+	}
+    }
+
+    return 0;
+}
+
 module_init(rtcan_mscan_init);
 module_exit(rtcan_mscan_exit);
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
 
Index: ksrc/drivers/can/sja1000/rtcan_peak_dng.c
===================================================================
--- ksrc/drivers/can/sja1000/rtcan_peak_dng.c	(revision 1695)
+++ ksrc/drivers/can/sja1000/rtcan_peak_dng.c	(working copy)
@@ -50,15 +50,9 @@
 static ushort io[RTCAN_PEAK_DNG_MAX_DEV];
 static char   irq[RTCAN_PEAK_DNG_MAX_DEV];
 
-#if LINUX_VERSION_CODE > KERNEL_VERSION(2,6,10)
-module_param_array(type, charp,  NULL, 0444);
-module_param_array(io,   ushort, NULL, 0444);
-module_param_array(irq,  byte,   NULL, 0444);
-#else
-MODULE_PARM(type, "0-" __MODULE_STRING(RTCAN_PEAK_DNG_MAX_DEV) "s");
-MODULE_PARM(io,   "0-" __MODULE_STRING(RTCAN_PEAK_DNG_MAX_DEV) "h");
-MODULE_PARM(irq,  "0-" __MODULE_STRING(RTCAN_PEAK_DNG_MAX_DEV) "b");
-#endif
+compat_module_param_array(type, charp,  RTCAN_PEAK_DNG_MAX_DEV, 0444);
+compat_module_param_array(io,   ushort, RTCAN_PEAK_DNG_MAX_DEV, 0444);
+compat_module_param_array(irq,  byte,   RTCAN_PEAK_DNG_MAX_DEV, 0444);
 
 MODULE_PARM_DESC(type, "The type of interface (sp, epp)");
 MODULE_PARM_DESC(io,   "The io-port address");
Index: ksrc/drivers/can/sja1000/rtcan_isa.c
===================================================================
--- ksrc/drivers/can/sja1000/rtcan_isa.c	(revision 1695)
+++ ksrc/drivers/can/sja1000/rtcan_isa.c	(working copy)
@@ -51,11 +51,11 @@
 static u8 ocr[RTCAN_ISA_MAX_DEV];
 static u8 cdr[RTCAN_ISA_MAX_DEV];
 
-compat_module_short_param_array(io, RTCAN_ISA_MAX_DEV);
-compat_module_int_param_array(irq, RTCAN_ISA_MAX_DEV);
-compat_module_int_param_array(clock, RTCAN_ISA_MAX_DEV);
-compat_module_byte_param_array(ocr, RTCAN_ISA_MAX_DEV);
-compat_module_byte_param_array(cdr, RTCAN_ISA_MAX_DEV);
+compat_module_param_array(io, ushort, RTCAN_ISA_MAX_DEV, 0444);
+compat_module_param_array(irq, int, RTCAN_ISA_MAX_DEV, 0444);
+compat_module_param_array(clock, uint, RTCAN_ISA_MAX_DEV, 0444);
+compat_module_param_array(ocr, byte, RTCAN_ISA_MAX_DEV, 0444);
+compat_module_param_array(cdr, byte, RTCAN_ISA_MAX_DEV, 0444);
 
 MODULE_PARM_DESC(io, "The io-port address");
 MODULE_PARM_DESC(irq, "The interrupt number");
Index: ksrc/drivers/can/sja1000/rtcan_mem.c
===================================================================
--- ksrc/drivers/can/sja1000/rtcan_mem.c	(revision 1695)
+++ ksrc/drivers/can/sja1000/rtcan_mem.c	(working copy)
@@ -59,11 +59,11 @@
 static u8 ocr[RTCAN_MEM_MAX_DEV];
 static u8 cdr[RTCAN_MEM_MAX_DEV];
 
-compat_module_int_param_array(mem, RTCAN_MEM_MAX_DEV);
-compat_module_int_param_array(irq, RTCAN_MEM_MAX_DEV);
-compat_module_int_param_array(clock, RTCAN_MEM_MAX_DEV);
-compat_module_byte_param_array(ocr, RTCAN_MEM_MAX_DEV);
-compat_module_byte_param_array(cdr, RTCAN_MEM_MAX_DEV);
+compat_module_param_array(mem, uint, RTCAN_MEM_MAX_DEV, 0444);
+compat_module_param_array(irq, int, RTCAN_MEM_MAX_DEV, 0444);
+compat_module_param_array(clock, uint, RTCAN_MEM_MAX_DEV, 0444);
+compat_module_param_array(ocr, byte, RTCAN_MEM_MAX_DEV, 0444);
+compat_module_param_array(cdr, byte, RTCAN_MEM_MAX_DEV, 0444);
 
 MODULE_PARM_DESC(mem, "The io-memory address");
 MODULE_PARM_DESC(irq, "The interrupt number");

--------------030708080603020108080903--

