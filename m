Message-ID: <497998EA.3010501@domain.hid>
Date: Fri, 23 Jan 2009 11:16:10 +0100
From: Federico Ridolfo <federico.ridolfo@domain.hid>
MIME-Version: 1.0
References: <4979727E.6060304@domain.hid> <49798544.4050808@domain.hid>
	<49798994.1010903@domain.hid> <49799256.6000009@domain.hid>
In-Reply-To: <49799256.6000009@domain.hid>
Content-Type: text/plain; charset=windows-1251
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] PowerPC irq unmask
Reply-To: federico.ridolfo@domain.hid
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: rpm@xenomai.org
Cc: xenomai@xenomai.org

Philippe Gerum wrote:
> Federico Ridolfo wrote:
>   
>> Philippe Gerum wrote:
>>     
>>> Federico Ridolfo wrote:
>>>   
>>>       
>>>> Hi all,
>>>> my platform is a mpc5200b based one. I wrote
>>>> some rtdm driver for that platform on linux-2.6.18
>>>> kernel. Some info:
>>>> - ARCH=ppc
>>>> - no fdt (so no dts)
>>>> - u-boot
>>>> - xenomai 2.3.2,
>>>> - adeos-ipipe-2.6.18-ppc-1.5-01.patch
>>>> All works fine.
>>>>
>>>> Now i want to use:
>>>> - ARCH = powerpc
>>>> - linux kernel from denx: ipipe-2.6-26-powerpc-2.4-03
>>>> - fdt (so i have a dts file)
>>>> - xenomai-2.4.6.1
>>>> - u-boot
>>>> Ok. My board boots, all peripheral s work. Xenomai works, but
>>>> my rtdm drivers don't work. The problem is that the rtdm_irq_request
>>>> returns -ENODEV coming from line 166 in wrappers.h:
>>>> ...
>>>> #else /* > 2.6.19 */
>>>> #define rthal_irq_chip_enable(irq)                    \
>>>>     ({                                \
>>>>         int __err__ = 0;                    \
>>>>         if (unlikely(rthal_irq_handlerp(irq)->unmask == NULL))    \
>>>>             __err__ = -ENODEV;     \
>>>>         else                            \
>>>>             rthal_irq_handlerp(irq)->unmask(irq);        \
>>>>         __err__;                        \
>>>>     })
>>>> ...
>>>> Seems that adeos doesn't not set the unmask function. In the linux kernel
>>>> the right functions for my pic in in
>>>>     
>>>>         
>>> Adeos reuses what Linux provides. In this case, an unmask routine is provided
>>> for all the SDMA, external, peripheral and main interrupt sources.
>>>
>>> Which IRQ are you trying to grab? What does you code look like?
>>>       
>> I wrote 2 rtdm drivers. The first one tries to grab  MPC52xx_GPIO_IRQ (= 12)
>> in order to use USB1_9 of MPC5200B has an interrupt pin.
>> The second driver is a RTDM SPI driver for PSC3 (full spi mode)
>> and PSC6, so i'm trying to grap MPC52xx_PSC3_IRQ (= 42) and 
>> MPC52xx_PSC6_IRQ (= 43).
>>
>>     
>
> Ok, what does /proc/interrupts say?
>
>   
on 2.6.18 (works fine):
~ # cat /proc/interrupts
CPU0
22: 245 MPC52xx Level mpc52xx-fec_rx
23: 101 MPC52xx Level mpc52xx-fec_tx
40: 292 MPC52xx Level mpc52xx_psc_uart
44: 7 MPC52xx Level mpc52xx-fec_ctrl
46: 431 MPC52xx Level ide0
54: 0 MPC52xx Level i2c-mpc
55: 38 MPC52xx Level i2c-mpc
BAD: 0

Instead in 2.6.26:
~ # cat /proc/interrupts
CPU0
129: 1201427 MPC52xx Peripherals Edge mpc52xx_psc_uart
135: 15252 MPC52xx Peripherals Edge mpc52xx_ata
143: 0 MPC52xx Peripherals Edge i2c-mpc
144: 36 MPC52xx Peripherals Edge i2c-mpc
BAD: 0


>>>   
>>>       
>>>> arch/powerpc/platforms/52xx/mpc52xx_pic.c
>>>> I thing i have to add some code in mpc52xx_pic.c in order to match
>>>> device tree table
>>>> and also something in my dts file.
>>>>     
>>>>         
>>> Don't do that. It would be wrong.
>>>   
>>>       
>> mmm... some .config mistake? I don't known...
>>     
>>>  Any help is very usefull!!!
>>>   
>>>       
>>>> Thanks
>>>>
>>>>
>>>> --
>>>> chicco
>>>>
>>>> _______________________________________________
>>>> Xenomai-help mailing list
>>>> Xenomai-help@domain.hid
>>>> https://mail.gna.org/listinfo/xenomai-help
>>>>
>>>>     
>>>>         
>>>   
>>>       
>> --
>> Dott. Ing. Federico Ridolfo
>> COL Giovanni Paolo S.P.A.
>> Stabilimento Catania
>> Via Luigi Pirandello,Contrada Cugno, 95040 Piano Tavola, BELPASSO (CT)
>> tel. +39 095 7133088
>> e-mail: federico.ridolfo@domain.hid
>>
>>     
>
>
>   


--
Dott. Ing. Federico Ridolfo
COL Giovanni Paolo S.P.A.
Stabilimento Catania
Via Luigi Pirandello,Contrada Cugno, 95040 Piano Tavola, BELPASSO (CT)
tel. +39 095 7133088
e-mail: federico.ridolfo@domain.hid

-- 
AVVERTENZE AI SENSI DEL D.LGS. 196/2003

Le informazioni contenute in questo messaggio di posta elettronica e negli eventuali files allegati, sono da considerarsi strettamente riservate. Il loro utilizzo e` consentito esclusivamente al destinatario del messaggio, per le finalita` indicate nel messaggio stesso. Qualora riceveste per errore questo messaggio, Vi preghiamo cortesemente di darcene notizia all'indirizzo e-mail di cui sopra e di procedere alla distruzione del messaggio stesso, cancellandolo dal Vostro sistema; costituisce comportamento contrario ai principi dettati dal D.lgs. 196/2003 il trattenere il messaggio stesso, divulgarlo anche in parte, distribuirlo ad altri soggetti, copiarlo, od utilizzarlo per finalita` diverse.
Ogni dato previsto e trattato dal D.lgs. 196/2003, eventualmente presente nell'e-mail e` trattato nel rispetto della legge.

This e-mail is confidential and may also contain privileged information. If you are not the intended recipient you are not authorised to read, print, save, process or disclose this message.
If you have received this message by mistake, please inform the sender immediately and delete this e-mail, its attachments and any copies.
Any use, distribution, reproduction or disclosure by any person other than the intended recipient is strictly forbidden and the person responsible may incur penalties (D.lgs. 196/2003 Italian law).
Every information treated by D.lgs. 196/2003 Italian law, eventually present in this e-mail are treated in the respect of the law. 


