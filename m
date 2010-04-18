From: Jan Kiszka <Jan Kiszka jan.kiszka@domain.hid>
Date: Sun, 18 Apr 2010 15:12:42 +0200
Message-Id: <35eafa7c55fbb2c6f68873ae2c62bc7e644c9eed.1271596367.git.Jan
	Kiszka jan.kiszka@domain.hid>
In-Reply-To: <cover.1271596366.git.Jan Kiszka jan.kiszka@domain.hid>
References: <cover.1271596366.git.Jan Kiszka jan.kiszka@domain.hid>
In-Reply-To: <cover.1271596366.git.Jan Kiszka jan.kiszka@domain.hid>
References: <cover.1271596366.git.Jan Kiszka jan.kiszka@domain.hid>
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] [PATCH v3 18/24] testing: Clean up Kconfig rules
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Jan Kiszka <jan.kiszka@domain.hid>, xenomai-core <xenomai@xenomai.org>

From: Jan Kiszka <jan.kiszka@domain.hid>

To exclude modules from built-in, make them depend on 'm' is sufficient.

Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
---
 ksrc/drivers/testing/Config.in |    2 +-
 ksrc/drivers/testing/Kconfig   |   14 +++++---------
 2 files changed, 6 insertions(+), 10 deletions(-)

diff --git a/ksrc/drivers/testing/Config.in b/ksrc/drivers/testing/Config.in
index 3552670..215c38d 100644
--- a/ksrc/drivers/testing/Config.in
+++ b/ksrc/drivers/testing/Config.in
@@ -15,6 +15,6 @@ dep_tristate 'Context switches test driver' CONFIG_XENO_DRIVERS_SWITCHTEST $CONF
 
 dep_tristate 'Kernel-only latency measurement module' CONFIG_XENO_DRIVERS_KLATENCY $CONFIG_XENO_DRIVERS_TIMERBENCH m
 
-dep_tristate 'User-space real-time signals testing module' CONFIG_XENO_DRIVERS_SIGTEST $CONFIG_MODULES m
+dep_tristate 'User-space real-time signals testing module' CONFIG_XENO_DRIVERS_SIGTEST m
 
 endmenu
diff --git a/ksrc/drivers/testing/Kconfig b/ksrc/drivers/testing/Kconfig
index 05d6a49..883ede1 100644
--- a/ksrc/drivers/testing/Kconfig
+++ b/ksrc/drivers/testing/Kconfig
@@ -1,9 +1,5 @@
 menu "Testing drivers"
 
-config XENO_TESTING_MODULE
-        depends on MODULES
-	def_tristate m
-
 config XENO_DRIVERS_TESTING_LEGACY_NAMES
 	depends on XENO_SKIN_RTDM
 	bool "Use legacy names for testing drivers"
@@ -22,7 +18,7 @@ config XENO_DRIVERS_TIMERBENCH
 	See testsuite/latency for a possible front-end.
 
 config XENO_DRIVERS_KLATENCY
-	depends on XENO_DRIVERS_TIMERBENCH && XENO_TESTING_MODULE
+	depends on XENO_DRIVERS_TIMERBENCH && m
 	tristate "Kernel-only latency measurement module"
 	help
 	Kernel module for kernel-only latency measurement.
@@ -44,9 +40,9 @@ config XENO_DRIVERS_SWITCHTEST
 	FPU switches.
 
 config XENO_DRIVERS_SIGTEST
-       depends on XENO_TESTING_MODULE
-       tristate "User-space real-time signals testing module"
-       help
-       Elementary skin for unit testing user-space real-time signals.
+	depends on m
+	tristate "User-space real-time signals testing module"
+	help
+	Elementary skin for unit testing user-space real-time signals.
 
 endmenu
-- 
1.6.0.2


