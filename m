References: <5AC116C9.6040809@freyder.net>
 <15a83f1d-7785-11c9-5f64-c09cb035ff10@xenomai.org>
From: Steve Freyder <steve@freyder.net>
Message-ID: <5AC24433.30107@freyder.net>
Date: Mon, 2 Apr 2018 09:54:43 -0500
MIME-Version: 1.0
In-Reply-To: <15a83f1d-7785-11c9-5f64-c09cb035ff10@xenomai.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Possible Xenomai fuse filesystem/registry queue
 status files issue?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 4/2/2018 8:41 AM, Philippe Gerum wrote:
> On 04/01/2018 07:28 PM, Steve Freyder wrote:
>> Greetings again.
>>
>> As I understand it, for each rt_queue there's supposed to be a
>> "status file" located in the fuse filesystem underneath the
>> "/run/xenomai/user/session/pid/alchemy/queues" directory, with
>> the file name being the queue name.  This used to contain very
>> useful info about queue status, message counts, etc.  I don't know
>> when it broke or whether it's something I'm doing wrong but I'm
>> now getting a "memory exhausted" message on the console when I
>> attempt to do a "cat" on the status file.
>>
>> Here's a small C program that just creates a queue, and then does
>> a pause to hold the accessor count non-zero.
>>
> <snip>
>
>> The resulting output (logged in via the system console):
>>
>> # sh qtest.sh
>> + sleep 1
>> + ./qc --mem-pool-size=64M --session=mysession foo
>> + find /run/xenomai
>> /run/xenomai
>> /run/xenomai/root
>> /run/xenomai/root/mysession
>> /run/xenomai/root/mysession/821
>> /run/xenomai/root/mysession/821/alchemy
>> /run/xenomai/root/mysession/821/alchemy/tasks
>> /run/xenomai/root/mysession/821/alchemy/tasks/task@1[821]
>> /run/xenomai/root/mysession/821/alchemy/queues
>> /run/xenomai/root/mysession/821/alchemy/queues/foo
>> /run/xenomai/root/mysession/system
>> /run/xenomai/root/mysession/system/threads
>> /run/xenomai/root/mysession/system/heaps
>> /run/xenomai/root/mysession/system/version
>> + qfile='/run/xenomai/*/*/*/alchemy/queues/foo'
>> + cat /run/xenomai/root/mysession/821/alchemy/queues/foo
>> memory exhausted
>>
>> At this point, it hangs, although SIGINT usually terminates it.
>>
>> I've seen some cases where SIGINT won't terminate it, and a reboot is
>> required to clean things up.  I see this message appears to be logged
>> in the obstack error handler.  I don't think I'm running out of memory,
>> which makes me think "heap corruption".  Not much of an analysis!  I did
>> try varying queue sizes and max message counts - no change.
>>
> I can't reproduce this. I would suspect a rampant memory corruption too,
> although running the test code over valgrind (mercury build) did not
> reveal any issue.
>
> - which Xenomai version are you using?
> - cobalt / mercury ?
> - do you enable the shared heap when configuring ? (--enable-pshared)
>

I'm using Cobalt.  uname -a reports:

Linux sdftest 4.1.18_C01571-15S00-00.000.zimg+83fdace666 #2 SMP Fri Mar 
9 11:07:52 CST 2018 armv7l GNU/Linux

Here is the config dump:

CONFIG_MMU=1
CONFIG_SMP=1
CONFIG_XENO_BUILD_ARGS=" '--build=x86_64-linux' 
'--host=arm-emac-linux-gnueabi' '--target=arm-emac-linux-gnueabi' 
'--with-core=cobalt' '--enable-pshared' '--enable-smp' '--prefix=/usr' 
'--exec_prefix=/usr' '--includedir=/usr/include/xenomai' 
'--enable-registry' 'build_alias=x86_64-linux' 
'host_alias=arm-emac-linux-gnueabi' 
'target_alias=arm-emac-linux-gnueabi' 'CC=arm-emac-linux-gnueabi-gcc  
-march=armv7-a -mfpu=neon -mfloat-abi=softfp 
--sysroot=/home/developer/oe/build_c01571-15/tmp/sysroots/c01571-15' 
'CFLAGS=-march=armv7-a' 'LDFLAGS=-D_FILE_OFFSET_BITS=64 
-I/home/developer/oe/build_c01571-15/tmp/sysroots/c01571-15/usr/include/fuse 
-lfuse -pthread' 'CPPFLAGS=' 'CPP=arm-emac-linux-gnueabi-gcc -E 
--sysroot=/home/developer/oe/build_c01571-15/tmp/sysroots/c01571-15 
-march=armv7-a -mfpu=neon  -mfloat-abi=softfp' 
'PKG_CONFIG_PATH=/home/developer/oe/build_c01571-15/tmp/sysroots/c01571-15/usr/lib/pkgconfig:/home/developer/oe/build_c01571-15/tmp/sysroots/c01571-15/usr/share/pkgconfig' 
'PKG_CONFIG_LIBDIR=/home/developer/oe/build_c01571-15/tmp/sysroots/c01571-15/usr/lib/pkgconfig'"
CONFIG_XENO_BUILD_STRING="x86_64-pc-linux-gnu"
CONFIG_XENO_COBALT=1
CONFIG_XENO_COMPILER="gcc version 5.3.0 (GCC) "
CONFIG_XENO_DEFAULT_PERIOD=1000000
CONFIG_XENO_FORTIFY=1
CONFIG_XENO_HOST_STRING="arm-emac-linux-gnueabi"
CONFIG_XENO_LORES_CLOCK_DISABLED=1
CONFIG_XENO_PREFIX="/usr"
CONFIG_XENO_PSHARED=1
CONFIG_XENO_RAW_CLOCK_ENABLED=1
CONFIG_XENO_REGISTRY=1
CONFIG_XENO_REGISTRY_ROOT="/var/run/xenomai"
CONFIG_XENO_REVISION_LEVEL=6
CONFIG_XENO_SANITY=1
CONFIG_XENO_TLSF=1
CONFIG_XENO_TLS_MODEL="initial-exec"
CONFIG_XENO_UAPI_LEVEL=14
CONFIG_XENO_VERSION_MAJOR=3
CONFIG_XENO_VERSION_MINOR=0
CONFIG_XENO_VERSION_NAME="Stellar Parallax"
CONFIG_XENO_VERSION_STRING="3.0.6"
---
CONFIG_XENO_ASYNC_CANCEL is OFF
CONFIG_XENO_COPPERPLATE_CLOCK_RESTRICTED is OFF
CONFIG_XENO_DEBUG is OFF
CONFIG_XENO_DEBUG_FULL is OFF
CONFIG_XENO_LIBS_DLOPEN is OFF
CONFIG_XENO_MERCURY is OFF
CONFIG_XENO_VALGRIND_API is OFF
CONFIG_XENO_WORKAROUND_CONDVAR_PI is OFF
CONFIG_XENO_X86_VSYSCALL is OFF
---
PTHREAD_STACK_DEFAULT=65536
AUTOMATIC_BOOTSTRAP=1

Best regards,
Steve


