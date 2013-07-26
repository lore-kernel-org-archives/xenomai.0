Message-ID: <51F2AAF9.3050403@xenomai.org>
Date: Fri, 26 Jul 2013 18:59:37 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <1374841118.86884.BPMail_high_noncarrier@web125405.mail.ne1.yahoo.com>
	<51F2A4E9.3000304@xenomai.org>
In-Reply-To: <51F2A4E9.3000304@xenomai.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] XDDP test failure on Raspberry Pi, 3.8.13 kernel
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: GP Orcullo <kinsamanka@ymail.com>
Cc: xenomai@xenomai.org

On 07/26/2013 06:33 PM, Philippe Gerum wrote:
> On 07/26/2013 02:18 PM, GP Orcullo wrote:
>>
>> ------------------------------
>> On Fri, Jul 26, 2013 5:09 AM PDT GP Orcullo wrote:
>>
>>> ----- Original Message -----
>>>
>>> From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
>>> To: GP Orcullo <kinsamanka@ymail.com>
>>> Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>
>>> Sent: Friday, July 26, 2013 4:26 AM
>>> Subject: Re: [Xenomai] XDDP test failure on Raspberry Pi, 3.8.13 kernel
>>>
>>> On 07/24/2013 02:12 PM, GP Orcullo wrote:
>>>
>>>> Hi,
>>>>
>>>> Raspberry Pi on Xenomai v2.6.2.1 passes all the regression tests
>>>> except for the xddp_test.  The test fails with "FAILURE bind: Address
>>>> already in use".
>>>>
>>>> How do I resolve this issue?
>>>
>>>
>>> Hi,
>>>
>>> do you have the same issue with Xenomai from git repository?
>>>
>>>
>>> -- 
>>>                                                                   
>>> Gilles.
>>>
>>>
>>> Hello Gilles,
>>>
>>> I have restarted from scratch and the issue seemed to have resolved 
>>> itself. I have no clue why it initially failed.
>>>
>>> Thanks!
>>>
>>> GP Orcullo
>>
>> I have found the cause.
>>
>> If the module xeno_klat is loaded, xddp_test fails.
>>
> 
> It looks like both the kernel latency and xddp tests do not cope well 
> together, with respect to the message pipe number they want to use. The 
> patch below works around the issue, but xddp_test should rather be fixed 
> to use the XDDP port auto-selection, like klat already does.
> 

Something like this would do:

commit 3a61082756c097ba60a87ee8f9f185ad9f8d4686
Author: Philippe Gerum <rpm@xenomai.org>
Date:   Fri Jul 26 18:56:49 2013 +0200

    testsuite/regression: xddp_test: use port auto-selection
    
    Let the XDDP driver pick an idle port for communication, so that we
    won't conflict with other message pipe users (e.g. xeno_klat).

diff --git a/src/testsuite/regression/posix/xddp_test.c b/src/testsuite/regression/posix/xddp_test.c
index 194584e..e10a09a 100644
--- a/src/testsuite/regression/posix/xddp_test.c
+++ b/src/testsuite/regression/posix/xddp_test.c
@@ -22,14 +22,14 @@
 
 static pthread_t rt, nrt;
 static sem_t opened;
-
-#define XDDP_PORT 0	/* [0..CONFIG-XENO_OPT_PIPE_NRDEV - 1] */
+static int xddp_port = -1;	/* First pass uses auto-selection */
 
 static void *realtime_thread(void *arg)
 {
 	unsigned long count = (unsigned long)arg;
 	struct sockaddr_ipc saddr;
 	struct timespec ts;
+	socklen_t addrlen;
 	size_t poolsz;
 	int ret, s;
 
@@ -57,7 +57,7 @@ static void *realtime_thread(void *arg)
 	 */
 	memset(&saddr, 0, sizeof(saddr));
 	saddr.sipc_family = AF_RTIPC;
-	saddr.sipc_port = XDDP_PORT;
+	saddr.sipc_port = xddp_port;
 	ret = bind(s, (struct sockaddr *)&saddr, sizeof(saddr));
 	if (count == 1) {
 		if (ret < 0 && errno == EADDRINUSE) {
@@ -69,6 +69,10 @@ static void *realtime_thread(void *arg)
 			exit(EXIT_FAILURE);
 		}
 		fprintf(stderr, "FAILURE: bind returned %d\n", ret);
+	} else {
+		addrlen = sizeof(saddr);
+		check_unix(getsockname(s, (struct sockaddr *)&saddr, &addrlen));
+		xddp_port = saddr.sipc_port;
 	}
 	if (ret < 0) {
 		fprintf(stderr, "FAILURE bind: %m\n");
@@ -91,7 +95,7 @@ static void *regular_thread(void *arg)
 	char buf[128], *devname;
 	int fd;
 
-	check_unix(asprintf(&devname, "/dev/rtp%d", XDDP_PORT));
+	check_unix(asprintf(&devname, "/dev/rtp%d", xddp_port));
 
 	fd = check_unix(open(devname, O_RDWR));
 	free(devname);
-- 
Philippe.

