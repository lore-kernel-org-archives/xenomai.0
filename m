Message-ID: <512B46E6.4080308@siemens.com>
Date: Mon, 25 Feb 2013 12:11:34 +0100
From: Jan Kiszka <jan.kiszka@siemens.com>
MIME-Version: 1.0
References: <511E5112.9030006@control.lth.se> <511E53A5.1030406@siemens.com>
	<512B3A5F.5000707@control.lth.se>
In-Reply-To: <512B3A5F.5000707@control.lth.se>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] kernel BUG at arch/x86/kernel/ipipe.c:589! on
	motherboard DX79SI
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Anders Blomdell <anders.blomdell@control.lth.se>
Cc: Xenomai <xenomai@xenomai.org>

On 2013-02-25 11:18, Anders Blomdell wrote:
> On 2013-02-15 16:26, Jan Kiszka wrote:
>> On 2013-02-15 16:15, Anders Blomdell wrote:
>>> Hi,
>>>
>>> I have a DX79SI that dies with "kernel BUG at
>>> arch/x86/kernel/ipipe.c:589!" when running Xenomai. This is not very
>>> surprising since when running the system with an ordinary kernel thera
>>> are a few 'do_IRQ: X.Y No irq handler for vector (irq -1)' each day.
>>>
>>> Question is if it would be possible to do something less fatal than
>>> 'BUG_ON(irq < 0);' in the code below:
>>
>> This remains a bug that has to be understood.
>>
>>>
>>> int __ipipe_handle_irq(struct pt_regs *regs)
>>> {
>>>      struct ipipe_percpu_data *p = __ipipe_this_cpu_ptr(&ipipe_percpu);
>>>      int irq, vector = regs->orig_ax, flags = 0;
>>>      struct pt_regs *tick_regs;
>>>
>>>      if (likely(vector < 0)) {
>>>          irq = __this_cpu_read(vector_irq[~vector]);
>>>          BUG_ON(irq < 0);
>>>      } else { /* Software-generated. */
>>>          irq = vector;
>>>          flags = IPIPE_IRQF_NOACK;
>>>      }
>>
>> Kernel 3.5.7 with latest I-pipe?
> Yes.
> 
>> This is the second report of this kind,
>> see [1] for the discussion and suggestions. If you don't have KGDB and
>> that kind enabled, try Gilles' instrumentations.
> After a running xenomai five and a half day on a DX58SO motherboard, the 
> system crashed, leaving a single 'do_IRQ: 2.166 No irq handler for 
> vector (irq -1)' on our logserver.
> 
> I'm planning to put in Gilles instrumentations and change the BUG_ON to 
> a WARN_ON/WARN, but what should I return after that (my guess is a 
> 'return 1', but waiting a week to be proved wrong would be a waste of 
> time :-).

Err, what was the test setup that generated the Linux error but not the
I-pipe BUG_ON? Was it a Xenomai-enabled kernel with the BUG_ON removed?

Jan

-- 
Siemens AG, Corporate Technology, CT RTC ITP SDP-DE
Corporate Competence Center Embedded Linux

