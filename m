Message-ID: <4FB154F9.3030807@domain.hid>
Date: Mon, 14 May 2012 20:54:49 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <2037196635.155333961.1337011990782.JavaMail.root@domain.hid>
	<4FB13059.6060503@domain.hid>
In-Reply-To: <4FB13059.6060503@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Xenomai on the TS-7553 ARM SBC
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: aubin.rebillat@domain.hid
Cc: xenomai@xenomai.org

On 05/14/2012 06:18 PM, Gilles Chanteperdrix wrote:
> On 05/14/2012 06:13 PM, aubin.rebillat@domain.hid wrote:
>> Hi Gilles,
>>
>> I've followed your advices and reimplemented the timer management. 
>> Now it's an up counter wrapping to 0 on overflow, it uses a match 
>> register to trigger the interrupt and it's never disabled.
>>
>> I've also cleaned the code : suppressed linux specific calls, move 
>> update_tsc to linux handler, etc... as you advised me.
>>
>> Then, I tested this with both CONFIG_IPIPE and CONFIG_XENOMAI 
>> disabled, and it's working fine.
>> I also tested with only CONFIG_XENOMAI disabled and it's still
>> working as expected.
>>
>> Nevertheless, the issue is still the same. It hangs after starting
>> the init program. 
>>
>> After investigations, the problem is that __ipipe__mach_set_dec is 
>> never called after Xenomai has taken control of the  timer. The last 
>> timer update was done in rthal_timer_calibrate and it effectively 
>> triggers an interrupt after MAXINT ticks (I've put a printk in the 
>> linux timer handler and it's displayed after a few time).
>>
>> My problem is that i don't really understand the timer management by
>> Xenomai. As i understood each skin has its own timers and Xenomai
>> manages to trigger them when expected. But what code is managing the
>> linux timer ?
>> I'm expecting to probably have errors in my ipipe code that's why i'm
>> asking this, to follow the execution and see where it is broken.
>>
>> Thank you very much,
> 
> 
> If the interrupt triggers only once, it probably means that the timer
> needs some acknowledgement that must be put in __ipipe_mach_acktimer.
> 
> The code managing Linux timer works and has been validated on all the
> port so far. So, the thing probably at fault is the timer management
> code in the I-pipe patch. Do not worry for Linux timer interrupt, only
> take care of ipipe_mach_set_dec and ipipe_mach_acktimer.
> 
> Also, if some timer programming is done in linux timer interrupt, it
> should not be done once ipipe_mach_timerstolen is true.
> 

To summarize, there are two states in the system:

Either Linux is handling the timer, in which case:
- ipipe_mach_timerstolen == 0
- ipipe_mach_acktimer is called to acknowledge the linux timer interrupt
- linux timer interrupt routine is called for each timer interrupt, HZ
times a second, and in charge to reprogram the timer hardware if it
needs to be reprogrammed

Either xenomai is handling the timer, in which case:
- ipipe_mach_timerstolen == 1
- ipipe_mach_acktimer is called to acknowledge the xenomai timer interrupt
- ipipe_mach_set_dec is called by xenomai to program the next timer
interrupt

linux timer interrupt is called HZ times a second, but should not touch
anything related to the timer hardware, because that part is handled by
xenomai now (vie ipipe_mach_set_dec).

if CONFIG_IPIPE is enabled and CONFIG_XENOMI is disabled, only the first
state happens.

if CONFIG_XENOMAI is enabled, as soon as xenomai is started, we enter
the second state.

-- 
                                                                Gilles.

