From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [ANNOUNCE] Xenomai v3.1-rc4 available
Message-ID: <313ed563-6a6e-a7f4-93a4-06013d2a239d@siemens.com>
Date: Fri, 6 Dec 2019 15:43:59 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai <xenomai@xenomai.org>

Hi all,

after running into a number of critical issues around the scheduler but 
also one of the new ABIs, this -rc is a fairly important one:

https://gitlab.denx.de/Xenomai/xenomai/-/archive/v3.1-rc4/xenomai-v3.1-rc4.tar.bz2
https://gitlab.denx.de/Xenomai/xenomai/commits/v3.1-rc4

Changes since rc3:

Jan Kiszka (15):
      rtdm: Do not return an error from send/recvmmsg if there are packets
      rtdm: Remove early exit from send/recvmmsg on vlan == 0
      ci: Always build the latest release
      lib/cobalt: Fix help for --print-sync-delay
      alchemy: Fully initialize tcb->self
      testsuite/smokey/posix-cond: Make more robust for execution in VMs
      cobalt/posix/thread: Factor out thread_lookup_or_shadow
      cobalt/posix: Add thread_setschedprio
      lib/cobalt: Use new thread_setschedprio syscall
      Revert "cobalt/kernel: Introduce __SCHED_CURRENT policy to setschedparam_ex"
      testsuite/smokey: Fix setsched /wrt lazy scheduling parameter application
      testsuite/smokey: Add pthread_setschedprio to setsched test case
      debian: Enable lazy-setsched in userspace package
      cobalt/intr: Move IRQ exit trace point in non-shared case
      config: Bump version number

Philippe Gerum (16):
      copperplate/heapobj-pshared: fix element size for array init
      testsuite/mq-2: clarify test implementation
      boilerplate/avl: fix NULL link representation in pshared mode - take #2
      cobalt/process: skip trap handling for the root thread
      cobalt/thread: update inline documentation
      cobalt/posix: fix missed rescheduling opportunities
      cobalt/process: remove superfluous check for non-relaxed state
      cobalt/thread: fix scheduler breakage on thread suspension
      drivers/testing: heapcheck: silence UMR warning (false positive)
      cobalt/process: exit_thread handlers should reschedule as needed
      net/proxy: fix non-rt signal overflow
      cobalt/sched: quota: fix use-after-free in quota_remove operation
      net/rtmac: vnic: fix non-rt signal overflow
      net/rtpc: fix non-rt signal overflow
      net/cap: fix non-rt signal overflow
      cobalt/sched: guard against missed rescheduling upon CPU migration

Please test so that we finalize 3.1 soon.

Jan

PS: A new stable 3.0 release is scheduled as well, just need to finish 
some local testing.

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

