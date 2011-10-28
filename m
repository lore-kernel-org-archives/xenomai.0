From: Manfred <manfred@domain.hid>
Date: Fri, 28 Oct 2011 14:14:51 +0000 (UTC)
Message-ID: <loom.20111028T160712-174@domain.hid>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] twl4030-irq takes 50%cpu constantly on omap3 gumstix
	overo
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

Dear xenomai-users/developers,

I am currently working with an omap3530 based gumstix overo(fire), and I am
trying to get xenomai running on this platform.
I found quite detailed instructions on this page
(http://www.lara.unb.br/wiki/index.php/Overo_Xenomai)
and after some adaptations (details, see below) was able to get the system to
boot from an SD card, to compile and run the "trivial-periodic" example. 
I am working with kernel linux-omap3-2.6.33 and xenomai 2.5.3 and I checked out
the bitbake recipes from the gumstix-org, overo branch (I could not find the old 
kernel recipes in the overo-2011.3 branch)

However, I do have the following problem:
when I look at the running processes using "top" , i see that a system process
called twl4030-irq is taking 50% of the cpu constantly. This happens when I
connect through the usb-serial port, as well as connecting through ssh (over the
built-in wireless, which probably also depends on the twl4030 routines).

Q1) Is this normal behaviour? (i.e. does xenomai handle these irqs "in software"
and reserves 50% of the cpu for that?) Is there a way to reduce this load
somehow?

Q2) Assuming that it is not normal behaviour, has anyone had already the same
issue?

What I have tried is to disable more twl4030-related modules in the menuconfig
step. However, either it has no effect (still twl4030-irq takes 50% cpu) or then 
he system stopped already at boot-up time.
I then realized that twl4030-irq must be a pretty essential part, since also
twl4030-core is depending on it:
./drivers/mfd/Makefile:29:obj-$(CONFIG_TWL4030_CORE)
  += twl-core.o twl4030-irq.o twl6030-irq.o

So, I assume there is no workaround, based on disabling twl4030-related
kernelmodules (such as SND_SOC_TWL4030 etc.)

Q3) Am I correct in this assumption, or could it still be, that some of the
other drivers are actually "triggering" the twl4030-irq process 
to run continuously?


Looking at the twl4030-irq.c source file, 
I find some "FIX_ME" statements like this:
778 /* FIXME pass in which interrupt line we'll use ... */
779 #define twl_irq_line    0
(http://lxr.free-electrons.com/source/drivers/mfd/twl4030-irq.c?v=2.6.33;a=arm)

Q4) Do I need to be concerned about this? Does it mean, that the twl4030 chipset
is not fully supported yet by the linux kernel drivers? Do I need to make
adaptations  directly into the source  code to get this working?

Q5) Are there any debugging/system tools in xenomai which could help me in
finding out what causes twl4030-irq to be spending that many cpu-cycles?
Attaching with gdb or killing with kill -9 does not work. (using gdb, I get a
error message from ptrace, and just no reaction from kill)


At the end of this message you find a detailed description of how I came to the
current setup, for reference. In case any further information is needed, please
let me know.
By the way, without the xenomai-patch, the standard omap3-2.6.33 kernel does not
have the twl4030-irq process running at 50%. So the problem seems to be either
related to the xenomai-patch or to the other changes that were necessary to make
it run.

Any help with this would be highly appreciated.

Regards,
Manfred

More System Information:
-------------------------
Attachment (1): output related to xenomai and twl4030 in dmesg:
-----------------
ARMv7 Processor [411fc083] revision 3 (ARMv7)
[..]
I-pipe 1.16-01: pipeline enabled
[...]
twl4030: PIH (irq 7) chaining IRQs 368..375
twl4030: power (irq 373) chaining IRQs 376..383
[..]
twl4030: gpio (irq 368) chaining IRQs 384..401
twl4030_usb twl4030_usb: Initialized TWL4030 USB module
[..]
I-pipe: Domain Xenomai registered.
Xenomai: hal/arm started.
Xenomai: scheduling class idle registered.
Xenomai: scheduling class rt registered.
Xenomai: real-time nucleus v2.5.3 (Hordes Of Locusts) loaded.
Xenomai: starting native API services.
Xenomai: starting POSIX services.
Xenomai: starting RTDM services.
[..]
asoc: twl4030 <-> omap-mcbsp-dai-0 mapping ok



