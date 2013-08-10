Message-ID: <5206353E.4070804@xenomai.org>
Date: Sat, 10 Aug 2013 14:42:38 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <52039EC3.4050908@gmail.com>
	<2A0F278E-ED28-46CC-8727-DC97BB89A6D6@mah.priv.at>
	<68671d77.6ce2003b.520526a4.3e2c@o2.pl>
	<52060B80.1080601@gmail.com>
	<ca8c552.13b41e8d.52063223.12f46@o2.pl>
In-Reply-To: <ca8c552.13b41e8d.52063223.12f46@o2.pl>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] Using hardware PWM generators with Xenomai
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Robert <robert-km@o2.pl>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 08/10/2013 02:29 PM, Robert wrote:
> I have decided to push it here, since it was private message:
> 
> Dnia 10 sierpnia 2013 11:44 Sagar Behere <sagar.behere@gmail.com> napisał(a):
> 
>> On 08/09/2013 07:28 PM, Robert wrote:
>>> I wrote this driver recently, and it generates stable pwm signal. Probably you will have to adapt it to beaglebone black.
>>> It is written for Pandaboard and its hardware general purpose timer.
>>> There are some ioctl interfaces for user space.
>>>
>>> https://github.com/rkmiec/pandaboard-pwm-rtdm/tree/dc_engine
>>>
>>> Do NOT use master branch now.
>>
>> Hello Robert,
>>
>> Quick question about your pandaboard-pwm-rtdm.
>>
>> I see in pwm.c (dc_engine branch), lines 125 and 127, that you use 
>> gpio_set_value() to set the level of the gpio pin. This function comes 
>> from #include <linux/gpio.h>, which is a standard linux driver, I guess. 
>> So every time you call this function, you are making a linux kernel 
>> call.. won't that trigger a transition away from xenomai's primary 
>> domain? i.e., you task won't be hard realtime anymore..
>>
>> I haven't understood xenomai completely, so it is possible that my 
>> reasoning is wrong. Could you clarify?
>>
>> Thanks and regards,
>> Sagar
>>
> 
> 
> 
> I'm learning it too.
> gpio_set_value() could be called from any context (comments in
> drivers/gpio/gpiolib.c), so it shouldn't sleep.
> On osciloscope this signal looks very stable. Also servo connected to this
> signal is not shaking.
> 
> 
> And why I'm toggling gpio:
> On pandaboard, hardware outputs from those timers are connected to HDMI
> outuput, camera, display (for backlight) etc.
> None of them is available on expansion connector. That is why I'm toggling
> gpios.
> 
> My program differs a little from Andrey.
> I'm using hardware interrupts from timers to change value on gpio pin and
> he was using rtdm_sleep*() (as far as I remember).

gpio_set_value is only safe to be called from Xenomai context if care
has been taken in the I-pipe patch, as described here:
http://www.xenomai.org/index.php/I-pipe-core:ArmPorting#GPIOs_in_real-time_drivers

Calling a Linux service from real-time context in kernel-space never
results in a switch to secondary mode.

If the service can be called from real-time context, namely if it does
not rely on a Linux kernel coherent state (as is the case for instance
for memcpy), or if special care has been taken to make this service
callable from primary mode (as should be the case of gpio_get/set_value
for supported ARM platforms), it can be called.

Otherwise if you are lucky, it may call BUG_ON/WARN_ON if you enabled
CONFIG_IPIPE_DEBUG_CONTEXT, and if you are unlucky, it will sometime
work, and sometime cause random crashes.

But it never will cause the thread to transition to secondary mode. Only
system calls, called by user-space threads do that.

-- 
                                                                Gilles.

