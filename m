Subject: Re: [PATCH] testsuite/smokey: add simple RTCAN loopback test
References: <051a49fa-a30c-2038-1417-62d140d01abe@grandegger.com>
 <5bbdf42a-ebb6-f542-2435-5eaa045cebdb@siemens.com>
 <f7b4ae5b-d9f8-5ced-3b92-423eba02c7c9@siemens.com>
From: Wolfgang Grandegger <wg@grandegger.com>
Message-ID: <82b0a396-e295-a03b-b335-816c55ccc7a0@grandegger.com>
Date: Thu, 10 Oct 2019 11:29:47 +0200
MIME-Version: 1.0
In-Reply-To: <f7b4ae5b-d9f8-5ced-3b92-423eba02c7c9@siemens.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>, Xenomai ML <Xenomai@xenomai.org>



Am 10.10.19 um 10:26 schrieb Jan Kiszka:
> On 10.10.19 10:26, Jan Kiszka wrote:
>> On 10.10.19 10:07, Wolfgang Grandegger via Xenomai wrote:
>>> The test runs for about 10 seconds!
>>>
>>> Use "smokey --verbose=2" or higher to turn on traces.
>>>
>>> Signed-off-by: Wolfgang Grandegger <wg@grandegger.com>
>>> ---
>>>  configure.ac                       |   1 +
>>>  testsuite/smokey/Makefile.am       |   1 +
>>>  testsuite/smokey/rtcan/Makefile.am |  10 ++
>>>  testsuite/smokey/rtcan/rtcan.c     | 198 +++++++++++++++++++++++++++++++++++++
>>>  4 files changed, 210 insertions(+)
>>>  create mode 100644 testsuite/smokey/rtcan/Makefile.am
>>>  create mode 100644 testsuite/smokey/rtcan/rtcan.c
>>>
>>> diff --git a/configure.ac b/configure.ac
>>> index 45e222b..1166f18 100644
>>> --- a/configure.ac
>>> +++ b/configure.ac
>>> @@ -883,6 +883,7 @@ AC_CONFIG_FILES([ \
>>>  	testsuite/smokey/sched-quota/Makefile \
>>>  	testsuite/smokey/sched-tp/Makefile \
>>>  	testsuite/smokey/setsched/Makefile \
>>> +	testsuite/smokey/rtcan/Makefile \
>>>  	testsuite/smokey/rtdm/Makefile \
>>>  	testsuite/smokey/vdso-access/Makefile \
>>>  	testsuite/smokey/posix-cond/Makefile \
>>> diff --git a/testsuite/smokey/Makefile.am b/testsuite/smokey/Makefile.am
>>> index e6abdb8..ea8c610 100644
>>> --- a/testsuite/smokey/Makefile.am
>>> +++ b/testsuite/smokey/Makefile.am
>>> @@ -20,6 +20,7 @@ COBALT_SUBDIRS = 	\
>>>  	posix-fork	\
>>>  	posix-mutex 	\
>>>  	posix-select 	\
>>> +	rtcan 		\
>>>  	rtdm 		\
>>>  	sched-quota 	\
>>>  	sched-tp 	\
>>> diff --git a/testsuite/smokey/rtcan/Makefile.am b/testsuite/smokey/rtcan/Makefile.am
>>> new file mode 100644
>>> index 0000000..8e2e083
>>> --- /dev/null
>>> +++ b/testsuite/smokey/rtcan/Makefile.am
>>> @@ -0,0 +1,10 @@
>>> +
>>> +noinst_LIBRARIES = librtcan.a
>>> +
>>> +librtcan_a_SOURCES = rtcan.c
>>> +
>>> +CCLD = $(top_srcdir)/scripts/wrap-link.sh $(CC)
>>> +
>>> +librtcan_a_CPPFLAGS = 		\
>>> +	@XENO_USER_CFLAGS@	\
>>> +	-I$(top_srcdir)/include
>>> diff --git a/testsuite/smokey/rtcan/rtcan.c b/testsuite/smokey/rtcan/rtcan.c
>>> new file mode 100644
>>> index 0000000..0725b72
>>> --- /dev/null
>>> +++ b/testsuite/smokey/rtcan/rtcan.c
>>> @@ -0,0 +1,198 @@
>>> +/*
>>> + * RTCAN test.
>>> + *
>>> + * Copyright (C) Wolfgang Grandegger <wg@grandegger.com>
>>> + *
>>> + * Released under the terms of GPLv2.
>>> + */
>>> +#include <stdio.h>
>>> +#include <stdlib.h>
>>> +#include <unistd.h>
>>> +#include <signal.h>
>>> +#include <string.h>
>>> +#include <pthread.h>
>>> +#include <fcntl.h>
>>> +#include <errno.h>
>>> +#include <netinet/in.h>
>>> +#include <net/if.h>
>>> +#include <sys/ioctl.h>
>>> +#include <smokey/smokey.h>
>>> +#include <rtdm/can.h>
>>> +
>>> +smokey_test_plugin(rtcan,
>>> +		   SMOKEY_NOARGS,
>>> +		   "Check RTCAN interface."
>>> +);
>>> +
>>> +#define RTCAN_SMOKEY_DEVICE "rtcan0"
>>> +#define RTCAN_SMOKEY_DELAY   10000000 /* 10 ms */
>>> +#define RTCAN_SMOKEY_LOOPS   1000
>>> +#define RTCAN_SMOKEY_BITRATE 1000000 /* 1 MB/s */
>>> +#define RTCAN_SMOKEY_TIMEOUT 1000000000ll /* 1 sec */
>>> +
>>> +static int sock;
>>> +static uint32_t txcount;
>>> +static uint32_t rxcount;
>>> +
>>> +static pthread_t txtid, rxtid;
>>> +
>>> +static void fail(const char *reason)
>>> +{
>>> +	perror(reason);
>>> +	exit(EXIT_FAILURE);
>>> +}
>>> +
>>> +static void *transmitter(void *arg)
>>> +{
>>> +	struct can_frame frame;
>>> +	struct timespec ts;
>>> +	int loops = RTCAN_SMOKEY_LOOPS;
>>> +	int ret;
>>> +
>>> +	pthread_setname_np(pthread_self(), "RTCAN transmitter");
>>> +
>>> +	while (--loops) {
>>> +		frame.can_id = txcount & CAN_SFF_MASK;
>>> +		frame.can_dlc = sizeof(txcount);
>>> +		memcpy(frame.data, &txcount, sizeof(txcount));
>>> +
>>> +		ret = send(sock, (void *)&frame, sizeof(struct can_frame), 0);
>>> +		if (ret < 0) {
>>> +			close(sock);
>>> +			if (errno == EBADF)
>>> +				fail("terminating transmitter thread\n");
>>> +			else
>>> +				fail("send");
>>> +		}
>>> +		txcount++;
>>> +
>>> +		smokey_trace("%s: send %d bytes, id %#x data txcount %d",
>>> +			     __func__, ret, frame.can_id, txcount);
>>> +
>>> +		ts.tv_sec = 0;
>>> +		ts.tv_nsec = RTCAN_SMOKEY_DELAY;
>>> +		clock_nanosleep(CLOCK_REALTIME, 0, &ts, NULL);
>>> +	}
>>> +
>>> +	return NULL;
>>> +}
>>> +
>>> +static void *receiver(void *arg)
>>> +{
>>> +	struct can_frame frame;
>>> +	uint32_t count;
>>> +	int ret;
>>> +
>>> +	pthread_setname_np(pthread_self(), "RTCAN receiver");
>>> +
>>> +	while (rxcount < RTCAN_SMOKEY_LOOPS - 1) {
>>> +		ret = recv(sock, (void *)&frame, sizeof(struct can_frame), 0);
>>> +		if (ret < 0) {
>>> +			close(sock);
>>> +			if (errno == EBADF)
>>> +				fail("terminating receiver thread\n");
>>> +			else
>>> +				fail("recv");
>>> +		}
>>> +
>>> +		memcpy(&count, frame.data, sizeof(count));
>>> +
>>> +		smokey_trace("%s: received %d bytes, id %#x data count %d",
>>> +			     __func__, ret, frame.can_id, count);
>>> +
>>> +		if (frame.can_id != (count &  CAN_SFF_MASK) ||
>>> +		    frame.can_dlc != sizeof(count) ||
>>> +		    count != rxcount) {
>>> +			close(sock);
>>> +			smokey_note("CAN frame does not match");
>>> +			errno = -EINVAL;
>>> +			fail("frame mismatch");
>>> +		}
>>> +
>>> +		rxcount++;
>>> +	}
>>> +
>>> +	return NULL;
>>> +}
>>> +
>>> +static int run_rtcan(struct smokey_test *t, int argc, char *const argv[])
>>> +{
>>> +	struct sched_param txparam = {.sched_priority = 70 };
>>> +	struct sched_param rxparam = {.sched_priority = 70 };
>>> +	pthread_attr_t txattr, rxattr;
>>> +	nanosecs_rel_t timeout = RTCAN_SMOKEY_TIMEOUT;
>>> +	struct sockaddr_can saddr;
>>> +	struct can_ifreq ifr;
>>> +	int ret;
>>> +
>>> +	sock = socket(PF_CAN, SOCK_RAW, CAN_RAW);
>>> +	if (sock < 0)
>>> +		fail("socket");
>>> +
>>> +	ret = ioctl(sock, RTCAN_RTIOC_RCV_TIMEOUT, &timeout);
>>> +	if (ret)
>>> +	    fail("ioctl RCV_TIMEOUT");
>>> +
>>> +	ret = ioctl(sock, RTCAN_RTIOC_SND_TIMEOUT, &timeout);
>>> +	if (ret)
>>> +	    fail("ioctl SND_TIMEOUT");
>>> +
>>> +	namecpy(ifr.ifr_name, RTCAN_SMOKEY_DEVICE);
>>> +	ret = ioctl(sock, SIOCGIFINDEX, &ifr);
>>> +	if (ret < 0)
>>> +		fail("ioctl SIOCGIFINDEX");
>>> +
>>> +	ifr.ifr_ifru.mode = CAN_MODE_STOP;
>>> +	ret = ioctl(sock, SIOCSCANMODE, &ifr);
>>> +	if (ret < 0)
>>> +		fail("ioctl SIOCSCANCTRLMODE STOP");
>>> +
>>> +	ifr.ifr_ifru.baudrate = RTCAN_SMOKEY_BITRATE;
>>> +	ret = ioctl(sock, SIOCSCANBAUDRATE, &ifr);
>>> +	if (ret < 0)
>>> +		fail("ioctl SIOCSCANBAUDRATE");
>>> +
>>> +	ifr.ifr_ifru.ctrlmode = CAN_CTRLMODE_LOOPBACK;;
>>> +	ret = ioctl(sock, SIOCSCANCTRLMODE, &ifr);
>>> +	if (ret < 0)
>>> +		fail("ioctl SIOCSCANCTRLMODE LOOPBACK");
>>> +
>>> +	ifr.ifr_ifru.mode = CAN_MODE_START;
>>> +	ret = ioctl(sock, SIOCSCANMODE, &ifr);
>>> +	if (ret < 0)
>>> +		fail("ioctl SIOCSCANCTRLMODE START");
>>> +
>>> +	memset(&saddr, 0, sizeof(saddr));
>>> +	saddr.can_ifindex = ifr.ifr_ifindex;
>>> +	saddr.can_family = AF_CAN;
>>> +
>>> +	ret = bind(sock, (struct sockaddr *)&saddr, sizeof(saddr));
>>> +	if (ret < 0)
>>> +		fail("bind");
>>> +
>>> +	pthread_attr_init(&txattr);
>>> +	pthread_attr_setdetachstate(&txattr, PTHREAD_CREATE_JOINABLE);
>>> +	pthread_attr_setinheritsched(&txattr, PTHREAD_EXPLICIT_SCHED);
>>> +	pthread_attr_setschedpolicy(&txattr, SCHED_FIFO);
>>> +	pthread_attr_setschedparam(&txattr, &txparam);
>>> +
>>> +	errno = pthread_create(&txtid, &txattr, &transmitter, NULL);
>>> +	if (errno)
>>> +		fail("pthread_create for tx");
>>> +
>>> +	pthread_attr_init(&rxattr);
>>> +	pthread_attr_setdetachstate(&rxattr, PTHREAD_CREATE_JOINABLE);
>>> +	pthread_attr_setinheritsched(&rxattr, PTHREAD_EXPLICIT_SCHED);
>>> +	pthread_attr_setschedpolicy(&rxattr, SCHED_FIFO);
>>> +	pthread_attr_setschedparam(&rxattr, &rxparam);
>>> +
>>> +	errno = pthread_create(&rxtid, &rxattr, &receiver, NULL);
>>> +	if (errno)
>>> +		fail("pthread_create for rx");
>>> +
>>> +	pthread_join(rxtid, NULL);
>>> +	pthread_cancel(txtid);
>>> +	pthread_join(txtid, NULL);
>>> +
>>> +	return 0;
>>> +}
>>>
>>
>> I thinks this lacks two things:
>>
>>  - testing for availability of the feature, not failing, just warning if
>>    missing
>>
>>  - loading of possibly needed modules, including the virtual CAN driver
>>    (most test machines will not have a phyisical interface)
>>
> 
> i.e. basically the same things that the RTnet test does.

Well, yes, makes sense! And if we use real CAN hardware, we must even
probe what driver is appropriate. More soon...

Wolfgang


