Message-ID: <4DB9C0D3.4030003@domain.hid>
Date: Thu, 28 Apr 2011 21:32:35 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4DB8149A.7080600@domain.hid>	<4DB83CBE.5040007@domain.hid>	<4DB94BA0.1020503@domain.hid>	<4DB94C9C.7080904@domain.hid>	<4DB991E6.90403@domain.hid>	<4DB99E47.7000904@domain.hid>	<BANLkTik_MeMvpq2x7N0WmML97uW5=HxsLw@domain.hid>	<4DB9B978.2010200@domain.hid>
	<BANLkTinSWAT+33YFAD-z0kz6pesSQBe7qw@domain.hid>
In-Reply-To: <BANLkTinSWAT+33YFAD-z0kz6pesSQBe7qw@domain.hid>
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
> 2011/4/29 Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
> 
>>
>> So, have you tried reverting the timer3 patch?
>>
>>
> Yes. After reverting, EVERYTHING stops working correctly (even with ipipe
> off). It is really necessary.
> 
> Now I'm trying to understand the MMC code. Looks like that timers do their
> job correctly, and MMC/SD driver seems to be the source of irq flood. If so,
> it depends on kernel version, not on ipipe version. That is, ipipe seems
> just to trigger a bug in already buggy kernel. Trying to examine it more
> closely. Not sure.

Maybe you can try booting with MMC disabled, to see if the I-pipe is
working? Not permanently, just to confirm that you are not chasing the
wrong bug.

-- 
                                                                Gilles.

