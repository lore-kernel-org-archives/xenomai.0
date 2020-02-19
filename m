Subject: Re: xenomai app running under gdb hangs on 3.1/arm32
References: <76cffbb0-cd34-760d-9e4b-a4dafa3bc19c@freyder.net>
 <d89b5115-6837-46f4-7cf3-1b70f25b64ce@siemens.com>
 <76d7c7af-4d41-8546-6714-b4bfb947f686@siemens.com>
 <4ba86f82-cd74-da16-a9eb-81a488c9708a@freyder.net>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <2577342c-53e7-c9e5-17dc-5c5027125a41@siemens.com>
Date: Wed, 19 Feb 2020 16:36:13 +0100
MIME-Version: 1.0
In-Reply-To: <4ba86f82-cd74-da16-a9eb-81a488c9708a@freyder.net>
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

On 19.02.20 15:58, steve freyder via Xenomai wrote:
> On 2/19/2020 4:02 AM, Jan Kiszka wrote:
>> On 19.02.20 09:56, Jan Kiszka via Xenomai wrote:
>>> On 18.02.20 23:33, steve freyder via Xenomai wrote:
>>>> Hello again Xenomai group,
>>>>
>>>>
>>>> Was testing gdb on xenomai 3.1, ran into this (Xenomai 3.1 on 
>>>> armv7-a, iMX6-dual-lite)
>>>>
>>>> root@g3l-21:~ # gdb /usr/bin/rtcanrecv
>>>> GNU gdb (GDB) 8.3.1
>>>> Copyright (C) 2019 Free Software Foundation, Inc.
>>>> License GPLv3+: GNU GPL version 3 or later 
>>>> <http://gnu.org/licenses/gpl.html>
>>>> This is free software: you are free to change and redistribute it.
>>>> There is NO WARRANTY, to the extent permitted by law.
>>>> Type "show copying" and "show warranty" for details.
>>>> This GDB was configured as "arm-emac-linux-gnueabi".
>>>> Type "show configuration" for configuration details.
>>>> For bug reporting instructions, please see:
>>>> <http://www.gnu.org/software/gdb/bugs/>.
>>>> Find the GDB manual and other documentation resources online at:
>>>>      <http://www.gnu.org/software/gdb/documentation/>.
>>>>
>>>> For help, type "help".
>>>> Type "apropos word" to search for commands related to "word"...
>>>> Reading symbols from /usr/bin/rtcanrecv...
>>>> (No debugging symbols found in /usr/bin/rtcanrecv)
>>>> (gdb) break main
>>>> Breakpoint 1 at 0x10d50
>>>> (gdb) run --trace=10
>>>> Starting program: /usr/bin/rtcanrecv --trace=10
>>>> warning: Unable to find libthread_db matching inferior's thread 
>>>> library, thread debugging will not be available.
>>>> --  cold init from program
>>>> --  cobalt->init()
>>>> --  connected to Cobalt
>>>> --  memory locked
>>>> --  memory heaps mapped
>>>> [New LWP 1931]
>>>> --  boilerplate->init()
>>>>
>>>> -- copperplate->init()
>>>>
>>>>
>>>> [ at this point the program is hung, so press Control-C ]
>>>>
>>>> ^C
>>>> Thread 1 "rtcanrecv" received signal SIGINT, Interrupt.
>>>> 0x76fca4a0 in __cobalt_pthread_mutex_lock (mutex=0x484c20c8 
>>>> <heapmem_main>) at 
>>>> /home/sdf/xenobuild/imx-xenomai/xenomai-3.1/lib/cobalt/mutex.c:375
>>>> 375                     ret = XENOMAI_SYSCALL1(sc_cobalt_mutex_lock, 
>>>> _mutex);
>>>> (gdb)
>>>>
>>>> So this appears to be hung taking the mutex on "heapmem_main".  I'm 
>>>> not running any other Xenomai programs on this system when this 
>>>> happens so I presume it's locked by another thread in this program 
>>>> but we haven't even made it to main() yet.
>>>>
>>>>
>>>> This is a stock 3.1 build using the stock /usr/bin/rtcanrecv test 
>>>> program.
>>>>
>>>>
>>>> Any thoughts?
>>>>
>>>
>>> Trying to reproduce via qemu-armhf target of xenomai-images. Are you 
>>> on kernel 4.19.55?
>>>
>>
>> It's not reproducible in that qemu target with xeno_can_virt devices. 
>> Can you specify the differences in your config?
>>
>> Jan
>>
> Jan,
> 
> 
> My kernel is 4.14.85.  Below is my Xenomai configuration from 
> --dump-config, and attached is the config.gz from the Linux kernel.

