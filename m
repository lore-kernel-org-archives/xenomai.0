Message-ID: <459B7C6C.9030401@domain.hid>
Date: Wed, 03 Jan 2007 10:50:36 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] parallelport module for measuring external
	interrupt latency
References: <459B6DAD.4030406@domain.hid>
In-Reply-To: <459B6DAD.4030406@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigC62CF714EEBB735C1E53753E"
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
To: Markus.Franke@domain.hid
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigC62CF714EEBB735C1E53753E
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Markus Franke wrote:
> Dear Xenomai-Users / Developers,
>=20
> I have finished my work on a parallelport module for measuring external=

> interrupt latencies. It is based on another kernel-module working on
> plain linux. Interrupt latencies are measured via triggering an
> interrupt over a connection between data pin 7 and the ACK-pin.
>=20
> The kernel module loads fine without any problems. When starting the
> User-space task the system freezes without any output in the kernel log=
=2E
>  I was trying to solve the problem for several days now without any
> success. I would appreciate, if somebody would have a short look on it.=

> Maybe its just a small problem which can be fixed easily.
>=20
> The kernel-module as well as the user-space task are attached.
>=20
> Thanks in advance and regards,
> Markus Franke
>=20
> PS.: I am aware of the fact that there is already a testcase in the
> testsuite for measuring external interrupt latencies. Nevertheless, I
> would like to gain experiences in developing with Xenomai and I want to=

> know why the attached code doesn't work. I will also work with the
> testcases in the testsuite soon.
>=20

=2E..

>=20
> // ISR
> int parport_isr(xnintr_t* cookie)
> {
> 	rdtsc(t_end);
> =09
> 	outb(0x00,SPPDATAPORT);
> =09
> #ifdef DEBUG
> 	printk(KERN_INFO "parport_latency: Interrupt fired!!!\n");
> 	printk(KERN_INFO "parport_latency: interruptcount before =3D %d!!!\n",=
atomic_read(&interruptcount));
> #endif
> =09
> 	atomic_inc(&interruptcount);
>=20
> #ifdef DEBUG
> 	printk(KERN_INFO "parport_latency: interruptcount after=3D %d!!!\n",at=
omic_read(&interruptcount));
> #endif
>=20
> 	wake_up_interruptible(&intlatpar_queue);

This is a hard-RT IRQ handler, thus any scheduling Linux service is
strictly forbidden.

[Reminds me of the I-pipe debugging service that can catch such faults
but still needs some integration work...]

>=20
> #ifdef DEBUG
> 	printk(KERN_INFO "parport_latency: exit parport_isr()!!!\n");
> #endif
>=20
> 	return 0;
> }
>=20
> /* the struct of fileoperations */
> static struct file_operations intlat_fops =3D {
> 	.read =3D latdev_read,
> 	.open =3D latdev_open,
> 	.release =3D latdev_release,
> 	.ioctl =3D latdev_ioctl
> };
>=20
>=20
> // Initialise module
> int parport_init(void)
> {
> 	int err =3D 0;
> =09
> 	printk(KERN_INFO "parport_latency: Initialisation started\n");
> =09
> 	/* enable parallel port interrupt generation, probably not needed */
>         outb(SSPINTERRUPTENABLE,SPPCONTROLPORT);
> =09
> 	err =3D rt_intr_create(&intr, "parport_latency", INTR_NR, &parport_isr=
, NULL, 0);
> 	if(err !=3D 0)
> 	{
> 		printk(KERN_INFO "parport_latency: Error while requesting Interrupt %=
d, error %d\n", INTR_NR, err);
> 		return -1;
> 	}
>=20
> 	err =3D rt_intr_enable(&intr);
> 	if(err !=3D 0)
> 	{
> 		printk(KERN_INFO "parport_latency: Error while enabling Interrupt %d,=
 error %d\n", INTR_NR, err);
> 		return -1;
> 	}
>=20
> 	if(register_chrdev(INTLAT_DEV_MAJOR,INTLAT_DEV_NAME,&intlat_fops) < 0)=
=20
> 	{
> 		printk(KERN_WARNING "intlat: parport_latency(): register_chrdev() fai=
led.\n");
> 		rt_intr_disable(&intr);
> 		return -1;
> 	}

Hmm, a Linux character device for this purpose... I guess you should
study the existing irqbench test a bit first. And if you don't see why
something is done the way it is - ask here.

Jan


--------------enigC62CF714EEBB735C1E53753E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFm3xtniDOoMHTA+kRAk9lAJ4tr6SoLsBQmPDT8THXtmkkD3syFQCfRf/s
Zjjk4CeigKMTbUgJWLlJmRM=
=JVH9
-----END PGP SIGNATURE-----

--------------enigC62CF714EEBB735C1E53753E--

