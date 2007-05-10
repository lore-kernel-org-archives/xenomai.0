From: "Jonas Witt" <Jonas@domain.hid>
Date: Thu, 10 May 2007 16:56:33 +0200
Message-ID: <004601c79313$66ab9110$c67ba8c0@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <4643442B.8080600@domain.hid>
Subject: Re: [Xenomai-help] Serial Port Driver (rtser):
	NoRTSER_RTIOC_WAIT_EVENT
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: 'Jan Kiszka' <jan.kiszka@domain.hid>
Cc: xenomai@xenomai.org


Jonas Witt wrote:
> > Hi everybody,
> >=20
> > =20
> >=20
> > i am having a problem with the serial port driver in xenomai for a =
while
> > now..
> >=20
> > =20
> >=20
> > I have tried different programs like
> > http://www.captain.at/xenomai-serial-port-example.php
> >=20
> > =20
> >=20
> > I have also changed the code of cross-link.c to use the same port =
for
> > writing and reading (as i only have one serial port in my computer).
Opening
> > a port and writing the configuration seems to work form e.. also
writing.
> > The Problem stems from the call to:
> >=20
> > =20
> >=20
> > rt_dev_ioctl(read_fd, RTSER_RTIOC_WAIT_EVENT, &rx_event);
> >=20
> > =20
> >=20
> > which keeps waiting forever and never receives an interrupt. I tried =
a
> > self-made loopback-adapter and a sensor with a serial interface (so =
at >
least
> > _something_ should come back). Nothing worked. The serial port is
working
> > fine with the linux-driver, though. I already figured that the calls =
to
> > rt_dev_write do not work from non-xenomai-tasks (which should really =
be
> > emphasized in the documentation..)
> >=20
>
> Some suggestions:
>
>  o check the hardware configuration (ie. the module parameters of
>    xeno_16550A) twice, you can easily get them wrong
>
>  o check /proc/xenomai/irq for any progress on transmission as well as
>    on reception. If there is nothing happen on tx, the IRQ number may =
be
>    wrong, if there is nothing on rx, your port configuration might be
>    broken.
>
>  o try the driver from trunk, it can handle PnP-related issues =
(hardware
>    gets powered off when Linux driver is removed)
>
> Jan

Thanks for the fast reply!

I am using the following kernel parameters:

kernel		/boot/vmlinuz-2.6.19-ipipe root=3D/dev/sda1 ro 8250.nr_uarts=3D0
xeno_16550A.ioaddr=3D0x3f8 xeno_16550A.irq=3D4

I got these settings from setserial prior to disabling the =
kernel-driver. To
be honest i don't know how to 'check' /proc/xenomai/irq for progress. I =
took
a look at the folder prior to and while running my modified =
cross-link-code
but irq is an empty file in both cases. Is there some special =
trick/function
to handle the files in the proc-folder?

To the last point.. so there is an updated version of the driver =
available?
I think i will try that one.. is it just a question of executing 'make' =
and
modprobing or are there more actions involved?

Best regards,
Jonas




