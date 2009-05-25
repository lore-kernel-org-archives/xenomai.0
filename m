MIME-Version: 1.0
Date: Mon, 25 May 2009 15:01:25 +0530
Message-ID: <200905251501.25400.shashank.bhatia@domain.hid>
From: Shashank Bhatia <shashank.bhatia@domain.hid>
content-type: text/plain; charset=iso-8859-1
content-transfer-encoding: quoted-printable
content-disposition: inline
Subject: [Xenomai-help] RT Task as a kernel module halts the whole system
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

Dear All,

=A0 =A0 =A0 =A0 =A0 =A0 I wrote a simple RT task to be run as kernel module=
 and tried to=20
run it. As soon as i issue the insmod command, it halts the whole system.
Please help me out,

The code is as follows:

#include <linux/module.h> =A0 // required by all modules
#include <linux/kernel.h> =A0 // required by printk()
#include <linux/init.h>
#include <posix/sys/mman.h>
#include <native/task.h>
#include <native/alarm.h>

#define TASK_PRI =A050
#define TASK_MODE T_FPU|T_CPU(0)
#define STAK_SIZE 4096


#define ALARM_VAL 500000
#define ALRAM_INT 25000000

RT_ALARM alarm;
RT_TASK =A0alarm_handler;
int err;


void alarm_hand_func(void *cookie)
{

=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0if(!err)
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0{
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0// =
do the periodic task
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0}
}


MODULE_LICENSE("GPL");
MODULE_AUTHOR("Shashank");

// Start/Init function
static int hello_init(void) {

=A0 =A0 =A0 =A0 printk(KERN_ALERT "Hello world!\n"); =A0// A logging mechan=
ism for=20
kernel

=A0=A0=A0=A0=A0=A0=A0=A0err =3D rt_alarm_create(&alarm,"myAlarm");

=A0=A0=A0=A0=A0=A0=A0=A0err =3D rt_alarm_start(&alarm,ALARM_VAL,ALARM_INT);

err=3Drt_task_create(&alarm_handler, "ALARMtask",STAK_SIZE,TASK_PRI,TASK_MO=
DE);

=A0=A0=A0=A0=A0=A0=A0=A0if(!err)
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0rt_task_start(&alarm_handle=
r,&alarm_hand_func,NULL);

=A0 =A0 =A0 =A0 return 0; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 // A non-zero return means=20
hello_init failed; the module can't be loaded.
}

// End/Cleanup function
static void hello_exit(void) {

=A0=A0=A0=A0=A0=A0=A0=A0//rt_task_delete(&alarm_handler);

=A0=A0=A0=A0=A0=A0=A0=A0rt_alarm_delete(&alarm);

=A0 =A0 =A0 =A0 printk(KERN_ALERT "Goodbye world!\n");
}

module_init(hello_init);
module_exit(hello_exit);

-------------------------------------
Hi-Tech Gears Limited, Gurgaon, India





