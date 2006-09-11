Message-ID: <4504EA2C.4080604@domain.hid>
Date: Mon, 11 Sep 2006 06:46:36 +0200
From: Philipp Keller <philipp.keller@domain.hid>
MIME-Version: 1.0
References: <E1GMOIv-000171-QV@server-r004.hostpoint.ch>
In-Reply-To: <E1GMOIv-000171-QV@server-r004.hostpoint.ch>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] external hardware interupts on a PPC405
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

xenomai-core-request@domain.hid wrote:
> Send Xenomai-core mailing list submissions to
> 	xenomai@xenomai.org
>
> To subscribe or unsubscribe via the World Wide Web, visit
> 	https://mail.gna.org/listinfo/xenomai-core
> or, via email, send a message with subject or body 'help' to
> 	xenomai-core-request@domain.hid
>
> You can reach the person managing the list at
> 	xenomai-core-owner@domain.hid
>
> When replying, please edit your Subject line so it is more specific
> than "Re: Contents of Xenomai-core digest..."
>
>
> Today's Topics:
>
>    1. Re: Re: CAN updates & questions (Matthias Fuchs)
>    2. No hardware interrupts with xenomai on ppc405  (Matthias Fuchs)
>    3. Re: No hardware interrupts with xenomai on ppc405
>       (Wolfgang Grandegger)
>    4. Re: Xenomai on PXA (Gilles Chanteperdrix)
>
>
> ----------------------------------------------------------------------
>
> Message: 1
> Date: Sun, 10 Sep 2006 12:27:21 +0200
> From: Matthias Fuchs <matthias.fuchs@domain.hid>
> Subject: Re: [Xenomai-core] Re: CAN updates & questions
> To: Wolfgang Grandegger <wg@domain.hid>
> Cc: Jan Kiszka <jan.kiszka@domain.hid>, xenomai@xenomai.org
> Message-ID: <4503E889.2080306@domain.hid>
> Content-Type: text/plain; charset=ISO-8859-1
>
> Hi Wolfgang,
>
> Wolfgang Grandegger wrote:
>   
>> Hi Matthias,
>>
>> Matthias Fuchs wrote:
>>     
>>> Hi Wolfgang,
>>>
>>> Wolfgang Grandegger wrote:
>>>       
>>>> You have to define the real CAN system clock, which is 16/2 = 8 Mhz for
>>>> most SJA 1000 hardware even if the oscillator is running at 16 MHz. I
>>>> will add some reasonable note to rtcan_dev.h
>>>>         
>>> Is there any special reason for this? Wouldn't it be more meaningful
>>> to pass the SJA1000 externally applied clock frequency? I can imagine
>>> that others will also run into this issue as Jan and I did yesterday ;-)
>>>       
>> The frequency is used to calculate reasonable bit-timing parameters, not
>> only for SJA 1000. It's used in a similar way in the Linux socket CAN
>> driver.
>>     
> I am not very familiar with the socket CAN driver, but after a quick
> glance at its svn repository it seems to me that they are also passing
> the SJA1000 external clock frequency to the module (clk-parameter).
>
> So I think other controller's drivers may use an other meaning of the
> clk/clock parameter. But for SJA1000 the ext. clock frequency is best.
>   
>>>>> Then we will soon have to discuss how to deal with a rtcan_isa
>>>>> derivative that uses ioremapped memory instead of ports (naming,
>>>>> separation or integration).
>>>>>           
>>>> We could add a generic device similar to ISA (or extend ISA
>>>> accordingly).
>>>>         
>>> The SJA1000 isa driver is very simple - and so is the modified version
>>> for the memory mapped SJA1000. I think that merging both ways of
>>> access to the SJA1000 into a single driver will make the code much
>>> more dirty. I would prefer different source files (= different drivers). 
>>>       
>> I agree.
>>
>>     
>>> It would be a compromise to add support for boards that use some kind
>>> of indirect addressing to access the SJA1000 (address + data register)
>>> into the isa and mem versions of the driver.
>>>       
>> Fine if this could be done in a generic way. We also should add a
>> generic PCI driver sooner than later.
>>
>>     
>>> One more proposal: I think many (old) ISA drivers name the module
>>> parameter for the ISA io port "io" instead of "isa". For the memory
>>> mapped SJA1000 driver, I'd like to call the parameter "mem".
>>>       
>> Well, I cannot remember why I used the name "isa". Common is "io" or
>> "port" or "ioport", indeed. "io" and "mem" or "ioport" and "iomem" would
>> be fine for me.
>>     
> I will use mem for the mem'mapped driver. The socket CAN project uses
> base_addr - they must have an affection to a long parameter name :-)
>
> Matthias
>
>
>
>
> ------------------------------
>
> Message: 2
> Date: Sun, 10 Sep 2006 12:40:08 +0200
> From: Matthias Fuchs <matthias.fuchs@domain.hid>
> Subject: [Xenomai-core] No hardware interrupts with xenomai on ppc405 
> To: xenomai@xenomai.org
> Message-ID: <4503EB88.2040309@domain.hid>
> Content-Type: text/plain; charset=ISO-8859-1
>
> Hi,
>
> I was trying to use some external hardware interupts on a PPC405 board
> as part of a hacking session with Jan to bring up the rtcan driver on
> this board.
>
> Here are some versions:
>
> 	Linux Kernel: 2.6.14
> 	Adeos: 1.3-07
> 	Xenomai: from svn (2.3pre, last friday night)
>
> The first interrupt interrupt was always fine. When the 2nd interupt
> occured, it was never handled and did not cause any action. We used the
> ipipe-tracer and did not see anything related to the 2nd and any further
> interrupt.
>
> I think that the hardware interrupt is somehow masked and therefore
> never result in any action. So the handling of the first interrupt might
> be incorrect.
>
> This seems to be ppc or even ppc4xx related because I assume that x86
> platforms do not have this issue. Is this an Adeos issue.
>
> I will do the same test on a 2.4 kernel next week - if nobody tells me
> that this will be a waste of time.
>
> Matthias
>
>
>
> ------------------------------
>
> Message: 3
> Date: Sun, 10 Sep 2006 13:02:00 +0200
> From: Wolfgang Grandegger <wg@domain.hid>
> Subject: Re: [Xenomai-core] No hardware interrupts with xenomai on
> 	ppc405
> To: Matthias Fuchs <matthias.fuchs@domain.hid>
> Cc: xenomai@xenomai.org
> Message-ID: <4503F0A8.8050602@domain.hid>
> Content-Type: text/plain; charset=ISO-8859-1; format=flowed
>
> Hi Matthias,
>
> Matthias Fuchs wrote:
>   
>> Hi,
>>
>> I was trying to use some external hardware interupts on a PPC405 board
>> as part of a hacking session with Jan to bring up the rtcan driver on
>> this board.
>>
>> Here are some versions:
>>
>> 	Linux Kernel: 2.6.14
>> 	Adeos: 1.3-07
>> 	Xenomai: from svn (2.3pre, last friday night)
>>
>> The first interrupt interrupt was always fine. When the 2nd interupt
>> occured, it was never handled and did not cause any action. We used the
>> ipipe-tracer and did not see anything related to the 2nd and any further
>> interrupt.
>>
>> I think that the hardware interrupt is somehow masked and therefore
>> never result in any action. So the handling of the first interrupt might
>> be incorrect.
>>
>> This seems to be ppc or even ppc4xx related because I assume that x86
>> platforms do not have this issue. Is this an Adeos issue.
>>
>> I will do the same test on a 2.4 kernel next week - if nobody tells me
>> that this will be a waste of time.
>>     
>
> Could you please add printk statements to the ack, enable and end 
> functions to arch/ppc/syslib/ppc4xx_pic.c if the irq number matches. 
> Please print also SR, ER and status.
>
> Wolfgang.
>
>   
We are using ppc6xx, but hat a timing problem with external HW, perhaps
this is related to that interrupt thing? We saw on the oszilloscope that
we have to init the rtcan with half the baudrate the external modules
use, then it works.
Philipp
>
>
> ------------------------------
>
> Message: 4
> Date: Sun, 10 Sep 2006 14:19:47 +0200
> From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
> Subject: Re: [Xenomai-core] Xenomai on PXA
> To: Detlef Vollmann <dv@domain.hid>
> Cc: xenomai@xenomai.org
> Message-ID: <17668.739.465406.379629@domain.hid>
> Content-Type: text/plain; charset="us-ascii"
>
> Detlef Vollmann wrote:
>  > With that change, first tests look fine.
>
> Thanks, attached the patch with this error corrected.
>
>  > BTW, on the SA, what results do you get from xeno-test?
>
> latency in user-space easily get above 100 microseconds, if this is what
> you mean. But I guess this is what we should expect on ARM.
>
>   
 



