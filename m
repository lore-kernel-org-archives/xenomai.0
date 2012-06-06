Message-ID: <4FCF47CB.4010703@xenomai.org>
Date: Wed, 06 Jun 2012 14:06:35 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <CAKKWdtfz7+pRjjbE6Ev4zJNZpa45axMePyVar+3MyRyMvcp8aA@mail.gmail.com>
	<4FCF1517.3010904@xenomai.org>
	<CAKKWdtfRyuhDzmvCC-WM66+=ncs+ocbdUuop2TRNThsj6ZAy6g@mail.gmail.com>
	<4FCF1ED5.5000403@xenomai.org>
	<CAKKWdtd6p2-xHH1FdjVzbX-raNtDkvMemALrQBJMgoTb1dScnw@mail.gmail.com>
	<4FCF2751.5070700@xenomai.org>
	<CAKKWdteRr1gy76GCbCjpU-1tCQM-o+wpCNV9eDPUZ0uoCju7rQ@mail.gmail.com>
In-Reply-To: <CAKKWdteRr1gy76GCbCjpU-1tCQM-o+wpCNV9eDPUZ0uoCju7rQ@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] xenomai-2.6.0 instrumentation commands not executing
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: ali hagigat <hagigatali@gmail.com>
Cc: Xenomai@xenomai.org

On 06/06/2012 12:47 PM, ali hagigat wrote:
> I still have the problem:
>

This is obviously not the same problem.

> /root/build/xenomai/xenomai-2.6.0>  ./configure --enable-smp
> CFLAGS=-fno-omit-frame-pointers
> checking build system type... i686-pc-linux-gnu
> checking host system type... i686-pc-linux-gnu
> checking for a BSD-compatible install... /usr/bin/install -c
> checking for gcc... gcc
> checking whether the C compiler works... no
> configure: error: in `/root/build/xenomai/xenomai-2.6.0':
> configure: error: C compiler cannot create executables
> See `config.log' for more details

What about doing what the tool recommends? config.log chokes on the 
option due to the extraneous 's'.

It's -fno-omit-frame-pointer.

