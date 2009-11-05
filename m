Message-ID: <4AF29229.2090205@domain.hid>
Date: Thu, 05 Nov 2009 09:51:53 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <BB99A6BA28709744BF22A68E6D7EB51F03310307D6@domain.hid>	<4AF20D2B.30508@domain.hid>
	<BB99A6BA28709744BF22A68E6D7EB51F033103081D@midas.usurf.usu.edu>
In-Reply-To: <BB99A6BA28709744BF22A68E6D7EB51F033103081D@midas.usurf.usu.edu>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig7C668D3BC42DFBFB999652DD"
Sender: jan.kiszka@domain.hid
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
To: Jonathan Haws <Jonathan.Haws@domain.hid>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig7C668D3BC42DFBFB999652DD
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Jonathan Haws wrote:
>>> I am writing a driver that needs to wake up a user space thread on
>> a
>>> hardware interrupt.  I am reading about the Xenomai APIs
>> semaphores
>>> and want to know if I create a semaphore in my kernel module with
>> a
>>> given name using rt_sem_create, can I call rt_sem_bind in user
>> space
>>> to bind to that same semaphore?
>>>
>>> I am sure hoping the answer is yes!
>> The answer is yes, but...
>> this programming model is deprecated. You should be implementing a
>> driver using the RTDM API, as you would do with Linux.
>=20
> The driver is a really dumb driver - all it really does is setup pointe=
rs to the PCI BARs and installs the interrupt.  I provide an mmap routine=
 to map the BARs to user space so I can control the device from there.
>=20
> Would this still be necessary to use the RTDM API?  I guess to install =
the interrupt, but there really is not anything else the driver does.

Abstraction is the primary job of a driver. Pushing things to user space
quickly blurs the boundaries and ends up in tricky to maintain blob on
the long term.

>=20
> I was also reading the RTDM API and am confused about the rtdm_iomap_to=
_user() function - is that to be called from my user space application an=
d it will then call the mmap routine that I have in place for my driver?

It's part of the function set that a driver can use, not an application.
This function will do all the work required to let some I/O memory show
up in the user space's memory range.

Jan


--------------enig7C668D3BC42DFBFB999652DD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAkrykioACgkQitSsb3rl5xTPdQCdHAjM52mxt1F1MKGC4kK13ibp
pawAnA8QNR+nayl59tfZfx/FIKZFiC6S
=ZdqI
-----END PGP SIGNATURE-----

--------------enig7C668D3BC42DFBFB999652DD--

