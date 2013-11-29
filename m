Message-ID: <52985FBF.8090608@xenomai.org>
Date: Fri, 29 Nov 2013 10:34:55 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <20131128143152.04ac3eab.norbert.bukuli@mediso.hu>	<5297BD30.4060007@xenomai.org>
 <20131129094157.3d7202e1.norbert.bukuli@mediso.hu>
 <52985E94.4070101@xenomai.org>
In-Reply-To: <52985E94.4070101@xenomai.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] test suite programs crash with Illegal instruction on
 MPC5200
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Bukuli Norbert <norbert.bukuli@mediso.hu>
Cc: Xenomai <xenomai@xenomai.org>

On 11/29/2013 10:29 AM, Philippe Gerum wrote:
> On 11/29/2013 09:41 AM, Bukuli Norbert wrote:
>> (gdb) cont
>> Continuing.
>> warning: Could not load shared library symbols for linux-vdso32.so.1.
>> Do you need "set solib-search-path" or "set sysroot"?
>> warning: .dynamic section for
>> "/opt/eldk-5.4/powerpc/sysroots/powerpc-linux/usr/xenomai/lib/libpthread_rt.so.1"
>> is not at the expected address (wrong library or version mismatch?)
>> warning: .dynamic section for
>> "/opt/eldk-5.4/powerpc/sysroots/powerpc-linux/usr/xenomai/lib/libxenomai.so.0"
>> is not at the expected address (wrong library or version mismatch?)
>
> These warnings may trigger with recent broken gdbserver releases, let's
> ignore them.
> https://sourceware.org/ml/gdb-patches/2013-06/msg00054.html
>
>> [New Thread 280]
>>
>> Program received signal SIGILL, Illegal instruction.
>> [Switching to Thread 280]
>> 0x0fdf4e74 in ?? () from
>> /opt/eldk-5.4/powerpc/sysroots/powerpc-linux/lib/libc.so.6
>>
>
> (gdb) disass $pc-64 $pc+20
>
> would help at this point.
>
>> (gdb) bt
>> #0  0x0fdf4e74 in ?? () from
>> /opt/eldk-5.4/powerpc/sysroots/powerpc-linux/lib/libc.so.6
>> #1  0x0ffd8af8 in sched_setconfig_np ()
>>     from
>> /opt/eldk-5.4/powerpc/sysroots/powerpc-linux/usr/xenomai/lib/libpthread_rt.so.1
>>
>> #2  0x0ff7ba68 in start_thread (arg=0xbffffdd0) at pthread_create.c:313
>
> Is sched_setconfig_np() really the start routine given to
> pthread_create() in your application, I guess not. Or could this weird
> backtrace reveal a stack overflow?

Or maybe just too much frame information is optimized out, too 
aggressively. You may want to turn on debug symbols for building the 
Xenomai libraries, using --enable-debug.

-- 
Philippe.