Could you try getting closer with your setup to what we support (4.14 is 
EOL, e.g., compiler is very old - all that might be unrelated, but we 
can't test them all)?

If there are major technical hurdles for that, I need at least some gdb 
backtrace from the hanging bootup to give further hints where to look at 
or actually try to reproduce here.

My problem: ARM (and ARM64) is really best-effort for me, and we 
currently lack someone in the Xenomai community to look after it (them) 
after Philippe stepped back.

Jan

> 
> ------------------------------------------------------------------------
> 
> 
> based on Xenomai/cobalt v3.1
> CONFIG_MMU=1
> CONFIG_SMP=1
> CONFIG_XENO_BUILD_ARGS=" 'CFLAGS=-march=armv7-a -g -O0' 
> '--with-core=cobalt' '--enable-smp' '--enable-pshared' 
> '--host=arm-emac-linux-gnueabi' 'host_alias=arm-emac-linux-gnueabi' 
> 'CC=arm-emac-linux-gnueabi-gcc  -march=armv7-a -mfpu=neon 
> -mfloat-abi=softfp 
> --sysroot=/opt/emac/5.1/sysroots/armv7a-neon-emac-linux-gnueabi' 
> 'LDFLAGS=-Wl,-O1 -Wl,--hash-style=gnu -Wl,--as-needed' 'CPPFLAGS=' 
> 'CPP=arm-emac-linux-gnueabi-gcc -E  -march=armv7-a -mfpu=neon 
> -mfloat-abi=softfp 
> --sysroot=/opt/emac/5.1/sysroots/armv7a-neon-emac-linux-gnueabi' 
> 'PKG_CONFIG_PATH=/opt/emac/5.1/sysroots/armv7a-neon-emac-linux-gnueabi/usr/lib/pkgconfig'" 
> 
> CONFIG_XENO_BUILD_STRING="x86_64-pc-linux-gnu"
> CONFIG_XENO_COBALT=1
> CONFIG_XENO_COMPILER="gcc version 5.3.0 (GCC) "
> CONFIG_XENO_DEFAULT_PERIOD=1000000
> CONFIG_XENO_FORTIFY=1
> CONFIG_XENO_HEAPMEM=1
> CONFIG_XENO_HOST_STRING="arm-emac-linux-gnueabi"
> CONFIG_XENO_LORES_CLOCK_DISABLED=1
> CONFIG_XENO_PREFIX="/usr/xenomai"
> CONFIG_XENO_PSHARED=1
> CONFIG_XENO_RAW_CLOCK_ENABLED=1
> CONFIG_XENO_REVISION_LEVEL=
> CONFIG_XENO_SANITY=1
> CONFIG_XENO_TLS_MODEL="initial-exec"
> CONFIG_XENO_UAPI_LEVEL=15
> CONFIG_XENO_VERSION_MAJOR=3
> CONFIG_XENO_VERSION_MINOR=1
> CONFIG_XENO_VERSION_STRING="3.1"
> ---
> CONFIG_XENO_ASYNC_CANCEL is OFF
> CONFIG_XENO_COPPERPLATE_CLOCK_RESTRICTED is OFF
> CONFIG_XENO_DEBUG is OFF
> CONFIG_XENO_DEBUG_FULL is OFF
> CONFIG_XENO_LAZY_SETSCHED is OFF
> CONFIG_XENO_LIBS_DLOPEN is OFF
> CONFIG_XENO_MERCURY is OFF
> CONFIG_XENO_REGISTRY is OFF
> CONFIG_XENO_REGISTRY_ROOT is OFF
> CONFIG_XENO_TLSF is OFF
> CONFIG_XENO_VALGRIND_API is OFF
> CONFIG_XENO_WORKAROUND_CONDVAR_PI is OFF
> CONFIG_XENO_X86_VSYSCALL is OFF
> ---
> PTHREAD_STACK_DEFAULT=65536
> AUTOMATIC_BOOTSTRAP=1
> 
> -------------- next part --------------
> A non-text attachment was scrubbed...
> Name: config.gz
> Type: application/x-gzip
> Size: 25269 bytes
> Desc: not available
> URL: 
> <http://xenomai.org/pipermail/xenomai/attachments/20200219/5405fc9a/attachment.bin> 
> 

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

