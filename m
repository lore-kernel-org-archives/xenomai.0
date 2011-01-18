Message-ID: <4D35CC68.5010204@domain.hid>
Date: Tue, 18 Jan 2011 18:22:48 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4CEE8FF0.6000704@domain.hid> <1295370797.1857.86.camel@domain.hid>
In-Reply-To: <1295370797.1857.86.camel@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Adeos-main] [git pull] Updates for ipipe-2.6.36-noarch
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/options/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: adeos-main <adeos-main@gna.org>

On 2011-01-18 18:13, Philippe Gerum wrote:
> On Thu, 2010-11-25 at 17:33 +0100, Jan Kiszka wrote:
>> The following changes since commit 4c83ab8e3ac5b194695e38bbc253f78e6072ad24:
>>
>>   ipipe: tell __ipipe_run_irqtail about the latest IRQ number (2010-11-05 13:52:55 +0100)
>>
>> are available in the git repository at:
>>   git://git.kiszka.org/ipipe-2.6 queues/2.6.35-noarch
>>
>> [edited log]
>> Jan Kiszka (4):
>>       ipipe: Provide wrapper for IRQ mask/unmask at chip level
> 
> Could you give me some hints about the intended usage of these?

The idea was (and still is but effort stalled ATM) to emulate MSI
masking on top of that.

> 
>>       ipipe: Drop spurious irq_enter/exit from __ipipe_sync_stage
> 
> Actually, what is wrong is not with irq_enter/exit, but rather with the
> fact that we should only attempt a preemption resched when a virq
> handler returns, and that is a generic operation. There is no point in
> having uselessly hairy code in the arch-dep section, and that code is
> pure nop with CONFIG_PREEMPT off.
> 
> I just merged something along these lines.

OK, will have a look.

> 
>>       ipipe: Provide __ipipe_spin_trylock_irq for !CONFIG_IPIPE
>>       Merge commit 'v2.6.35.9' into queues/2.6.35-noarch
>>
>> Will follow up with the ipipe specific patches for review.
> 
> I'll be merging the IRQ virtualization removal for x86_32 next, but I
> want to issue an intermediate patch with the pending fixes first, given
> the potential for regression there is when messing with entry.S.
> However, I'll merge the EFLAGS fixes early on, since they are obviously
> required and right, and merge them along with 2.8-03 asap.
> 

Fine with me.

Thanks,
Jan

-- 
Siemens AG, Corporate Technology, CT T DE IT 1
Corporate Competence Center Embedded Linux

