Message-ID: <43EBA31B.2020107@domain.hid>
Date: Thu, 09 Feb 2006 13:16:27 -0700
From: John Schipper <jschipper@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Isolated CPU, SMI problems an thoughts
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

Jan Kiszka wrote:

> John Schipper wrote:
>  
>
>> Hello,
>> I'm new to this list but have in the past used RTAI in a single
>> processor off the shelf solution. I'm looking to switch to native
>> Xenomai api but have a general problem...
>> The problem is SMI on new systems, and other latency killers that
>>   
>
>
> What do you mean with "other" precisely?
>  
>
I have seen on systems the need to disable USB Legacy/emulation? and 
only use a PS/2 keyboard.  The USB interface (tied to a usb keyboard and 
mouse) are standard on a Dell GX280 without a PS/2 interface.  I believe 
and have seen real-time having problems.  This is due to to SMM mode, I 
believe, being a latency killer (not sure if this is SMI related).

In regard to SMI I poked around the intel chips registers (sorry can't 
remember what the GX280 chipset was but I could get it if important!  ) 
and I found that their are lock bits that do not allow disabling global 
SMI or the watchdog capability.  This was 6 months ago at least so I 
have not tested the latest smi workaround module (in RTAI at least 
because I have not use xenomai yet but plan too :) )

>  
>
>> sometimes are not controllable by software always popping up when trying
>> to migrate to a newer platform.  Can a dual core processor using
>> isolcpus, preemp-rt and xenomai effectively future proof agains smi/chip
>> set issues (specificly AMD or Intel dual core solutions) by isolating a
>> cpu for exclusively xenomai/realtime use?
>>   
>
>
> SMI can only be addressed with CPU isolation if you are able to redirect
> the related event only to one CPU. Don't know if this is possible / 
> default.
>
>  
>
This redirection has occured to me also.   A couple months ago I 
inquired and did not get any confirmation either way from Dell about 
doing this and maybe they do not know and I need to ask 
Intel/Via/AMD?......  Its not clear (if even possible ) to me if this 
would be a bios feature or only controlled by using a special chipset 
kernel patch or module?

> There are tricks to disable SMI on modern Intel chipsets. Xenomai
> implements this, you can select the workaround during system
> configuration. Don't this work for your particular systems? Then please
> report details.
>
>  
>
 SMI tricks had not worked on a Dell GX280 system but I plan to start 
some more testing again with xenomai.  The fact that it did not work 
prompted me to dig into the SMI/SMM registers and is where I discovered 
that I could not get past the lock bit capability of the SMI/SMM chipset 
that was being set by the bios (not positive this is where it was 
happening ) and after some failed attempts I just continued with the 
Dell 170/270 solution.  If there is an advantage or maybe even a hope :) 
that an isolated cpu will help in regards to SMI/SMM then I plan to go 
ahead and order some systems to test otherwise I may continue to try to 
testing single core solutions.

> "Other", more subtle latency issues can only be addressed when the
> mechanisms behind them are understood. Depends on the chipset
> manufacturer's documentation. So, no general answer is possible.
>
>  
>
>> Some background information:  The realtime software I've developed in
>> the past (with RTAI/adeos in user space) is a simple high speed
>> serializer driver (mmap) to communicate with outside hardware and is
>> responsible for syncronizing (with a semaphore/mutex) a linux process
>> (soft realtime) at ~60Hz.  The realtime process is periodic at 1.2Khz or
>> 2.4Khz and calculates/filters the data before sending commands back down
>> the serializer interface and to the linux process for soft realtime
>> network access.
>>
>> Generally we like to use "off the shelf" business PC's (Dell 170's and
>> Dell 270's, HP 5000 with 1Gig memory) and find that 20-30us latency is
>> achievable.  We use "off the shelf" hardware because availability
>> (recieve within a week) and low cost are desired.   Whenever looking for
>> an alernative solution either availablity or cost becomes a show
>> stopper.  I'm open to suggestions and invite anyones thoughts on the
>> subject.
>>   
>
>
> Using off the shelf standard systems is always risky. I've heard of a
> larger German automation company ordering standard PC hardware for
> industrial control purposes only when initial latency tests on a
> specific charge were successful. Ok, they are ordering large enough
> quantities, so they can dictate certain conditions...
>
>  
>

 Testing the system is done to verify latency and expected real-time 
isolation from the normal linux tasks. Its done on a standard system and 
once verified used until the system is no longer available which seems 
to be happening at an increasing rate.  PCI express may be a reason, 
maybe money.. but systems don't last much longer then a year and a 
half.  Either way the motherboards themselves don't stay around to 
long.  Our quantity is not there for the needed leverage with providers 
:( .  The system is used for an industrial purpose which is NOT for a 
life saving/risking situation.  Its used for simulation or simulator 
purposes.

> Jan
>
>  
>
John

