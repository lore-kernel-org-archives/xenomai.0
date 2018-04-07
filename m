References: <edde814a-56f9-1853-22fe-d3b28c1aadc6@siemens.com>
 <fb450297-ba2f-5e5e-4bfd-cc9090a2ba47@xenomai.org>
 <fa4f1378-b342-8fb1-3923-1a4c86041272@web.de>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <0b5a9737-131f-b166-0def-a8325425a270@xenomai.org>
Date: Sat, 7 Apr 2018 19:06:43 +0200
MIME-Version: 1.0
In-Reply-To: <fa4f1378-b342-8fb1-3923-1a4c86041272@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [PULL] ipipe 4.9 update
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@web.de>
Cc: Xenomai <xenomai@xenomai.org>

On 04/07/2018 07:04 PM, Jan Kiszka wrote:
> On 2018-04-07 18:58, Philippe Gerum wrote:
>> On 04/06/2018 07:21 PM, Jan Kiszka wrote:
>>> The following changes since commit 3d21f886ffae3ffdef54a19ec53393482626a84c:
>>>
>>>   ipipe-core-4.9.90-x86-6 (2018-03-26 17:36:13 +0200)
>>>
>>> are available in the git repository at:
>>>
>>>   git://git.xenomai.org/ipipe-jki 
>>>
>>> for you to fetch changes up to 3fac4646875dbbab6969cf080a02467b578c55be:
>>>
>>>   Merge tag 'v4.9.92' into for-upstream/4.9 (2018-04-06 18:45:31 +0200)
>>>
>>> ----------------------------------------------------------------
>>> (excluding stable merge)
>>> Jan Kiszka (4):
>>>       arm/ipipe: Avoid open-coded __ipipe_call_mayday
>>>       ipipe: Fix root domain guard in preempt_schedule_notrace
>>>       x86/ipipe: Deny JUMP_LABEL over I-pipe
>>>       x86/ipipe: Disable access_ok context under I-pipe
>>>
>>>  arch/arm/kernel/ipipe.c        | 3 +--
>>>  arch/x86/Kconfig               | 2 +-
>>>  arch/x86/include/asm/uaccess.h | 2 +-
>>>  kernel/sched/core.c            | 2 +-
>>>  4 files changed, 4 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/arch/arm/kernel/ipipe.c b/arch/arm/kernel/ipipe.c
>>> index b95c8128c5de..e7642bd28871 100644
>>> --- a/arch/arm/kernel/ipipe.c
>>> +++ b/arch/arm/kernel/ipipe.c
>>> @@ -354,8 +354,7 @@ void __ipipe_exit_irq(struct pt_regs *regs)
>>>  		 * so prefer test then maybe clear over
>>>  		 * test_and_clear.
>>>  		 */
>>> -		ipipe_clear_thread_flag(TIP_MAYDAY);
>>> -		__ipipe_notify_trap(IPIPE_TRAP_MAYDAY, regs);
>>> +		__ipipe_call_mayday(regs);
>>>  	}
>>>  }
>>
>> Nack. If the purpose is to prevent open coding, then you should provide
>> a light __ipipe_call_mayday() which does not fiddle with the IRQ state
>> uselessly. __ipipe_irq_exit does run with hard IRQs off by design.
> 
> You already merged this into 4.4. This is just the same thing with the
> same reasoning.
> 

Yes, but my comment made clear that it was useless. Maybe the second
submission could account for this.

-- 
Philippe.

