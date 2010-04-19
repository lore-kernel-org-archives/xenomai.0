From: Jan Kiszka <jan.kiszka@domain.hid>
Date: Mon, 19 Apr 2010 12:28:57 +0200
Message-Id: <06dce22ccaaf0649a89a0e1251926abf7d284032.1271672940.git.jan.kiszka@domain.hid>
In-Reply-To: <cover.1271672940.git.jan.kiszka@domain.hid>
References: <cover.1271672940.git.jan.kiszka@domain.hid>
In-Reply-To: <cover.1271672940.git.jan.kiszka@domain.hid>
References: <cover.1271672940.git.jan.kiszka@domain.hid>
Subject: [Xenomai-core] [PATCH v4 17/25] rttest: Resolved test device
	conflicts via separate name spaces
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai-core <xenomai@xenomai.org>

Usually, all devices of some RTDM class use the same naming scheme. But
as test devices are different as they do not provide compatible APIs,
let's give them separate name space for their device names. That finally
resolves all the detection troubles that showed up once more than one
test device was registered.

To allow addressing old drivers with new user space and vice versa, a
config switch is added to the former to select the naming scheme, and
the latter will try to open under both names.

Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
---
 include/rtdm/rttesting.h              |   10 +++++++---
 ksrc/drivers/testing/Config.in        |    2 ++
 ksrc/drivers/testing/Kconfig          |    9 +++++++++
 ksrc/drivers/testing/irqbench.c       |    9 +++++++--
 ksrc/drivers/testing/klat.c           |    8 +++++++-
 ksrc/drivers/testing/switchtest.c     |    7 ++++++-
 ksrc/drivers/testing/timerbench.c     |    7 ++++++-
 src/testsuite/irqbench/irqloop.c      |   11 ++++++++++-
 src/testsuite/latency/latency.c       |   12 +++++++++++-
 src/testsuite/switchtest/switchtest.c |   15 +++++++++++++--
 10 files changed, 78 insertions(+), 12 deletions(-)

diff --git a/include/rtdm/rttesting.h b/include/rtdm/rttesting.h
index ce0418e..a660139 100644
--- a/include/rtdm/rttesting.h
+++ b/include/rtdm/rttesting.h
@@ -29,13 +29,14 @@
  * Feel free to comment on this profile via the Xenomai mailing list
  * (xenomai@xenomai.org) or directly to the author (jan.kiszka@domain.hid).
  *
- * @b Profile @b Revision: 1
+ * @b Profile @b Revision: 2
  * @n
  * @n
  * @par Device Characteristics
  * @ref rtdm_device.device_flags "Device Flags": @c RTDM_NAMED_DEVICE @n
  * @n
- * @ref rtdm_device.device_name "Device Name": @c "rttest<N>", N >= 0 @n
+ * @ref rtdm_device.device_name "Device Name": @c "rttest[-<subclass>]<N>",
+ * N >= 0, optional subclass name to simplify device discovery @n
  * @n
  * @ref rtdm_device.device_class "Device Class": @c RTDM_CLASS_TESTING @n
  * @n
@@ -61,7 +62,7 @@
 
 #include <rtdm/rtdm.h>
 
