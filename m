Message-ID: <459BED3C.4080400@domain.hid>
Date: Wed, 03 Jan 2007 18:51:56 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig25BCEF4661D4B115B78D89A6"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] [PATCH] Reorder Kconfig menus
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig25BCEF4661D4B115B78D89A6
Content-Type: multipart/mixed; boundary="------------010008010309040704010909"

This is a multi-part message in MIME format.
--------------010008010309040704010909
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

The menu ordering bugged me, specifically under the skins menu with all
the new period options. There was some bug /wrt RTDM and some redundancy
around the drivers menu. Any concerns about this patch?

Jan

--------------010008010309040704010909
Content-Type: text/x-patch;
 name="Kconfig-cleanup.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="Kconfig-cleanup.patch"

Index: ksrc/arch/arm/Kconfig
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- ksrc/arch/arm/Kconfig	(Revision 2044)
+++ ksrc/arch/arm/Kconfig	(Arbeitskopie)
@@ -19,9 +19,4 @@ config XENO_HW_FPU
 endmenu
=20
 source "kernel/xenomai/skins/Kconfig"
-
-menu "Drivers"
-
 source "drivers/xenomai/Kconfig"
-
-endmenu
Index: ksrc/arch/i386/Kconfig
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- ksrc/arch/i386/Kconfig	(Revision 2044)
+++ ksrc/arch/i386/Kconfig	(Arbeitskopie)
@@ -186,11 +186,4 @@ endmenu
 endmenu
=20
 source "kernel/xenomai/skins/Kconfig"
-
-menu "Drivers"
-
-depends on XENO_OPT_NUCLEUS
-
 source "drivers/xenomai/Kconfig"
-
-endmenu
Index: ksrc/arch/ia64/Kconfig
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- ksrc/arch/ia64/Kconfig	(Revision 2044)
+++ ksrc/arch/ia64/Kconfig	(Arbeitskopie)
@@ -20,9 +20,4 @@ config XENO_HW_IA64_STACK_POOL
 endmenu
=20
 source "kernel/xenomai/skins/Kconfig"
-
-menu "Drivers"
-
 source "drivers/xenomai/Kconfig"
-
-endmenu
Index: ksrc/arch/blackfin/Kconfig
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- ksrc/arch/blackfin/Kconfig	(Revision 2044)
+++ ksrc/arch/blackfin/Kconfig	(Arbeitskopie)
@@ -36,9 +36,4 @@ endmenu
 endmenu
=20
 source "kernel/xenomai/skins/Kconfig"
-
-menu "Drivers"
-
 source "drivers/xenomai/Kconfig"
-
-endmenu
Index: ksrc/arch/powerpc/Kconfig
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- ksrc/arch/powerpc/Kconfig	(Revision 2044)
+++ ksrc/arch/powerpc/Kconfig	(Arbeitskopie)
@@ -20,9 +20,4 @@ config XENO_HW_FPU
 endmenu
=20
 source "kernel/xenomai/skins/Kconfig"
-
-menu "Drivers"
-
 source "drivers/xenomai/Kconfig"
-
-endmenu
Index: ksrc/skins/rtai/Kconfig
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- ksrc/skins/rtai/Kconfig	(Revision 2044)
+++ ksrc/skins/rtai/Kconfig	(Arbeitskopie)
@@ -1,14 +1,14 @@
-config XENO_SKIN_RTAI
+menuconfig XENO_SKIN_RTAI
 	depends on XENO_OPT_NUCLEUS
 	tristate "RTAI emulator"
-	default n
 	help
=20
 	An emulator of the RTAI system.
=20
+if XENO_SKIN_RTAI
+
 config XENO_OPT_RTAI_PERIOD
-	depends on XENO_OPT_TIMING_PERIODIC && XENO_SKIN_RTAI
-	int "Base period (us)"
+	int "Base period (us)" if XENO_OPT_TIMING_PERIODIC
 	default 0
 	help
 	Duration of the base periodic tick (in microseconds).
@@ -24,37 +24,29 @@ config XENO_OPT_RTAI_PERIOD
=20
 	If in doubt, leave zero in this field.
=20
-if XENO_OPT_TIMING_PERIODIC !=3D y
-
-config XENO_OPT_RTAI_PERIOD
-	int
-	default 0
-
-endif
-
 config XENO_OPT_RTAI_FIFO
 	bool "Fifos"
-	depends on XENO_OPT_PIPE && XENO_SKIN_RTAI
+	select XENO_OPT_PIPE
 	default y
 	help
-=09
+
 	Fifos are uni-directional communication channels allowing data
 	exchange between real-time tasks in kernel-space and regular
 	user-space processes.
=20
 config XENO_OPT_RTAI_SEM
 	bool "Semaphores"
-	depends on XENO_SKIN_RTAI
 	default y
 	help
-=09
+
 	Semaphores are synchronization objects granting RTAI
 	tasks a concurrent access to a given number of resources.
