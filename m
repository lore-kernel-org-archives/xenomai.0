Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFD3D1A0730
	for <xenomai@lists.linux.dev>; Wed,  8 Jan 2025 16:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736353928; cv=none; b=Q7kBF23DZiLvLFNtEnAVQF7x4Pv95Uf4T2hNIzO8WPdLqgPh5c+GGSSKlXooxLs0joHuiiPgsSsguwJUlql7Qs7Riac81K9dvym4dOBdoyWcnbgmbDAkwTybwfWVO4Mo9B2uuP7tRot8S7P+IihUfFOj5XAyrCPd2NX7RN5RZI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736353928; c=relaxed/simple;
	bh=+KtIE7hKAnzr7SKvF7wTA/11X7MGj7KSRrCIpIaSo54=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bn/G1U4Z8tqbQsRzFfBlQsfs9xdr9hhOVu0gvkXPBzDqhBUmYXJUvcRtuZommbarnj1sH6EfWWemhzkIJGZl+bLUcerQFJLQ9HEE9saIYhWzhhNqw7qCJM9wDcFG2U7M8AmKbeC16z/oETZ9Ha//hSWGkOkR2vHewlDyN+wG69Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=GZ0SVKEj; arc=none smtp.client-ip=185.136.65.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="GZ0SVKEj"
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 20250108163157e4267229ab3507c2eb
        for <xenomai@lists.linux.dev>;
        Wed, 08 Jan 2025 17:31:57 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=AGV2UM8BoiIoLqI9MXlfZ9v3sKVtSv5c3+ETBS5h73g=;
 b=GZ0SVKEjJB08Rn/ew8g3+7yN7V4z7mjONfbMXRMalCC9rOJWR3Cq1HHf+99Toqz+tZFSXd
 5qEfjb1juuS+ePwFV9d/X8v3gsMOe1fQG36qgCFMi9QNKSiD7ohFPA0zqluB89eWTpUpOl7+
 SQOxH7/6cnqi0Uv/8OCFzhuTN7fqcayAhYCChv+cZ16b0A/Uu+wG4y7UC6O8jU5O3cTYDUVJ
 GIX1FnMAfGDVUrfsiV4ZlPBEMNsk3myAxRi++tVn/2DPzADHZGGv1qdZALEsDGuJydzYW+FI
 /IlkU9EEycBwZIqlSoK1blwVm+0dWNRONEvGf9USvqB/QdTcFjIc+D4Q==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: xenomai@lists.linux.dev
Cc: Jan Kiszka <jan.kiszka@siemens.com>,
	Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [PATCH] kernel: Reformat all Kconfig files
Date: Wed,  8 Jan 2025 17:31:35 +0100
Message-Id: <20250108163135.3631208-1-florian.bezdeka@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

A lot of white space conversions and reformatting of the help option
according to most upstream files.

No functional change.

Typo fixes in the following files:
  - kernel/drivers/net/addons/Kconfig
  - kernel/drivers/net/stack/Kconfig
  - kernel/drivers/net/stack/ipv4/Kconfig
  - kernel/drivers/serial/Kconfig

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 kernel/cobalt/arch/arm/Kconfig                |  10 +-
 kernel/cobalt/arch/arm64/Kconfig              |   8 +-
 kernel/cobalt/arch/x86/Kconfig                |   2 +-
 kernel/drivers/Kconfig                        |  22 +--
 kernel/drivers/analogy/Kconfig                |  63 ++++-----
 kernel/drivers/gpio/Kconfig                   |  49 +++----
 kernel/drivers/net/Kconfig                    |  20 +--
 kernel/drivers/net/addons/Kconfig             |  66 ++++-----
 kernel/drivers/net/drivers/Kconfig            | 130 +++++++++---------
 .../drivers/net/drivers/experimental/Kconfig  |   8 +-
 .../net/drivers/experimental/rt2500/Kconfig   |   6 +-
 kernel/drivers/net/stack/Kconfig              |  46 +++----
 kernel/drivers/net/stack/ipv4/Kconfig         | 110 +++++++--------
 kernel/drivers/net/stack/ipv4/tcp/Kconfig     |  28 ++--
 kernel/drivers/net/stack/ipv4/udp/Kconfig     |  10 +-
 kernel/drivers/net/stack/packet/Kconfig       |  24 ++--
 kernel/drivers/net/stack/rtcfg/Kconfig        |  38 ++---
 kernel/drivers/net/stack/rtmac/Kconfig        |  22 +--
 kernel/drivers/net/stack/rtmac/nomac/Kconfig  |  16 +--
 kernel/drivers/net/stack/rtmac/tdma/Kconfig   |  34 ++---
 kernel/drivers/serial/Kconfig                 |  56 ++++----
 kernel/drivers/spi/Kconfig                    |  15 +-
 kernel/drivers/testing/Kconfig                |  12 +-
 kernel/drivers/udd/Kconfig                    |   5 +-
 24 files changed, 390 insertions(+), 410 deletions(-)

diff --git a/kernel/cobalt/arch/arm/Kconfig b/kernel/cobalt/arch/arm/Kconfig
index b0cbdc3b7..080f9df80 100644
--- a/kernel/cobalt/arch/arm/Kconfig
+++ b/kernel/cobalt/arch/arm/Kconfig
@@ -5,12 +5,12 @@ config XENO_ARCH_FPU
 	def_bool VFP
 
 config XENO_ARCH_SYS3264
-        def_bool n
+	def_bool n
 
 config XENO_ARCH_OUTOFLINE_XNLOCK
-       bool
-       default y
+	bool
+	default y
 
 config XENO_ARCH_IPIPE_COMPAT
-       def_bool DOVETAIL
-       select IPIPE_COMPAT
+	def_bool DOVETAIL
+	select IPIPE_COMPAT
diff --git a/kernel/cobalt/arch/arm64/Kconfig b/kernel/cobalt/arch/arm64/Kconfig
index 14e5fa1c4..2ea82ce48 100644
--- a/kernel/cobalt/arch/arm64/Kconfig
+++ b/kernel/cobalt/arch/arm64/Kconfig
@@ -5,9 +5,9 @@ config XENO_ARCH_FPU
 	def_bool y
 
 config XENO_ARCH_SYS3264
-        def_bool COMPAT
-        depends on COMPAT_VDSO
+	def_bool COMPAT
+	depends on COMPAT_VDSO
 
 config XENO_ARCH_OUTOFLINE_XNLOCK
-       bool
-       default y
+	bool
+	default y
diff --git a/kernel/cobalt/arch/x86/Kconfig b/kernel/cobalt/arch/x86/Kconfig
index 9adbbf79d..dd08a5a3a 100644
--- a/kernel/cobalt/arch/x86/Kconfig
+++ b/kernel/cobalt/arch/x86/Kconfig
@@ -2,7 +2,7 @@ config XENO_ARCH_FPU
 	def_bool y
 
 config XENO_ARCH_SYS3264
-        def_bool IA32_EMULATION
+	def_bool IA32_EMULATION
 
 source "kernel/xenomai/Kconfig"
 source "drivers/xenomai/Kconfig"
diff --git a/kernel/drivers/Kconfig b/kernel/drivers/Kconfig
index 197a48eef..a0781c4bf 100644
--- a/kernel/drivers/Kconfig
+++ b/kernel/drivers/Kconfig
@@ -4,21 +4,21 @@ config XENO_OPT_RTDM_COMPAT_DEVNODE
 	bool "Enable legacy pathnames for named RTDM devices"
 	default y
 	help
