References: <20210613155522.1851338-1-rpm@xenomai.org>
 <20210613155522.1851338-2-rpm@xenomai.org> <87wnqx7o3k.fsf@xenomai.org>
 <e480b487-e30a-bcb8-fa61-5b613756a8d0@siemens.com>
From: Philippe Gerum <rpm@xenomai.org>
Subject: Re: [PATCH 2/2] ARM: irq_pipeline: preserve lockdep irq state
 across kernel entries
In-reply-to: <e480b487-e30a-bcb8-fa61-5b613756a8d0@siemens.com>
Date: Mon, 14 Jun 2021 08:40:36 +0200
Message-ID: <87eed56ja3.fsf@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: xenomai@xenomai.org


Jan Kiszka <jan.kiszka@siemens.com> writes:

> On 13.06.21 17:58, Philippe Gerum via Xenomai wrote:
>> 
>> Philippe Gerum <rpm@xenomai.org> writes:
>> 
>>> From: Philippe Gerum <rpm@xenomai.org>
>>>
>>> When lockdep is enabled, per_cpu(hardirqs_enabled) may not be in sync
>>> with the in-band stall bit on kernel entry upon preemption by an
>>> IRQ. This may happen since the relevant local_irq_* calls do not
>>> manipulate the stall bit and the lockdep irq state atomically (for a
>>> good reason). In addition, the raw_local_irq API may be used directly,
>>> without lockdep tracking whatsoever (e.g. when manipulating raw
>>> spinlocks).
>> 
>> A similar fix may be needed for x86 in the generic entry code when
>> pipelining interrupts.
>> 
>
> Is there a good way to tickle the related splat out of the system? At
> least locally, I have PROVE_LOCKING on but didn't see this so far.
>

Only the bbb displayed such bug so far here, PROVE_LOCKING and
DOVETAIL_DEBUG on, function ftracing might help lowering the odds of
reproducing the bug. Running latency, the assertion would trigger at ^C
within secs, rarely during boot although this has been observed a couple
of times too.

I believe that some network traffic may help, increasing the rate of
softirqs (I'm running with a rootfs over nfs). In this case,
__local_bh_disable_ip would be preempted by an IRQ while covered by
raw_local_irq_save, exposing the issue described in the commit log, and
lockdep_assert_irqs_enabled() would trigger in __local_bh_enable_ip.

-- 
Philippe.

