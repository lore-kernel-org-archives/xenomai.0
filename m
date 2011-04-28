Message-ID: <4DB99E47.7000904@domain.hid>
Date: Thu, 28 Apr 2011 19:05:11 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4DB8149A.7080600@domain.hid> <4DB83CBE.5040007@domain.hid>
	<4DB94BA0.1020503@domain.hid> <4DB94C9C.7080904@domain.hid>
	<4DB991E6.90403@domain.hid>
In-Reply-To: <4DB991E6.90403@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Adeos-main] Ipipe hangs on ARM MINI2440 after switching
	clocksource
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/options/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Alexey Galakhov <agalakhov@domain.hid>
Cc: adeos-main@gna.org

Alexey Galakhov wrote:
> On 04/28/2011 05:16 PM, Gilles Chanteperdrix wrote:
>> Ok. Better try without this patch first, then try reapplying the patch
>> when you are certain that everything else works correctly. The patch
>> enables some assembly code that was never actually tested. On my side, I
>> will try and test it separately.
> So I tried to trace the kernel using gdb and jtag.
> 
> It enters the interrupt handler over and over again. If I set a
> breakpoint at __ipipe_grab_irq, I see the following:
> __ipipe_grab_irq (irq=37, regs=0xc3dd3f08)
> __ipipe_grab_irq (irq=30, regs=0xc3dd3f08)
> __ipipe_grab_irq (irq=37, regs=0xc3dd3f08)
> __ipipe_grab_irq (irq=30, regs=0xc3dd3f08)
> and so on. Note the strict order of IRQs 30 and 37.
> 
> According to /proc/interrupts running vanilla kernel, these IRQs are:
>  30:      36105         s3c  S3C2410 Timer Tick
>  37:      12464         s3c  s3c-mci
> 
> As far as I can see, these two IRQs are both handled by the same code in
> ipipe. And they are both periodic and occur so frequently that they
> interrupt each other's handler. Looks like they aren't masked properly
> for some reason. So the kernel loops infinitely in these two interrupt
> handlers and does never exit them!

Well, is not that an effect of kgdb? The timer tick occurs 100 or 1000
times per second, so, you can not keep up with gdb. The fact that a new
interrupts may occur why handling another interrupt is normal with Adeos.

It is not to say that there is no irq loop, but we can not conclude from
the symptoms you are describing.

Is there an earlier version of the I-pipe patch which was working?



-- 
					    Gilles.