-	This compatibility option allows applications to open named
-	RTDM devices using the legacy naming scheme, i.e.
+	  This compatibility option allows applications to open named
+	  RTDM devices using the legacy naming scheme, i.e.
 
-	fd = open("devname", ...);
-	   or
-	fd = open("/dev/devname", ...);
+	  fd = open("devname", ...);
+	     or
+	  fd = open("/dev/devname", ...);
 
-	When such a request is received by RTDM, a warning message is
-	issued to the kernel log whenever XENO_OPT_DEBUG_LEGACY is
-	also enabled in the kernel configuration.
+	  When such a request is received by RTDM, a warning message is
+	  issued to the kernel log whenever XENO_OPT_DEBUG_LEGACY is
+	  also enabled in the kernel configuration.
 
-	Applications should open named devices via their actual device
-	nodes instead, i.e.
+	  Applications should open named devices via their actual device
+	  nodes instead, i.e.
 
-	fd = open("/dev/rtdm/devname", ...);
+	  fd = open("/dev/rtdm/devname", ...);
 
 source "drivers/xenomai/autotune/Kconfig"
 source "drivers/xenomai/serial/Kconfig"
diff --git a/kernel/drivers/analogy/Kconfig b/kernel/drivers/analogy/Kconfig
index 858762bda..974b90021 100644
--- a/kernel/drivers/analogy/Kconfig
+++ b/kernel/drivers/analogy/Kconfig
@@ -3,50 +3,45 @@ menu "ANALOGY drivers"
 config XENO_DRIVERS_ANALOGY
 	tristate "ANALOGY interface"
 	help
-
-	ANALOGY is a framework aimed at supporting data acquisition
-	devices.
+	  ANALOGY is a framework aimed at supporting data acquisition devices.
 
 config XENO_DRIVERS_ANALOGY_DEBUG
-       depends on XENO_DRIVERS_ANALOGY
-       bool "Analogy debug trace"
-       default n
-       help
-
-       Enable debugging traces in Analogy so as to monitor Analogy's
-       core and drivers behaviours.
+	depends on XENO_DRIVERS_ANALOGY
+	bool "Analogy debug trace"
+	default n
+	help
+	  Enable debugging traces in Analogy so as to monitor Analogy's
+	  core and drivers behaviours.
 
 config XENO_DRIVERS_ANALOGY_DEBUG_FTRACE
-       depends on XENO_DRIVERS_ANALOGY_DEBUG
-       bool "Analogy debug ftrace"
-       default n
-       help
-
-       Route the Analogy a4l_dbg and a4l_info statements to /sys/kernel/debug/
+	depends on XENO_DRIVERS_ANALOGY_DEBUG
+	bool "Analogy debug ftrace"
+	default n
+	help
+          Route the Analogy a4l_dbg and a4l_info statements to
+          /sys/kernel/debug/
 
 config XENO_DRIVERS_ANALOGY_DEBUG_LEVEL
-       depends on XENO_DRIVERS_ANALOGY_DEBUG
-       int "Analogy core debug level threshold"
-       default 0
-       help
-
-       Define the level above which the debugging traces will not be
-       displayed.
+	depends on XENO_DRIVERS_ANALOGY_DEBUG
+	int "Analogy core debug level threshold"
+	default 0
+	help
+	  Define the level above which the debugging traces will not be
+	  displayed.
 
-       WARNING: this threshold is only applied on the Analogy
-       core. That will not affect the driver.
+	  WARNING: this threshold is only applied on the Analogy core.
+	  That will not affect the driver.
 
 config XENO_DRIVERS_ANALOGY_DRIVER_DEBUG_LEVEL
-       depends on XENO_DRIVERS_ANALOGY_DEBUG
-       int "Analogy driver debug level threshold"
-       default 0
-       help
-
-       Define the level above which the debugging traces will not be
-       displayed.
+	depends on XENO_DRIVERS_ANALOGY_DEBUG
+	int "Analogy driver debug level threshold"
+	default 0
+	help
+	  Define the level above which the debugging traces will not be
+	  displayed.
 
-       WARNING: this threshold is only applied on the Analogy
-       driver. That will not affect the core.
+	  WARNING: this threshold is only applied on the Analogy
+	  driver. That will not affect the core.
 
 source "drivers/xenomai/analogy/testing/Kconfig"
 source "drivers/xenomai/analogy/intel/Kconfig"
diff --git a/kernel/drivers/gpio/Kconfig b/kernel/drivers/gpio/Kconfig
index bc9cbc5e9..94943388f 100644
--- a/kernel/drivers/gpio/Kconfig
+++ b/kernel/drivers/gpio/Kconfig
@@ -1,11 +1,10 @@
 menu "Real-time GPIO drivers"
 
 config XENO_DRIVERS_GPIO
-       bool "GPIO controller"
-       depends on GPIOLIB
-       help
-
-       Real-time capable GPIO module.
+	bool "GPIO controller"
+	depends on GPIOLIB
+	help
+	  Real-time capable GPIO module.
 
 if XENO_DRIVERS_GPIO
 
@@ -13,67 +12,59 @@ config XENO_DRIVERS_GPIO_BCM2835
 	depends on MACH_BCM2708 || ARCH_BCM2835
 	tristate "Support for BCM2835 GPIOs"
 	help
-
-	Enables support for the GPIO controller available from
-	Broadcom's BCM2835 SoC.
+	  Enables support for the GPIO controller available from
+	  Broadcom's BCM2835 SoC.
 
 config XENO_DRIVERS_GPIO_BCM2711
 	depends on MACH_BCM2708 || ARCH_BCM2835
 	tristate "Support for BCM2711 GPIOs"
 	help
-
-	Enables support for the GPIO controller available from
-	Broadcom's BCM2711 SoC.
+	  Enables support for the GPIO controller available from
+	  Broadcom's BCM2711 SoC.
 
 config XENO_DRIVERS_GPIO_MXC
 	depends on GPIO_MXC
 	tristate "Support for MXC GPIOs"
 	help
-
-	Suitable for the GPIO controller available from
-	Freescale/NXP's MXC architecture.
+	  Suitable for the GPIO controller available from
+	  Freescale/NXP's MXC architecture.
 
 config XENO_DRIVERS_GPIO_SUN8I_H3
 	depends on MACH_SUN8I && PINCTRL_SUN8I_H3
 	tristate "Support for SUN8I H3 GPIOs"
 	help
-
-	Suitable for the GPIO controller available from Allwinner's H3
-	SoC, as found on the NanoPI boards.
+	  Suitable for the GPIO controller available from Allwinner's H3
+	  SoC, as found on the NanoPI boards.
 
 config XENO_DRIVERS_GPIO_ZYNQ7000
 	depends on ARCH_ZYNQ || ARCH_ZYNQMP
 	tristate "Support for Zynq7000 GPIOs"
 	help
-
-	Enables support for the GPIO controller available from
-	Xilinx's Zynq7000 SoC.
+	  Enables support for the GPIO controller available from
+	  Xilinx's Zynq7000 SoC.
 
 config XENO_DRIVERS_GPIO_XILINX
 	depends on ARCH_ZYNQ || ARCH_ZYNQMP
 	tristate "Support for Xilinx GPIOs"
 	help