-#define RTTST_PROFILE_VER		1
+#define RTTST_PROFILE_VER		2
 
 typedef struct rttst_bench_res {
 	long long avg;
@@ -145,8 +146,11 @@ struct rttst_swtest_error {
 /*!
  * @name Sub-Classes of RTDM_CLASS_TESTING
  * @{ */
+/** subclass name: "timerbench" */
 #define RTDM_SUBCLASS_TIMERBENCH	0
+/** subclass name: "irqbench" */
 #define RTDM_SUBCLASS_IRQBENCH		1
+/** subclass name: "switchtest" */
 #define RTDM_SUBCLASS_SWITCHTEST	2
 /** @} */
 
diff --git a/ksrc/drivers/testing/Config.in b/ksrc/drivers/testing/Config.in
index 07bd900..3552670 100644
--- a/ksrc/drivers/testing/Config.in
+++ b/ksrc/drivers/testing/Config.in
@@ -5,6 +5,8 @@
 mainmenu_option next_comment
 comment 'Testing drivers'
 
+bool 'Use legacy names for testing drivers' CONFIG_XENO_DRIVERS_TESTING_LEGACY_NAMES $CONFIG_XENO_SKIN_RTDM
+
 dep_tristate 'Timer benchmark driver' CONFIG_XENO_DRIVERS_TIMERBENCH $CONFIG_XENO_SKIN_RTDM
 
 dep_tristate 'IRQ benchmark driver' CONFIG_XENO_DRIVERS_IRQBENCH $CONFIG_XENO_SKIN_RTDM
diff --git a/ksrc/drivers/testing/Kconfig b/ksrc/drivers/testing/Kconfig
index 7ca2eb1..05d6a49 100644
--- a/ksrc/drivers/testing/Kconfig
+++ b/ksrc/drivers/testing/Kconfig
@@ -4,6 +4,15 @@ config XENO_TESTING_MODULE
         depends on MODULES
 	def_tristate m
 
+config XENO_DRIVERS_TESTING_LEGACY_NAMES
+	depends on XENO_SKIN_RTDM
+	bool "Use legacy names for testing drivers"
+	help
+	This lets the testing drivers register under legacy names
+	("rttest<N>") instead of the new scheme ("rttest-<subclass><N>").
+	Only enable this if you plan to use old userspace tools with the
+	drivers.
+
 config XENO_DRIVERS_TIMERBENCH
 	depends on XENO_SKIN_RTDM
 	tristate "Timer benchmark driver"
diff --git a/ksrc/drivers/testing/irqbench.c b/ksrc/drivers/testing/irqbench.c
index 3dfb646..ab9686a 100644
--- a/ksrc/drivers/testing/irqbench.c
+++ b/ksrc/drivers/testing/irqbench.c
@@ -515,8 +515,13 @@ static int __init __irqbench_init(void)
 	int err;
 
 	do {
-		snprintf(device.device_name, RTDM_MAX_DEVNAME_LEN, "rttest%d",
-			 start_index);
+		snprintf(device.device_name, RTDM_MAX_DEVNAME_LEN,
+#ifdef CONFIG_XENO_DRIVERS_TESTING_LEGACY_NAMES
+			 "rttest%d",
+#else
+			 "rttest-irqbench%d",
+#endif
+			  start_index);
 		err = rtdm_dev_register(&device);
 
 		start_index++;
diff --git a/ksrc/drivers/testing/klat.c b/ksrc/drivers/testing/klat.c
index 6070c26..9e3613e 100644
--- a/ksrc/drivers/testing/klat.c
+++ b/ksrc/drivers/testing/klat.c
@@ -99,7 +99,13 @@ static int __init klat_mod_init(void)
 	pkt.config.freeze_max = freeze_max;
 
 	for (dev_nr = 0; dev_nr < DEV_NR_MAX; dev_nr++) {
-		snprintf(devname, sizeof(devname), "rttest%d", dev_nr);
+		snprintf(devname, sizeof(devname),
+#ifdef CONFIG_XENO_DRIVERS_TESTING_LEGACY_NAMES
+			 "rttest%d",
+#else
+			 "rttest-timerbench%d",
+#endif
+			 dev_nr);
 		fd = rt_dev_open(devname, O_RDONLY);
 		if (fd < 0)
 			continue;
diff --git a/ksrc/drivers/testing/switchtest.c b/ksrc/drivers/testing/switchtest.c
index 057094b..e335bfb 100644
--- a/ksrc/drivers/testing/switchtest.c
+++ b/ksrc/drivers/testing/switchtest.c
@@ -750,7 +750,12 @@ int __init __switchtest_init(void)
 	int err;
 
 	do {
-		snprintf(device.device_name, RTDM_MAX_DEVNAME_LEN, "rttest%d",
+		snprintf(device.device_name, RTDM_MAX_DEVNAME_LEN,
+#ifdef CONFIG_XENO_DRIVERS_TESTING_LEGACY_NAMES
+			 "rttest%d",
+#else
+			 "rttest-switchtest%d",
+#endif
 			 start_index);
 		err = rtdm_dev_register(&device);
 
diff --git a/ksrc/drivers/testing/timerbench.c b/ksrc/drivers/testing/timerbench.c
index 0946a04..fcd040d 100644
--- a/ksrc/drivers/testing/timerbench.c
+++ b/ksrc/drivers/testing/timerbench.c
@@ -508,7 +508,12 @@ static int __init __timerbench_init(void)
 	int err;
 
 	do {
-		snprintf(device.device_name, RTDM_MAX_DEVNAME_LEN, "rttest%d",
+		snprintf(device.device_name, RTDM_MAX_DEVNAME_LEN,
+#ifdef CONFIG_XENO_DRIVERS_TESTING_LEGACY_NAMES
+			 "rttest%d",
+#else
+			 "rttest-timerbench%d",
+#endif
 			 start_index);
 		err = rtdm_dev_register(&device);
 
diff --git a/src/testsuite/irqbench/irqloop.c b/src/testsuite/irqbench/irqloop.c
index d4623b4..9298575 100644
--- a/src/testsuite/irqbench/irqloop.c
+++ b/src/testsuite/irqbench/irqloop.c
@@ -26,6 +26,11 @@
 #include <sys/mman.h>
 #include <rtdm/rttesting.h>
 
+static const char *devname_fmt[] = {
+	"/dev/rttest-irqbench%d",
+	"/dev/rttest%d",
+};
+
 static int benchdev;
 static int terminate;
 
@@ -81,6 +86,7 @@ int main(int argc, char *argv[])
 	int irq_set = 0;
 	int c;
 	int timeout = 10;
+	int fmt = 0;
 
 	while ((c = getopt(argc, argv, "D:t:P:o:a:i:")) != EOF)
 		switch (c) {
@@ -136,9 +142,12 @@ int main(int argc, char *argv[])
 
 	mlockall(MCL_CURRENT|MCL_FUTURE);
 
-	snprintf(devname, RTDM_MAX_DEVNAME_LEN, "/dev/rttest%d", benchdev_no);
+retry:
+	snprintf(devname, RTDM_MAX_DEVNAME_LEN, devname_fmt[fmt], benchdev_no);
 	benchdev = open(devname, O_RDWR);
 	if (benchdev < 0) {
+		if (fmt++ == 0)
+			goto retry;
 		perror("irqloop: failed to open benchmark device");
 		fprintf(stderr, "(modprobe xeno_irqbench?)\n");
 		return 1;
diff --git a/src/testsuite/latency/latency.c b/src/testsuite/latency/latency.c
index e9e741e..8c3ca87 100644
--- a/src/testsuite/latency/latency.c
+++ b/src/testsuite/latency/latency.c
@@ -67,6 +67,11 @@ long *histogram_avg = NULL, *histogram_max = NULL, *histogram_min = NULL;
 int do_histogram = 0, do_stats = 0, finished = 0;
 int bucketsize = 1000;		/* default = 1000ns, -B <size> to override */
 
+static const char *devname_fmt[] = {
+	"rttest-timerbench%d",
+	"rttest%d",
+};
+
 static inline void add_histogram(long *histogram, long addval)
 {
 	/* bucketsize steps */
@@ -473,6 +478,7 @@ int main(int argc, char **argv)
 	int cpu = 0, c, err, sig;
 	char task_name[16];
 	sigset_t mask;
+	int fmt = 0;
 
 	while ((c = getopt(argc, argv, "hp:l:T:qH:B:sD:t:fc:P:b")) != EOF)
 		switch (c) {
@@ -622,11 +628,15 @@ int main(int argc, char **argv)
 	if (test_mode != USER_TASK) {
 		char devname[RTDM_MAX_DEVNAME_LEN];
 
-		snprintf(devname, RTDM_MAX_DEVNAME_LEN, "rttest%d",
+retry:
+		snprintf(devname, RTDM_MAX_DEVNAME_LEN, devname_fmt[fmt],
 			 benchdev_no);
 		benchdev = rt_dev_open(devname, O_RDWR);
 
 		if (benchdev < 0) {
+			if (fmt++ == 0)
+				goto retry;
+
 			fprintf(stderr,
 				"latency: failed to open benchmark device, code %d\n"
 				"(modprobe xeno_timerbench?)\n", benchdev);
diff --git a/src/testsuite/switchtest/switchtest.c b/src/testsuite/switchtest/switchtest.c
index 9e4df10..7114a9f 100644
--- a/src/testsuite/switchtest/switchtest.c
+++ b/src/testsuite/switchtest/switchtest.c
@@ -888,13 +888,19 @@ static int task_create(struct cpu_tasks *cpu,
 
 #define DEV_NR_MAX 256
 
+static const char *devname_fmt[] = {
+	"/dev/rttest-switchtest%d",
+	"/dev/rttest%d",
+};
+
 static int open_rttest(char *buf, size_t size, unsigned count)
 {
 	static unsigned dev_nr = 0;
 	int fd, status;
+	int fmt = 0;
 
 	do {
-		snprintf(buf, size, "/dev/rttest%u", dev_nr);
+		snprintf(buf, size, devname_fmt[fmt], dev_nr);
 
 		status = fd = open(buf, O_RDWR);
 
@@ -913,6 +919,11 @@ static int open_rttest(char *buf, size_t size, unsigned count)
 		if (++dev_nr != DEV_NR_MAX)
 			continue;
 
+		if (fmt++ == 0) {
+			dev_nr = 0;
+			continue;
+		}
+
 		fprintf(stderr, "switchtest: Unable to open switchtest device.\n"
 			"(modprobe xeno_switchtest ?)\n");
 
@@ -1110,7 +1121,7 @@ int main(int argc, const char *argv[])
 	const char *progname = argv[0];
 	struct cpu_tasks *cpus;
 	struct sched_param sp;
-	char devname[21];
+	char devname[RTDM_MAX_DEVNAME_LEN+1];
 	sigset_t mask;
 	int sig;
 
-- 
1.6.0.2


