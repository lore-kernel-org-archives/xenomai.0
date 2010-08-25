Message-ID: <4C74D948.6010906@domain.hid>
Date: Wed, 25 Aug 2010 10:50:16 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <1278071401-13880-1-git-send-email-wolfgang.mauerer@domain.hid>	
	<1278071401-13880-2-git-send-email-wolfgang.mauerer@domain.hid>
	<1282725843.1709.12.camel@domain.hid>
In-Reply-To: <1282725843.1709.12.camel@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Adeos-main] [PATCH 1/2] ipipe: Pass NTP-corrected time
 information from Linux to higher domains
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: "adeos-main@gna.org" <adeos-main@gna.org>, "Mauerer,
	Wolfgang" <wolfgang.mauerer@domain.hid>

Philippe Gerum wrote:
> On Fri, 2010-07-02 at 13:50 +0200, Wolfgang Mauerer wrote:
> 
> <snip>
> 
>> diff --git a/include/linux/ipipe_tickdev.h b/include/linux/ipipe_tickdev.h
>> index 4a1cb1b..86f13e0 100644
>> --- a/include/linux/ipipe_tickdev.h
>> +++ b/include/linux/ipipe_tickdev.h
>> @@ -25,6 +25,7 @@
>>  #if defined(CONFIG_IPIPE) && defined(CONFIG_GENERIC_CLOCKEVENTS)
> 
> Since we should have CONFIG_HAVE_IPIPE_HOSTRT by now, let's use it.

Don't get yet how this fits here.

> 
>>  
>>  #include <linux/clockchips.h>
>> +#include <linux/clocksource.h>
>>  
>>  struct tick_device;
>>  
>> @@ -44,6 +45,30 @@ struct ipipe_tick_device {
>>  	int real_shift;
>>  };
>>  
>> +/*
>> + * NOTE: When modifying this structure, make sure to keep the Xenomai
>> + * definition include/nucleus/vdso.h in synch.
>> + */
>> +struct ipipe_hostrt_data {
>> +	short live;
>> +	seqcount_t seqcount;
>> +	time_t wall_time_sec;
>> +	u32 wall_time_nsec;
>> +	struct timespec wall_to_monotonic;
>> +	cycle_t cycle_last;
>> +	cycle_t mask;
>> +	u32 mult;
>> +	u32 shift;
>> +};
>> +
>> +#ifdef CONFIG_IPIPE_HOSTRT
>> +void ipipe_set_hostrt_data(struct ipipe_hostrt_data *exchg);
>> +void update_ipipe_hostrt(struct timespec *wall_time, struct clocksource *clock);
> 
> Naming consistency -> ipipe_update_hostrt()
> 
> We should probably mark this as an internal interface as well, e.g.
> __ipipe_update_hostrt.

Will fix.

> 
>> +#else /* !CONFIG_IPIPE_HOSTRT */
>> +static inline void ipipe_set_hostrt_data(struct ipipe_hostrt_data *exchg) { };
>> +static inline void update_ipipe_hostrt(struct timespec *wall_time, struct clocksource *clock) {};
>> +#endif
>> +
> 
> <snip>
> 
>> diff --git a/kernel/ipipe/core.c b/kernel/ipipe/core.c
>> index 63deaf9..9b21db9 100644
>> --- a/kernel/ipipe/core.c
>> +++ b/kernel/ipipe/core.c
>> @@ -48,6 +48,49 @@ static unsigned long __ipipe_domain_slot_map;
>>  
>>  struct ipipe_domain ipipe_root;
>>  
>> +#ifdef CONFIG_IPIPE_HOSTRT
> 
> Same remark as previously regarding the use of CONFIG_HAVE_IPIPE_HOSTRT
> in noarch code. In case the arch-dep code does support the feature, we
> want the noarch section to always compile the generic bits. There is no
> incentive for overcomplicated and error prone feature selection, only
> for saving a few hundred bytes, most - if not all - people will want
> anyway.

We are following kernel-style here: arch selects HAVE_*, generic code
enables some feature depending on HAVE_* and further dependencies (here:
CONFIG_IPIPE).

Jan

-- 
Siemens AG, Corporate Technology, CT T DE IT 1
Corporate Competence Center Embedded Linux