>
> On Wed, Jun 6, 2012 at 2:18 PM, Philippe Gerum<rpm@xenomai.org>  wrote:
>> On 06/06/2012 11:18 AM, ali hagigat wrote:
>>>
>>> Much appreciate for the reply, Mr. Gerum. Here is the result of ldd
>>> command:
>>>
>>
>> http://www.xenomai.org/pipermail/xenomai-help/2011-12/msg00012.html
>>
>>
>>> /usr/xenomai/bin>    ldd switchtest
>>>         linux-gate.so.1 =>     (0xb786c000)
>>>         libpthread_rt.so.1 =>    /usr/xenomai/lib/libpthread_rt.so.1
>>> (0xb785f000)
>>>         libxenomai.so.0 =>    /usr/xenomai/lib/libxenomai.so.0 (0xb7859000)
>>>         libpthread.so.0 =>    /lib/libpthread.so.0 (0x0058e000)
>>>         librt.so.1 =>    /lib/librt.so.1 (0x005c3000)
>>>         libc.so.6 =>    /lib/libc.so.6 (0x003cd000)
>>>         /lib/ld-linux.so.2 (0x003a7000)
>>> /usr/xenomai/bin>    ldd switchbench
>>> ldd: ./switchbench: No such file or directory
>>> /usr/xenomai/bin>    cd /root
>>> /root>    ldd switchtest
>>> ldd: ./switchtest: No such file or directory
>>>
>>>
>>> On Wed, Jun 6, 2012 at 1:41 PM, Philippe Gerum<rpm@xenomai.org>    wrote:
>>>>
>>>> On 06/06/2012 11:06 AM, ali hagigat wrote:
>>>>>
>>>>>
>>>>> Thank you, Philippe, for the reply.
>>>>>
>>>>> How can i enable posix skin? should i do , make menuconfig, for the
>>>>> kernel? Or i should change scripts/defconfig.frag?
>>>>>
>>>>> It seems that both places have the correct values already but i still
>>>>> have the error:
>>>>
>>>>
>>>>
>>>> The POSIX skin is indeed enabled. What is the output of the command
>>>> below?
>>>>
>>>> # ldd<your-executable>
>>>>
>>>>
>>>>>
>>>>> defconfig.frag:
>>>>> #
>>>>> # Interfaces
>>>>> #
>>>>> CONFIG_XENO_SKIN_NATIVE=y
>>>>>
>>>>> #
>>>>> # Native interface options
>>>>> #
>>>>> CONFIG_XENO_OPT_NATIVE_PERIOD=0
>>>>> CONFIG_XENO_OPT_NATIVE_PIPE=y
>>>>> CONFIG_XENO_OPT_NATIVE_PIPE_BUFSZ=4096
>>>>> CONFIG_XENO_OPT_NATIVE_SEM=y
>>>>> CONFIG_XENO_OPT_NATIVE_EVENT=y
>>>>> CONFIG_XENO_OPT_NATIVE_MUTEX=y
>>>>> CONFIG_XENO_OPT_NATIVE_COND=y
>>>>> CONFIG_XENO_OPT_NATIVE_QUEUE=y
>>>>> CONFIG_XENO_OPT_NATIVE_HEAP=y
>>>>> CONFIG_XENO_OPT_NATIVE_ALARM=y
>>>>> CONFIG_XENO_OPT_NATIVE_MPS=y
>>>>> # CONFIG_XENO_OPT_NATIVE_INTR is not set
>>>>> CONFIG_XENO_SKIN_POSIX=y
>>>>>
>>>>> and in the kernel:
>>>>> # Interfaces
>>>>> #
>>>>> CONFIG_XENO_SKIN_NATIVE=y
>>>>> CONFIG_XENO_OPT_NATIVE_PERIOD=0
>>>>> CONFIG_XENO_OPT_NATIVE_PIPE=y
>>>>> CONFIG_XENO_OPT_NATIVE_PIPE_BUFSZ=1024
>>>>> CONFIG_XENO_OPT_NATIVE_SEM=y
>>>>> CONFIG_XENO_OPT_NATIVE_EVENT=y
>>>>> CONFIG_XENO_OPT_NATIVE_MUTEX=y
>>>>> CONFIG_XENO_OPT_NATIVE_COND=y
>>>>> CONFIG_XENO_OPT_NATIVE_QUEUE=y
>>>>> CONFIG_XENO_OPT_NATIVE_BUFFER=y
>>>>> CONFIG_XENO_OPT_NATIVE_HEAP=y
>>>>> CONFIG_XENO_OPT_NATIVE_ALARM=y
>>>>> CONFIG_XENO_OPT_NATIVE_MPS=y
>>>>> CONFIG_XENO_OPT_NATIVE_INTR=y
>>>>> CONFIG_XENO_OPT_DEBUG_NATIVE=y
>>>>> CONFIG_XENO_SKIN_POSIX=y
>>>>> CONFIG_XENO_OPT_POSIX_PERIOD=0
>>>>> CONFIG_XENO_OPT_POSIX_SHM=y
>>>>> CONFIG_XENO_OPT_POSIX_INTR=y
>>>>> CONFIG_XENO_OPT_POSIX_SELECT=y
>>>>> CONFIG_XENO_OPT_DEBUG_POSIX=y
>>>>> # CONFIG_XENO_SKIN_PSOS is not set
>>>>> # CONFIG_XENO_SKIN_UITRON is not set
>>>>> # CONFIG_XENO_SKIN_VRTX is not set
>>>>> CONFIG_XENO_SKIN_VXWORKS=y
>>>>> CONFIG_XENO_OPT_VXWORKS_PERIOD=1000
>>>>> CONFIG_XENO_OPT_DEBUG_VXWORKS=y
>>>>> # CONFIG_XENO_OPT_NOWARN_DEPRECATED is not set
>>>>> CONFIG_XENO_SKIN_RTDM=y
>>>>> CONFIG_XENO_OPT_RTDM_PERIOD=0
>>>>> CONFIG_XENO_OPT_RTDM_FILDES=128
>>>>> CONFIG_XENO_OPT_RTDM_SELECT=y
>>>>> # CONFIG_XENO_OPT_DEBUG_RTDM is not set
>>>>> CONFIG_XENO_OPT_DEBUG_RTDM_APPL=y
>>>>>
>>>>>
>>>>> On Wed, Jun 6, 2012 at 1:00 PM, Philippe Gerum<rpm@xenomai.org>
>>>>>   wrote:
>>>>>>
>>>>>>
>>>>>> On 06/06/2012 09:40 AM, ali hagigat wrote:
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>> I have installed xenomai-2.6.0. None of the instrumentation commands
>>>>>>> work except latency. What can i do?
>>>>>>>
>>>>>>
>>>>>> Likely fix your Kconfig. Enable the Xenomai POSIX skin.
>>>>>>
>>>>>>> /root>        switchbench
>>>>>>> bash: switchbench: command not found
>>>>>>> /root>        switchtest
>>>>>>> Xenomai Posix skin init: pthread_setschedparam: Function not
>>>>>>> implemented
>>>>>>> /root>        cyclictest
>>>>>>> Xenomai Posix skin init: pthread_setschedparam: Function not
>>>>>>> implemented
>>>>>>> /root>        latency
>>>>>>> == Sampling period: 100 us
>>>>>>> == Test mode: periodic user-mode task
>>>>>>> == All results in microseconds
>>>>>>>
>>>>>>> /root>        xeno-test
>>>>>>> Started child 7172: /bin/bash /usr/xenomai/bin/xeno-test-run-wrapper
>>>>>>> /usr/xenomai/bin/xeno-test
>>>>>>> ++ echo 0
>>>>>>> ++ /usr/xenomai/bin/arith
>>>>>>> mul: 0x79364d93, shft: 26
>>>>>>> integ: 30, frac: 0x4d9364d9364d9364
>>>>>>>
>>>>>>> signed positive operation: 0x03ffffffffffffff * 1000000000 / 33000000
>>>>>>> inline calibration: 0x0000000000000000: 28.751 ns, rejected 1/10000
>>>>>>> inlined llimd: 0x79364d9364d9362f: 41.292 ns, rejected 1/10000
>>>>>>> inlined llmulshft: 0x79364d92ffffffe1: 5.007 ns, rejected 0/10000
>>>>>>> inlined nodiv_llimd: 0x79364d9364d9362f: 11.323 ns, rejected 1/10000
>>>>>>> out of line calibration: 0x0000000000000000: 30.003 ns, rejected
>>>>>>> 0/10000
>>>>>>> out of line llimd: 0x79364d9364d9362f: 46.075 ns, rejected 1/10000
>>>>>>> out of line llmulshft: 0x79364d92ffffffe1: 7.800 ns, rejected 1/10000
>>>>>>> out of line nodiv_llimd: 0x79364d9364d9362f: 16.683 ns, rejected
>>>>>>> 1/10000
>>>>>>>
>>>>>>> signed negative operation: 0xfc00000000000001 * 1000000000 / 33000000
>>>>>>> inline calibration: 0x0000000000000000: 29.298 ns, rejected 1/10000
>>>>>>> inlined llimd: 0x86c9b26c9b26c9d1: 39.658 ns, rejected 1/10000
>>>>>>> inlined llmulshft: 0x86c9b26d0000001e: 4.059 ns, rejected 0/10000
>>>>>>> inlined nodiv_llimd: 0x86c9b26c9b26c9d1: 16.976 ns, rejected 0/10000
>>>>>>> out of line calibration: 0x0000000000000000: 30.002 ns, rejected
>>>>>>> 1/10000
>>>>>>> out of line llimd: 0x86c9b26c9b26c9d1: 48.757 ns, rejected 0/10000
>>>>>>> out of line llmulshft: 0x86c9b26d0000001e: 11.085 ns, rejected 1/10000
>>>>>>> out of line nodiv_llimd: 0x86c9b26c9b26c9d1: 17.770 ns, rejected
>>>>>>> 1/10000
>>>>>>>
>>>>>>> unsigned operation: 0x03ffffffffffffff * 1000000000 / 33000000
>>>>>>> inline calibration: 0x0000000000000000: 28.749 ns, rejected 1/10000
>>>>>>> inlined nodiv_ullimd: 0x79364d9364d9362f: 16.264 ns, rejected 0/10000
>>>>>>> out of line calibration: 0x0000000000000000: 30.001 ns, rejected
>>>>>>> 0/10000
>>>>>>> out of line nodiv_ullimd: 0x79364d9364d9362f: 20.463 ns, rejected
>>>>>>> 1/10000
>>>>>>> ++ /usr/xenomai/bin/clocktest -T 30
>>>>>>> Xenomai Posix skin init: pthread_setschedparam: Function not
>>>>>>> implemented
>>>>>>>
>>>>>>>
>>>>>>> Only latency seems working.
>>>>>>>
>>>>>>> _______________________________________________
>>>>>>> Xenomai mailing list
>>>>>>> Xenomai@xenomai.org
>>>>>>> http://www.xenomai.org/mailman/listinfo/xenomai
>>>>>>>
>>>>>>
>>>>>>
>>>>>> --
>>>>>> Philippe.
>>>>>
>>>>>
>>>>>
>>>>
>>>>
>>>> --
>>>> Philippe.
>>>
>>>
>>
>>
>> --
>> Philippe.
>


-- 
Philippe.

