Subject: Re: [PATCH 10/18] cobalt/timer: ipipe: directly use the abstract
 interface for IPIs
References: <20210207160434.2869121-1-rpm@xenomai.org>
 <20210207160434.2869121-10-rpm@xenomai.org>
 <05c67720-6321-4365-606c-f6657659f3d7@siemens.com>
 <8735y5obmb.fsf@xenomai.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <1aa59b25-2038-c2da-dc42-bda5e24a4f4f@siemens.com>
Date: Tue, 9 Feb 2021 11:28:56 +0100
MIME-Version: 1.0
In-Reply-To: <8735y5obmb.fsf@xenomai.org>
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

On 09.02.21 10:04, Philippe Gerum wrote:
> 
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
> The idea is rather to drop the xnintr layer which has zero value in this
> case, because it does not abstract anything by itself, all is provided
> by the pipeline-specific section. This is why the pipeline call moved
> there, this is the one which brings value in, just like we directly call
> the pipeline interface elsewhere from the generic section, to flatten
> the call stack.
> 

I don't disagree with this step, just that is stopped in the middle.
Make it complete, if you like on top, by folding
pipeline_request_timer_ipi & Co. in.

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

