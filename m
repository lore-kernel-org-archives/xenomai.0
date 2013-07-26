Message-ID: <51F2A4E9.3000304@xenomai.org>
Date: Fri, 26 Jul 2013 18:33:45 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <1374841118.86884.BPMail_high_noncarrier@web125405.mail.ne1.yahoo.com>
In-Reply-To: <1374841118.86884.BPMail_high_noncarrier@web125405.mail.ne1.yahoo.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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

On 07/26/2013 02:18 PM, GP Orcullo wrote:
>
> ------------------------------
> On Fri, Jul 26, 2013 5:09 AM PDT GP Orcullo wrote:
>
>> ----- Original Message -----
>>
>> From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
>> To: GP Orcullo <kinsamanka@ymail.com>
>> Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>
>> Sent: Friday, July 26, 2013 4:26 AM
>> Subject: Re: [Xenomai] XDDP test failure on Raspberry Pi, 3.8.13 kernel
>>
>> On 07/24/2013 02:12 PM, GP Orcullo wrote:
>>
>>> Hi,
>>>
>>> Raspberry Pi on Xenomai v2.6.2.1 passes all the regression tests
>>> except for the xddp_test.  The test fails with "FAILURE bind: Address
>>> already in use".
>>>
>>> How do I resolve this issue?
>>
>>
>> Hi,
>>
>> do you have the same issue with Xenomai from git repository?
>>
>>
>> --
>>                                                                   Gilles.
>>
>>
>> Hello Gilles,
>>
>> I have restarted from scratch and the issue seemed to have resolved itself. I have no clue why it initially failed.
>>
>> Thanks!
>>
>> GP Orcullo
>
> I have found the cause.
>
> If the module xeno_klat is loaded, xddp_test fails.
>

It looks like both the kernel latency and xddp tests do not cope well 
together, with respect to the message pipe number they want to use. The 
patch below works around the issue, but xddp_test should rather be fixed 
to use the XDDP port auto-selection, like klat already does.

diff --git a/src/testsuite/regression/posix/xddp_test.c 
b/src/testsuite/regression/posix/xddp_test.c
index 194584e..2de07a3 100644
--- a/src/testsuite/regression/posix/xddp_test.c
+++ b/src/testsuite/regression/posix/xddp_test.c
@@ -23,7 +23,7 @@
  static pthread_t rt, nrt;
  static sem_t opened;

-#define XDDP_PORT 0	/* [0..CONFIG-XENO_OPT_PIPE_NRDEV - 1] */
+#define XDDP_PORT 1	/* [0..CONFIG-XENO_OPT_PIPE_NRDEV - 1] */

  static void *realtime_thread(void *arg)
  {

-- 
Philippe.

