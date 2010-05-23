Message-ID: <4BF95799.1050508@domain.hid>
Date: Sun, 23 May 2010 18:28:09 +0200
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
References: <AANLkTimhw6cOHeDP3D4Om8nBiT-aURPWxbIrT23hNcNW@mail.gmail.com>		<4BF8F73D.3070008@domain.hid>	<AANLkTikT2AgxYKn4rK1jHtHzcK_AwJBzNANjDtAnyrwt@domain.hid>
	<4BF94DE3.90001@domain.hid>
In-Reply-To: <4BF94DE3.90001@domain.hid>
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

Hello,

some more insights:

On 05/23/2010 05:46 PM, Wolfgang Grandegger wrote:
> On 05/23/2010 04:59 PM, Everett Wang wrote:
>> On Sun, May 23, 2010 at 5:37 PM, Wolfgang Grandegger <wg@domain.hid> wrote:
>>> On 05/23/2010 05:48 AM, Everett Wang wrote:
>>>> Hi All,
>>>>
>>>> I am trying to make my serial work with xenomai. I have managed to
>>>> compile and almost run the cross-link example.
>>>> When I tried to run it, I got a shared library problem:
>>>>
>>>> examples
>>>> ./cross-link
>>>> ./cross-link: error while loading shared libraries: libxenomai.so.0: cannot...
>>>>
>>>> I then added this:
>>>>
>>>> $LD_LIBRARY_PATH=/usr/xenomai/lib
>>>> $export LD_LIBRARY_PATH
>>>>
>>>> Is this the right thing to do?
>>>>
>>>> I tried it again. I got a little further:
>>>>
>>>> root@domain.hid# ./cross-link
>>>> main : can't open rtser0 (write), No such device
>>>>
>>>> I googled a little bit and still can't find a solution. Here is the system I am
>>>> using: Beagleboard C4, xenomai 2.5.3, linux 2.6.33.3, cross-compiler CSL
>>>> 2010Q1. In my kernel configuration, I do have CONFIG_XENO_DRIVERS_16550A
>>>> enabled as a module.
>>>
>>> Is the module loaded. If not, it's no surprise that there is no rtser0
>>> device. Anyway, I'm not sure if Xenomai's 16550A RTserial driver is
>>> fully compatible with OMAPs 8250 devices, especially the proper access
>>> method might not be supported.

I think the serial ports for the beagle boards are configured in:

http://lxr.linux.no/#linux+v2.6.34/arch/arm/mach-omap2/serial.c

Therein you find entries like:

http://lxr.linux.no/#linux+v2.6.34/arch/arm/mach-omap2/serial.c#L82

As you can see, a regshift of 2 is used, which is not yet supported by
the 16550A RTDM driver. Should not be a big deal to add it, though.
Also, as baud_base you should use OMAP24XX_BASE_BAUD.

Wolfgang.

