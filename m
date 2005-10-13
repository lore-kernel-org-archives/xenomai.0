Message-ID: <434E7420.5090602@domain.hid>
Date: Thu, 13 Oct 2005 16:50:08 +0200
From: Jan Kiszka <kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Best way to port device driver to RTAI/fusion
References: <434E6F00.9090805@domain.hid>
In-Reply-To: <434E6F00.9090805@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig5C199A9DEF17B9348E4E1657"
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Sean McGranaghan <smm@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig5C199A9DEF17B9348E4E1657
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

Sean McGranaghan wrote:
> Hello all,
> 
> My name is Sean McGranaghan, I am a software engineer working in
> Rochester, NY. USA. I have recently been tasked with porting a standard
> Linux driver to the RTAI/fusion environment. I have RTAI/fusion 0.8.3 up
> and running with a 2.6.13 kernel. I have a couple general questions,
> followed by my specific problem. I apologize for the length of this post
> in advance, this is my first foray into RTAI/fusion. Please direct this
> message as appropriate.
> 
> When a realtime RTAI native or LXRT task performs io using a vanilla
> Linux driver, does it retain its realtime scheduling priority via the
> nucleaus scheduler or is the task demoted to the non-realtime domain
> i.e. the Linux scheduler? Assume the vanilla Linux driver uses
> wake_up_interruptible() to wake Linux tasks.
> 
> Is there a standard approach to making a driver "realtime"? I would
> assume replacing the interrupt handling, synchronization and task
> scheduling calls with RTAI/fusion equivalents would be the approach to
> take. How does this affect the file operations interface in Linux?
> (open(), close(), read(), write(), ioctl() etc.) Is this driver still
> usable by non-realtime Linux tasks?

Short answer: real-time drivers are for real-time tasks and
non-real-time driver for non-real-time tasks. Don't mix them up, because
both domains use different schedulers.

Anyway, the step from a non-real-time to a real-time task is rather low
under Xenomai. You can easily create applications that have both RT and
non-RT threads included. And switching a RT-thread for a certain time to
non-RT is also possible. Of course, this can cause deadline misses if
your application is not prepared for this unpredictably long switch-back
to Linux.

> 
> My specific problem is to make an existing Linux driver "realtime".
> (Vague requirement I know.) The driver is for an ISA CAN bus card. The
> card contains two CAN controllers using two irqs. My first step was to
> try and get the irq handling under nucleus control. I replaced
> request_irq() and related Linux irq calls with rt_intr_create() and
> such. I was then going to look at replacing the Linux
> spin_lock_irqsave()/spin_unlock_irqrestore() and wake_interruptble()
> calls if needed. I am currently having problems with the first step.

In any case, you should have a look at the services the RTDM layer
(skin) of fusion-0.9 or later provides
(http://download.gna.org/xenomai/documentation/html/api). It's intended
for driver development and should offer you all real-time replacements
for services your driver requires. What is does not offer
(IO-memory/register or PCI registration) can be taken from Linux as usual.

Note that you don't have to register an RTDM device with the core to use
those services. This can be a second step, depending on the requirements
on the API you have to deliver. RTDM provides a POSIX API to the user:
I/O (read/write/ioctl) or sockets.

It might be interesing for you that we are currently preparing a new,
generic, socket-based API for direkt CAN access. First target will be an
SJA1000 adapter, but the mid-term goal is to have a framework for
various cards - all addressable via the same API. Request more
information if you like to.

> 
> I test the driver with a loopback cable between the two channels. In the
> pure Linux driver I send and receive datagrams with no problem. I
> receive a transmit complete interrupt immediatly followed by a message
> received interrupt for each datagram sent. When I replace the interrupt
> handling with RTAI/fusion calls I seem to be missing the receive
> interrupt. I have looked at the CAN controller register contents and
> they are consistant between the vanilla driver and realtime driver. I am
> currently trying to look at the 8259 PIC controller register contents to
> see how the interrupt handling differs. I suspect that the mixing of
> nucleaus interrupt handling and Linux spin locks (irq save/restore) is
> fouling up the PIC, but I can't prove this yet. Is there any benefit to
> moving the interrupt handling to the realtime domain?

Simple rule: if your driver provides services for real-time tasks, it
has to use real-time services of the underlying system as well.
Especially synchronisation and IRQ handling does not like a mix-up! Take
a look at the RTDM API to see which services can be invoked from which
contexts.

Jan

--------------enig5C199A9DEF17B9348E4E1657
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFDTnQgncNeS9Q0k+IRAu1aAKC7urCynQZKlwTkBVfYEiUhPbSuRgCgvdIw
wTNz1WwSahyBoYD0jxMVJ9A=
=WWyn
-----END PGP SIGNATURE-----

--------------enig5C199A9DEF17B9348E4E1657--

