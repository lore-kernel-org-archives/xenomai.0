Message-ID: <503BF463.50603@xenomai.org>
Date: Tue, 28 Aug 2012 00:27:47 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <201208262252.27556.paul_c@tuxcnc.org>	<503B637F.4060302@xenomai.org>
	<201208272322.05160.paul_c@tuxcnc.org>
In-Reply-To: <201208272322.05160.paul_c@tuxcnc.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] oops on ARM1176 SoC
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Paul <paul_c@tuxcnc.org>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 08/28/2012 12:22 AM, Paul wrote:

> On Monday 27 August 2012, Gilles Chanteperdrix wrote:
>> Please try the following patch:
>> diff --git a/ksrc/nucleus/module.c b/ksrc/nucleus/module.c
>> index 5eb7c52..052fcb5 100644
>> --- a/ksrc/nucleus/module.c
>> +++ b/ksrc/nucleus/module.c
>> @@ -92,8 +92,19 @@ static inline void init_hostrt(void)
>>         nkvdso->hostrt_data.live = 0;
>>         rthal_catch_hostrt(&hostrt_event);
>>  }
>> +
>> +static inline void cleanup_hostrt(void)
>> +{
>> +       rthal_catch_hostrt(NULL);
>> +}
>>  #else
>> -static inline void init_hostrt(void) { }
>> +static inline void init_hostrt(void)
>> +{
>> +}
>> +
>> +static inline void cleanup_hostrt(void)
>> +{
>> +}
>>  #endif /* CONFIG_XENO_OPT_HOSTRT */
>>
>>  MODULE_DESCRIPTION("Xenomai nucleus");
>> @@ -235,8 +246,9 @@ int __init __xeno_sys_init(void)
>>
>>         xnpod_umount();
>>
>> -      cleanup_arch:
>> +       cleanup_hostrt();
>>
>> +  cleanup_arch:
>>         xnarch_exit();
>>
>>  #endif /* __KERNEL__ */
>> @@ -261,7 +273,7 @@ void __exit __xeno_sys_exit(void)
>>
>>         xntbase_umount();
>>         xnpod_umount();
>> -
>> +       cleanup_hostrt();
> 
> Did a quick and dirty hack just after you posted your original response, 
> and this one function cured the bug.
> 
>>         xnarch_exit();
>>
>>  #ifdef __KERNEL__
> 
> Reverted my hack and applied your patch, and xeno-nucleus has been 
> running fine all day - The skins on the other hand haven't...
> Unloading any of the skins result in the kernel halting. It appears as 
> if it is a deadlock, but I suspect it is timer related - A subject for 
> another thread perhaps.


Mmmm... does not look too tested either. Try the following patch:
diff --git a/kernel/ipipe/timer.c b/kernel/ipipe/timer.c
index 4286e4a..9838dc4 100644
--- a/kernel/ipipe/timer.c
+++ b/kernel/ipipe/timer.c
@@ -317,6 +317,7 @@ void ipipe_timer_stop(unsigned cpu)
 		evtdev->mult = timer->real_mult;
 		evtdev->shift = timer->real_shift;
 		evtdev->set_mode = timer->real_set_mode;
+		evtdev->set_next_event = timer->real_set_next_event;
 		timer->real_mult = timer->real_shift = 0;
 		timer->real_set_mode = NULL;
 		timer->real_set_next_event = NULL;

-- 
                                                                Gilles.

