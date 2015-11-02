From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <563767EC.9020008@xenomai.org>
Date: Mon, 2 Nov 2015 14:41:00 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] [RELEASE] Xenomai 3.0.1
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <Xenomai@xenomai.org>


This is the first maintenance release for v3.0. Core and rtnet fixes for
the most part, including a nasty SMP-only issue which could delay a
real-time rescheduling unexpectedly. Update recommended.

http://xenomai.org/downloads/xenomai/stable/latest/

Short log follows:

Gilles Chanteperdrix (15):
      rtnet/udp: fix sendmsg error path
      rtnet: fix reference count issues
      cobalt/sched: bypass scheduler lock in irq
      rtnet: add option to enable debug asserts
      cobalt/mutex: invalidate autoinit mutex upon fork
      cobalt/mutex: propagate autoinit error
      cobalt/process: avoid crash at fork
      cobalt/sched: avoid leaking the reschedule bit
      testsuite/dohell: sync after dd to disk
      testsuite/smokey: tsc: add tsc test
      cobalt/rtdm: use distinct minor for each protocol device
      cobalt/rtdm: schedule_work: avoid ipipe_work_post_root
      rtnet/e1000e: use rtdm schedule work
      rtnet: transfer skb ownership when sending
      lib/smokey: fix argument parsing

Henning Schild (1):
      scripts: use mktemp instead of relying on TMPDIR beeing in env

Jan Kiszka (2):
      lib/cobalt: Introduce cobalt_thread_probe
      lib/cobalt: Forward kill to Linux if no target was found

Philippe Gerum (10):
      alchemy/heap: allow zero size for SBA binding
      copperplate/regd: do not involve Cobalt before binding is done
      lib/cobalt: explain -ENOSYS upon binding error
      boilerplate/version: fix version suffix for non-devel release
      doc: fix URL of the download area
      cobalt/timer: allow for changing the underlying clock source
      cobalt/thread: allow for changing the clock of the periodic timer
      cobalt/thread: allow NULL thread spec for xnthread_set_clock()
      bump version code
      doc: prebuild

--
Philippe.


