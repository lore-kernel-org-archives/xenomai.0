From: Jonathan Haws <Jonathan.Haws@domain.hid>
Date: Thu, 5 Nov 2009 08:16:53 -0700
Message-ID: <BB99A6BA28709744BF22A68E6D7EB51F03310309AA@midas.usurf.usu.edu>
References: <BB99A6BA28709744BF22A68E6D7EB51F03310307D6@domain.hid>
	<4AF20D2B.30508@domain.hid>
	<BB99A6BA28709744BF22A68E6D7EB51F033103081D@midas.usurf.usu.edu>
	<4AF29229.2090205@domain.hid>
In-Reply-To: <4AF29229.2090205@domain.hid>
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
To: "jan.kiszka@domain.hid" <jan.kiszka@domain.hid>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

> >>> I am writing a driver that needs to wake up a user space thread
> on
> >> a
> >>> hardware interrupt.  I am reading about the Xenomai APIs
> >> semaphores
> >>> and want to know if I create a semaphore in my kernel module
> with
> >> a
> >>> given name using rt_sem_create, can I call rt_sem_bind in user
> >> space
> >>> to bind to that same semaphore?
> >>>
> >>> I am sure hoping the answer is yes!
> >> The answer is yes, but...
> >> this programming model is deprecated. You should be implementing
> a
> >> driver using the RTDM API, as you would do with Linux.
> >
> > The driver is a really dumb driver - all it really does is setup
> pointers to the PCI BARs and installs the interrupt.  I provide an
> mmap routine to map the BARs to user space so I can control the
> device from there.
> >
> > Would this still be necessary to use the RTDM API?  I guess to
> install the interrupt, but there really is not anything else the
> driver does.
>=20
> Abstraction is the primary job of a driver. Pushing things to user
> space
> quickly blurs the boundaries and ends up in tricky to maintain blob
> on
> the long term.

That is what I am trying to do, abstract away the details of interfacing wi=
th the hardware, however the user does need to have access to the BARs to b=
e able to configure the device at runtime in an efficient manner.  IOCTL ca=
lls are too slow for our application.  We do not need this driver to be ver=
y portable either - this is custom built hardware specific to our applicati=
on only.

> > I was also reading the RTDM API and am confused about the
> rtdm_iomap_to_user() function - is that to be called from my user
> space application and it will then call the mmap routine that I have
> in place for my driver?
>=20
> It's part of the function set that a driver can use, not an
> application.
> This function will do all the work required to let some I/O memory
> show
> up in the user space's memory range.

So, how would it be used?  Does the driver call this routine with some spec=
ific memory in mind and it returns a user space pointer?  If so, how does t=
hat pointer get passed back to user space?

I think for our application the RTDM driver is not necessary.  Simply synch=
ronizing with a RT_SEM will do the trick for us.

Thanks for all the help!

Jonathan



