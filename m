Message-ID: <528368C7.80902@xenomai.org>
Date: Wed, 13 Nov 2013 12:55:51 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <528290CE.1030002@xenomai.org> <52833710.5080407@xenomai.org>
 <52833A47.2000009@xenomai.org>
In-Reply-To: <52833A47.2000009@xenomai.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] issues with debugging enabled
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai <xenomai@xenomai.org>

On 11/13/2013 09:37 AM, Gilles Chanteperdrix wrote:
> On 11/13/2013 09:23 AM, Philippe Gerum wrote:
>> On 11/12/2013 09:34 PM, Gilles Chanteperdrix wrote:
>>>
>>> Hi,
>>>
>>> for a change, I ran the xeno-regression-test with a lot of debugging and
>>> options known to having caused problems in the past and found two issues:
>>>
>>> on x86 SMP, with full dynticks and debugging enabled (preemptible kernel
>>> debugging, mutex, spinlocks, and sleep inside spinlocks), I get the
>>> series of warnings at the end of the mail.
>>
>> Our IRQ deferral might conflict with the RCU state logic (e.g.
>> rcu-irq_enter/exit).
>>
>>>
>>> on ARM, when a fault occurs, the fault ode is entered with hardware irqs
>>> off (this is a recent change in the mainline kernel, this code used to
>>> be executed with hardware irqs on), so I do:
>>>
>>> ipipe_stall_root();
>>> hard_local_irq_enabled();
>>>
>>> But the context checking does not like that.
>>>
>>
>> You mean ipipe_root_only() triggers over the stall point?
>>
> Yes, because ipipe_stall_root() is called with hw irqs off if I
> understand correctly.
>

This means that there is a discrepancy between the hw masking state and 
the logical one via the stall bit. This might also mean that we fault 
into a (root-)stalled area, or hopefully that some fixup already 
happened on the stall bit from the fault trampoline in the lowest core 
code. Could that be?

Also, we may not stall using the regular interface over non-root domains.

-- 
Philippe.

