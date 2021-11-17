From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [xenomai-images][PATCH 4/4] Add kas menu support
Date: Wed, 17 Nov 2021 19:34:19 +0100
Message-Id: <7c87984cc4088d2f398283ae4b970ffa487b79d9.1637174059.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1637174059.git.jan.kiszka@siemens.com>
References: <cover.1637174059.git.jan.kiszka@siemens.com>
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

From: Jan Kiszka <jan.kiszka@siemens.com>

With kas 2.6, we can provide a kconfig-like interactive menu to select
the desired image configuration. Add such a menu to model the complex
dependencies properly and provide an easy way to expore available
options. Also update the README accordingly.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 .gitignore |   1 +
 Kconfig    | 148 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 README.md  |  20 ++++----
 3 files changed, 158 insertions(+), 11 deletions(-)
 create mode 100644 Kconfig

diff --git a/.gitignore b/.gitignore
index a7053b5..a796dba 100644
--- a/.gitignore
+++ b/.gitignore
@@ -1,2 +1,3 @@
 build
 isar
+.config.yaml*
diff --git a/Kconfig b/Kconfig
new file mode 100644
index 0000000..8337d3f
--- /dev/null
+++ b/Kconfig
@@ -0,0 +1,148 @@
+mainmenu "Xenomai Reference Images"
+
+config KAS_INCLUDE_MAIN
+	string
+	default "kas.yml"
+
+config KAS_BUILD_SYSTEM
+	string
+	default "isar"
+
+config ARCH_X86
+	bool
+
+config ARCH_ARM
+	bool
+
+config ARCH_ARM64
+	bool
+
+choice
+	prompt "Target board"
+	default TARGET_QEMU_AMD64
+
+config TARGET_QEMU_AMD64
+	bool "QEMU/KVM Intel-x86 virtual target"
+	select ARCH_X86
+
+config TARGET_X86_64_EFI
+	bool "Generic x86-64 EFI target"
+	select ARCH_X86
+
+config TARGET_QEMU_ARM
+	bool "QEMU ARM virtual target"
+	select ARCH_ARM
+
+config TARGET_BBB
+	bool "BeagleBone Black"
+	select ARCH_ARM
+
+config TARGET_QEMU_ARM64
+	bool "QEMU ARM64 virtual target"
+	select ARCH_ARM64
+
+config TARGET_HIKEY
+	bool "LeMaker HiKey"
+	select ARCH_ARM64
+
+endchoice
+
+config KAS_INCLUDE_TARGET
+	string
+	default "board-qemu-amd64.yml" if TARGET_QEMU_AMD64
+	default "board-x86-64-efi.yml" if TARGET_X86_64_EFI
+	default "board-qemu-arm.yml" if TARGET_QEMU_ARM
+	default "board-beagle-bone-black.yml" if TARGET_BBB
+	default "board-qemu-arm64.yml" if TARGET_QEMU_ARM64
+	default "board-hikey.yml" if TARGET_HIKEY
+
+choice
+	prompt "Xenomai version"
+	default XENOMAI_3_2
+
+config XENOMAI_LATEST
+	bool "Head of next branch"
+
+config XENOMAI_3_2
+	bool "Latest 3.2.x release"
+
+config XENOMAI_3_1_LATEST
+	bool "Head of stable/v3.1.x branch"
+
+config XENOMAI_3_0_LATEST
+	bool "Head of stable/v3.0.x branch"
+	depends on !ARCH_ARM64
+
+endchoice
+
+config KAS_INCLUDE_XENOMAI
+	string
+	default "opt-xenomai-next.yml" if XENOMAI_LATEST
+	default "opt-xenomai-3.1.x.yml" if XENOMAI_3_1_LATEST
+	default "opt-xenomai-3.0.x.yml" if XENOMAI_3_0_LATEST
+
+choice
+	prompt "Kernel version"
+	default KERNEL_5_10
+
+config KERNEL_5_10_LATEST
+	bool "Head of 5.10 Dovetail branch"
+	depends on XENOMAI_LATEST || XENOMAI_3_2
+
+config KERNEL_5_10
+	bool "Latest 5.10 Dovetail version"
+	depends on XENOMAI_LATEST || XENOMAI_3_2
+
+config KERNEL_5_4_LATEST
+	bool "Head of 5.4 I-pipe branch"
+	depends on !XENOMAI_3_0_LATEST
+
+config KERNEL_5_4
+	bool "Latest 5.4 I-pipe version"
+	depends on !XENOMAI_3_0_LATEST
+
+config KERNEL_4_19_LATEST
+	bool "Head of 4.19-cip I-pipe branch"
+	depends on !XENOMAI_3_0_LATEST
+
+config KERNEL_4_19
+	bool "Latest 4.19-cip I-pipe version"
+	depends on !XENOMAI_3_0_LATEST
+
+config KERNEL_4_4_LATEST
+	bool "Head of 4.4-cip I-pipe branch"
+	depends on XENOMAI_3_0_LATEST
+
+config KERNEL_4_4
+	bool "Latest 4.4-cip I-pipe version"
+	depends on XENOMAI_3_0_LATEST
+
+endchoice
+
+config KAS_INCLUDE_KERNEL
+	string
+	default "opt-linux-latest-5.10.yml" if KERNEL_5_10_LATEST
+	default "opt-linux-5.10.yml" if KERNEL_5_10
+	default "opt-linux-latest-5.4.yml" if KERNEL_5_4_LATEST
+	default "opt-linux-5.4.yml" if KERNEL_5_4
+	default "opt-linux-latest-4.19.yml" if KERNEL_4_19_LATEST
+	default "opt-linux-4.19.yml" if KERNEL_4_19
+	default "opt-linux-latest-4.4.yml" if KERNEL_4_4_LATEST
+	default "opt-linux-4.4.yml" if KERNEL_4_4
+
+comment "Features"
+
+config DEBUG
+	bool "Build debug version"
+	help
+	  This enables various debug options in the kernel that can help to
+	  validate the correctness of a particular Xenomai version and kernel
+	  patch.
+
+	  However, these options also significantly degrade the performance and
+	  maximum latencies, so don't use such a configuration for
+	  benchmarking!
+
+config KAS_INCLUDE_DEBUG
+	string
+	default "opt-debug.yml" if DEBUG
diff --git a/README.md b/README.md
index 2f48181..77296dc 100644
--- a/README.md
+++ b/README.md
@@ -13,25 +13,23 @@ from scratch.
 
 Install `kas-container` from the [kas project](https://github.com/siemens/kas):
 
-    wget https://raw.githubusercontent.com/siemens/kas/2.4/kas-container -P ~/bin/
+    wget https://raw.githubusercontent.com/siemens/kas/2.6.2/kas-container -P ~/bin/
     chmod a+x ~/bin/kas-container
 
 Furthermore, install docker and make sure you have required permissions to
 start containers.
 
-To build, e.g., the QEMU AMD64 target inside Docker, invoke kas-container like
-this:
+Next invoke the configuration menu to select the desired image configuration
+and start the build:
 
-    kas-container build kas.yml:board-qemu-amd64.yml
+    kas-container menu
 
-This image can be run using `start-qemu.sh x86`.
+If you built, e.g., a QEMU AMD64 image, this can be run using
+`start-qemu.sh x86`.
 
-The QEMU ARM64 target is selected by `... kas.yml:board-qemu-arm64.yml` and
-started via `start-qemu.sh arm64`. Make sure to have `qemu-aarch64-system`
-installed.
-
-Xenomai related debug is switched off by default. But you still can switch it
-on like this:
+You can also select the desired image configuration on the command line.  To
+build the QEMU AMD64 target with debug options enabled, invoke kas-container
+like this:
 
     kas-container build kas.yml:board-qemu-amd64.yml:opt-debug.yml
 
-- 
2.31.1


