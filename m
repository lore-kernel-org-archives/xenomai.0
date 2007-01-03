Message-ID: <459B8A19.2060809@domain.hid>
Date: Wed, 03 Jan 2007 11:48:57 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] parallelport module for measuring
	external	interrupt latency
References: <459B6DAD.4030406@domain.hid>	<459B7C6C.9030401@domain.hid>
	<459B8382.7060508@domain.hid>
In-Reply-To: <459B8382.7060508@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig0B8097618777B25132412F84"
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
--------------enig0B8097618777B25132412F84
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Markus Franke wrote:
> Jan Kiszka wrote:
>>> // ISR
>>> int parport_isr(xnintr_t* cookie)
>>> {
>>> 	rdtsc(t_end);
>>> =09
>>> 	outb(0x00,SPPDATAPORT);
>>> =09
>>> #ifdef DEBUG
>>> 	printk(KERN_INFO "parport_latency: Interrupt fired!!!\n");
>>> 	printk(KERN_INFO "parport_latency: interruptcount before =3D %d!!!\n=
",atomic_read(&interruptcount));
>>> #endif
>>> =09
>>> 	atomic_inc(&interruptcount);
>>>
>>> #ifdef DEBUG
>>> 	printk(KERN_INFO "parport_latency: interruptcount after=3D %d!!!\n",=
atomic_read(&interruptcount));
>>> #endif
>>>
>>> 	wake_up_interruptible(&intlatpar_queue);
>>
>> This is a hard-RT IRQ handler, thus any scheduling Linux service is
>> strictly forbidden.
>>
>> [Reminds me of the I-pipe debugging service that can catch such faults=

>> but still needs some integration work...]
>=20
> Ok I understand. But somehow I have to notify the read()-call that it
> can compute the latency value. Do you have any suggestions how to do th=
at?

Even if the notification is not time-critical, you first have to get out
of the Xenomai context in a sane manner. rtdm_nrtsig may help if you
don't want to use the RT scheduler for user task wakeup.

>=20
>>> 	if(register_chrdev(INTLAT_DEV_MAJOR,INTLAT_DEV_NAME,&intlat_fops) < =
0)=20
>>> 	{
>>> 		printk(KERN_WARNING "intlat: parport_latency(): register_chrdev() f=
ailed.\n");
>>> 		rt_intr_disable(&intr);
>>> 		return -1;
>>> 	}
>>
>> Hmm, a Linux character device for this purpose... I guess you should
>> study the existing irqbench test a bit first. And if you don't see why=

>> something is done the way it is - ask here.
>=20
> Yes of course I have already studied the irqbench test but it uses the
> RTDM skin. I also know that this skin should be used for developing har=
d
> realtime drivers. But I just need to measure latencies and I don't want=

> to develop a huge realtime driver. I just need some values for

Well, irqbench contains a bunch of test cases. If you cut it down to
only your scenario, it wouldn't appear as that "huge", it would likely
be as long as your own driver.

> comparison with the driver working on plain linux. I was wondering
> whether it is possible to rewrite the driver working on plain linux by
> using the Xenomai native API.
> Why isn't it possible to use a Linux character device. I just want to
> transfer the latency values to the user space task which is out of any
> realtime context I think.

You can - if you keep a clean separation between RT and non-RT. Direct
wakeup from the Xenomai IRQ handler is forbidden, but indirect via a
rtdm_nrtsig trampoline would be feasible. [In that case you could also
drop all Xenomai functions from your user-space tool and use plain Linux.=
]

Jan


--------------enig0B8097618777B25132412F84
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFm4oZniDOoMHTA+kRAg/UAKCBRlYsmnqYlRkVMGUv7BdLDlhbIwCggReP
hfAKKDJob2lgH8hZKE3rVjU=
=6ukY
-----END PGP SIGNATURE-----

--------------enig0B8097618777B25132412F84--

