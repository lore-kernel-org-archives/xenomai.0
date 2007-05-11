Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 May 2007 00:39:10 -0400
Message-ID: <D412DC851FDFAB4D8976895AC5C1F8AD30A781@domain.hid>
In-Reply-To: <46439123.60705@domain.hid>
From: "Zhang, Haobo" <haobo.zhang@domain.hid>
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
To: jan.kiszka@domain.hid
Cc: xenomai@xenomai.org, stelian@domain.hid

Hi Jan,

Thank you so much for your reply!

In my driver, I wrote:

int map_io( struct gpiodrv_context *dev_context, rtdm_user_info_t
*user_info, struct MAPPED_IO *io )
{
	int ret;

	if ((dev_context =3D=3D 0) || (user_info =3D=3D 0) || (io =3D=3D 0))
		return -EFAULT;

	if (dev_context->mapped_user_info !=3D 0)
	{
		if ((ret =3D gpio_unmap_io( dev_context )) !=3D 0)
			return ret;
	}

	dev_context->mapped_user_info =3D user_info;

	ret =3D rtdm_iomap_to_user( user_info, MPC52xx_PA(
MPC52xx_GPIO_WKUP_OFFSET + 0x0C ),
		1, PROT_READ | PROT_WRITE, (void
**)&(io->gpio_heart_beat), NULL, NULL );
=09
	if (ret !=3D 0)
		goto __ERROR;
	else
		dev_context->mapped_heart_beat =3D (void
*)io->gpio_heart_beat;

	return 0;

__ERROR:

	gpio_unmap_io( dev_context );
	return ret;
}=20

In the application, I wrote:

int main(int argc, char *argv[])=20
{
	int dev_gpio;
	struct MAPPED_IO gpio;

	signal(SIGTERM, clean_exit);=09
	signal(SIGINT, clean_exit);=09
=09
	mlockall( MCL_CURRENT | MCL_FUTURE );

	rt_task_shadow( &mainapp, "mainapp", 1, 0 );

	dev_gpio =3D rt_dev_open( "gpio", 0 );
	if (dev_gpio < 0)
	{
		return -1;
	}
=09
	gpio.gpio_heart_beat =3D NULL;

	if (rt_dev_ioctl( dev_gpio, 1, &gpio ) !=3D 0)
	{
		return -1;
	}

	gpio.gpio_heart_beat[0] =3D 0x01;

	...
}

I also tried another way by opening "/dev/mem" and then using "mmap" to
map the I/O memory addresses in the application. It worked!=20
I am very curious about why "rtdm_iomap_to_user" did not work for me.=20

Thanks,
Haobo

-----Original Message-----
From: jan.kiszka@domain.hid [mailto:jan.kiszka@domain.hid
Sent: May 10, 2007 5:40 PM
To: Zhang, Haobo
Cc: xenomai@xenomai.org; stelian@domain.hid
Subject: Re: [Xenomai-help] rtdm_iomap_to_user question

Zhang, Haobo wrote:
> Hi,
>=20
> I am currently working on a project which is running on a PowerPC=20
> platform. In my rtdm driver, I use "rtdm_iomap_to_user" to map a few=20
> I/O memory locations to be accessed from my application. All the=20
> function calls seem to work (no error code returned). But my=20
> application fails to use these pointers to manipulate any I/O. Is=20
> there any restrictions I have to be aware in order to use those mapped

> I/O mem? I am new to xenomai. I would really appreciate any help to
this.

Maybe you can post code or relevant code snippets so that we can have a
look. As I personally haven't work with this particular service yet, I
put Stelian in CC who contributed it and might already have some
suggestion. But, again, code talks much more.

Jan