-
-	Enables support for the GPIO controller available from
-	Xilinx's softcore IP.
+	  Enables support for the GPIO controller available from
+	  Xilinx's softcore IP.
 
 config XENO_DRIVERS_GPIO_OMAP
 	depends on ARCH_OMAP2PLUS || ARCH_OMAP
 	tristate "Support for OMAP GPIOs"
 	help
-
-	Enables support for the GPIO controller available from
-	OMAP family SOC.
+	  Enables support for the GPIO controller available from
+	  OMAP family SOC.
 
 config XENO_DRIVERS_GPIO_CHERRYVIEW
 	depends on PINCTRL_CHERRYVIEW
 	tristate "Support for Cherryview GPIOs"
 	help
-
-	Enables support for the Intel Cherryview GPIO controller
+	  Enables support for the Intel Cherryview GPIO controller
 
 config XENO_DRIVERS_GPIO_DEBUG
-       bool "Enable GPIO core debugging features"
+	bool "Enable GPIO core debugging features"
 
 endif
 
diff --git a/kernel/drivers/net/Kconfig b/kernel/drivers/net/Kconfig
index 2e8032464..576627d66 100644
--- a/kernel/drivers/net/Kconfig
+++ b/kernel/drivers/net/Kconfig
@@ -1,20 +1,20 @@
 menu "RTnet"
 
 config XENO_DRIVERS_NET
-    depends on m
-    select NET
-    tristate "RTnet, TCP/IP socket interface"
+	depends on m
+	select NET
+	tristate "RTnet, TCP/IP socket interface"
 
 if XENO_DRIVERS_NET
 
 config XENO_DRIVERS_RTNET_CHECKED
-    bool "Internal Bug Checks"
-    default n
-    help
-    Switch on if you face crashes when RTnet is running or if you suspect
-    any other RTnet-related issues. This feature will add a few sanity
-    checks at critical points that will produce warnings on the kernel
-    console in case certain internal bugs are detected.
+	bool "Internal Bug Checks"
+	default n
+	help
+	  Switch on if you face crashes when RTnet is running or if you suspect
+	  any other RTnet-related issues. This feature will add a few sanity
+	  checks at critical points that will produce warnings on the kernel
+	  console in case certain internal bugs are detected.
 
 source "drivers/xenomai/net/stack/Kconfig"
 source "drivers/xenomai/net/drivers/Kconfig"
diff --git a/kernel/drivers/net/addons/Kconfig b/kernel/drivers/net/addons/Kconfig
index e92f6d8ca..8215c39aa 100644
--- a/kernel/drivers/net/addons/Kconfig
+++ b/kernel/drivers/net/addons/Kconfig
@@ -1,44 +1,44 @@
 menu "Add-Ons"
-    depends on XENO_DRIVERS_NET
+	depends on XENO_DRIVERS_NET
 
 config XENO_DRIVERS_NET_ADDON_RTCAP
-    depends on XENO_DRIVERS_NET && m
-    select ETHERNET
-    tristate "Real-Time Capturing Support"
-    default n
-    help
-    This feature allows to capture real-time packets traversing the RTnet
-    stack. It can both be used to sniff passively on a network (in this
-    case you may want to enable the promisc mode of your real-time NIC via
-    rtifconfig) and to log the traffic the node receives and transmits
-    during normal operation. RTcap consists of additional hooks in the
-    RTnet stack and a separate module as interface to standard network
-    analysis tools like Ethereal.
+	depends on XENO_DRIVERS_NET && m
+	select ETHERNET
+	tristate "Real-Time Capturing Support"
+	default n
+	help
+	  This feature allows to capture real-time packets traversing the RTnet
+	  stack. It can both be used to sniff passively on a network (in this
+	  case you may want to enable the promisc mode of your real-time NIC via
+	  rtifconfig) and to log the traffic the node receives and transmits
+	  during normal operation. RTcap consists of additional hooks in the
+	  RTnet stack and a separate module as interface to standard network
+	  analysis tools like Ethereal.
 
-    For further information see Documentation/README.rtcap.
+	  For further information see Documentation/README.rtcap.
 
 config XENO_DRIVERS_NET_ADDON_PROXY
-    depends on XENO_DRIVERS_NET_RTIPV4 && m
-    select ETHERNET
-    tristate "IP protocol proxy for Linux"
-    default n
-    help
-    Enables a forward-to-Linux module for all IP protocols that are not
-    handled by the IPv4 implemenation of RTnet (TCP, UDP, etc.). Only use
-    when you know what you are doing - it can easily break your real-time
-    requirements!
+	depends on XENO_DRIVERS_NET_RTIPV4 && m
+	select ETHERNET
+	tristate "IP protocol proxy for Linux"
+	default n
+	help
+	  Enables a forward-to-Linux module for all IP protocols that are not
+	  handled by the IPv4 implementation of RTnet (TCP, UDP, etc.). Only use
+	  when you know what you are doing - it can easily break your real-time
+	  requirements!
 
-    See Documentation/README.rtnetproxy for further information.
+	  See Documentation/README.rtnetproxy for further information.
 
 config XENO_DRIVERS_NET_ADDON_PROXY_ARP
-    depends on XENO_DRIVERS_NET_ADDON_PROXY
-    bool "Enable ARP handling via protocol proxy"
-    default n
-    help
-    Enables ARP support for the IP protocol proxy. Incoming ARP replies
-    are then delivered to both, the RTnet and the Linux network stack,
-    but only answered by Linux. The IP protocol proxy gets attached to
-    the RTnet device specified by the module parameter "rtdev_attach",
-    rteth0 by default.
+	depends on XENO_DRIVERS_NET_ADDON_PROXY
+	bool "Enable ARP handling via protocol proxy"
+	default n
+	help
+	  Enables ARP support for the IP protocol proxy. Incoming ARP replies
+	  are then delivered to both, the RTnet and the Linux network stack,
+	  but only answered by Linux. The IP protocol proxy gets attached to
+	  the RTnet device specified by the module parameter "rtdev_attach",
+	  rteth0 by default.
 
 endmenu
diff --git a/kernel/drivers/net/drivers/Kconfig b/kernel/drivers/net/drivers/Kconfig
index 8ecd560b0..04362fbb0 100644
--- a/kernel/drivers/net/drivers/Kconfig
+++ b/kernel/drivers/net/drivers/Kconfig
@@ -1,119 +1,119 @@
 menu "Drivers"
-    depends on XENO_DRIVERS_NET
+	depends on XENO_DRIVERS_NET
 
 comment "Common PCI Drivers"
-    depends on PCI
+	depends on PCI
 
 config XENO_DRIVERS_NET_DRV_PCNET32
-    depends on XENO_DRIVERS_NET && PCI
-    tristate "AMD PCnet32"
+	depends on XENO_DRIVERS_NET && PCI
+	tristate "AMD PCnet32"
 
 
 config XENO_DRIVERS_NET_DRV_TULIP
-    depends on XENO_DRIVERS_NET && PCI
-    tristate "DEC Tulip"
+	depends on XENO_DRIVERS_NET && PCI
+	tristate "DEC Tulip"
 
 
 config XENO_DRIVERS_NET_DRV_EEPRO100
-    depends on XENO_DRIVERS_NET && PCI
-    tristate "Intel EtherExpress PRO/100"
-    default y
+	depends on XENO_DRIVERS_NET && PCI
+	tristate "Intel EtherExpress PRO/100"
+	default y
 
 config XENO_DRIVERS_NET_DRV_EEPRO100_CMDTIMEOUT
