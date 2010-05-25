MIME-Version: 1.0
In-Reply-To: <4BFA9F2C.1040808@domain.hid>
References: <AANLkTimhw6cOHeDP3D4Om8nBiT-aURPWxbIrT23hNcNW@mail.gmail.com>
	<4BF8F73D.3070008@domain.hid>
	<AANLkTikT2AgxYKn4rK1jHtHzcK_AwJBzNANjDtAnyrwt@domain.hid>
	<4BF94DE3.90001@domain.hid>
	<AANLkTinUBnuLgLj-k_rPVEPHtgf8gC5ZtTcbgnmspRn7@domain.hid>
	<4BF95796.6030504@domain.hid>
	<AANLkTin9MXTXmDZhZSgalCS4KpurXpAa_5l9xLvHDTY9@domain.hid>
	<AANLkTinW1CDCo0pzSFHS8QwQg6TP3WS8rXGoWC7UDryy@domain.hid>
	<4BFA9F2C.1040808@domain.hid>
Date: Tue, 25 May 2010 21:47:41 +0800
Message-ID: <AANLkTingSXRAZDsNW6VUsDMh9prHKvnk_jV3PjTnSl8s@domain.hid>
From: Everett Wang <everteq@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
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
To: Wolfgang Grandegger <wg@domain.hid>
Cc: xenomai@xenomai.org

On Mon, May 24, 2010 at 11:45 PM, Wolfgang Grandegger <wg@domain.hid> w=
rote:
> On 05/24/2010 09:32 AM, Everett Wang wrote:
>> On Mon, May 24, 2010 at 7:36 AM, Everett Wang <everteq@domain.hid> wrote:
>>> On Mon, May 24, 2010 at 12:28 AM, Wolfgang Grandegger <wg@domain.hid=
m> wrote:
>>>> On 05/23/2010 06:19 PM, Everett Wang wrote:
>>>>> On Sun, May 23, 2010 at 11:46 PM, Wolfgang Grandegger <wg@domain.hid.=
com> wrote:
>>>>
>>>>>> There are other possibilities to interact with Linux, e.g. telnet,
>>>>>> slogin or netcat. But it's always good to have a console.
>>>>>>
>>>>> I guess I need a USB to ethernet for these.
>>>>
>>>> Yes.
>>>>
>>>> ...
>>>>>> All three uarts are occupied by Linux and you cannot use them as
>>>>>> rtserial. First you need to release at least one of them. What Linux
>>>>>> config do you use for your board?
>>>>>
>>>>> I didn't do any configuration. Do you mean to config these during ker=
nel
>>>>> configuration?
>>>>
>>>> Can you show us the .config of your kernel?
>>>>
>>>> Some more insights:
>>>>
>>>> I think the serial ports for the beagle boards are configured in:
>>>>
>>>> http://lxr.linux.no/#linux+v2.6.34/arch/arm/mach-omap2/serial.c
>>>>
>>>> Therein you find entries like:
>>>>
>>>> http://lxr.linux.no/#linux+v2.6.34/arch/arm/mach-omap2/serial.c#L82
>>>>
>>>> As you can see, a regshift of 2 is used, which is not yet supported by
>>>> the 16550A RTDM driver. Should not be a big deal to add it, though.
>>>> Also, as "baud_base" you should use OMAP24XX_BASE_BAUD.
>>>>
>>>> Wolfgang.
>>>>
>>>
>>> Thanks for the suggestions. The .config file is attached. I will look a=
t the
>>> code you pointed to today to study the configuration of the serial port=
.
>>>
>>> Everett
>>>
>>
>> Hi Wolfgang,
>>
>> I looked at the serial.c and function you pointed too. I have can't figu=
re
>> out how to modify it. Could you point me to the right direction to read =
so
>> I can understand and eventually improve the serial for beagleboard? I th=
ought
>> I could limit the kernel to use only one of the uart (console) by
>> changing function
>> =A0__init omap_serial_init(void):
>>
>> =A0void __init omap_serial_init(void)
>> {
>> =A0 =A0 =A0 =A0 int i;
>>
>> // =A0 =A0 =A0 =A0for (i =3D 0; i < ARRAY_SIZE(omap_uart); i++)
>> // =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0omap_serial_init_port(i);
>> =A0 =A0 =A0 omap_serial_init_port(2);
>> }
>>
>> But the kernel hangs during booting after printing this message:
>>
>> uncompressing Linux... done.
>>
>> I guess it is not that simple to let kernel not to claim the uart0 and u=
art1.
>
> Yes, unfortunately. I would try to comment out the uarts you want to
> use for rtser in the following struct:
>
> http://lxr.linux.no/#linux+v2.6.34/arch/arm/mach-omap2/serial.c#L562
>
> Maybe the better option is to download setserial from
>
> http://sourceforge.net/projects/setserial/files/setserial/2.17/setserial-=
2.17.tar.gz/download
>
> and cross-compile it for your target. Then try:
>
> # setserial /dev/ttyS2 uart none
>
> Wolfgang.
>
>

Hi Wolfgang,

Thanks,

I took the easiest way by
opkg install setserial

The setserial got installed into my flash. I then

 # setserial /dev/ttyS0 uart none
Linux has no complain. dmesg | tail doesn't show anything

Finally I did this:
 # setserial /dev/ttyS2 uart none
Linux reports "Can't set serial info: Device or resource busy". The
uart3 is used by console login.
And my console login still works,

I guess I still don't have a clear direction what to do next. What are
needed to make the uart
to work with xenomai? I also want to make SPI to work with xenomai. Is
that even harder to
do?

Everett

