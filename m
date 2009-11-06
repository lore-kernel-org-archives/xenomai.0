Message-ID: <4AF3DF51.70402@domain.hid>
Date: Fri, 06 Nov 2009 09:33:21 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <BB99A6BA28709744BF22A68E6D7EB51F03310307D6@domain.hid>	<4AF20D2B.30508@domain.hid>
	<BB99A6BA28709744BF22A68E6D7EB51F033103081D@midas.usurf.usu.edu>
	<4AF29229.2090205@domain.hid>
	<BB99A6BA28709744BF22A68E6D7EB51F03310309AA@midas.usurf.usu.edu>
In-Reply-To: <BB99A6BA28709744BF22A68E6D7EB51F03310309AA@midas.usurf.usu.edu>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig4492952CF9C35445E151F38F"
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
--------------enig4492952CF9C35445E151F38F
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Jonathan Haws wrote:
>>>>> I am writing a driver that needs to wake up a user space thread
>> on
>>>> a
>>>>> hardware interrupt.  I am reading about the Xenomai APIs
>>>> semaphores
>>>>> and want to know if I create a semaphore in my kernel module
>> with
>>>> a
>>>>> given name using rt_sem_create, can I call rt_sem_bind in user
>>>> space
>>>>> to bind to that same semaphore?
>>>>>
>>>>> I am sure hoping the answer is yes!
>>>> The answer is yes, but...
>>>> this programming model is deprecated. You should be implementing
>> a
>>>> driver using the RTDM API, as you would do with Linux.
>>> The driver is a really dumb driver - all it really does is setup
>> pointers to the PCI BARs and installs the interrupt.  I provide an
>> mmap routine to map the BARs to user space so I can control the
>> device from there.
>>> Would this still be necessary to use the RTDM API?  I guess to
>> install the interrupt, but there really is not anything else the
>> driver does.
>>
>> Abstraction is the primary job of a driver. Pushing things to user
>> space
>> quickly blurs the boundaries and ends up in tricky to maintain blob
>> on
>> the long term.
>=20
> That is what I am trying to do, abstract away the details of interfacin=
g with the hardware, however the user does need to have access to the BAR=
s to be able to configure the device at runtime in an efficient manner.  =
IOCTL calls are too slow for our application.  We do not need this driver=
 to be very portable either - this is custom built hardware specific to o=
ur application only.

No one says that every transfered byte need to be encapsulated into an
IOCTL. There can be clever device models that only issue driver calls
when the caller needs to wait on an event. Of course, this also depends
on the hardware's capabilities.

>=20
>>> I was also reading the RTDM API and am confused about the
>> rtdm_iomap_to_user() function - is that to be called from my user
>> space application and it will then call the mmap routine that I have
>> in place for my driver?
>>
>> It's part of the function set that a driver can use, not an
>> application.
>> This function will do all the work required to let some I/O memory
>> show
>> up in the user space's memory range.
>=20
> So, how would it be used?  Does the driver call this routine with some =
specific memory in mind and it returns a user space pointer?  If so, how =
does that pointer get passed back to user space?

It's typically in a driver's IOCTL handler that processes a user request
to set up the memory mapping for a specific device. So you pass the
pointer back and forth as an argument to this IOCTL. For details on the
service just look at its doc:

http://www.xenomai.org/documentation/xenomai-2.4/html/api/group__util.htm=
l#gd3cd99bd0049763a4bf4c41edb249785

Jan


--------------enig4492952CF9C35445E151F38F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAkrz31UACgkQitSsb3rl5xQknQCg8CeqJBl566xA65V+iM+oEIiN
FgEAni9ArdFRh3HQ45fjyCuCe0caEGcR
=jSlP
-----END PGP SIGNATURE-----

--------------enig4492952CF9C35445E151F38F--

