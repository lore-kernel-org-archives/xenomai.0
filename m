MIME-Version: 1.0
Sender: had2006@gmail.com
In-Reply-To: <CABqyFP-2R-r_OWHs7zgLLKEUjBfL1amuOteAEKNKBVye-E6Xmg@mail.gmail.com>
References: <553232db.8404460a.6101.538c@mx.google.com>
 <CAKk99t1NdbeEWeB9hTztoZyDS7XDFzHeDRjMypfURLVkLqENkA@mail.gmail.com>
 <CABqyFP-2R-r_OWHs7zgLLKEUjBfL1amuOteAEKNKBVye-E6Xmg@mail.gmail.com>
Date: Mon, 20 Apr 2015 13:20:19 +0100
Message-ID: <CAKk99t0ZbCUYJp-V1HEczY5T+ddeLXrfm3-_5SjofKf2gcM-5g@mail.gmail.com>
From: Helder Daniel <hdaniel@ualg.pt>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] Error: could not insert module kernel-task.ko:
 Unknown symbol in module
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Ruika You <crazylinuxcnc@gmail.com>
Cc: "Xenomai@xenomai.org" <xenomai@xenomai.org>

Hi,

The warnings about =E2=80=98rt_task_spawn=E2=80=99, =E2=80=98rt_task_create=
=E2=80=99, etc., ... is
deprecated
are giving you an hint that the native API will not be supported in version
3.x.

You can change this function rt_xxxxxx to similar functions from the RTDM
API (rtdm_xxxx) which is supported in version 2.6.x and 3.x.

Below is an example of a simple RTDM module for Xenomai 2.5.x and 2.6.x.
For Xenomai 3.x is a liittle different the location of the headers for
RTDM, and also we must take care to terminate a thread that is killed with
rtdm_task_destroy(). I also included the Xenomai 3.x example if you are
willing to take a look.

regards,

Helder

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Xeno 2.6.x version
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

#include <linux/kernel.h>
#include <linux/module.h>
#include <linux/moduleparam.h>
#include <rtdm_driver.h>  //RTDM support includes also: <rtdm.h>

#define TASK_PRIO 10 // 99 is Highest RT priority
#define TASK_MODE 0 // No flags
#define TASK_STKSZ 0 // default Stack size

#define TASK_PERIOD 500000000ll // in nano seconds =3D 500 ms

static rtdm_task_t td;    //RTDM Real time task pointer

void periodic (void *arg) {
   for (;;) {
  rtdm_task_wait_period(); //deschedule until next period
      printk(KERN_ALERT "Hi there!");
   }
}


int init_module(void) {
   return rtdm_task_init (&td, "periodic", &periodic, NULL, TASK_PRIO,
TASK_PERIOD);
}

void cleanup_module(void) {
rtdm_task_destroy(&td);
}

MODULE_LICENSE("GPL");  //To access Xenoma symbols


=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Xeno 3.x version
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
#include <linux/kernel.h>
#include <linux/module.h>
#include <linux/moduleparam.h>
#include <rtdm/driver.h>  //defines: rtdm_task_t, rtdm_sem_t, ... (also
includes rtdm.h)

#define TASK_PRIO 10 // 99 is Highest RT priority
#define TASK_MODE 0 // No flags
#define TASK_STKSZ 0 // default Stack size

#define TASK_PERIOD 500000000ll // in nano seconds =3D 500 ms

static rtdm_task_t td;    //RTDM Real time task pointer

void periodic (void *arg) {
for (;;) {
if (rtdm_task_should_stop()) //to avoid kernel crash when rmmod and
break; //rtdm_task_destroy is called, this
//function should exit
rtdm_task_wait_period(); //deschedule until next period

printk(KERN_ALERT "Hi there!");
}
}


int init_module(void) {
   return rtdm_task_init (&td, "periodic", &periodic, NULL, TASK_PRIO,
TASK_PERIOD);
}

void cleanup_module(void) {
rtdm_task_destroy(&td);
}

MODULE_LICENSE("GPL");  //To access Xenoma symbols





On 20 April 2015 at 12:23, Ruika You <crazylinuxcnc@gmail.com> wrote:

> Dear Helder Daniel,
>
> Thanks for your guide, I solve this issue.
>
> MODULES        =3Dhello
> PWD          :=3D $(shell if [ "$$PWD" !=3D "" ]; then echo $$PWD; else p=
wd;
> fi)
> KSRC         ?=3D /lib/modules/$(shell uname -r)/build
> obj-m         +=3D ${patsubst %, %.o, $(MODULES)}
>
> #comment this line change to your proposal
> #EXTRA_CFLAGS    =3D -I$(KSRC)/include/xenomai -D_GNU_SOURCE -D_REENTRANT
> -D__XENO__
>
> EXTRA_CFLAGS:=3D$(shell /usr/xenomai/bin/xeno-config --skin native --cfla=
gs)
> all:
>     make -C $(KSRC) M=3D$(PWD) modules
> clean::
>     $(RM) $(CLEANMOD) *.o *.ko *.mod.c Module*.symvers Module.markers
> modules.order
>     $(RM) -R .tmp*
>
> make -C /lib/modules/3.14.0/build M=3D/home/edm/test/hello modules
> make[1]: Entering directory `/home/edm/linuxcnc/linux-kernel'
>   CC [M]  /home/edm/test/hello/hello.o
> In file included from /home/edm/test/hello/hello.c:4:0:
> /usr/xenomai/include/native/task.h: In function =E2=80=98rt_task_spawn=E2=
=80=99:
> /usr/xenomai/include/native/task.h:319:5: warning: =E2=80=98rt_task_creat=
e=E2=80=99 is
> deprecated (declared at /usr/xenomai/include/native/task.h:252)
> [-Wdeprecated-declarations]
> /home/edm/test/hello/hello.c: In function =E2=80=98init_module=E2=80=99:
> /home/edm/test/hello/hello.c:24:1: warning: =E2=80=98rt_task_create=E2=80=
=99 is deprecated
> (declared at /usr/xenomai/include/native/task.h:252)
> [-Wdeprecated-declarations]
>   Building modules, stage 2.
>   MODPOST 1 modules
>   CC      /home/edm/test/hello/hello.mod.o
>   LD [M]  /home/edm/test/hello/hello.ko
> make[1]: Leaving directory `/home/edm/linuxcnc/linux-kernel'
>
> By the way, I am wondering are there warning OK?
>
> -chengxi
>
>


--=20
Helder Daniel
UALG - FCT
DEEI

http://w3.ualg.pt/~hdaniel
