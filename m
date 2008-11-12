Message-ID: <491B367A.1050207@domain.hid>
Date: Wed, 12 Nov 2008 21:03:06 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <c024fefc0811120041l71143d5dic1980a06d89a1317@domain.hid>
In-Reply-To: <c024fefc0811120041l71143d5dic1980a06d89a1317@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Xenomai Kernel Module & Watchdogs
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Adrian Boeing <me@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>

Adrian Boeing wrote:
> Hi,
> 
> I'm new to Xenomai, and wanted to know how to create a watchdog. It is my
> understanding that high priority periodic watchdog alarms need to be created
> in kernel mode.

Not necessarily, the same priority scale is available in kernel-space
and user-space. However, are you aware that Xenomai already has a
watchdog? It is selectable in Linux configuration once linux sources
have been prepared.

> 
> I would like to know:
> 1. Are there any tutorials/examples for Xenomai? I am aware of the examples
> at:
> http://www.xenomai.org/documentation/branches/v2.4.x/html/api/index.html
> and
> http://www.captain.at/xenomai.php

See the examples directory in xenomai distribution.

> 
> 2. How do I create a kernel module? (what is the compiler command?)
> If I try defining "__KERNEL__" and "MODULE" then I get a large number of
> errors in the xenomai/linux includes.

This question is off-topic on Xenomai mailing list, it is not related to
xenomai at all. But you have to get the module compiled by Linux kernel
makefiles. See Documentation/kbuild/modules.txt in the kernel sources.

> 
> I would like to create a simple 'hello world' module:
> 
> #include <nucleus/module.h>
> #include <native/task.h>
> 
> int init_module(void) {
>  printk("<1>Hello World 1.\n");
>  return 0;
> }
> 
> void cleanup_module(void) {
>  printk(KERN_ALERT,"Goodbye world 1.\n");
> }
> (The first error I recieve on compiling is "error: variable or field
> 'xnpod_declare_tbase_proc' declared void", using
> g++ hello.c -c -I/usr/include/xenomai -D_GNU_SOURCE -D_REENTRANT -D__XENO__
> )

the linux kernel is C only, there is no C++, and actually, trying to
compile C++ in kernel-space is a major PITA.

-- 
					    Gilles.