Attachment (2): detailed description, how i got to the current setup:
----------------
I have to mention, that I am just getting started with xenomai.For completeness
here are more or less the adaptations that I needed to make to get xenomai
running so far: (it might very well be, that some steps are not necc. but I
did/do not have time to traverse through the decision tree again)
1.) checkout recipes from overo branch (not overo-2011.3): 
(following guidelines here:
http://www.gumstix.org/software-development/open-embedded/
61-using-the-open-embedded-build-system.html )
git clone git://gitorious.org/gumstix-oe/mainline.git org.openembedded.dev
cd org.openembedded.dev
git checkout --track -b overo-2011.03 origin/overo

2.) starting from the standard config files for gumstix:
cp -r org.openembedded.dev/contrib/gumstix/build .
adapting build/conf/local.conf:
BB_NUMBER_THREADS = "16"
PARALLEL_MAKE = "-j 4"
PREFERRED_VERSION_linux-omap3 = "2.6.33"
#disable manpages *for opensp/openjade issue* in overo-branch:
EXTRA_OECONF = " --disable-man-pages --disable-gtk-doc-html "

then touch build/conf/sanity.conf
(I am using /bin/dash and cannot change it *don't have root-access on the
development machine*)

3.) build a standard image:
bitbake -v -k omap3-console-image 2>&1 | tee Bitbaking-omap3-console.log
fix any problems by adapting the corresponding recipes

4.) get the user.collection with the corresponding recipes for xenomai
from here:
http://www.lara.unb.br/wiki/index.php/Overo_Xenomai

5.) run bitbake on the omap3-2.6.33 kernel up to the menuconfig step,
disable usb-gadgets driver and one of the watchdogs (omap or twl4030)
copy the modified .config file from /tmp/work.. to the coresponding
user.collection folder
clean and bitbake omap3-2.6.33
bitbake gumstixwithxenomai (adapted recipe adding the xenomai-userside)

6.) boot from SD card.


Attachment (3): Kernel Config File information:
----------------
A diff of the .config file from the standard omap3-2.6.33 config file (from the
git repository/ overo-branch), with the one I used:
--- defconfig-original-opemb	2011-10-21 11:42:34.000000000 +0200
+++ defconfig.xenomai	2011-10-28 15:37:25.000000000 +0200
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
 # Linux kernel version: 2.6.33
-# Wed Mar 24 06:13:38 2010
+# Tue Oct 25 22:37:04 2011
 #
 CONFIG_ARM=y
 CONFIG_SYS_SUPPORTS_APM_EMULATION=y
@@ -102,7 +102,6 @@
 #
 CONFIG_PERF_EVENTS=y
 # CONFIG_PERF_COUNTERS is not set
-# CONFIG_DEBUG_PERF_USE_VMALLOC is not set
 CONFIG_VM_EVENT_COUNTERS=y
 # CONFIG_COMPAT_BRK is not set
 CONFIG_SLAB=y
@@ -175,6 +174,120 @@
 CONFIG_INLINE_WRITE_UNLOCK_IRQ=y
 # CONFIG_INLINE_WRITE_UNLOCK_IRQRESTORE is not set
 # CONFIG_MUTEX_SPIN_ON_OWNER is not set
