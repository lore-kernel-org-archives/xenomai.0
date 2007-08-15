Message-ID: <46C3269F.8070408@domain.hid>
Date: Wed, 15 Aug 2007 18:15:27 +0200
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
References: <469E10D5.8000602@domain.hid> <469E6349.5000209@domain.hid>
In-Reply-To: <469E6349.5000209@domain.hid>
Content-Type: multipart/mixed; boundary="------------020203030008050603030907"
Subject: Re: [Xenomai-core] Problems with compat_module_param_array() with
 Linux	2.4
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

This is a multi-part message in MIME format.
--------------020203030008050603030907
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Jan Kiszka wrote:
> Wolfgang Grandegger wrote:
>> Hello,
>>
>> yesterday I realized a problem with compat_module_param_array() with
>> ksrc/drivers/can/sja1000/rtcan_mem.c under Linux 2.4. It uses
>> CONFIG_XENO_DRIVERS_CAN_SJA1000_MEM_MAX_DEV to define the number of mem
>> devices, which is set to '(4)' by "make [menuc]onfig". Unfortunately, 
>> the brackets '()' break compat_module_param_array() because it treats 
>> the count as string:
>>
>> #define compat_module_param_array(name, type, count, perm) \
>>          static inline void *__check_existence_##name(void) { return
>> &name; } \
>>          MODULE_PARM(name, "1-" __MODULE_STRING(count)
>> _MODULE_PARM_STRING_##type)
>>
>> Any idea how to fix that? I actually tend to remove the configuration 
>> option CONFIG_XENO_DRIVERS_CAN_SJA1000_MEM_MAX_DEV and hardcode it to 
>> "4" (without brackets) in the driver. It's kind of overkill, anyhow.
> 
> I would say that this problem is not "with compat_module_param_array",
> but about the Kconfig-based constant. I don't see a way to make the
> module parameter array size configurable even under vanilla 2.4. Simply
> go for a patchable constant in the source code like other drivers do.

The attached patch fixes the problem:

2007-08-15  Wolfgang Grandegger  <wg@domain.hid>

         * ksrc/drivers/can/sja1000/Kconfig,
         ksrc/drivers/can/sja1000/{rtcan_isa.c,rtcan_mem.c}: Remove config
         options XENO_DRIVERS_CAN_SJA1000_*_MAX_DEV to avoid problems with
         defining module parameters with Linux 2.4.

If nobody complains, I'm going to apply it to the trunk and the v2.3.x 
branch.

Wolfgang.


--------------020203030008050603030907
Content-Type: text/x-patch;
 name="xenomai-rtcan-dev-max.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="xenomai-rtcan-dev-max.patch"

Index: ChangeLog
===================================================================
--- ChangeLog	(revision 2922)
+++ ChangeLog	(working copy)
@@ -1,3 +1,10 @@
+2007-08-15  Wolfgang Grandegger  <wg@domain.hid>
+
+	* ksrc/drivers/can/sja1000/Kconfig,
+	ksrc/drivers/can/sja1000/{rtcan_isa.c,rtcan_mem.c}: Remove config
+	options XENO_DRIVERS_CAN_SJA1000_*_MAX_DEV to avoid problems with
+	defining module parameters with Linux 2.4.
+
 2007-08-14  Jan Kiszka  <jan.kiszka@domain.hid>
 
 	* ksrc/skins/rtdm/*, include/rtdm/*: Lindention and several sparse
Index: ksrc/drivers/can/sja1000/Kconfig
===================================================================
--- ksrc/drivers/can/sja1000/Kconfig	(revision 2922)
+++ ksrc/drivers/can/sja1000/Kconfig	(working copy)
@@ -12,11 +12,6 @@ config XENO_DRIVERS_CAN_SJA1000_ISA
 	or a PC/104 system. The I/O port, interrupt number and a few other
 	hardware specific parameters can be defined via module parameters.
 
-config XENO_DRIVERS_CAN_SJA1000_ISA_MAX_DEV
-	depends on XENO_DRIVERS_CAN_SJA1000_ISA
-	int "Maximum number of controllers"
-	default 4
-
 config XENO_DRIVERS_CAN_SJA1000_MEM
 	depends on XENO_DRIVERS_CAN_SJA1000
 	tristate "Memory mapped controllers"
@@ -26,11 +21,6 @@ config XENO_DRIVERS_CAN_SJA1000_MEM
 	interrupt number and a few other hardware specific parameters can
 	be defined via module parameters.
 
-config XENO_DRIVERS_CAN_SJA1000_MEM_MAX_DEV
-	depends on XENO_DRIVERS_CAN_SJA1000_MEM
-	int "Maximum number of controllers"
-	default 4
-
 config XENO_DRIVERS_CAN_SJA1000_PEAK_PCI
 	depends on XENO_DRIVERS_CAN_SJA1000
 	tristate "PEAK PCI Card"
Index: ksrc/drivers/can/sja1000/rtcan_isa.c
===================================================================
--- ksrc/drivers/can/sja1000/rtcan_isa.c	(revision 2922)
+++ ksrc/drivers/can/sja1000/rtcan_isa.c	(working copy)
@@ -36,7 +36,7 @@
 #define RTCAN_DEV_NAME    "rtcan%d"
 #define RTCAN_DRV_NAME    "sja1000-isa"
 
-#define RTCAN_ISA_MAX_DEV CONFIG_XENO_DRIVERS_CAN_SJA1000_ISA_MAX_DEV
+#define RTCAN_ISA_MAX_DEV 4
 
 static char *isa_board_name = "ISA-Board";
 
Index: ksrc/drivers/can/sja1000/rtcan_mem.c
===================================================================
--- ksrc/drivers/can/sja1000/rtcan_mem.c	(revision 2922)
+++ ksrc/drivers/can/sja1000/rtcan_mem.c	(working copy)
@@ -44,7 +44,7 @@
 #define RTCAN_DEV_NAME    "rtcan%d"
 #define RTCAN_DRV_NAME    "sja1000-mem"
 
-#define RTCAN_MEM_MAX_DEV CONFIG_XENO_DRIVERS_CAN_SJA1000_MEM_MAX_DEV
+#define RTCAN_MEM_MAX_DEV 4
 
 static char *mem_board_name = "mem mapped";
 
Index: ksrc/drivers/can/sja1000/Config.in
===================================================================
--- ksrc/drivers/can/sja1000/Config.in	(revision 2922)
+++ ksrc/drivers/can/sja1000/Config.in	(working copy)
@@ -9,14 +9,8 @@ if [ "$CONFIG_XENO_DRIVERS_CAN_SJA1000" 
 fi
 
 dep_tristate '  Standard ISA controllers' CONFIG_XENO_DRIVERS_CAN_SJA1000_ISA $CONFIG_XENO_DRIVERS_CAN_SJA1000
-if [ "$CONFIG_XENO_DRIVERS_CAN_SJA1000_ISA" != "n" ]; then
-	int '    Maximum number of controllers' CONFIG_XENO_DRIVERS_CAN_SJA1000_ISA_MAX_DEV 4
-fi
 
 dep_tristate '  Memory mapped controllers' CONFIG_XENO_DRIVERS_CAN_SJA1000_MEM $CONFIG_XENO_DRIVERS_CAN_SJA1000
-if [ "$CONFIG_XENO_DRIVERS_CAN_SJA1000_MEM" != "n" ]; then
-	int '    Maximum number of controllers' CONFIG_XENO_DRIVERS_CAN_SJA1000_MEM_MAX_DEV 4
-fi
 
 if [ "$CONFIG_PCI" = "y" ]; then
 	dep_tristate '  PEAK PCI cards' CONFIG_XENO_DRIVERS_CAN_SJA1000_PEAK_PCI $CONFIG_XENO_DRIVERS_CAN_SJA1000

--------------020203030008050603030907--

