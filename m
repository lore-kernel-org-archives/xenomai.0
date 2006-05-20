Message-ID: <446F852B.7090400@domain.hid>
Date: Sat, 20 May 2006 23:07:55 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] Xenomai v2.2-rc2
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org


Here is the second release candidate for the v2.2 branch. Short log
follows:

[x86,ppc64] Fix ugly Adeos-related SMP bug involving kernel-based
             Xenomai threads.

[nucleus] Extend pipeline head optimizations.
           Provide  thread "held" state for later temporal partitioning
           support.
           Add PIP resource stealing.
           Add support for per-process data.
           Add cleanup handler to synchronization objects.
           Work around SuSE-originated GCC 4.x bug (optimizer
           issue) in message pipe support.
           Fix xnpod_unblock_thread() (don't raise XNBREAK for
           ready threads).
           Fix xnpod_start_thread() (error code propagation).
           Add missing symbol exports.

[posix]   Update for PIP resource stealing.
           Set default mutex priority protocol to PTHREAD_PRIO_NONE.

[rtdm]    Refactor mutex, sema4 and event implementation.
           Fix rtdm_strncpy_from_user().
           Fix PIP handling code.

[vxworks] Update for PIP resource stealing.
           Reset timer upon unload.
           Fix tick handler return value.
	  Fix stack overflow in demo program.

[native]  Update for PIP resource stealing.
           Fix rt_task_delete() when killing a non-shadowed thread.
           Fix T_JOINABLE bit conflict.

[vrtx]    Update for PIP resource stealing.

[rtai]    Update for PIP resource stealing.

[testsuite]  Allow running multiple tests in parallel.
              Allow pinning down the sampling task to a specified
              CPU.

Aside of this, all Adeos patches have been upgraded.

Please see the ChangeLog for details.

http://download.gna.org/xenomai/testing/xenomai-2.2-rc2.tar.bz2

-- 

Philippe.

