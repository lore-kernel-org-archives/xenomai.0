Message-ID: <51778F44.8030109@siemens.com>
Date: Wed, 24 Apr 2013 09:52:36 +0200
From: Jan Kiszka <jan.kiszka@siemens.com>
MIME-Version: 1.0
References: <517652E1.3090104@thrane.com> <51767C66.9030103@siemens.com>
	<51778C38.8030105@thrane.com>
In-Reply-To: <51778C38.8030105@thrane.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Lost interrupts
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jesper Christensen <jbc@thrane.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 2013-04-24 09:39, Jesper Christensen wrote:
> On 04/23/2013 02:19 PM, Jan Kiszka wrote:
>> On 2013-04-23 11:22, Jesper Christensen wrote:
>>> Hi guys
>>>
>>> I have a quick question regarding rtdm synchronisation. Is it possible
>>> to "loose" an interrupt if it is generated while i am inside a critical
>>> section protected by a rtdm_lock_get_irqsave/rtdm_lock_put_irqrestore?
>> Nope, as Gilles already answered.
>>
>>> I have a problem with an ethernet driver where the Tx Queue fills up and
>>> i suspect that its because the Tx ISR isn't being executed for the above
>>> mentioned reason.
>> Are we talking about a Linux NIC or a real-time device? What is your
>> software stack in general (used components and their versions)?
>>
>> Jan
>>
> 
> Its a real time device (ETSEC on a MPC8520) with xenomai 2.5.6 on a
> linux-2.6.29.6 and ipipe-2.7-04 and the stack is rtnet-0.9.12. The ipipe
> patch has minor modifications to make it apply to the freescale patched
> version of the linux source. The rtnet source also has several (heavier)
> modifications (scattered skbs, etc.).

That introduces a lot of variations and potential breakage points. You
will have to debug through them.

> 
> So if an interrupt occurs during a critical section, the ISR will run
> upon exit from that section?

Critical RT sections disable interrupts in hardware. And common CPUs
keep interrupts pending that arrive while delivery is disabled,
replaying them once the OS reenables them again.

Jan

-- 
Siemens AG, Corporate Technology, CT RTC ITP SDP-DE
Corporate Competence Center Embedded Linux

