References: <CAFZ-hKjeJZGD7s54hH_QURdY4z=ViUEz3_mrgQbwH4pX4weY+g@mail.gmail.com>
 <fa5f0b2a-4f92-343c-b00d-0d75ee79a97e@freyder.net>
From: Philippe Gerum <rpm@xenomai.org>
Subject: Re: domain switch
In-reply-to: <fa5f0b2a-4f92-343c-b00d-0d75ee79a97e@freyder.net>
Date: Sun, 03 Jan 2021 11:31:34 +0100
Message-ID: <87zh1qqpkp.fsf@xenomai.org>
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
To: steve freyder <steve@freyder.net>
Cc: Leandro Bucci <guestleandro11@gmail.com>, xenomai@xenomai.org


steve freyder via Xenomai <xenomai@xenomai.org> writes:

> Right.
>
>
> AKA, "mode switch", a switch from "primary mode" to "secondary mode",
> or vice versa.
>
> One place you can find that information is in:
>
> /proc/xenomai/sched/acct
>
> there are two fields MSW, and CSW which count mode/context switches
> per-process. This requires an open, a read loop to locate the desired 
> pid and extract the desired information, then either rewind or
> close/reopen to do it again - all of which will almost surely generate 
> more mode/context switching.
>

If that helps, there is also the option of getting the thread stats by
program, using int cobalt_thread_stat(pid_t pid, struct
cobalt_threadstat *stat), declared in sys/cobalt.h. pid refers to a
thread identifier (as obtained from gettid(2) in the context of the
target thread). It must refer to a Cobalt thread, otherwise the call
would fail with -ESRCH.

The mode switch count is present in the returned information block
(->msw). cobalt_thread_stat() would not cause any mode switch. It can be
called by any thread regardless of its type (i.e. regular or Cobalt).

-- 
Philippe.