+
+#
+# Real-time sub-system
+#
+CONFIG_XENOMAI=y
+CONFIG_XENO_GENERIC_STACKPOOL=y
+CONFIG_XENO_FASTSYNCH_DEP=y
+CONFIG_XENO_FASTSYNCH=y
+CONFIG_XENO_OPT_NUCLEUS=y
+CONFIG_XENO_OPT_PERVASIVE=y
+CONFIG_XENO_OPT_PRIOCPL=y
+CONFIG_XENO_OPT_PIPELINE_HEAD=y
+# CONFIG_XENO_OPT_SCHED_CLASSES is not set
+CONFIG_XENO_OPT_PIPE=y
+CONFIG_XENO_OPT_PIPE_NRDEV=32
+CONFIG_XENO_OPT_REGISTRY_NRSLOTS=512
+CONFIG_XENO_OPT_SYS_HEAPSZ=256
+CONFIG_XENO_OPT_SYS_STACKPOOLSZ=128
+CONFIG_XENO_OPT_SEM_HEAPSZ=12
+CONFIG_XENO_OPT_GLOBAL_SEM_HEAPSZ=12
+CONFIG_XENO_OPT_STATS=y
+# CONFIG_XENO_OPT_DEBUG is not set
+# CONFIG_XENO_OPT_SHIRQ is not set
+
+#
+# Timing
+#
+# CONFIG_XENO_OPT_TIMING_PERIODIC is not set
+CONFIG_XENO_OPT_TIMING_VIRTICK=1000
+CONFIG_XENO_OPT_TIMING_SCHEDLAT=0
+
+#
+# Scalability
+#
+# CONFIG_XENO_OPT_SCALABLE_SCHED is not set
+CONFIG_XENO_OPT_TIMER_LIST=y
+# CONFIG_XENO_OPT_TIMER_HEAP is not set
+# CONFIG_XENO_OPT_TIMER_WHEEL is not set
+
+#
+# Machine
+#
+CONFIG_IPIPE_WANT_PREEMPTIBLE_SWITCH=y
+CONFIG_XENO_HW_FPU=y
+CONFIG_XENO_HW_UNLOCKED_SWITCH=y
+
+#
+# Interfaces
+#
+CONFIG_XENO_SKIN_NATIVE=y
+CONFIG_XENO_OPT_NATIVE_PERIOD=0
+CONFIG_XENO_OPT_NATIVE_PIPE=y
+CONFIG_XENO_OPT_NATIVE_PIPE_BUFSZ=1024
+CONFIG_XENO_OPT_NATIVE_SEM=y
+CONFIG_XENO_OPT_NATIVE_EVENT=y
+CONFIG_XENO_OPT_NATIVE_MUTEX=y
+CONFIG_XENO_OPT_NATIVE_COND=y
+CONFIG_XENO_OPT_NATIVE_QUEUE=y
+CONFIG_XENO_OPT_NATIVE_BUFFER=y
+CONFIG_XENO_OPT_NATIVE_HEAP=y
+CONFIG_XENO_OPT_NATIVE_ALARM=y
+CONFIG_XENO_OPT_NATIVE_MPS=y
+# CONFIG_XENO_OPT_NATIVE_INTR is not set
+CONFIG_XENO_SKIN_POSIX=y
+CONFIG_XENO_OPT_POSIX_PERIOD=0
+# CONFIG_XENO_OPT_POSIX_SHM is not set
+# CONFIG_XENO_OPT_POSIX_INTR is not set
+# CONFIG_XENO_OPT_POSIX_SELECT is not set
+# CONFIG_XENO_OPT_DEBUG_POSIX is not set
+# CONFIG_XENO_SKIN_PSOS is not set
+# CONFIG_XENO_SKIN_UITRON is not set
+# CONFIG_XENO_SKIN_VRTX is not set
+# CONFIG_XENO_SKIN_VXWORKS is not set
+# CONFIG_XENO_SKIN_RTAI is not set
+# CONFIG_XENO_OPT_NOWARN_DEPRECATED is not set
+CONFIG_XENO_SKIN_RTDM=y
+CONFIG_XENO_OPT_RTDM_PERIOD=0
+CONFIG_XENO_OPT_RTDM_FILDES=128
+# CONFIG_XENO_OPT_RTDM_SELECT is not set
+
+#
+# Drivers
+#
+
+#
+# Serial drivers
+#
+# CONFIG_XENO_DRIVERS_16550A is not set
+
+#
+# Testing drivers
+#
+# CONFIG_XENO_DRIVERS_TESTING_LEGACY_NAMES is not set
+CONFIG_XENO_DRIVERS_TIMERBENCH=y
+# CONFIG_XENO_DRIVERS_KLATENCY is not set
+# CONFIG_XENO_DRIVERS_IRQBENCH is not set
+CONFIG_XENO_DRIVERS_SWITCHTEST=y
+# CONFIG_XENO_DRIVERS_SIGTEST is not set
+# CONFIG_XENO_DRIVERS_RTDMTEST is not set
+
+#
+# CAN drivers
+#
+# CONFIG_XENO_DRIVERS_CAN is not set
+
+#
+# ANALOGY drivers
+#
+# CONFIG_XENO_DRIVERS_ANALOGY is not set
+
+#
+# Real-time IPC drivers
+#
+# CONFIG_XENO_DRIVERS_RTIPC is not set
 CONFIG_FREEZER=y
 
 #
