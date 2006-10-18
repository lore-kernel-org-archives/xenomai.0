Message-ID: <45366314.5000904@domain.hid>
Date: Wed, 18 Oct 2006 19:23:32 +0200
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------080107090308070908030007"
Subject: [Xenomai-core] BUG: sleeping function called from invalid context
	at kernel/xenomai/skins/posix/syscall.c:272
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai-core <xenomai@xenomai.org>

This is a multi-part message in MIME format.
--------------080107090308070908030007
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

when I start the RT-Socket-CAN program rtcan_rtt.c, I get the attached 
error message. Any idea where the problem could be? It was working with 
Xenomai under Linux 2.4.25.

Thanks.

Wolfgang.



--------------080107090308070908030007
Content-Type: text/x-log;
 name="BUG.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="BUG.log"

bash-3.00# rtcan_rtt rtcan0 rtcan1
BUG: sleeping function called from invalid context at kernel/xenomai/skins/posix/syscall.c:272
in_atomic():0, irqs_disabled():1
Call Trace:
[C30C9E00] [C000D7E8] show_stack+0x48/0x190 (unreliable)
[C30C9E30] [C0013D08] __might_sleep+0xc4/0xf0
[C30C9E50] [C0066514] __pthread_setschedparam+0xe0/0x2c0
[C30C9EB0] [C00492AC] losyscall_event+0xc8/0x1e0
[C30C9EE0] [C003A330] __ipipe_dispatch_event+0x94/0x19c
[C30C9F30] [C0009290] __ipipe_syscall_root+0x44/0xfc
[C30C9F40] [C00041C0] DoSyscall+0x24/0x60
1 3
TX txsock=897, ifr_name=rtcan0
RX rxsock=898, ifr_name=rtcan1
Round-Trip-Time test rtcan0 -> rtcan1 with CAN ID 0x1
Cycle time: 10000 us
All RTT timing figures are in us.
Messages RTTlast RTT_avg RTT_min RTT_max Overruns
     100    1022     997     992    1026        0
     200     998    1006     990    1034        0
     300     998    1005     990    1034        0

--------------080107090308070908030007
Content-Type: text/x-csrc;
 name="rtcan_rtt.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="rtcan_rtt.c"

/*
 * Round-Trip-Time Test - sends and receives messages and measures the
 *                        time in between.
 *
 * Copyright (C) 2006 Wolfgang Grandegger <wg@domain.hid>
 *
 * Based on RTnet's examples/xenomai/posix/rtt-sender.c.
 *
 * Copyright (C) 2002 Ulrich Marx <marx@domain.hid>
 *               2002 Marc Kleine-Budde <kleine-budde@domain.hid>
 *               2006 Jan Kiszka <jan.kiszka@domain.hid>
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
 */

#include <errno.h>
#include <mqueue.h>
#include <signal.h>
#include <pthread.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <limits.h>
#include <getopt.h>
#include <netinet/in.h>
#include <sys/mman.h>

#include "rtdm/rtcan.h"

static unsigned int cycle = 10000; /* 10 ms */
static can_id_t can_id = 0x1;

static pthread_t txthread, rxthread;
static int txsock, rxsock;
static mqd_t mq;
static int txcount, rxcount;
static int overruns;

struct rtt_stat {    
    long long rtt;
    long long rtt_min;
    long long rtt_max;
    long long rtt_sum;
    long long rtt_sum_last;
    int counts_per_sec;
};

static void print_usage(char *prg)
{
    fprintf(stderr, 
	    "Usage: %s  [Options] <tx-can-interface> <rx-can-interface>\n"
	    "Options:\n"
	    " -i, --id=ID   CAN Identifier (default = 0x1)\n"
	    " -c, --cycle   Cycle time in us (default = 10000us)\n",
	    prg);
}

void *transmitter(void *arg)
{
    struct sched_param  param = { .sched_priority = 80 };
    struct timespec next_period;
    struct timespec time;
    struct can_frame frame;
    long long *rtt_time = (long long *)&frame.data;

    /* Pre-fill CAN frame */
    frame.can_id = can_id;
    frame.can_dlc = sizeof(*rtt_time);

    pthread_setschedparam(pthread_self(), SCHED_FIFO, &param);

    clock_gettime(CLOCK_MONOTONIC, &next_period);

    while(1) {
        next_period.tv_nsec += cycle * 1000;
        if (next_period.tv_nsec >= 1000000000) {
            next_period.tv_nsec = 0;
            next_period.tv_sec++;
        }

        clock_nanosleep(CLOCK_MONOTONIC, TIMER_ABSTIME, &next_period, NULL);

	if (rxcount != txcount) {
	    overruns++;
	    continue;
	}

        clock_gettime(CLOCK_MONOTONIC, &time);
	*rtt_time = time.tv_sec * 1000000000LL + time.tv_nsec;

        /* Transmit the message containing the local time */
	if (send(txsock, (void *)&frame, sizeof(can_frame_t), 0) < 0) {	    
            if (errno == EBADF)
                printf("terminating transmitter thread\n");
            else
                perror("send failed");
            return NULL;
        }
	txcount++;
    }
}


