Message-ID: <4BFE2072.2090404@domain.hid>
Date: Thu, 27 May 2010 09:34:10 +0200
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
References: <AANLkTimhw6cOHeDP3D4Om8nBiT-aURPWxbIrT23hNcNW@mail.gmail.com>	<4BF8F73D.3070008@domain.hid>	<AANLkTikT2AgxYKn4rK1jHtHzcK_AwJBzNANjDtAnyrwt@domain.hid>	<4BF94DE3.90001@domain.hid>	<AANLkTinUBnuLgLj-k_rPVEPHtgf8gC5ZtTcbgnmspRn7@domain.hid>	<4BF95796.6030504@domain.hid>	<AANLkTin9MXTXmDZhZSgalCS4KpurXpAa_5l9xLvHDTY9@domain.hid>	<AANLkTinW1CDCo0pzSFHS8QwQg6TP3WS8rXGoWC7UDryy@domain.hid>	<4BFA9F2C.1040808@domain.hid>	<AANLkTingSXRAZDsNW6VUsDMh9prHKvnk_jV3PjTnSl8s@domain.hid>	<4BFCB3E8.4040607@domain.hid>
	<AANLkTin1Oq15DI0FctW77a7y1mBdY8Aq87sgCEJ013wj@domain.hid>
In-Reply-To: <AANLkTin1Oq15DI0FctW77a7y1mBdY8Aq87sgCEJ013wj@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] problem with serial example
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Everett Wang <everteq@domain.hid>
Cc: xenomai@xenomai.org

