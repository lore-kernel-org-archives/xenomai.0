References: <CADXNiGXcYVk8JUDv24_TVLtvRQ=hJaaSiMzwQPct5V92U-jGYw@mail.gmail.com>
 <640d22cb-ac74-6702-8c15-76ace5732262@xenomai.org>
 <CADXNiGW4EB96ovgEqutmYthLS9rk9paHGj0BGQG_dZCmiB2S6Q@mail.gmail.com>
 <CADXNiGW83FQPkVvdsdYzNSjVHmE0pL1YbxuNVpC4bd3uZJBN1g@mail.gmail.com>
 <4d7df01d-e90b-2598-6424-7336732c2be5@xenomai.org>
 <CADXNiGXDwfAtX3f7FpjeSRe0NsJcZi_EW2=+9MZd-93xWBQkJA@mail.gmail.com>
 <CADXNiGXfA0EE3BRKQWmDQa8Ks9rfjL+00PTsXg+1xbz3kiY2Bw@mail.gmail.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <935663fd-24ea-a058-0fbd-f3d07c9efac8@xenomai.org>
Date: Wed, 2 Aug 2017 16:01:13 +0200
MIME-Version: 1.0
In-Reply-To: <CADXNiGXfA0EE3BRKQWmDQa8Ks9rfjL+00PTsXg+1xbz3kiY2Bw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] real-time spi driver for imx6
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jackson Jones <jackson.jones@gmail.com>, xenomai@xenomai.org

On 08/02/2017 04:31 AM, Jackson Jones wrote:
> Philippe,
> 
> I changed the .compatible string in spi-device.c so that it would search
> for "spidev". The module now tries to initialize, but I am getting a null
> pointer somewhere. The kernel stack trace is pasted below. I put a couple
> of printk's in spi_device_probe to try and see where the issue was, but
> none of them printed out.
> 
> Are there any changes you would recommend that I make to the
> imx6ql-var-som.dtsi (it is attached to the previous message). I did not
> make any other changes to any of the xenomai spi files. I have not changed
> my driver file since the initialization has not gotten to it yet.
> 
> I do have one question, should I leave the original spi-imx driver in place
> (the Linux driver), or should it be disabled. I was looking online for
> examples of how people were using the xeno driver for the Raspberry Pi to
> get some sort of idea/example, but I did not find much.
> 

The RTDM-based SPI core (kernel/driver/spi/spi{master, device}.c goes on
top of the regular Linux SPI core. The bus-specific real-time backend
(e.g. kernel/drivers/spi/spi-bcm2835.c) which goes on top of the former
replaces the regular backend. So, you do have to disable the regular
spi-imx driver, so that it does not conflict with the RTDM-based backend
you need to provide. You have to leave the regular SPI core enabled, so
that the RTDM SPI core can stack on top of it.

The logic is as follows:

- the RTDM-based SPI backend is probed for instantiating a SPI
master/controller device (instead of the regular driver you have
disabled) as its compatible string matches the device tree specs for the
bus, which has to turned on there (e.g. "brcm,bcm2835-spi" for RPI
Zero/2/3). The probe() routine must call into rtdm_spi_add_master() at
some point, creating an hybrid RTDM+regular master device object,
standing for the controller.

- at some point, the regular Linux SPI core will enumerate all slave
devices declared in the device tree for each enabled SPI controller it
finds there. Each slave device bearing the "rtdm-spidev" compatible
string will be announced to the spi_device_probe() routine from the
generic RTDM SPI core, since this is the support such driver advertises.
That routine connects the slave device to the RTDM SPI core, which
should trigger the attachment call to the RTDM SPI backend eventually.

- from this point, only the operation handlers defined in struct
rtdm_spi_master_ops for the real-time SPI backend apply for I/O
transactions.

In other words, we leave the complex part of detection, enumeration and
registration of SPI controllers and slaves to the regular kernel,
overriding the I/O operations once this is done to operate in real-time
mode. A general understanding of the logic behind device trees is
required to make sense of the above.

Regarding the crash, you should be able to pinpoint the offending source
line by running the following command, and progress from there:

$ arm-linux-gnueabihf-addr2line -a 7f048f38 -e vmlinux

If the kernel went loopy for some reason, jumping to random places via a
rogue function pointer, the IP value (7f048f38) might not be trusted;
you may want to try looking for the link register value instead (LR:
800aa3f4 in your case). At least this should bring you back to a
sensible caller, hopefully.

> Right now we cannot keep up with the demands of the systems since using the
> Linux SPI driver causes 100s of context switches between real-time and non
> real-time. This slows down the sending and receiving of messages causing
> watchdog faults.

Switching between runtime modes in the work loop is definitely not the
way to go, I can confirm this. So either the regular SPI driver fits the
bill and you should invoke its services from a regular thread or non-rt
Xenomai thread (i.e. SCHED_OTHER / SCHED_WEAK), or it does not and the
RTDM driver is required to control the bus, called from a real-time thread.

-- 
Philippe.

