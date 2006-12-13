Message-ID: <457FF9FE.5090507@domain.hid>
Date: Wed, 13 Dec 2006 14:02:54 +0100
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Symbols undefined [Scanned]
References: <457FF5B6.7070509@domain.hid>
In-Reply-To: <457FF5B6.7070509@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Niklaus Burren <niklaus.burren@domain.hid>
Cc: xenomai@xenomai.org

Niklaus Burren wrote:
> Hello
> 
> Im trying to create a Xenomai kernel module for a ARM processor 
> (PXA-270). In this module I register a interrupt handler with the 
> function rt_inter_create(). When I compile the module I get the 
> following warnings:
> 
> *** Warning: "rt_intr_delete" 
> [/home/student/work/xenomai/latency-test/latency-test.ko] undefined!
> *** Warning: "rt_intr_create" 
> [/home/student/work/xenomai/latency-test/latency-test.ko] undefined!
> *** Warning: "rt_intr_enable" 
> [/home/student/work/xenomai/latency-test/latency-test.ko] undefined!
> 
> I don't know what is wrong. In my makefile I have defined the paths to 
> the libraries and the include files of xenomai:
> 
> obj-m = latency-test.o
> 
> XENODIR = /opt/carme/rootfs/usr/xenomai
> KDIR    = /opt/carme/linux-2.6.15-col2
> PWD    = $(shell pwd)
> 
> EXTRA_CFLAGS = -I $(XENODIR)/include -L $(XENODIR)/lib
> 
> all:
>     $(MAKE) -C $(KDIR) M=$(PWD) modules
> 
> clean:
>     $(MAKE) -C $(KDIR) M=$(PWD) clean
> 
> 
> Has someone an idea what is wrong?

Have you enabled support for interrupts in the native skin? Check for 
CONFIG_XENO_OPT_NATIVE_INTR in your config file.

Wolfgang.


