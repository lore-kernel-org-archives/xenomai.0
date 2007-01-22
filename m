Message-ID: <45B495F9.6090808@domain.hid>
Date: Mon, 22 Jan 2007 11:46:17 +0100
From: Stephan Zimmermann <s.zimmermann@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"; format="flowed"
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai-help] weired behaviour around userspace interrupts
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

Hello all,
I guess I found some weired memory bug in Xenomai's (userspace?)=20
interrupt handling. When I run the attached testprogram (or another=20
program using userspace interrupt's) it happens that 'cat=20
/proc/xenomai/irq' delivers the following output:

linux1:/proc# cat xenomai/irq
IRQ         CPU0        CPU1
   7:           0           9         ?*=E7d
213:           9           0
216:        1949        1949         [timer]
217:           0           0
226:          28           0         [virtual]

As you can see, for IRQ 7 the output looks somehow confusing.

To run the attached program, you need a LPT loopback-device, simply=20
connect pin's 9 and 10 of the parallel port. (This is not necessary to=20
see the problem.)

Another thing I have seen, which may be related to this, happens after=20
re-running the program.  The whole /proc/xenomai directory is empty.=20
Reloading the xeno modules doesn't help and a reboot is needed to get it=20
working. I don't know how to reproduce it reliably.

That all happens on my AMD X2 as well as on two Pentium M machines.

Maybe someone can explain this.

Thanks in advance,
Stephan


The testprogram:
-----------------------------------------------------------
#include <iostream>
#include <sys/mman.h>
#include <assert.h>
#include "native/task.h"
#include "native/timer.h"
#include "native/queue.h"
#include "native/intr.h"

#include <sys/io.h>

RT_TASK maintask;
RT_TASK inttask;
RT_TASK intcreatortask;

#define LPT_BASE	0x378
#define LPT_INT		7

bool finish =3D false;

void int_task(void* cookie){
	int err =3D 0;
	int counter =3D 0;
	RT_INTR lptint;
=09
	err =3D rt_intr_create(&lptint,"parp_int",7,0);
	std::cout << "interrupt create:" << err << std::endl;
=09
	err =3D rt_intr_enable(&lptint);
	std::cout << "interrupt enable:" << err << std::endl;
=09
	// switch int mode on
	outb_p(0x10, LPT_BASE + 2);
=09
	// all pins =3D 0
	outb_p(0x00, LPT_BASE );
=09
	while(!finish){
		err =3D rt_intr_wait(&lptint, 100);
		if(err >=3D 0 ){
			counter++;
			std::cout << "got " << err << " loop: " << counter << std::endl;
		}
	}
=09
	err =3D rt_intr_disable(&lptint);
	std::cout << "interrupt disable:" << err << std::endl;
=09
	err =3D rt_intr_delete(&lptint);
	std::cout << "interrupt delete:" << err << std::endl;
=09
}

void int_creator_task(void* cookie){
	char ob =3D 0x00;
	for(int i =3D 0; i < 1000; i++){=09
		rt_task_sleep(100);
		outb_p(ob,LPT_BASE);
		if(ob){
			ob =3D 0x00;
		}else{
			ob =3D 0xFF;
		}
	}
	finish =3D true;
}

int main(void){
	int err;
=09
	std::cout << "xenomai interrupt test" << std::endl;
	mlockall(MCL_CURRENT | MCL_FUTURE);
=09
	if (iopl(3)) {
		printf("iopl err\n");
		exit(1);
	}
=09
	err =3D rt_task_shadow (&maintask,"maintask",10,0);
	std::cout << "task shadow:" << err << std::endl;
=09
	err =3D rt_timer_set_mode(1000000);
	std::cout << "timer set mode:" << err << std::endl;
=09
	rt_task_spawn(&inttask,"interrupt-task",1024,50,T_JOINABLE,int_task,NULL);
=09
	rt_task_spawn(&intcreatortask,"interrupt-creator-task",1024,50,T_JOINABLE,=
int_creator_task,NULL);
=09
	rt_task_join(&intcreatortask);
	rt_task_join(&inttask);
=09
	std::cout << "task's finished, exiting" << std::endl;
=09
	return 0;
}

