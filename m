From: ayaida marwane <ayaida_marwane@yahoo.fr>
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.60.0.2.5\))
Subject: RTDM Printk do not work on rtdm_timer_handler_t 
Message-Id: <D5DEC4F7-7609-4B43-9DF7-BEBFEEFB1AC1@yahoo.fr>
Date: Mon, 18 May 2020 11:27:31 +0200
References: <D5DEC4F7-7609-4B43-9DF7-BEBFEEFB1AC1.ref@yahoo.fr>
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Dear all,

I have tried this code :

=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=
=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=
=94=E2=80=94=E2=80=94=E2=80=94

#include <rtdm/driver.h>

static int periode_us =3D 1000;
module_param(periode_us, int, 0644);

static void timer_task(rtdm_timer_t *);
static rtdm_timer_t rtimer;

static int __init init_oscillateur (void)
{
        int err;

        rtdm_printk(KERN_INFO "%s.%s() : Initialisation\n", =
THIS_MODULE->name, __FUNCTION__);

        if ((err =3D rtdm_timer_init(& rtimer, timer_task, =
"Timer_Task")) !=3D 0) {
                return err;
        }

        if ((err =3D rtdm_timer_start(& rtimer, periode_us*1000, =
periode_us*1000, RTDM_TIMERMODE_RELATIVE)) !=3D 0) {
                rtdm_timer_destroy(& rtimer);
                return err;
        }

        return 0;
}

static void __exit exit_oscillateur (void)
{
        rtdm_timer_stop(& rtimer);
        rtdm_timer_destroy(& rtimer);
        rtdm_printk(KERN_INFO "%s.%s() : Exit\n", THIS_MODULE->name, =
__FUNCTION__);
}

static void timer_task(rtdm_timer_t * unused)
{
        rtdm_printk(KERN_INFO "%s.%s() : Appel Timer\n", =
THIS_MODULE->name, __FUNCTION__);
}

module_init(init_oscillateur);
module_exit(exit_oscillateur);
MODULE_LICENSE("GPL");


=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=
=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=
=94=E2=80=94=E2=80=94=E2=80=94

However, when I execute the code, we have only :

[ 6696.615556] oscillateur_gpio_rtdm.init_oscillateur() : Initialisation
[ 6705.148129] oscillateur_gpio_rtdm.exit_oscillateur() : Exit

So, why the rtdm_printk in the timer_task is never called?

Thanks for your help.

BR,
Marwane.