=20
 config XENO_OPT_RTAI_SHM
 	bool "Shared Memory"
-	depends on XENO_SKIN_RTAI
 	default y
 	help
-=09
+
 	SHM are Shared Memory objects across RTAI tasks.
+
+endif
Index: ksrc/skins/rtdm/Kconfig
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- ksrc/skins/rtdm/Kconfig	(Revision 2044)
+++ ksrc/skins/rtdm/Kconfig	(Arbeitskopie)
@@ -1,4 +1,4 @@
-config XENO_SKIN_RTDM
+menuconfig XENO_SKIN_RTDM
 	depends on XENO_OPT_NUCLEUS
 	tristate "Real-Time Driver Model"
 	default y
@@ -8,9 +8,10 @@ config XENO_SKIN_RTDM
 	light weight interface in kernel mode, but use them across all other
 	skins in both kernel and user mode.
=20
+if XENO_SKIN_RTDM
+
 config XENO_OPT_RTDM_PERIOD
-	depends on XENO_OPT_TIMING_PERIODIC
-	int "Base period (us)"
+	int "Base period (us)" if XENO_OPT_TIMING_PERIODIC
 	default 0
 	help
 	Duration of the base periodic tick (in microseconds).
@@ -26,17 +27,8 @@ config XENO_OPT_RTDM_PERIOD
=20
 	If in doubt, leave zero in this field.
=20
-if XENO_OPT_TIMING_PERIODIC !=3D y
-
-config XENO_OPT_RTDM_PERIOD
-	int
-	default 0
-
-endif
-
 config XENO_OPT_RTDM_FILDES
 	int "Maximum number of RTDM file descriptors"
-	depends on XENO_SKIN_RTDM
 	default 128
 	help
=20
@@ -47,10 +39,12 @@ config XENO_OPT_RTDM_FILDES
=20
 config XENO_OPT_DEBUG_RTDM
 	bool "RTDM debugging support"
-	depends on XENO_OPT_DEBUG && XENO_SKIN_RTDM
+	depends on XENO_OPT_DEBUG
 	default y
 	help
=20
 	This option activates debugging checks for the RTDM subsystem.
 	It is a recommended option for analysing potential issues in RTDM
 	drivers. A minor runtime overhead is added.
+
+endif
Index: ksrc/skins/vrtx/Kconfig
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- ksrc/skins/vrtx/Kconfig	(Revision 2044)
+++ ksrc/skins/vrtx/Kconfig	(Arbeitskopie)
@@ -1,4 +1,4 @@
-config XENO_SKIN_VRTX
+menuconfig XENO_SKIN_VRTX
 	depends on XENO_OPT_NUCLEUS
 	select XENO_OPT_TIMING_PERIODIC
 	tristate "VRTX emulator"
Index: ksrc/skins/posix/Kconfig
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- ksrc/skins/posix/Kconfig	(Revision 2044)
+++ ksrc/skins/posix/Kconfig	(Arbeitskopie)
@@ -1,4 +1,4 @@
-config XENO_SKIN_POSIX
+menuconfig XENO_SKIN_POSIX
 	depends on XENO_OPT_NUCLEUS
 	tristate "POSIX API"
 	default y
@@ -6,11 +6,10 @@ config XENO_SKIN_POSIX
=20
 	A POSIX-compliant skin.
=20
-if XENO_SKIN_POSIX !=3D n
+if XENO_SKIN_POSIX
=20
 config XENO_OPT_POSIX_PERIOD
-	depends on XENO_OPT_TIMING_PERIODIC
-	int "Base period (us)"
+	int "Base period (us)" if XENO_OPT_TIMING_PERIODIC
 	default 0
 	help
 	Duration of the base periodic tick (in microseconds).
@@ -26,14 +25,6 @@ config XENO_OPT_POSIX_PERIOD
=20
 	If in doubt, leave zero in this field.
=20
-if XENO_OPT_TIMING_PERIODIC !=3D y
-
-config XENO_OPT_POSIX_PERIOD
-	int
-	default 0
-
-endif
-
 config XENO_OPT_POSIX_SHM
 	bool "Shared memory"
 	help
Index: ksrc/skins/psos+/Kconfig
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- ksrc/skins/psos+/Kconfig	(Revision 2044)
+++ ksrc/skins/psos+/Kconfig	(Arbeitskopie)
@@ -1,8 +1,7 @@
-config XENO_SKIN_PSOS
+menuconfig XENO_SKIN_PSOS
 	depends on XENO_OPT_NUCLEUS
 	select XENO_OPT_TIMING_PERIODIC
 	tristate "pSOS+ emulator"
-	default n
 	help
=20
 	This API skin emulates WindRiver's pSOS+ operating system.
Index: ksrc/skins/Kconfig
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- ksrc/skins/Kconfig	(Revision 2044)
+++ ksrc/skins/Kconfig	(Arbeitskopie)
@@ -3,19 +3,12 @@ menu "Interfaces"
 depends on XENO_OPT_NUCLEUS
