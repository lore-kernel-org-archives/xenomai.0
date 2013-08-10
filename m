Message-ID: <520604C3.90903@gmail.com>
Date: Sat, 10 Aug 2013 11:15:47 +0200
From: Sagar Behere <sagar.behere@gmail.com>
MIME-Version: 1.0
References: <52039EC3.4050908@gmail.com>
	<2A0F278E-ED28-46CC-8727-DC97BB89A6D6@mah.priv.at>
	<68671d77.6ce2003b.520526a4.3e2c@o2.pl>
In-Reply-To: <68671d77.6ce2003b.520526a4.3e2c@o2.pl>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] Using hardware PWM generators with Xenomai
Reply-To: sagar.behere@gmail.com
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

(top posting, because confused how to bottom post in response to two top 
posts)

Thanks for your suggestions, people. I'll go through your code and learn 
from it.

One thing though: All the suggestions in the responses (and others I've 
seen on mailing list history) toggle the GPIO pins to generate the PWM 
signal. Why do this if there is a perfectly good PWM generation hardware 
on the chip? (like the am33xx has the eHRPWM generator). Me, I'd go for 
the gpio route only if the onboard PWM generation hardware does not 
provide sufficient number of PWMs. Or, is there some problem with the 
onboard PWM hardware that I am not aware of?

For my application, I only need 2 pwms, and the onboard eHRPWM module 
provides 3, so I prefer to use this module.

Thanks and regards,
Sagar

On 08/09/2013 07:28 PM, Robert wrote:
> I wrote this driver recently, and it generates stable pwm signal. Probably you will have to adapt it to beaglebone black.
> It is written for Pandaboard and its hardware general purpose timer.
> There are some ioctl interfaces for user space.
>
> https://github.com/rkmiec/pandaboard-pwm-rtdm/tree/dc_engine
>
> Do NOT use master branch now.
>
> Dnia 8 sierpnia 2013 16:26 Michael Haberler <mail17@mah.priv.at> napisał(a):
>
>> Sagar,
>>
>> you might want to study the LinuxCNC code, which does PWM - among other functions like a stepper generator - via the PRU
>>
>> http://git.linuxcnc.org/gitweb?p=linuxcnc.git;a=tree;f=src/hal/drivers/hal_pru_generic;h=5e7dc56c1891408833362fd7f480a9da20dcc31d;hb=refs/heads/unified-build-candidate-1
>>
>> - Michael
>> Am 08.08.2013 um 15:36 schrieb Sagar Behere <sagar.behere@gmail.com>:
>>
>>> Hello,
>>>
>>> I wish to generate PWM signals from Xenomai, using the beaglebone black, kernel 3.8.13 patched with xenomai.
>>>
>>> There already exist linux kernel modules for the hardware PWM generator (eHRPWM) on the am335x chip in the beaglebone. The PWM generator can be configured and controlled via the /sysfs interface and the whole thing works very well.
>>>
>>> I understand that the /sysfs interface cannot be used by xenomai tasks without triggering a transition away from the primary xenomai (hard realtime) domain. So my question is: What is the least effort way to change the duty cycle of the hardware PWM generator, from a xenomai task?
>>>
>>> Does the following approach sound feasible?
>>>
>>> 1. Configure the PWM generator (freq, polarity etc.) from the /sysfs interface at application startup. This need not be realtime
>>> 2. Assuming that the duty-cycle is controlled by the value of some memory-mapped register, use mmap()/ioremap() to map that register's address into the xenomai task's address space.
>>> 3. Write the duty-cycle values to the mapped memory, from within the xenomai task
>>>
>>> So this is like a hybrid approach that uses the existing linux kernel module for initializing/configuring the hardware PWM and the xenomai task only changes the value of one register that affects the duty cycle of the output waveform.
>>>
>>> Thanks in advance,
>>> Sagar
>>>
>>> _______________________________________________
>>> Xenomai mailing list
>>> Xenomai@xenomai.org
>>> http://www.xenomai.org/mailman/listinfo/xenomai
>>
>>
>> _______________________________________________
>> Xenomai mailing list
>> Xenomai@xenomai.org
>> http://www.xenomai.org/mailman/listinfo/xenomai
>>
>
> _______________________________________________
> Xenomai mailing list
> Xenomai@xenomai.org
> http://www.xenomai.org/mailman/listinfo/xenomai
>


