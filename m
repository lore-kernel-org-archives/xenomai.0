Message-ID: <4BF8F73D.3070008@domain.hid>
Date: Sun, 23 May 2010 11:37:01 +0200
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
References: <AANLkTimhw6cOHeDP3D4Om8nBiT-aURPWxbIrT23hNcNW@mail.gmail.com>
In-Reply-To: <AANLkTimhw6cOHeDP3D4Om8nBiT-aURPWxbIrT23hNcNW@mail.gmail.com>
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

On 05/23/2010 05:48 AM, Everett Wang wrote:
> Hi All,
> 
> I am trying to make my serial work with xenomai. I have managed to
> compile and almost run the cross-link example.
> When I tried to run it, I got a shared library problem:
> 
> examples
> ./cross-link
> ./cross-link: error while loading shared libraries: libxenomai.so.0: cannot...
> 
> I then added this:
> 
> $LD_LIBRARY_PATH=/usr/xenomai/lib
> $export LD_LIBRARY_PATH
> 
> Is this the right thing to do?
> 
> I tried it again. I got a little further:
> 
> root@domain.hid# ./cross-link
> main : can't open rtser0 (write), No such device
> 
> I googled a little bit and still can't find a solution. Here is the system I am
> using: Beagleboard C4, xenomai 2.5.3, linux 2.6.33.3, cross-compiler CSL
> 2010Q1. In my kernel configuration, I do have CONFIG_XENO_DRIVERS_16550A
> enabled as a module.

Is the module loaded. If not, it's no surprise that there is no rtser0
device. Anyway, I'm not sure if Xenomai's 16550A RTserial driver is
fully compatible with OMAPs 8250 devices, especially the proper access
method might not be supported.

> In a 2007 post, I saw  Philippe Gerum suggested to  have "vanilla
> serial support disabled".
> which kernel config is that? CONFIG_SERIAL_CORE? or CONFIG_SERIAL_8250?

This will disable all serial devices including the console. Not sure if
you want that.

> I looked at my /dev/ directory and not found rtser*. It does have
> ttyS0, ttyS1 and ttyS3
> for my normal serial ports. Nothing called rtser in /proc/xenomai/rtdm either
> root@domain.hid# ls
> fildes         open_fildes       rttest-switchtest0
> named_devices  protocol_devices  rttest-timerbench0
> 
> Any suggestions?

Which UART device do you want to use as rtser0? On the PC you can
shutdown the device you want to use for rtserial with:

# setserial /dev/ttyS0 uart none

Not sure if this works on the Beagle board, though. If not, you may need
to disable the UARTs in your board config code. Finally you must load
the module with the proper arguments:

# insmod xeno_16550A.ko mem=0x49020000 irq=74 baud_base=?

That requires XENO_DRIVERS_16550A_MMIO or XENO_DRIVERS_16550A_ANY to be
set. If you are lucky, it might work.

Wolfgang.


