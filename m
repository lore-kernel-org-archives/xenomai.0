MIME-Version: 1.0
Date: Thu, 31 Mar 2016 20:35:38 +0300
Message-ID: <CAOLO655T6eQxwCq6swn2M-ruzaLvCpm9NKZNYiyKe-oUNj=89Q@mail.gmail.com>
From: =?UTF-8?Q?Ahmet_Soyyi=C4=9Fit?= <ahmedius2@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] No rtdm device is created with multiple source files,
	kernel module
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hello,

I am trying to write a rtdm kernel module for raspberyy pi B+ which creates
a device named rtdm-blink01. The operation succeeds with no problem, the
device rtdm-blink01 is created under /proc/xenomai/rtdm for single source
file with this makefile  (my module is ioctl added version of
tut01-skeleton-drv  rtdm driver in xenomai examples).

### List of modules to be build
MODULES =3D rtdm_blink

###### KERNEL MODULE BUILD (no change required normally) ######
### Default to sources of currently running kernel
KSRC ?=3D /lib/modules/$(shell uname -r)/build

OBJS     :=3D ${patsubst %, %.o, $(MODULES)}
CLEANMOD :=3D ${patsubst %, .%*, $(MODULES)}
PWD      :=3D $(shell if [ "$$PWD" !=3D "" ]; then echo $$PWD; else pwd; fi=
)

obj-m        :=3D $(OBJS)
#rtdm_blink-y :=3D bcm2835.o
ccflags-y    :=3D -I$(KSRC)/include/xenomai -I$(KSRC)/include/xenomai/posix
$(ADD_CFLAGS)

all::
$(MAKE) -C $(KSRC) M=3D$(PWD) modules

clean::
$(RM) $(CLEANMOD) *.o *.ko *.mod.c Module*.symvers Module.markers
modules.order
$(RM) -R .tmp*

 I can reach the device from a RT task and can do open read write and close
operations. But when I uncomment the line #rtdm_blink-y :=3D bcm2835.o and
compile again with bcm.2835.c the compilation succeeds with no problem but
when I insmod the module no device appears under /proc/xenomai/rtdm and
anything printed with rtdm_printk and prink does not show in dmesg. I do
not call anything from bcm2835.c file, I just link it to my module and
these happens. What happens when I link this file, why are these happening
? Thanks for your help.

Ahmet Soyyi=C4=9Fit
Gebze Technical University - TURKEY
Computer Engineering Department
