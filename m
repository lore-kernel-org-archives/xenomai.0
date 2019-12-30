MIME-Version: 1.0
From: Laurentiu-Cristian Duca <laurentiu.duca@gmail.com>
Date: Mon, 30 Dec 2019 17:11:43 +0200
Message-ID: <CAPm8-H508VRig12CTHGn8=FLBJO-q2yeBbtrd4USHsqWD4=nUA@mail.gmail.com>
Subject: [patch 5/5] spitest.c: adding ioctl(SPI_RTIOC_TRANSFER_N,
 TRANSFER_SIZE)
Content-Type: text/plain; charset="UTF-8"
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai <xenomai@xenomai.org>

>From a642fc578486af9f232033db216cdff8f27ab779 Mon Sep 17 00:00:00 2001
From: Laurentiu-Cristian Duca <laurentiu.duca@gmail.com>
Date: Mon, 30 Dec 2019 16:53:21 +0200
Subject: [PATCH] spitest.c: extending spi_transfer test in order to allow
 testing ioctl(SPI_RTIOC_TRANSFER_N, TRANSFER_SIZE) via ioctl_n parameter

- the ioctl_n user parameter must be set to non-zero value
in order to perform ioctl(SPI_RTIOC_TRANSFER_N, TRANSFER_SIZE);
if ioctl_n is 0 or undefined then the test performs ioctl(SPI_RTIOC_TRANSFER).
- default SPI clock speed set to 40MHz
because bbb am335x realtime SPI driver has its maximum set to this value.

Signed-off-by: Laurentiu-Cristian Duca <laurentiu.duca@gmail.com>
---
 testsuite/spitest/spitest.c | 27 +++++++++++++++++++++------
 1 file changed, 21 insertions(+), 6 deletions(-)

diff --git a/testsuite/spitest/spitest.c b/testsuite/spitest/spitest.c
index debf1b673..2ca25f457 100644
--- a/testsuite/spitest/spitest.c
+++ b/testsuite/spitest/spitest.c
@@ -40,17 +40,19 @@ smokey_test_plugin(spi_transfer,
 			   SMOKEY_STRING(device),
 			   SMOKEY_INT(speed),
 			   SMOKEY_BOOL(latency),
+			   SMOKEY_INT(ioctl_n)
 		   ),
    "Run a SPI transfer.\n"
    "\tdevice=<device-path>\n"
    "\tspeed=<speed-hz>\n"
-   "\tlatency"
+   "\tlatency\n"
+   "\tioctl_n=<set to non-zero to use ioctl(SPI_RTIOC_TRANSFER_N)>"
 );

 #define ONE_BILLION	1000000000
 #define TEN_MILLIONS	10000000

-static int with_traffic = 1, with_latency;
+static int with_traffic = 1, with_latency, with_ioctl_n = 0;

 #define SEQ_SHIFT 24
 #define SEQ_MASK  ((1 << SEQ_SHIFT) - 1)
@@ -311,8 +313,16 @@ static int do_spi_loop(int fd)
 			if (ret < 0)
 				break;
 			clock_gettime(CLOCK_MONOTONIC, &start);
-			if (!__Terrno(ret, ioctl(fd, SPI_RTIOC_TRANSFER)))
-				return ret;
+			if(with_ioctl_n == 0) {
+				if (!__Terrno(ret,
+					ioctl(fd, SPI_RTIOC_TRANSFER)))
+					return ret;
+			} else {
+                                if (!__Terrno(ret,
+					ioctl(fd, SPI_RTIOC_TRANSFER_N,
+						TRANSFER_SIZE)))
+                                        return ret;
+			}
 			if (with_latency) {
 				clock_gettime(CLOCK_MONOTONIC, &now);
 				dt = (int32_t)diff_ts(&now, &start);
@@ -348,7 +358,7 @@ static int do_spi_loop(int fd)

 static int run_spi_transfer(struct smokey_test *t, int argc, char
*const argv[])
 {
-	int fd, ret, speed_hz = 60000000;
+	int fd, ret, speed_hz = 40000000;
 	struct rtdm_spi_config config;
 	struct rtdm_spi_iobufs iobufs;
 	const char *device = NULL;
@@ -366,7 +376,12 @@ static int run_spi_transfer(struct smokey_test
*t, int argc, char *const argv[])

 	if (SMOKEY_ARG_ISSET(spi_transfer, speed))
 		speed_hz = SMOKEY_ARG_INT(spi_transfer, speed);
-	
+
+        if (SMOKEY_ARG_ISSET(spi_transfer, ioctl_n)) {
+		with_ioctl_n = SMOKEY_ARG_INT(spi_transfer, ioctl_n);
+		smokey_note("ioctl_n enabled; using SPI_RTIOC_TRANSFER_N");
+	}
+
 	if (!SMOKEY_ARG_ISSET(spi_transfer, device)) {
 		warning("missing device= specification");
 		return -EINVAL;
-- 
2.17.1

