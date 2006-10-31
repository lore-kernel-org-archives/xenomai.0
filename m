Message-ID: <4547AD1B.1060505@domain.hid>
Date: Tue, 31 Oct 2006 21:07:55 +0100
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Bug in taskSuspend for user mode vxworks
References: <200610252346.34150.niklaus.giger@domain.hid>
	<200610300809.43844.niklaus.giger@domain.hid>
	<454705E9.9040606@domain.hid>
	<200610311951.29678.niklaus.giger@domain.hid>
In-Reply-To: <200610311951.29678.niklaus.giger@domain.hid>
Content-Type: multipart/mixed; boundary="------------060409050800010300050504"
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: niklaus.giger@domain.hid
Cc: xenomai@xenomai.org

This is a multi-part message in MIME format.
--------------060409050800010300050504
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Niklaus Giger wrote:
> Am Dienstag, 31. Oktober 2006 09:14 schrieb Wolfgang Grandegger:
>> Niklaus Giger wrote:
>>> Am Montag, 30. Oktober 2006 08:31 schrieb Wolfgang Grandegger:
>>>> Niklaus Giger wrote:
>>>>> Am Samstag, 28. Oktober 2006 20:36 schrieb Wolfgang Grandegger:
>>>>>> Niklaus Giger wrote:
>>>>>>> Am Samstag, 28. Oktober 2006 14:54 schrieb Niklaus Giger:
>>>>>>>> Am Freitag, 27. Oktober 2006 18:38 schrieb Philippe Gerum:
>>>>>>>>> On Wed, 2006-10-25 at 23:46 +0200, Niklaus Giger wrote:
>>>>>>>>>> Hi
>>>>>> My impression from our last discussion was that your toolchain is
>>>>>> somehow broken as I was unable to reproduce your problems on (almost)
>>>>>> the same hardware
>>>>>>
>>>>>>> I think I really have to reactivate my old Walnut board to have
>>>>>>> common platform to test with Wolfgang Grandegger.
>>>>>> It would make more sense to use the ELDK4 for comparison. I don't
>>>>>> think it depends on the hardware.
>>>>> As I forced my son to run on his MacMini (Intel Core Duo) only Linux
>>>>> and no MacOsX (he discovered widelands and was quite happy), I had a
>>>>> platform where I could install the CD with ELDK 4.0, which I had laying
>>>>> around.
>>>>>
>>>>> After some setting up of my environment and tweaking my scripts to work
>>>>> with ELDK (e.g. adding --host=ppc CC=ppc_4xx-gcc to my
>>>>> xenomai/configure) I ended
>>>> --host=ppc-linux is already enough with CROSS_COMPILE=ppc_4xx- set.
>>>>
>>>>> up with a nice environment and rootfs with much more precompiled
>>>>> programs than I had ever before. Debugging on the platform is now as
>>>>> good as on my PowerBook.
>>>>>
>>>>> My situation is now as follows:
>>>>> - ELDK 4.0 installed on Debian Etch MacMini
>>>>> - Using ELD 4.0 rootfs ppc_4xx
>>>>> - compiled the kernel uImage, modules, xenomai using ppc_4xx-gcc
>>>>>    (but NOT adding any -mcpu=40x flag to the compiler)
>>>>>
>>>>> The trap 0 in  /proc/xenomai/fault seems to count on each invocation of
>>>>> simple 0:           51    (Data or instruction access)
>>>>> gdb however no does not show anything abnormal, as it says now
>>>>>
>>>>>> This GDB was configured as "ppc-linux"...Using host libthread_db
>>>>>> library "/lib/tls/libthread_db.so.1".
>>>>>>
>>>>>> (gdb) run
>>>>>> Starting program: /bin/simple
>>>>>> [Thread debugging using libthread_db enabled]
>>>>>> [New Thread 805422032 (LWP 639)]
>>>>>> root_thread_init 4[New Thread 805455088 (LWP 642)]
>>>>>>
>>>>>> Program exited normally.
>>>>>> (gdb) quit
>>>>> Though I am still puzzled.
>>>> Could you please send me your Makefile or the compile command to make
>>>> "simple", then I would give it a try on my setup.
>>> Here are the commands
>>> ppc_4xx-gcc -I../.. -I/home/hcu/rootfs/usr/xenomai/include -D_GNU_SOURCE
>>> -D_REENTRANT -I/net/ng/mnt/data.ng/hcu/project/vx_skin -D__XENO__ -g
>>> -DVXWORKS    -c -o simple.o simple.c
>>> ppc_4xx-gcc -o simple
>>> simple.o -L/home/hcu/rootfs/usr/xenomai/lib -lpthread  -lvxworks
>> Again the same question. What versions of kernel, ADEOS-IPIPE and
>> Xenomai are you using.I have some problems to get the kernel booted with
>> the VxWorks skin emulation. I understood, that I must build the Native
>> and POSIX skin as modules and enable the periodic timer support with a
>> resonable frequency.
> I used revision 1747 of the xenomai trunk, linux 2.4.17 + some small patches 
> (attached) for my system, the attached .config, 
> adeos-ipipe-2.6.14-ppc-1.5-01.patch.
> 
> I have vxworks built-in to enforce that the timers get initialized into the 
> periodic mode.

OK, with a similar setup I get the same results as you have seen on your 
(son's) MacMini. I have attached the output.

Wolfgang.


--------------060409050800010300050504
Content-Type: text/x-log;
 name="simple.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="simple.log"

sh-3.00# export LD_LIBRARY_PATH=/home/wolf/xenomai/lib
bash-3.00# ./simple

root_thread_init 3
bash-3.00# cat /proc/xenomai/faults
TRAP         CPU0
  0:            1    (Data or instruction access)
  1:            0    (Alignment)
  2:            0    (Altivec unavailable)
  3:            0    (Program check exception)
  4:            0    (Machine check exception)
  5:            0    (Unknown)
  6:            0    (Instruction breakpoint)
  7:            0    (Run mode exception)
  8:            0    (Single-step exception)
  9:            0    (Non-recoverable exception)
 10:            0    (Software emulation)
 11:            0    (Debug)
 12:            0    (SPE)
 13:            0    (Altivec assist)
bash-3.00# ./simple

root_thread_init 3
bash-3.00# cat /proc/xenomai/faults
TRAP         CPU0
  0:            2    (Data or instruction access)
  1:            0    (Alignment)
  2:            0    (Altivec unavailable)
  3:            0    (Program check exception)
  4:            0    (Machine check exception)
  5:            0    (Unknown)
  6:            0    (Instruction breakpoint)
  7:            0    (Run mode exception)
  8:            0    (Single-step exception)
  9:            0    (Non-recoverable exception)
 10:            0    (Software emulation)
 11:            0    (Debug)
 12:            0    (SPE)
 13:            0    (Altivec assist)
bash-3.00# gdb simple
GNU gdb Red Hat Linux (6.3.0.0-1.21_1rh)
Copyright 2004 Free Software Foundation, Inc.
GDB is free software, covered by the GNU General Public License, and you are
welcome to change it and/or distribute copies of it under certain conditions.
Type "show copying" to see the conditions.
There is absolutely no warranty for GDB.  Type "show warranty" for details.
This GDB was configured as "ppc-linux"...Using host libthread_db library "/lib/libthread_db.so.1".

(gdb) run
Starting program: /home/wolf/simple
[Thread debugging using libthread_db enabled]
[New Thread 805422032 (LWP 260)]
[New Thread 805455088 (LWP 263)]

root_thread_init 3

Program exited normally.
(gdb)



--------------060409050800010300050504--