void *receiver(void *arg)
{
    struct sched_param param = { .sched_priority = 82 };
    struct timespec time;
    struct can_frame frame;
    long long *rtt_time = (long long *)frame.data;
    struct rtt_stat rtt_stat = {0, LONG_LONG_MAX, LONG_LONG_MIN, 0, 0, 0};

    pthread_setschedparam(pthread_self(), SCHED_FIFO, &param);

    rtt_stat.counts_per_sec = 1000000 / cycle;

    while (1) {
	if (recv(rxsock, (void *)&frame, sizeof(can_frame_t), 0) < 0) {
	    if (errno == EBADF)
                printf("terminating receiver thread\n");
            else
                perror("recv failed");
            return NULL;
        }

	clock_gettime(CLOCK_MONOTONIC, &time);
	if (rxcount++ > 0) {
	    rtt_stat.rtt = (time.tv_sec * 1000000000LL + 
			    time.tv_nsec - *rtt_time);
	    rtt_stat.rtt_sum += rtt_stat.rtt;
	    if (rtt_stat.rtt <  rtt_stat.rtt_min)
		rtt_stat.rtt_min = rtt_stat.rtt;
	    if (rtt_stat.rtt > rtt_stat.rtt_max)
		rtt_stat.rtt_max = rtt_stat.rtt;
	}
	if ((rxcount % rtt_stat.counts_per_sec) == 0) {
	    mq_send(mq, (char *)&rtt_stat, sizeof(rtt_stat), 0);
	    rtt_stat.rtt_sum_last = rtt_stat.rtt_sum;
	}
    }
}

void catch_signal(int sig)
{
    mq_close(mq);
}


