Message-ID: <54F97E05.8010107@xenomai.org>
Date: Fri, 06 Mar 2015 11:14:29 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <CAKk99t3_phHv3kUfCZcwr2bqTys3JPL3iaWACLjP+f1yoD_Nag@mail.gmail.com>	<54F97594.2060605@xenomai.org>
 <CAKk99t1AGHj8sOf7Vgy_UZ_+rECP5Vx22cyup--FHsh=RuK2zA@mail.gmail.com>
In-Reply-To: <CAKk99t1AGHj8sOf7Vgy_UZ_+rECP5Vx22cyup--FHsh=RuK2zA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Error boilerplate/wrappers.h no found trying to
 compile RTDM module on 3.x-rc3 cobalt
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Helder Daniel <hdaniel@ualg.pt>
Cc: "Xenomai@xenomai.org" <Xenomai@xenomai.org>

On 03/06/2015 11:03 AM, Helder Daniel wrote:
> On 6 March 2015 at 09:38, Philippe Gerum <rpm@xenomai.org
> <mailto:rpm@xenomai.org>> wrote:
> 
>     >
>     > obj-m += intr.o
>     >
>     > EXTRA_CFLAGS := -I/usr/xenomai/include -I/usr/include
> 
>     This is wrong, you are pulling userland headers. The CFLAGS required to
>     build a kernel module using the RTDM API should be obtained by:
> 
>     $(shell xeno-config --kcflags)
> 
> 
> Ok I was suspecting that (even makefile worked with 2.5) .
> I tried:
> 
> EXTRA_CFLAGS := $(shell xeno-config --kcflags)
> 
> but now it can not find rtdm.h:
> 

rtdm.h provides the RTDM API definitions to userland applications. You
want rtdm/driver.h for building a module implementing a RTDM driver.

> /root/prg/01-rtdm_interrupt/intr.c:2:18: fatal error: rtdm.h: No such
> file or directory
> 
> Whether It is included as <rtdm/rtdm.h>
> or just <rtdm.h>
> 
> I run the command in a shell and the output is:
> 
> root@debian:~/prg/01-rtdm_interrupt# xeno-config --kcflags
> 
> -Iarch/$(SRCARCH)/xenomai/include -Iinclude/xenomai
> 
> However complete output of make, tells SRCARCH not found:
> 
> $> make
> make -C /lib/modules/3.18.7-rt2/build M=/root/prg/01-rtdm_interrupt modules
> make[1]: Entering directory `/usr/src/linux-headers-3.18.7-rt2'
>   CC [M]  /root/prg/01-rtdm_interrupt/intr.o
> /bin/sh: 1: SRCARCH: not found
> /root/prg/01-rtdm_interrupt/intr.c:2:18: fatal error: rtdm.h: No such
> file or directory
> compilation terminated.
> make[2]: *** [/root/prg/01-rtdm_interrupt/intr.o] Error 1
> make[1]: *** [_module_/root/prg/01-rtdm_interrupt] Error 2
> make[1]: Leaving directory `/usr/src/linux-headers-3.18.7-rt2'
> make: *** [all] Error 2
> 

SRCARCH is defined by the standard Kbuild infrastructure, this is not a
Xenomai-specific variable. You may want to look at
xenomai3/kernel/drivers/ipc/Makefile for an illustration of its usage.

-- 
Philippe.

