References: <008d01d40ef4$aa152ab0$fe3f8010$@sepro-group.com>
 <f91caf3e-5b65-298a-1ac6-91697eed90c3@xenomai.org>
 <00a901d40f76$771290d0$6537b270$@sepro-group.com>
 <56e66ad7-91b7-2b6a-f953-507d2493a27e@xenomai.org>
 <002f01d4136c$3bdf9090$b39eb1b0$@sepro-group.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <4d8d5350-df55-a670-f929-57b9b45353a4@xenomai.org>
Date: Wed, 4 Jul 2018 11:29:54 +0200
MIME-Version: 1.0
In-Reply-To: <002f01d4136c$3bdf9090$b39eb1b0$@sepro-group.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] Assertion current-magic 0 failed
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: =?UTF-8?Q?St=c3=a9phane_Reichert?= <sreichert@sepro-group.com>, xenomai@xenomai.org

On 07/04/2018 09:54 AM, Stéphane Reichert wrote:
> Hi Philippe:
> 
> Thanks for your answer. In fact, the assertion occurs when I call these two 
> statements at the end of sigdebug_handler:
>    signal (sig, SIG_DFL);
>    kill (getpid(), sig);
> 
> You can find below the answers you asked for:
> 
> Backtrace reported by the debugger:
> ------------------------------------------------
> Mode switch (reason: triggered fault), aborting. Backtrace:

The mode switch is due to a memory access fault, and looking at the
implementation of rt_heap_bind(), the only reason for this to happen in
such situation would be that alchemy_init() did not run prior to calling
rt_heap_bind().

In other words, I suspect that auto-init was disabled via xeno-config,
but xenomai_init() was not yet called when rt_heap_bind() is issued.
Would that be a plausible scenario?

> /root/tests_integration_lib_ipc(sigdebug_handler+0x120)[0x12200]
> /lib/libc.so.6(+0x25150)[0x76d56150]
> /lib/libcopperplate.so.0(syncobj_lock+0x84)[0x76ecd7e8]
> /lib/libcopperplate.so.0(syncluster_findobj+0x34)[0x76ecbeec]
> /lib/libalchemy.so.0(alchemy_bind_object+0x98)[0x76ef11c0]
> /lib/libalchemy.so.0(rt_heap_bind+0x30)[0x76ef41c4]
> /root/libs/lib_ipc.so(init_local_data+0x60)[0x76fc385c]
> /root/libs/lib_ipc.so(rt_shm_open+0x70)[0x76fc3bfc]
> /root/tests_integration_lib_ipc[0x12d08]
> /lib/libalchemy.so.0(+0xa448)[0x76ef6448]
> /lib/libcopperplate.so.0(+0x8314)[0x76ecd314]
> /lib/libcobalt.so.2(+0x1058c)[0x76ea858c]
> 
> tests_integration_lib_ipc: threadobj.c:1344: threadobj_prologue: Assertion 
> `current->magic == 0' failed.
> 
> This log is displayed in the sigdebug_handler when I call rt_heap_bind 
> (switch into secondary mode).
> 
> Kernel Panic:
> -----------------
> . We have adapted the ipipe-core-patch-4.1.18 -arm-10.patch to our kernel 
> (4.1.46).
> . The kernel is compiled with these options for xenomai : full-debug, 
> registry on, relax traces on.
> . The problem occurs when we call the kill at the end of the 
> sigdebug_handler (same function as in the "Finding
> spurious relaxes" example).
> . The result of the addr2line gives me :
> ..../kernel/xenomai/posix/signal.c:75
> This line code is (line 75 - function cobalt_signal_deliver):
>     if (sigismember(swc->set, sig))
> 

That kernel panic has to be fixed, however I have not been able to
reproduce it yet. If you could either send me a basic test code
triggering the issue, or the executable causing the fault (no source
needed), that would help.

-- 
Philippe.

