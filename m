Message-ID: <4D306110.7000104@domain.hid>
Date: Fri, 14 Jan 2011 15:43:28 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] [PATCH] Add INTEL_IDLE to list of problematic config
	options
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Xenomai core <Xenomai-core@domain.hid>

See TROUBLESHOOTING for explanation.

Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
---
 TROUBLESHOOTING      |    4 ++++
 scripts/Kconfig.frag |    9 +++++----
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/TROUBLESHOOTING b/TROUBLESHOOTING
index 4d84a79..e8d4b53 100644
--- a/TROUBLESHOOTING
+++ b/TROUBLESHOOTING
@@ -57,6 +57,10 @@ sleep states, increasing latency in ways dependent upon both the
 BIOS's ACPI tables and code.  You may be able to suppress the sleeping
 with 'idle=poll' boot-arg, test to find out
 
+INTEL_IDLE: Just like ACPI_PROCESSOR, this idle driver sends the CPU
+into deep C states, also causing huge latencies because the APIC timer
+that Xenomai uses may not fire anymore.
+
 Summarizing, the latencies incurred here are dependent upon CPU, BIOS,
 and motherboard; ie they're hard to predict, so we are conservative.
 Feel free to test on your platform, (xeno-test runs testsuite/latency
diff --git a/scripts/Kconfig.frag b/scripts/Kconfig.frag
index 3a52ed4..c136ebf 100644
--- a/scripts/Kconfig.frag
+++ b/scripts/Kconfig.frag
@@ -1,10 +1,11 @@
 
 menu "Real-time sub-system"
 
-comment "WARNING! You enabled APM, CPU Frequency scaling or ACPI 'processor'"
-	depends on APM || CPU_FREQ || ACPI_PROCESSOR
-comment "option. These options are known to cause troubles with Xenomai."
-	depends on APM || CPU_FREQ || ACPI_PROCESSOR
+if APM || CPU_FREQ || ACPI_PROCESSOR || INTEL_IDLE
+comment "WARNING! You enabled APM, CPU Frequency scaling, ACPI 'processor'"
+comment "or Intel cpuidle option. These options are known to cause troubles"
+comment "with Xenomai, disable them."
+endif
 
 comment "NOTE: Xenomai conflicts with PC speaker support."
 	depends on !X86_TSC && X86 && INPUT_PCSPKR
-- 
1.7.1

