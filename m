Message-ID: <4B042E1C.40505@domain.hid>
Date: Wed, 18 Nov 2009 18:25:48 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4B042121.2050509@domain.hid>	
	<1258562983.2348.168.camel@domain.hid>	
	<4B042B0F.2080003@domain.hid>
	<1258564904.2348.170.camel@domain.hid>
In-Reply-To: <1258564904.2348.170.camel@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Adeos-main] [PATCH] Restore pipeline state on exit from
	ipipe_suspend_domain
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: adeos-main <adeos-main@gna.org>

Philippe Gerum wrote:
> On Wed, 2009-11-18 at 18:12 +0100, Jan Kiszka wrote:
>> This fixes the valid complaint about safe_halt being called with the
>> root domain unstalled.
> 
> The fix should go to the caller. ipipe_suspend_domain() acts as a
> logical barrier: after that point, you may assume that the current
> domain is unstalled.

The caller so far expect to find no interruption window between return
from ipipe_suspend_domain and yet another local_irq_disable. It expects
to remain stalled all the time until safe_halt.

Jan

> 
>> Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
>> ---
>>  kernel/ipipe/core.c |    5 ++++-
>>  1 files changed, 4 insertions(+), 1 deletions(-)
>>
>> Applies to 2.6.31, but is relevant for older kernels as well.
>>
>> diff --git a/kernel/ipipe/core.c b/kernel/ipipe/core.c
>> index ffaceaa..cd946f3 100644
>> --- a/kernel/ipipe/core.c
>> +++ b/kernel/ipipe/core.c
>> @@ -615,12 +615,13 @@ void ipipe_suspend_domain(void)
>>  	struct ipipe_domain *this_domain, *next_domain;
>>  	struct ipipe_percpu_domain_data *p;
>>  	struct list_head *ln;
>> -	unsigned long flags;
>> +	unsigned long flags, saved_status;
>>
>>  	local_irq_save_hw(flags);
>>
>>  	this_domain = next_domain = __ipipe_current_domain;
>>  	p = ipipe_cpudom_ptr(this_domain);
>> +	saved_status = p->status & ~IPIPE_SYNC_MASK;
>>  	p->status &= ~(IPIPE_STALL_MASK|IPIPE_SYNC_MASK);
>>
>>  	if (p->irqpend_himask != 0)
>> @@ -654,6 +655,8 @@ sync_stage:
>>  	}
>>
>>  	__ipipe_current_domain = this_domain;
>> +	p = ipipe_cpudom_ptr(this_domain);
>> +	p->status = saved_status;
>>
>>  	local_irq_restore_hw(flags);
>>  }
> 
> 


-- 
Siemens AG, Corporate Technology, CT T DE IT 1
Corporate Competence Center Embedded Linux

