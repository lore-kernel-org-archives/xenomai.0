From: "Heinick, J Michael" <Michael.Heinick@Honeywell.com>
Date: Mon, 11 Jan 2016 14:33:58 +0000
Message-ID: <D9EDB4F689BF9F4EA6F2158A073942732E7C9E64@de08ex3008.global.ds.honeywell.com>
Content-Language: en-US
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] Test program not accessing RTDM driver
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>


.........1.........2.........3.........4.........5.........6.........7....|

Currently, I have a RTDM driver that installs with insmod, creates the
node in /dev/rtdm, uninstalls with rmmod, and removes the node from
/dev/rtdm.  At this early stage this RTDM driver is only a skeleton that
should log a message with rtdm_printk whenever the open, close, read,
write, and ioctl handlers are called. So far I have been unable to get
any indication that any of the handlers I have written for the driver are
interacting with the small test program even though the program appears to
run without errors.

The ioctl call in the test program generates the following message in the
dmesg file:

[12503.672657] [Xenomai] tcgrtdmtest[3595] called regular ioctl() on /dev/r=
tdm/tcgrtdm

The example at http://git.xenomai.org/xenomai-jro.git/tree/demo/posix/cobal=
t/gpiopwm.c?h=3D410c
recently suggested by Jorge Ramirez Ortiz has been somewhat helpful, but
I still do not know what I am missing.  Are my rtdm_device and
rtdm_driver structures correct enough to get the handlers called, or is the
problem elsewhere?

Thanks for any help that you can provide.
Mike H.

Additional details on our situation are included below:

The code: vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
// ------------- tcgrtdmtest.c -----------
#include <xenomai/init.h>
#include <rtdm/rtdm.h>
#include <stdlib.h>
#include <errno.h>
#include <error.h>
#include <stdio.h>

int main()
  {
  int fd;
  unsigned int rply;
  rply =3D 987; // =3D0x3DB
  fd =3D open("/dev/rtdm/tcgrtdm",O_RDWR);
  perror("Open error: ");
  ioctl(fd,0x55,&rply);
  printf("reply =3D 0x%X\n",rply); // reply =3D 0xAB would be good
  close(fd);
  return 0;
  }


The makefile: vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
XENO_CONFIG :=3D /usr/xenomai/bin/xeno-config
CFLAGS :=3D $(shell $(XENO_CONFIG) --posix --cflags)
LDLAGS :=3D $(shell $(XENO_CONFIG) --posix --ldflags)
CC :=3D $(shell $(XENO_CONFIG) --cc)

default:
        $(CC) -o tcgrtdmtest tcgrtdmtest.C $(CFLAGS) $(LDFLAGS)

The test program make result: vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
$ make
gcc -o tcgrtdmtest tcgrtdmtest.C -I/usr/xenomai/include/cobalt -I/usr/xenom=
ai/include -D_GNU_SOURCE -D_REENTRANT -D__COBALT__ -D__COBALT_WRAP__
$

Output from test program vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
(Note: The 987 (0x3DB) sent to the driver by the test ptogram should
be changed to 0xAB and returned by the driver in the ioctl call, but
that is not happening.)
Open error: : Success
reply =3D 0x3DB


The driver: vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
// ------------------- tcgbc635rt.c ---------------------------
#include <rtdm/rtdm.h>
#include <rtdm/driver.h>

MODULE_LICENSE("GPL");
MODULE_AUTHOR("Michael Heinick");
MODULE_DESCRIPTION("RTDM Interface to BC635 TCG card");

int __init tcgrt_init(void);

void __exit tcgrt_exit(void);
static int tcgrtdmopen(struct rtdm_fd *fd, int oflags)
  {
  int status;
  printk(KERN_CRIT"TCG RTDM open:.\n");
  rtdm_printk(KERN_CRIT"TCG RTDM open:.\n");
  status =3D 0;
  return status;
  }

static void tcgrtdmclose(struct rtdm_fd *fd)
  {
  int status;
  printk("TCG RTDM close:.\n");
  rtdm_printk("TCG RTDM close:.\n");
  status =3D  0;
  return;
  }

static int tcgrtdmioctl(struct rtdm_fd *fd, unsigned int request,void __use=
r *arg)
  {
  unsigned int rply;
  printk("TCG RTDM ioctl: 0x%X\n",request);
  if(!rtdm_rw_user_ok(fd,arg,sizeof(rply))) { return -EFAULT; }
  rtdm_copy_from_user(fd,&rply,arg,sizeof(rply));
  rtdm_printk("TCG RTDM ioctl: 0x%X arg =3D 0x%X\n",request,rply);
  rply =3D 0xAB; //Change rply to 0xAB for return to test application
  rtdm_copy_to_user(fd, arg, &rply, sizeof(rply));
  return request;
  }

