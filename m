From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17373.63969.941760.677529@domain.hid>
Date: Mon, 30 Jan 2006 12:34:57 +0100
Subject: Re: [Xenomai-core] [PATCH] fix pthread cancellation in native skin
In-Reply-To: <43DB3AB1.5090004@domain.hid>
References: <43DB3AB1.5090004@domain.hid>
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

Jan Kiszka wrote:
 > Hi,
 > 
 > Gilles' work on cancellation for the posix skin reminded me of this
 > issue I once discovered in the native skin:
 > 
 > https://mail.gna.org/public/xenomai-core/2005-12/msg00014.html
 > 
 > I found out that this can easily be fixed by switching the pthread of a
 > native task to PTHREAD_CANCEL_ASYNCHRONOUS. See attached patch.
 > 
 > 
 > At this chance I discovered that calling rt_task_delete for a task that
 > was created and started with T_SUSP mode but was not yet resumed, locks
 > up the system. More precisely: it raises a fatal warning when
 > XENO_OPT_DEBUG is on. Might be the case that it just works on system
 > without this switched on. Either this is a real bug, or the warning
 > needs to be fixed. (Deleting a task after rt_task_suspend works.)

Actually, the fatal warning happens when starting with rt_task_start the
task which was created with the T_SUSP bit. The task needs to wake-up in
xnshadow_wait_barrier until it gets really suspended in primary mode by
the final xnshadow_harden. This situation triggers the fatal, because
the thread has the nucleus XNSUSP bit and is running in secondary mode.

This is not the only situation where a thread with a nucleus suspension
bit need to run shortly in secondary mode: it also occurs when
suspending with xnpod_suspend_thread() a thread running in secondary
mode; the thread receives the SIGCHLD signal and need to execute shortly
with the suspension bit set in order to cause a migration to primary
mode.

So, the only case when we are sure that a user-space thread can not be
scheduled by Linux seems to be when this thread does not have the
XNRELAX bit.

-- 


					    Gilles Chanteperdrix.

