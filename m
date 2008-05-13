Message-ID: <2ff1a98a0805130156m3a8caf44s772f551f9e315a7d@domain.hid>
Date: Tue, 13 May 2008 10:56:29 +0200
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <48295098.10204@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <48295098.10204@domain.hid>
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

On Tue, May 13, 2008 at 10:26 AM, Jan Kiszka <jan.kiszka@domain.hid> wrote:
>  @@ -1236,6 +1236,9 @@ void xnpod_delete_thread(xnthread_t *thr
>                 xnthread_cleanup_tcb(thread);
>
>                 xnarch_finalize_no_switch(xnthread_archtcb(thread));
>  +
>  +               if (xnthread_test_state(sched->runthread, XNROOT))
>  +                       xnfreesync();
>         }

No, this does not look good. The point of deferring TCB freeing is
that the TCB will be accessed shortly after it is freed.

IMHO, the right solution is to add a call to xnpod_schedule or even
directly xnfreesyng in the right place (in skins code, after all
threads have been freed)

-- 
 Gilles

