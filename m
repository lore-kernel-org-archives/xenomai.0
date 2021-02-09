References: <20210207160434.2869121-1-rpm@xenomai.org>
 <20210207160434.2869121-10-rpm@xenomai.org>
 <05c67720-6321-4365-606c-f6657659f3d7@siemens.com>
 <8735y5obmb.fsf@xenomai.org>
From: Philippe Gerum <rpm@xenomai.org>
Subject: Re: [PATCH 10/18] cobalt/timer: ipipe: directly use the abstract
 interface for IPIs
In-reply-to: <8735y5obmb.fsf@xenomai.org>
Date: Tue, 09 Feb 2021 10:10:12 +0100
Message-ID: <87zh0dmwsr.fsf@xenomai.org>
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


Philippe Gerum <rpm@xenomai.org> writes:

> Jan Kiszka <jan.kiszka@siemens.com> writes:
>
>> On 07.02.21 17:04, Philippe Gerum wrote:
>>> From: Philippe Gerum <rpm@xenomai.org>
>>> 
>>> Signed-off-by: Philippe Gerum <rpm@xenomai.org>
>>> ---
>>>  kernel/cobalt/ipipe/tick.c | 6 +++---
>>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>> 
>>> diff --git a/kernel/cobalt/ipipe/tick.c b/kernel/cobalt/ipipe/tick.c
>>> index da1563a66..b711bedc0 100644
>>> --- a/kernel/cobalt/ipipe/tick.c
>>> +++ b/kernel/cobalt/ipipe/tick.c
>>> @@ -187,7 +187,7 @@ int pipeline_install_tick_proxy(void)
>>>  	nkclock.wallclock_offset =
>>>  		ktime_to_ns(ktime_get_real()) - xnclock_read_monotonic(&nkclock);
>>>  
>>> -	ret = xntimer_setup_ipi();
>>> +	ret = pipeline_request_timer_ipi(xnintr_core_clock_handler);
>>
>> Ah, here we change this to the suboptimal pattern: Just fold that
>> implementation in here.
>>
>> We should try to reduce needless static inlines.
>>
>
> The idea is rather to drop the xnintr layer which has zero value in
> this

s,xnintr_,xntimer_,

-- 
Philippe.

