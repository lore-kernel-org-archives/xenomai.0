Message-ID: <48295AF4.2090402@domain.hid>
Date: Tue, 13 May 2008 11:10:12 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <48295098.10204@domain.hid>
	<2ff1a98a0805130156m3a8caf44s772f551f9e315a7d@domain.hid>
In-Reply-To: <2ff1a98a0805130156m3a8caf44s772f551f9e315a7d@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
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
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai-core@domain.hid

Gilles Chanteperdrix wrote:
> On Tue, May 13, 2008 at 10:26 AM, Jan Kiszka <jan.kiszka@domain.hid> wrote:
>>  @@ -1236,6 +1236,9 @@ void xnpod_delete_thread(xnthread_t *thr
>>                 xnthread_cleanup_tcb(thread);
>>
>>                 xnarch_finalize_no_switch(xnthread_archtcb(thread));
>>  +
>>  +               if (xnthread_test_state(sched->runthread, XNROOT))
>>  +                       xnfreesync();
>>         }
> 
> No, this does not look good. The point of deferring TCB freeing is
> that the TCB will be accessed shortly after it is freed.

By whom in this case? The thread was not active anymore. IIRC, the
use-after-release issue was related to self-deletions.

> 
> IMHO, the right solution is to add a call to xnpod_schedule or even
> directly xnfreesyng in the right place (in skins code, after all
> threads have been freed)

Well, as I said, we should rather move all these syncs out of critical
sections. So better avoid xnpod_schedule.

I need to think about this a bit more, I'm afraid. It is safe to delete
the TCB once the terminating thread is scheduled away and its successor
of about to leave (or left) xnpod_schedule, right?

Jan

-- 
Siemens AG, Corporate Technology, CT SE 2
Corporate Competence Center Embedded Linux

