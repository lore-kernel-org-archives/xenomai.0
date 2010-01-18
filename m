Message-ID: <4B546AD0.3060106@domain.hid>
Date: Mon, 18 Jan 2010 15:06:08 +0100
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] [PATCH] rtcan_rtt:  Various fixes and improvement
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai-core <xenomai@xenomai.org>

This patch fixes type long overflows, invalid command line argument
types and gives the receiver and transmitter thread dedicated names.

Signed-off-by: Wolfgang Grandegger <wg@domain.hid>

diff --git a/examples/rtdm/profiles/can/rtcan_rtt.c
b/examples/rtdm/profiles/can/rtcan_rtt.c
index 93c84a6..2280562 100644
--- a/examples/rtdm/profiles/can/rtcan_rtt.c
+++ b/examples/rtdm/profiles/can/rtcan_rtt.c
@@ -94,6 +94,7 @@ void *transmitter(void *arg)
     frame.can_id = can_id;
     frame.can_dlc = sizeof(*rtt_time);

+    pthread_set_name_np(pthread_self(), "rtcan_rtt_transmitter");
     pthread_setschedparam(pthread_self(), SCHED_FIFO, &param);

     clock_gettime(CLOCK_MONOTONIC, &next_period);
@@ -113,7 +114,7 @@ void *transmitter(void *arg)
 	}

         clock_gettime(CLOCK_MONOTONIC, &time);
-	*rtt_time = time.tv_sec * NSEC_PER_SEC + time.tv_nsec;
+	*rtt_time = (long long)time.tv_sec * NSEC_PER_SEC + time.tv_nsec;

         /* Transmit the message containing the local time */
 	if (send(txsock, (void *)&frame, sizeof(can_frame_t), 0) < 0) {
@@ -136,6 +137,8 @@ void *receiver(void *arg)
     long long *rtt_time = (long long *)frame.data;
     struct rtt_stat rtt_stat = {0, 1000000000000000000LL,
-1000000000000000000LL,
 				0, 0, 0};
+
+    pthread_set_name_np(pthread_self(), "rtcan_rtt_receiver");
     pthread_setschedparam(pthread_self(), SCHED_FIFO, &param);

     rtt_stat.counts_per_sec = 1000000 / cycle;
@@ -161,7 +164,7 @@ void *receiver(void *arg)
 	} else {
 	    clock_gettime(CLOCK_MONOTONIC, &time);
 	    if (rxcount > 0) {
-		rtt_stat.rtt = (time.tv_sec * 1000000000LL +
+		rtt_stat.rtt = ((long long)time.tv_sec * 1000000000LL +
 				time.tv_nsec - *rtt_time);
 		rtt_stat.rtt_sum += rtt_stat.rtt;
 		if (rtt_stat.rtt <  rtt_stat.rtt_min)
@@ -201,7 +204,7 @@ int main(int argc, char *argv[])
     struct option long_options[] = {
 	{ "id", required_argument, 0, 'i'},
 	{ "cycle", required_argument, 0, 'c'},
-	{ "repeater", required_argument, 0, 'r'},
+	{ "repeater", no_argument, 0, 'r'},
 	{ "help", no_argument, 0, 'h'},
 	{ 0, 0, 0, 0},
     };