static ssize_t tcgrtdmread(struct rtdm_fd *fd, void __user *buf, size_t siz=
e)
  {
  rtdm_printk("TCG RTDM read:.\n");
  size =3D 124;
  return size;
  }

static ssize_t tcgrtdmwrite(struct rtdm_fd *fd, const void __user *buf, siz=
e_t size)
  {
  rtdm_printk("TCG RTDM write:.\n");
  return size;
  }

static struct rtdm_driver driver =3D {
  .profile_info =3D RTDM_PROFILE_INFO(tcgrtdm,RTDM_CLASS_SERIAL,0,3),
  .device_flags =3D RTDM_NAMED_DEVICE | RTDM_EXCLUSIVE,
  .device_count =3D 1,
  .ops =3D {
    .open =3D tcgrtdmopen,
    .close =3D tcgrtdmclose,
    .read_nrt =3D tcgrtdmread,
    .write_nrt =3D tcgrtdmwrite,
    .ioctl_nrt =3D tcgrtdmioctl,
    },
  };
static struct rtdm_device device =3D {
  .driver =3D &driver,
  .label =3D "tcgrtdm"
  };

int __init tcgrt_init(void)
  {
  int status;
  rtdm_printk("TCG RTDM Driver Init.\n");
  status =3D rtdm_dev_register(&device);
  if(status =3D=3D 0)
    {
    rtdm_printk("TCG RTDM Driver Registration succeeded.\n");
    }
  else
    {
    switch(status)
     {
      case -EINVAL:
        rtdm_printk("Registration: Invalid entries in device structure\n");
        break;
      case -EEXIST:
        rtdm_printk("Registration: Device name of Protocol ID already in us=
e\n");
        break;
      case -ENOMEM:
        rtdm_printk("Registration: Memory allocation failed\n");
        break;
      default:
        rtdm_printk("Registration: Unknown error\n");
        break;
      } // End of status switch
    } // End of status not 0
  return status;
  }

void __exit tcgrt_exit(void)
  {
  rtdm_printk("Unregistration: Exiting TCG RTDM Driver\n");
  rtdm_dev_unregister(&device);
  }

#ifdef MODULE
module_init(tcgrt_init);
#endif
module_exit(tcgrt_exit);

The driver makefile: vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
KDIR :=3D /lib/modules/$(shell uname -r)/build
PWD :=3D $(shell pwd)
XENO_CONFIG :=3D /usr/xenomai/bin/xeno-config
$(eval ccflags-y =3D $(shell $(XENO_CONFIG) --rtdm --cflags))
obj-m +=3D tcgbc635rt.o

default:
       $(MAKE) -C $(KDIR) M=3D$(PWD) tcgbc635rt.ko

The driver make result: vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
make -C /lib/modules/3.14.44-xeno02/build M=3D/home/guts/mike/tcg/rtdmdrvr =
tcgbc635rt.ko
make[1]: Entering directory `/home/guts/mike/xeno/linux-3.14.44'
  CC [M]  /home/guts/mike/tcg/rtdmdrvr/tcgbc635rt.o
  MODPOST 1 modules
  CC      /home/guts/mike/tcg/rtdmdrvr/tcgbc635rt.mod.o
  LD [M]  /home/guts/mike/tcg/rtdmdrvr/tcgbc635rt.ko
make[1]: Leaving directory `/home/guts/mike/xeno/linux-3.14.44'


Return from /usr/xenomai/bin/xeno-config --info vvvvvvvvvvvvvvvvvvvvvvvvvv
$ /usr/xenomai/bin/xeno-config --info
Xenomai version: Xenomai/cobalt v3.0.1
Linux htsi-linux 3.14.44-xeno02 #1 SMP PREEMPT Fri Nov 13 09:35:37 EST 2015=
 x86_64 x86_64 x86_64 GNU/Linux
Kernel parameters: BOOT_IMAGE=3D/vmlinuz-3.14.44-xeno02 root=3DUUID=3Def5da=
f08-36a0-46b3-9ed4-4917b36301cf ro nomodeset quiet splash
I-pipe release #10 detected
Cobalt core 3.0.1 detected
Compiler: gcc version 4.8.2 (Ubuntu 4.8.2-19ubuntu1)
Build args: --with-core=3Dcobalt --enable-smp --enable-pshared --host=3Di68=
6-linux host_alias=3Di686-linux
$

