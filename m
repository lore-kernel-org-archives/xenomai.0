Message-ID: <4443C1B6.1080802@domain.hid>
Date: Mon, 17 Apr 2006 12:26:30 -0400
From: Jim Cromie <jim.cromie@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------070302050508040708000708"
Subject: [Xenomai-core] [patch]  TROUBLESHOOTING additions, README tweaks
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

This is a multi-part message in MIME format.
--------------070302050508040708000708
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


heres another try.

contains some speculative explanations that perhaps warrant rewording.

The regular reader will also detect some prose poached from this ML ;-)

--------------070302050508040708000708
Content-Type: text/plain;
 name="patch-readme-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-readme-2"

Index: TROUBLESHOOTING
===================================================================
--- TROUBLESHOOTING	(revision 935)
+++ TROUBLESHOOTING	(working copy)
@@ -6,6 +6,46 @@
                            GENERIC
 ===================================================================
 
+Q: Which CONFIG_* items are latency killers, and should be avoided ?
+
+A: Heres an enumeration.  Several of these are discussed in greater
+detail later.  Feel free to verify that these cause latencies to
+explode (xeno-test runs testsuite/latency 3 different ways), but keep
+in mind that before you rely on the numbers, you must create workloads
+that will excersize all the hardware used for your RT application.
+
+CONFIG_CPU_FREQ: This allows the CPU frequency to be modulated with
+workload, but many CPUs change the TSC counting frequency also, which
+makes it useless for accurate timing when the CPU clock can change.
+
+ACPI_PROCESSOR: ACPI is a complex BIOS functionality, and BIOS code is
+never written with RT-latency in mind.  If enabled, this BIOS code can
+be invoked at a pseudo-SMI priority, which breaks the rule that
+adeos-ipipe must be in charge of such things.  DISABLE_SMI doesnt help
+here (more later).
+
+PM & APM: Linux power management features also use the BIOS, so ACPI
+comments apply here too.
+
+______________________________________________________________________
+
+Q: How do I adequately stress-test ?
+
+A: xeno-test has a very basic workload generator, whose main virtue is
+that its nearly universally available.
+
+    dd if=/dev/zero if=/dev/null
+
+You can change the input device (-d /dev/hda1) to get real device
+activity and interrupts, and/or -w 4 to run more workload tasks.  For
+more thorough testing, use -W <your-script>.
+
+If you are looking for real heavy load: cache benchmarks tend to
+stress your system most, http://www.cwi.nl/~manegold/Calibrator for
+example. Combine them with heavy i/o load (flood ping etc.).
+
+______________________________________________________________________
+
 Q: My user-space application has unexpected latencies which seem to
 appear when transitioning from primary (Xenomai) to secondary (native
 Linux) real-time modes. Why?
Index: README.INSTALL
===================================================================
--- README.INSTALL	(revision 935)
+++ README.INSTALL	(working copy)
@@ -74,12 +74,14 @@
 Once the target kernel has been prepared, all Xenomai configuration
 options are available from the "Real-time subsystem" toplevel menu.
 
-Once configured, the kernel should be built as usual.
+There are several configure options that cause large latencies; they
+should be avoided.  The TROUBLESHOOTING file identifies them and
+explains the issues with their use.  Once configured, the kernel
+should be built as usual.
 
-It might be a good idea to put all the output into a different build
-directory as to build from from linux source several targets. For each
-target add O=../build-<target> to each make invocation. See section 2.2 
-for an example.
+If you want several different configs/builds at hand, you can reuse
+the same source by adding O=../build-<target> to each make
+invocation. See section 2.2 for an example.
 
 In order to cross-compile the Linux kernel, pass an ARCH and
 CROSS_COMPILE variable on make command line. See sections 2.2, 2.3 and
@@ -105,7 +107,9 @@
 albeit the kernel has been compiled with CONFIG_X86_TSC disabled would
 certainly lead to runtime problems if uncaught, since Xenomai and the
 application would not agree on the high precision clock to use for
-their timings.
+their timings.  Furthermore, most of these issues cannot be probed for
+during compilation, because the target generally has different
+features than the host, even when theyre the same arch (ex 386 vs 686)
 
 In order to solve those potential issues, each Xenomai architecture
 port defines a set of critical features which is tested for
@@ -126,8 +130,8 @@
 kernel built with CONFIG_X86_TSC set, since the x86-tsc option's
 binding is strong.
 
-1.3.2 Generic options
----------------------
+1.3.2 Generic configure options
+-------------------------------
 
 NAME                 DESCRIPTION                     [BINDING,]DEFAULT(*)
 
@@ -137,15 +141,17 @@
 --enable-debug       Enable debug symbols (-g)       disabled
 --enable-smp         Enable SMP support              weak,disabled
 
-1.3.3 Arch-specific options
----------------------------
+1.3.3 Arch-specific configure options
+-------------------------------------
 
 NAME                DESCRIPTION                      [BINDING,]DEFAULT(*)
 
 --enable-x86-sep    Enable x86 SEP instructions      strong,disabled
-                    for issuing syscalls
+                    for issuing syscalls.
+		    You will also need NPTL
 
 --enable-x86-tsc    Enable x86 TSC for timings       strong,enabled
+		    You must have TSC for this.
 
 --enable-arm-arch   Define version of the target     strong,"4"
                     ARM core architecture
@@ -254,7 +260,7 @@
 2.4 Building for the Blackfin
 -----------------------------
 
-The Blackfin is a MMU-less, DSP-type architecture running
+The Blackfin is an MMU-less, DSP-type architecture running
 uClinux.
 
 $ $xenomai_root/scripts/prepare-kernel.sh --arch=blackfin \

--------------070302050508040708000708--

