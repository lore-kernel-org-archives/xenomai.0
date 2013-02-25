Message-ID: <512B7AEE.2000607@xenomai.org>
Date: Mon, 25 Feb 2013 15:53:34 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <511E5112.9030006@control.lth.se> <511E53A5.1030406@siemens.com>
	<512B3A5F.5000707@control.lth.se> <512B58B1.4060509@xenomai.org>
	<512B77AF.9020509@control.lth.se>
In-Reply-To: <512B77AF.9020509@control.lth.se>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] kernel BUG at arch/x86/kernel/ipipe.c:589!
 on	motherboard DX79SI
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Anders Blomdell <anders.blomdell@control.lth.se>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, Xenomai <xenomai@xenomai.org>

On 02/25/2013 03:39 PM, Anders Blomdell wrote:
> On 2013-02-25 13:27, Gilles Chanteperdrix wrote:
>> On 02/25/2013 11:18 AM, Anders Blomdell wrote:
>>
>>> On 2013-02-15 16:26, Jan Kiszka wrote:
>>>> On 2013-02-15 16:15, Anders Blomdell wrote:
>>>>> Hi,
>>>>>
>>>>> I have a DX79SI that dies with "kernel BUG at
>>>>> arch/x86/kernel/ipipe.c:589!" when running Xenomai. This is not very
>>>>> surprising since when running the system with an ordinary kernel thera
>>>>> are a few 'do_IRQ: X.Y No irq handler for vector (irq -1)' each day.
>>>>>
>>>>> Question is if it would be possible to do something less fatal than
>>>>> 'BUG_ON(irq < 0);' in the code below:
>>>>
>>>> This remains a bug that has to be understood.
>>>>
>>>>>
>>>>> int __ipipe_handle_irq(struct pt_regs *regs)
>>>>> {
>>>>>       struct ipipe_percpu_data *p =
>>>>> __ipipe_this_cpu_ptr(&ipipe_percpu);
>>>>>       int irq, vector = regs->orig_ax, flags = 0;
>>>>>       struct pt_regs *tick_regs;
>>>>>
>>>>>       if (likely(vector < 0)) {
>>>>>           irq = __this_cpu_read(vector_irq[~vector]);
>>>>>           BUG_ON(irq < 0);
>>>>>       } else { /* Software-generated. */
>>>>>           irq = vector;
>>>>>           flags = IPIPE_IRQF_NOACK;
>>>>>       }
>>>>
>>>> Kernel 3.5.7 with latest I-pipe?
>>> Yes.
>>>
>>>> This is the second report of this kind,
>>>> see [1] for the discussion and suggestions. If you don't have KGDB and
>>>> that kind enabled, try Gilles' instrumentations.
>>> After a running xenomai five and a half day on a DX58SO motherboard, the
>>> system crashed, leaving a single 'do_IRQ: 2.166 No irq handler for
>>> vector (irq -1)' on our logserver.
>>>
>>> I'm planning to put in Gilles instrumentations and change the BUG_ON to
>>> a WARN_ON/WARN, but what should I return after that (my guess is a
>>> 'return 1', but waiting a week to be proved wrong would be a waste of
>>> time :-).
>>
>>
>> Returning 1 is incorrect:
>> - you should probably jump to the end of the __ipipe_handle_irq function
>> - if the irq is irq 7, meaning a spurious irq, Linux should handle it,
>> so, __ipipe_dispatch_irq should be called.
> OK, so you mean that I'm probably lokking at two different problems
> DX58SO: a spurious interrupt (irq==7) passes through __ipipe_handle_irq
> without triggering BUG_ON, but something else breaks.
> DX79SI: some (spurious?) interrupt results in irq < 0, triggering BUG_ON
>
> Would the following changes be what you have in mind:
>
>      if (likely(vector < 0)) {
>          irq = __this_cpu_read(vector_irq[~vector]);
>              if (irq < 0) {
>                  WARN(irq < 0, "irq(%d) < 0", irq);
>                 goto out:
>           }
>      } else { /* Software-generated. */
>          irq = vector;
>          flags = IPIPE_IRQF_NOACK;
>      }
>      ...
> out:
>      return 1;
>

	...
	goto out;
	...

out:
	if (!__ipipe_root_p ||
	    test_bit(IPIPE_STALL_FLAG, &__ipipe_root_status))
		return 0;

	return 1;

Returning non-zero means: "context is regular, pass irq to linux 
normally", and therefore let do_IRQ handle it.

The interrupted context stops being regular linux-wise when the 
interrupt has preempted the real-time domain (in which case linux might 
have been preempted in the middle of nowhere by a rt activity), or the 
root domain is stalled (which means linux does NOT expect that irq to 
flow down to it, yet).

-- 
Philippe.

