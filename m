Message-ID: <4B54ACC8.9030006@domain.hid>
Date: Mon, 18 Jan 2010 19:47:36 +0100
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
References: <4B546AD0.3060106@domain.hid> <4B546BEC.8030703@domain.hid>
In-Reply-To: <4B546BEC.8030703@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [PATCH] rtcan_rtt: Various fixes and improvement
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

Gilles Chanteperdrix wrote:
> Wolfgang Grandegger wrote:
>> This patch fixes type long overflows, invalid command line argument
>> types and gives the receiver and transmitter thread dedicated names.
>>
>> Signed-off-by: Wolfgang Grandegger <wg@domain.hid>
>>
>> diff --git a/examples/rtdm/profiles/can/rtcan_rtt.c
>> b/examples/rtdm/profiles/can/rtcan_rtt.c
>> index 93c84a6..2280562 100644
>> --- a/examples/rtdm/profiles/can/rtcan_rtt.c
>> +++ b/examples/rtdm/profiles/can/rtcan_rtt.c
>> @@ -94,6 +94,7 @@ void *transmitter(void *arg)
>>      frame.can_id = can_id;
>>      frame.can_dlc = sizeof(*rtt_time);
>>
>> +    pthread_set_name_np(pthread_self(), "rtcan_rtt_transmitter");
> 
> Maybe we should put this between #ifdef __XENO__, so that the code
> compiles under plain posix too?

Good idea but it requires a few more changes. See below:

Thanks,

Wolfgang.


[PATCH v3] rtcan_rtt: Various fixes and improvement

This patch fixes type long overflows, invalid command line argument
types and gives the receiver and transmitter thread dedicated names.
Furthermore, it now also compiles under plain POSIX by using the macro
definition __XENO__ as suggested by Gilles.

Signed-off-by: Wolfgang Grandegger <wg@domain.hid>

diff --git a/examples/rtdm/profiles/can/rtcan_rtt.c b/examples/rtdm/profiles/can/rtcan_rtt.c
index 93c84a6..b4ff74a 100644
--- a/examples/rtdm/profiles/can/rtcan_rtt.c
+++ b/examples/rtdm/profiles/can/rtcan_rtt.c
@@ -45,14 +45,21 @@
 #include <limits.h>
 #include <getopt.h>
 #include <netinet/in.h>
+#include <net/if.h>
+#include <sys/ioctl.h>
 #include <sys/mman.h>
 
+#ifdef __XENO__
 #include <rtdm/rtcan.h>
+#else
+#include <linux/can.h>
+#include <linux/can/raw.h>
+#endif
 
 #define NSEC_PER_SEC 1000000000
 
 static unsigned int cycle = 10000; /* 10 ms */
-static can_id_t can_id = 0x1;
+static canid_t can_id = 0x1;
 
 static pthread_t txthread, rxthread;
 static int txsock, rxsock;
@@ -94,6 +101,9 @@ void *transmitter(void *arg)
     frame.can_id = can_id;
     frame.can_dlc = sizeof(*rtt_time);
 
+#ifdef __XENO__
+    pthread_set_name_np(pthread_self(), "rtcan_rtt_transmitter");
+#endif
     pthread_setschedparam(pthread_self(), SCHED_FIFO, &param);
 
     clock_gettime(CLOCK_MONOTONIC, &next_period);
@@ -113,10 +123,10 @@ void *transmitter(void *arg)
 	}
 
         clock_gettime(CLOCK_MONOTONIC, &time);
-	*rtt_time = time.tv_sec * NSEC_PER_SEC + time.tv_nsec;
+	*rtt_time = (long long)time.tv_sec * NSEC_PER_SEC + time.tv_nsec;
 
         /* Transmit the message containing the local time */
-	if (send(txsock, (void *)&frame, sizeof(can_frame_t), 0) < 0) {
+	if (send(txsock, (void *)&frame, sizeof(struct can_frame), 0) < 0) {
             if (errno == EBADF)
                 printf("terminating transmitter thread\n");
             else
@@ -136,12 +146,16 @@ void *receiver(void *arg)
     long long *rtt_time = (long long *)frame.data;
     struct rtt_stat rtt_stat = {0, 1000000000000000000LL, -1000000000000000000LL,
 				0, 0, 0};
+
+#ifdef __XENO__
+    pthread_set_name_np(pthread_self(), "rtcan_rtt_receiver");
+#endif
     pthread_setschedparam(pthread_self(), SCHED_FIFO, &param);
 
     rtt_stat.counts_per_sec = 1000000 / cycle;
 
     while (1) {
-	if (recv(rxsock, (void *)&frame, sizeof(can_frame_t), 0) < 0) {
+	if (recv(rxsock, (void *)&frame, sizeof(struct can_frame), 0) < 0) {
 	    if (errno == EBADF)
                 printf("terminating receiver thread\n");
             else
@@ -150,7 +164,7 @@ void *receiver(void *arg)
         }
 	if (repeater) {
 	    /* Transmit the message back as is */
-	    if (send(txsock, (void *)&frame, sizeof(can_frame_t), 0) < 0) {
+	    if (send(txsock, (void *)&frame, sizeof(struct can_frame), 0) < 0) {
 		if (errno == EBADF)
 		    printf("terminating transmitter thread\n");
 		else
@@ -161,7 +175,7 @@ void *receiver(void *arg)
 	} else {
 	    clock_gettime(CLOCK_MONOTONIC, &time);
 	    if (rxcount > 0) {
-		rtt_stat.rtt = (time.tv_sec * 1000000000LL +
+		rtt_stat.rtt = ((long long)time.tv_sec * 1000000000LL +
 				time.tv_nsec - *rtt_time);
 		rtt_stat.rtt_sum += rtt_stat.rtt;
 		if (rtt_stat.rtt <  rtt_stat.rtt_min)
@@ -201,7 +215,7 @@ int main(int argc, char *argv[])
     struct option long_options[] = {
 	{ "id", required_argument, 0, 'i'},
 	{ "cycle", required_argument, 0, 'c'},
-	{ "repeater", required_argument, 0, 'r'},
+	{ "repeater", no_argument, 0, 'r'},
 	{ "help", no_argument, 0, 'h'},
 	{ 0, 0, 0, 0},
     };

 


