Subject: Re: [PATCH] cobalt/syscall: dovetail: enable propagation from
 handle_oob_syscall()
References: <20211114100348.1235576-1-rpm@xenomai.org>
 <53f5238c-4227-a4f3-c9c4-993768d0b4f0@siemens.com>
 <878rxponoo.fsf@xenomai.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <784a15c5-fd74-77d5-f42f-82e20173f53f@siemens.com>
Date: Mon, 15 Nov 2021 09:01:59 +0100
MIME-Version: 1.0
In-Reply-To: <878rxponoo.fsf@xenomai.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

On 15.11.21 08:57, Philippe Gerum wrote:
> 
> Jan Kiszka <jan.kiszka@siemens.com> writes:
> 
>> On 14.11.21 11:03, Philippe Gerum via Xenomai wrote:
>>> From: Philippe Gerum <rpm@xenomai.org>
>>>
>>> Since release v5.10.76-dovetail3, handle_oob_syscall() should return a
>>> propagation status just like handle_pipelined_syscall(), with the same
>>> semantics. This is a requirement for properly handling our syscall
>>> format and the new prctl-based one concurrently. Fix up the signature
>>> accordingly.  This status is ignored on earlier Dovetail releases.
>>>
>>> In addition, CONFIG_DOVETAIL_LEGACY_SYSCALL_RANGE is checked for
>>> enabling our current syscall format, which defaults to y at the
>>> moment.  Force it on regardless to allow for detection when this call
>>> format is eventually deprecated upstream.
>>>
>>> Signed-off-by: Philippe Gerum <rpm@xenomai.org>
>>> ---
>>>  kernel/cobalt/dovetail/syscall.c | 5 ++---
>>>  scripts/Kconfig.frag             | 1 +
>>>  2 files changed, 3 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/kernel/cobalt/dovetail/syscall.c b/kernel/cobalt/dovetail/syscall.c
>>> index cec6c0244..440c069d5 100644
>>> --- a/kernel/cobalt/dovetail/syscall.c
>>> +++ b/kernel/cobalt/dovetail/syscall.c
>>> @@ -19,8 +19,7 @@ int handle_pipelined_syscall(struct irq_stage *stage, struct pt_regs *regs)
>>>  	return handle_head_syscall(stage == &inband_stage, regs);
>>>  }
>>>  
>>> -void handle_oob_syscall(struct pt_regs *regs)
>>> +int handle_oob_syscall(struct pt_regs *regs)
>>>  {
>>> -	int ret = handle_head_syscall(false, regs);
>>> -	XENO_BUG_ON(COBALT, ret == KEVENT_PROPAGATE);
>>> +	return handle_head_syscall(false, regs);
>>>  }
>>
>> This unfortunately makes the Xenomai 3.2 release incompatible with
>> latest stable Dovetail. I would now have to hectically roll out 3.2.1
>> and cross fingers that people will use it. Better than before, but still
>> not smooth.
> 
> Did you try this patch? What went wrong?
> 

The patch passed testing and is not the issue. That is in the fact that
we must update to callback in order to have stable syscall processing
again because 3.2 would return random codes for it and can fail subtly.

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