int main(int argc, char *argv[])
{
    struct sched_param param = { .sched_priority = 1 };
    struct sockaddr_can addr;
    pthread_attr_t thattr;
    struct mq_attr mqattr;
    struct can_filter rxfilter[1];
    struct rtt_stat rtt_stat;
    char mqname[32];
    struct ifreq ifr;
    int ret, opt;

    struct option long_options[] = {
	{ "id", required_argument, 0, 'i'},
	{ "cycle", required_argument, 0, 'c'},
	{ 0, 0, 0, 0},
    };

    while ((opt = getopt_long(argc, argv, "i:c:", 
			      long_options, NULL)) != -1) {
	switch (opt) {
	case 'c':
	    cycle = atoi(optarg);
	    break;

	case 'i':
	    can_id = strtoul(optarg, NULL, 0);
	    break;

	default:
	    fprintf(stderr, "Unknown option %c\n", opt);
	    print_usage(argv[0]);
	    break;
	}
    }

    printf("%d %d\n", optind, argc);
    if (optind + 2 != argc) {
	print_usage(argv[0]);
	exit(0);
    }

    /* Create and configure TX socket */
    if ((txsock = socket(PF_CAN, SOCK_RAW, 0)) < 0) {
	perror("TX socket failed");
	return -1;
    }

    strncpy(ifr.ifr_name, argv[optind], IFNAMSIZ);
    printf("TX txsock=%d, ifr_name=%s\n", txsock, ifr.ifr_name);

    if (ioctl(txsock, SIOCGIFINDEX, &ifr) < 0) {
	perror("TX ioctl SIOCGIFINDEX failed");
	goto failure1;
    }

    memset(&addr, 0, sizeof(addr));
    addr.can_ifindex = ifr.ifr_ifindex;
    addr.can_family = AF_CAN;
    if (bind(txsock, (struct sockaddr *)&addr, sizeof(addr)) < 0) {
	perror("TX bind failed\n");
	goto failure1;
    }

    /* Create and configure RX socket */
    if ((rxsock = socket(PF_CAN, SOCK_RAW, 0)) < 0) {
	perror("RX socket failed");
	goto failure1;
    }

    strncpy(ifr.ifr_name, argv[optind + 1], IFNAMSIZ);
    printf("RX rxsock=%d, ifr_name=%s\n", rxsock, ifr.ifr_name);

    if (ioctl(rxsock, SIOCGIFINDEX, &ifr) < 0) {
	perror("RX ioctl SIOCGIFINDEX failed");
	goto failure2;
    }

    /* We only want to receive our own messages */
    rxfilter[0].can_id = can_id;
    rxfilter[0].can_mask = 0x3ff;
    if (setsockopt(rxsock, SOL_CAN_RAW, CAN_RAW_FILTER, 
		   &rxfilter, sizeof(struct can_filter)) < 0) {
	perror("RX setsockopt CAN_RAW_FILTER failed");
	goto failure2;
    }
    memset(&addr, 0, sizeof(addr));
    addr.can_ifindex = ifr.ifr_ifindex;
    addr.can_family = AF_CAN;
    if (bind(rxsock, (struct sockaddr *)&addr, sizeof(addr)) < 0) {
	perror("RX bind failed\n");
	goto failure2;
    }

    signal(SIGTERM, catch_signal);
    signal(SIGINT, catch_signal);
    signal(SIGHUP, catch_signal);
    mlockall(MCL_CURRENT|MCL_FUTURE);

    printf("Round-Trip-Time test %s -> %s with CAN ID 0x%x\n", 
	   argv[optind], argv[optind + 1], can_id);
    printf("Cycle time: %d us\n", cycle);
    printf("All RTT timing figures are in us.\n");

    /* Create statistics message queue */
    snprintf(mqname, sizeof(mqname), "/rtcan_rtt-%d", getpid());
    mqattr.mq_flags   = 0;
    mqattr.mq_maxmsg  = 100;
    mqattr.mq_msgsize = sizeof(struct rtt_stat);
    mq = mq_open(mqname, O_RDWR | O_CREAT | O_EXCL, 0600, &mqattr);
    if (mq == (mqd_t)-1) {
        perror("opening mqueue failed");
        goto failure2;
    }

    /* Create receiver RT-thread */
    pthread_attr_init(&thattr);
    pthread_attr_setdetachstate(&thattr, PTHREAD_CREATE_JOINABLE);
    pthread_attr_setstacksize(&thattr, PTHREAD_STACK_MIN);
    ret = pthread_create(&rxthread, &thattr, &receiver, NULL);
    if (ret) {
	fprintf(stderr, "%s: pthread_create(receiver) failed\n", 
		strerror(-ret));
        goto failure3;
    }

    /* Create transitter RT-thread */
    ret = pthread_create(&txthread, &thattr, &transmitter, NULL);
    if (ret) {
	fprintf(stderr, "%s: pthread_create(transmitter) failed\n", 
		strerror(-ret));
	goto failure4;
    }

    pthread_setschedparam(pthread_self(), SCHED_FIFO, &param);

    printf("Messages RTTlast RTT_avg RTT_min RTT_max Overruns\n");

    while (1) {
	long long rtt_avg;

        ret = mq_receive(mq, (char *)&rtt_stat, sizeof(rtt_stat), NULL);
        if (ret != sizeof(rtt_stat)) {
	    if (ret < 0) {
		if (errno == EBADF)
		    printf("terminating mq_receive\n");
		else
		    perror("mq_receive failed");
	    } else
		fprintf(stderr, 
			"mq_receive returned invalid length %d\n", ret);
            break;
	}

	rtt_avg = ((rtt_stat.rtt_sum - rtt_stat.rtt_sum_last) /
		   rtt_stat.counts_per_sec);
	printf("%8d %7ld %7ld %7ld %7ld %8d\n", rxcount, 
	       (long)(rtt_stat.rtt / 1000), (long)(rtt_avg / 1000),
	       (long)(rtt_stat.rtt_min / 1000),
	       (long)(rtt_stat.rtt_max / 1000),
	       overruns);
    }

    /* This call also leaves primary mode, required for socket cleanup. */
    printf("shutting down\n");

    /* Important: First close the sockets! */
    while ((close(rxsock) < 0) && (errno == EAGAIN)) {
        printf("RX socket busy - waiting...\n");
        sleep(1);
    }
    while ((close(txsock) < 0) && (errno == EAGAIN)) {
        printf("TX socket busy - waiting...\n");
        sleep(1);
    }
    
    pthread_join(txthread, NULL);
    pthread_kill(rxthread, SIGHUP);
    pthread_join(rxthread, NULL);

    return 0;

 failure4:
    pthread_kill(rxthread, SIGHUP);
    pthread_join(rxthread, NULL);
 failure3:
    mq_close(mq);
 failure2:
    close(rxsock);
 failure1:
    close(txsock);

    return 1;
}

--------------080107090308070908030007--

