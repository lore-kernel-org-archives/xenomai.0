Message-ID: <4469CB20.9030909@domain.hid>
Date: Tue, 16 May 2006 14:52:48 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] CPU load over 90%[Scanned]
References: <AD78122AD7C05B4B936EBAD7F49738C0AB2B3D@square.bfh.ch>
	<44686D9B.2010509@domain.hid> <4469C85C.7060900@domain.hid>
In-Reply-To: <4469C85C.7060900@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig6EE5A9941CDEF933D433C0D2"
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
To: Nathan Lauener <nathan.lauener@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig6EE5A9941CDEF933D433C0D2
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Nathan Lauener wrote:
> Jan Kiszka wrote:
>=20
>> Lauener Nathan wrote:
>> =20
>>
>>> Hi, I am using Xenomai to read data from different sensors in real
>>> time from
>>> user space. So far I am reading position data from a device attached =
to
>>> a serial port. The CPU load is at about 1%. I also have a
>>> microcontroller attached via USB to read encoder data. The USB device=
 is
>>> a USB-to-serial converter. As soon as I open the (USB-)serial port wi=
th
>>> normal systemcalls and read the incoming data my CPU load skyrockets =
to
>>> over 90%. I only read about 30 bytes every 100ms.
>>> I ran the application on a much newer computer also to rule out any
>>> buggy hardware. The results stayed the same. Intensively searching th=
e
>>> mailing list and provided documentation have not helped solve the
>>> problem. I'm using Xenomai 2.1.0 with kernel 2.6.15.6. Xenomai is
>>> compiled into
>>> the kernel. I also use the driver xeno_16550A loaded as module. The
>>> USB-to-serial bridge used is a CP2101 from Silabs.  =20
>>
>> Is there any IRQ conflict between the USB host controller and some
>> RT-device? Please check /proc/interrupts and /proc/xenomai/irq.
>> =20
>>
> There is no conflict (interrupt 0 (timer) is the only interrupt
> mentioned in both listings).

Ok, just to exclude this.

>=20
>> Which process is consuming your CPU time? At system or at user level?
>> =20
>>
> It seems that the system consumes the CPU time. Here are the first few
> lines from opreport
>=20
> CPU: CPU with timer interrupt, speed 0 MHz (estimated)
> Profiling through timer interrupt
> samples  %        image name               app name               =20
> symbol name
> 1733     31.9742  vmlinux                  vmlinux                =20
> default_idle
> 1151     21.2362  vmlinux                  vmlinux                =20
> __ipipe_trace
> 601      11.0886  libqt-mt.so.3.3.3        libqt-mt.so.3.3.3        (no=

> symbols)
> 528       9.7417  libc-2.3.2.so            libc-2.3.2.so            (no=

> symbols)
> 305       5.6273  vmlinux                  vmlinux                =20
> __ipipe_unstall_root
> 184       3.3948  vmlinux                  vmlinux                =20
> __ipipe_dispatch_event
> 122       2.2509  anon (tgid:4322 range:0x81fb000-0x89b2000)
> Xorg                     (no symbols)
> 100       1.8450  libstdc++.so.5.0.7       libstdc++.so.5.0.7       (no=

> symbols)
> 97        1.7897  vmlinux                  vmlinux                  mco=
unt
>=20
> It looks like the systems gets stuck on the idle task. I do not know
> what __ipipe_trace exactly does.

__ipipe_trace belongs to the ipipe-tracer you seem to have patched into
your system. It's called on EVERY kernel function's entry, so it should
show up on higher ranks. Disable the tracer first to get a more
consistent profile.

>=20
>> Jan
>>
>> =20
>>
> In my current design I acquire and process the data in the same program=
m
> using the Xenomai native skin from user space. This means I link the
> Xenomai-native and rtdm libraries with several graphics and mathematica=
l
> libraries. Could this lead to conflicts or problems with Xenomai?

Should not, we do the same here (e.g. with opencv). Anyway, reducing
your scenario to the minimum that still performs badly can help to
identify the reason.

Jan


--------------enig6EE5A9941CDEF933D433C0D2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEacsgniDOoMHTA+kRAh2CAJ9jb0jW1ahmddf9P4v2OR96AjQaZACfVCSt
jl2tP/XOeNTQ1s0T3QCrLHM=
=l1Xk
-----END PGP SIGNATURE-----

--------------enig6EE5A9941CDEF933D433C0D2--

