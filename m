From: Philippe  Gerum <rpm@xenomai.org>
Subject: [PATCH 12/13] cobalt/init: ipipe: remove clock frequency override
Date: Sun, 31 Jan 2021 15:45:39 +0100
Message-Id: <20210131144540.243363-12-rpm@xenomai.org>
In-Reply-To: <20210131144540.243363-1-rpm@xenomai.org>
References: <20210131144540.243363-1-rpm@xenomai.org>
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

Regarding the frequency of the clock hardware, the kernel knows
better. This parameter dates back to the dark ages when the kernel
might not have detected variations in (per-CPU) clock frequency, which
is no more an issue nowadays.

Actually, we do want to rely on the non-trivial logic the kernel has
to figure out that value dynamically for us.

So let's drop the user override for this parameter.

Signed-off-by: Philippe Gerum <rpm@xenomai.org>
---
 doc/asciidoc/MIGRATION.adoc      |  1 -
 doc/asciidoc/README.INSTALL.adoc |  7 -------
 kernel/cobalt/ipipe/init.c       | 13 +------------
 3 files changed, 1 insertion(+), 20 deletions(-)

diff --git a/doc/asciidoc/MIGRATION.adoc b/doc/asciidoc/MIGRATION.adoc
index ced356548..dce7f40e9 100644
--- a/doc/asciidoc/MIGRATION.adoc
+++ b/doc/asciidoc/MIGRATION.adoc
@@ -74,7 +74,6 @@ enabled (default), unless *linuxthreads* are used instead of *NPTL*.
 System parameters renamed::
 
 * xeno_hal.supported_cpus -> xenomai.supported_cpus
-* xeno_hal.clockfreq -> xenomai.clockfreq
 * xeno_hal.disable -> xenomai.state=disabled
 * xeno_hal.cpufreq -> xenomai.cpufreq
 * xeno_nucleus.watchdog_timeout -> xenomai.watchdog_timeout
diff --git a/doc/asciidoc/README.INSTALL.adoc b/doc/asciidoc/README.INSTALL.adoc
index fc3f52964..da96686b4 100644
--- a/doc/asciidoc/README.INSTALL.adoc
+++ b/doc/asciidoc/README.INSTALL.adoc
@@ -147,13 +147,6 @@ documentation about the
 link:../documentation/xenomai-3/html/man1/corectl/index.html[corectl(1)]
 utility for a description of these states. | enabled
 
-|xenomai.clockfreq=<hz-freq> | Override the real-time clock frequency
-used in measuring time intervals with the given value. The most
-accurate value is normally determined by the Cobalt core automatically
-when initializing. It is strongly recommended *not* to use this option
-unless you really know what you are doing. This value is expressed in
-HZ. | 0 (=calibrated)
-
 |xenomai.smi=<state> | *x86-specific*: Set the state of the SMI
 workaround. The possible values are _disabled_, _detect_ and
 _enabled_. See the discussion about link:dealing-with-x86-SMI[SMIs]
diff --git a/kernel/cobalt/ipipe/init.c b/kernel/cobalt/ipipe/init.c
index 2533d99ba..1b3696b2f 100644
--- a/kernel/cobalt/ipipe/init.c
+++ b/kernel/cobalt/ipipe/init.c
@@ -11,9 +11,6 @@
 #include <cobalt/kernel/sched.h>
 #include <cobalt/kernel/clock.h>
 
-static unsigned long clockfreq_arg;
-module_param_named(clockfreq, clockfreq_arg, ulong, 0444);
-
 int __init pipeline_init(void)
 {
 	struct ipipe_sysinfo sysinfo;
@@ -25,15 +22,7 @@ int __init pipeline_init(void)
 
 	ipipe_get_sysinfo(&sysinfo);
 
-	if (clockfreq_arg == 0)
-		clockfreq_arg = sysinfo.sys_hrclock_freq;
-
-	if (clockfreq_arg == 0) {
-		printk(XENO_ERR "null clock frequency? Aborting.\n");
-		return -ENODEV;
-	}
-
-	cobalt_pipeline.clock_freq = clockfreq_arg;
+	cobalt_pipeline.clock_freq = sysinfo.sys_hrclock_freq;
 
 	if (cobalt_machine.init) {
 		ret = cobalt_machine.init();
-- 
2.26.2