@@ -246,10 +359,9 @@
 # CONFIG_OMAP_MUX is not set
 CONFIG_OMAP_MCBSP=y
 # CONFIG_OMAP_MBOX_FWK is not set
-# CONFIG_OMAP_MPU_TIMER is not set
-CONFIG_OMAP_32K_TIMER=y
+CONFIG_OMAP_MPU_TIMER=y
+# CONFIG_OMAP_32K_TIMER is not set
 # CONFIG_OMAP3_L2_AUX_SECURE_SAVE_RESTORE is not set
-CONFIG_OMAP_32K_TIMER_HZ=128
 CONFIG_OMAP_DM_TIMER=y
 # CONFIG_OMAP_PM_NONE is not set
 CONFIG_OMAP_PM_NOOP=y
@@ -327,10 +439,14 @@
 # CONFIG_VMSPLIT_2G is not set
 # CONFIG_VMSPLIT_1G is not set
 CONFIG_PAGE_OFFSET=0xC0000000
+CONFIG_IPIPE=y
+CONFIG_IPIPE_DOMAINS=4
+CONFIG_IPIPE_DELAYED_ATOMICSW=y
+# CONFIG_IPIPE_UNMASKED_CONTEXT_SWITCH is not set
 CONFIG_PREEMPT_NONE=y
 # CONFIG_PREEMPT_VOLUNTARY is not set
 # CONFIG_PREEMPT is not set
-CONFIG_HZ=128
+CONFIG_HZ=100
 # CONFIG_THUMB2_KERNEL is not set
 CONFIG_AEABI=y
 # CONFIG_OABI_COMPAT is not set
@@ -369,21 +485,7 @@
 #
 # CPU Power Management
 #
-CONFIG_CPU_FREQ=y
-CONFIG_CPU_FREQ_TABLE=y
-CONFIG_CPU_FREQ_DEBUG=y
-CONFIG_CPU_FREQ_STAT=y
-CONFIG_CPU_FREQ_STAT_DETAILS=y
-# CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE is not set
-# CONFIG_CPU_FREQ_DEFAULT_GOV_POWERSAVE is not set
-# CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE is not set
-CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND=y
-# CONFIG_CPU_FREQ_DEFAULT_GOV_CONSERVATIVE is not set
-CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
-CONFIG_CPU_FREQ_GOV_POWERSAVE=y
-CONFIG_CPU_FREQ_GOV_USERSPACE=y
-CONFIG_CPU_FREQ_GOV_ONDEMAND=y
-CONFIG_CPU_FREQ_GOV_CONSERVATIVE=y
+# CONFIG_CPU_FREQ is not set
 # CONFIG_CPU_IDLE is not set
 
 #
@@ -588,8 +690,6 @@
 CONFIG_FW_LOADER=y
 CONFIG_FIRMWARE_IN_KERNEL=y
 CONFIG_EXTRA_FIRMWARE=""
-# CONFIG_DEBUG_DRIVER is not set
-# CONFIG_DEBUG_DEVRES is not set
 # CONFIG_SYS_HYPERVISOR is not set
 # CONFIG_CONNECTOR is not set
 CONFIG_MTD=y
@@ -671,12 +771,6 @@
 # CONFIG_MTD_NAND_PLATFORM is not set
 # CONFIG_MTD_ALAUDA is not set
 # CONFIG_MTD_ONENAND is not set
-# CONFIG_MTD_ONENAND_VERIFY_WRITE is not set
-# CONFIG_MTD_ONENAND_GENERIC is not set
-# CONFIG_MTD_ONENAND_OMAP2 is not set
-# CONFIG_MTD_ONENAND_OTP is not set
-# CONFIG_MTD_ONENAND_2X_PROGRAM is not set
-# CONFIG_MTD_ONENAND_SIM is not set
 
 #
 # LPDDR flash memory drivers
@@ -1103,7 +1197,6 @@
 # CONFIG_I2C_DEBUG_BUS is not set
 # CONFIG_I2C_DEBUG_CHIP is not set
 CONFIG_SPI=y
-# CONFIG_SPI_DEBUG is not set
 CONFIG_SPI_MASTER=y
 
 #
