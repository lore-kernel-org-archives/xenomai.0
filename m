Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
From: Guenter Ebermann <guenter.ebermann@domain.hid>
In-Reply-To: <4C5D0F40.1070104@domain.hid>
Date: Sat, 7 Aug 2010 12:13:34 +0200
Content-Transfer-Encoding: quoted-printable
Message-Id: <1DDE5D7F-58F5-4919-A4B4-5FCAD385E679@domain.hid>
References: <AANLkTi=yDXty82va8JGzmRA453e021EvomyYitaQTCTg@domain.hid>
	<4C5D0F40.1070104@domain.hid>
Subject: Re: [Xenomai-help] migration scenario to xenomai
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

Hi Gilles,

Am 07.08.2010 um 09:46 schrieb Gilles Chanteperdrix:
> You can access hardware registers in user-space by mmaping the memory
> mapped ones with /dev/mem, or using iopl/ioperm and in[lwb]/out[lwb] =
for
> the old x86 I/O registers.

Ok, thank you very much. I will look into using /dev/mem (we dont need =
x86 I/O
- we use powerpc arch).

> However, if this can help for a first order port to Xenomai,
> implementing an RTDM driver later is better on the long run. By =
limiting
> the interface between the application and low-level code to a well
> defined interface, it will make it possible to use different
> applications with the same drivers, or use different hardware with the
> same application at will, things that are often hard when the =
low-level
> code is mixed with the application code.

The xenomai RTDM API is made solely for kernel space, if i understood =
the docs
correctly?

Yeah, I understand your point with generic interface and device driver
separation. And I really like the way this happens under linux/xenomai. =
I am
also willing to write new drivers which are usable by a broader public =
using
these design principles. But the communication stack I am gona use =
(AUTOSAR
FlexRay stack) does not follow them. AUTOSAR (www.autosar.org) specs =
defines
the Interfaces and layers of the whole communcation system for cars. It =
does
not involve kernel/userspace separation, but it also does not mix the =
low-level
code with application code. Low level code is only implemented in the =
device
drivers (CAN, LIN, FlexRay), but the interface to the upper level stack =
is not
generic (as in linux with device drivers) - it is different for each =
kind of
lower layer device (CAN, LIN, FlexRay) to gain the best performance from =
each
of them.

So I will try to keep the AUTOSAR part in a high prio process (deadlines =
to
fill communication buffers in-time must be met) in user space which =
stays in
the xenomai domain.

For all other things I will try to use the linux design philosophy and =
RTDM
drivers.

> And you could even get the drivers you develop merged into Xenomai, if
> you are willing to publish them.

I will do my best to publish drivers which are not our core business and =
which
will be usable by a broader public. E.g. a driver for =
device-PCI-communication,
or other drivers which are missing yet for our target processor. And of =
course
bug-fixes or extensions of existing drivers.

We will like to use the rt-socket-can MSCAN driver from xenomai. I =
already
looked in the source and liked it very much (I maintained, extended and =
fixed
a MSCAN driver for eCos). On top of it I would like to write a small =
AUTOSAR
Can Driver API in userspace to link it with the rest of the stack.=20

BTW. Is anyone of you using Xenomai on Freescale QorIP P2020?
I have seen it mentioned in the supported hardware area on the xenomai
home page.

-Guenter


