From: Hongzhan Chen <hongzhan.chen@intel.com>
Subject: [PATCH] testsuite/gpiobench: Provide choice to switch clock for
 getting timestamp
Date: Fri,  3 Sep 2021 00:33:05 -0400
Message-Id: <20210903043305.17533-1-hongzhan.chen@intel.com>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Provide choices to switch clock between MONO and REALTIME for getting
different timestamp since gpio driver already provide choosable service.

Signed-off-by: Hongzhan Chen <hongzhan.chen@intel.com>

diff --git a/testsuite/gpiobench/gpiobench.c b/testsuite/gpiobench/gpiobench.c
index 0f099b0e8..04c694639 100644
--- a/testsuite/gpiobench/gpiobench.c
+++ b/testsuite/gpiobench/gpiobench.c
@@ -85,6 +85,7 @@ struct test_info {
 	unsigned long total_cycles;
 	unsigned long max_histogram;
 	int mode;
+	int clockid;
 	int prio;
 	int quiet;
 	int tracelimit;
@@ -121,7 +122,10 @@ static void display_help(void)
 	       "                            must be specified\n"
 	       "-m       --testmode         0 is loopback mode\n"
 	       "                            1 is react mode which works with a latency box,\n"
-	       "                            default=0\n\n"
+	       "                            default=0\n"
+	       "-k       --clockid          0 is CLOCK_REALTIME\n"
+	       "                            1 is CLOCK_MONOTONIC,\n"
+	       "                            default=1\n\n"
 
 	       "e.g.     gpiobench -o 20 -i 21 -c pinctrl-bcm2835\n"
 		);
@@ -130,7 +134,7 @@ static void display_help(void)
 static void process_options(int argc, char *argv[])
 {
 	int c = 0;
-	static const char optstring[] = "h:p:m:l:c:b:i:o:q";
+	static const char optstring[] = "h:p:m:l:c:b:i:o:k:q";
 
 	struct option long_options[] = {
 		{ "bracetrace", required_argument, 0, 'b'},
@@ -142,6 +146,7 @@ static void process_options(int argc, char *argv[])
 		{ "intr", required_argument, 0, 'i'},
 		{ "pinctrl", required_argument, 0, 'c'},
 		{ "testmode", required_argument, 0, 'm'},
+		{ "clockid", required_argument, 0, 'k'},
 		{ 0, 0, 0, 0},
 	};
 
@@ -185,6 +190,11 @@ static void process_options(int argc, char *argv[])
 				MODE_REACT ? MODE_REACT : MODE_LOOPBACK;
 			break;
 
+		case 'k':
+			ti.clockid = atoi(optarg) >= CLOCK_MONOTONIC ?
+				CLOCK_MONOTONIC : CLOCK_REALTIME;
+			break;
+
 		default:
 			display_help();
 			exit(2);
@@ -291,7 +301,7 @@ static int rw_gpio(int value, int index)
 	struct rtdm_gpio_readout rdo;
 	long long gpio_write, gpio_read, inner_diff, outer_diff;
 
-	clock_gettime(CLOCK_MONOTONIC, &timestamp);
+	clock_gettime(ti.clockid, &timestamp);
 	gpio_write = calc_us(timestamp);
 
 	ret = write(ti.fd_dev_out, &value, sizeof(value));
@@ -306,7 +316,7 @@ static int rw_gpio(int value, int index)
 		return ret;
 	}
 
-	clock_gettime(CLOCK_MONOTONIC, &timestamp);
+	clock_gettime(ti.clockid, &timestamp);
 	gpio_read = calc_us(timestamp);
 
 	inner_diff = (rdo.timestamp - gpio_write) / 1000;
@@ -472,6 +482,7 @@ static void init_ti(void)
 	ti.gpio_out = -1;
 	ti.gpio_intr = -1;
 	ti.mode = MODE_LOOPBACK;
+	ti.clockid = CLOCK_MONOTONIC;
 
 	ti.ts.inner_min = ti.ts.outer_min = DEFAULT_LIMIT;
 	ti.ts.inner_max = ti.ts.outer_max = 0;
@@ -632,7 +643,9 @@ int main(int argc, char **argv)
 			goto out;
 		}
 
-		ret = ioctl(ti.fd_dev_intr, GPIO_RTIOC_TS_MONO, &value);
+		ret = ioctl(ti.fd_dev_intr,
+			ti.clockid == CLOCK_MONOTONIC ?
+			GPIO_RTIOC_TS_MONO : GPIO_RTIOC_TS_REAL, &value);
 		if (ret) {
 			printf("ioctl gpio port ts, failed\n");
 			goto out;
-- 
2.17.1


