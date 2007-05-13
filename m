Message-ID: <4646E773.6020908@domain.hid>
Date: Sun, 13 May 2007 12:24:51 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <D412DC851FDFAB4D8976895AC5C1F8AD30A925@domain.hid>
In-Reply-To: <D412DC851FDFAB4D8976895AC5C1F8AD30A925@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig8AA5B7151877BF00377F98E5"
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
--------------enig8AA5B7151877BF00377F98E5
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Zhang, Haobo wrote:
> Thanks, Jan. It is fixed after I modified my code as you suggested.

Good to hear. Now just please answer my question below related to
/dev/mem so that I can think about a generic solution for the
documentation or the code or rtdm_*map_to_user.

Jan

>=20
> Best Regards,
> Haobo Zhang=20
>=20
> -----Original Message-----
> From: jan.kiszka@domain.hid [mailto:jan.kiszka@domain.hid
> Sent: May 11, 2007 12:22 PM
> To: Zhang, Haobo
> Cc: xenomai@xenomai.org; stelian@domain.hid
> Subject: Re: [Xenomai-help] rtdm_iomap_to_user question
>=20
> Zhang, Haobo wrote:
>> Hi Jan,
>>
>> Thank you so much for your reply!
>>
>> In my driver, I wrote:
>>
>> int map_io( struct gpiodrv_context *dev_context, rtdm_user_info_t=20
>> *user_info, struct MAPPED_IO *io ) {
>> 	int ret;
>>
>> 	if ((dev_context =3D=3D 0) || (user_info =3D=3D 0) || (io =3D=3D 0))
>> 		return -EFAULT;
>>
>> 	if (dev_context->mapped_user_info !=3D 0)
>> 	{
>> 		if ((ret =3D gpio_unmap_io( dev_context )) !=3D 0)
>> 			return ret;
>> 	}
>>
>> 	dev_context->mapped_user_info =3D user_info;
>>
>> 	ret =3D rtdm_iomap_to_user( user_info, MPC52xx_PA(=20
>> MPC52xx_GPIO_WKUP_OFFSET + 0x0C ),
>> 		1, PROT_READ | PROT_WRITE, (void
>> **)&(io->gpio_heart_beat), NULL, NULL );
>=20
> Hmm, hmm. Looking at our code and the kernel again I would say we shoul=
d
> catch non-page-aligned requests like this and document this pitfall
> better.
>=20
> The mapping code always assumes page-alignment and rounds your physical=

> address down. So what likely happened here is that you got a mapping,
> but with unexpected offset (gpio_heart_beat should point to MPC52xx_PA)=
=2E
>=20
>> =09
>> 	if (ret !=3D 0)
>> 		goto __ERROR;
>> 	else
>> 		dev_context->mapped_heart_beat =3D (void
> *)io->gpio_heart_beat;
>> 	return 0;
>>
>> __ERROR:
>>
>> 	gpio_unmap_io( dev_context );
>> 	return ret;
>> }
>>
>> In the application, I wrote:
>>
>> int main(int argc, char *argv[])
>> {
>> 	int dev_gpio;
>> 	struct MAPPED_IO gpio;
>>
>> 	signal(SIGTERM, clean_exit);=09
>> 	signal(SIGINT, clean_exit);=09
>> =09
>> 	mlockall( MCL_CURRENT | MCL_FUTURE );
>>
>> 	rt_task_shadow( &mainapp, "mainapp", 1, 0 );
>>
>> 	dev_gpio =3D rt_dev_open( "gpio", 0 );
>> 	if (dev_gpio < 0)
>> 	{
>> 		return -1;
>> 	}
>> =09
>> 	gpio.gpio_heart_beat =3D NULL;
>>
>> 	if (rt_dev_ioctl( dev_gpio, 1, &gpio ) !=3D 0)
>> 	{
>> 		return -1;
>> 	}
>>
>> 	gpio.gpio_heart_beat[0] =3D 0x01;
>>
>> 	...
>> }
>>
>> I also tried another way by opening "/dev/mem" and then using "mmap"=20
>> to map the I/O memory addresses in the application. It worked!
>> I am very curious about why "rtdm_iomap_to_user" did not work for me. =

>=20
> When you do precisely the same odd-numbered mapping via mmap on
> /dev/mem, you do get the right address at gpio_heart_beat (check if the=

> start address ends with 0x0b0c)?
>=20
> We either have to improve rtdm_iomap/mmap_to_user in this regard or
> catch unaligned requests. Probably it's easier to catch it so that the
> driver writer also realises that this is always about mapping full
> pages...
>=20
> Jan
>=20



--------------enig8AA5B7151877BF00377F98E5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFGRudzniDOoMHTA+kRAqOGAJsGAqeMBqf7Un9mAuoKw6Vu2nhNnACfZ9Aa
aBatAZVcd/dvg9tu0Yu/rI0=
=Dsui
-----END PGP SIGNATURE-----

--------------enig8AA5B7151877BF00377F98E5--

