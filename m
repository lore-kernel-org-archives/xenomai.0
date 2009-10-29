From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <1f3e02580910290229t5ad46268r5e7799a46950db5e@domain.hid>
References: <1f3e02580910290229t5ad46268r5e7799a46950db5e@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 29 Oct 2009 11:35:59 +0100
Message-ID: <1256812559.2065.197.camel@domain.hid>
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

On Thu, 2009-10-29 at 18:29 +0900, Didenko Sergey wrote:
> Dear experts
> 
> assuming I have:
> 
> xenomai_tree - path to Xenomai source code
> project_tree - path to my project (originally based on VxWorks)
> 
> Which directories and files should I include to the project's makefile
> to be able to compile and link it with Xenimai's VxWorks APIs instead
> of VxWorks's API's?
> Do I need only *.h and *.c files or any libraries are required?
> 

XENO_CONFIG := /usr/xenomai/bin/xeno-config
CFLAGS:= $(shell $(XENO_CONFIG) --xeno-cflags) -g
LDFLAGS:= $(shell $(XENO_CONFIG) --xeno-ldflags) -lvxworks

This said, moving a pristine VxWorks application from a traditional RTOS
environment to Linux requires some work, no API emulation layer will
give you 1:1 mapping between the zillions of WRS APIs and Linux+Xenomai.

Only playing whack-a-mole fixing syntactical/compilation issues until
your app eventually builds and links is the fastest way to hell for such
a porting exercise: this will NOT address the design-related issues that
must exist (e.g. what will you do with your original I/O drivers, how
and where will you put the kernel/user boundary when porting your code
etc, etc).

A core issue is that programming models are fundamentally different,
i.e:

- single-address space + flat/physically addressed memory + permanent
supervisor privileges + sloppy device driver model
VS 
- multiple process contexts + MMU protection + separate
kernel/application address spaces + non-privileged CPU mode for
applications + strict device driver model.

And, while I'm at it, just in case you might have considered this:
moving all of your original code to Linux kernel space on top of the
Xenomai APIs there would be likely terribly wrong. Aside of the license
issues (GPL vs proprietary), you may also have serious problems down the
road porting your code.

The Xenomai APIs _in kernel space_ are now deprecated, they were made
available at a time when Xenomai had no user-space support, back in
2001. We have such support since 2004 and the in-kernel APIs were kept
for backward compatibility purposes only, so moving a complex
application today, to such an hostile environment for user-level code is
basically masochistic.

A safer way to this journey is:

- assess which original I/O drivers have to be real-time and move them
to kernel space on top of RTDM.
- assess which original I/O drivers have direct Linux counter-parts,
and/or does not have any RT requirement, and reuse/implement a regular
Linux driver for those.
- segregate what parts of your original code has to be RT enabled from
the other more "relaxed" parts.
- move the application code bulk to userland, on top of the Xenomai APIs
there. Adapt the RT portions to the Xenomai APIs, use anything that fits
for the rest (e.g. plain glibc).

Driver-wise, there is rule #666 to abide by: in a dual kernel
environment - like Xenomai 2.x - never, ever, plan to share an IRQ line
between a real-time device and a regular one. As soon as anyone feels
tempted by implementing such a construct, the design flaw is there, and
something must have been wrongly assessed during the early porting
steps.

All in all, and to sum up: unless your application is 50 LOC at most,
porting it to Linux will require some implementation re-design work, and
Xenomai is no magic bullet to avoid that. What Xenomai aims at, is
providing a _correct_ emulation of the core VxWorks services (~100 of
them), which normally mitigates the impact of such re-design work. In
other words, do not confuse Xenomai with running the actual, original
RTOS within some virtual machine on top of a bare metal hypervisor.

The hypervisor approach is not Linux at all, it is just enabling the
legacy RTOS to run on the same hw than Linux. The former approach is
about mimicking the original RTOS environment natively in a Linux
context, which leads to very different trade-offs when porting.

You may at the very least want to read that piece, not much yet, but
this is still better than nothing:
http://www.xenomai.org/index.php/Xenomai:Porting_From_RTOS

> Sergey
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help


-- 
Philippe.



