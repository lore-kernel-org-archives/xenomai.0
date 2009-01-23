Message-ID: <49799256.6000009@domain.hid>
Date: Fri, 23 Jan 2009 10:48:06 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <4979727E.6060304@domain.hid> <49798544.4050808@domain.hid>
	<49798994.1010903@domain.hid>
In-Reply-To: <49798994.1010903@domain.hid>
Content-Type: text/plain; charset=windows-1251
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] PowerPC irq unmask
Reply-To: rpm@xenomai.org
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: federico.ridolfo@domain.hid
Cc: xenomai@xenomai.org

Federico Ridolfo wrote:
> Philippe Gerum wrote:
>> Federico Ridolfo wrote:
>>   
>>> Hi all,
>>> my platform is a mpc5200b based one. I wrote
>>> some rtdm driver for that platform on linux-2.6.18
>>> kernel. Some info:
>>> - ARCH=ppc
>>> - no fdt (so no dts)
>>> - u-boot
>>> - xenomai 2.3.2,
>>> - adeos-ipipe-2.6.18-ppc-1.5-01.patch
>>> All works fine.
>>>
>>> Now i want to use:
>>> - ARCH = powerpc
>>> - linux kernel from denx: ipipe-2.6-26-powerpc-2.4-03
>>> - fdt (so i have a dts file)
>>> - xenomai-2.4.6.1
>>> - u-boot
>>> Ok. My board boots, all peripheral s work. Xenomai works, but
>>> my rtdm drivers don't work. The problem is that the rtdm_irq_request
>>> returns -ENODEV coming from line 166 in wrappers.h:
>>> ...
>>> #else /* > 2.6.19 */
>>> #define rthal_irq_chip_enable(irq)                    \
>>>     ({                                \
>>>         int __err__ = 0;                    \
>>>         if (unlikely(rthal_irq_handlerp(irq)->unmask == NULL))    \
>>>             __err__ = -ENODEV;     \
>>>         else                            \
>>>             rthal_irq_handlerp(irq)->unmask(irq);        \
>>>         __err__;                        \
>>>     })
>>> ...
>>> Seems that adeos doesn't not set the unmask function. In the linux kernel
>>> the right functions for my pic in in
>>>     
>> Adeos reuses what Linux provides. In this case, an unmask routine is provided
>> for all the SDMA, external, peripheral and main interrupt sources.
>>
>> Which IRQ are you trying to grab? What does you code look like?
> I wrote 2 rtdm drivers. The first one tries to grab  MPC52xx_GPIO_IRQ (= 12)
> in order to use USB1_9 of MPC5200B has an interrupt pin.
> The second driver is a RTDM SPI driver for PSC3 (full spi mode)
> and PSC6, so i'm trying to grap MPC52xx_PSC3_IRQ (= 42) and 
> MPC52xx_PSC6_IRQ (= 43).
>

Ok, what does /proc/interrupts say?

>>   
>>> arch/powerpc/platforms/52xx/mpc52xx_pic.c
>>> I thing i have to add some code in mpc52xx_pic.c in order to match
>>> device tree table
>>> and also something in my dts file.
>>>     
>> Don't do that. It would be wrong.
>>   
> mmm... some .config mistake? I don't known...
>>  Any help is very usefull!!!
>>   
>>> Thanks
>>>
>>>
>>> --
>>> chicco
>>>
>>> _______________________________________________
>>> Xenomai-help mailing list
>>> Xenomai-help@domain.hid
>>> https://mail.gna.org/listinfo/xenomai-help
>>>
>>>     
>>
>>   
> 
> 
> --
> Dott. Ing. Federico Ridolfo
> COL Giovanni Paolo S.P.A.
> Stabilimento Catania
> Via Luigi Pirandello,Contrada Cugno, 95040 Piano Tavola, BELPASSO (CT)
> tel. +39 095 7133088
> e-mail: federico.ridolfo@domain.hid
> 


-- 
Philippe.

