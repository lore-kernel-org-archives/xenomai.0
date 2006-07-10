Content-Type: text/plain; charset="iso-8859-1"
Date: Mon, 10 Jul 2006 10:45:49 +0200
From: "Keinen Namen" <GSM909@domain.hid>
In-Reply-To: <44B21018.4060702@domain.hid>
Message-ID: <20060710084549.4390@domain.hid>
MIME-Version: 1.0
References: <20060710080757.4430@domain.hid> <44B21018.4060702@domain.hid>
Subject: Re: Re: [Xenomai-help] isr
Content-Transfer-Encoding: quoted-printable
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

Sorry here is my source code.

My Problem ist how can I call the ISR.

Regards Memory


#include <linux/kernel.h>
#include <linux/init.h>
#include <linux/module.h>
#include <linux/fs.h>

#include <native/intr.h>

MODULE_DESCRIPTION("My kernel module");
MODULE_AUTHOR("Nobody");
MODULE_DESCRIPTION("Dei Mudda");
MODULE_LICENSE("my own");


RT_INTR my_rt_intr;

int helloworld_isr(rt_intr_t *intr){
	printk( KERN_ALERT "IRQ\n");
	return IRQ_HANDLED;
}

struct file_operations helloworld_fops =3D {
	.owner 		=3D THIS_MODULE,
	.llseek		=3D NULL,
	.read		=3D NULL,
	.write		=3D NULL,
	.readdir	=3D NULL,
	.poll		=3D NULL,
	.ioctl		=3D NULL,
	.mmap		=3D NULL,
	.open		=3D NULL,
	.flush		=3D NULL,
	.release	=3D NULL,
	.fsync		=3D NULL,
	.fasync		=3D NULL,
	.lock		=3D NULL,
	.readv		=3D NULL,
	.writev		=3D NULL,
};


static int helloworld_init_module(void) {
	int x;
	printk( KERN_ALERT "Module helloworld init startet Version 0.1\n" );
	x =3D rt_intr_create(&my_rt_intr,"ein Name",SIU_INT_TIMER2,&helloworld_isr=
,NULL,0);
	if(!x){
		printk( KERN_ALERT "Interrupt erfolgreich erstellt\n");
		if(!(rt_intr_enable(&my_rt_intr))){
			printk( KERN_ALERT "Interrupt erfolgreich aktiviert\n");
		}
	}else{
		printk( KERN_ALERT "Interrupt Erstellung fehlgeschlagen %i\n",x);
	}
}

static void helloworld_exit_module(void) {

	if(!(rt_intr_disable(&my_rt_intr))){
		printk( KERN_ALERT "Interrupt Cleared !\n" );
		if(!(rt_intr_delete(&my_rt_intr))){
	 		printk(KERN_ALERT "Interrupt deleted\n" );
		}
	}

	printk( KERN_ALERT "Module helloworld exit\n" );
}

module_init(helloworld_init_module);
module_exit(helloworld_exit_module);

-------- Original-Nachricht --------
Datum: Mon, 10 Jul 2006 10:30:16 +0200
Von: Jan Kiszka <jan.kiszka@domain.hid>
An: Keinen Namen <GSM909@domain.hid>
Betreff: Re: [Xenomai-help] isr

> Keinen Namen wrote:
> > Hi I useing Xenomai 2.1 and the native skin=20
> >=20
> > I want create a intr in kernel space with rt_intr_create, the 4th
> argument is the pointer is the ISR.
> >=20
> > My Question is which form does the ISR must have
> >=20
> > rt_isr_t myisr ( ??? )
> > {
> > ...
> > }
> >=20
>=20
> int my_isr(rt_intr_t *intr);
>=20
> That's indeed undocumented, you had to browse the code for this
> information. :-/
>=20
> [Note: unless you are writing some specialised or experimental code,
> developing drivers over the RTDM skin is recommended now. This aims at
> unifying the device interfaces for all skins.]
>=20
> Jan
>=20

--=20


Echte DSL-Flatrate dauerhaft f=FCr 0,- Euro*!
"Feel free" mit GMX DSL! http://www.gmx.net/de/go/dsl

