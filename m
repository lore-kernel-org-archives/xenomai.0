From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <1f3e02580910291831t3db9f713sef6b162bb51ad6ee@domain.hid>
References: <1f3e02580910290229t5ad46268r5e7799a46950db5e@domain.hid>
	<1256812559.2065.197.camel@domain.hid>
	<1f3e02580910291831t3db9f713sef6b162bb51ad6ee@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 30 Oct 2009 12:09:16 +0100
Message-ID: <1256900956.2065.320.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] [VxWorks API] Compile and Link
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Didenko Sergey <didenkos@domain.hid>
Cc: xenomai@xenomai.org

On Fri, 2009-10-30 at 10:31 +0900, Didenko Sergey wrote:
> Dear Philippe
> 
> Thank you very much for the detailed explanation.
> That was exactly what I need to understand once again and again.
> Yes, I have read the "Porting_From_RTOS", but my next small step is
> just to reuse APIs provided by Xenomai.
> 
> may I test my understanding in one thing "where Xenomai should be
> installed?"
> 
> I have my Linux based PC with:
> $linux_tree = /home/d.sergey/kernel/linux-2.6.29-v02.00.29 (patched
> with xenomai + added support for MV 88F6290 Platfrom)
> $xenomai_root = /home/d.sergey/xemomai/xenomai-2.4.9.1
> $build_root = /home/d.sergey/build_root
> $staging_dir = /nfs/rootfs
> 
> after patching linux_tree with Xenomai and Adeos...
> I have done:
> ======================
> cd $linux_tree
> make ARCH=arm CROSS_COMPILE=arm-none-linux-gnueabi- O=$build_root
> project_defconfig -j5
> make ARCH=arm CROSS_COMPILE=arm-none-linux-gnueabi- O=$build_root
> bzImage modules -j5
> ======================
> then
> ======================
> cd  $build_root
> /home/d.sergey/xemomai/xenomai-2.4.9.1/configure
> --build=i686-pc-linux-gnu --host=arm-none-linux-gnueabi
> --enable-arm-mach=generic --enable-arm-tsc
> make DESTDIR=/nfs/rootfs install
> ======================
> 
> Gilles, is that what you said ? 
>         You need to install Xenomai, running 'make install' in the
>         build tree.
>  
> Or should I install Xenomai on my Linux based PC? (Right now I assume
> it is installed on my target's rootfs)
> 

To keep things simple at the beginning, I would have two copies. One for
your target via the staging dir, the other one as a compilation
environment on your PC. Which means two separate builds:

- keep the one you did for your target, standard prefix is /usr/xenomai
by default. This install is for running Xenomai apps on your target.
- start another build, passing --prefix=/your/local/install/path to the
configure script. This one should be installed using a plain "make
install", you need no staging dir spec via DESTDIR here. It is for
cross-compiling applications on your PC.

Once installed, have your application Makefiles
pick /your/local/install/path/bin/xeno-config, for retrieving the CFLAGS
and LDFLAGS for building the application. Make sure to set the CC
variable properly as well in those Makefiles, e.g. CC := $(shell
xeno-config --cc), so that you actually compile with the cross-compiler
used in building the Xenomai libs, not the native x86 one.

Your target should update /etc/ld.so.conf* in order to
list /usr/xenomai/lib in the shared library path, so that Xenomai libs
can be found without resorting to setting the LD_LIBRARY_PATH variable.

If your target filesystem is NFS-mounted, you could use a single copy of
the Xenomai userland install for the same result, but having two is
easier if you are not familiar with this setup. Just make sure to keep
both copies in sync if you happen to update the Xenomai support.

>  
> 
>         Then use xeno-config.
> Sorry, but I did not get how should I use it? 
> Please give me more details!
> 
> I also do not understand for what the $build_root folder is required? 
> Why  can not we compile the Xenomai's code it its tree?
> 

Because this is not recommended by the autoconf standards, albeit this
might (or might not) work, depending on how the package maintainer
crafted the configure script. AFAIK, all Xenomai maintainers usually
build into a separate directory, so you can assume that this will always
work. In any case, I personally never build within the source tree.

> 
> Philippe, I understand all the things you have mentioned...
>         moving a pristine VxWorks application from a traditional RTOS
>         environment to Linux requires some work, no API emulation
>         layer will
>         give you 1:1 mapping between the zillions of WRS APIs and
>         Linux+Xenomai.
>  
> But, for the next step of my journey, I simply need to emulate the API
> layer, that is it!
> Please help me to understand how can I emulate the APIs.
> Right now I just need to make my code be able to use Xenomai's APIs.
> 

Did you have a look at examples/native from instance? This Makefile
template illustrates how to build an application linked against the
native Xenomai API. Just replace -lnative by -lvxworks, and the logic
remains the same to build a vxworks app.

#include <vxworks/vxworks.h> will load all the emulated service
prototypes.

The -I specs dumped by xeno-config --xeno-cflags will point at the right
include directory, to find the above file. The -L specs dumped by
xeno-config --xeno-ldflags will get you the proper flags for the linker
to find the Xenomai libs you need, e.g. libvxworks.so.

Just run those two commands manually, you will get many of the answers
to your questions. xeno-config --help is available as well.

Now, a bit of "how does it work"?

Let's consider foo.c, a mundane skeleton app:

#include <vxworks/vxworks.h>

MSG_Q_ID qid;
TASK_ID tid;

void demo_task(int a0, int a1, int a2, int a3, int a4,
		int a5, int a6, int a7, int a8, int a9)
{
	for (;;) {
		...
		msgQSend(qid, blah, sizeof(blah), WAIT_FOREVER, MSG_PRI_NORMAL);
		...
	}
}

int main(int argc, char **argv)
{
	qid = msgQCreate(16, sizeof(int), MSG_Q_FIFO);
	if (qid == ERROR) {
		fprintf(stderr, "failed to create queue: VxWorks code %d\n", errno);
		exit(1);
	}

	tid = taskSpawn("someTask",
			110,
			0,
			64*1024,
			(FUNCPTR)&demo_task,
			0,0,0,0,0,0,0,0,0,0);
	if (tid == ERROR) {
		fprintf(stderr, "failed to create task: VxWorks code %d\n", errno);
		exit(1);
	}

	pause();

	return 0;
}

As you see, it's plain simple. You get the prototypes from the emulated
VxWorks syscalls from vxworks/vxworks.h, and you get the implementation
of those services from {/usr/xenomai/lib/}libvxworks.so, or wherever you
eventually put the Xenomai libs.

libvxworks.so will emit actual system calls to the in-kernel Xenomai
emulation engine, which will do the VxWorks magic for you, over Xenomai
real-time threads.

Before the question arises, yes: you may call standard glibc routines
over VxWorks tasks. But if you do so, you will lose real-time
performances. Make sure to read this document
http://www.xenomai.org/documentation/branches/v2.3.x/pdf/Native-API-Tour-rev-C.pdf
Everything you need to understand is explained; the fact that it details
the native API instead of the VxWorks emulator has zero impact on the
relevance of what is explains regarding the programming model and
various concepts of dual kernel systems.

> I'm not saying that right after that I will try to run my project on
> the target and will complain why it is not working, no...
> Just to do next step, I want to make my code compile and link with new
> APIs.
> Looking forward to hearing from you.
> 
> Sergey
> 
> 2009/10/29 Philippe Gerum <rpm@xenomai.org>
>         On Thu, 2009-10-29 at 18:29 +0900, Didenko Sergey wrote:
>         
>         
>         > Dear experts
>         >
>         > assuming I have:
>         >
>         > xenomai_tree - path to Xenomai source code
>         > project_tree - path to my project (originally based on
>         VxWorks)
>         >
>         > Which directories and files should I include to the
>         project's makefile
>         > to be able to compile and link it with Xenimai's VxWorks
>         APIs instead
>         > of VxWorks's API's?
>         > Do I need only *.h and *.c files or any libraries are
>         required?
>         >
>         
>         
>         
>         XENO_CONFIG := /usr/xenomai/bin/xeno-config
>         CFLAGS:= $(shell $(XENO_CONFIG) --xeno-cflags) -g
>         LDFLAGS:= $(shell $(XENO_CONFIG) --xeno-ldflags) -lvxworks
>         
>         This said, moving a pristine VxWorks application from a
>         traditional RTOS
>         environment to Linux requires some work, no API emulation
>         layer will
>         give you 1:1 mapping between the zillions of WRS APIs and
>         Linux+Xenomai.
>         
>         Only playing whack-a-mole fixing syntactical/compilation
>         issues until
>         your app eventually builds and links is the fastest way to
>         hell for such
>         a porting exercise: this will NOT address the design-related
>         issues that
>         must exist (e.g. what will you do with your original I/O
>         drivers, how
>         and where will you put the kernel/user boundary when porting
>         your code
>         etc, etc).
>         
>         A core issue is that programming models are fundamentally
>         different,
>         i.e:
>         
>         - single-address space + flat/physically addressed memory +
>         permanent
>         supervisor privileges + sloppy device driver model
>         VS
>         - multiple process contexts + MMU protection + separate
>         kernel/application address spaces + non-privileged CPU mode
>         for
>         applications + strict device driver model.
>         
>         And, while I'm at it, just in case you might have considered
>         this:
>         moving all of your original code to Linux kernel space on top
>         of the
>         Xenomai APIs there would be likely terribly wrong. Aside of
>         the license
>         issues (GPL vs proprietary), you may also have serious
>         problems down the
>         road porting your code.
>         
>         The Xenomai APIs _in kernel space_ are now deprecated, they
>         were made
>         available at a time when Xenomai had no user-space support,
>         back in
>         2001. We have such support since 2004 and the in-kernel APIs
>         were kept
>         for backward compatibility purposes only, so moving a complex
>         application today, to such an hostile environment for
>         user-level code is
>         basically masochistic.
>         
>         A safer way to this journey is:
>         
>         - assess which original I/O drivers have to be real-time and
>         move them
>         to kernel space on top of RTDM.
>         - assess which original I/O drivers have direct Linux
>         counter-parts,
>         and/or does not have any RT requirement, and reuse/implement a
>         regular
>         Linux driver for those.
>         - segregate what parts of your original code has to be RT
>         enabled from
>         the other more "relaxed" parts.
>         - move the application code bulk to userland, on top of the
>         Xenomai APIs
>         there. Adapt the RT portions to the Xenomai APIs, use anything
>         that fits
>         for the rest (e.g. plain glibc).
>         
>         Driver-wise, there is rule #666 to abide by: in a dual kernel
>         environment - like Xenomai 2.x - never, ever, plan to share an
>         IRQ line
>         between a real-time device and a regular one. As soon as
>         anyone feels
>         tempted by implementing such a construct, the design flaw is
>         there, and
>         something must have been wrongly assessed during the early
>         porting
>         steps.
>         
>         All in all, and to sum up: unless your application is 50 LOC
>         at most,
>         porting it to Linux will require some implementation re-design
>         work, and
>         Xenomai is no magic bullet to avoid that. What Xenomai aims
>         at, is
>         providing a _correct_ emulation of the core VxWorks services
>         (~100 of
>         them), which normally mitigates the impact of such re-design
>         work. In
>         other words, do not confuse Xenomai with running the actual,
>         original
>         RTOS within some virtual machine on top of a bare metal
>         hypervisor.
>         
>         The hypervisor approach is not Linux at all, it is just
>         enabling the
>         legacy RTOS to run on the same hw than Linux. The former
>         approach is
>         about mimicking the original RTOS environment natively in a
>         Linux
>         context, which leads to very different trade-offs when
>         porting.
>         
>         You may at the very least want to read that piece, not much
>         yet, but
>         this is still better than nothing:
>         http://www.xenomai.org/index.php/Xenomai:Porting_From_RTOS
>         
>         > Sergey
>         >
>         > _______________________________________________
>         > Xenomai-help mailing list
>         > Xenomai-help@domain.hid
>         > https://mail.gna.org/listinfo/xenomai-help
>         
>         
>         --
>         Philippe.
>         
>         
>         
> 


-- 
Philippe.



