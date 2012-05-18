Message-ID: <4FB5FF19.2080209@domain.hid>
Date: Fri, 18 May 2012 09:49:45 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <C7408997F5B0784C970ED53C11855FAE011112339155@domain.hid>,
	<C7408997F5B0784C970ED53C11855FAE01111232AFE7@domain.hid>
	<C7408997F5B0784C970ED53C11855FAE011112339156@domain.hid>,
	<30154f906372933f78eb6a9f4c632782.squirrel@domain.hid>
	<C7408997F5B0784C970ED53C11855FAE011112339157@domain.hid>
In-Reply-To: <C7408997F5B0784C970ED53C11855FAE011112339157@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] RE :  IRQ latency
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jean-Pascal JULIEN <jean-pascal.julien@domain.hid>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 05/18/2012 09:06 AM, Jean-Pascal JULIEN wrote:
>>> Hi,
>>>
>>> I installed xenomai on an overo water board (cortex A8) and performed
>>> latency tests.
> 
>> What version of Xenomai?
> 
>>> I tested two modules.
>>> The first module is based on an internal timer. It toggles a GPIO each
>>> 1ms.
>>> The second module waits for an external interrupt from an input GPIO
>>> (square signal at 1KHz). When that happens, the module toggles a GPIO pin.
>>>
>>> When i load the system and do a transfer from Ethernet to the sd card the
>>> first module works fine with a maximum latency less than 50us.
>>> But the second module, in the same context, have a maximum latency of
>>> several milliseconds.
>>>
>>> As the first module works fine i think i have a problem with the hardware
>>> configuration like the hardware irq priority.
>>> In the irq.c file, the irq priority level is not set for the linux domain.
>>>
>>> Should i configure the irq level at the initialization of the board ? What
>>> else could cause this issue ?
> 
>> The error is more likely in the code of your driver. Show us the code.
> 
> Hi Gilles,
> 
> 
> Sorry, i forgot the essential.
> My linux kernel version is the 2.6.38 from sakoman. 
> My xenomai version is xenomai-2.6.0
> The adeos patch is : adeos-ipipe-2.6.38.8-arm-1.18-04.patch ( ./prepare-kernel.sh --linux=${WORKDIR}/git --arch=arm --adeos=${WORKDIR}/xenomai-2.6.0/ksrc/arch/arm/patches/adeos-ipipe-2.6.38.8-arm-1.18-04.patch).
> The xenomai user space is make with the next configuration : 
>  ./configure --build=arm-ti-linux --host=arm-none-linux-gnueabi --prefix=/usr --includedir=/usr/include/xenomai  --enable-arm-tsc=omap3   --disable-dox-doc --disable-dbx LDFLAGS="-Wl,-O1 -Wl,--hash-style=gnu"

You do not need --enable-arm-tsc.

I see nothing wrong with your code. However this version of the I-pipe
patch has a bug with gpio irqs. You can try backporting this patch:

http://git.xenomai.org/?p=ipipe-gch.git;a=commit;h=81bfc05c4716b76e79f5e486baf4c52015a3b92c

To fix it. If that is the cause of your problem, then you should only
see the bug if you are running some other real-time program which
triggers a user-space task wakeup based in an interrupt, such as for
instance the timer interrupt. Running the "latency" test for instance
would do that.


-- 
                                                                Gilles.