-    depends on XENO_DRIVERS_NET && PCI
-    int "Command Timeout"
-    depends on XENO_DRIVERS_NET_DRV_EEPRO100
-    default 20
-    help
-    Timeout in microseconds of transmission or configuration commands that
-    are issued in real-time contexts.
+	depends on XENO_DRIVERS_NET && PCI
+	int "Command Timeout"
+	depends on XENO_DRIVERS_NET_DRV_EEPRO100
+	default 20
+	help
+	  Timeout in microseconds of transmission or configuration commands
+	  that are issued in real-time contexts.
 
 config XENO_DRIVERS_NET_DRV_EEPRO100_DBG
-    depends on XENO_DRIVERS_NET && PCI
-    bool "Enable debugging and instrumentation"
-    depends on XENO_DRIVERS_NET_DRV_EEPRO100
-    help
-    This option switches on internal debugging code of the EEPRO/100 driver.
-    It also enables the collection of worst-case command delays in real-time
-    contexts in order to reduce the command timeout (which, effectively, will
-    also reduce the worst-case transmission latency).
+	depends on XENO_DRIVERS_NET && PCI
+	bool "Enable debugging and instrumentation"
+	depends on XENO_DRIVERS_NET_DRV_EEPRO100
+	help
+	  This option switches on internal debugging code of the EEPRO/100
+	  driver. It also enables the collection of worst-case command delays
+	  in real-time contexts in order to reduce the command timeout (which,
+	  effectively, will also reduce the worst-case transmission latency).
 
 
 config XENO_DRIVERS_NET_DRV_E1000
-    depends on XENO_DRIVERS_NET && PCI
-    tristate "Intel(R) PRO/1000 (Gigabit)"
-    default y
+	depends on XENO_DRIVERS_NET && PCI
+	tristate "Intel(R) PRO/1000 (Gigabit)"
+	default y
 
 config XENO_DRIVERS_NET_DRV_E1000E
-    depends on XENO_DRIVERS_NET && PCI
-    tristate "New Intel(R) PRO/1000 PCIe (Gigabit)"
+	depends on XENO_DRIVERS_NET && PCI
+	tristate "New Intel(R) PRO/1000 PCIe (Gigabit)"
 
 
 config XENO_DRIVERS_NET_DRV_NATSEMI
-    depends on XENO_DRIVERS_NET && PCI
-    tristate "NatSemi"
+	depends on XENO_DRIVERS_NET && PCI
+	tristate "NatSemi"
 
 
 config XENO_DRIVERS_NET_DRV_8139
-    depends on XENO_DRIVERS_NET && PCI
-    tristate "Realtek 8139"
-    default y
+	depends on XENO_DRIVERS_NET && PCI
+	tristate "Realtek 8139"
+	default y
 
 
 config XENO_DRIVERS_NET_DRV_VIA_RHINE
-    depends on XENO_DRIVERS_NET && PCI
-    tristate "VIA Rhine"
+	depends on XENO_DRIVERS_NET && PCI
+	tristate "VIA Rhine"
 
 
 config XENO_DRIVERS_NET_DRV_IGB
-    select I2C
-    select I2C_ALGOBIT
-    depends on XENO_DRIVERS_NET && PCI
-    tristate "Intel(R) 82575 (Gigabit)"
+	select I2C
+	select I2C_ALGOBIT
+	depends on XENO_DRIVERS_NET && PCI
+	tristate "Intel(R) 82575 (Gigabit)"
 
 config XENO_DRIVERS_NET_DRV_IGC
-    depends on XENO_DRIVERS_NET && PCI
-    tristate "Intel(R) Ethernet Controller I225-LM/I225-V support"
+	depends on XENO_DRIVERS_NET && PCI
+	tristate "Intel(R) Ethernet Controller I225-LM/I225-V support"
 
 config XENO_DRIVERS_NET_DRV_R8169
-    depends on XENO_DRIVERS_NET && PCI
-    tristate "Realtek 8169 (Gigabit)"
+	depends on XENO_DRIVERS_NET && PCI
+	tristate "Realtek 8169 (Gigabit)"
 
 
 comment "Misc Drivers"
 
 config XENO_DRIVERS_NET_DRV_LOOPBACK
-    depends on XENO_DRIVERS_NET
-    tristate "Loopback"
-    default y
+	depends on XENO_DRIVERS_NET
+	tristate "Loopback"
+	default y
 
 if ARM
 
 config XENO_DRIVERS_NET_DRV_AT91_ETHER
-    depends on XENO_DRIVERS_NET && SOC_AT91RM9200
-    select XENO_DRIVERS_NET_DRV_MACB
-    tristate "AT91RM9200 Board Ethernet Driver"
+	depends on XENO_DRIVERS_NET && SOC_AT91RM9200
+	select XENO_DRIVERS_NET_DRV_MACB
+	tristate "AT91RM9200 Board Ethernet Driver"
 
 config XENO_DRIVERS_NET_DRV_MACB
-    depends on XENO_DRIVERS_NET
-    select AT91_PROGRAMMABLE_CLOCKS if ARCH_AT91
-    tristate "Cadence MACB/GEM devices"
-    help
-    Driver for internal MAC-controller on AT91SAM926x microcontrollers.
-    Porting by Cristiano Mantovani and Stefano Banzi (Marposs SpA).
+	depends on XENO_DRIVERS_NET
+	select AT91_PROGRAMMABLE_CLOCKS if ARCH_AT91
+	tristate "Cadence MACB/GEM devices"
+	help
+	  Driver for internal MAC-controller on AT91SAM926x microcontrollers.
+	  Porting by Cristiano Mantovani and Stefano Banzi (Marposs SpA).
 
 endif
 
 config XENO_DRIVERS_NET_FEC
-    depends on XENO_DRIVERS_NET
-    depends on BROKEN || $(VERSION) < 6 || ($(VERSION) = 6 && $(PATCHLEVEL) < 3)
-    tristate "Freescale FEC"
-    depends on ARCH_MXC || SOC_IMX28
-    select PHYLIB
-    imply PTP_1588_CLOCK
-    help
-    For built-in 10/100 Fast ethernet controller on Freescale i.MX
-    processors.
+	depends on XENO_DRIVERS_NET
+	depends on BROKEN || $(VERSION) < 6 || ($(VERSION) = 6 && $(PATCHLEVEL) < 3)
+	tristate "Freescale FEC"
+	depends on ARCH_MXC || SOC_IMX28
+	select PHYLIB
+	imply PTP_1588_CLOCK
+	help
+	  For built-in 10/100 Fast ethernet controller on Freescale i.MX
+	  processors.
 
 source "drivers/xenomai/net/drivers/experimental/Kconfig"
 
diff --git a/kernel/drivers/net/drivers/experimental/Kconfig b/kernel/drivers/net/drivers/experimental/Kconfig
index e6a5edb9f..3571f06b8 100644
--- a/kernel/drivers/net/drivers/experimental/Kconfig
+++ b/kernel/drivers/net/drivers/experimental/Kconfig
@@ -1,12 +1,12 @@
 config XENO_DRIVERS_NET_EXP_DRIVERS