@@ -1127,7 +1220,6 @@
 # CONFIG_PPS is not set
 CONFIG_ARCH_REQUIRE_GPIOLIB=y
 CONFIG_GPIOLIB=y
-CONFIG_DEBUG_GPIO=y
 CONFIG_GPIO_SYSFS=y
 
 #
@@ -1246,7 +1338,7 @@
 #
 # CONFIG_SOFT_WATCHDOG is not set
 CONFIG_OMAP_WATCHDOG=y
-CONFIG_TWL4030_WATCHDOG=y
+# CONFIG_TWL4030_WATCHDOG is not set
 
 #
 # USB-based Watchdog Cards
@@ -1608,6 +1700,7 @@
 CONFIG_PANEL_SAMSUNG_LTE430WQ_F0C=y
 CONFIG_PANEL_SHARP_LS037V7DW01=y
 # CONFIG_PANEL_SHARP_LQ043T1DG01 is not set
+# CONFIG_PANEL_TAAL is not set
 # CONFIG_PANEL_TOPPOLY_TDO35S is not set
 # CONFIG_PANEL_TPO_TD043MTEA1 is not set
 CONFIG_BACKLIGHT_LCD_SUPPORT=y
@@ -1694,7 +1787,6 @@
 CONFIG_SND_OMAP_SOC=y
 CONFIG_SND_OMAP_SOC_MCBSP=y
 CONFIG_SND_OMAP_SOC_OVERO=y
-# CONFIG_SND_OMAP_SOC_OMAP3_BEAGLE is not set
 CONFIG_SND_OMAP_SOC_IGEP0020=y
 CONFIG_SND_SOC_I2C_AND_SPI=y
 # CONFIG_SND_SOC_ALL_CODECS is not set
@@ -1803,7 +1895,6 @@
 CONFIG_USB_MUSB_HOST=y
 # CONFIG_USB_MUSB_PERIPHERAL is not set
 # CONFIG_USB_MUSB_OTG is not set
-# CONFIG_USB_GADGET_MUSB_HDRC is not set
 CONFIG_USB_MUSB_HDRC_HCD=y
 # CONFIG_MUSB_PIO_ONLY is not set
 CONFIG_USB_INVENTRA_DMA=y
@@ -1935,46 +2026,7 @@
 # CONFIG_USB_TEST is not set
 CONFIG_USB_ISIGHTFW=m
 CONFIG_USB_VST=m
-CONFIG_USB_GADGET=y
-# CONFIG_USB_GADGET_DEBUG is not set
-# CONFIG_USB_GADGET_DEBUG_FILES is not set
-# CONFIG_USB_GADGET_DEBUG_FS is not set
-CONFIG_USB_GADGET_VBUS_DRAW=500
-CONFIG_USB_GADGET_SELECTED=y
-# CONFIG_USB_GADGET_AT91 is not set
-# CONFIG_USB_GADGET_ATMEL_USBA is not set
-# CONFIG_USB_GADGET_FSL_USB2 is not set
-# CONFIG_USB_GADGET_LH7A40X is not set
-# CONFIG_USB_GADGET_OMAP is not set
-# CONFIG_USB_GADGET_PXA25X is not set
-# CONFIG_USB_GADGET_R8A66597 is not set
-# CONFIG_USB_GADGET_PXA27X is not set
-# CONFIG_USB_GADGET_S3C_HSOTG is not set
-# CONFIG_USB_GADGET_IMX is not set
-# CONFIG_USB_GADGET_S3C2410 is not set
-# CONFIG_USB_GADGET_M66592 is not set
-# CONFIG_USB_GADGET_AMD5536UDC is not set
-# CONFIG_USB_GADGET_FSL_QE is not set
-# CONFIG_USB_GADGET_CI13XXX is not set
-# CONFIG_USB_GADGET_NET2280 is not set
-# CONFIG_USB_GADGET_GOKU is not set
-# CONFIG_USB_GADGET_LANGWELL is not set
-# CONFIG_USB_GADGET_DUMMY_HCD is not set
-# CONFIG_USB_GADGET_DUALSPEED is not set
-# CONFIG_USB_ZERO is not set
-CONFIG_USB_AUDIO=m
-CONFIG_USB_ETH=m
-CONFIG_USB_ETH_RNDIS=y
-# CONFIG_USB_ETH_EEM is not set
-# CONFIG_USB_GADGETFS is not set
-CONFIG_USB_FILE_STORAGE=m
-# CONFIG_USB_FILE_STORAGE_TEST is not set
-# CONFIG_USB_MASS_STORAGE is not set
-CONFIG_USB_G_SERIAL=m
-# CONFIG_USB_MIDI_GADGET is not set
-CONFIG_USB_G_PRINTER=m
-CONFIG_USB_CDC_COMPOSITE=m
-# CONFIG_USB_G_MULTI is not set
+# CONFIG_USB_GADGET is not set
 
 #
 # OTG and related infrastructure
