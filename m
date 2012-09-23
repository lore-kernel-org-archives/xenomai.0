Message-ID: <505F175C.2020702@xenomai.org>
Date: Sun, 23 Sep 2012 16:06:20 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <50483A49.5090100@ebus.com> <504C7797.8040201@xenomai.org>
	<5058F5F6.2060708@xenomai.org>
In-Reply-To: <5058F5F6.2060708@xenomai.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Queue corruption from XDDP in Xenomai 2.6.1
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Doug Brunner <dbrunner@ebus.com>, xenomai@xenomai.org

On 09/19/2012 12:30 AM, Gilles Chanteperdrix wrote:
> On 09/09/2012 01:03 PM, Philippe Gerum wrote:
> 
>> On 09/06/2012 07:53 AM, Doug Brunner wrote:
>>> It looks like the bug I wrote about back in June still exists in Xenomai
>>> 2.6.1 (with Linux 3.2.21). I ran the same test case (an RT thread opens
>>> an XDDP socket, then a Linux thread opens its end of the pipe, then the
>>> RT thread stops, then with the Linux thread still holding its end of the
>>> pipe another RT thread tries to open an XDDP socket with the same minor
>>> number). With Xenomai queue and I-pipe debugging enabled, I got a report
>>> of a corrupted queue. I've attached my config, test case, and serial
>>> console log.
>>>
>>> So far I haven't found anything in the XDDP or underlying xnpipe_* code
>>> that would suggest why this is happening. However something is
>>> definitely going wrong, since xnpipe_minor_free should not be called
>>> until my Linux task closes its end of the pipe, so the call by the
>>> second RT thread to open the pipe should fail with -EBUSY. Any thoughts
>>> on why this might be happening?
>>>
>>
>> Yes, please have a look at the commit log there:
>> http://git.xenomai.org/?p=xenomai-2.6.git;a=commit;h=283c5f6eae1d1d7c65073e2f30fd40abdcf2c1ca
>>
>> This patch should fix the issue raised by the test case you sent
>> (actually, it does, it was very useful to spot the problem - thanks for
>> this).
> 
> 
> Hi Philippe, 
> 
> I am using a test case which should be about the same as Doug's, however when running the test
> case twice, the second test fails at bind with EADDRINUSE.

This is intended, the port remains bound until both ends
have released it, e.g.:

diff --git a/src/testsuite/regression/posix/xddp_test.c b/src/testsuite/regression/posix/xddp_test.c
index 1c9389f..c75f8c1 100644
--- a/src/testsuite/regression/posix/xddp_test.c
+++ b/src/testsuite/regression/posix/xddp_test.c
@@ -79,6 +79,7 @@ void *regular_thread(void *arg)
 	char buf[128], *devname;
 	int fd, ret;
 
+reset:
 	check_unix(asprintf(&devname, "/dev/rtp%d", XDDP_PORT));
 
 	fd = check_unix(open(devname, O_RDWR));
@@ -87,7 +88,11 @@ void *regular_thread(void *arg)
 	for (;;) {
 		/* Get the next message from realtime_thread. */
 		ret = read(fd, buf, sizeof(buf));
-
+		if (ret < 0) {
+			fprintf(stderr, "read: %m\n");
+			close(fd);
+			goto reset;
+		}
 		usleep(10000);
 	}

-- 
Philippe.

