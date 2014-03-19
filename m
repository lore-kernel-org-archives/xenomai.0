MIME-Version: 1.0
Date: Wed, 19 Mar 2014 14:24:10 -0700
Message-ID: <CADoY7i80BSHm4iu9Mv35mcQ6v=SK2d1fL0qyoDeHoaib+4D8mw@mail.gmail.com>
From: Newell Jensen <newell.jensen@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Xenomai] Device Profile and API questions
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hello,

We are currently evaluating Xenomai's interrupt latency response on the
Freescale imx6dl chip.  I have successfully installed Xenomai several days
ago after posting this question to the mailing list:

http://www.xenomai.org/pipermail/xenomai/2014-March/030336.html

Thanks to Gilles for supplying that information :)

I used the ipipe pre-patched kernel and have a Debian rootfs.  Everything
is working great so far.  I have used latency, klatency and the other tests
and the response so far has been passable for our requirements.  We now
want to write a driver for the EPIT counter to learn how to use Xenomai as
well as see what kind of interrupt latency we can achieve.  If this passes
we can then move on to our ultimate goal.

Our ultimate goal is to have a dedicated hardware interrupt line (pin to
chip) which will handle 125 microsecond interrupts that will initiate
parallel bus reads/writes.

The questions below relate to 'both' the counter irq and the dedicated hard
irq (pin to chip) drivers so if there are different Profiles or APIs that I
should use for each one and vice versa, pointing that out would be greatly
appreciated.  My general questions are listed below.

1. Which Device Profile is best for hard irq interrupt handler?

2. What API is best for hard irq interrupt handler?

I noticed that irqbench.c is using the HAL API for hard irq but RTDM for
other irq and didn't know what to make of that.

Thanks in advance,

Newell
