MIME-Version: 1.0
In-Reply-To: <4BF94DE3.90001@domain.hid>
References: <AANLkTimhw6cOHeDP3D4Om8nBiT-aURPWxbIrT23hNcNW@mail.gmail.com>
	<4BF8F73D.3070008@domain.hid>
	<AANLkTikT2AgxYKn4rK1jHtHzcK_AwJBzNANjDtAnyrwt@domain.hid>
	<4BF94DE3.90001@domain.hid>
Date: Mon, 24 May 2010 00:19:56 +0800
Message-ID: <AANLkTinUBnuLgLj-k_rPVEPHtgf8gC5ZtTcbgnmspRn7@domain.hid>
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

On Sun, May 23, 2010 at 11:46 PM, Wolfgang Grandegger <wg@domain.hid> w=
rote:
> On 05/23/2010 04:59 PM, Everett Wang wrote:
>> On Sun, May 23, 2010 at 5:37 PM, Wolfgang Grandegger <wg@domain.hid>=
 wrote:
>>> On 05/23/2010 05:48 AM, Everett Wang wrote:
>>>> Hi All,
>>>>
>>>> I am trying to make my serial work with xenomai. I have managed to
>>>> compile and almost run the cross-link example.
>>>> When I tried to run it, I got a shared library problem:
>>>>
>>>> examples
>>>> ./cross-link
>>>> ./cross-link: error while loading shared libraries: libxenomai.so.0: c=
annot...
>>>>
>>>> I then added this:
>>>>
>>>> $LD_LIBRARY_PATH=3D/usr/xenomai/lib
>>>> $export LD_LIBRARY_PATH
>>>>
>>>> Is this the right thing to do?
>>>>
>>>> I tried it again. I got a little further:
>>>>
>>>> root@domain.hid# ./cross-=
link
>>>> main : can't open rtser0 (write), No such device
>>>>
>>>> I googled a little bit and still can't find a solution. Here is the sy=
stem I am
>>>> using: Beagleboard C4, xenomai 2.5.3, linux 2.6.33.3, cross-compiler C=
SL
>>>> 2010Q1. In my kernel configuration, I do have CONFIG_XENO_DRIVERS_1655=
0A
>>>> enabled as a module.
>>>
>>> Is the module loaded. If not, it's no surprise that there is no rtser0
>>> device. Anyway, I'm not sure if Xenomai's 16550A RTserial driver is
>>> fully compatible with OMAPs 8250 devices, especially the proper access
>>> method might not be supported.
>>
>> I checked with lsmod. No modules are loaded.
>>
>>>
>>>> In a 2007 post, I saw =A0Philippe Gerum suggested to =A0have "vanilla
>>>> serial support disabled".
>>>> which kernel config is that? CONFIG_SERIAL_CORE? or CONFIG_SERIAL_8250=
?
>>>
>>> This will disable all serial devices including the console. Not sure if
>>> you want that.
>>
>> That is right. Currently with a vanilla kernel and xenomai patch, my DVI=
 display
>> and USB keyboard, mouse do not function. So uart3 is the only way to int=
eract
>> with the beagleboard.
>
> There are other possibilities to interact with Linux, e.g. telnet,
> slogin or netcat. But it's always good to have a console.
>
I guess I need a USB to ethernet for these.

>>>> I looked at my /dev/ directory and not found rtser*. It does have
>>>> ttyS0, ttyS1 and ttyS3
>>>> for my normal serial ports. Nothing called rtser in /proc/xenomai/rtdm=
 either
>>>> root@domain.hid# ls
>>>> fildes =A0 =A0 =A0 =A0 open_fildes =A0 =A0 =A0 rttest-switchtest0
>>>> named_devices =A0protocol_devices =A0rttest-timerbench0
>>>>
>>>> Any suggestions?
>>>
>>> Which UART device do you want to use as rtser0? On the PC you can
>>> shutdown the device you want to use for rtserial with:
>>>
>>> # setserial /dev/ttyS0 uart none
>>>
>>> Not sure if this works on the Beagle board, though. If not, you may nee=
d
>>> to disable the UARTs in your board config code. Finally you must load
>>> the module with the proper arguments:
>>>
>>> # insmod xeno_16550A.ko mem=3D0x49020000 irq=3D74 baud_base=3D?
>>>
>>> That requires XENO_DRIVERS_16550A_MMIO or XENO_DRIVERS_16550A_ANY to be
>>> set. If you are lucky, it might work.
>>>
>>> Wolfgang.
>>>
>> I am trying to use uart1 and uart2 (uart3 is for the console) for cross-=
link.
>>
>> These lines are from my dmesg output:
>>
>> Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
>> serial8250.0: ttyS0 at MMIO 0x4806a000 (irq =3D 72) is a ST16654
>> serial8250.1: ttyS1 at MMIO 0x4806c000 (irq =3D 73) is a ST16654
>> serial8250.2: ttyS2 at MMIO 0x49020000 (irq =3D 74) is a ST16654
>> console [ttyS2] enabled
>
> All three uarts are occupied by Linux and you cannot use them as
> rtserial. First you need to release at least one of them. What Linux
> config do you use for your board?

I didn't do any configuration. Do you mean to config these during kernel
configuration?

>> I can see that I have xeno_16550A.ko in
>> /lib/modules/2.6.33.3/kernel/drivers/xenomai/serial. But I forgot if I
>> have set XENO_DRIVERS_16550A_MMIO or XENO_DRIVERS_16550A_ANY during
>> xenomai configuration. How to check
>> these configuration? I can't find a .config file like linux kernel.
>> The config.log
>> doesn't contain these.
>
> It should be in the kernels .config!

You are right. I found them in my .config for the kernel. I will enable the=
m
and recompile the kernel and xenomai.

>> When I tried to load the driver by:
>>
>> root@domain.hid:~# =A0insmod xeno_16550A.ko mem=3D0x4806a000 irq=3D72 b=
aud_base=3D19200
>> sh: insmod: not found
>> root@domain.hid:~#
>
> Hm, maybe modprobe is present. Might be a busybox config issue.

modeprobe doesn't exist either. I will try to ask Angstrom mailing list for
these.

> Wolfgang.
>

Everett

