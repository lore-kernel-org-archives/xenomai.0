Message-ID: <50FE507C.6080406@xenomai.org>
Date: Tue, 22 Jan 2013 09:40:28 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CALJOq=VtrBhMzCaT=7omDVN9hnnwZ+cmM1_1eff9DTS-fvLjaw@mail.gmail.com>	<201301200013.09110.paul_c@tuxcnc.org>	<50FBF628.1000709@xenomai.org>	<201301220306.28220.paul_c@tuxcnc.org>
	<50FE44F5.9000204@xenomai.org>
In-Reply-To: <50FE44F5.9000204@xenomai.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] GPIO Interrupts problem with RTDM
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Paul <paul_c@tuxcnc.org>
Cc: Pierre LE COZ <peter.le.coz@gmail.com>, xenomai@xenomai.org

On 01/22/2013 08:51 AM, Gilles Chanteperdrix wrote:

> On 01/22/2013 04:06 AM, Paul wrote:
> 
>> On Sunday 20 January 2013, Gilles Chanteperdrix wrote:
>>> On 01/20/2013 01:13 AM, Paul wrote:
>>
>>>>>  About the fact that interrupts are not detected :
>>>>>
>>>>> This may be a generic issue, which I thought was fixed, but may
>>>>> not be.
>>>>>
>>>>>> Could you try the following patch?
>>>>>
>>>>> http://git.xenomai.org/?p=ipipe-gch.git;a=commit;h=c14c79d29fed822
>>>>> 675 60c7bf26d628ef4d39f5b7
>>>>
>>>> Gilles: Looked at the patch and got as far as the changes in
>>>> kernel/ipipe/timer.c:ipipe_timer_stop() - Correct me if I'm wrong,
>>>> but this patch is based on a 3.5.7 parent without
>>>> GENERIC_CLOCKEVENTS ?
>>>
>>> Yes, this patch is based on 3.5.7 and is used with and without
>>> GENERIC_CLOCKEVENTS.
>>
>> Short version: Updated my kernel to 3.5.7 and backported the Raspberry 
>> Pi changes from 3.6.11 and added in the ipipe support. Interrupts are 
>> not being recognised unless irq_set_irq_type() is called. Digging 
>> through the rtdm, nucleus, and ipipe code, at no point is 
>> irq_chip->irq_set_type() called - Also have a problem that none of the 
>> ipipe_pic_muter fields are set, so __ipipe_enable_irqdesc() & friends 
>> do nothing.
>>
>> Noticed XN_ISR_EDGE equates to a falling edge trigger - 
>> irq_set_irq_type() allows for rising, level, or falling edge triggers. 
>> At some point, it may be advantageous to be able to select one of the 
>> three.
>>
>> Will continue digging and add a routine in bcm2708_gpio.c to set the 
>> ipipe_pic_muter fields in the morning.
> 
> 
> PIC muting is not mandatory, I am not sure why you would need it.
> 

If you decide to implement it anyway, you may find some information here:
http://xenomai.org/index.php/I-pipe-core:ArmPorting#Interrupt_Controller_muting

-- 
                                                                Gilles.