-    depends on XENO_DRIVERS_NET && PCI
-    bool "Experimental Drivers"
+	depends on XENO_DRIVERS_NET && PCI
+	bool "Experimental Drivers"
 
 if XENO_DRIVERS_NET_EXP_DRIVERS
 
 config XENO_DRIVERS_NET_DRV_E1000_NEW
-    depends on PCI
-    tristate "New Intel(R) PRO/1000 (Gigabit)"
+	depends on PCI
+	tristate "New Intel(R) PRO/1000 (Gigabit)"
 
 source "drivers/xenomai/net/drivers/experimental/rt2500/Kconfig"
 
diff --git a/kernel/drivers/net/drivers/experimental/rt2500/Kconfig b/kernel/drivers/net/drivers/experimental/rt2500/Kconfig
index 054412839..46cd4308a 100644
--- a/kernel/drivers/net/drivers/experimental/rt2500/Kconfig
+++ b/kernel/drivers/net/drivers/experimental/rt2500/Kconfig
@@ -1,4 +1,4 @@
 config XENO_DRIVERS_NET_DRV_RT2500
-    depends on XENO_DRIVERS_NET && PCI
-    tristate "Ralink 2500 WLAN"
-    select XENO_DRIVERS_NET_RTWLAN
+	depends on XENO_DRIVERS_NET && PCI
+	tristate "Ralink 2500 WLAN"
+	select XENO_DRIVERS_NET_RTWLAN
diff --git a/kernel/drivers/net/stack/Kconfig b/kernel/drivers/net/stack/Kconfig
index 996536cc5..bf151f3df 100644
--- a/kernel/drivers/net/stack/Kconfig
+++ b/kernel/drivers/net/stack/Kconfig
@@ -1,35 +1,35 @@
 menu "Protocol Stack"
-    depends on XENO_DRIVERS_NET
+	depends on XENO_DRIVERS_NET
 
 comment "Stack parameters"
 
 config XENO_DRIVERS_NET_RX_FIFO_SIZE
-    int "Size of central RX-FIFO"
-    depends on XENO_DRIVERS_NET
-    default 32
-    help
-    Size of FIFO between NICs and stack manager task. Must be power
-    of two! Effectively, only CONFIG_RTNET_RX_FIFO_SIZE-1 slots will
-    be usable.
+	int "Size of central RX-FIFO"
+	depends on XENO_DRIVERS_NET
+	default 32
+	help
+	  Size of FIFO between NICs and stack manager task. Must be power
+	  of two! Effectively, only CONFIG_RTNET_RX_FIFO_SIZE-1 slots will
+	  be usable.
 
 config XENO_DRIVERS_NET_ETH_P_ALL
-    depends on XENO_DRIVERS_NET
-    bool "Support for ETH_P_ALL"
-    help
-    Enables core support for registering listeners on all layer 3
-    protocols (ETH_P_ALL). Internally this is currently realised by
-    clone-copying incoming frames for those listners, future versions
-    will implement buffer sharing for efficiency reasons. Use with
-    care, every ETH_P_ALL-listener adds noticable overhead to the
-    reception path.
+	depends on XENO_DRIVERS_NET
+	bool "Support for ETH_P_ALL"
+	help
+	  Enables core support for registering listeners on all layer 3
+	  protocols (ETH_P_ALL). Internally this is currently realised by
+	  clone-copying incoming frames for those listeners, future versions
+	  will implement buffer sharing for efficiency reasons. Use with
+	  care, every ETH_P_ALL-listener adds noticeable overhead to the
+	  reception path.
 
 config XENO_DRIVERS_NET_RTWLAN
-    depends on XENO_DRIVERS_NET
-    bool "Real-Time WLAN"
-    help
-    Enables core support for real-time wireless LAN. RT-WLAN is based
-    on low-level access to 802.11-compliant adapters and is currently
-    in an experimental stage.
+	depends on XENO_DRIVERS_NET
+	bool "Real-Time WLAN"
+	help
+	  Enables core support for real-time wireless LAN. RT-WLAN is based
+	  on low-level access to 802.11-compliant adapters and is currently
+	  in an experimental stage.
 
 comment "Protocols"
 
diff --git a/kernel/drivers/net/stack/ipv4/Kconfig b/kernel/drivers/net/stack/ipv4/Kconfig
index d5a6cd6d7..46c5d0f98 100644
--- a/kernel/drivers/net/stack/ipv4/Kconfig
+++ b/kernel/drivers/net/stack/ipv4/Kconfig
@@ -1,75 +1,75 @@
 config XENO_DRIVERS_NET_RTIPV4
-    depends on XENO_DRIVERS_NET
-    tristate "Real-Time IPv4"
-    default y
-    help
-    Enables the real-time capable IPv4 support of RTnet. The protocol is
-    implemented as a separate module. Supplementing tools (rtroute,
-    rtping) and examples are provided as well. Moreover, RTcfg will
-    include IPv4 support when this option is switched on.
+	depends on XENO_DRIVERS_NET
+	tristate "Real-Time IPv4"
+	default y
+	help
+	  Enables the real-time capable IPv4 support of RTnet. The protocol is
+	  implemented as a separate module. Supplementing tools (rtroute,
+	  rtping) and examples are provided as well. Moreover, RTcfg will
+	  include IPv4 support when this option is switched on.
 
-    For further information see also Documentation/README.routing and
-    Documentation/README.ipfragmentation.
+	  For further information see also Documentation/README.routing and
+	  Documentation/README.ipfragmentation.
 
 config XENO_DRIVERS_NET_RTIPV4_ICMP
-    bool "ICMP support"
-    depends on XENO_DRIVERS_NET_RTIPV4
-    default y
-    help
-    Enables ICMP support of the RTnet Real-Time IPv4 protocol.
+	bool "ICMP support"
+	depends on XENO_DRIVERS_NET_RTIPV4
+	default y
+	help
+	  Enables ICMP support of the RTnet Real-Time IPv4 protocol.
 
-    When the RTnet-Proxy is enabled while this feature is disabled, ICMP
-    will be forwarded to the Linux network stack.
+	  When the RTnet-Proxy is enabled while this feature is disabled, ICMP
+	  will be forwarded to the Linux network stack.
 
 config XENO_DRIVERS_NET_RTIPV4_HOST_ROUTES
-    int "Maximum host routing table entries"
-    depends on XENO_DRIVERS_NET_RTIPV4
-    default 32
-    help
-    Each IPv4 supporting interface and each remote host that is directly
-    reachable via via some output interface requires a host routing table
-    entry. If you run larger networks with may hosts per subnet, you may
-    have to increase this limit. Must be power of 2!
+	int "Maximum host routing table entries"
+	depends on XENO_DRIVERS_NET_RTIPV4
+	default 32
+	help
+	  Each IPv4 supporting interface and each remote host that is directly
+	  reachable via some output interface requires a host routing table
+	  entry. If you run larger networks with may hosts per subnet, you may
+	  have to increase this limit. Must be power of 2!
 
 config XENO_DRIVERS_NET_RTIPV4_NETROUTING
-    bool "IP Network Routing"
-    depends on XENO_DRIVERS_NET_RTIPV4
-    help
-    Enables routing across IPv4 real-time networks. You will only require
-    this feature in complex networks, while switching it off for flat,
-    single-segment networks improves code size and the worst-case routing
-    decision delay.
+	bool "IP Network Routing"
+	depends on XENO_DRIVERS_NET_RTIPV4
+	help
+	  Enables routing across IPv4 real-time networks. You will only require
+	  this feature in complex networks, while switching it off for flat,
+	  single-segment networks improves code size and the worst-case routing
+	  decision delay.
 
