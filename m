Message-ID: <50F99CCE.1000907@siemens.com>
Date: Fri, 18 Jan 2013 20:04:46 +0100
From: Jan Kiszka <jan.kiszka@siemens.com>
MIME-Version: 1.0
References: <50F96C89.8010004@siemens.com> <50F97A65.7060306@xenomai.org>
	<50F98088.5070804@siemens.com>
In-Reply-To: <50F98088.5070804@siemens.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [CRITICAL PATCH] ipipe: Re-read domain context after
	IRQ processing
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: Xenomai <xenomai@xenomai.org>

On 2013-01-18 18:04, Jan Kiszka wrote:
> On 2013-01-18 17:37, Philippe Gerum wrote:
>> On 01/18/2013 04:38 PM, Jan Kiszka wrote:
>>> This fixes a nasty bug on SMP boxes: We may migrate to root in the
>>> context of an IRQ handler, and then also to a different CPU. Therefore,
>>> we must not use domain contexts read before the invocation but update
>>> them afterward or use stable information like the domain reference.
>>
>> Ack.
>>
>>>
>>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>>> ---
>>>
>>> We are still facing stalled, unkillable RT processes despite this fix,
>>
>> Is TASK_HARDENING still lingering in task->state despite the recent 
>> switch_tail fix, or is this something different?
> 
> Patch is applied, but I didn't check this detail yet.
> 
> I just found a potential SMP race in schedule_linux_call, patch follows.
> But now I triggered XENO_BUGON(NUCLEUS, need_resched == 0); for unknown
> reasons...

Probably found the problem - or at least another one: XNINLOCK must be
used with xnsched::lflags, not status. It is set/cleared by the RTDM
spin locks outside nklock. Will patch that and retest.

Jan

-- 
Siemens AG, Corporate Technology, CT RTC ITP SDP-DE
Corporate Competence Center Embedded Linux

