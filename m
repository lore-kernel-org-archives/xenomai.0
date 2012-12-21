From: Wolfgang Mauerer <wolfgang.mauerer@siemens.com>
Date: Fri, 21 Dec 2012 14:26:05 +0100
Message-Id: <1356096375-29859-1-git-send-email-wolfgang.mauerer@siemens.com>
Subject: [Xenomai] [RFC PATCH 0/10] Support ftrace on ipipe kernels
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org
Cc: jan.kiszka@siemens.com, wolfgang.mauerer@siemens.com

Hi Gilles, Jan,

here's a proposal to make ipipe compatible with ftrace that
does not require global modifications to the preemption system,
but makes do with local changes. The approach should be easy
to maintain in the long run:

- ipipe_safe_preempt_xyz() counterparts for the preemption API
  need to be provided.
- Portions of the kernel that need to call into the preemption API
  from non-root context must ensure that they #include the new
  linux/ipipe_switch_preempt.h header file.

All callers of the preempt API that are not converted continue to
trigger an ipipe panic as before if they are called from non-root
context, which is an advantage compared to approaches that
change the preemption API globally. Almost all changes are to
ipipe-specific files, which should also ease maintainability.

NOTE: The series has only been tested _very_ superficially.
Before I spend more effort, I'd like to have some feedback if
you see any fundamental issues with the approach.

The changes are also on github, see below.

Best regards, Wolfgang

---
The following changes since commit 4b451bb6508b3a2f27b6d0e5c1d813f4f109abdb:

  Fix dispatching of IRQ_MOVE_CLEANUP_VECTOR (2012-10-08 14:57:53 +0200)

are available in the git repository at:
  https://github.com/siemens/ipipe.git ftrace

Jan Kiszka (4):
      ipipe: Add root domain guard to preempt_schedule
      ipipe: Harden clocks used by ftrace and perf
      ipipe: Harden ftrace function and function-graph tracer
      Harden trace_vbprintk for non-root use

Wolfgang Mauerer (6):
      ipipe: Remove superfluous include file in ipipe.h
      ipipe: safe thread_info access from non-root context
      ipipe: Add mechanism to allow preemption calls from non-root context
      ipipe: Introduce preemption call replacement mechanism
      ipipe: Fix CONFIG_PREEMPT build
      ipipe: Make ftrace compatible with ipipe

 include/linux/ipipe.h                |   33 +---------------
 include/linux/ipipe_foreign_stack.h  |   70 ++++++++++++++++++++++++++++++++++
 include/linux/ipipe_switch_preempt.h |   31 +++++++++++++++
 kernel/ipipe/core.c                  |   52 +++++++++++++++++++++++++
 kernel/sched/clock.c                 |    6 ++-
 kernel/sched/core.c                  |    3 +-
 kernel/trace/trace.c                 |    6 +-
 kernel/trace/trace.h                 |    1 +
 kernel/trace/trace_clock.c           |    4 +-
 kernel/trace/trace_functions.c       |    8 ++--
 kernel/trace/trace_functions_graph.c |    8 ++--
 11 files changed, 174 insertions(+), 48 deletions(-)
 create mode 100644 include/linux/ipipe_foreign_stack.h
 create mode 100644 include/linux/ipipe_switch_preempt.h

--
Siemens AG, Corporate Technology
Corporate Competence Centre Embedded Linux