-    See Documentation/README.routing for further information.
+	  See Documentation/README.routing for further information.
 
 config XENO_DRIVERS_NET_RTIPV4_NET_ROUTES
-    int "Maximum network routing table entries"
-    depends on XENO_DRIVERS_NET_RTIPV4_NETROUTING
-    default 16
-    help
-    Each route describing a target network reachable via a router
-    requires an entry in the network routing table. If you run very
-    complex realtime networks, you may have to increase this limit. Must
-    be power of 2!
+	int "Maximum network routing table entries"
+	depends on XENO_DRIVERS_NET_RTIPV4_NETROUTING
+	default 16
+	help
+	  Each route describing a target network reachable via a router
+	  requires an entry in the network routing table. If you run very
+	  complex realtime networks, you may have to increase this limit. Must
+	  be power of 2!
 
 config XENO_DRIVERS_NET_RTIPV4_ROUTER
-    bool "IP Router"
-    depends on XENO_DRIVERS_NET_RTIPV4
-    help
-    When switched on, the RTnet station will be able to forward IPv4
-    packets that are not directed to the station itself. Typically used in
-    combination with CONFIG_RTNET_RTIPV4_NETROUTING.
+	bool "IP Router"
+	depends on XENO_DRIVERS_NET_RTIPV4
+	help
+	  When switched on, the RTnet station will be able to forward IPv4
+	  packets that are not directed to the station itself. Typically used
+	  in combination with CONFIG_RTNET_RTIPV4_NETROUTING.
 
-    See Documentation/README.routing for further information.
+	  See Documentation/README.routing for further information.
 
 config XENO_DRIVERS_NET_RTIPV4_DEBUG
-    bool "RTipv4 Debugging"
-    depends on XENO_DRIVERS_NET_RTIPV4
-    default n
-    
-    help
-    Enables debug message output of the RTipv4 layer. Typically, you
-    may want to turn this on for tracing issues in packet delivery.
+	bool "RTipv4 Debugging"
+	depends on XENO_DRIVERS_NET_RTIPV4
+	default n
+
+	help
+	  Enables debug message output of the RTipv4 layer. Typically, you
+	  may want to turn this on for tracing issues in packet delivery.
 
 source "drivers/xenomai/net/stack/ipv4/udp/Kconfig"
 source "drivers/xenomai/net/stack/ipv4/tcp/Kconfig"
diff --git a/kernel/drivers/net/stack/ipv4/tcp/Kconfig b/kernel/drivers/net/stack/ipv4/tcp/Kconfig
index a69d34679..69f606c42 100644
--- a/kernel/drivers/net/stack/ipv4/tcp/Kconfig
+++ b/kernel/drivers/net/stack/ipv4/tcp/Kconfig
@@ -1,18 +1,18 @@
 config XENO_DRIVERS_NET_RTIPV4_TCP
-    tristate "TCP support"
-    depends on XENO_DRIVERS_NET_RTIPV4
-    help
-    Enables TCP support of the RTnet Real-Time IPv4 protocol.
+	tristate "TCP support"
+	depends on XENO_DRIVERS_NET_RTIPV4
+	help
+	  Enables TCP support of the RTnet Real-Time IPv4 protocol.
 
-    When the RTnet IPv4 is enabled while this feature is disabled, TCP
-    will be forwarded to the Linux network stack.
+	  When the RTnet IPv4 is enabled while this feature is disabled, TCP
+	  will be forwarded to the Linux network stack.
 
 config XENO_DRIVERS_NET_RTIPV4_TCP_ERROR_INJECTION
-    bool "TCP error injection"
-    depends on XENO_DRIVERS_NET_RTIPV4_TCP
-    help
-    Enables error injection for incoming TCP packets. This can be used
-    to test both protocol as well as application behavior under error
-    conditions. The per-socket error rate is 0 by default and can be
-    tuned during runtime via the error_rate and multi_error module
-    parameters.
+	bool "TCP error injection"
+	depends on XENO_DRIVERS_NET_RTIPV4_TCP
+	help
+	  Enables error injection for incoming TCP packets. This can be used
+	  to test both protocol as well as application behavior under error
+	  conditions. The per-socket error rate is 0 by default and can be
+	  tuned during runtime via the error_rate and multi_error module
+	  parameters.
diff --git a/kernel/drivers/net/stack/ipv4/udp/Kconfig b/kernel/drivers/net/stack/ipv4/udp/Kconfig
index a23279411..79141df50 100644
--- a/kernel/drivers/net/stack/ipv4/udp/Kconfig
+++ b/kernel/drivers/net/stack/ipv4/udp/Kconfig
@@ -1,6 +1,6 @@
 config XENO_DRIVERS_NET_RTIPV4_UDP
-    tristate "UDP support"
-    depends on XENO_DRIVERS_NET_RTIPV4
-    default y
-    help
-    Enables UDP support of the RTnet Real-Time IPv4 protocol.
+	tristate "UDP support"
+	depends on XENO_DRIVERS_NET_RTIPV4
+	default y
+	help
+	  Enables UDP support of the RTnet Real-Time IPv4 protocol.
diff --git a/kernel/drivers/net/stack/packet/Kconfig b/kernel/drivers/net/stack/packet/Kconfig
index 4c83b73c2..bb2dbe886 100644
--- a/kernel/drivers/net/stack/packet/Kconfig
+++ b/kernel/drivers/net/stack/packet/Kconfig
@@ -1,14 +1,14 @@
 config XENO_DRIVERS_NET_RTPACKET
-    depends on XENO_DRIVERS_NET
-    tristate "Real-Time Packet Socket Support"
-    default y
-    help
-    Enables real-time packet sockets for RTnet. This support is
-    implemented in a separate module. When loaded, application programs
-    can send and received so-called "cooked" packets directly at OSI layer
-    2 (device layer). This means that RTnet will still maintain the
-    device-dependent packet header but leave the full data segment to the
-    user.
+	depends on XENO_DRIVERS_NET
+	tristate "Real-Time Packet Socket Support"
+	default y
+	help
+	  Enables real-time packet sockets for RTnet. This support is
+	  implemented in a separate module. When loaded, application programs
+	  can send and received so-called "cooked" packets directly at OSI
+	  layer 2 (device layer). This means that RTnet will still maintain the
+	  device-dependent packet header but leave the full data segment to the
+	  user.
 
-    Examples like raw-ethernet or netshm make use of this support. See
-    also Linux man page packet(7).
+	  Examples like raw-ethernet or netshm make use of this support. See
+	  also Linux man page packet(7).
diff --git a/kernel/drivers/net/stack/rtcfg/Kconfig b/kernel/drivers/net/stack/rtcfg/Kconfig
index 38c484046..c1f9687f4 100644
--- a/kernel/drivers/net/stack/rtcfg/Kconfig
+++ b/kernel/drivers/net/stack/rtcfg/Kconfig
@@ -1,23 +1,23 @@
 config XENO_DRIVERS_NET_RTCFG
