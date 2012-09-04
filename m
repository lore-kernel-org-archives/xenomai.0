Message-ID: <50464969.2000902@xenomai.org>
Date: Tue, 04 Sep 2012 20:33:13 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CANKLDmsO-1E7+d9X6-t532RJ=CWY4P4x30nCNCwgHffJjAFkDA@mail.gmail.com>	<50460BCE.8010505@xenomai.org>
	<CANKLDmtmnbAb7PM4URTjxYtaH5WnvGjVcEPOpSNr2A6gPwLLaA@mail.gmail.com>
In-Reply-To: <CANKLDmtmnbAb7PM4URTjxYtaH5WnvGjVcEPOpSNr2A6gPwLLaA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] kernel NULL pointer dereference
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Henri Roosen <henriroosen@gmail.com>
Cc: Xenomai <xenomai@xenomai.org>

On 09/04/2012 04:28 PM, Henri Roosen wrote:

> On Tue, Sep 4, 2012 at 4:10 PM, Gilles Chanteperdrix
> <gilles.chanteperdrix@xenomai.org> wrote:
>> On 09/04/2012 03:42 PM, Henri Roosen wrote:
>>> Hi,
>>>
>>> I'm using the bleeding edge of Xenomai (0590cb45adce468f619) and Ipipe
>>> (d21e8cdbdcf21ade) on a x86 multicore system and kernel 3.4.6.
>>> I reserved one cpu (kernel param isolcpus=1).
>>>
>>> Our application triggers the following NULL pointer dereference when I
>>> set the affinity of some tasks to cpu 0 and other tasks to cpu 1.
>>> The application does not trigger this when all tasks have the same
>>> affinity (set via /proc/xenomai/affinity).
>>>
>>> I was able to reproduce this also under QEMU and will do some
>>> debugging, but maybe someone knows what is wrong already by seeing the
>>> stacktrace below:
>>
>> Could you try to reduce the bug to a simple testcase which we would try
>> and run to reproduce?
>>
>>> [  108.013023] BUG: unable to handle kernel NULL pointer dereference
>> at 00000294
>>> [  108.013550] IP: [<c0126a91>] __lock_task_sighand+0x53/0xc3
>>
>> Or send us a disassembly of the function __lock_task_sighand?


Looks like someone is calling send_sig_info with an invalid pointer. 
There is something seriously wrong.

On the other hand, now that I think about it, you need at least the 
following patch:

diff --git a/ksrc/nucleus/intr.c b/ksrc/nucleus/intr.c
index c75fcac..0f37bb2 100644
--- a/ksrc/nucleus/intr.c
+++ b/ksrc/nucleus/intr.c
@@ -93,8 +93,18 @@ void xnintr_host_tick(struct xnsched *sched) /* Interrupts off. */
 
 void xnintr_clock_handler(void)
 {
-	struct xnsched *sched = xnpod_current_sched();
 	xnstat_exectime_t *prev;
+	struct xnsched *sched;
+	unsigned cpu;
+
+	cpu = xnarch_current_cpu();
+
+	if (!cpumask_test_cpu(cpu, &xnarch_supported_cpus)) {
+		xnarch_relay_tick();
+		return;
+	}
+
+	sched = xnpod_sched_slot(cpu);
 
 	prev = xnstat_exectime_switch(sched,
 		&nkclock.stat[xnsched_cpu(sched)].account);



-- 
                                                                Gilles.

