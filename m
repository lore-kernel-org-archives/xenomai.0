Message-ID: <46443277.3060102@domain.hid>
Date: Fri, 11 May 2007 11:08:07 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <XqI9Fhxa.1178875870.3777430.dchabal@domain.hid>
In-Reply-To: <XqI9Fhxa.1178875870.3777430.dchabal@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigC7FBD841BB20A569D172375C"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] 16550A driver and Moxa card / solved
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: CHABAL David <david.chabal@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigC7FBD841BB20A569D172375C
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

CHABAL David wrote:
> Hello,
>=20
> I met some trouble with the 16550A driver provided in Xenomai 2.3.1
> and my Moxa cards (PCI / 8 * RS232 / 168U ).
>=20
> It was a problem of baudrate computation before setting the LCR_DLAB
> register.
>=20
> The formula implemented by the Xenomai driver is different from the one=

> provided by Moxa. So I copy/paste the formula from the mxser.c file
> (present in the
> kernel distro), and it seems to work fine.
>=20
> I think it's Moxa card dependant, may be caused by the high default bau=
d
> rate of this card.
>=20
> I post here my patch below, it may interest someone.

Thanks for sharing your findings. Will check if/how we can integrate
them. See some comments below already.

[Reminds me that there are more 16550A patches pending in my inbox... :-/=
]

>=20
> David
>=20
> ----------------------------------------------
>=20
>=20
>=20
> @@ -29,7 +29,7 @@
>  #define IN_BUFFER_SIZE      4096
>  #define OUT_BUFFER_SIZE     4096
>=20
> -#define DEFAULT_BAUD_BASE   115200
> +#define DEFAULT_BAUD_BASE   921600

OK, that's for your convenience right now. We also have a module
parameter to set the base.

>  #define DEFAULT_TX_FIFO     16
>=20
>  #define PARITY_MASK         0x03
> @@ -316,8 +316,23 @@
>=20
>      if (testbits(config->config_mask, RTSER_SET_BAUD)) {
>          ctx->config.baud_rate =3D config->baud_rate;
> -        baud_div =3D (baud_base[dev_id] + (ctx->config.baud_rate >> 1)=
) /
> -                   ctx->config.baud_rate;
> +        if (ctx->config.baud_rate =3D=3D 134)
> +        {
> +          baud_div =3D (2 * baud_base[dev_id] / 269);
> +        }

Well, whoever needs such low rates in practice these days... :)

> +        else
> +        {
> +          if (ctx->config.baud_rate)

Oops, that check protects us from dividing by zero - should be fixed in
any case! Or is baud_div =3D 0 a special mode with Moxa?

> +          {
> +            baud_div =3D baud_base[dev_id] / ctx->config.baud_rate;

So this means dividing with round down instead of round up. We could
enable this mode with an additional module parameter, something like
variant =3D {0: standard, 1: moxa, ...}. That could also raise the defaul=
t
baudbase for the particular port.

> +                 if (baud_div =3D=3D 0)
> +              baud_div =3D 1;

That shouldn't trigger with xeno_16550A because we catch baud_rate >
baud_base already in rt_16550_ioctl.

> +               }
> +          else
> +          {
> +                 baud_div =3D 0;
> +          }
> +        }
>          outb(LCR_DLAB,        LCR(dev_id));
>          outb(baud_div & 0xff, DLL(dev_id));
>          outb(baud_div >> 8,   DLM(dev_id));
>=20

Jan


--------------enigC7FBD841BB20A569D172375C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGRDJ3niDOoMHTA+kRAlkmAJ4wYvikgNavb/Cpgle0F+SrWsaMYACdE62u
yPxjhtJH14BFTcYsqHK1Adw=
=bHn8
-----END PGP SIGNATURE-----

--------------enigC7FBD841BB20A569D172375C--

