MIME-Version: 1.0
Date: Mon, 25 May 2009 17:36:07 +0530
Message-ID: <200905251736.07951.shashank.bhatia@domain.hid>
From: Shashank Bhatia <shashank.bhatia@domain.hid>
content-type: text/plain; charset=us-ascii
content-transfer-encoding: 7bit
content-disposition: inline
Subject: [Xenomai-help] Interrupt service routine problem
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

I was trying to make a simple kernel module, and was unable to insert it into 
the kernel space. The code and Error messages are provided hereunder:


Code:
#include <native/task.h>
#include <native/timer.h>
#include <native/intr.h>

#define STACK_SIZE         0 

RT_INTR isrDesc;


int isrKbdHandler(struct xnintr* _idesc) {


  printk("module: catch a key\n");

  return RT_INTR_PROPAGATE; 

}



int init_module (void) {

  printk("module: Init\n");
  rt_intr_create(&isrDesc, "kbdisr", (unsigned)1, &isrKbdHandler, NULL, 0);
  rt_intr_enable(&isrDesc);


  return 0;
}



void cleanup_module (void) {

 
  rt_intr_delete(&isrDesc);
  
  printk("module: exit\n");
}

MODULE_LICENSE("GPL");




Makefile:


obj-m  = module.o


KDIR	= /lib/modules/$(shell uname -r)/build
PWD		= $(shell pwd)
EXTRA_CFLAGS = -I/usr/xenomai/include -I/usr/include/ 
default:
	$(MAKE) -C $(KDIR) SUBDIRS=$(PWD) modules

clean:
	rm -f *.o *.ko *.mod.c *symvers *~



Error message:
make -C /lib/modules/2.6.25.11-default/build 
SUBDIRS=/home/bhatia/rtprog/interupt modules
make[1]: Entering directory `/usr/src/linux-2.6.25.11'
  CC [M]  /home/bhatia/rtprog/interupt/module.o
  Building modules, stage 2.
  MODPOST 1 modules
WARNING: "rt_intr_enable" [/home/bhatia/rtprog/interupt/module.ko] undefined!
WARNING: "rt_intr_create" [/home/bhatia/rtprog/interupt/module.ko] undefined!
WARNING: "rt_intr_delete" [/home/bhatia/rtprog/interupt/module.ko] undefined!
  CC      /home/bhatia/rtprog/interupt/module.mod.o
  LD [M]  /home/bhatia/rtprog/interupt/module.ko
make[1]: Leaving directory `/usr/src/linux-2.6.25.11'



Error while insmoding:
insmod: error inserting './module.ko': -1 Unknown symbol in module







Thanks and Regards,

Shashank

-------------------------------------
Hi-Tech Gears Limited, Gurgaon, India





