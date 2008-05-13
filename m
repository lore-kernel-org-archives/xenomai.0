Message-ID: <2ff1a98a0805130238j391b3c5dge5f79f8275b42c46@domain.hid>
Date: Tue, 13 May 2008 11:38:53 +0200
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <4829602A.6050603@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <48295098.10204@domain.hid>
	<2ff1a98a0805130156m3a8caf44s772f551f9e315a7d@domain.hid>
	<48295AF4.2090402@domain.hid>
	<2ff1a98a0805130216n242eddbek3f24810fc7bdd7c4@domain.hid>
	<48295F82.40404@domain.hid> <4829602A.6050603@domain.hid>
Subject: Re: [Xenomai-core] [PATCH] Flush xnfree backlog after thread
	deletion in root context
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
Cc: Xenomai-core@domain.hid

On Tue, May 13, 2008 at 11:32 AM, Jan Kiszka <jan.kiszka@domain.hid> wrote:
> Philippe Gerum wrote:
>  > Gilles Chanteperdrix wrote:
>  >> On Tue, May 13, 2008 at 11:10 AM, Jan Kiszka <jan.kiszka@domain.hid> wrote:
>  >>> Gilles Chanteperdrix wrote:
>  >>>  > On Tue, May 13, 2008 at 10:26 AM, Jan Kiszka <jan.kiszka@domain.hid> wrote:
>  >>>  >>  @@ -1236,6 +1236,9 @@ void xnpod_delete_thread(xnthread_t *thr
>  >>>  >>                 xnthread_cleanup_tcb(thread);
>  >>>  >>
>  >>>  >>                 xnarch_finalize_no_switch(xnthread_archtcb(thread));
>  >>>  >>  +
>  >>>  >>  +               if (xnthread_test_state(sched->runthread, XNROOT))
>  >>>  >>  +                       xnfreesync();
>  >>>  >>         }
>  >>>  >
>  >>>  > No, this does not look good. The point of deferring TCB freeing is
>  >>>  > that the TCB will be accessed shortly after it is freed.
>  >>>
>  >>>  By whom in this case? The thread was not active anymore. IIRC, the
>  >>>  use-after-release issue was related to self-deletions.
>  >> I do not remember the issue precisely, I know that it was related to
>  >> thread deletion hooks.
>  >
>  > The point is that we have to run thread deletion hooks on behalf of the outgoing
>  > thread context; this is a strong requirement.
>
>  Yes, I remember.

Ok. Now I remember. The point is that the tcb is scheduled for
deletion by thread deletion hooks, and accessed shortly after by
xnthread_cleanup_tcb and xnarch_finalize_no_switch. So basically, your
initial patch looks Ok. However, you should add the same call to
__xnpod_finalize_zombie.

>
>
>  >
>  >  The XNARCH_WANT_UNLOCKED_CTXSW complicated the
>  >> issue further.
>
>  I now wonder when in this unlocked case do we schedule the tcb for
>  deletion - should be _before_ the switch - and what then prevents that
>  the tcb is flushed by some other CPU that happen to run xnfreesync while
>  we are unlocked during that switch.

The XNSWLOCK bit.

 Or does XNARCH_WANT_UNLOCKED_CTXSW
>  imply !CONFIG_CMP?

No, it is supposed to work. The sched->zombie points to this zombie,
which is finalized in xnpod_finish_unlocked_switch

-- 
 Gilles

