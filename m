Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Message-Id: <8c50175f71b97232ddbe.1481551766@devws148.be.alcatel-lucent.com>
Date: Mon, 12 Dec 2016 15:09:26 +0100
From: Ronny Meeus <ronny.meeus@gmail.com>
Subject: [Xenomai] [PATCH v2] psos: add tunables to configure region 0
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

In the pSOS interface region 0 can be used by applications to allocate
memory from. It contains 'system' memory and is created by default during
system init. Region 0 is currently not supported by the xenomai psos skin.

This patch adds functionality to configure the total size and the unit
size by means of following tunabels:
  set_config_tunable(region0_size, 128000);
  set_config_tunable(region0_unitsize, 256);

The corresponding command-line options are:
  psos-rn0-size
  psos-rn0-unitsize

diff --git a/include/psos/tunables.h b/include/psos/tunables.h
--- a/include/psos/tunables.h
+++ b/include/psos/tunables.h
@@ -31,6 +31,8 @@ extern "C" {
 #endif /* __cplusplus */
 
 extern int psos_long_names;
+extern unsigned long psos_region0_size;
+extern unsigned long psos_region0_unitsize;
 
 static inline define_config_tunable(long_names, int, on)
 {
@@ -42,6 +44,26 @@ static inline read_config_tunable(long_n
 	return psos_long_names;
 }
 
+static inline define_config_tunable(region0_size, unsigned long, size)
+{
+	psos_region0_size = size;
+}
+
+static inline read_config_tunable(region0_size, unsigned long)
+{
+	return psos_region0_size;
+}
+
+static inline define_config_tunable(region0_unitsize, unsigned long, size)
+{
+	psos_region0_unitsize = size;
+}
+
+static inline read_config_tunable(region0_unitsize, unsigned long)
+{
+	return psos_region0_unitsize;
+}
+
 #ifdef __cplusplus
 }
 #endif /* __cplusplus */
diff --git a/lib/psos/init.c b/lib/psos/init.c
--- a/lib/psos/init.c
+++ b/lib/psos/init.c
@@ -47,6 +47,8 @@
  * - Partitions, Regions, Timers
  */
 int psos_long_names = 0;
+u_long psos_region0_size;
+u_long psos_region0_unitsize;
 
 static unsigned int clock_resolution = 1000000; /* 1ms */
 
@@ -70,6 +72,16 @@ static const struct option psos_options[
 		.flag = &psos_long_names,
 		.val = 1
 	},
+	{
+#define region0_size_opt	3
+		.name = "psos-rn0-size",
+		.has_arg = required_argument,
+	},
+	{
+#define region0_unitsize_opt	4
+		.name = "psos-rn0-unitsize",
+		.has_arg = required_argument,
+	},
 	{ /* Sentinel */ }
 };
 
@@ -82,6 +94,12 @@ static int psos_parse_option(int optnum,
 	case time_slice_opt:
 		time_slice_in_ticks = atoi(optarg);
 		break;
+	case region0_size_opt:
+		psos_region0_size = (u_long)atol(optarg);
+		break;
+	case region0_unitsize_opt:
+		psos_region0_unitsize = (u_long)atol(optarg);
+		break;
 	case long_names_opt:
 		break;
 	default:
@@ -96,6 +114,8 @@ static void psos_help(void)
 {
         fprintf(stderr, "--psos-clock-resolution=<ns>	tick value (default 1ms)\n");
         fprintf(stderr, "--psos-time-slice=<psos-ticks>	round-robin time slice\n");
+        fprintf(stderr, "--psos-rn0-size=<size>		region0 size in bytes\n");
+        fprintf(stderr, "--psos-rn0-unitsize=<usize>	region0 unit size in bytes (default 128 bytes)\n");
         fprintf(stderr, "--psos-long-names		enable long names for objects (> 4 characters)\n");
 }
 
@@ -124,6 +144,18 @@ static int psos_init(void)
 		return __bt(ret);
 	}
 
+	if (psos_region0_size) {
+		u_long rsize;
+		ret = rn_create("_RN0", xnmalloc(psos_region0_size), psos_region0_size,
+				(psos_region0_unitsize?psos_region0_unitsize:128), 0, &psos_region0_id, &rsize);
+		if (ret) {
+			warning("%s: failed to initialize pSOS region 0 (ret=%u)",
+				__FUNCTION__, ret);
+			return __bt(ret);
+		}
+	}
+
+
 	/* Convert pSOS ticks to timespec. */
 	clockobj_ticks_to_timespec(&psos_clock, time_slice_in_ticks, &psos_rrperiod);
 
diff --git a/lib/psos/rn.c b/lib/psos/rn.c
--- a/lib/psos/rn.c
+++ b/lib/psos/rn.c
@@ -35,9 +35,16 @@ struct pvcluster psos_rn_table;
 
 static unsigned long anon_rnids;
 
+u_long psos_region0_id = 0;
+
 static struct psos_rn *get_rn_from_id(u_long rnid, int *err_r)
 {
-	struct psos_rn *rn = mainheap_deref(rnid, struct psos_rn);
+	struct psos_rn *rn;
+
+	if (rnid == 0)
+		rnid = psos_region0_id;
+
+	rn = mainheap_deref(rnid, struct psos_rn);
 
 	if (rn == NULL || ((uintptr_t)rn & (sizeof(uintptr_t)-1)) != 0)
 		goto objid_error;
diff --git a/lib/psos/rn.h b/lib/psos/rn.h
--- a/lib/psos/rn.h
+++ b/lib/psos/rn.h
@@ -45,5 +45,6 @@ struct psos_rn_wait {
 };
 
 extern struct pvcluster psos_rn_table;
+extern u_long psos_region0_id;
 
 #endif /* _PSOS_RN_H */

