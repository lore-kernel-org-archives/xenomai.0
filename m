Message-ID: <4829602A.6050603@domain.hid>
Date: Tue, 13 May 2008 11:32:26 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <48295098.10204@domain.hid>	<2ff1a98a0805130156m3a8caf44s772f551f9e315a7d@domain.hid>	<48295AF4.2090402@domain.hid>
	<2ff1a98a0805130216n242eddbek3f24810fc7bdd7c4@domain.hid>
	<48295F82.40404@domain.hid>
In-Reply-To: <48295F82.40404@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [PATCH] Flush xnfree backlog after
 thread	deletion in root context
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: rpm@xenomai.org
Cc: Xenomai-core@domain.hid

Philippe Gerum wrote:
> Gilles Chanteperdrix wrote:
>> On Tue, May 13, 2008 at 11:10 AM, Jan Kiszka <jan.kiszka@domain.hid> wrote:
>>> Gilles Chanteperdrix wrote:
>>>  > On Tue, May 13, 2008 at 10:26 AM, Jan Kiszka <jan.kiszka@domain.hid> wrote:
>>>  >>  @@ -1236,6 +1236,9 @@ void xnpod_delete_thread(xnthread_t *thr
>>>  >>                 xnthread_cleanup_tcb(thread);
>>>  >>
>>>  >>                 xnarch_finalize_no_switch(xnthread_archtcb(thread));
>>>  >>  +
>>>  >>  +               if (xnthread_test_state(sched->runthread, XNROOT))
>>>  >>  +                       xnfreesync();
>>>  >>         }
>>>  >
>>>  > No, this does not look good. The point of deferring TCB freeing is
>>>  > that the TCB will be accessed shortly after it is freed.
>>>
>>>  By whom in this case? The thread was not active anymore. IIRC, the
>>>  use-after-release issue was related to self-deletions.
>> I do not remember the issue precisely, I know that it was related to
>> thread deletion hooks.
> 
> The point is that we have to run thread deletion hooks on behalf of the outgoing
> thread context; this is a strong requirement.

Yes, I remember.

> 
>  The XNARCH_WANT_UNLOCKED_CTXSW complicated the
>> issue further.

I now wonder when in this unlocked case do we schedule the tcb for
deletion - should be _before_ the switch - and what then prevents that
the tcb is flushed by some other CPU that happen to run xnfreesync while
we are unlocked during that switch. Or does XNARCH_WANT_UNLOCKED_CTXSW
imply !CONFIG_CMP?

Jan

-- 
Siemens AG, Corporate Technology, CT SE 2
Corporate Competence Center Embedded Linux

