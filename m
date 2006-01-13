Message-ID: <43C829C5.1060104@domain.hid>
Date: Fri, 13 Jan 2006 23:29:25 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] PCI Framegrabber real-time driver
References: <200601111655.57020.lbocseg@domain.hid>
	<200601131224.55609.lbocseg@domain.hid> <43C80626.6090007@domain.hid>
	<200601131953.46146.lbocseg@domain.hid>
In-Reply-To: <200601131953.46146.lbocseg@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigECD00FFCE70053F3FB1C439F"
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
--------------enigECD00FFCE70053F3FB1C439F
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Rodrigo Rosenfeld Rosas wrote:
>>> How could I
>>> share this memory with userspace RT-programs in a deterministic way?
>> Set up the memory mapping between kernel and user space during (non-rt=
)
>> initialisation. This means that you have to create some mapping from t=
he
>> physical block into the user space address range. I think
>> remap_pfn_range() or io_remap_page_range() should do this after mappin=
g
>> the physical memory into the address space of the kernel (ioremap()).
>> But I suggest LDD3 on this topic as a better reference.
>=20
> Of course. You are right. I will only need this at initialization so I =

> shouldn't bore about that.
>=20
>>> I can't understand why sharing that memory should be so complex...
>> As long as it's static, it's trivial. But as soon as you have to
>> synchronise with potential changes of your process' mm, it starts to
>> cause problems. Again, the concept of setting up the mapping during
>> non-rt init of your driver and then using it in RT context is safe.
>=20
> Right.
>=20
>>> By reading the registers in the PCI board the driver can get the acqu=
ire
>>> status (capturing, finished, etc).
>> ... and single this event by unblocking some potentially waiting user
>> space, which was blocked in some related IOCTL of your driver.
>=20

Bah, once again:

"... and *signal* this event by unblocking some potentially waiting user
space *task*, which was blocked in a related IOCTL of your driver."

> Sorry, I didn't understand this phrase... My ioctl's never block...

In case you want synchronous frame access, you can create an IOCTL that
blocks until the hardware signals the arrival of a new one via an IRQ.
Of course, if you design an asynchronous interface, your IOCTL(s) may
only be used to switch the current buffer.

>=20
>> So, as Jeroen suggested as well, let the user register two or more exc=
hange
>> buffers, set up a shared memory region, and provide in IOCTL interface=

>> to inform the user about updates.
>=20
> Do you mean by using polling or by a more efficient mechanism? I mean, =
how can=20
> I use an IOCTL interface like a condition variable?

By using one of RTDM's services in your driver's IOCTL handler,
typically either a semaphore or an event. See the Xenomai API doc for
details - and have a look at the existing drivers...

>=20
>>> Well, let me explain what my problem is. I'm developing a framework f=
or
>>> developing rt applications for mobile robots. OROCOS seemed too compl=
ex
>>> for
>> Welcome to the club - we are working on the same topic at my institute=
=2E
>=20
> :)
>=20
>>> me... For testing the framework I built a simple robot with an optica=
l
>>> encoder on the weels. I developed an odometry system based on the enc=
oder
>>> sensors that worked well. I would like to write an application that d=
oes
>>> position and speed control by using the images taken by the framegrab=
ber
>>> and compare the result with the odometry system for making a conceptu=
al
>>> proof of my framework for my master-thesis work.
>> Sounds very interesting. Would be interesting to hear, when this works=
,
>> what precision can be achieved with your hardware.
>=20
> I'll let you know when I finish it -- if I finish! ;)

That's just a question of (re-)defining the goal when necessary. :)

Jan


--------------enigECD00FFCE70053F3FB1C439F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFDyCnFniDOoMHTA+kRAqp6AJ0XDb6MrT2UYe77L69Uzy5Q4qh17QCfXt3A
BgREd6U1vWcfQc9FfgTo6Uc=
=mMCl
-----END PGP SIGNATURE-----

--------------enigECD00FFCE70053F3FB1C439F--

