Message-ID: <1165859722.457d9b8a9b097@domain.hid>
Date: Mon, 11 Dec 2006 18:55:22 +0100
From: barbalace@domain.hid
Subject: Re: [Xenomai-help] Re: [Adeos-main] [PATCH] ppc mvme5500
References: <1165537720.4578b1b879da9@domain.hid>
	<45795320.5060806@domain.hid>
	<1165595720.45799448b0adc@domain.hid>
	<4579CD41.6060102@domain.hid>
	<1165665886.457aa65e2c26e@domain.hid>
	<457AAEB9.20403@domain.hid>
	<1165834501.457d390514d36@domain.hid>
	<457D57B4.3000802@domain.hid>
	<1165843368.457d5ba8692bd@domain.hid>
	<457D609F.8030301@domain.hid> <457D6BF1.1040507@domain.hid>
In-Reply-To: <457D6BF1.1040507@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
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
Cc: xenomai-help <xenomai@xenomai.org>, adeos-main@gna.org

Quoting Jan Kiszka <jan.kiszka@domain.hid>:
> Antonio, please use a recent Xenomai version (e.g. 2.2.5) to avoid that
> we may hunt old issues.
 Ok, could be the right solution.

> Next post a simple demo code to xenomai-help,
> showing the misbehaviour. We could then check if other archs are
> involved, if it's reproducible on further PPC boards, or if some mistak=
e
> might have slipped into the code.
> From your description I wonder if you lock the mutex in line 2 from the
> correct context (a Xenomai thread). If you call that lock from main,
> don't forget to invoke rt_task_shadow first.

A simplified version of the code (in the original code there is an hw DAQ=
 and I
understand that the same code run 2-times, here one could use a buffer to=
 write
for example a u(->for unlocking) and a l(->for locking) ):

/* -- START CODE HERE ---------- demo.c ---------------------------------=
-----*/
#include <linux/config.h>
#include <linux/version.h>
#include <linux/module.h>
#include <linux/moduleparam.h>

#include <native/task.h>
#include <native/intr.h>
#include <native/mutex.h>
#include <native/sem.h>


#define TASK_PRIO 99
#define TASK_MODE (T_FPU | T_CPU(0))
#define TASK_STKSZ 4096

RT_INTR intr_desc;
RT_TASK task_desc;
RT_MUTEX mutex_desc;

int demo_finalize;

#define INTR_IRQ 76

static irqreturn_t demo_irqhandler(void)
{
        rt_mutex_unlock(&mutex_desc);                        // IPC handl=
ing

        return RT_INTR_HANDLED;
}



void rt_handler(void *data){

        printk(KERN_ERR"entered in RT task\n");                // ok I kn=
ow is
not right use printk
        rt_mutex_lock(&mutex_desc, TM_INFINITE);

        for(;;){
                rt_mutex_lock(&mutex_desc, TM_INFINITE);

                if(demo_finalize =3D=3D 1)
                        break;
                /* doing something */
        }

        return;
}

static int demo_init(void)
{
        int result;
        // initialize MUTEX
        int err;
        err =3D rt_mutex_create(&mutex_desc, "demo_mutex");
        printk(KERN_ERR"mutex created and locked\n");

        demo_finalize =3D 0;

        // create the real-time task waiting for data
        err =3D rt_task_create(&task_desc, "demo_acq", TASK_STKSZ, TASK_P=
RIO,
TASK_MODE);
        if (!err) {
                rt_task_start(&task_desc, &rt_handler, NULL);
                printk(KERN_ERR"RT task started!\n");
        } else
                printk(KERN_ERR"can't start RT thread!!!\n");

        result =3D rt_intr_create(&intr_desc, "demo_intr", INTR_IRQ,
demo_irqhandler, 0,
0);

        return (0);
}

static void demo_exit(void)
{
        rt_intr_delete(&intr_desc);

        demo_finalize =3D 1;
        rt_mutex_unlock(&mutex_desc);


        rt_task_delete(&task_desc);
        printk(KERN_ERR"demo: RT task destroyed\n");

        return;
}

module_init(demo_init);
module_exit(demo_exit);

/* --- END CODE HERE ----------------------------------------------------=
-----*/

With this code and Xenomai 2.2.0 you lose the machine control... I resolv=
e this
using semaphores.

regards,
Antonio

PS. excuse me, was my error... replay to all, ok! Thanks!

