Message-ID: <50576804.9030109@siemens.com>
Date: Mon, 17 Sep 2012 20:12:20 +0200
From: Jan Kiszka <jan.kiszka@siemens.com>
MIME-Version: 1.0
References: <5056C385.6090403@xenomai.org>	<5056D4AE.2010201@web.de>
	<5056DA52.6040006@xenomai.org>	<5056DCC5.10909@web.de>
	<5056E024.5020904@xenomai.org>	<5056E863.4090606@siemens.com>
	<5056ED68.6050101@xenomai.org>	<5056F09C.8050602@siemens.com>
	<5056F4A1.6070500@xenomai.org>
	<CANKLDmuxUk0XQobqs_OJ8vwQvaMie3Q3JU5Fn5DjpfpfZH3=cg@mail.gmail.com>
	<50570606.7060909@xenomai.org>
	<CANKLDmuTU3351fNd8eTqiY-9+53h2iO5TzWNsX-wqPj98f4gMw@mail.gmail.com>
	<5057173C.9070108@siemens.com> <5057299B.9060804@xenomai.org>
	<50572B95.2060302@siemens.com> <50572D86.3040306@xenomai.org>
	<50573532.20700@siemens.com> <505761DF.3010609@xenomai.org>
	<5057666D.7080404@siemens.com> <50576725.9030601@xenomai.org>
In-Reply-To: <50576725.9030601@xenomai.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] IO-APIC latencies
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai <Xenomai@xenomai.org>

On 2012-09-17 20:08, Gilles Chanteperdrix wrote:
> On 09/17/2012 08:05 PM, Jan Kiszka wrote:
> 
>> On 2012-09-17 19:46, Gilles Chanteperdrix wrote:
>>> ipipe_end is a nop when called from primary domain, yes, but this is not
>>> very different from edge irqs. Also, fasteoi become a bit like MSI: in
>>> the same way as we can not mask MSI from primary domain, we should not
>>> mask IO-APIC fasteoi irqs, because the cost is too prohibitive. If we
>>> can live with MSI without masking them in primary mode, I guess we can
>>> do the same with fasteoi irqs.
>>
>> MSIs are edge triggered, fasteois are still level-based. They require
>> masking at the point you defer them - what we do and what Linux may even
>> extend beyond that. If you mask them by raising the task priority, you
>> have to keep it raised until Linux finally handled the IRQ.
> 
> 
> Yes.
> 
>> Or you
>> decide to mask it at IO-APIC level again.
> 
> 
> We do not want that.
> 
>> If you keep the TPR raised,
>> you will block more than what Linux wants to block.
> 
> 
> The point is that if the TPR keeps raised, it means that primary domain
> has preempted Linux, so, we want it to keep that way. Otherwise the TPR
> gets lowered when Linux has handled the interrupt.
> 
> A week-end of testing made me sure of one thing: it works. I assure you.

Probably, in the absence of IRQF_ONESHOT Linux interrupts. No longer if
you face threaded IRQs - I assure you.

Jan

-- 
Siemens AG, Corporate Technology, CT RTC ITP SDP-DE
Corporate Competence Center Embedded Linux

