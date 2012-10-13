Message-ID: <50795024.4010506@xenomai.org>
Date: Sat, 13 Oct 2012 13:27:32 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] [PATCH 0/1 v3] rtdm: get spinlocks to lock the scheduler
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai <xenomai@xenomai.org>


Hi,

here is the latest attempt to avoid entering __xnpod_schedule when
xnpod_unlock_sched is called without a needed rescheduling.

This one is much simpler. We do not try to prevent entering
__xnpod_schedule when xnpod_schedule is called with the scheduler
locked: it may be racy when the current thread wants to suspend with the
scheduler locked, and would avoid sending the reschedule IPIs to other
cpus if the other cpus scheduler state was changed. Instead, if
xnpod_schedule is called with the scheduler locked, but not to suspend
the current thread, exit early keeping the resched bit set. This avoids
having to set the resched bit in xnpod_unlock_sched and thus entering
__xnpod_schedule every time.

As with the previous patch, no attempt is made to lock the scheduler for
the implementation of xnlock* services, as they are called at a time
during the early init where xnpod_current_thread() is NULL.

Regards.

-- 
                                                                Gilles.