-    depends on XENO_DRIVERS_NET
-    tristate "RTcfg Service"
-    default y
-    help
-    The Real-Time Configuration service configures and monitors nodes in
-    a RTnet network. It works both with plain MAC as well as with IPv4
-    addresses (in case CONFIG_RTNET_RTIPV4 has been switched on). RTcfg
-    consists of a configuration server, which can run on the same station
-    as the TDMA master e.g., and one or more clients. Clients can join and
-    leave the network during runtime without interfering with other
-    stations. Besides network configuration, the RTcfg server can also
-    distribute custom data.
+	depends on XENO_DRIVERS_NET
+	tristate "RTcfg Service"
+	default y
+	help
+	  The Real-Time Configuration service configures and monitors nodes in
+	  a RTnet network. It works both with plain MAC as well as with IPv4
+	  addresses (in case CONFIG_RTNET_RTIPV4 has been switched on). RTcfg
+	  consists of a configuration server, which can run on the same station
+	  as the TDMA master e.g., and one or more clients. Clients can join and
+	  leave the network during runtime without interfering with other
+	  stations. Besides network configuration, the RTcfg server can also
+	  distribute custom data.
 
-    See Documentation/README.rtcfg for further information.
+	See Documentation/README.rtcfg for further information.
 
 config XENO_DRIVERS_NET_RTCFG_DEBUG
-    bool "RTcfg Debugging"
-    depends on XENO_DRIVERS_NET_RTCFG
-    default n
-    help
-    Enables debug message output of the RTcfg state machines. Switch on if
-    you have to trace some problem related to RTcfg.
+	bool "RTcfg Debugging"
+	depends on XENO_DRIVERS_NET_RTCFG
+	default n
+	help
+	  Enables debug message output of the RTcfg state machines. Switch on if
+	  you have to trace some problem related to RTcfg.
diff --git a/kernel/drivers/net/stack/rtmac/Kconfig b/kernel/drivers/net/stack/rtmac/Kconfig
index a97b316b0..56f70af38 100644
--- a/kernel/drivers/net/stack/rtmac/Kconfig
+++ b/kernel/drivers/net/stack/rtmac/Kconfig
@@ -1,16 +1,16 @@
 menuconfig XENO_DRIVERS_NET_RTMAC
-    depends on XENO_DRIVERS_NET
-    tristate "RTmac Layer"
-    default y
-    help
-    The Real-Time Media Access Control layer allows to extend the RTnet
-    stack with software-based access control mechanisms (also called
-    disciplines) for nondeterministic transport media. Disciplines can be
-    attached and detached per real-time device. RTmac also provides a
-    framework for tunnelling non-time-critical packets through real-time
-    networks by installing virtual NICs (VNIC) in the Linux domain.
+	depends on XENO_DRIVERS_NET
+	tristate "RTmac Layer"
+	default y
+	help
+	  The Real-Time Media Access Control layer allows to extend the RTnet
+	  stack with software-based access control mechanisms (also called
+	  disciplines) for nondeterministic transport media. Disciplines can be
+	  attached and detached per real-time device. RTmac also provides a
+	  framework for tunnelling non-time-critical packets through real-time
+	  networks by installing virtual NICs (VNIC) in the Linux domain.
 
-    See Documentation/README.rtmac for further information.
+	  See Documentation/README.rtmac for further information.
 
 source "drivers/xenomai/net/stack/rtmac/tdma/Kconfig"
 source "drivers/xenomai/net/stack/rtmac/nomac/Kconfig"
diff --git a/kernel/drivers/net/stack/rtmac/nomac/Kconfig b/kernel/drivers/net/stack/rtmac/nomac/Kconfig
index e706d4a96..9e457cd3f 100644
--- a/kernel/drivers/net/stack/rtmac/nomac/Kconfig
+++ b/kernel/drivers/net/stack/rtmac/nomac/Kconfig
@@ -1,9 +1,9 @@
 config XENO_DRIVERS_NET_NOMAC
-    tristate "NoMAC discipline for RTmac"
-    depends on XENO_DRIVERS_NET_RTMAC
-    default n
-    help
-    This no-operation RTmac discipline is intended to act as a template
-    for new implementations. However, it can be compiled and used (see
-    nomaccfg management tool), but don't expect any improved determinism
-    of your network. ;)
+	tristate "NoMAC discipline for RTmac"
+	depends on XENO_DRIVERS_NET_RTMAC
+	default n
+	help
+	  This no-operation RTmac discipline is intended to act as a template
+	  for new implementations. However, it can be compiled and used (see
+	  nomaccfg management tool), but don't expect any improved determinism
+	  of your network. ;)
diff --git a/kernel/drivers/net/stack/rtmac/tdma/Kconfig b/kernel/drivers/net/stack/rtmac/tdma/Kconfig
index 4444661f2..3f806c68d 100644
--- a/kernel/drivers/net/stack/rtmac/tdma/Kconfig
+++ b/kernel/drivers/net/stack/rtmac/tdma/Kconfig
@@ -1,21 +1,21 @@
 config XENO_DRIVERS_NET_TDMA
-    tristate "TDMA discipline for RTmac"
-    depends on XENO_DRIVERS_NET_RTMAC
-    default y
-    help
-    The Time Division Multiple Access discipline is the default RTmac
-    protocol for Ethernet networks. It consists of a master synchronising
-    the access of the slaves to the media by periodically issuing frames.
-    Backup masters can be set up to take over if the primary master fails.
-    TDMA also provides a global clock across all participants. The tdmacfg
-    tool can be used to configure a real-time NIC to use TDMA.
+	tristate "TDMA discipline for RTmac"
+	depends on XENO_DRIVERS_NET_RTMAC
+	default y
+	help
+	  The Time Division Multiple Access discipline is the default RTmac
+	  protocol for Ethernet networks. It consists of a master synchronising
+	  the access of the slaves to the media by periodically issuing frames.
+	  Backup masters can be set up to take over if the primary master fails.
+	  TDMA also provides a global clock across all participants. The tdmacfg
+	  tool can be used to configure a real-time NIC to use TDMA.
 
-    See Documenatation/README.rtmac for further details.
+	  See Documenatation/README.rtmac for further details.
 
 config XENO_DRIVERS_NET_TDMA_MASTER
-    bool "TDMA master support"
-    depends on XENO_DRIVERS_NET_TDMA
-    default y
-    help
-    Enables TDMA master and backup master support for the node. This can
-    be switched of to reduce the memory footprint of pure slave nodes.
+	bool "TDMA master support"
+	depends on XENO_DRIVERS_NET_TDMA
+	default y
+	help
+	  Enables TDMA master and backup master support for the node. This can
+	  be switched of to reduce the memory footprint of pure slave nodes.
diff --git a/kernel/drivers/serial/Kconfig b/kernel/drivers/serial/Kconfig
index 43dd5ec23..f6eadb152 100644
--- a/kernel/drivers/serial/Kconfig
+++ b/kernel/drivers/serial/Kconfig
@@ -3,8 +3,8 @@ menu "Serial drivers"
 config XENO_DRIVERS_16550A
 	tristate "16550A UART driver"
 	help
-	Real-time UART driver for 16550A compatible controllers. See
-	doc/txt/16550A-driver.txt for more details.
+	  Real-time UART driver for 16550A compatible controllers. See
+	  doc/txt/16550A-driver.txt for more details.
 
 choice
 	prompt "Hardware access mode"
@@ -14,27 +14,27 @@ choice
 config XENO_DRIVERS_16550A_PIO
 	bool "Port-based I/O"
 	help
