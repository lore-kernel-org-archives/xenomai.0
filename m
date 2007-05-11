Message-ID: <4644982B.5040708@domain.hid>
Date: Fri, 11 May 2007 18:22:03 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <D412DC851FDFAB4D8976895AC5C1F8AD30A781@domain.hid>
In-Reply-To: <D412DC851FDFAB4D8976895AC5C1F8AD30A781@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig53AAD14BC1A264614DD0A193"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] rtdm_iomap_to_user question
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "Zhang, Haobo" <haobo.zhang@domain.hid>
Cc: xenomai@xenomai.org, stelian@domain.hid

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig53AAD14BC1A264614DD0A193
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Zhang, Haobo wrote:
> Hi Jan,
>=20
> Thank you so much for your reply!
>=20
> In my driver, I wrote:
>=20
> int map_io( struct gpiodrv_context *dev_context, rtdm_user_info_t
> *user_info, struct MAPPED_IO *io )
> {
> 	int ret;
>=20
> 	if ((dev_context =3D=3D 0) || (user_info =3D=3D 0) || (io =3D=3D 0))
> 		return -EFAULT;
>=20
> 	if (dev_context->mapped_user_info !=3D 0)
> 	{
> 		if ((ret =3D gpio_unmap_io( dev_context )) !=3D 0)
> 			return ret;
> 	}
>=20
> 	dev_context->mapped_user_info =3D user_info;
>=20
> 	ret =3D rtdm_iomap_to_user( user_info, MPC52xx_PA(
> MPC52xx_GPIO_WKUP_OFFSET + 0x0C ),
> 		1, PROT_READ | PROT_WRITE, (void
> **)&(io->gpio_heart_beat), NULL, NULL );

Hmm, hmm. Looking at our code and the kernel again I would say we should
catch non-page-aligned requests like this and document this pitfall bette=
r.

The mapping code always assumes page-alignment and rounds your physical
address down. So what likely happened here is that you got a mapping,
but with unexpected offset (gpio_heart_beat should point to MPC52xx_PA).

> =09
> 	if (ret !=3D 0)
> 		goto __ERROR;
> 	else
> 		dev_context->mapped_heart_beat =3D (void
> *)io->gpio_heart_beat;
>=20
> 	return 0;
>=20
> __ERROR:
>=20
> 	gpio_unmap_io( dev_context );
> 	return ret;
> }=20
>=20
> In the application, I wrote:
>=20
> int main(int argc, char *argv[])=20
> {
> 	int dev_gpio;
> 	struct MAPPED_IO gpio;
>=20
> 	signal(SIGTERM, clean_exit);=09
> 	signal(SIGINT, clean_exit);=09
> =09
> 	mlockall( MCL_CURRENT | MCL_FUTURE );
>=20
> 	rt_task_shadow( &mainapp, "mainapp", 1, 0 );
>=20
> 	dev_gpio =3D rt_dev_open( "gpio", 0 );
> 	if (dev_gpio < 0)
> 	{
> 		return -1;
> 	}
> =09
> 	gpio.gpio_heart_beat =3D NULL;
>=20
> 	if (rt_dev_ioctl( dev_gpio, 1, &gpio ) !=3D 0)
> 	{
> 		return -1;
> 	}
>=20
> 	gpio.gpio_heart_beat[0] =3D 0x01;
>=20
> 	...
> }
>=20
> I also tried another way by opening "/dev/mem" and then using "mmap" to=

> map the I/O memory addresses in the application. It worked!=20
> I am very curious about why "rtdm_iomap_to_user" did not work for me.=20

When you do precisely the same odd-numbered mapping via mmap on
/dev/mem, you do get the right address at gpio_heart_beat (check if the
start address ends with 0x0b0c)?

We either have to improve rtdm_iomap/mmap_to_user in this regard or
catch unaligned requests. Probably it's easier to catch it so that the
driver writer also realises that this is always about mapping full pages.=
=2E.

Jan


--------------enig53AAD14BC1A264614DD0A193
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGRJgrniDOoMHTA+kRAk44AJ9bzmVt0pt9Hs2V4+64c3tYgXFcpgCff42v
r93SeTVAt/R5zMOebL9LLBM=
=QA5E
-----END PGP SIGNATURE-----

--------------enig53AAD14BC1A264614DD0A193--

