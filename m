Message-ID: <45DC39DE.8050802@domain.hid>
Date: Wed, 21 Feb 2007 13:23:58 +0100
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] CAN driver
References: <45DC1D05.1000206@domain.hid> <45DC2478.2020602@domain.hid>
In-Reply-To: <45DC2478.2020602@domain.hid>
Content-Type: multipart/mixed; boundary="------------090307020801080100050008"
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: Xenomai-help@domain.hid

This is a multi-part message in MIME format.
--------------090307020801080100050008
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Jan Kiszka wrote:
> Roland Tollenaar wrote:
>> Hi list,
>>
>> does anyone have, or can anyone direct met to a project or code-snippet
>> that shows how the CAN driver in the xenomai patch is used in an
>> application? If not that any documentation that gives and explains what
>> calls it responds to.
> 
> Check src/utils/can/ on some tools that can also serve as nice examples.
> But maybe we should also add even simpler demo code to the examples
> repository. Just takes someone to write them...

The utility programs rtcanconfig, rtcansend and rtcanrcv in 
src/utils/can already demonstrate most of RT-Socket-CAN's functionality 
including filter definition and error handling. I do not see a need for 
simpler examples. I have attached a patch for a nice program to measure 
the round trip time of CAN messages. It contrast to the other CAN 
utility programs, it uses the POSIX-API and works as-is for Socket-CAN 
as well. Jan, any objections to include it? If yes, I'm going to provide 
a README.

BTW: some time ago I provided a patch to make the CAN utility programs 
part of the Doxygen documentation. IIRC, we said it's nice to have 
hyperlinked examples in general.

Wolfgang.


--------------090307020801080100050008
Content-Type: text/x-patch;
 name="xenomai-rtcan-rtt.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="xenomai-rtcan-rtt.patch"

