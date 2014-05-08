Message-ID: <536BA891.3060605@xenomai.org>
Date: Thu, 08 May 2014 17:53:53 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <20140502141307.B6A14EC0@centrum.cz>,
 <53639AC8.1000507@xenomai.org>, <20140506101735.3A0BEBEB@centrum.cz>,
 <5368A3A2.1010302@xenomai.org>,
 <20140506112918.F5E14FAA@centrum.cz> <5368DC2C.5000505@xenomai.org>
 <20140507151310.0F980ADD@centrum.cz>
In-Reply-To: <20140507151310.0F980ADD@centrum.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] non-blocking rt_task_suspend(NULL)
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Petr Cervenka <grugh@centrum.cz>, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai <xenomai@xenomai.org>

On 05/07/2014 03:13 PM, Petr Cervenka wrote:
>> Od: Philippe Gerum <rpm@xenomai.org>
>>>
>>> Here it is. It's full of modules and other perhaps not so real-time 
>>> settings, because it was derived from Kubuntu kernel config file.
>>>
>>
>> Thanks. The issue seems to happen as a result of a relax -> harden 
>> transition racing with a signal receipt. In order to help me ruling 
>> out some assumptions, could you please apply the patch below, and 
>> confirm that no job control is involved (SIGCONT/SIGSTOP) in your 
>> application?
>>
>> Knowing whether any of the two warnings added by this patch is issued 
>> when the bug happens would also help solving the issue, TIA.
>>
>> diff --git a/ksrc/nucleus/pod.c b/ksrc/nucleus/pod.c
>> index 0a2ee19..9fb797f 100644
>> --- a/ksrc/nucleus/pod.c
>> +++ b/ksrc/nucleus/pod.c
>> @@ -1379,15 +1379,17 @@ void xnpod_suspend_thread(xnthread_t *thread, 
>> xnflags_t mask,
>>          * context, to collect and act upon the pending Linux
>>          * signal.
>>          */
>> -        if ((mask & XNRELAX) == 0 &&
>> -            xnthread_test_info(thread, XNKICKED)) {
>> -            if (wchan) {
>> -                thread->wchan = wchan;
>> -                xnsynch_forget_sleeper(thread);
>> +        if (xnthread_test_info(thread, XNKICKED)) {
>> +            if ((mask & XNRELAX) == 0) {
>> +                if (wchan) {
>> +                    thread->wchan = wchan;
>> +                    xnsynch_forget_sleeper(thread);
>> +                }
>> +                xnthread_clear_info(thread, XNRMID | XNTIMEO);
>> +                xnthread_set_info(thread, XNBREAK);
>> +                goto unlock_and_exit;
>>             }
>> -            xnthread_clear_info(thread, XNRMID | XNTIMEO);
>> -            xnthread_set_info(thread, XNBREAK);
>> -            goto unlock_and_exit;
>> +            WARN_ON(1);
>>         }
>> #endif /* CONFIG_XENO_OPT_PERVASIVE */
>>
>> diff --git a/ksrc/nucleus/shadow.c b/ksrc/nucleus/shadow.c
>> index 38c1423..fc592a2 100644
>> --- a/ksrc/nucleus/shadow.c
>> +++ b/ksrc/nucleus/shadow.c
>> @@ -2696,6 +2696,8 @@ static inline void do_sigwake_event(struct 
>> task_struct *p)
>>         }
>>     }
>>
>> +    WARN_ON(!signal_pending(p));
>> +
>>     /*
>>      * If a relaxed thread is getting a signal while running, we
>>      * force it out of RPI, so that it won't keep a boosted
>> -- 
> 
> Finally, I was able to catch the warning(s). I got 38 of these before 
> task ended:
> 
> [ 1109.336726] ------------[ cut here ]------------
> [ 1109.336737] WARNING: at kernel/xenomai/nucleus/pod.c:1392 
> xnpod_suspend_thread+0x17d/0x5a0()
> [ 1109.336746] Hardware name: X7SBA
> [ 1109.336755] Modules linked in: fr01_rtdm(O) netconsole configfs igb 
> dca e1000e e1000 r8169 rt_e1000(O) rt_r8169(O) rtpacket(O) rtnet(O) 
> coretemp psmouse microcode serio_raw shpchp lpc_ich i3200_edac video 
> edac_core floppy
> [ 1109.336908] Pid: 786, comm: ASYNC_TASK_1869 Tainted: G           O 
> 3.5.7-debug #38
> [ 1109.336917] Call Trace:
> [ 1109.336933]  [<ffffffff8103cdcf>] warn_slowpath_common+0x7f/0xc0
> [ 1109.336949]  [<ffffffff8103ce2a>] warn_slowpath_null+0x1a/0x20
> [ 1109.336965]  [<ffffffff8110b08d>] xnpod_suspend_thread+0x17d/0x5a0
> [ 1109.336981]  [<ffffffff81117054>] xnshadow_relax+0xf4/0x250
> [ 1109.336997]  [<ffffffff810cc73c>] ? __ipipe_restore_head+0x7c/0x100
> [ 1109.337013]  [<ffffffff811181db>] xnshadow_harden+0x30b/0x340
> [ 1109.337029]  [<ffffffff811183e0>] losyscall_event+0xb0/0x2f0
> [ 1109.337045]  [<ffffffff810d0829>] ipipe_syscall_hook+0x89/0xd0
> [ 1109.337061]  [<ffffffff810cbc68>] __ipipe_notify_syscall+0x158/0x340
> [ 1109.337076]  [<ffffffff8102167a>] __ipipe_syscall_root+0x4a/0x1f0
> [ 1109.337092]  [<ffffffff81367baa>] __ipipe_syscall_root_thunk+0x35/0x67
> [ 1109.337108]  [<ffffffff81682217>] ? system_call_after_swapgs+0x54/0x6d
> [ 1109.337117] ---[ end trace 9fc5fa66a7479311 ]---
> 
> The trace log is in the attachment.
> 

Thanks. Could you drop the previous instrumentation patches, and give a try at this one? It fixes a flaw in the logic for maintaining the thread information bits, which may have caused the issue you observed: 

diff --git a/ksrc/nucleus/pod.c b/ksrc/nucleus/pod.c
index 0a2ee19..22fa91d 100644
--- a/ksrc/nucleus/pod.c
+++ b/ksrc/nucleus/pod.c
@@ -1391,7 +1391,8 @@ void xnpod_suspend_thread(xnthread_t *thread, xnflags_t mask,
 		}
 #endif /* CONFIG_XENO_OPT_PERVASIVE */
 
-		xnthread_clear_info(thread, XNRMID | XNTIMEO | XNBREAK | XNWAKEN | XNROBBED);
+		xnthread_clear_info(thread, XNRMID | XNTIMEO | XNBREAK | \
+				    XNWAKEN | XNROBBED | XNKICKED);
 	}
 
 	/* Don't start the timer for a thread indefinitely delayed by

TIA,

-- 
Philippe.

