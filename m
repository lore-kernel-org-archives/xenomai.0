Message-ID: <45C9E90D.2050307@domain.hid>
Date: Wed, 07 Feb 2007 15:58:21 +0100
From: Stephan Zimmermann <s.zimmermann@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"; format="flowed"
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai-help] system freeze with 2.3.x latest svn
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

Hello,
I get the following message and a completely frozen system when I run my
applications after upgrading to branches/v2.3.x  rev. 2137. (Everything=20
worked fine on revision 2077)

'Xenomai: fatal: re-enqueuing a relaxed thread in the RPI queue'

Maybe I did s.th. stupid again?

I did 'svn -r 2137 up' in the source directory and recompiled=20
everything (kernel, xenomai, my application). It's a AMD-X2 with Kernel=20
2.6.17.14, running Debian Sarge. My colleague tells me he saw the same=20
when experimenting with trunk.

some additional infos:

'svn info' gives me:
------------------------------------------------------------------
linux1:~/xenomai_svn_test/xenomai$ svn info
Pfad: .
URL: http://svn.gna.org/svn/xenomai/branches/v2.3.x
UUID des Projektarchivs: c6d672ea-8702-0410-b560-f74c916a59fe
Revision: 2137
Knotentyp: Verzeichnis
Plan: normal
Letzter Autor: rpm
Letzte ge=E4nderte Rev: 2137
Letztes =C4nderungsdatum: 2007-02-07 12:13:48 +0100 (Mi, 07 Feb 2007)
Eigenschaften zuletzt ge=E4ndert: 2007-01-22 13:20:30 +0100 (Mo, 22 Jan 200=
7)


the following code leads to the crash, shortly after entering main():
--------------------------------------------------------------------
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


