From: Jonathan Haws <Jonathan.Haws@domain.hid>
Date: Wed, 4 Nov 2009 16:34:25 -0700
Message-ID: <BB99A6BA28709744BF22A68E6D7EB51F033103081D@midas.usurf.usu.edu>
References: <BB99A6BA28709744BF22A68E6D7EB51F03310307D6@domain.hid>
	<4AF20D2B.30508@domain.hid>
In-Reply-To: <4AF20D2B.30508@domain.hid>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Sharing Semaphores in Kernel and User Space
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
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

> > I am writing a driver that needs to wake up a user space thread on
> a
> > hardware interrupt.  I am reading about the Xenomai APIs
> semaphores
> > and want to know if I create a semaphore in my kernel module with
> a
> > given name using rt_sem_create, can I call rt_sem_bind in user
> space
> > to bind to that same semaphore?
> >
> > I am sure hoping the answer is yes!
>=20
> The answer is yes, but...
> this programming model is deprecated. You should be implementing a
> driver using the RTDM API, as you would do with Linux.

The driver is a really dumb driver - all it really does is setup pointers t=
o the PCI BARs and installs the interrupt.  I provide an mmap routine to ma=
p the BARs to user space so I can control the device from there.

Would this still be necessary to use the RTDM API?  I guess to install the =
interrupt, but there really is not anything else the driver does.

I was also reading the RTDM API and am confused about the rtdm_iomap_to_use=
r() function - is that to be called from my user space application and it w=
ill then call the mmap routine that I have in place for my driver?

