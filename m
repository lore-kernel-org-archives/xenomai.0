Message-ID: <446F7F63.6050108@domain.hid>
Date: Sat, 20 May 2006 22:43:15 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] Xenomai v2.1.2
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


Here is the second maintenance release for the v2.1 branch. Short log 
follows:

[x86,ppc64] Fix ugly Adeos-related SMP bug involving kernel-based
             Xenomai threads.

[nucleus] Work around SuSE-originated GCC 4.x bug (optimizer
           issue) in message pipe support.
           Fix xnpod_unblock_thread() (don't raise XNBREAK for
           ready threads).
           Fix xnpod_start_thread() (error code propagation).
           Add missing symbol exports.

[rtdm]   Fix rtdm_strncpy_from_user().
          Fix PIP handling code.

[vxworks] Reset timer upon unload.
           Fix tick handler return value.
	  Fix stack overflow in demo program.

[native] Fix rt_task_delete() when killing a non-shadowed thread.
          Fix T_JOINABLE bit conflict.

Please see the ChangeLog for details.

http://download.gna.org/xenomai/stable/xenomai-2.1.2.tar.bz2

-- 

Philippe.

