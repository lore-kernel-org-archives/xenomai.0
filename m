References: <200905251736.07951.shashank.bhatia@domain.hid>
	<4A1A9F29.8050806@domain.hid>
In-Reply-To: <4A1A9F29.8050806@domain.hid>
MIME-Version: 1.0
Date: Tue, 26 May 2009 11:13:24 +0530
Message-ID: <200905261113.24697.shashank.bhatia@domain.hid>
From: Shashank Bhatia <shashank.bhatia@domain.hid>
content-type: text/plain; charset=utf-8
content-transfer-encoding: 7bit
content-disposition: inline
Subject: Re: [Xenomai-help] Interrupt service routine problem
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Stefan Kisdaroczi <kisda@domain.hid>
Cc: xenomai@xenomai.org

Thanks a lot, i got my ISR working. I was also looking for some tutorial on 
RTDM, do you have any source for it ?

Thanks ,
Shashank



On Mon May 25 2009 07:07:45 pm you wrote:
> Hi,
>
> the rt_intr_* functions are disabled by default in the kernel configuration
> [1].
>
> You can enable them here:
> Real-time subsystem -> Interfaces -> Native API -> Interrupts
>
> For device drivers its suggested that you use the RTDM skin and not the
> rt_intr_* calls from the native API.
>
> kisda
>
> [1] https://mail.gna.org/public/xenomai-help/2006-07/msg00197.html
>
> Shashank Bhatia schrieb:
> > Dear All,
> >
> > I was trying to make a simple kernel module, and was unable to insert it
> > into the kernel space. The code and Error messages are provided
> > hereunder:
> >
> >
> > Code:
> > #include <native/task.h>
> > #include <native/timer.h>
> > #include <native/intr.h>
> >
> > #define STACK_SIZE         0
> >
> > RT_INTR isrDesc;
> >
> >
> > int isrKbdHandler(struct xnintr* _idesc) {
> >
> >
> >   printk("module: catch a key\n");
> >
> >   return RT_INTR_PROPAGATE;
> >
> > }
> >
> >
> >
> > int init_module (void) {
> >
> >   printk("module: Init\n");
> >   rt_intr_create(&isrDesc, "kbdisr", (unsigned)1, &isrKbdHandler, NULL,
> > 0); rt_intr_enable(&isrDesc);
> >
> >
> >   return 0;
> > }
> >
> >
> >
> > void cleanup_module (void) {
> >
> >
> >   rt_intr_delete(&isrDesc);
> >
> >   printk("module: exit\n");
> > }
> >
> > MODULE_LICENSE("GPL");
> >
> >
> >
> >
> > Makefile:
> >
> >
> > obj-m  = module.o
> >
> >
> > KDIR	= /lib/modules/$(shell uname -r)/build
> > PWD		= $(shell pwd)
> > EXTRA_CFLAGS = -I/usr/xenomai/include -I/usr/include/
> > default:
> > 	$(MAKE) -C $(KDIR) SUBDIRS=$(PWD) modules
> >
> > clean:
> > 	rm -f *.o *.ko *.mod.c *symvers *~
> >
> >
> >
> > Error message:
> > make -C /lib/modules/2.6.25.11-default/build
> > SUBDIRS=/home/bhatia/rtprog/interupt modules
> > make[1]: Entering directory `/usr/src/linux-2.6.25.11'
> >   CC [M]  /home/bhatia/rtprog/interupt/module.o
> >   Building modules, stage 2.
> >   MODPOST 1 modules
> > WARNING: "rt_intr_enable" [/home/bhatia/rtprog/interupt/module.ko]
> > undefined! WARNING: "rt_intr_create"
> > [/home/bhatia/rtprog/interupt/module.ko] undefined! WARNING:
> > "rt_intr_delete" [/home/bhatia/rtprog/interupt/module.ko] undefined! CC  
> >    /home/bhatia/rtprog/interupt/module.mod.o
> >   LD [M]  /home/bhatia/rtprog/interupt/module.ko
> > make[1]: Leaving directory `/usr/src/linux-2.6.25.11'
> >
> >
> >
> > Error while insmoding:
> > insmod: error inserting './module.ko': -1 Unknown symbol in module
> >
> >
> >
> >
> >
> >
> >
> > Thanks and Regards,
> >
> > Shashank
> >
> > -------------------------------------
> > Hi-Tech Gears Limited, Gurgaon, India
> >
> >
> >
> >
> >
> > _______________________________________________
> > Xenomai-help mailing list
> > Xenomai-help@domain.hid
> > https://mail.gna.org/listinfo/xenomai-help



-------------------------------------
Hi-Tech Gears Limited, Gurgaon, India





