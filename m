Message-ID: <4545AA69.9080609@domain.hid>
Date: Mon, 30 Oct 2006 08:31:53 +0100
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Bug in taskSuspend for user mode vxworks
References: <200610252346.34150.niklaus.giger@domain.hid>
	<200610281940.10654.niklaus.giger@domain.hid>
	<4543A31B.1000500@domain.hid>
	<200610292202.49810.niklaus.giger@domain.hid>
In-Reply-To: <200610292202.49810.niklaus.giger@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
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

Niklaus Giger wrote:
> Am Samstag, 28. Oktober 2006 20:36 schrieb Wolfgang Grandegger:
>> Niklaus Giger wrote:
>>> Am Samstag, 28. Oktober 2006 14:54 schrieb Niklaus Giger:
>>>> Am Freitag, 27. Oktober 2006 18:38 schrieb Philippe Gerum:
>>>>> On Wed, 2006-10-25 at 23:46 +0200, Niklaus Giger wrote:
>>>>>> Hi
>> My impression from our last discussion was that your toolchain is
>> somehow broken as I was unable to reproduce your problems on (almost)
>> the same hardware
>>
>>> I think I really have to reactivate my old Walnut board to have common
>>> platform to test with Wolfgang Grandegger.
>> It would make more sense to use the ELDK4 for comparison. I don't think
>> it depends on the hardware.
> As I forced my son to run on his MacMini (Intel Core Duo) only Linux and no 
> MacOsX (he discovered widelands and was quite happy), I had a platform where 
> I could install the CD with ELDK 4.0, which I had laying around.
> 
> After some setting up of my environment and tweaking my scripts to work with 
> ELDK (e.g. adding --host=ppc CC=ppc_4xx-gcc to my xenomai/configure) I ended 

--host=ppc-linux is already enough with CROSS_COMPILE=ppc_4xx- set.

> up with a nice environment and rootfs with much more precompiled programs 
> than I had ever before. Debugging on the platform is now as good as on my 
> PowerBook.
> 
> My situation is now as follows:
> - ELDK 4.0 installed on Debian Etch MacMini
> - Using ELD 4.0 rootfs ppc_4xx
> - compiled the kernel uImage, modules, xenomai using ppc_4xx-gcc 
>    (but NOT adding any -mcpu=40x flag to the compiler) 
> 
> The trap 0 in  /proc/xenomai/fault seems to count on each invocation of simple
>   0:           51    (Data or instruction access)
> gdb however no does not show anything abnormal, as it says now
>> This GDB was configured as "ppc-linux"...Using host libthread_db library
>> "/lib/tls/libthread_db.so.1".
>>
>> (gdb) run
>> Starting program: /bin/simple
>> [Thread debugging using libthread_db enabled]
>> [New Thread 805422032 (LWP 639)]
>> root_thread_init 4[New Thread 805455088 (LWP 642)]
>>
>> Program exited normally.
>> (gdb) quit
> 
> Though I am still puzzled.

Could you please send me your Makefile or the compile command to make 
"simple", then I would give it a try on my setup.

Wolfgang.


