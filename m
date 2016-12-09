References: <CAPdz0-x1Vg2LU-n9BzU4Ozt=AetkZNZYG6fZ849boWSrBgFHFg@mail.gmail.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <88b82cb6-37ab-5a32-9381-443007580c41@xenomai.org>
Date: Fri, 9 Dec 2016 12:38:46 +0100
MIME-Version: 1.0
In-Reply-To: <CAPdz0-x1Vg2LU-n9BzU4Ozt=AetkZNZYG6fZ849boWSrBgFHFg@mail.gmail.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] UART RT-Driver for BBB
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Florian G." <florian.r.groeger@gmail.com>, xenomai@xenomai.org

On 11/21/2016 01:46 AM, Florian G. wrote:
> Hey,
> 
> I'm using Xenomai 2.6.5 on a 3.8.13 kernel on an ARM 32-bit(BeagleBone
> Black).
> 
> I have a sensor connected via UART which I have to read in a RT_TASK.
> Therefore, I need a RT-Driver for that. Sadly I wasn't able to install
> xenomai's xeno-16550A driver because setserial does not work[1]. So, my

You mean you did not succeed to get the standard driver out of the way?

> first question is:
> Does an alternative for setserial exist?

PySerial? No idea if that would work on the Beagle though.

 If not, can I get the io, irq,
> and so on from somewhere else? Maybe I could use the In-Kernel Driver
> Setup.

I would have a look at the sysfs contents, e.g. /sys/class/tty, locating
your device instance there. The properties such as the current irq line
should be available as leaf nodes.

> 
> I saw some discussion about that topic in the mailing list already but I
> am not sure if the problem was ever resolved.[2] Any hints here would be
> highly appreciated.
> 
> So the solutions I have in mind right now are, in case I won't be able to
> install xeno-16550A are:
> 1. Reading directly from memory by using mmep

You would have to deal with TX and RX IRQs at the very least
nevertheless, unless you want to fully operate in polled I/O mode, which
is unlikely to be nice in terms of overhead. Besides, it could become
uselessly complex to share the UART between processes.

> 2. Developing my own RTDM.

For which benefit?
http://www.xenomai.org/pipermail/xenomai/2010-May/020419.html

> (3. Using on of the PRUs)

Even more complex than implementing a driver that already exists I believe.

-- 
Philippe.