-	Hardware access only via I/O ports. Use module parameter
-	"io=<port>[,<port>[,...]]" to specify the base port of a device.
+	  Hardware access only via I/O ports. Use module parameter
+	  "io=<port>[,<port>[,...]]" to specify the base port of a device.
 
 config XENO_DRIVERS_16550A_MMIO
 	bool "Memory-mapped I/O"
 	help
-	Hardware access only via memory mapping. Use module paramter
-	"mem=<addr>[,<addr>[,...]]" to specify the physical base address of
-	a device.
+	  Hardware access only via memory mapping. Use module parameter
+	  "mem=<addr>[,<addr>[,...]]" to specify the physical base address of
+	  a device.
 
 config XENO_DRIVERS_16550A_ANY
 	bool "Any access mode"
 	help
-	Decide at module load-time (or via kernel parameter) which access
-	mode to use for which device. This mode is useful when devices of
-	both types can be present in a system, also at the same time.
+	  Decide at module load-time (or via kernel parameter) which access
+	  mode to use for which device. This mode is useful when devices of
+	  both types can be present in a system, also at the same time.
 
-	Both "io" and "mem" module parameters are available, but always only
-	one of them can be applied on a particular device. Use, e.g.,
-	"io=0x3f8,0 mem=0,0xe0000000" to address device 1 via IO base port
-	0x3f8 and device 2 via physical base address 0xe0000000.
+	  Both "io" and "mem" module parameters are available, but always only
+	  one of them can be applied on a particular device. Use, e.g.,
+	  "io=0x3f8,0 mem=0,0xe0000000" to address device 1 via IO base port
+	  0x3f8 and device 2 via physical base address 0xe0000000.
 
 endchoice
 
@@ -43,37 +43,35 @@ config XENO_DRIVERS_16550A_PCI
 	bool "PCI board support"
 	default n
 	help
-
-	This option activates support for PCI serial boards.
+	  This option activates support for PCI serial boards.
 
 config XENO_DRIVERS_16550A_PCI_MOXA
 	depends on XENO_DRIVERS_16550A_PCI
 	bool "Moxa PCI boards"
 	default n
 	help
-
-	This option activates support for the following Moxa boards:
-	PCI Serial Boards:
-	  C104H/PCI, C168H/PCI
-	  CP-114, CP-132
-	Universal PCI Serial Boards:
-	  CP-102U, CP-102UL, CP-104U
-	  CP-112UL, CP-114UL, CP-118U
-	  CP-132U, CP-134U, CP-138U
-	  CP-168U
+	  This option activates support for the following Moxa boards:
+	  PCI Serial Boards:
+	    C104H/PCI, C168H/PCI
+	    CP-114, CP-132
+	  Universal PCI Serial Boards:
+	    CP-102U, CP-102UL, CP-104U
+	    CP-112UL, CP-114UL, CP-118U
+	    CP-132U, CP-134U, CP-138U
+	    CP-168U
 
 config XENO_DRIVERS_MPC52XX_UART
 	depends on PPC_MPC52xx
 	tristate "MPC52xx PSC UART driver"
 	help
-	Real-time UART driver for the PSC on the MPC5200 processor.
+	  Real-time UART driver for the PSC on the MPC5200 processor.
 
 config XENO_DRIVERS_IMX_UART
 	depends on ARCH_IMX || ARCH_MXC
 	tristate "RT IMX UART driver"
 	select RATIONAL
 	help
-	Real-time UART driver for the Freescale Semiconductor MXC Internal
-	UART compatible controllers.
+	  Real-time UART driver for the Freescale Semiconductor MXC Internal
+	  UART compatible controllers.
 
 endmenu
diff --git a/kernel/drivers/spi/Kconfig b/kernel/drivers/spi/Kconfig
index b48aaf3f9..7c18be293 100644
--- a/kernel/drivers/spi/Kconfig
+++ b/kernel/drivers/spi/Kconfig
@@ -9,18 +9,16 @@ config XENO_DRIVERS_SPI_BCM2835
 	select XENO_DRIVERS_SPI
 	tristate "Support for BCM2835 SPI"
 	help
-
-	Enables support for the SPI0 controller available from
-	Broadcom's BCM2835 SoC.
+	  Enables support for the SPI0 controller available from
+	  Broadcom's BCM2835 SoC.
 
 config XENO_DRIVERS_SPI_SUN6I
 	depends on MACH_SUN6I || MACH_SUN8I
 	select XENO_DRIVERS_SPI
 	tristate "Support for A31/H3 SoC SPI"
 	help
-
-	Enables support for the SPI controller available from
-	Allwinner's A31, H3 SoCs.
+	  Enables support for the SPI controller available from
+	  Allwinner's A31, H3 SoCs.
 
 config XENO_DRIVERS_SPI_OMAP2_MCSPI_RT
 	tristate "McSPI rt-driver for OMAP"
@@ -28,9 +26,8 @@ config XENO_DRIVERS_SPI_OMAP2_MCSPI_RT
 	depends on ARCH_OMAP2PLUS || COMPILE_TEST
 	select XENO_DRIVERS_SPI
 	help
-
-	SPI real-time master controller for OMAP24XX and later Multichannel SPI
-	(McSPI) modules.
+	  SPI real-time master controller for OMAP24XX and later Multichannel
+	  SPI (McSPI) modules.
 
 config XENO_DRIVERS_SPI_DEBUG
        depends on XENO_DRIVERS_SPI
diff --git a/kernel/drivers/testing/Kconfig b/kernel/drivers/testing/Kconfig
index 88c043c82..a189fa19d 100644
--- a/kernel/drivers/testing/Kconfig
+++ b/kernel/drivers/testing/Kconfig
@@ -4,26 +4,26 @@ config XENO_DRIVERS_TIMERBENCH
 	tristate "Timer benchmark driver"
 	default y
 	help
-	Kernel-based benchmark driver for timer latency evaluation.
-	See testsuite/latency for a possible front-end.
+	  Kernel-based benchmark driver for timer latency evaluation.
+	  See testsuite/latency for a possible front-end.
 
 config XENO_DRIVERS_SWITCHTEST
 	tristate "Context switch unit testing driver"
 	default y
 	help
-	Kernel-based driver for unit testing context switches and
-	FPU switches.
+	  Kernel-based driver for unit testing context switches and
+	  FPU switches.
 
 config XENO_DRIVERS_HEAPCHECK
 	tristate "Memory allocator test driver"
 	default y
 	help
-	Kernel-based driver for testing Cobalt's memory allocator.
+	  Kernel-based driver for testing Cobalt's memory allocator.
 
 config XENO_DRIVERS_RTDMTEST
 	depends on m
 	tristate "RTDM unit tests driver"
 	help
-	Kernel driver for performing RTDM unit tests.
+	  Kernel driver for performing RTDM unit tests.
 
 endmenu
diff --git a/kernel/drivers/udd/Kconfig b/kernel/drivers/udd/Kconfig
index 86b9a8258..9b9b0776a 100644
--- a/kernel/drivers/udd/Kconfig
+++ b/kernel/drivers/udd/Kconfig
@@ -3,8 +3,7 @@ menu "UDD support"
 config XENO_DRIVERS_UDD
 	tristate "User-space device driver framework"
 	help
-
-	A RTDM-based driver for enabling interrupt control and I/O
-	memory access interfaces to user-space device drivers.
+	  A RTDM-based driver for enabling interrupt control and I/O
+	  memory access interfaces to user-space device drivers.
 
 endmenu
-- 
2.39.5