=20
 source "kernel/xenomai/skins/native/Kconfig"
-
 source "kernel/xenomai/skins/posix/Kconfig"
-
 source "kernel/xenomai/skins/psos+/Kconfig"
-
 source "kernel/xenomai/skins/uitron/Kconfig"
-
 source "kernel/xenomai/skins/vrtx/Kconfig"
-
 source "kernel/xenomai/skins/vxworks/Kconfig"
-
 source "kernel/xenomai/skins/rtai/Kconfig"
-
 source "kernel/xenomai/skins/rtdm/Kconfig"
=20
 endmenu
Index: ksrc/skins/native/Kconfig
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- ksrc/skins/native/Kconfig	(Revision 2044)
+++ ksrc/skins/native/Kconfig	(Arbeitskopie)
@@ -1,4 +1,4 @@
-config XENO_SKIN_NATIVE
+menuconfig XENO_SKIN_NATIVE
 	depends on XENO_OPT_NUCLEUS
 	tristate "Native API"
 	default y
@@ -6,11 +6,10 @@ config XENO_SKIN_NATIVE
=20
 	The native Xenomai API.
=20
-if XENO_SKIN_NATIVE !=3D n
+if XENO_SKIN_NATIVE
=20
 config XENO_OPT_NATIVE_PERIOD
-	depends on XENO_OPT_TIMING_PERIODIC
-	int "Base period (us)"
+	int "Base period (us)" if XENO_OPT_TIMING_PERIODIC
 	default 0
 	help
 	Duration of the base periodic tick (in microseconds).
@@ -26,14 +25,6 @@ config XENO_OPT_NATIVE_PERIOD
=20
 	If in doubt, leave zero in this field.
=20
-if XENO_OPT_TIMING_PERIODIC !=3D y
-
-config XENO_OPT_NATIVE_PERIOD
-	int
-	default 0
-
-endif
-
 config XENO_OPT_NATIVE_PIPE
 	bool "Message pipes"
 	select XENO_OPT_PIPE
@@ -91,7 +82,7 @@ config XENO_OPT_NATIVE_EVENT
=20
 config XENO_OPT_NATIVE_MUTEX
 	bool "Mutexes"
-	default y if XENO_OPT_NATIVE_COND=3Dy
+	default y if XENO_OPT_NATIVE_COND
 	help
 =09
 	Mutexes are MUTual EXclusion objects, useful for protecting
Index: ksrc/skins/uitron/Kconfig
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- ksrc/skins/uitron/Kconfig	(Revision 2044)
+++ ksrc/skins/uitron/Kconfig	(Arbeitskopie)
@@ -1,8 +1,7 @@
-config XENO_SKIN_UITRON
+menuconfig XENO_SKIN_UITRON
 	depends on XENO_OPT_NUCLEUS
 	select XENO_OPT_TIMING_PERIODIC
 	tristate "uITRON API"
-	default n
 	help
=20
 	This skin implements the uITRON API.=20
Index: ksrc/skins/vxworks/Kconfig
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- ksrc/skins/vxworks/Kconfig	(Revision 2044)
+++ ksrc/skins/vxworks/Kconfig	(Arbeitskopie)
@@ -1,4 +1,4 @@
-config XENO_SKIN_VXWORKS
+menuconfig XENO_SKIN_VXWORKS
 	depends on XENO_OPT_NUCLEUS
 	select XENO_OPT_TIMING_PERIODIC
 	tristate "VxWorks emulator"
Index: ksrc/drivers/Kconfig
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- ksrc/drivers/Kconfig	(Revision 2044)
+++ ksrc/drivers/Kconfig	(Arbeitskopie)
@@ -1,3 +1,9 @@
+menu "Drivers"
+
+depends on XENO_OPT_NUCLEUS
+
 source "drivers/xenomai/serial/Kconfig"
 source "drivers/xenomai/testing/Kconfig"
 source "drivers/xenomai/can/Kconfig"
+
+endmenu
Index: ChangeLog
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- ChangeLog	(Revision 2044)
+++ ChangeLog	(Arbeitskopie)
@@ -1,3 +1,8 @@
+2007-01-03  Jan Kiszka  <jan.kiszka@domain.hid>
+
+	* ksrc/skins/*/Kconfig, ksrc/arch/*/Kconfig, ksrc/drivers/Kconfig:
+	Reorganise and clean up menus.
+
 2007-01-02  Gilles Chanteperdrix  <gilles.chanteperdrix@xenomai.org>
=20
 	* ksrc/nucleus/pod.c (xnpod_announce_tick): Remove support for

--------------010008010309040704010909--

--------------enig25BCEF4661D4B115B78D89A6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFFm+1AniDOoMHTA+kRAuSuAJ4zGtreGufhzvJ/zJ/V8xadCXsBOQCdEfa2
iQwo/+3kmo7sWCH2c4q0lxY=
=13Rq
-----END PGP SIGNATURE-----

--------------enig25BCEF4661D4B115B78D89A6--

