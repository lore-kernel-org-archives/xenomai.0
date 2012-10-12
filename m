Message-ID: <5077B799.5000408@xenomai.org>
Date: Fri, 12 Oct 2012 08:24:25 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] [PATCH 0/1] rtdm: get spinlocks to lock the scheduler
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

here is the second attempt to try and allow drivers to wake-up threads
in the middle of spinlock sections. The idea is to try and have a
lighter version of __xnpod_lock_sched/__xnpod_unlock_sched and use that
in the RTDM spinlocks.

The lighter version of __xnpod_lock_sched/__xnpod_unlock_sched uses a
status bit, and a preemption count in the scheduler structure, but as we
want to allow a thread to suspend itself when the scheduler is locked,
when this happens, we save the preemption count in the thread structure,
and clear the preemption count and scheduler bit, they get restore in
xnpod_schedule/xnshadow epilogue when waking-up such a thread.

We have to keep the thread XNLOCK bit, it is more or less part of the
ABI (for instance, it is possible to create a thread with this bit set,
and the scheduler is locked immediately when this thread is first
scheduled). I guess we can completely remove it in -forge though.

I have failed to modify xnlock services to also use the scheduler lock,
xnheap_init is called before the scheduler is initialized, and takes an
xnlock.

Regards.

-- 
                                                                Gilles.

