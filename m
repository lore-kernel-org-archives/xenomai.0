Message-ID: <491D5769.1050308@domain.hid>
Date: Fri, 14 Nov 2008 11:48:09 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <406CC9939904F143B9D42CEEA3E56E565DA7FA@oab1mx1.oneaccess.intra>
	<4918560D.2000306@domain.hid>
	<406CC9939904F143B9D42CEEA3E56E566514C0@domain.hid>
	<491ABF34.8020504@domain.hid>
In-Reply-To: <491ABF34.8020504@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] xenomai on blackfin svn4240
Reply-To: rpm@xenomai.org
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Filip Van Rillaer <Filip.VanRillaer@domain.hid>
Cc: xenomai@xenomai.org

Philippe Gerum wrote:
> Filip Van Rillaer wrote:
>> Hello Philippe,
>>
>> Thank you for upgrading the blackfin code.  I upgraded to rev 4369 and
>> the compilation + booting the image works fine.
>> However, I am still having problems running programs with rt_task_shadow
>> (e.g. in examples/native/rtprint.c example).  Are you seeing similar
>> problems? (my platform is BF537 on Stamp)
>>
> 
> I have a serious kernel issue here with 1.7-04 on a bf561, so severe that I
> cannot actually run any app yet. I have a bf537 at hand as well, I think I'm
> going to give it a try asap.
>

The issue you faced has just been fixed in the trunk. There is a new I-pipe
patch brewing here for the blackfin as well, since all patches from the 1.7
series are terminally broken when it comes to handling GPIO interrupts. The
bf537 does work because the EMAC ethernet IRQ is not on the GPIO demux, but the
ethernet interrupt of the bf561 is.

You should be able to run your bf537 just pulling the from the current trunk; I
will release an updated I-pipe patch later.

>> Best regards,
>> Filip
>>
>> -----Original Message-----
>> From: Philippe Gerum [mailto:rpm@xenomai.org] 
>> Sent: 10 November 2008 16:41
>> To: Filip Van Rillaer
>> Cc: xenomai@xenomai.org
>> Subject: Re: [Xenomai-help] xenomai on blackfin svn4240
>>
>> Filip Van Rillaer wrote:
>>> Hello,
>>>  
>>> Starting from subversion revision 4240, xenomai is not compiling 
>>> anymore for blackfin.
>>> I think that part of the problem is the absence of following parts in 
>>> usermode (I mean not __KERNEL__) in the file asm-blackfin/atomic.h :
>>>  - typedef for xnarch_atomic_t is missing
>>>  - xnarch_atomic_get is missing
>>>  - xnarch_atomic_set is missing
>>>  - xnarch_atomic_cmpxchg is missing
>>>  
>>> I also had to make the function xeno_init_current_mode (file bind.h) 
>>> as <<static inline>> to avoid a problem with multiple definitions when
>>> linking my user-application (it includes functions of native and rtdm 
>>> library).
>>>  
>>> Finally rt_task_shadow fails and returns  EFAULT (but that problem can
>>> be caused by my own dummy implementation for the functions mentioned)
>>>
>> The build woes should be fixed, but I still need to validate the trunk
>> on a
>> bf561 here.
>>
>>> Best regards,
>>> Filip
>>>
>>>
>>> ----------------------------------------------------------------------
>>> --
>>>
>>> _______________________________________________
>>> Xenomai-help mailing list
>>> Xenomai-help@domain.hid
>>> https://mail.gna.org/listinfo/xenomai-help
>>
>> --
>> Philippe.
>>
> 
> 


-- 
Philippe.

