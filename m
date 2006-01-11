Message-ID: <43C56124.4040407@domain.hid>
Date: Wed, 11 Jan 2006 20:48:52 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] PCI Framegrabber real-time driver
References: <200601111655.57020.lbocseg@domain.hid>
In-Reply-To: <200601111655.57020.lbocseg@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig73B800D19322A385DE4570BC"
Sender: jan.kiszka@domain.hid
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Rodrigo Rosenfeld Rosas <lbocseg@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig73B800D19322A385DE4570BC
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Rodrigo Rosenfeld Rosas wrote:
> Hi,
> 
> I developed a v4l2 driver for my PCI framegrabber and I need to use it in my
> real-time applications. I think I need to write a new one with real-time
> constrainments. But I'm not sure of which API would be the best one for this
> kind of driver.
> 
> I know about existence of RTDM, but I'm not sure if it is the best choice...
> 
> Let me explain how the driver works. It initializes the board with some PCI
> writes on startup. It's passed to the kernel the parameter "mem=510M"
> reserving 2Mb for use with the framegrabber through DMA access. I need a

I guess "510M" does not stand for 510 MB... ;)

> continuous physic memory area and I can't get it through kmalloc or similar
> functions. I map this memory in my programs in user space. So, I basically
> need to write and read from PCI registers in the drive. But I don't know if
> it should be better to develop the driver using some existing API or not
> because I didn't find any API that applies to framegrabbers like v4l does on
> Linux domain...

There is no such thing like video4RTDM (yet), that's true.

> 
> Please, what do you suggest about the design of my driver?
> 

Well, if you already have a working driver for standard Linux, I would
suggest the following:

Split up your driver in the (non-real-time) initialisation work where
you may use all the useful driver APIs Linux provides you (BTW, how do
you obtain this continuous memory block?) and a (real-time) runtime part
where only RTDM functions can be used.

Then register a RTDM device, likely some misc device with a nice unique
name and an instance number postfix, and with open, close, and ioctl
handlers. The init stuff, or parts of it, would be moved to the open_nrt
(note the "_nrt") handler, cleanup to close_nrt. Likely the parameters
that can be passed via rt_dev_open (or plain "open" in the posix skin)
are not sufficient to configure your device instance. E.g. you may want
to pass up or down some userspace buffer addresses. Therefore, register
an ioctl_nrt handler which deals with specific setup-IOCTLs. On the
other hand, all the synchronisation, buffer flipping, etc. you need to
perform during runtime from your hard-real-time task has to be
implemented in an ioctl_rt (note: "_rt") handler.

As there is no magic involved in the rt-part of RTDM - all
synchronisation mechanisms are standard -, porting the existing semantic
of your driver over the RTDM API should cause no real problem. But I
don't know your driver design and its usage, so feel free to point out
potential issues you see.

If you like to have a look at a rather simple reference code with all
the described features included (just without direct hardware acesss),
check out ksrc/drivers/benchmark/ in the latest Xenomai SVN.

And if you think the final API design for your framegrabbing hardware
looks common enough to cover other framegrabbing hardware as well, you
are warmly welcome to post the concept so that we can discuss making
this THE real-time framegrabbing device profile (officially reserving an
RTDM ID and name, including the API header in the Xenomai code base,
etc.). That could mean your application suddenly becomes portable over
other hardware - something like video4RTDM...

Jan

--------------enig73B800D19322A385DE4570BC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFDxWEpniDOoMHTA+kRAoB7AJ0W9gGrUTq2CxCb9xmDdEGujwOt1ACeNlou
2TsP6EjgdCQSd3bpP/lpR50=
=aVBE
-----END PGP SIGNATURE-----

--------------enig73B800D19322A385DE4570BC--

