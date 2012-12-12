Message-ID: <50C84FA3.4070907@xenomai.org>
Date: Wed, 12 Dec 2012 10:34:27 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <1491832.238.1355257934434.JavaMail.poli@jacqueline>	<FE9848C4-D19F-4628-8047-5E67A667A2E9@mah.priv.at>	<50C8330D.8040305@xenomai.org>	<325B0F26-79FE-4C8B-A41E-10ED40FC0B3B@mah.priv.at>	<50C849BB.9090307@xenomai.org>
	<7A843E24-17B0-4F91-96DA-84CE8007AC5A@mah.priv.at>
In-Reply-To: <7A843E24-17B0-4F91-96DA-84CE8007AC5A@mah.priv.at>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] RT GPIO with Raspberry Pi
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Michael Haberler <mail17@mah.priv.at>
Cc: xenomai@xenomai.org

On 12/12/2012 10:28 AM, Michael Haberler wrote:
> 
> Am 12.12.2012 um 10:09 schrieb Gilles Chanteperdrix:
> 
>> On 12/12/2012 09:30 AM, Michael Haberler wrote:
>>>>
>>>> ...
>>>
>>> just to make sure I understand your suggestion:
>>>
>>> in kernel mode you'd suggest to go through gpiolib and use
>>> gpio_get_value/gpio_set_value if possible ?
>>>
>>> in user mode you can prepare things through sysfs but I dont see an
>>> alternative to memory-mapped register manipulation in that case if
>>> one wants to avoid system calls like read/write/open/ioctl which
>>> likely will be a dog on top of switching to secondary domain
>>
>> This happens if you put the kernel/user split in the wrong place. For
>> instance, if your GPIOS are used to implement an I2C master,
>> implementing the I2C master in user-space manipulating GPIOS in
>> kernel-space is the wrong thing to do. What you should do is implement
>> the I2C master in kernel-space, and use it either in other drivers, or
>> in user-space. This way, you will get a write for a whole I2C transfer
>> instead of a write for each GPIO change. The same goes for a PWM, SPI
>> master, RS232 why not, etc... If your GPIOs are used to power on/power
>> off some devices, then using them in primary mode is probably not relevant.
> 
> in that particular application, the GPIO's are used, among others, for generating stepper pulses, and the thread running this should be as fast as possible; in the RTAI/parport version of that code that's anywhere from 20-50uSec
> 
> nothing else though except wiggling pins, in particular no interrupt-driven input; so I dont see any extra functionality a kernel driver could provide

A stepper pulse driver ? You name it...

-- 
					    Gilles.