+ diff -u xenomai/examples/rtdm/profiles/can/Makefile.RTT xenomai/examples/rtdm/profiles/can/Makefile
--- xenomai/examples/rtdm/profiles/can/Makefile.RTT	2007-02-21 13:10:34.000000000 +0100
+++ xenomai/examples/rtdm/profiles/can/Makefile	2007-02-21 13:06:19.000000000 +0100
@@ -0,0 +1,82 @@
+###### CONFIGURATION ######
+
+### List of applications to be build
+APPLICATIONS = rtcan_rtt
+
+### Note: to override the search path for the xeno-config script, use "make XENO=..."
+
+
+### List of modules to be build
+MODULES =
+
+### Default to sources of currently running kernel
+KSRC ?= /lib/modules/$(shell uname -r)/build
+
+### Note: to override the kernel source path, use "make KSRC=..."
+
+
+
+###### USER SPACE BUILD (no change required normally) ######
+ifneq ($(APPLICATIONS),)
+
+XENOCONFIG=$(shell PATH=$(XENO):$(XENO)/bin:$(PATH) which xeno-config 2>/dev/null)
+
+### Sanity check
+ifeq ($(XENOCONFIG),)
+all::
+	@echo ">>> Invoke make like this: \"make XENO=/path/to/xeno-config\" <<<"
+	@echo
+endif
+
+
+CC=$(shell $(XENOCONFIG) --cc)
+
+CFLAGS=$(shell $(XENOCONFIG) --posix-cflags) $(MY_CFLAGS)
+
+LDFLAGS=$(shell $(XENOCONFIG) --posix-ldflags) $(MY_LDFLAGS) -lrtdm
+
+all:: $(APPLICATIONS)
+
+clean::
+	$(RM) $(APPLICATIONS) *.o
+
+endif
+
+
+
+###### KERNEL MODULE BUILD (no change required normally) ######
+ifneq ($(MODULES),)
+
+OBJS     := ${patsubst %, %.o, $(MODULES)}
+CLEANMOD := ${patsubst %, .%*, $(MODULES)}
+PWD      := $(shell if [ "$$PWD" != "" ]; then echo $$PWD; else pwd; fi)
+
+### Kernel 2.6
+ifeq ($(findstring 2.6,$(KSRC)),2.6)
+
+obj-m        := $(OBJS)
+EXTRA_CFLAGS := -I$(KSRC)/include/xenomai -I$(KSRC)/include/xenomai/posix $(ADD_CFLAGS)
+
+all::
+	$(MAKE) -C $(KSRC) SUBDIRS=$(PWD) modules
+
+### Kernel 2.4
+else
+
+ARCH    ?= $(shell uname -i)
+INCLUDE := -I$(KSRC)/include/xenomai -I$(KSRC)/include/xenomai/compat -I$(KSRC)/include/xenomai/posix
+CFLAGS  += $(shell $(MAKE) -s -C $(KSRC) CC=$(CC) ARCH=$(ARCH) SUBDIRS=$(PWD) modules) $(INCLUDE)
+
+all:: $(OBJS)
+
+endif
+
+## Target for capturing 2.4 module CFLAGS
+modules:
+	@echo "$(CFLAGS)"
+
+clean::
+	$(RM) $(CLEANMOD) *.cmd *.o *.ko *.mod.c Module*.symvers
+	$(RM) -R .tmp*
+
+endif
+ diff -u xenomai/examples/rtdm/profiles/can/rtcan_rtt.c.RTT xenomai/examples/rtdm/profiles/can/rtcan_rtt.c
--- xenomai/examples/rtdm/profiles/can/rtcan_rtt.c.RTT	2007-02-21 13:10:43.000000000 +0100
+++ xenomai/examples/rtdm/profiles/can/rtcan_rtt.c	2007-02-21 13:04:44.000000000 +0100
@@ -0,0 +1,402 @@
+/*
+ * Round-Trip-Time Test - sends and receives messages and measures the
+ *                        time in between.
+ *
+ * Copyright (C) 2006 Wolfgang Grandegger <wg@domain.hid>
+ *
+ * Based on RTnet's examples/xenomai/posix/rtt-sender.c.
+ *
+ * Copyright (C) 2002 Ulrich Marx <marx@domain.hid>
+ *               2002 Marc Kleine-Budde <kleine-budde@domain.hid>
+ *               2006 Jan Kiszka <jan.kiszka@domain.hid>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+
+#include <errno.h>
+#include <mqueue.h>
+#include <signal.h>
+#include <pthread.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+#include <limits.h>
+#include <getopt.h>
+#include <netinet/in.h>
+#include <sys/mman.h>
+
+#include <rtdm/rtcan.h>
+
+static unsigned int cycle = 10000; /* 10 ms */
+static can_id_t can_id = 0x1;
+
+static pthread_t txthread, rxthread;
+static int txsock, rxsock;
+static mqd_t mq;
+static int txcount, rxcount;
+static int overruns;
+static int repeater;
+
+struct rtt_stat {
+    long long rtt;
+    long long rtt_min;
+    long long rtt_max;
+    long long rtt_sum;
+    long long rtt_sum_last;
+    int counts_per_sec;
+};
+
+static void print_usage(char *prg)
+{
+    fprintf(stderr,
+	    "Usage: %s  [Options] <tx-can-interface> <rx-can-interface>\n"
+	    "Options:\n"
+	    " -h, --help     This help\n"
+	    " -r, --repeater Repeater, send back received messages\n"
+	    " -i, --id=ID    CAN Identifier (default = 0x1)\n"
+	    " -c, --cycle    Cycle time in us (default = 10000us)\n",
+	    prg);
+}
+
+void *transmitter(void *arg)
+{
+    struct sched_param  param = { .sched_priority = 80 };
+    struct timespec next_period;
+    struct timespec time;
+    struct can_frame frame;
+    long long *rtt_time = (long long *)&frame.data;
+
+    /* Pre-fill CAN frame */
+    frame.can_id = can_id;
+    frame.can_dlc = sizeof(*rtt_time);
+
+    pthread_setschedparam(pthread_self(), SCHED_FIFO, &param);
+
+    clock_gettime(CLOCK_MONOTONIC, &next_period);
+
+    while(1) {
+        next_period.tv_nsec += cycle * 1000;
+        if (next_period.tv_nsec >= 1000000000) {
+            next_period.tv_nsec = 0;
+            next_period.tv_sec++;
+        }
+
+        clock_nanosleep(CLOCK_MONOTONIC, TIMER_ABSTIME, &next_period, NULL);
+
+	if (rxcount != txcount) {
+	    overruns++;
+	    continue;
+	}
+
+        clock_gettime(CLOCK_MONOTONIC, &time);
+	*rtt_time = time.tv_sec * 1000000000LL + time.tv_nsec;
+
+        /* Transmit the message containing the local time */
+	if (send(txsock, (void *)&frame, sizeof(can_frame_t), 0) < 0) {
+            if (errno == EBADF)
+                printf("terminating transmitter thread\n");
+            else
+                perror("send failed");
+            return NULL;
+        }
+	txcount++;
+    }
+}
+
+
+void *receiver(void *arg)
+{
+    struct sched_param param = { .sched_priority = 82 };
+    struct timespec time;
+    struct can_frame frame;
+    long long *rtt_time = (long long *)frame.data;
+    struct rtt_stat rtt_stat = {0, 1000000000000000000LL, -1000000000000000000LL,
+				0, 0, 0};
+    pthread_setschedparam(pthread_self(), SCHED_FIFO, &param);
+
+    rtt_stat.counts_per_sec = 1000000 / cycle;
+
+    while (1) {
+	if (recv(rxsock, (void *)&frame, sizeof(can_frame_t), 0) < 0) {
+	    if (errno == EBADF)
+                printf("terminating receiver thread\n");
+            else
+                perror("recv failed");
+            return NULL;
+        }
+	if (repeater) {
+	    /* Transmit the message back as is */
+	    if (send(txsock, (void *)&frame, sizeof(can_frame_t), 0) < 0) {
+		if (errno == EBADF)
+		    printf("terminating transmitter thread\n");
+		else
+		    perror("send failed");
+		return NULL;
+	    }
+	    txcount++;
+	} else {
+	    clock_gettime(CLOCK_MONOTONIC, &time);
+	    if (rxcount > 0) {
+		rtt_stat.rtt = (time.tv_sec * 1000000000LL +
+				time.tv_nsec - *rtt_time);
+		rtt_stat.rtt_sum += rtt_stat.rtt;
+		if (rtt_stat.rtt <  rtt_stat.rtt_min)
+		    rtt_stat.rtt_min = rtt_stat.rtt;
+		if (rtt_stat.rtt > rtt_stat.rtt_max)
+		    rtt_stat.rtt_max = rtt_stat.rtt;
+	    }
+	}
+	rxcount++;
+
+	if ((rxcount % rtt_stat.counts_per_sec) == 0) {
+	    mq_send(mq, (char *)&rtt_stat, sizeof(rtt_stat), 0);
+	    rtt_stat.rtt_sum_last = rtt_stat.rtt_sum;
+	}
+    }
+}
+
+void catch_signal(int sig)
+{
+    mq_close(mq);
+}
+
+
+int main(int argc, char *argv[])
+{
+    struct sched_param param = { .sched_priority = 1 };
+    pthread_attr_t thattr;
+    struct mq_attr mqattr;
+    struct sockaddr_can rxaddr, txaddr;
+    struct can_filter rxfilter[1];
+    struct rtt_stat rtt_stat;
+    char mqname[32];
+    char *txdev, *rxdev;
+    struct ifreq ifr;
+    int ret, opt;
+
+    struct option long_options[] = {
+	{ "id", required_argument, 0, 'i'},
+	{ "cycle", required_argument, 0, 'c'},
+	{ "repeater", required_argument, 0, 'r'},
+	{ "help", no_argument, 0, 'h'},
+	{ 0, 0, 0, 0},
+    };
+
+    while ((opt = getopt_long(argc, argv, "hri:c:",
+			      long_options, NULL)) != -1) {
+	switch (opt) {
+	case 'c':
+	    cycle = atoi(optarg);
+	    break;
+
+	case 'i':
+	    can_id = strtoul(optarg, NULL, 0);
+	    break;
+
+	case 'r':
+	    repeater = 1;
+	    break;
+
+	default:
+	    fprintf(stderr, "Unknown option %c\n", opt);
+	case 'h':
+	    print_usage(argv[0]);
+	    exit(-1);
+	}
+    }
+
+    printf("%d %d\n", optind, argc);
+    if (optind + 2 != argc) {
+	print_usage(argv[0]);
+	exit(0);
+    }
+
+    txdev = argv[optind];
+    rxdev = argv[optind + 1];
+
+    /* Create and configure RX socket */
+    if ((rxsock = socket(PF_CAN, SOCK_RAW, 0)) < 0) {
+	perror("RX socket failed");
+	return -1;
+    }
+
+    strncpy(ifr.ifr_name, rxdev, IFNAMSIZ);
+    printf("RX rxsock=%d, ifr_name=%s\n", rxsock, ifr.ifr_name);
+
+    if (ioctl(rxsock, SIOCGIFINDEX, &ifr) < 0) {
+	perror("RX ioctl SIOCGIFINDEX failed");
+	goto failure1;
+    }
+
+    /* We only want to receive our own messages */
+    rxfilter[0].can_id = can_id;
+    rxfilter[0].can_mask = 0x3ff;
+    if (setsockopt(rxsock, SOL_CAN_RAW, CAN_RAW_FILTER,
+		   &rxfilter, sizeof(struct can_filter)) < 0) {
+	perror("RX setsockopt CAN_RAW_FILTER failed");
+	goto failure1;
+    }
+    memset(&rxaddr, 0, sizeof(rxaddr));
+    rxaddr.can_ifindex = ifr.ifr_ifindex;
+    rxaddr.can_family = AF_CAN;
+    if (bind(rxsock, (struct sockaddr *)&rxaddr, sizeof(rxaddr)) < 0) {
+	perror("RX bind failed\n");
+	goto failure1;
+    }
+
+    /* Create and configure TX socket */
+
+    if (strcmp(rxdev, txdev) == 0) {
+	txsock = rxsock;
+    } else {
+	if ((txsock = socket(PF_CAN, SOCK_RAW, 0)) < 0) {
+	    perror("TX socket failed");
+	    goto failure1;
+	}
+
+	strncpy(ifr.ifr_name, txdev, IFNAMSIZ);
+	printf("TX txsock=%d, ifr_name=%s\n", txsock, ifr.ifr_name);
+
+	if (ioctl(txsock, SIOCGIFINDEX, &ifr) < 0) {
+	    perror("TX ioctl SIOCGIFINDEX failed");
+	    goto failure2;
+	}
+
+	/* Suppress definiton of a default receive filter list */
+	if (setsockopt(txsock, SOL_CAN_RAW, CAN_RAW_FILTER, NULL, 0) < 0) {
+	    perror("TX setsockopt CAN_RAW_FILTER failed");
+	    goto failure2;
+	}
+
+	memset(&txaddr, 0, sizeof(txaddr));
+	txaddr.can_ifindex = ifr.ifr_ifindex;
+	txaddr.can_family = AF_CAN;
+
+	if (bind(txsock, (struct sockaddr *)&txaddr, sizeof(txaddr)) < 0) {
+		perror("TX bind failed\n");
+		goto failure2;
+	}
+    }
+
+    signal(SIGTERM, catch_signal);
+    signal(SIGINT, catch_signal);
+    signal(SIGHUP, catch_signal);
+    mlockall(MCL_CURRENT|MCL_FUTURE);
+
+    printf("Round-Trip-Time test %s -> %s with CAN ID 0x%x\n",
+	   argv[optind], argv[optind + 1], can_id);
+    printf("Cycle time: %d us\n", cycle);
+    printf("All RTT timing figures are in us.\n");
+
+    /* Create statistics message queue */
+    snprintf(mqname, sizeof(mqname), "/rtcan_rtt-%d", getpid());
+    mqattr.mq_flags   = 0;
+    mqattr.mq_maxmsg  = 100;
+    mqattr.mq_msgsize = sizeof(struct rtt_stat);
+    mq = mq_open(mqname, O_RDWR | O_CREAT | O_EXCL, 0600, &mqattr);
+    if (mq == (mqd_t)-1) {
+        perror("opening mqueue failed");
+        goto failure2;
+    }
+
+    /* Create receiver RT-thread */
+    pthread_attr_init(&thattr);
+    pthread_attr_setdetachstate(&thattr, PTHREAD_CREATE_JOINABLE);
+    pthread_attr_setstacksize(&thattr, PTHREAD_STACK_MIN);
+    ret = pthread_create(&rxthread, &thattr, &receiver, NULL);
+    if (ret) {
+	fprintf(stderr, "%s: pthread_create(receiver) failed\n",
+		strerror(-ret));
+        goto failure3;
+    }
+
+    if (!repeater) {
+	/* Create transitter RT-thread */
+	ret = pthread_create(&txthread, &thattr, &transmitter, NULL);
+	if (ret) {
+	    fprintf(stderr, "%s: pthread_create(transmitter) failed\n",
+		    strerror(-ret));
+	    goto failure4;
+	}
+    }
+
+    pthread_setschedparam(pthread_self(), SCHED_FIFO, &param);
+
+    if (repeater)
+	printf("Messages\n");
+    else
+	printf("Messages RTTlast RTT_avg RTT_min RTT_max Overruns\n");
+
+    while (1) {
+	long long rtt_avg;
+
+        ret = mq_receive(mq, (char *)&rtt_stat, sizeof(rtt_stat), NULL);
+        if (ret != sizeof(rtt_stat)) {
+	    if (ret < 0) {
+		if (errno == EBADF)
+		    printf("terminating mq_receive\n");
+		else
+		    perror("mq_receive failed");
+	    } else
+		fprintf(stderr,
+			"mq_receive returned invalid length %d\n", ret);
+            break;
+	}
+
+	if (repeater) {
+	    printf("%8d\n", rxcount);
+	} else {
+	    rtt_avg = ((rtt_stat.rtt_sum - rtt_stat.rtt_sum_last) /
+		       rtt_stat.counts_per_sec);
+	    printf("%8d %7ld %7ld %7ld %7ld %8d\n", rxcount,
+		   (long)(rtt_stat.rtt / 1000), (long)(rtt_avg / 1000),
+		   (long)(rtt_stat.rtt_min / 1000),
+		   (long)(rtt_stat.rtt_max / 1000),
+		   overruns);
+	}
+    }
+
+    /* This call also leaves primary mode, required for socket cleanup. */
+    printf("shutting down\n");
+
+    /* Important: First close the sockets! */
+    while ((close(rxsock) < 0) && (errno == EAGAIN)) {
+        printf("RX socket busy - waiting...\n");
+        sleep(1);
+    }
+    while ((close(txsock) < 0) && (errno == EAGAIN)) {
+        printf("TX socket busy - waiting...\n");
+        sleep(1);
+    }
+
+    pthread_join(txthread, NULL);
+    pthread_kill(rxthread, SIGHUP);
+    pthread_join(rxthread, NULL);
+
+    return 0;
+
+ failure4:
+    pthread_kill(rxthread, SIGHUP);
+    pthread_join(rxthread, NULL);
+ failure3:
+    mq_close(mq);
+ failure2:
+    close(txsock);
+ failure1:
+    close(rxsock);
+
+    return 1;
+}

--------------090307020801080100050008--

