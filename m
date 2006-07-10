Message-ID: <44B2169F.7070205@domain.hid>
Date: Mon, 10 Jul 2006 10:58:07 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] isr
References: <20060710080757.4430@domain.hid> <44B21018.4060702@domain.hid>
	<20060710084549.4390@domain.hid>
In-Reply-To: <20060710084549.4390@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigC5F4D4561CDB98DD4C39F6A2"
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
To: Keinen Namen <GSM909@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigC5F4D4561CDB98DD4C39F6A2
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Keinen Namen wrote:
> Sorry here is my source code.
>=20
> My Problem ist how can I call the ISR.

Well, the basic idea behind IRQs is that the hardware "call" them for
you, isn't it? :)

See /proc/xenomai/irq if something is happening on your IRQ line.

>=20
> Regards Memory
>=20
>=20
> #include <linux/kernel.h>
> #include <linux/init.h>
> #include <linux/module.h>
> #include <linux/fs.h>
>=20
> #include <native/intr.h>
>=20
> MODULE_DESCRIPTION("My kernel module");
> MODULE_AUTHOR("Nobody");
> MODULE_DESCRIPTION("Dei Mudda");
> MODULE_LICENSE("my own");
>=20
>=20
> RT_INTR my_rt_intr;
>=20
> int helloworld_isr(rt_intr_t *intr){
> 	printk( KERN_ALERT "IRQ\n");
> 	return IRQ_HANDLED;
> }
>=20
> struct file_operations helloworld_fops =3D {
> 	.owner 		=3D THIS_MODULE,
> 	.llseek		=3D NULL,
> 	.read		=3D NULL,
> 	.write		=3D NULL,
> 	.readdir	=3D NULL,
> 	.poll		=3D NULL,
> 	.ioctl		=3D NULL,
> 	.mmap		=3D NULL,
> 	.open		=3D NULL,
> 	.flush		=3D NULL,
> 	.release	=3D NULL,
> 	.fsync		=3D NULL,
> 	.fasync		=3D NULL,
> 	.lock		=3D NULL,
> 	.readv		=3D NULL,
> 	.writev		=3D NULL,
> };

What's this for? Keep in mind that mixing Linux file operations with
Xenomai is almost always not cleanly working. That's also what RTDM is
for: providing a stripped down file operations interface to real-time use=
rs.

>=20
>=20
> static int helloworld_init_module(void) {
> 	int x;
> 	printk( KERN_ALERT "Module helloworld init startet Version 0.1\n" );
> 	x =3D rt_intr_create(&my_rt_intr,"ein Name",SIU_INT_TIMER2,&helloworld=
_isr,NULL,0);

Are you sure your hardware is already set up to fire on SIU_INT_TIMER2?

If you are looking for some working examples, check the new irqbench
test over RS232 or the timer-related part of Hannes' example driver on
http://www.captain.at/xenomai-real-time-driver-example-driver-source-code=
=2Ephp

What's your goal, BTW?

> 	if(!x){
> 		printk( KERN_ALERT "Interrupt erfolgreich erstellt\n");
> 		if(!(rt_intr_enable(&my_rt_intr))){
> 			printk( KERN_ALERT "Interrupt erfolgreich aktiviert\n");
> 		}
> 	}else{
> 		printk( KERN_ALERT "Interrupt Erstellung fehlgeschlagen %i\n",x);
> 	}
> }
>=20
> static void helloworld_exit_module(void) {
>=20
> 	if(!(rt_intr_disable(&my_rt_intr))){
> 		printk( KERN_ALERT "Interrupt Cleared !\n" );
> 		if(!(rt_intr_delete(&my_rt_intr))){
> 	 		printk(KERN_ALERT "Interrupt deleted\n" );
> 		}
> 	}
>=20
> 	printk( KERN_ALERT "Module helloworld exit\n" );
> }
>=20
> module_init(helloworld_init_module);
> module_exit(helloworld_exit_module);
>=20
> -------- Original-Nachricht --------
> Datum: Mon, 10 Jul 2006 10:30:16 +0200
> Von: Jan Kiszka <jan.kiszka@domain.hid>
> An: Keinen Namen <GSM909@domain.hid>
> Betreff: Re: [Xenomai-help] isr
>=20
>> Keinen Namen wrote:
>>> Hi I useing Xenomai 2.1 and the native skin=20
>>>
>>> I want create a intr in kernel space with rt_intr_create, the 4th
>> argument is the pointer is the ISR.
>>> My Question is which form does the ISR must have
>>>
>>> rt_isr_t myisr ( ??? )
>>> {
>>> ...
>>> }
>>>
>> int my_isr(rt_intr_t *intr);
>>
>> That's indeed undocumented, you had to browse the code for this
>> information. :-/
>>
>> [Note: unless you are writing some specialised or experimental code,
>> developing drivers over the RTDM skin is recommended now. This aims at=

>> unifying the device interfaces for all skins.]
>>
>> Jan
>>
>=20



--------------enigC5F4D4561CDB98DD4C39F6A2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEshafniDOoMHTA+kRAvIjAJoCDgujMw+MjBjAroueL7bRkAaZsgCdHn58
2tuz4GiUZbrB9+HVy8aKnXA=
=OEuv
-----END PGP SIGNATURE-----

--------------enigC5F4D4561CDB98DD4C39F6A2--

