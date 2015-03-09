MIME-Version: 1.0
Sender: had2006@gmail.com
In-Reply-To: <CAKk99t3FfAff0X0nGzKD+YcVFQWm5aeSRFB4U6No1YSPuS_qpA@mail.gmail.com>
References: <CAKk99t3_phHv3kUfCZcwr2bqTys3JPL3iaWACLjP+f1yoD_Nag@mail.gmail.com>
 <54F97594.2060605@xenomai.org>
 <CAKk99t1AGHj8sOf7Vgy_UZ_+rECP5Vx22cyup--FHsh=RuK2zA@mail.gmail.com>
 <54F97E05.8010107@xenomai.org>
 <CAKk99t3FfAff0X0nGzKD+YcVFQWm5aeSRFB4U6No1YSPuS_qpA@mail.gmail.com>
Date: Mon, 9 Mar 2015 18:57:40 +0000
Message-ID: <CAKk99t03p_Pc41meo_zzZ0V6X_vjHZRWBeO1aNb+DM2c38pNTg@mail.gmail.com>
From: Helder Daniel <hdaniel@ualg.pt>
Content-Type: text/plain; charset=UTF-8
Subject: [Xenomai] Fwd: Error boilerplate/wrappers.h no found trying to
 compile RTDM module on 3.x-rc3 cobalt
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Xenomai@xenomai.org" <xenomai@xenomai.org>

Hi again,

I am sorry to ask help again about this point but I still am no able to
compile a kernel module with Xenomai 3.x support.

I made the changes pointed in the previous email:
In the module is now being included just:

<rtdm/driver.h>

and the makefile is now:

EXTRA_CFLAGS := $(shell xeno-config --kcflags)
all:

make -C /lib/modules/$(shell uname -r)/build M=$(PWD) modules


but it did not work. The error make issued was:

In file included from include/xenomai/cobalt/kernel/sched.h:24:0,
                 from include/xenomai/rtdm/driver.h:36,
                 from /root/prg/01-rtdm_interrupt/ps2auxint.c:4:
include/xenomai/cobalt/kernel/thread.h:32:33: fatal error:
asm/xenomai/machine.h: No such file or directory


Then I ran xeno-config --kcflags in the cmd line and it returned:

-Iarch/$(SRCARCH)/xenomai/include -Iinclude/xenomai


So I tried to explicitly add it to the Makefile (according to my kernel):

EXTRA_CFLAGS := -I/usr/src/linux-headers-3.16.0-ipipe/include/xenomai
-Iinclude/xenomai


Make returned asimilar error:

In file included from
/usr/src/linux-headers-3.16.0-ipipe/include/xenomai/cobalt/kernel/sched.h:24:0,
                 from
/usr/src/linux-headers-3.16.0-ipipe/include/xenomai/rtdm/driver.h:36,
                 from /root/prg/01-rtdm_interrupt/ps2auxint.c:4:
/usr/src/linux-headers-3.16.0-ipipe/include/xenomai/cobalt/kernel/thread.h:32:33:
fatal error: asm/xenomai/machine.h: No such file or directory


I am not sure what I am missing. Another header?
The wrong path to Xenomai headers?

My Xenomai install is cobalt on kernel 3.16.

$> uname -r
3.16.0-ipipe

$> /usr/xenomai/sbin/version -a
Xenomai/cobalt v3.0-rc3 --
Target: x86_64-unknown-linux-gnu
Compiler: gcc version 4.7.2 (Debian 4.7.2-5)
Build args:  '--with-core=cobalt' '--enable-registry' '--enable-smp'
'--enable-pshared' '--prefix=/usr/xenomai'


On 6 March 2015 at 10:14, Philippe Gerum <rpm@xenomai.org> wrote:

> On 03/06/2015 11:03 AM, Helder Daniel wrote:
> > On 6 March 2015 at 09:38, Philippe Gerum <rpm@xenomai.org
> > <mailto:rpm@xenomai.org>> wrote:
> >
> >     >
> >     > obj-m += intr.o
> >     >
> >     > EXTRA_CFLAGS := -I/usr/xenomai/include -I/usr/include
> >
> >     This is wrong, you are pulling userland headers. The CFLAGS required
> to
> >     build a kernel module using the RTDM API should be obtained by:
> >
> >     $(shell xeno-config --kcflags)
> >
> >
> > Ok I was suspecting that (even makefile worked with 2.5) .
> > I tried:
> >
> > EXTRA_CFLAGS := $(shell xeno-config --kcflags)
> >
> > but now it can not find rtdm.h:
> >
>
> rtdm.h provides the RTDM API definitions to userland applications. You
> want rtdm/driver.h for building a module implementing a RTDM driver.
>
> > /root/prg/01-rtdm_interrupt/intr.c:2:18: fatal error: rtdm.h: No such
> > file or directory
> >
> > Whether It is included as <rtdm/rtdm.h>
> > or just <rtdm.h>
> >
> > I run the command in a shell and the output is:
> >
> > root@debian:~/prg/01-rtdm_interrupt# xeno-config --kcflags
> >
> > -Iarch/$(SRCARCH)/xenomai/include -Iinclude/xenomai
> >
> > However complete output of make, tells SRCARCH not found:
> >
> > $> make
> > make -C /lib/modules/3.18.7-rt2/build M=/root/prg/01-rtdm_interrupt
> modules
> > make[1]: Entering directory `/usr/src/linux-headers-3.18.7-rt2'
> >   CC [M]  /root/prg/01-rtdm_interrupt/intr.o
> > /bin/sh: 1: SRCARCH: not found
> > /root/prg/01-rtdm_interrupt/intr.c:2:18: fatal error: rtdm.h: No such
> > file or directory
> > compilation terminated.
> > make[2]: *** [/root/prg/01-rtdm_interrupt/intr.o] Error 1
> > make[1]: *** [_module_/root/prg/01-rtdm_interrupt] Error 2
> > make[1]: Leaving directory `/usr/src/linux-headers-3.18.7-rt2'
> > make: *** [all] Error 2
> >
>
> SRCARCH is defined by the standard Kbuild infrastructure, this is not a
> Xenomai-specific variable. You may want to look at
> xenomai3/kernel/drivers/ipc/Makefile for an illustration of its usage.
>
> --
> Philippe.
>



-- 
Helder Daniel
UALG - FCT
DEEI

http://w3.ualg.pt/~hdaniel



-- 
Helder Daniel
UALG - FCT
DEEI

http://w3.ualg.pt/~hdaniel
