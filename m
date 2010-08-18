Message-ID: <4C6BD433.6030603@domain.hid>
Date: Wed, 18 Aug 2010 14:38:11 +0200
From: Stefan Kisdaroczi <kisda@domain.hid>
MIME-Version: 1.0
References: <4C45539B.70204@domain.hid>	<4C6932E8.7050701@domain.hid>	<4C694AB3.8050407@domain.hid>	<4C698E16.5050806@domain.hid>	<1282040830.1730.232.camel@domain.hid>
	<4C6ACA50.3080108@domain.hid> <4C6ACFA3.6090408@domain.hid>
In-Reply-To: <4C6ACFA3.6090408@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigFD7A3A2181B1DCC0323D3BE6"
Subject: Re: [Xenomai-help] kernel 2.6.32.11 with xenomai 2.5.3 fails to
 boot on ubuntu lucid system
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigFD7A3A2181B1DCC0323D3BE6
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

On 17.08.2010 20:06, Jan Kiszka wrote:
> Stefan Kisdaroczi wrote:
>  =20
>> I installed the kernel (2.6.32.15 2.5.4 x86 32bit) which is working on=

>> my laptop in a kvm machine.
>> In the virtual machine the kernel never starts and hangs.
>>    =20
> To make sure you are not facing a KVM issue (though they are much rarer=

> theses days - given you are using a recent KVM version...), please
> cross-check if the guest behaves identically when booting without KVM
> support (-no-kvm when using qemu-kvm).
>  =20

Hi Jan,

thanks for the hints.
With versions 0.12.4 setting breakpoints with gdb didn't work, with
0.12.5 they work.

Stefan

>> I attached gdb to kvm and according to the cpu registers and system.ma=
p
>> it hangs in 'doublefault_fn'. As I'm not really familiar with gdb i'm
>> thankful if someone has a hint how to proceed. Thanks
>>    =20
> Build the kernel with CONFIG_DEBUG_INFO, start "gdb
> /linux/src/path/vmlinux", then type "bt" at the gdb prompt when the
> guest hangs. This should dump a symbolic backtrace - though likely not
> beyond the exception entry. In that case, you could help us by examinin=
g
> the origin of the exception (parameters to the exception handler, it
> specifically receives a full register state).
>
> Also note that there are graphical debuggers, e.g. ddd, that can help
> working with gdb without knowing all its commands by heart.
>
> Jan
>
>  =20



--------------enigFD7A3A2181B1DCC0323D3BE6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAkxr1DgACgkQIPTw9rIdn6plMgCfRrQtDfQG/9QuK/HPN/uVsR5j
iisAn2XJvtKJ5RUJN5OP+/GBTXgt/eTH
=vCBZ
-----END PGP SIGNATURE-----

--------------enigFD7A3A2181B1DCC0323D3BE6--

