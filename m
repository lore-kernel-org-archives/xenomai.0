Message-ID: <50A188A3.90704@gmail.com>
Date: Mon, 12 Nov 2012 20:39:15 -0300
From: Sebastian Pavez <sebastian.pavez.t@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"; Format="flowed"
Subject: [Xenomai] module.h error
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai <xenomai@xenomai.org>

Hi everybody!

I have xenomai-2.6.1 with kernel 3.2.32 over an i7.
I'm trying to compile the attached files, but with make I get this message:

cc -I/lib/modules/3.2.32/build/include/xenomai =

-I/lib/modules/3.2.32/build/include/xenomai/compat
-I/lib/modules/3.2.32/build/include/xenomai/posix     -c -o sinus.o sinus.c
sinus.c:2:26: fatal error: linux/module.h: No such file or directory
compilation terminated.
make: *** [sinus.o] Error 1

How could I fix this?? This mean that I have some problems with =

xenomai's installation?? or did I overlook something??

Thank you for your time and disposition
Seba
-------------- next part --------------
###### CONFIGURATION ######

### List of applications to be build
APPLICATIONS =3D  =


### Note: to override the search path for the xeno-config script, use "make=
 XENO=3D..."


### List of modules to be build
MODULES =3D sinus  =


### Note: to override the kernel source path, use "make KSRC=3D..."



###### USER SPACE BUILD (no change required normally) ######
ifeq ($(KERNELRELEASE),)
ifneq ($(APPLICATIONS),)

### Default Xenomai installation path
XENO ?=3D /usr/xenomai

XENOCONFIG=3D$(shell PATH=3D$(XENO):$(XENO)/bin:$(PATH) which xeno-config 2=
>/dev/null)

### Sanity check
ifeq ($(XENOCONFIG),)
all::
	@echo ">>> Invoke make like this: \"make XENO=3D/path/to/xeno-config\" <<<"
	@echo
endif


CC=3D$(shell $(XENOCONFIG) --cc)

CPPFLAGS=3D$(shell $(XENOCONFIG) --xeno-cflags) $(MY_CFLAGS)

LOADLIBES=3D$(shell $(XENOCONFIG) --xeno-ldflags) $(MY_LDFLAGS) -lnative -l=
rtdm

# This includes the library path of given Xenomai into the binary to make l=
ive
# easier for beginners if Xenomai's libs are not in any default search path.
LOADLIBES+=3D-Xlinker -rpath -Xlinker $(shell $(XENOCONFIG) --libdir)

all:: $(APPLICATIONS)

clean::
	$(RM) $(APPLICATIONS) *.o

endif
endif



###### KERNEL MODULE BUILD (no change required normally) ######
ifneq ($(MODULES),)

### Default to sources of currently running kernel
KSRC ?=3D /lib/modules/$(shell uname -r)/build

OBJS     :=3D ${patsubst %, %.o, $(MODULES)}
CLEANMOD :=3D ${patsubst %, .%*, $(MODULES)}
PWD      :=3D $(shell if [ "$$PWD" !=3D "" ]; then echo $$PWD; else pwd; fi)

### Kernel 2.6
ifeq ($(findstring 2.6,$(KSRC)),2.6)

obj-m        :=3D $(OBJS)
EXTRA_CFLAGS :=3D -I$(KSRC)/include/xenomai -I$(KSRC)/include/xenomai/posix=
 $(ADD_CFLAGS)

all::
	$(MAKE) -C $(KSRC) SUBDIRS=3D$(PWD) modules

### Kernel 2.4
else

ARCH    ?=3D $(shell uname -i)
INCLUDE :=3D -I$(KSRC)/include/xenomai -I$(KSRC)/include/xenomai/compat -I$=
(KSRC)/include/xenomai/posix
CFLAGS  +=3D $(shell $(MAKE) -s -C $(KSRC) CC=3D$(CC) ARCH=3D$(ARCH) SUBDIR=
S=3D$(PWD) modules) $(INCLUDE)

all:: $(OBJS)

endif

## Target for capturing 2.4 module CFLAGS
modules:
	@echo "$(CFLAGS)"

clean::
	$(RM) $(CLEANMOD) *.o *.ko *.mod.c Module*.symvers Module.markers modules.=
order
	$(RM) -R .tmp*

endif
-------------- next part --------------
#ifndef REG_PCI1711_h

#define REG_PCI1711_h

#define PCI171x_AD_DATA  0              /* R:   A/D data */
#define PCI171x_SOFTTRG  0              /* W:   soft trigger for A/D */
#define PCI171x_RANGE    2              /* W:   A/D gain/range register */
#define PCI171x_MUX_sta  4              /* W:   A/D multiplexor control */
#define PCI171x_MUX_sto  5              /* W:   A/D multiplexor control */


#define PCI171x_STATUS   7              /* R:   status register */
#define PCI171x_CONTROL  6              /* W:   control register */
#define PCI171x_CLRINT   8              /* W:   clear interrupts request */
#define PCI171x_CLRFIFO  9              /* W:   clear FIFO */
#define PCI171x_DA0     10              /* W:   D/A register */
#define PCI171x_DA1     12              /* W:   D/A register */
#define PCI171x_DAREF   14              /* W:   D/A reference control */
#define PCI171x_DI      16              /* R:   digi inputs */
#define PCI171x_DO      16              /* R:   digi inputs */
#define PCI171x_CNT0    24              /* R/W: 8254 couter 0 */
#define PCI171x_CNT1    26              /* R/W: 8254 couter 1 */
#define PCI171x_CNT2    28              /* R/W: 8254 couter 2 */
#define PCI171x_CNTCTRL 30              /* W:   8254 counter control */

