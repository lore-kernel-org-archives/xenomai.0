Message-ID: <4DB9B978.2010200@domain.hid>
Date: Thu, 28 Apr 2011 21:01:12 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4DB8149A.7080600@domain.hid>	<4DB83CBE.5040007@domain.hid>	<4DB94BA0.1020503@domain.hid>	<4DB94C9C.7080904@domain.hid>	<4DB991E6.90403@domain.hid>	<4DB99E47.7000904@domain.hid>
	<BANLkTik_MeMvpq2x7N0WmML97uW5=HxsLw@domain.hid>
In-Reply-To: <BANLkTik_MeMvpq2x7N0WmML97uW5=HxsLw@domain.hid>
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
> 2011/4/28 Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
> 
>> Well, is not that an effect of kgdb? The timer tick occurs 100 or 1000
>> times per second, so, you can not keep up with gdb. The fact that a new
>> interrupts may occur why handling another interrupt is normal with Adeos.
>>
>> It is not to say that there is no irq loop, but we can not conclude from
>> the symptoms you are describing.
>>
>>
> I understand this possibility. I did a simple test: just switched the
> processor back and forth between "run" and "halt" many many times. I did it
> on hardware (JTAG) level so I believe the CPU was running at full speed. And
> it was catched in one of these interrupt handlers every time, I've never
> seen it in any other function. Thus I believe it was doing nothing else. The
> stack is suspicious as well: it has lots of IRQ stuff, nothing but IRQs,
> even if I interrupt the CPU for the first time.
> 
> 
> 
>> Is there an earlier version of the I-pipe patch which was working?
>>
>>
> Unfortunately I've not tested earlier versions. I'll try. They say it worked
> with linux 2.6.29 (ipipe version not mentioned, but it was just before the
> mini2440 timer3 patch was submitted to mainstream):
> http://www.friendlyarm.net/forum/topic/598
> 
> Seems that these guys have the same problem:
> http://www.friendlyarm.net/forum/topic/1108

So, have you tried reverting the timer3 patch?

-- 
                                                                Gilles.

