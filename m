Message-ID: <49750A32.8080104@domain.hid>
Date: Tue, 20 Jan 2009 00:18:10 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <496F0DBE.5010108@domain.hid> <496F14B9.4010604@domain.hid>
	<496F1CF2.1030401@domain.hid> <496F275E.90407@domain.hid>
	<496F4065.9040501@domain.hid> <496F4558.8080603@domain.hid>
In-Reply-To: <496F4558.8080603@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] Pending patches
Reply-To: rpm@xenomai.org
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

Philippe Gerum wrote:
> Jan Kiszka wrote:
>> Philippe Gerum wrote:
>>> Jan Kiszka wrote:
>>>> Philippe Gerum wrote:
>>>>> Jan Kiszka wrote:
>>>>>> commit 728fc8970e2032b3280971788f1223f3ad82d80d
>>>>>> Author: Jan Kiszka <jan.kiszka@domain.hid>
>>>>>> Date:   Thu Jan 15 11:10:24 2009 +0100
>>>>>>
>>>>>>     xnpipe: Fix racy callback handlers
>>>>>>     
>>>>>>     Invocation of input, output and alloc handler must take place under
>>>>>>     nklock to properly synchronize with xnpipe_disconnect. Change all
>>>>>>     callers to comply with this policy.
>>>>>>
>>>>> That one is under investigation. I agree on the bug report (thanks btw), but I
>>>>> disagree on the fix. Basically, we can't run all hooks under nklock. For
>>>>> instance, the alloc_handler may issue kmalloc() calls when issued from the Linux
>>>>> write endpoint.
>>>> You mean it /could/? Because no in-tree user (ie. native) calls
>>>> rt-unsafe services from its alloc_handler.
>>>>
>>> When you export a public interface, it is better not to make it incompatible
>>> unless there is no other way to fix a situation. Doing so is last resort for me.
>> OTH, there is nothing documented yet about those callback handlers or
>> xnpipe_connect. So we could only break _assumptions_ about this
>> interface.
> 
> Actually, we would break existing implementations, but I understand your point.
> 
>  But, of course, I would be happy if we could continue to keep
>> the critical section length short. I just don't see how to achieve this
>> without significant restrictions on the callback handlers and their use
>> cases.
>>
> 
> That is because the semantics of those callouts is not that smart. If we have to
> break the API to solve the locking issue, I want to get the semantics fixed in
> the same move (which may help a lot in solving the locking issue as well), so we
> don't end up with two subsequent breakage.
> 

As suspected, the callback management in the message pipe code had very serious
issues, including the xnpipe_disconnect / xnpipe_release race. At least:

- the latency would simply skyrocket when the input queue (i.e. userland to
kernel) is flushed from xnpipe_cleanup_user_conn, because the latter holds the
nklock with interrupts off when doing so. I've tested this case on v2.4.x, the
results on a latency test when the pipe test code is running in parallel are not
pretty (i.e. > 220 us latency spot).

- message buffers waiting in the output queue while the latter is flushed would
NOT be returned to the memory pool when an input handler is present, which is
the case with the native API that provides one. All the confusion went from the
output notification and free buffer logic that were combined into the output
handler. This went unnoticed probably because messages sent via the write()
endpoint are immediately consumed by the receiving side in a RT task that
preempts, but still, the bug is there.

The disconnect vs release race can be fixed in a (nearly) lockless way using a
lingering close sequence, that prevents xnpipe_disconnect() to wipe out the
extra state (e.g. RT_PIPE struct) until xnpipe_release() does not need it
anymore. In short, if the userland side is connected, xnpipe_disconnect() will
defer the actual release of that extra state to xnpipe_release(); otherwise, it
will discard it immediately. A new callback, namely .release has been added for
that purpose.

The internal xnpipe API had to be fixed with respect to the new set of callbacks
it accepts, but the overall logic remained the same. The handlers were simply
made more consistent with what the message pipe machinery expects from them.
There is no user visible change.

I have committed the changes that fix all the issues above; the new code
survived significant stress testing here, which only means that this seems to be
a reasonable framework to start working with.

Given the severity of the bugs, I definitely plan to backport those changes to
v2.4.x at some point (the earlier, the better), since we could not reasonably
live with such issues in a stable version.

-- 
Philippe.