// upper bits from status register (PCI171x_STATUS) (lower is same woth con=
trol reg)
#define Status_FE       0x01          /* 1=3DFIFO is empty */
#define Status_FH       0x02          /* 1=3DFIFO is half full */
#define Status_FF       0x04          /* 1=3DFIFO is full, fatal error */
#define Status_IRQ      0x08          /* 1=3DIRQ occured */
// bits from control register (PCI171x_CONTROL)


#define Control_CNT0    0x0040          /* 1=3DCNT0 have external source, 0=
=3Dhave internal 100kHz source */
#define Control_ONEFH   0x0020          /* 1=3DIRQ on FIFO is half full, 0=
=3Devery sample */
#define Control_IRQEN   0x0010          /* 1=3Denable IRQ */
#define Control_GATE    0x0008          /* 1=3Denable external trigger GATE=
 (8254?) */
#define Control_EXT     0x0004          /* 1=3Dexternal trigger source */
#define Control_PACER   0x0002          /* 1=3Denable internal 8254 trigger=
 source */
#define Control_SW      0x0001          /* 1=3Denable software trigger sour=
ce */

//bits from d/a reference control
#define DA_Control_DA1_I_E 0x08	//1=3Dexternal reference
#define DA_Control_DA0_I_E 0x02
#define DA_Control_DA1_5_10 0x04	//1=3D10V
#define DA_Control_DA0_5_10 0x01

#define AD_Range_S_D 0x0020
#define AD_Range_B_U 0x0010

#endif


-------------- next part --------------
#include <linux/pci.h>
#include <linux/module.h>
#include <rtdm/rtdm_driver.h>
#include <time.h>
//#include <math.h>


MODULE_LICENSE("GPL");

#define PERIOD	10000 /* 10us */
#define PORT_PARALLEL 0x378
#define SPEAKER_DATA 0x61


#include "REG_PCI1711.h"


#define PCI_VENDOR_ 0x13fe
#define PCI_DEVICE_ 0x1711
#define NREG 32 	/*Espai reservat per registres*/

unsigned int PCI_BASE_ADRESS_1711;


static rtdm_task_t periodic_task;
static int end =3D 0;

//*************************************************************************=
**
//*********************************************************************

int detecta_PCI (void){

  /*
  unsigned char pci_bus, pci_device_fn;
  int pci_index;
  pci_index=3D0;
  pcibios_find_device (PCI_VENDOR, PCI_DEVICE, pci_index, &pci_bus, &pci_de=
vice_fn);
  pcibios_read_config_dword(pci_bus, pci_device_fn, PCI_BASE_ADDRESS_2, &PC=
I_BASE_ADRESS);
  PCI_BASE_ADRESS  &=3D PCI_BASE_ADDRESS_IO_MASK;
  request_region(PCI_BASE_ADRESS, 32, "Advantech PCI-1710");
  */


struct pci_dev *pcidev;

printk("PCI-1711 DETECT PCI \n");
pcidev=3DNULL;
pcidev =3Dpci_get_device (PCI_VENDOR_, PCI_DEVICE_, pcidev );
if (pcidev=3D=3DNULL){
	printk("PCI-1711 CANNOT BE FOUND \n");
}
else{
    printk("PCI-1711 LOCATED \n");
    if (pci_enable_device(pcidev)){
      printk("PCI-1711 NOT ENABLED \n");
      return(-EIO);
    }
    else{
        printk("PCI-1711 ENABLED \n");
	}
    PCI_BASE_ADRESS_1711=3D pci_resource_start(pcidev, 2);

    printk("PCI-1711 DETECT PCI %x \n",PCI_BASE_ADRESS_1711);
}

 return (0);
}
//*********************************************************************


void periodic(void *cookie)
{
  unsigned int yint;
  double t,w,y;
  struct timespec time;


  outw(0x0000,PCI_BASE_ADRESS_1711 + PCI171x_DAREF);

  while (!end) {
       	=

    //clock_gettime(CLOCK_REALTIME,&time);
    //t=3D(double)time.tv_nsec*1.0E-9+(double)time.tv_sec;
    //y=3D(double)0.5+(double)0.5*sin( w*t);
    //yint=3Dceil( y* ( (double) 4095 ));
    yint=3Dyint+1;
    outw(yint,PCI_BASE_ADRESS_1711 + PCI171x_DA0);
    rtdm_task_wait_period();
  }

}

int __init init_heartbeat(void)
{
	 =

        detecta_PCI ();

	return rtdm_task_init(&periodic_task, "periodic", periodic, NULL,
			      99, PERIOD);
}

void __exit cleanup_heartbeat(void)
{
	end =3D 1;
	rtdm_task_join_nrt(&periodic_task, 100);
}

module_init(init_heartbeat);
module_exit(cleanup_heartbeat);

