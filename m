References: <DM5PR11MB18525F69E34389DE7A8EE49BF2409@DM5PR11MB1852.namprd11.prod.outlook.com>
 <87mtti3325.fsf@xenomai.org>
From: Philippe Gerum <rpm@xenomai.org>
Subject: Re: gdb  test failure debug status update
In-reply-to: <87mtti3325.fsf@xenomai.org>
Date: Wed, 28 Apr 2021 16:30:00 +0200
Message-ID: <87k0om32jb.fsf@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: "Chen, Hongzhan" <hongzhan.chen@intel.com>, xenomai@xenomai.org


Philippe Gerum via Xenomai <xenomai@xenomai.org> writes:

> Chen, Hongzhan via Xenomai <xenomai@xenomai.org> writes:
>
>> According to my validation, gdb test fail on dovetail 5.10 branch but pass on v5.9-evl4 tag with same for-upstream/dovetail
>> xenomai code base.
>>
>> After further debug , the issue is more clear for me. Gdb test failure because low priority thread smokey  userspace  is still
>> executed after "cobalt_shadow_relaxed: state=0x4488c0 info=0x200"  like log [1] on dovetail-5.10 branch.
>> The weird thing is that its following first ftrace log  happen at 62235.848583 after cobalt_shadow_relaxed in log [1].
>> It is almost 3ms happened after cobalt_shadow_relaxed. The low priority smoke thread user space is executed during this
>> 3ms period so that test fail.
>>
>> But in success case with v5.9-evl4 like in  log [2], the time interval between cobalt_shadow_relaxed and the following first ftrace log
>> is only about 1us. It seems that low priority smokey userspace do not have chance to execute in this 1us because gdb test is successful.
>>
>> My question is why there is even no interrupt happened during that about 3ms period in failure case?  Tick seems in abnormal behavior.
>> Please comment if you have any ideas to further debug it.
>>
>> PS: All my tests run on same up Xtream board.
>
> <snip>
>
> Let's put aside the tick issue for now, there may be a valid reason for
> this delay with dynticks enabled.
>
> The issue at stake may be related to the way a return to kernel space is
> forced on a @user task (Dovetail has an integrated service for
> triggering this called dovetail_request_ucall()).
>
> The logic for doing so is as follows:
>
> 1. @user hits a breakpoint, which is an exception Dovetail-wise
>
> 2. @user gets XNDBGSTOP set into its flags because Cobalt notices it is
> being debugged via a breakpoint trap, then relaxed as a result of taking
> a exception in general, so that we may traverse the common trap handling code
> safely.
>
> 3. since XNDBGSTOP is a blocking bit Cobalt-wise, it should prevent
> @user from being picked for scheduling by the real-time core, next time
> a Cobalt considers rescheduling that is. However, since @user is
> currently relaxed, it can still run under the supervision of the common
> Linux scheduler. This is what the log[1] show.
>
> 4. the common/in-band kernel code stops @user due to the ptrace stop
> condition caused by the breakpoint, waiting for a continuation event to
> happen.
>
> Therefore, upon PTRACE_CONT (i.e. gdb continue), we need to force @user
> to call back into kernel context (handle_ptrace_cont ->
> dovetail_request_ucall), then ask for a switch to primary mode from
> there, which should eventually happen when @user is about to leave the
> kernel (on x86, this now happens from a generic kernel entry/exit code
> in kernel/entry/*). As a result, handle_taskexit_event() runs, figures

Not quite:
s,handle_taskexit_event,handle_user_return,

-- 
Philippe.

