Content-Disposition: inline
From: Rodrigo Rosenfeld Rosas <lbocseg@domain.hid>
Date: Wed, 11 Jan 2006 16:55:56 -0200
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Message-Id: <200601111655.57020.lbocseg@domain.hid>
Subject: [Xenomai-help] PCI Framegrabber real-time driver
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

Hi,

I developed a v4l2 driver for my PCI framegrabber and I need to use it in my
real-time applications. I think I need to write a new one with real-time
constrainments. But I'm not sure of which API would be the best one for this
kind of driver.

I know about existence of RTDM, but I'm not sure if it is the best choice...

Let me explain how the driver works. It initializes the board with some PCI
writes on startup. It's passed to the kernel the parameter "mem=3D510M"
reserving 2Mb for use with the framegrabber through DMA access. I need a
continuous physic memory area and I can't get it through kmalloc or similar
functions. I map this memory in my programs in user space. So, I basically
need to write and read from PCI registers in the drive. But I don't know if
it should be better to develop the driver using some existing API or not
because I didn't find any API that applies to framegrabbers like v4l does on
Linux domain...

Please, what do you suggest about the design of my driver?

Thanks,

Rodrigo.

=09

=09
	=09
_______________________________________________________=20
Yahoo! doce lar. Fa=E7a do Yahoo! sua homepage.=20
http://br.yahoo.com/homepageset.html=20



