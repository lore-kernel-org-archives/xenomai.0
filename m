MIME-Version: 1.0
In-Reply-To: <88b82cb6-37ab-5a32-9381-443007580c41@xenomai.org>
References: <CAPdz0-x1Vg2LU-n9BzU4Ozt=AetkZNZYG6fZ849boWSrBgFHFg@mail.gmail.com>
 <88b82cb6-37ab-5a32-9381-443007580c41@xenomai.org>
From: Steve B <sbattazzo@gmail.com>
Date: Tue, 3 Jan 2017 17:08:29 -0800
Message-ID: <CAEMXjGw-BiTWkRC4SZDzzGRqf2gvGuiEnoa0dOX8D3ZT2cNb-w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Xenomai] UART RT-Driver for BBB
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai <xenomai@xenomai.org>
Cc: "Florian G." <florian.r.groeger@gmail.com>

I was able to get this to work, but it was a little bit of a hassle. The
16550A driver as it stands doesn't quite work because the AM335x CPU has
some registers that are not exactly like the standard 16550A.. So a few
lines of code needed to be modified, and I believe there was an issue with
word size when doing register reads/writes that also needed to be addressed.

Lastly, to actually load the driver requires some modification to your
device tree overlays.
I wasn't quite able to get the device tree to bind the final driver in a
clean way like I wanted, so I did a very ugly hack and made a single
overlay to cover two UARTs I was going to use (one with the standard driver
and one RTDM), and made a sacrificial partial entry in the name of a
different UART which is unused in my application. This is important because
it's the mechanism the OS uses to enable power and clocks to the various
peripherals, as well as pinmux. So I set up the overlay somehow to turn the
desired UART on and enable clocks and the correct pinmux settings, and then
did an insmod on the compiled driver to get it running.
It is probably also possible to hack the peripheral/clock/pinmux portion in
to application space with mem mapped I/O, which is also in the ugly hack
department.

I haven't had time to bother with a clean solution.. something "working"
was kind of good enough at the time.


On Fri, Dec 9, 2016 at 3:38 AM, Philippe Gerum <rpm@xenomai.org> wrote:

> On 11/21/2016 01:46 AM, Florian G. wrote:
> > Hey,
> >
> > I'm using Xenomai 2.6.5 on a 3.8.13 kernel on an ARM 32-bit(BeagleBone
> > Black).
> >
> > I have a sensor connected via UART which I have to read in a RT_TASK.
> > Therefore, I need a RT-Driver for that. Sadly I wasn't able to install
> > xenomai's xeno-16550A driver because setserial does not work[1]. So, my
>
> You mean you did not succeed to get the standard driver out of the way?
>
> > first question is:
> > Does an alternative for setserial exist?
>
> PySerial? No idea if that would work on the Beagle though.
>
>  If not, can I get the io, irq,
> > and so on from somewhere else? Maybe I could use the In-Kernel Driver
> > Setup.
>
> I would have a look at the sysfs contents, e.g. /sys/class/tty, locating
> your device instance there. The properties such as the current irq line
> should be available as leaf nodes.
>
> >
> > I saw some discussion about that topic in the mailing list already but I
> > am not sure if the problem was ever resolved.[2] Any hints here would be
> > highly appreciated.
> >
> > So the solutions I have in mind right now are, in case I won't be able to
> > install xeno-16550A are:
> > 1. Reading directly from memory by using mmep
>
> You would have to deal with TX and RX IRQs at the very least
> nevertheless, unless you want to fully operate in polled I/O mode, which
> is unlikely to be nice in terms of overhead. Besides, it could become
> uselessly complex to share the UART between processes.
>
> > 2. Developing my own RTDM.
>
> For which benefit?
> http://www.xenomai.org/pipermail/xenomai/2010-May/020419.html
>
> > (3. Using on of the PRUs)
>
> Even more complex than implementing a driver that already exists I believe.
>
> --
> Philippe.
>
> _______________________________________________
> Xenomai mailing list
> Xenomai@xenomai.org
> https://xenomai.org/mailman/listinfo/xenomai
>
