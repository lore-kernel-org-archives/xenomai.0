Message-ID: <4CD090F8.7040909@domain.hid>
Date: Tue, 02 Nov 2010 23:30:16 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <AANLkTinN+KBK2B77opSCwDvb9bneObxL1+FTmmwpQGup@domain.hid>	<4CC20AD2.4060501@domain.hid>	<AANLkTi=W0w277PctkebaC=BcTLNZeW3KMzPzp=X1isB=@mail.gmail.com>	<4CC665AC.5030802@domain.hid>	<AANLkTi=5YF3QnvK9iGpBs8enuA+=MHz7gKjE1p_3whM+@mail.gmail.com>	<4CD00450.6020100@domain.hid>
	<AANLkTikFiNw5HcDJsnbVsER9xjvPWAm5dBbZM9uiRh6x@domain.hid>
In-Reply-To: <AANLkTikFiNw5HcDJsnbVsER9xjvPWAm5dBbZM9uiRh6x@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Slow hard drive access in xenomai
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Peter Pastor <peter.pastor@domain.hid>
Cc: xenomai@xenomai.org

Peter Pastor wrote:
> Hey Gilles,
> 
> I do understand the intention of why I should disable either of the two (usb
> controller and SATA drives), however, what I meant is, I need both
> "permanently". If I disable all the usb ports, then I only have access over
> ethernet (ssh), since the keyboard is attached to the computer through usb
> (there are no other options). Also, to the best of my knowledge, disabling
> means disabling them in the BIOS, correct? If so, I do not see how I could
> enable the usb controller again... Are there other ways to do that. If not,
> please let me know how to do it. The other option, disabling the SATA drives
> does not make sense either, since I need them to boot the kernel, do I ?

I was talking about the Intel HDA driver and the "ioc" driver. Since you
have another disk controller (ahci), you may probably boot on it for the
sake of testing.

> 
> Anyway, I added the kernel parameter "irqpooll" as suggested by the error
> msg in the kernel log... and since then I haven't seen the problem occurring
> again. The documentation says that I will loose some performance and I am
> wondering how much that is. However, I am willing to debug this further and
> to remove the irqpoll option again.

But if you are satisfied with irqpoll, why bother?


-- 
                                                                Gilles.

