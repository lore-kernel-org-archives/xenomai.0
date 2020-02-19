Subject: Re: xenomai app running under gdb hangs on 3.1/arm32
References: <76cffbb0-cd34-760d-9e4b-a4dafa3bc19c@freyder.net>
 <d89b5115-6837-46f4-7cf3-1b70f25b64ce@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <76d7c7af-4d41-8546-6714-b4bfb947f686@siemens.com>
Date: Wed, 19 Feb 2020 11:02:07 +0100
MIME-Version: 1.0
In-Reply-To: <d89b5115-6837-46f4-7cf3-1b70f25b64ce@siemens.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: steve freyder <steve@freyder.net>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 19.02.20 09:56, Jan Kiszka via Xenomai wrote:
> On 18.02.20 23:33, steve freyder via Xenomai wrote:
>> Hello again Xenomai group,
>>
>>
>> Was testing gdb on xenomai 3.1, ran into this (Xenomai 3.1 on armv7-a, 
>> iMX6-dual-lite)
>>
>> root@g3l-21:~ # gdb /usr/bin/rtcanrecv
>> GNU gdb (GDB) 8.3.1
>> Copyright (C) 2019 Free Software Foundation, Inc.
>> License GPLv3+: GNU GPL version 3 or later 
>> <http://gnu.org/licenses/gpl.html>
>> This is free software: you are free to change and redistribute it.
>> There is NO WARRANTY, to the extent permitted by law.
>> Type "show copying" and "show warranty" for details.
>> This GDB was configured as "arm-emac-linux-gnueabi".
>> Type "show configuration" for configuration details.
>> For bug reporting instructions, please see:
>> <http://www.gnu.org/software/gdb/bugs/>.
>> Find the GDB manual and other documentation resources online at:
>>      <http://www.gnu.org/software/gdb/documentation/>.
>>
>> For help, type "help".
>> Type "apropos word" to search for commands related to "word"...
>> Reading symbols from /usr/bin/rtcanrecv...
>> (No debugging symbols found in /usr/bin/rtcanrecv)
>> (gdb) break main
>> Breakpoint 1 at 0x10d50
>> (gdb) run --trace=10
>> Starting program: /usr/bin/rtcanrecv --trace=10
>> warning: Unable to find libthread_db matching inferior's thread 
>> library, thread debugging will not be available.
>> --  cold init from program
>> --  cobalt->init()
>> --  connected to Cobalt
>> --  memory locked
>> --  memory heaps mapped
>> [New LWP 1931]
>> --  boilerplate->init()
>>
>> -- copperplate->init()
>>
>>
>> [ at this point the program is hung, so press Control-C ]
>>
>> ^C
>> Thread 1 "rtcanrecv" received signal SIGINT, Interrupt.
>> 0x76fca4a0 in __cobalt_pthread_mutex_lock (mutex=0x484c20c8 
>> <heapmem_main>) at 
>> /home/sdf/xenobuild/imx-xenomai/xenomai-3.1/lib/cobalt/mutex.c:375
>> 375                     ret = XENOMAI_SYSCALL1(sc_cobalt_mutex_lock, 
>> _mutex);
>> (gdb)
>>
>> So this appears to be hung taking the mutex on "heapmem_main".  I'm 
>> not running any other Xenomai programs on this system when this 
>> happens so I presume it's locked by another thread in this program but 
>> we haven't even made it to main() yet.
>>
>>
>> This is a stock 3.1 build using the stock /usr/bin/rtcanrecv test 
>> program.
>>
>>
>> Any thoughts?
>>
> 
> Trying to reproduce via qemu-armhf target of xenomai-images. Are you on 
> kernel 4.19.55?
> 

It's not reproducible in that qemu target with xeno_can_virt devices. 
Can you specify the differences in your config?

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

