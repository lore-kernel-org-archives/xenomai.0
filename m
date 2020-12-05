From: Philippe  Gerum <rpm@xenomai.org>
Subject: [PATCH 1/4] cobalt/arm: disable unlocked context switching
Date: Sat,  5 Dec 2020 13:00:11 +0100
Message-Id: <20201205120014.2754097-2-rpm@xenomai.org>
In-Reply-To: <20201205120014.2754097-1-rpm@xenomai.org>
References: <20201205120014.2754097-1-rpm@xenomai.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

From: Philippe Gerum <rpm@xenomai.org>

Allowing the task context switching code to be preempted by local
interrupts was an optimization targeted at low-end ARM armv4/5 cores
with sluggish VIVT caches, at the expense of significant complexity in
the IRQ pipeline and Cobalt scheduler. Support for armv4/5 is long
gone for Xenomai, and maintaining such feature is not worth the burden
with the VIPT caches exhibited by current micro-architectures such as
armv7.

Dovetail provides some form of preemptible context switching of
in-band tasks specifically, which requires no support from Cobalt.

So we may disable this Cobalt-specific feature entirely for ARM.

Signed-off-by: Philippe Gerum <rpm@xenomai.org>
---
 kernel/cobalt/arch/arm/Kconfig | 22 ----------------------
 1 file changed, 22 deletions(-)

diff --git a/kernel/cobalt/arch/arm/Kconfig b/kernel/cobalt/arch/arm/Kconfig
index 0c4e0aa82..d81ff4c59 100644
--- a/kernel/cobalt/arch/arm/Kconfig
+++ b/kernel/cobalt/arch/arm/Kconfig
@@ -1,28 +1,6 @@
 source "kernel/xenomai/Kconfig"
 source "drivers/xenomai/Kconfig"
 
-menu "Machine/platform-specific options"
-
-config XENO_ARCH_UNLOCKED_SWITCH
-	bool "Unlocked context switch"
-	default y
-	help
-	The Cobalt core may allow non-atomic execution of the
-	machine-dependent context switching code, so that other CPUs
-	and/or local interrupts may execute concurrently.
-
-	This option reduces interrupt latency when costly cache and
-	TLB flushes are required to switch context.
-
-	You definitely want to enable that option on low-end ARM
-	platforms.
-endmenu
-
-config IPIPE_WANT_PREEMPTIBLE_SWITCH
-	bool
-	default y if XENO_ARCH_UNLOCKED_SWITCH
-	default n if !XENO_ARCH_UNLOCKED_SWITCH
-
 config XENO_ARCH_FPU
 	def_bool VFP
 
-- 
2.26.2


