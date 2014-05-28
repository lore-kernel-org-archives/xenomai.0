Message-ID: <5385F190.7050303@xenomai.org>
Date: Wed, 28 May 2014 16:24:16 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <CAO0fa7ZiofUS3wsbx89uYsnt6icuv+DVcDbiEfVyG5DUeprj2w@mail.gmail.com>	<5382E8B1.8070402@xenomai.org>	<CAO0fa7YQ0TxiAhbmFmt+41o+rugoLXKjXxtHygpthNOiu8gd9w@mail.gmail.com>	<5383406C.4070902@xenomai.org>	<CAO0fa7YavfJxxLW6h3Wm8CRmS2+yb9Uhv5RDfsv04+pcpvorFg@mail.gmail.com>	<CAO0fa7byLgJQ2_sLDtJLmjsf=oh2NF7k37qnWWxmwhZW6N1ksw@mail.gmail.com>
 <CAO0fa7YGSCmPducStbh7sM=HJtPYq86iO1e2ZAaKyjUjzPMEUA@mail.gmail.com>
In-Reply-To: <CAO0fa7YGSCmPducStbh7sM=HJtPYq86iO1e2ZAaKyjUjzPMEUA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] gdb / threads on beaglebone black
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Drew <pythondrew@gmail.com>
Cc: "Xenomai@xenomai.org" <Xenomai@xenomai.org>

On 05/28/2014 04:08 PM, Drew wrote:
> Yes, my guess was correct.
> The do - while loop in trampoline is exiting with error -38 (-ENOSYS?)
> If I change line 110 of skins/native/task.c:
>
> - while(err == -EINTR)
> + while(err == -EINTR || err == -ENOSYS)
>
> then I'm able to single-step in gdb. :-)
>
> Is my change a hack, or is it the correct thing to do?

No Xenomai call should ever return ENOSYS. Something is definitely wrong 
with the current setup.

> It looks like rt_task_trampoline is only expecting EINTR to occur. Is
> some other bug causing ENOSYS?

This means that the 'barrier' syscall did not get to Xenomai core, but 
was rejected as undefined.

Could any of the hints mentioned here apply in your case?
http://www.xenomai.org/documentation/xenomai-2.6/html/TROUBLESHOOTING/#_any_xenomai_service_fails_with_code_38_enosys

  Or are there a few other valid errors
> that may be returned while waiting on the barrier? (the comment above
> the loop says "to process Linux signals" but the code only checks for
> one thing.) Should rt_task_trampoline somehow warn a user if the
> do-while encounters an error it doesn't expect? (or does it already,
> through another debug mechanism I'm not using?)

The loop only cares for non-restartable syscalls, which receive EINTR 
when interrupted by a signal handler.

>
> As an aside, another question is why rt_task_trampoline at all? Why fire
> up the new thread when it doesn't yet know what it will be executing?
> I'm guessing it is for speed, so that when rt_task_start actually does
> execute, it will execute immediately...
>

Correct, rt_task_create() does all the resource reservation, all the 
lengthy stuff. When successful, we know that we'll be able to start the 
task code upon rt_task_start(), provided the task descriptor is valid. 
rt_task_start() is only about unleashing a ready-to-run thread context.

-- 
Philippe.