@@ -2330,49 +2382,13 @@
 # CONFIG_UNUSED_SYMBOLS is not set
 CONFIG_DEBUG_FS=y
 # CONFIG_HEADERS_CHECK is not set
-CONFIG_DEBUG_KERNEL=y
-# CONFIG_DEBUG_SHIRQ is not set
-CONFIG_DETECT_SOFTLOCKUP=y
-# CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC is not set
-CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC_VALUE=0
-CONFIG_DETECT_HUNG_TASK=y
-# CONFIG_BOOTPARAM_HUNG_TASK_PANIC is not set
-CONFIG_BOOTPARAM_HUNG_TASK_PANIC_VALUE=0
-CONFIG_SCHED_DEBUG=y
-CONFIG_SCHEDSTATS=y
-CONFIG_TIMER_STATS=y
-# CONFIG_DEBUG_OBJECTS is not set
-# CONFIG_DEBUG_SLAB is not set
-# CONFIG_DEBUG_KMEMLEAK is not set
-# CONFIG_DEBUG_RT_MUTEXES is not set
-# CONFIG_RT_MUTEX_TESTER is not set
-# CONFIG_DEBUG_SPINLOCK is not set
-CONFIG_DEBUG_MUTEXES=y
-# CONFIG_DEBUG_LOCK_ALLOC is not set
-# CONFIG_PROVE_LOCKING is not set
-# CONFIG_LOCK_STAT is not set
-# CONFIG_DEBUG_SPINLOCK_SLEEP is not set
-# CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
-# CONFIG_DEBUG_KOBJECT is not set
-# CONFIG_DEBUG_BUGVERBOSE is not set
-CONFIG_DEBUG_INFO=y
-# CONFIG_DEBUG_VM is not set
-# CONFIG_DEBUG_WRITECOUNT is not set
+# CONFIG_IPIPE_DEBUG is not set
+# CONFIG_DEBUG_KERNEL is not set
+CONFIG_DEBUG_BUGVERBOSE=y
 # CONFIG_DEBUG_MEMORY_INIT is not set
-# CONFIG_DEBUG_LIST is not set
-# CONFIG_DEBUG_SG is not set
-# CONFIG_DEBUG_NOTIFIERS is not set
-# CONFIG_DEBUG_CREDENTIALS is not set
-# CONFIG_BOOT_PRINTK_DELAY is not set
-# CONFIG_RCU_TORTURE_TEST is not set
 # CONFIG_RCU_CPU_STALL_DETECTOR is not set
-# CONFIG_BACKTRACE_SELF_TEST is not set
-# CONFIG_DEBUG_BLOCK_EXT_DEVT is not set
-# CONFIG_DEBUG_FORCE_WEAK_PER_CPU is not set
-# CONFIG_FAULT_INJECTION is not set
 # CONFIG_LATENCYTOP is not set
 # CONFIG_SYSCTL_SYSCALL_CHECK is not set
-# CONFIG_PAGE_POISONING is not set
 CONFIG_HAVE_FUNCTION_TRACER=y
 CONFIG_RING_BUFFER=y
 CONFIG_RING_BUFFER_ALLOW_SWAP=y
@@ -2394,12 +2410,8 @@
 # CONFIG_DYNAMIC_DEBUG is not set
 # CONFIG_SAMPLES is not set
 CONFIG_HAVE_ARCH_KGDB=y
-# CONFIG_KGDB is not set
 CONFIG_ARM_UNWIND=y
 # CONFIG_DEBUG_USER is not set
-# CONFIG_DEBUG_ERRORS is not set
-# CONFIG_DEBUG_STACK_USAGE is not set
-# CONFIG_DEBUG_LL is not set
 # CONFIG_OC_ETM is not set