On 05/27/2010 03:22 AM, Everett Wang wrote:
> On Wed, May 26, 2010 at 1:38 PM, Wolfgang Grandegger <wg@domain.hid> wrote:
>> On 05/25/2010 03:47 PM, Everett Wang wrote:
>>> On Mon, May 24, 2010 at 11:45 PM, Wolfgang Grandegger <wg@domain.hid> wrote:
>>>> On 05/24/2010 09:32 AM, Everett Wang wrote:
>>>>> On Mon, May 24, 2010 at 7:36 AM, Everett Wang <everteq@domain.hid> wrote:
>>>>>> On Mon, May 24, 2010 at 12:28 AM, Wolfgang Grandegger <wg@domain.hid> wrote:
>>>>>>> On 05/23/2010 06:19 PM, Everett Wang wrote:
>>>>>>>> On Sun, May 23, 2010 at 11:46 PM, Wolfgang Grandegger <wg@domain.hid> wrote:
>>>>>>>
>>>>>>>>> There are other possibilities to interact with Linux, e.g. telnet,
>>>>>>>>> slogin or netcat. But it's always good to have a console.
>>>>>>>>>
>>>>>>>> I guess I need a USB to ethernet for these.
>>>>>>>
>>>>>>> Yes.
>>>>>>>
>>>>>>> ...
>>>>>>>>> All three uarts are occupied by Linux and you cannot use them as
>>>>>>>>> rtserial. First you need to release at least one of them. What Linux
>>>>>>>>> config do you use for your board?
>>>>>>>>
>>>>>>>> I didn't do any configuration. Do you mean to config these during kernel
>>>>>>>> configuration?
>>>>>>>
>>>>>>> Can you show us the .config of your kernel?
>>>>>>>
>>>>>>> Some more insights:
>>>>>>>
>>>>>>> I think the serial ports for the beagle boards are configured in:
>>>>>>>
>>>>>>> http://lxr.linux.no/#linux+v2.6.34/arch/arm/mach-omap2/serial.c
>>>>>>>
>>>>>>> Therein you find entries like:
>>>>>>>
>>>>>>> http://lxr.linux.no/#linux+v2.6.34/arch/arm/mach-omap2/serial.c#L82
>>>>>>>
>>>>>>> As you can see, a regshift of 2 is used, which is not yet supported by
>>>>>>> the 16550A RTDM driver. Should not be a big deal to add it, though.
>>>>>>> Also, as "baud_base" you should use OMAP24XX_BASE_BAUD.
>>>>>>>
>>>>>>> Wolfgang.
>>>>>>>
>>>>>>
>>>>>> Thanks for the suggestions. The .config file is attached. I will look at the
>>>>>> code you pointed to today to study the configuration of the serial port.
>>>>>>
>>>>>> Everett
>>>>>>
>>>>>
>>>>> Hi Wolfgang,
>>>>>
>>>>> I looked at the serial.c and function you pointed too. I have can't figure
>>>>> out how to modify it. Could you point me to the right direction to read so
>>>>> I can understand and eventually improve the serial for beagleboard? I thought
>>>>> I could limit the kernel to use only one of the uart (console) by
>>>>> changing function
>>>>>  __init omap_serial_init(void):
>>>>>
>>>>>  void __init omap_serial_init(void)
>>>>> {
>>>>>         int i;
>>>>>
>>>>> //        for (i = 0; i < ARRAY_SIZE(omap_uart); i++)
>>>>> //                omap_serial_init_port(i);
>>>>>       omap_serial_init_port(2);
>>>>> }
>>>>>
>>>>> But the kernel hangs during booting after printing this message:
>>>>>
>>>>> uncompressing Linux... done.
>>>>>
>>>>> I guess it is not that simple to let kernel not to claim the uart0 and uart1.
>>>>
>>>> Yes, unfortunately. I would try to comment out the uarts you want to
>>>> use for rtser in the following struct:
>>>>
>>>> http://lxr.linux.no/#linux+v2.6.34/arch/arm/mach-omap2/serial.c#L562
>>>>
>>>> Maybe the better option is to download setserial from
>>>>
>>>> http://sourceforge.net/projects/setserial/files/setserial/2.17/setserial-2.17.tar.gz/download
>>>>
>>>> and cross-compile it for your target. Then try:
>>>>
>>>> # setserial /dev/ttyS2 uart none
>>>>
>>>> Wolfgang.
>>>>
>>>>
>>>
>>> Hi Wolfgang,
>>>
>>> Thanks,
>>>
>>> I took the easiest way by
>>> opkg install setserial
>>>
>>> The setserial got installed into my flash. I then
>>>
>>>  # setserial /dev/ttyS0 uart none
>>> Linux has no complain. dmesg | tail doesn't show anything
>>>
>>> Finally I did this:
>>>  # setserial /dev/ttyS2 uart none
>>> Linux reports "Can't set serial info: Device or resource busy". The
>>> uart3 is used by console login.
>>> And my console login still works,
>>>
>>> I guess I still don't have a clear direction what to do next. What are
>>> needed to make the uart
>>> to work with xenomai? I also want to make SPI to work with xenomai. Is
>>> that even harder to
>>> do?
>>
>> Next I would try to load the xeno_16550a.ko as described earlier. Then
>> you need to fix the register access by introducing a proper regshift, at
>> least. I can't tell if other fixups are necessary but if you are lucky
>> it will already work. And yes, implementing a RTDM SPI driver is even
>> harder, unfortunately.
>>
>> Wolfgang.
>>
> 
> Hi Wolfgang,
> 
> Thanks for your information. I am still interested in doing work on both
> xeno_16550a.ko and RTDM SPI. Could you give me an overview of
> what kind of knowledge is required, and where I can find more information
> about them? Right now I feel I don't have a clear understanding to
> modify the code.

I already explained what I would do to get the xeno_16550a.ko working on
your hardware (see above). Concerning a RTDM SPI driver, there has been
some discussion on this topic recently. You can find further information
in t he following thread (see also follow-up mail):

https://mail.gna.org/public/xenomai-help/2010-04/msg00084.html

The doc for the RTDM driver interface is here:

http://www.xenomai.org/documentation/trunk/html/api/index.html

Wolfgang.

