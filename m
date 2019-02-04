From: Philippe Gerum <rpm@xenomai.org>
Subject: [PATCH 16/18] testsuite/smokey: net_client: improve stats readability
Date: Mon,  4 Feb 2019 11:56:45 +0100
Message-Id: <20190204105647.5034-17-rpm@xenomai.org>
In-Reply-To: <20190204105647.5034-1-rpm@xenomai.org>
References: <20190204105647.5034-1-rpm@xenomai.org>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org
Cc: Jan Kiszka <jan.kiszka@siemens.com>, Philippe Gerum <rpm@xenomai.org>

Visibale with --verbose=2.

Signed-off-by: Philippe Gerum <rpm@xenomai.org>
---
 testsuite/smokey/net_common/client.c | 26 ++++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/testsuite/smokey/net_common/client.c b/testsuite/smokey/net_common/client.c
index 093282547..d13d72918 100644
--- a/testsuite/smokey/net_common/client.c
+++ b/testsuite/smokey/net_common/client.c
@@ -17,7 +17,7 @@ static pthread_t tid;
 static unsigned long long glost, glate;
 
 static int rcv_packet(struct smokey_net_client *client, int sock, unsigned seq,
-		struct timespec *next_shot, bool last)
+		      struct timespec *next_shot, bool last, int *linesout)
 {
 	static unsigned long long gmin = ~0ULL, gmax = 0, gsum = 0, gcount = 0;
 	static unsigned long long min = ~0ULL, max = 0, sum = 0, count = 0,
@@ -115,16 +115,19 @@ static int rcv_packet(struct smokey_net_client *client, int sock, unsigned seq,
 	glost += lost - late;
 	glate += late;
 
-	smokey_trace("%g pps\t%Lu\t%Lu\t%.03gus\t%.03gus\t%.03gus\t"
-		"| %Lu\t%Lu\t%.03gus\t%.03gus\t%.03gus",
+	if (((*linesout)++ % 20) == 0) {
+		smokey_trace("\n   %-7s%6s%8s%8s%8s%8s%8s%10s",
+			     "PPS", "LOST", "LATE", "MIN", "MAX",
+			     "BEST", "AVG", "WORST");
+		smokey_trace("------------------------------------------------------------------");
+	}
+
+	smokey_trace("%8.2f  %6Ld  %6Ld     %.03g     %.03g     %.03g     %.03g     %.03g",
 		count / (diff / 1000000000.0),
-		lost - late,
-		late,
-		count ? min / 1000.0 : 0,
-		count ? (sum / (double)count) / 1000 : 0,
-		count ? max / 1000.0 : 0,
 		glost,
 		glate,
+		count ? min / 1000.0 : 0,
+		count ? max / 1000.0 : 0,
 		gcount ? gmin / 1000.0 : 0,
 		gcount ? (gsum / (double)gcount) / 1000 : 0,
 		gcount ? gmax / 1000.0 : 0);
@@ -143,11 +146,11 @@ static int rcv_packet(struct smokey_net_client *client, int sock, unsigned seq,
 static int smokey_net_client_loop(struct smokey_net_client *client)
 {
 	struct smokey_net_payload payload;
+	int sock, err, linesout = 0;
 	struct timespec next_shot;
 	struct sched_param prio;
 	char packet[256];
 	long long limit;
-	int sock, err;
 
 	sock = client->create_socket(client);
 	if (sock < 0)
@@ -164,6 +167,9 @@ static int smokey_net_client_loop(struct smokey_net_client *client)
 	if (err < 0)
 		goto err;
 
+	smokey_trace("\nPPS, LOST, LATE: packet count");
+	smokey_trace("MIN, MAX, BEST, AVG, WORST: microseconds");
+
 	limit = (long long)rate * duration;
 	for (payload.seq = 1;
 	     limit <= 0 || payload.seq < limit + 1; payload.seq++) {
@@ -192,7 +198,7 @@ static int smokey_net_client_loop(struct smokey_net_client *client)
 
 		do {
 			err = rcv_packet(client, sock, seq, &next_shot,
-					payload.seq == limit);
+					 payload.seq == limit, &linesout);
 			if (!err)
 				seq = 0;
 		} while (err != -ETIMEDOUT);
-- 
2.17.2


