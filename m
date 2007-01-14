Message-ID: <45AA3D26.2040409@domain.hid>
Date: Sun, 14 Jan 2007 15:24:38 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] xeno_16550A and 8250.nr_uarts=0
References: <45A68383.3070203@domain.hid> <45A6CB80.9060306@domain.hid>
	<45A802CD.8010606@domain.hid>
In-Reply-To: <45A802CD.8010606@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig5F5703F81ECBD824D6304353"
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
To: Jeff Webb <jeff.webb@domain.hid>
Cc: Xenomai help <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig5F5703F81ECBD824D6304353
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Jeff Webb wrote:
> Jan Kiszka wrote:
>> Jeff Webb wrote:
>>> ...
>>> My serial test program works fine in the above scenario.  However, if=
 I
>>> try to disable the linux serial support at boot time by adding
>>> "8250.nr_uarts=3D0" to the kernel boot options, my serial test progra=
m
>>> does not work.  There are no errors opening, configuring, or reading
>>> from the rtdm device, but no data is received from the driver.  I ass=
ume
>>> that my test program is not initializing something properly, so it wo=
rks
>>> when linux initializes the serial port.  I can't seem to find what I'=
m
>>> doing wrong.  Any help would be appreciated.
>>
>> Hmm, maybe a PnP issue. If there is no driver registered for the on-ch=
ip
>> PnP UARTS, power might be switched off (or kept off) for them. As
>> xeno_16550A doesn't perform any validation of the underlying hardware
>> (dunno right now if there is a pattern to test at all), it may just
>> operate on dead addresses.
>>
>> I faced the same issue with irqbench and parallel ports. They get
>> switched off once the related Linux driver is removed. One solution
>> there was to register irqbench with the PnP subsystem. I need to check=

>> if this is required here as well.
>=20
> Thanks for the suggestion.  I looked at the PnP-related code in
> irqbench.c, and compared this to what is in
> linux/drivers/parport/parport_pc.c.  I then modified 16550A.c in a
> similar fashion, merging in the required code from
> linux/drivers/serial/8250_pnp.c.  I can now boot the kernel with
> 8250.nr_uarts=3D0", insert the modified xeno_16550A module, and then ru=
n
> my serial test program successfully.  I have not tried compiling the
> modified xeno_16550A code into the kernel, but I will try this next.

Nice to hear.

>=20
> Please review the attached patch and merge into subversion as you see f=
it.

Basically, it looks good. I'm just wondering if we shouldn't make use of
the resource information passed on probe, validate it against what the
user provided, and only claim those ports the user actually selected.

Another thing the check is MODULE_DEVICE_TABLE. Does your device still
work when you remove this line? While it is useful for standard ports
that shall be automatically configured, I noticed that it causes
irqbench being loaded automatically during boot (because the pnp
signature matches). That is likely not what you want when you configure
xeno_16550A as module and have to switch off the standard port first
before insmod'ing the rt-driver with full arguments.

Thanks,
Jan


--------------enig5F5703F81ECBD824D6304353
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFqj0mniDOoMHTA+kRAqSjAJoDjs3S2mPMCabZwBHRdh4Grmea8QCdHR/e
CKNjlZU1gSTwrMuTWw8fekc=
=hmyk
-----END PGP SIGNATURE-----

--------------enig5F5703F81ECBD824D6304353--

