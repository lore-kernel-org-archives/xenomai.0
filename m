Message-ID: <4C74E32D.2080101@domain.hid>
Date: Wed, 25 Aug 2010 11:32:29 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <1278071401-13880-1-git-send-email-wolfgang.mauerer@domain.hid>	
	<1278071401-13880-3-git-send-email-wolfgang.mauerer@domain.hid>	
	<1282726349.1709.21.camel@domain.hid>	
	<4C74DB1C.3030503@domain.hid>
	<1282728024.1709.39.camel@domain.hid>
In-Reply-To: <1282728024.1709.39.camel@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Adeos-main] [PATCH 2/2] ipipe: CLOCK_HOST_REALTIME:
 x86-specific part
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
>>>> diff --git a/arch/x86/kernel/vsyscall_64.c b/arch/x86/kernel/vsyscall_64.c
>>>> index 8cb4974..f1b90f7 100644
>>>> --- a/arch/x86/kernel/vsyscall_64.c
>>>> +++ b/arch/x86/kernel/vsyscall_64.c
>>>> @@ -32,6 +32,7 @@
>>>>  #include <linux/cpu.h>
>>>>  #include <linux/smp.h>
>>>>  #include <linux/notifier.h>
>>>> +#include <linux/ipipe_tickdev.h>
>>>>  
>>>>  #include <asm/vsyscall.h>
>>>>  #include <asm/pgtable.h>
>>>> @@ -89,6 +90,11 @@ void update_vsyscall(struct timespec *wall_time, struct clocksource *clock)
>>>>  	vsyscall_gtod_data.wall_to_monotonic = wall_to_monotonic;
>>>>  	vsyscall_gtod_data.wall_time_coarse = __current_kernel_time();
>>>>  	write_sequnlock_irqrestore(&vsyscall_gtod_data.lock, flags);
>>>> +
>>>> +#ifdef CONFIG_IPIPE_HOSTRT
>>>> +	if (clock == &clocksource_tsc)
>>>> +		update_ipipe_hostrt(wall_time, clock);
>>>> +#endif
>>>>  }
>>> It would be nice to move the test on clock to ipipe_update_hostrt() in
>>> order to hide all nitty-gritty details from mainline. Making the code
>>> unconditionally compiled in removes the need to #ifdefery.
>> This code is arch-specific while update_ipipe_hostrt is generic.
>>
> 
> We don't need #ifdefery with the conditional definition of
> ipipe_update_hostrt() in ipipe_tickdev.h.

You mean rely on the compiler optimizing the check away? OK, now I get it.

Jan

-- 
Siemens AG, Corporate Technology, CT T DE IT 1
Corporate Competence Center Embedded Linux

