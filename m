Message-ID: <008001c5e512$5c6e4630$1000000a@domain.hid>
From: "Hans-J. Ude" <ude@domain.hid>
References: <002f01c5e44a$b675bf50$1000000a@domain.hid>
	<43707B3E.8060900@domain.hid>
Subject: Re: [Xenomai-help] Task lock/unlock unlock difficulties
Date: Wed, 9 Nov 2005 10:45:44 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="Windows-1252"
Content-Transfer-Encoding: 7bit
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: Xenomai-help@domain.hid

Phillipe Gerum wrote:

> Hans-J. Ude wrote:
> > I need to lock/unlock the scheduler from time to time. I'm using the
RTAI
> > native skin in userspace and tried the rt_task_set_mode approach but was
not
> > very successfus yet. I've tried this:
> >
> > int task_lock(void) { return rt_task_set_mode(0, T_LOCK, &mask); }
> > int task_unlock(void) { return rt_task_set_mode(T_LOCK, mask, NULL); }
> >
> > To support nested calls to these functions i've implement an array of
masks
> > and lock/unlock counters to maintain a stack. I've also tried a single
mask
> > and no stack and with no mask at all. No success. It's hard to explain
what
> > exactly happens because I'm porting an existing software with a really
bad
> > design but the original works. I found there are xenomai functions
called
> > xnpod_lock_sched(), which are directly called from e.g. the vxWorks
skin.
> > Obviously xn_pod_lock has an integrated counting. Otherwise the vx skin
> > would be incompatible. But when i include pod.h i get a whole bunch of
error
> > messages, likely due to missing defines. So can someone show me a way to
a
> > clean working counting lock/unlock mechanism.
>
> Bypassing the interface won't help, especially if you think that there is
an
> issue in the core. Please write a simple test case illustrating the use
you want
> to make of sched locking using the native skin - which possibly exhibits
the
> issue - and post it.

I'm gonna try to do so, but it's not easy to track the problem down to a
simple testcase from inside a complex application. There is another basic
question I have. When the locking mechanism works as expected i would think
of the following szenario:

I have three task running. Then task 1 locks the scheduler then for some
reason pends on a semaphore or event from task 2 or 3. Then it should
automatically release the lock to prevent a deadlock. VxWorks does it that
way according to it's docs. But I don't know if gets automatically relocked
and latest lock count restored after the pended event was fired. The
application i'm porting is written on vxWorks but we went away from the vx
skin due to problems with taskSpawn. These problems probably came from to
the bug in the uvm layer which you recently fixed. Thanks for that. So we
switched to the rtai skin but ran into that tasklock problem. It would be
also important to know who handles the lock/unlock count as there is an
internal counter in the suspend/release funtions too. Were thinking of going
back to the vx skin but there is a problem with loading the modules now but
i'll put that under another subject. Any ideas somebody?

regards,
Hans



