Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47908B644
	for <xenomai@lists.linux.dev>; Thu,  9 Jan 2025 17:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736443357; cv=none; b=qSAYtaOIgfYogEKt9iHa+qGn7ZieWs9/EY7GR6ZLG5NhFrST1BUcXe5LUuWrXwLlUfJVqpCIx4CejsvEEKbskc1tzdQ6AQDLEnlsQTCd8zgbC2MVtHbZ9MQTJQrP8FcbWPn1UBOvqGjfKky/1CP1FqnIrnOq8llLCYfqPXQqVso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736443357; c=relaxed/simple;
	bh=2Ohe5tgTX+jyYL7VvbeAUm/JyKA/sDoWDfqJRQ/2Dnw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=pOdHEKhKbiuA511xBGwCi11cI9Vu61OTW+wnyx8bB68hO85P2/fH4QBRqjgOH/tH/o9NuxV2QLh6w3NM2HqJw0ML8qK6mydn09RaOZqlNiywgYOL4fnwW+WP2V4DvJClF8YAl+jjrBJRrq41RDXbS0TJyvp3Jpw/pqfbKyQ8NDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=JrPPewpx; arc=none smtp.client-ip=185.136.64.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="JrPPewpx"
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 202501091722183369bb9e95b4b384b2
        for <xenomai@lists.linux.dev>;
        Thu, 09 Jan 2025 18:22:19 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=55naUvEA4SvVjeNvRS3HzGTAvq+sxskuU8wtbi8QGVQ=;
 b=JrPPewpxg9yJD5jeiMT6Kcf6Ty3HSD+/vi3Nxf01x5cKp6vmNIWP/9eRA4T/1wImtsWYhH
 hhPibuZnhYJLwEKWkg5kQIUeqGQnKxq1Ury0nmbZ4mUIFpwCQjrV3szDMHzef3HvUP/rpvNL
 kZEOZQQIBS1k9EMPmzMH40x7oTUy+WZvMXZNfgHLtxzlNGE5sxMdzE922Zii7qvGOLfD8UQ/
 0OPcF6DiT03cgMcDspS5RqMGqZlILndfvLe53aT5Kkt0qG3KS4jiKfBfgjkEEKz4WpYy6xLj
 HQmCtTDpMNw8TTxH0jV5UnBBi3CAPCyjUlXdITKxij0apAdI1adWIeiw==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: xenomai@lists.linux.dev
Cc: Jan Kiszka <jan.kiszka@siemens.com>,
	Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [PATCH v4] kernel: Reformat all Kconfig files
Date: Thu,  9 Jan 2025 18:22:17 +0100
Message-Id: <20250109172217.497130-1-florian.bezdeka@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

A lot of white space conversions and reformatting of the help option
according to most upstream files.

No functional change.

Typo fixes in the following files:
  - kernel/cobalt/Kconfig
  - kernel/drivers/can/Kconfig
  - kernel/drivers/net/addons/Kconfig
  - kernel/drivers/net/stack/Kconfig
  - kernel/drivers/net/stack/ipv4/Kconfig
  - kernel/drivers/serial/Kconfig

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---

Changes in v4:
  - Typo fixes in
    - kernel/cobalt/Kconfig
    - kernel/drivers/can/Kconfig
  - (Additional) format conversions in
    - kernel/cobalt/Kconfig
    - kernel/drivers/analogy/testing/Kconfig
    - kernel/drivers/can/c_can/Kconfig
    - kernel/drivers/can/peak_canfd/Kconfig
    - kernel/drivers/can/sja1000/Kconfig
    - kernel/drivers/gpiopwm/Kconfig
    - kernel/drivers/ipc/Kconfig

Changes in v3:
  - Fixed another leftover in kernel/drivers/spi/Kconfig

Changes in v2:
  - Addressed review comments from Jan (kernel/drivers/analogy/Kconfig)
  - Converted leftover whitspaces in kernel/drivers/spi/Kconfig

 kernel/cobalt/Kconfig                         | 290 +++++++++---------
 kernel/cobalt/arch/arm/Kconfig                |  10 +-
 kernel/cobalt/arch/arm64/Kconfig              |   8 +-
 kernel/cobalt/arch/x86/Kconfig                |   2 +-
 kernel/drivers/Kconfig                        |  22 +-
 kernel/drivers/analogy/Kconfig                |  63 ++--
 kernel/drivers/analogy/testing/Kconfig        |  13 +-
 kernel/drivers/can/Kconfig                    |  55 ++--
 kernel/drivers/can/c_can/Kconfig              |  13 +-
 kernel/drivers/can/peak_canfd/Kconfig         |   3 +-
 kernel/drivers/can/sja1000/Kconfig            |  89 +++---
 kernel/drivers/gpio/Kconfig                   |  49 ++-
 kernel/drivers/gpiopwm/Kconfig                |   3 +-
 kernel/drivers/ipc/Kconfig                    |  72 ++---
 kernel/drivers/net/Kconfig                    |  20 +-
 kernel/drivers/net/addons/Kconfig             |  66 ++--
 kernel/drivers/net/drivers/Kconfig            | 130 ++++----
 .../drivers/net/drivers/experimental/Kconfig  |   8 +-
 .../net/drivers/experimental/rt2500/Kconfig   |   6 +-
 kernel/drivers/net/stack/Kconfig              |  46 +--
 kernel/drivers/net/stack/ipv4/Kconfig         | 110 +++----
 kernel/drivers/net/stack/ipv4/tcp/Kconfig     |  28 +-
 kernel/drivers/net/stack/ipv4/udp/Kconfig     |  10 +-
 kernel/drivers/net/stack/packet/Kconfig       |  24 +-
 kernel/drivers/net/stack/rtcfg/Kconfig        |  38 +--
 kernel/drivers/net/stack/rtmac/Kconfig        |  22 +-
 kernel/drivers/net/stack/rtmac/nomac/Kconfig  |  16 +-
 kernel/drivers/net/stack/rtmac/tdma/Kconfig   |  34 +-
 kernel/drivers/serial/Kconfig                 |  56 ++--
 kernel/drivers/spi/Kconfig                    |  25 +-
 kernel/drivers/testing/Kconfig                |  12 +-
 kernel/drivers/udd/Kconfig                    |   5 +-
 32 files changed, 651 insertions(+), 697 deletions(-)

diff --git a/kernel/cobalt/Kconfig b/kernel/cobalt/Kconfig
index 6ba4cdc5d..06566695d 100644
--- a/kernel/cobalt/Kconfig
+++ b/kernel/cobalt/Kconfig
@@ -4,53 +4,53 @@ config XENO_OPT_SCHED_CLASSES
 	bool "Extra scheduling classes"
 	default n
 	help
-	The Cobalt kernel implements a set of scheduling classes.
-	Each scheduling class defines its own set of rules for
-	determining when and how to select a new thread to run.
+	  The Cobalt kernel implements a set of scheduling classes.
+	  Each scheduling class defines its own set of rules for
+	  determining when and how to select a new thread to run.
 
-	Cobalt has a built-in real-time class, which supports both
-	preemptive fixed-priority FIFO, and round-robin scheduling.
+	  Cobalt has a built-in real-time class, which supports both
+	  preemptive fixed-priority FIFO, and round-robin scheduling.
 
-	Enabling CONFIG_XENO_OPT_SCHED_CLASSES allows you to select
-	additional scheduling classes to enable in the Cobalt kernel.
+	  Enabling CONFIG_XENO_OPT_SCHED_CLASSES allows you to select
+	  additional scheduling classes to enable in the Cobalt kernel.
 
-	If in doubt, say N.
+	  If in doubt, say N.
 
 config XENO_OPT_SCHED_WEAK
 	bool "Weak scheduling class"
 	default n
 	depends on XENO_OPT_SCHED_CLASSES
 	help
-	This option creates a Cobalt scheduling class for mapping
-	members of the regular POSIX SCHED_FIFO/RR policies to a low
-	priority class of the Cobalt kernel, providing no real-time
-	guarantee. Therefore, up to a hundred non real-time priority
-	levels are available from the SCHED_WEAK policy.
+	  This option creates a Cobalt scheduling class for mapping
+	  members of the regular POSIX SCHED_FIFO/RR policies to a low
+	  priority class of the Cobalt kernel, providing no real-time
+	  guarantee. Therefore, up to a hundred non real-time priority
+	  levels are available from the SCHED_WEAK policy.
 
-	When CONFIG_XENO_OPT_SCHED_WEAK is disabled, Cobalt still
-	supports a single non real-time priority level (i.e. zero
-	priority), assigned to members of the SCHED_OTHER class.
+	  When CONFIG_XENO_OPT_SCHED_WEAK is disabled, Cobalt still
+	  supports a single non real-time priority level (i.e. zero
+	  priority), assigned to members of the SCHED_OTHER class.
 
-	SCHED_WEAK/SCHED_OTHER threads can access Cobalt resources,
-	wait on Cobalt synchronization objects, but cannot compete for
-	the CPU with members of the real-time Cobalt classes.
+	  SCHED_WEAK/SCHED_OTHER threads can access Cobalt resources,
+	  wait on Cobalt synchronization objects, but cannot compete for
+	  the CPU with members of the real-time Cobalt classes.
 
-	Since Cobalt assumes no real-time requirement for
-	SCHED_WEAK/SCHED_OTHER threads, they are automatically moved
-	back to secondary mode upon return from any Cobalt syscall if
-	necessary, unless they hold a Cobalt mutex, which would defer
-	the transition until such mutex is released.
+	  Since Cobalt assumes no real-time requirement for
+	  SCHED_WEAK/SCHED_OTHER threads, they are automatically moved
+	  back to secondary mode upon return from any Cobalt syscall if
+	  necessary, unless they hold a Cobalt mutex, which would defer
+	  the transition until such mutex is released.
 
-	If in doubt, say N.
+	  If in doubt, say N.
 
 config XENO_OPT_SCHED_TP
 	bool "Temporal partitioning"
 	default n
 	depends on XENO_OPT_SCHED_CLASSES
 	help
-	This option enables support for temporal partitioning.
+	  This option enables support for temporal partitioning.
 
-	If in doubt, say N.
+	  If in doubt, say N.
 
 config XENO_OPT_SCHED_TP_NRPART
 	int "Number of partitions"
@@ -58,22 +58,22 @@ config XENO_OPT_SCHED_TP_NRPART
 	range 1 1024
 	depends on XENO_OPT_SCHED_TP
 	help
-	Define here the maximum number of temporal partitions the TP
-	scheduler may have to handle.
+	  Define here the maximum number of temporal partitions the TP
+	  scheduler may have to handle.
 
 config XENO_OPT_SCHED_SPORADIC
 	bool "Sporadic scheduling"
 	default n
 	depends on XENO_OPT_SCHED_CLASSES
 	help
-	This option enables support for the sporadic scheduling policy
-	in the Cobalt kernel (SCHED_SPORADIC), also known as POSIX
-	sporadic server.
+	  This option enables support for the sporadic scheduling policy
+	  in the Cobalt kernel (SCHED_SPORADIC), also known as POSIX
+	  sporadic server.
 
-	It can be used to enforce a capped limit on the execution time
-	of a thread within a given period of time.
+	  It can be used to enforce a capped limit on the execution time
+	  of a thread within a given period of time.
 
-	If in doubt, say N.
+	  If in doubt, say N.
 
 config XENO_OPT_SCHED_SPORADIC_MAXREPL
 	int "Maximum number of pending replenishments"
@@ -81,33 +81,33 @@ config XENO_OPT_SCHED_SPORADIC_MAXREPL
 	range 4 16
 	depends on XENO_OPT_SCHED_SPORADIC
 	help
-	For performance reason, the budget replenishment information
-	is statically stored on a per-thread basis. This parameter
-	defines the maximum number of replenishment requests that can
-	be pending concurrently for any given thread that undergoes
-	sporadic scheduling (system minimum is 4).
+	  For performance reason, the budget replenishment information
+	  is statically stored on a per-thread basis. This parameter
+	  defines the maximum number of replenishment requests that can
+	  be pending concurrently for any given thread that undergoes
+	  sporadic scheduling (system minimum is 4).
 
 config XENO_OPT_SCHED_QUOTA
 	bool "Thread groups with runtime quota"
 	default n
 	depends on XENO_OPT_SCHED_CLASSES
 	help
-	This option enables the SCHED_QUOTA scheduling policy in the
-	Cobalt kernel.
+	  This option enables the SCHED_QUOTA scheduling policy in the
+	  Cobalt kernel.
 
-	This policy enforces a limitation on the CPU consumption of
-	threads over a globally defined period, known as the quota
-	interval. This is done by pooling threads with common
-	requirements in groups, and giving each group a share of the
-	global period (see CONFIG_XENO_OPT_SCHED_QUOTA_PERIOD).
+	  This policy enforces a limitation on the CPU consumption of
+	  threads over a globally defined period, known as the quota
+	  interval. This is done by pooling threads with common
+	  requirements in groups, and giving each group a share of the
+	  global period (see CONFIG_XENO_OPT_SCHED_QUOTA_PERIOD).
 
-	When threads have entirely consumed the quota allotted to the
-	group they belong to, the latter is suspended as a whole,
-	until the next quota interval starts. At this point, a new
-	runtime budget is given to each group, in accordance with its
-	share.
+	  When threads have entirely consumed the quota allotted to the
+	  group they belong to, the latter is suspended as a whole,
+	  until the next quota interval starts. At this point, a new
+	  runtime budget is given to each group, in accordance with its
+	  share.
 
-	If in doubt, say N.
+	  If in doubt, say N.
 
 config XENO_OPT_SCHED_QUOTA_PERIOD
 	int "Quota interval (us)"
@@ -115,7 +115,7 @@ config XENO_OPT_SCHED_QUOTA_PERIOD
 	range 100 1000000000
 	depends on XENO_OPT_SCHED_QUOTA
 	help
-	The global period thread groups can get a share of.
+	  The global period thread groups can get a share of.
 
 config XENO_OPT_SCHED_QUOTA_NR_GROUPS
 	int "Number of thread groups"
@@ -123,80 +123,80 @@ config XENO_OPT_SCHED_QUOTA_NR_GROUPS
 	range 1 1024
 	depends on XENO_OPT_SCHED_QUOTA
 	help
-	The overall number of thread groups which may be defined
-	across all CPUs.
+	  The overall number of thread groups which may be defined
+	  across all CPUs.
 
 config XENO_OPT_STATS
 	bool "Runtime statistics"
 	depends on XENO_OPT_VFILE
 	default y
 	help
-	This option causes the Cobalt kernel to collect various
-	per-thread runtime statistics, which are accessible through
-	the /proc/xenomai/sched/stat interface.
+	  This option causes the Cobalt kernel to collect various
+	  per-thread runtime statistics, which are accessible through
+	  the /proc/xenomai/sched/stat interface.
 
 config XENO_OPT_SHIRQ
 	bool "Shared interrupts"
 	help
-	Enables support for both level- and edge-triggered shared
-	interrupts, so that multiple real-time interrupt handlers
-	are allowed to control dedicated hardware devices which are
-	configured to share the same interrupt line.
+	  Enables support for both level- and edge-triggered shared
+	  interrupts, so that multiple real-time interrupt handlers
+	  are allowed to control dedicated hardware devices which are
+	  configured to share the same interrupt line.
 
 config XENO_OPT_RR_QUANTUM
 	int "Round-robin quantum (us)"
 	default 1000
 	help
-	This parameter defines the duration of the default round-robin
-	time quantum expressed as a count of micro-seconds. This value
-	may be overriden internally by Cobalt services which do
-	provide a round-robin interval.
+	  This parameter defines the duration of the default round-robin
+	  time quantum expressed as a count of micro-seconds. This value
+	  may be overridden internally by Cobalt services which do
+	  provide a round-robin interval.
 
 config XENO_OPT_AUTOTUNE
         tristate "Auto-tuning"
         default y
 	select XENO_DRIVERS_AUTOTUNE
         help
-	Enable auto-tuning capabilities. Auto-tuning is used for
-	adjusting the core timing services to the intrinsic latency of
-	the platform.
+	  Enable auto-tuning capabilities. Auto-tuning is used for
+	  adjusting the core timing services to the intrinsic latency of
+	  the platform.
 
 config XENO_OPT_SCALABLE_SCHED
 	bool "O(1) scheduler"
 	help
-	This option causes a multi-level priority queue to be used in
-	the real-time scheduler, so that it operates in constant-time
-	regardless of the number of _concurrently runnable_ threads
-	(which might be much lower than the total number of active
-	threads).
+	  This option causes a multi-level priority queue to be used in
+	  the real-time scheduler, so that it operates in constant-time
+	  regardless of the number of _concurrently runnable_ threads
+	  (which might be much lower than the total number of active
+	  threads).
 
-	Its use is recommended for large multi-threaded systems
-	involving more than 10 of such threads; otherwise, the default
-	linear method usually performs better with lower memory
-	footprints.
+	  Its use is recommended for large multi-threaded systems
+	  involving more than 10 of such threads; otherwise, the default
+	  linear method usually performs better with lower memory
+	  footprints.
 
 choice
 	prompt "Timer indexing method"
 	default XENO_OPT_TIMER_LIST if !X86_64
 	default XENO_OPT_TIMER_RBTREE if X86_64
 	help
-	This option allows to select the underlying data structure
-	which is going to be used for ordering the outstanding
-	software timers managed by the Cobalt kernel.
+	  This option allows to select the underlying data structure
+	  which is going to be used for ordering the outstanding
+	  software timers managed by the Cobalt kernel.
 
 config XENO_OPT_TIMER_LIST
 	bool "Linear"
 	help
-	Use a linked list. Albeit O(N), this simple data structure is
-	particularly efficient when only a few timers (< 10) may be
-	concurrently outstanding at any point in time.
+	  Use a linked list. Albeit O(N), this simple data structure is
+	  particularly efficient when only a few timers (< 10) may be
+	  concurrently outstanding at any point in time.
 
 config XENO_OPT_TIMER_RBTREE
 	bool "Tree"
 	help
-	Use a red-black tree. This data structure is efficient when a
-	high number of software timers may be concurrently
-	outstanding at any point in time.
+	  Use a red-black tree. This data structure is efficient when a
+	  high number of software timers may be concurrently
+	  outstanding at any point in time.
 
 endchoice
 
@@ -226,74 +226,74 @@ config XENO_OPT_PIPE_NRDEV
 	depends on XENO_OPT_PIPE
 	default 32
 	help
-	Message pipes are bi-directional FIFO communication channels
-	allowing data exchange between Cobalt threads and regular
-	POSIX threads. Pipes natively preserve message boundaries, but
-	can also be used in byte streaming mode from kernel to
-	user-space.
+	  Message pipes are bi-directional FIFO communication channels
+	  allowing data exchange between Cobalt threads and regular
+	  POSIX threads. Pipes natively preserve message boundaries, but
+	  can also be used in byte streaming mode from kernel to
+	  user-space.
 
-	This option sets the maximum number of pipe devices supported
-	in the system. Pipe devices are named /dev/rtpN where N is a
-	device minor number ranging from 0 to XENO_OPT_PIPE_NRDEV - 1.
+	  This option sets the maximum number of pipe devices supported
+	  in the system. Pipe devices are named /dev/rtpN where N is a
+	  device minor number ranging from 0 to XENO_OPT_PIPE_NRDEV - 1.
 
 config XENO_OPT_REGISTRY_NRSLOTS
 	int "Number of registry slots"
 	default 512
 	help
-	The registry is used by the Cobalt kernel to export named
-	resources to user-space programs via the /proc interface.
-	Each named resource occupies a registry slot. This option sets
-	the maximum number of resources the registry can handle.
+	  The registry is used by the Cobalt kernel to export named
+	  resources to user-space programs via the /proc interface.
+	  Each named resource occupies a registry slot. This option sets
+	  the maximum number of resources the registry can handle.
 
 config XENO_OPT_SYS_HEAPSZ
 	int "Size of system heap (Kb)"
 	default 4096
 	help
-	The system heap is used for various internal allocations by
-	the Cobalt kernel. The size is expressed in Kilobytes.
+	  The system heap is used for various internal allocations by
+	  the Cobalt kernel. The size is expressed in Kilobytes.
 
 config XENO_OPT_PRIVATE_HEAPSZ
 	int "Size of private heap (Kb)"
 	default 256
 	help
-	The Cobalt kernel implements fast IPC mechanisms within the
-	scope of a process which require a private kernel memory heap
-	to be mapped in the address space of each Xenomai application
-	process. This option can be used to set the size of this
-	per-process heap.
+	  The Cobalt kernel implements fast IPC mechanisms within the
+	  scope of a process which require a private kernel memory heap
+	  to be mapped in the address space of each Xenomai application
+	  process. This option can be used to set the size of this
+	  per-process heap.
 
-	64k is considered a large enough size for common use cases.
+	  64k is considered a large enough size for common use cases.
 
 config XENO_OPT_SHARED_HEAPSZ
 	int "Size of shared heap (Kb)"
 	default 256
 	help
-	The Cobalt kernel implements fast IPC mechanisms between
-	processes which require a shared kernel memory heap to be
-	mapped in the address space of all Xenomai application
-	processes. This option can be used to set the size of this
-	system-wide heap.
+	  The Cobalt kernel implements fast IPC mechanisms between
+	  processes which require a shared kernel memory heap to be
+	  mapped in the address space of all Xenomai application
+	  processes. This option can be used to set the size of this
+	  system-wide heap.
 
-	64k is considered a large enough size for common use cases.
+	  64k is considered a large enough size for common use cases.
 
 config XENO_OPT_NRTIMERS
        int "Maximum number of POSIX timers per process"
        default 256
        help
-       This tunable controls how many POSIX timers can exist at any
-       given time for each Cobalt process (a timer is created by a
-       call to the timer_create() service of the Cobalt/POSIX API).
+         This tunable controls how many POSIX timers can exist at any
+         given time for each Cobalt process (a timer is created by a
+         call to the timer_create() service of the Cobalt/POSIX API).
 
 config XENO_OPT_DEBUG_TRACE_LOGSZ
        int "Trace log size"
        depends on XENO_OPT_DEBUG_TRACE_RELAX
        default 16
        help
-       The size (kilobytes) of the trace log of relax requests. Once
-       this limit is reached, subsequent traces will be silently
-       discarded.
+         The size (kilobytes) of the trace log of relax requests. Once
+         this limit is reached, subsequent traces will be silently
+         discarded.
 
-       Writing to /proc/xenomai/debug/relax empties the trace log.
+         Writing to /proc/xenomai/debug/relax empties the trace log.
 
 endmenu
 
@@ -303,43 +303,43 @@ config XENO_OPT_TIMING_SCHEDLAT
 	int "User scheduling latency (ns)"
 	default 0
 	help
-	The user scheduling latency is the time between the
-	termination of an interrupt handler and the execution of the
-	first instruction of the real-time application thread this
-	handler resumes. A default value of 0 (recommended) will cause
-	a pre-calibrated value to be used.
+	  The user scheduling latency is the time between the
+	  termination of an interrupt handler and the execution of the
+	  first instruction of the real-time application thread this
+	  handler resumes. A default value of 0 (recommended) will cause
+	  a pre-calibrated value to be used.
 
-	If the auto-tuner is enabled, this value will be used as the
-	factory default when running "autotune --reset".
+	  If the auto-tuner is enabled, this value will be used as the
+	  factory default when running "autotune --reset".
 
 config XENO_OPT_TIMING_KSCHEDLAT
 	int "Intra-kernel scheduling latency (ns)"
 	default 0
 	help
-	The intra-kernel scheduling latency is the time between the
-	termination of an interrupt handler and the execution of the
-	first instruction of the RTDM kernel thread this handler
-	resumes. A default value of 0 (recommended) will cause a
-	pre-calibrated value to be used.
+	  The intra-kernel scheduling latency is the time between the
+	  termination of an interrupt handler and the execution of the
+	  first instruction of the RTDM kernel thread this handler
+	  resumes. A default value of 0 (recommended) will cause a
+	  pre-calibrated value to be used.
 
-	Intra-kernel latency is usually significantly lower than user
-	scheduling latency on MMU-enabled platforms, due to CPU cache
-	latency.
+	  Intra-kernel latency is usually significantly lower than user
+	  scheduling latency on MMU-enabled platforms, due to CPU cache
+	  latency.
 
-	If the auto-tuner is enabled, this value will be used as the
-	factory default when running "autotune --reset".
+	  If the auto-tuner is enabled, this value will be used as the
+	  factory default when running "autotune --reset".
 
 config XENO_OPT_TIMING_IRQLAT
 	int "Interrupt latency (ns)"
 	default 0
 	help
-	The interrupt latency is the time between the occurrence of an
-	IRQ and the first instruction of the interrupt handler which
-	will service it. A default value of 0 (recommended) will cause
-	a pre-calibrated value to be used.
+	  The interrupt latency is the time between the occurrence of an
+	  IRQ and the first instruction of the interrupt handler which
+	  will service it. A default value of 0 (recommended) will cause
+	  a pre-calibrated value to be used.
 
-	If the auto-tuner is enabled, this value will be used as the
-	factory default when running "autotune --reset".
+	  If the auto-tuner is enabled, this value will be used as the
+	  factory default when running "autotune --reset".
 
 endmenu
 
@@ -436,7 +436,7 @@ config XENO_OPT_DEBUG_LEGACY
         bool "Detect usage of legacy constructs/features"
 	default n
 	help
-	    Turns on detection of legacy API usage.
+	  Turns on detection of legacy API usage.
 
 endif # XENO_OPT_DEBUG_USER
 
diff --git a/kernel/cobalt/arch/arm/Kconfig b/kernel/cobalt/arch/arm/Kconfig
index b0cbdc3b7..080f9df80 100644
--- a/kernel/cobalt/arch/arm/Kconfig
+++ b/kernel/cobalt/arch/arm/Kconfig
@@ -5,12 +5,12 @@ config XENO_ARCH_FPU
 	def_bool VFP
 
 config XENO_ARCH_SYS3264
-        def_bool n
+	def_bool n
 
 config XENO_ARCH_OUTOFLINE_XNLOCK
-       bool
-       default y
+	bool
+	default y
 
 config XENO_ARCH_IPIPE_COMPAT
-       def_bool DOVETAIL
-       select IPIPE_COMPAT
+	def_bool DOVETAIL
+	select IPIPE_COMPAT
diff --git a/kernel/cobalt/arch/arm64/Kconfig b/kernel/cobalt/arch/arm64/Kconfig
index 14e5fa1c4..2ea82ce48 100644
--- a/kernel/cobalt/arch/arm64/Kconfig
+++ b/kernel/cobalt/arch/arm64/Kconfig
@@ -5,9 +5,9 @@ config XENO_ARCH_FPU
 	def_bool y
 
 config XENO_ARCH_SYS3264
-        def_bool COMPAT
-        depends on COMPAT_VDSO
+	def_bool COMPAT
+	depends on COMPAT_VDSO
 
 config XENO_ARCH_OUTOFLINE_XNLOCK
-       bool
-       default y
+	bool
+	default y
diff --git a/kernel/cobalt/arch/x86/Kconfig b/kernel/cobalt/arch/x86/Kconfig
index 9adbbf79d..dd08a5a3a 100644
--- a/kernel/cobalt/arch/x86/Kconfig
+++ b/kernel/cobalt/arch/x86/Kconfig
@@ -2,7 +2,7 @@ config XENO_ARCH_FPU
 	def_bool y
 
 config XENO_ARCH_SYS3264
-        def_bool IA32_EMULATION
+	def_bool IA32_EMULATION
 
 source "kernel/xenomai/Kconfig"
 source "drivers/xenomai/Kconfig"
diff --git a/kernel/drivers/Kconfig b/kernel/drivers/Kconfig
index 197a48eef..a0781c4bf 100644
--- a/kernel/drivers/Kconfig
+++ b/kernel/drivers/Kconfig
@@ -4,21 +4,21 @@ config XENO_OPT_RTDM_COMPAT_DEVNODE
 	bool "Enable legacy pathnames for named RTDM devices"
 	default y
 	help
-	This compatibility option allows applications to open named
-	RTDM devices using the legacy naming scheme, i.e.
+	  This compatibility option allows applications to open named
+	  RTDM devices using the legacy naming scheme, i.e.
 
-	fd = open("devname", ...);
-	   or
-	fd = open("/dev/devname", ...);
+	  fd = open("devname", ...);
+	     or
+	  fd = open("/dev/devname", ...);
 
-	When such a request is received by RTDM, a warning message is
-	issued to the kernel log whenever XENO_OPT_DEBUG_LEGACY is
-	also enabled in the kernel configuration.
+	  When such a request is received by RTDM, a warning message is
+	  issued to the kernel log whenever XENO_OPT_DEBUG_LEGACY is
+	  also enabled in the kernel configuration.
 
-	Applications should open named devices via their actual device
-	nodes instead, i.e.
+	  Applications should open named devices via their actual device
+	  nodes instead, i.e.
 
-	fd = open("/dev/rtdm/devname", ...);
+	  fd = open("/dev/rtdm/devname", ...);
 
 source "drivers/xenomai/autotune/Kconfig"
 source "drivers/xenomai/serial/Kconfig"
diff --git a/kernel/drivers/analogy/Kconfig b/kernel/drivers/analogy/Kconfig
index 858762bda..bb838abbf 100644
--- a/kernel/drivers/analogy/Kconfig
+++ b/kernel/drivers/analogy/Kconfig
@@ -3,50 +3,45 @@ menu "ANALOGY drivers"
 config XENO_DRIVERS_ANALOGY
 	tristate "ANALOGY interface"
 	help
-
-	ANALOGY is a framework aimed at supporting data acquisition
-	devices.
+	  ANALOGY is a framework aimed at supporting data acquisition devices.
 
 config XENO_DRIVERS_ANALOGY_DEBUG
-       depends on XENO_DRIVERS_ANALOGY
-       bool "Analogy debug trace"
-       default n
-       help
-
-       Enable debugging traces in Analogy so as to monitor Analogy's
-       core and drivers behaviours.
+	depends on XENO_DRIVERS_ANALOGY
+	bool "Analogy debug trace"
+	default n
+	help
+	  Enable debugging traces in Analogy so as to monitor Analogy's
+	  core and drivers behaviours.
 
 config XENO_DRIVERS_ANALOGY_DEBUG_FTRACE
-       depends on XENO_DRIVERS_ANALOGY_DEBUG
-       bool "Analogy debug ftrace"
-       default n
-       help
-
-       Route the Analogy a4l_dbg and a4l_info statements to /sys/kernel/debug/
+	depends on XENO_DRIVERS_ANALOGY_DEBUG
+	bool "Analogy debug ftrace"
+	default n
+	help
+	  Route the Analogy a4l_dbg and a4l_info statements to
+	  /sys/kernel/debug/
 
 config XENO_DRIVERS_ANALOGY_DEBUG_LEVEL
-       depends on XENO_DRIVERS_ANALOGY_DEBUG
-       int "Analogy core debug level threshold"
-       default 0
-       help
-
-       Define the level above which the debugging traces will not be
-       displayed.
+	depends on XENO_DRIVERS_ANALOGY_DEBUG
+	int "Analogy core debug level threshold"
+	default 0
+	help
+	  Define the level above which the debugging traces will not be
+	  displayed.
 
-       WARNING: this threshold is only applied on the Analogy
-       core. That will not affect the driver.
+	  WARNING: this threshold is only applied on the Analogy core.
+	  That will not affect the driver.
 
 config XENO_DRIVERS_ANALOGY_DRIVER_DEBUG_LEVEL
-       depends on XENO_DRIVERS_ANALOGY_DEBUG
-       int "Analogy driver debug level threshold"
-       default 0
-       help
-
-       Define the level above which the debugging traces will not be
-       displayed.
+	depends on XENO_DRIVERS_ANALOGY_DEBUG
+	int "Analogy driver debug level threshold"
+	default 0
+	help
+	  Define the level above which the debugging traces will not be
+	  displayed.
 
-       WARNING: this threshold is only applied on the Analogy
-       driver. That will not affect the core.
+	  WARNING: this threshold is only applied on the Analogy
+	  driver. That will not affect the core.
 
 source "drivers/xenomai/analogy/testing/Kconfig"
 source "drivers/xenomai/analogy/intel/Kconfig"
diff --git a/kernel/drivers/analogy/testing/Kconfig b/kernel/drivers/analogy/testing/Kconfig
index 15db78289..8da11d644 100644
--- a/kernel/drivers/analogy/testing/Kconfig
+++ b/kernel/drivers/analogy/testing/Kconfig
@@ -4,10 +4,9 @@ config XENO_DRIVERS_ANALOGY_FAKE
 	tristate "Fake driver"
 	default n
 	help
-
-	The fake driver displays many subdevices:
-	- 0: analog input;
-	- 1: digital input / output;
-	- 2: analog output;
-	- 3: analog input; data written into the subdevice 2 can be
-          read here.
+	  The fake driver displays many subdevices:
+	  - 0: analog input;
+	  - 1: digital input / output;
+	  - 2: analog output;
+	  - 3: analog input; data written into the subdevice 2 can be
+            read here.
diff --git a/kernel/drivers/can/Kconfig b/kernel/drivers/can/Kconfig
index 2d7e66965..97e902938 100644
--- a/kernel/drivers/can/Kconfig
+++ b/kernel/drivers/can/Kconfig
@@ -3,32 +3,30 @@ menu "CAN drivers"
 config XENO_DRIVERS_CAN
 	tristate "RT-Socket-CAN, CAN raw socket interface"
 	help
-	RT-Socket-CAN is a real-time socket interface for CAN controllers.
+	  RT-Socket-CAN is a real-time socket interface for CAN controllers.
 
 config XENO_DRIVERS_CAN_DEBUG
 	depends on XENO_DRIVERS_CAN && PROC_FS
 	bool "Enable debug output"
 	default y
 	help
-
-	This option activates debugging checks and enhanced output for the
-	RT-Socket-CAN driver. It also allows to list the hardware registers
-	of the registered CAN controllers. It is a recommended option for
-	getting started and analysing potential problems. For production
-	purposes, it should be switched off (for the sake of latency).
+	  This option activates debugging checks and enhanced output for the
+	  RT-Socket-CAN driver. It also allows to list the hardware registers
+	  of the registered CAN controllers. It is a recommended option for
+	  getting started and analysing potential problems. For production
+	  purposes, it should be switched off (for the sake of latency).
 
 config XENO_DRIVERS_CAN_LOOPBACK
 	depends on XENO_DRIVERS_CAN
 	bool "Enable TX loopback to local sockets"
 	default n
 	help
-
-	This options adds support for TX loopback to local sockets. Normally,
-	messages sent to the CAN bus are not visible to sockets listening to
-	the same local device. When this option is enabled, TX messages are
-	looped back locally when the transmit has been done by default. This
-	behaviour can be deactivated or reactivated with "setsockopt". Enable
-	this option, if you want to have a "net-alike" behaviour.
+	  This options adds support for TX loopback to local sockets. Normally,
+	  messages sent to the CAN bus are not visible to sockets listening to
+	  the same local device. When this option is enabled, TX messages are
+	  looped back locally when the transmit has been done by default. This
+	  behaviour can be deactivated or reactivated with "setsockopt". Enable
+	  this option, if you want to have a "net-alike" behaviour.
 
 config XENO_DRIVERS_CAN_RXBUF_SIZE
 	depends on XENO_DRIVERS_CAN
@@ -45,45 +43,40 @@ config XENO_DRIVERS_CAN_MAX_RECEIVERS
 	int "Maximum number of receive filters per device"
 	default 16
 	help
-
-	The driver maintains a receive filter list per device for fast access.
+	  The driver maintains a receive filter list per device for fast access.
 
 config XENO_DRIVERS_CAN_BUS_ERR
 	depends on XENO_DRIVERS_CAN
 	bool
 	default n
 	help
-
-	To avoid unnecessary bus error interrupt flooding, this option enables
-	bus error interrupts when an application is calling a receive function
-	on a socket listening on bus errors. After one bus error has occured,
-	the interrupt will be disabled to allow the application time for error
-	processing. This option is automatically selected for CAN controllers
-	supporting bus error interrupts like the SJA1000.
+	  To avoid unnecessary bus error interrupt flooding, this option enables
+	  bus error interrupts when an application is calling a receive function
+	  on a socket listening on bus errors. After one bus error has occurred,
+	  the interrupt will be disabled to allow the application time for error
+	  processing. This option is automatically selected for CAN controllers
+	  supporting bus error interrupts like the SJA1000.
 
 config XENO_DRIVERS_CAN_CALC_BITTIME_OLD
 	depends on XENO_DRIVERS_CAN
 	bool "Old bit-time calculation algorithm (deprecated)"
 	default n
 	help
-
-	This option allows to enable the old algorithm to calculate the
-	CAN bit-timing parameters for backward compatibility.
+	  This option allows to enable the old algorithm to calculate the
+	  CAN bit-timing parameters for backward compatibility.
 
 config XENO_DRIVERS_CAN_VIRT
 	depends on XENO_DRIVERS_CAN
 	tristate "Virtual CAN bus driver"
 	help
-
-	This driver provides two CAN ports that are virtually interconnected.
-	More ports can be enabled with the module parameter "devices".
+	  This driver provides two CAN ports that are virtually interconnected.
+	  More ports can be enabled with the module parameter "devices".
 
 config XENO_DRIVERS_CAN_FLEXCAN
 	depends on XENO_DRIVERS_CAN && OF && !XENO_DRIVERS_CAN_CALC_BITTIME_OLD
 	tristate "Freescale FLEXCAN based chips"
 	help
-
-	Say Y here if you want to support for Freescale FlexCAN.
+	  Say Y here if you want to support for Freescale FlexCAN.
 
 source "drivers/xenomai/can/c_can/Kconfig"
 source "drivers/xenomai/can/peak_canfd/Kconfig"
diff --git a/kernel/drivers/can/c_can/Kconfig b/kernel/drivers/can/c_can/Kconfig
index 6d9b37921..d847d2cc3 100644
--- a/kernel/drivers/can/c_can/Kconfig
+++ b/kernel/drivers/can/c_can/Kconfig
@@ -6,10 +6,9 @@ config XENO_DRIVERS_CAN_C_CAN_PLATFORM
 	depends on XENO_DRIVERS_CAN_C_CAN
 	tristate "Generic Platform Bus based controller"
 	help
-
-	This driver adds support for the C_CAN/D_CAN chips connected
-	to the "platform bus" (Linux abstraction for directly to the
-	processor attached devices) which can be found on various
-	boards from ST Microelectronics (http://www.st.com) like the
-	SPEAr1310 and SPEAr320 evaluation boards & TI (www.ti.com)
-	boards like am335x, dm814x, dm813x and dm811x.
+	  This driver adds support for the C_CAN/D_CAN chips connected
+	  to the "platform bus" (Linux abstraction for directly to the
+	  processor attached devices) which can be found on various
+	  boards from ST Microelectronics (http://www.st.com) like the
+	  SPEAr1310 and SPEAr320 evaluation boards & TI (www.ti.com)
+	  boards like am335x, dm814x, dm813x and dm811x.
diff --git a/kernel/drivers/can/peak_canfd/Kconfig b/kernel/drivers/can/peak_canfd/Kconfig
index 0fccce9af..314f4f9a3 100644
--- a/kernel/drivers/can/peak_canfd/Kconfig
+++ b/kernel/drivers/can/peak_canfd/Kconfig
@@ -2,5 +2,4 @@ config XENO_DRIVERS_CAN_PEAK_CANFD
 	depends on XENO_DRIVERS_CAN && PCI && !XENO_DRIVERS_CAN_CALC_BITTIME_OLD
 	tristate "PEAK driver for PCAN-PCIe FD family"
 	help
-
-	This driver supports the PCAN-PCIe FD boards family from PEAK-System.
+	  This driver supports the PCAN-PCIe FD boards family from PEAK-System.
diff --git a/kernel/drivers/can/sja1000/Kconfig b/kernel/drivers/can/sja1000/Kconfig
index 9fab4a475..280045962 100644
--- a/kernel/drivers/can/sja1000/Kconfig
+++ b/kernel/drivers/can/sja1000/Kconfig
@@ -7,94 +7,85 @@ config XENO_DRIVERS_CAN_SJA1000_ISA
 	depends on XENO_DRIVERS_CAN_SJA1000
 	tristate "Standard ISA controllers"
 	help
-
-	This driver is for CAN devices connected to the ISA bus of a PC
-	or a PC/104 system. The I/O port, interrupt number and a few other
-	hardware specific parameters can be defined via module parameters.
+	  This driver is for CAN devices connected to the ISA bus of a PC
+	  or a PC/104 system. The I/O port, interrupt number and a few other
+	  hardware specific parameters can be defined via module parameters.
 
 config XENO_DRIVERS_CAN_SJA1000_MEM
 	depends on XENO_DRIVERS_CAN_SJA1000
 	tristate "Memory mapped controllers"
 	help
-
-	This driver is for memory mapped CAN devices. The memory address,
-	interrupt number and a few other hardware specific parameters can
-	be defined via module parameters.
+	  This driver is for memory mapped CAN devices. The memory address,
+	  interrupt number and a few other hardware specific parameters can
+	  be defined via module parameters.
 
 config XENO_DRIVERS_CAN_SJA1000_PEAK_PCI
 	depends on XENO_DRIVERS_CAN_SJA1000 && PCI
 	tristate "PEAK PCI Card"
 	help
-
-	This driver is for the PCAN PCI, the PC-PCI CAN plug-in card (1 or
-	2 channel) from PEAK Systems (http://www.peak-system.com). To get
-	the second channel working, Xenomai's shared interrupt support
-	must be enabled.
+	  This driver is for the PCAN PCI, the PC-PCI CAN plug-in card (1 or
+	  2 channel) from PEAK Systems (http://www.peak-system.com). To get
+	  the second channel working, Xenomai's shared interrupt support
+	  must be enabled.
 
 config XENO_DRIVERS_CAN_SJA1000_IXXAT_PCI
 	depends on XENO_DRIVERS_CAN_SJA1000 && PCI
 	tristate "IXXAT PCI Card"
 	help
-
-	This driver is for the IXXAT PC-I 04/PCI card (1 or 2 channel)
-	from the IXXAT Automation GmbH (http://www.ixxat.de). To get
-	the second channel working, Xenomai's shared interrupt support
-	must be enabled.
+	  This driver is for the IXXAT PC-I 04/PCI card (1 or 2 channel)
+	  from the IXXAT Automation GmbH (http://www.ixxat.de). To get
+	  the second channel working, Xenomai's shared interrupt support
+	  must be enabled.
 
 config XENO_DRIVERS_CAN_SJA1000_ADV_PCI
 	depends on XENO_DRIVERS_CAN_SJA1000 && PCI
 	tristate "ADVANTECH PCI Cards"
 	help
-
-	This driver is for the ADVANTECH PCI cards (1 or more channels)
-	It supports the 1680U and some other ones.
+	  This driver is for the ADVANTECH PCI cards (1 or more channels)
+	  It supports the 1680U and some other ones.
 
 
 config XENO_DRIVERS_CAN_SJA1000_PLX_PCI
 	depends on XENO_DRIVERS_CAN_SJA1000 && PCI
 	tristate "PLX90xx PCI-bridge based Cards"
 	help
-
-	This driver is for CAN interface cards based on
-	the PLX90xx PCI bridge.
-	Driver supports now:
-	 - Adlink PCI-7841/cPCI-7841 card (http://www.adlinktech.com/)
-	 - Adlink PCI-7841/cPCI-7841 SE card
-	 - esd CAN-PCI/CPCI/PCI104/200 (http://www.esd.eu/)
-	 - esd CAN-PCI/PMC/266
-	 - esd CAN-PCIe/2000
-	 - Marathon CAN-bus-PCI card (http://www.marathon.ru/)
-	 - TEWS TECHNOLOGIES TPMC810 card (http://www.tews.com/)
+	  This driver is for CAN interface cards based on
+	  the PLX90xx PCI bridge.
+	  Driver supports now:
+	   - Adlink PCI-7841/cPCI-7841 card (http://www.adlinktech.com/)
+	   - Adlink PCI-7841/cPCI-7841 SE card
+	   - esd CAN-PCI/CPCI/PCI104/200 (http://www.esd.eu/)
+	   - esd CAN-PCI/PMC/266
+	   - esd CAN-PCIe/2000
+	   - Marathon CAN-bus-PCI card (http://www.marathon.ru/)
+	   - TEWS TECHNOLOGIES TPMC810 card (http://www.tews.com/)
 
 config XENO_DRIVERS_CAN_SJA1000_EMS_PCI
 	depends on XENO_DRIVERS_CAN_SJA1000 && PCI
 	tristate "EMS CPC PCI Card"
 	help
-
-	This driver is for the 2 channel CPC PCI card from EMS Dr. Thomas
-	Wünsche (http://www.ems-wuensche.de). To get the second channel
-	working, Xenomai's shared interrupt support must be enabled.
+	  This driver is for the 2 channel CPC PCI card from EMS Dr. Thomas
+	  Wünsche (http://www.ems-wuensche.de). To get the second channel
+	  working, Xenomai's shared interrupt support must be enabled.
 
 config XENO_DRIVERS_CAN_SJA1000_ESD_PCI
 	depends on XENO_DRIVERS_CAN_SJA1000 && PCI
 	tristate "ESD PCI Cards (DEPRECATED)"
 	help
+	  This driver supports the esd PCI CAN cards CAN-PCI/200,
+	  CAN-PCI/266, CAN-PMC/266 (PMC), CAN-CPCI/200 (CompactPCI),
+	  CAN-PCIe2000 (PCI Express) and CAN-PCI104/200 (PCI104)
+	  from the esd electronic system design gmbh (http://www.esd.eu).
 
-	This driver supports the esd PCI CAN cards CAN-PCI/200,
-	CAN-PCI/266, CAN-PMC/266 (PMC), CAN-CPCI/200 (CompactPCI),
-	CAN-PCIe2000 (PCI Express) and CAN-PCI104/200 (PCI104)
-	from the esd electronic system design gmbh (http://www.esd.eu).
-
-	This driver is deprecated. It's functionality is now provided by
-	"PLX90xx PCI-bridge based Cards" driver.
+	  This driver is deprecated. It's functionality is now provided by
+	  "PLX90xx PCI-bridge based Cards" driver.
 
 config XENO_DRIVERS_CAN_SJA1000_PEAK_DNG
 	depends on XENO_DRIVERS_CAN_SJA1000 && !PARPORT
 	tristate "PEAK Parallel Port Dongle"
 	help
-
-	This driver is for the PCAN Dongle, the PC parallel port to CAN
-	converter from PEAK Systems (http://www.peak-system.com). You need
-	to disable parallel port support in the kernel (CONFIG_PARPORT) for
-	proper operation. The interface type (sp or epp), I/O port and
-	interrupt number should be defined via module parameters.
+	  This driver is for the PCAN Dongle, the PC parallel port to CAN
+	  converter from PEAK Systems (http://www.peak-system.com). You need
+	  to disable parallel port support in the kernel (CONFIG_PARPORT) for
+	  proper operation. The interface type (sp or epp), I/O port and
+	  interrupt number should be defined via module parameters.
diff --git a/kernel/drivers/gpio/Kconfig b/kernel/drivers/gpio/Kconfig
index bc9cbc5e9..94943388f 100644
--- a/kernel/drivers/gpio/Kconfig
+++ b/kernel/drivers/gpio/Kconfig
@@ -1,11 +1,10 @@
 menu "Real-time GPIO drivers"
 
 config XENO_DRIVERS_GPIO
-       bool "GPIO controller"
-       depends on GPIOLIB
-       help
-
-       Real-time capable GPIO module.
+	bool "GPIO controller"
+	depends on GPIOLIB
+	help
+	  Real-time capable GPIO module.
 
 if XENO_DRIVERS_GPIO
 
@@ -13,67 +12,59 @@ config XENO_DRIVERS_GPIO_BCM2835
 	depends on MACH_BCM2708 || ARCH_BCM2835
 	tristate "Support for BCM2835 GPIOs"
 	help
-
-	Enables support for the GPIO controller available from
-	Broadcom's BCM2835 SoC.
+	  Enables support for the GPIO controller available from
+	  Broadcom's BCM2835 SoC.
 
 config XENO_DRIVERS_GPIO_BCM2711
 	depends on MACH_BCM2708 || ARCH_BCM2835
 	tristate "Support for BCM2711 GPIOs"
 	help
-
-	Enables support for the GPIO controller available from
-	Broadcom's BCM2711 SoC.
+	  Enables support for the GPIO controller available from
+	  Broadcom's BCM2711 SoC.
 
 config XENO_DRIVERS_GPIO_MXC
 	depends on GPIO_MXC
 	tristate "Support for MXC GPIOs"
 	help
-
-	Suitable for the GPIO controller available from
-	Freescale/NXP's MXC architecture.
+	  Suitable for the GPIO controller available from
+	  Freescale/NXP's MXC architecture.
 
 config XENO_DRIVERS_GPIO_SUN8I_H3
 	depends on MACH_SUN8I && PINCTRL_SUN8I_H3
 	tristate "Support for SUN8I H3 GPIOs"
 	help
-
-	Suitable for the GPIO controller available from Allwinner's H3
-	SoC, as found on the NanoPI boards.
+	  Suitable for the GPIO controller available from Allwinner's H3
+	  SoC, as found on the NanoPI boards.
 
 config XENO_DRIVERS_GPIO_ZYNQ7000
 	depends on ARCH_ZYNQ || ARCH_ZYNQMP
 	tristate "Support for Zynq7000 GPIOs"
 	help
-
-	Enables support for the GPIO controller available from
-	Xilinx's Zynq7000 SoC.
+	  Enables support for the GPIO controller available from
+	  Xilinx's Zynq7000 SoC.
 
 config XENO_DRIVERS_GPIO_XILINX
 	depends on ARCH_ZYNQ || ARCH_ZYNQMP
 	tristate "Support for Xilinx GPIOs"
 	help
-
-	Enables support for the GPIO controller available from
-	Xilinx's softcore IP.
+	  Enables support for the GPIO controller available from
+	  Xilinx's softcore IP.
 
 config XENO_DRIVERS_GPIO_OMAP
 	depends on ARCH_OMAP2PLUS || ARCH_OMAP
 	tristate "Support for OMAP GPIOs"
 	help
-
-	Enables support for the GPIO controller available from
-	OMAP family SOC.
+	  Enables support for the GPIO controller available from
+	  OMAP family SOC.
 
 config XENO_DRIVERS_GPIO_CHERRYVIEW
 	depends on PINCTRL_CHERRYVIEW
 	tristate "Support for Cherryview GPIOs"
 	help
-
-	Enables support for the Intel Cherryview GPIO controller
+	  Enables support for the Intel Cherryview GPIO controller
 
 config XENO_DRIVERS_GPIO_DEBUG
-       bool "Enable GPIO core debugging features"
+	bool "Enable GPIO core debugging features"
 
 endif
 
diff --git a/kernel/drivers/gpiopwm/Kconfig b/kernel/drivers/gpiopwm/Kconfig
index 532742a88..106780af6 100644
--- a/kernel/drivers/gpiopwm/Kconfig
+++ b/kernel/drivers/gpiopwm/Kconfig
@@ -3,7 +3,6 @@ menu "GPIOPWM support"
 config XENO_DRIVERS_GPIOPWM
 	tristate "GPIOPWM driver"
 	help
-
-	An RTDM-based GPIO PWM generator driver
+	  An RTDM-based GPIO PWM generator driver
 
 endmenu
diff --git a/kernel/drivers/ipc/Kconfig b/kernel/drivers/ipc/Kconfig
index 104413aed..951ff3a29 100644
--- a/kernel/drivers/ipc/Kconfig
+++ b/kernel/drivers/ipc/Kconfig
@@ -3,9 +3,8 @@ menu "Real-time IPC drivers"
 config XENO_DRIVERS_RTIPC
 	tristate "RTIPC protocol family"
 	help
-
-	This driver provides the real-time IPC protocol family
-	(PF_RTIPC) over RTDM.
+	  This driver provides the real-time IPC protocol family
+	  (PF_RTIPC) over RTDM.
 
 config XENO_DRIVERS_RTIPC_XDDP
 	depends on XENO_DRIVERS_RTIPC
@@ -13,21 +12,20 @@ config XENO_DRIVERS_RTIPC_XDDP
 	default y
 	bool "XDDP cross-domain datagram protocol"
 	help
+	  Xenomai's XDDP protocol enables threads to exchange datagrams
+	  across the Xenomai/Linux domain boundary, using "message
+	  pipes".
 
-	Xenomai's XDDP protocol enables threads to exchange datagrams
-	across the Xenomai/Linux domain boundary, using "message
-	pipes".
-
-	Message pipes are bi-directional FIFO communication channels
-	allowing data exchange between real-time Xenomai threads and
-	regular (i.e. non real-time) user-space processes. Message
-	pipes are datagram-based and thus natively preserve message
-	boundaries, but they can also be used in byte stream mode when
-	sending from the real-time to the non real-time domain.
+	  Message pipes are bi-directional FIFO communication channels
+	  allowing data exchange between real-time Xenomai threads and
+	  regular (i.e. non real-time) user-space processes. Message
+	  pipes are datagram-based and thus natively preserve message
+	  boundaries, but they can also be used in byte stream mode when
+	  sending from the real-time to the non real-time domain.
 
-	The maximum number of communication ports available in the
-	system can be configured using the XENO_OPT_PIPE_NRDEV option
-	from the Nucleus menu.
+	  The maximum number of communication ports available in the
+	  system can be configured using the XENO_OPT_PIPE_NRDEV option
+	  from the Nucleus menu.
 
 config XENO_DRIVERS_RTIPC_IDDP
 	depends on XENO_DRIVERS_RTIPC
@@ -35,19 +33,17 @@ config XENO_DRIVERS_RTIPC_IDDP
 	default y
 	bool "IDDP intra-domain datagram protocol"
 	help
-
-	Xenomai's IDDP protocol enables real-time threads to exchange
-	datagrams within the Xenomai domain.
+	  Xenomai's IDDP protocol enables real-time threads to exchange
+	  datagrams within the Xenomai domain.
 
 config XENO_OPT_IDDP_NRPORT
 	depends on XENO_DRIVERS_RTIPC_IDDP
 	int "Number of IDDP communication ports"
 	default 32
 	help
-
-	This parameter defines the number of IDDP ports available in
-	the system for creating receiver endpoints. Port numbers range
-	from 0 to CONFIG_XENO_OPT_IDDP_NRPORT - 1.
+	  This parameter defines the number of IDDP ports available in
+	  the system for creating receiver endpoints. Port numbers range
+	  from 0 to CONFIG_XENO_OPT_IDDP_NRPORT - 1.
 
 config XENO_DRIVERS_RTIPC_BUFP
 	depends on XENO_DRIVERS_RTIPC
@@ -55,27 +51,25 @@ config XENO_DRIVERS_RTIPC_BUFP
 	default y
 	bool "Buffer protocol"
 	help
-
-	The buffer protocol implements a byte-oriented, one-way
-	Producer-Consumer data path, which makes it a bit faster than
-	datagram-oriented protocols. All messages written are buffered
-	into a single memory area in strict FIFO order, until read by
-	the consumer.
-
-	This protocol prevents short writes, and only allows short
-	reads when a potential deadlock situation arises (i.e. readers
-	and writers waiting for each other indefinitely), which
-	usually means that the buffer size does not fit the use peer
-	threads are making from the protocol.
+	  The buffer protocol implements a byte-oriented, one-way
+	  Producer-Consumer data path, which makes it a bit faster than
+	  datagram-oriented protocols. All messages written are buffered
+	  into a single memory area in strict FIFO order, until read by
+	  the consumer.
+
+	  This protocol prevents short writes, and only allows short
+	  reads when a potential deadlock situation arises (i.e. readers
+	  and writers waiting for each other indefinitely), which
+	  usually means that the buffer size does not fit the use peer
+	  threads are making from the protocol.
 
 config XENO_OPT_BUFP_NRPORT
 	depends on XENO_DRIVERS_RTIPC_BUFP
 	int "Number of BUFP communication ports"
 	default 32
 	help
-
-	This parameter defines the number of BUFP ports available in
-	the system for creating receiver endpoints. Port numbers range
-	from 0 to CONFIG_XENO_OPT_BUFP_NRPORT - 1.
+	  This parameter defines the number of BUFP ports available in
+	  the system for creating receiver endpoints. Port numbers range
+	  from 0 to CONFIG_XENO_OPT_BUFP_NRPORT - 1.
 
 endmenu
diff --git a/kernel/drivers/net/Kconfig b/kernel/drivers/net/Kconfig
index 2e8032464..576627d66 100644
--- a/kernel/drivers/net/Kconfig
+++ b/kernel/drivers/net/Kconfig
@@ -1,20 +1,20 @@
 menu "RTnet"
 
 config XENO_DRIVERS_NET
-    depends on m
-    select NET
-    tristate "RTnet, TCP/IP socket interface"
+	depends on m
+	select NET
+	tristate "RTnet, TCP/IP socket interface"
 
 if XENO_DRIVERS_NET
 
 config XENO_DRIVERS_RTNET_CHECKED
-    bool "Internal Bug Checks"
-    default n
-    help
-    Switch on if you face crashes when RTnet is running or if you suspect
-    any other RTnet-related issues. This feature will add a few sanity
-    checks at critical points that will produce warnings on the kernel
-    console in case certain internal bugs are detected.
+	bool "Internal Bug Checks"
+	default n
+	help
+	  Switch on if you face crashes when RTnet is running or if you suspect
+	  any other RTnet-related issues. This feature will add a few sanity
+	  checks at critical points that will produce warnings on the kernel
+	  console in case certain internal bugs are detected.
 
 source "drivers/xenomai/net/stack/Kconfig"
 source "drivers/xenomai/net/drivers/Kconfig"
diff --git a/kernel/drivers/net/addons/Kconfig b/kernel/drivers/net/addons/Kconfig
index e92f6d8ca..8215c39aa 100644
--- a/kernel/drivers/net/addons/Kconfig
+++ b/kernel/drivers/net/addons/Kconfig
@@ -1,44 +1,44 @@
 menu "Add-Ons"
-    depends on XENO_DRIVERS_NET
+	depends on XENO_DRIVERS_NET
 
 config XENO_DRIVERS_NET_ADDON_RTCAP
-    depends on XENO_DRIVERS_NET && m
-    select ETHERNET
-    tristate "Real-Time Capturing Support"
-    default n
-    help
-    This feature allows to capture real-time packets traversing the RTnet
-    stack. It can both be used to sniff passively on a network (in this
-    case you may want to enable the promisc mode of your real-time NIC via
-    rtifconfig) and to log the traffic the node receives and transmits
-    during normal operation. RTcap consists of additional hooks in the
-    RTnet stack and a separate module as interface to standard network
-    analysis tools like Ethereal.
+	depends on XENO_DRIVERS_NET && m
+	select ETHERNET
+	tristate "Real-Time Capturing Support"
+	default n
+	help
+	  This feature allows to capture real-time packets traversing the RTnet
+	  stack. It can both be used to sniff passively on a network (in this
+	  case you may want to enable the promisc mode of your real-time NIC via
+	  rtifconfig) and to log the traffic the node receives and transmits
+	  during normal operation. RTcap consists of additional hooks in the
+	  RTnet stack and a separate module as interface to standard network
+	  analysis tools like Ethereal.
 
-    For further information see Documentation/README.rtcap.
+	  For further information see Documentation/README.rtcap.
 
 config XENO_DRIVERS_NET_ADDON_PROXY
-    depends on XENO_DRIVERS_NET_RTIPV4 && m
-    select ETHERNET
-    tristate "IP protocol proxy for Linux"
-    default n
-    help
-    Enables a forward-to-Linux module for all IP protocols that are not
-    handled by the IPv4 implemenation of RTnet (TCP, UDP, etc.). Only use
-    when you know what you are doing - it can easily break your real-time
-    requirements!
+	depends on XENO_DRIVERS_NET_RTIPV4 && m
+	select ETHERNET
+	tristate "IP protocol proxy for Linux"
+	default n
+	help
+	  Enables a forward-to-Linux module for all IP protocols that are not
+	  handled by the IPv4 implementation of RTnet (TCP, UDP, etc.). Only use
+	  when you know what you are doing - it can easily break your real-time
+	  requirements!
 
-    See Documentation/README.rtnetproxy for further information.
+	  See Documentation/README.rtnetproxy for further information.
 
 config XENO_DRIVERS_NET_ADDON_PROXY_ARP
-    depends on XENO_DRIVERS_NET_ADDON_PROXY
-    bool "Enable ARP handling via protocol proxy"
-    default n
-    help
-    Enables ARP support for the IP protocol proxy. Incoming ARP replies
-    are then delivered to both, the RTnet and the Linux network stack,
-    but only answered by Linux. The IP protocol proxy gets attached to
-    the RTnet device specified by the module parameter "rtdev_attach",
-    rteth0 by default.
+	depends on XENO_DRIVERS_NET_ADDON_PROXY
+	bool "Enable ARP handling via protocol proxy"
+	default n
+	help
+	  Enables ARP support for the IP protocol proxy. Incoming ARP replies
+	  are then delivered to both, the RTnet and the Linux network stack,
+	  but only answered by Linux. The IP protocol proxy gets attached to
+	  the RTnet device specified by the module parameter "rtdev_attach",
+	  rteth0 by default.
 
 endmenu
diff --git a/kernel/drivers/net/drivers/Kconfig b/kernel/drivers/net/drivers/Kconfig
index 8ecd560b0..04362fbb0 100644
--- a/kernel/drivers/net/drivers/Kconfig
+++ b/kernel/drivers/net/drivers/Kconfig
@@ -1,119 +1,119 @@
 menu "Drivers"
-    depends on XENO_DRIVERS_NET
+	depends on XENO_DRIVERS_NET
 
 comment "Common PCI Drivers"
-    depends on PCI
+	depends on PCI
 
 config XENO_DRIVERS_NET_DRV_PCNET32
-    depends on XENO_DRIVERS_NET && PCI
-    tristate "AMD PCnet32"
+	depends on XENO_DRIVERS_NET && PCI
+	tristate "AMD PCnet32"
 
 
 config XENO_DRIVERS_NET_DRV_TULIP
-    depends on XENO_DRIVERS_NET && PCI
-    tristate "DEC Tulip"
+	depends on XENO_DRIVERS_NET && PCI
+	tristate "DEC Tulip"
 
 
 config XENO_DRIVERS_NET_DRV_EEPRO100
-    depends on XENO_DRIVERS_NET && PCI
-    tristate "Intel EtherExpress PRO/100"
-    default y
+	depends on XENO_DRIVERS_NET && PCI
+	tristate "Intel EtherExpress PRO/100"
+	default y
 
 config XENO_DRIVERS_NET_DRV_EEPRO100_CMDTIMEOUT
-    depends on XENO_DRIVERS_NET && PCI
-    int "Command Timeout"
-    depends on XENO_DRIVERS_NET_DRV_EEPRO100
-    default 20
-    help
-    Timeout in microseconds of transmission or configuration commands that
-    are issued in real-time contexts.
+	depends on XENO_DRIVERS_NET && PCI
+	int "Command Timeout"
+	depends on XENO_DRIVERS_NET_DRV_EEPRO100
+	default 20
+	help
+	  Timeout in microseconds of transmission or configuration commands
+	  that are issued in real-time contexts.
 
 config XENO_DRIVERS_NET_DRV_EEPRO100_DBG
-    depends on XENO_DRIVERS_NET && PCI
-    bool "Enable debugging and instrumentation"
-    depends on XENO_DRIVERS_NET_DRV_EEPRO100
-    help
-    This option switches on internal debugging code of the EEPRO/100 driver.
-    It also enables the collection of worst-case command delays in real-time
-    contexts in order to reduce the command timeout (which, effectively, will
-    also reduce the worst-case transmission latency).
+	depends on XENO_DRIVERS_NET && PCI
+	bool "Enable debugging and instrumentation"
+	depends on XENO_DRIVERS_NET_DRV_EEPRO100
+	help
+	  This option switches on internal debugging code of the EEPRO/100
+	  driver. It also enables the collection of worst-case command delays
+	  in real-time contexts in order to reduce the command timeout (which,
+	  effectively, will also reduce the worst-case transmission latency).
 
 
 config XENO_DRIVERS_NET_DRV_E1000
-    depends on XENO_DRIVERS_NET && PCI
-    tristate "Intel(R) PRO/1000 (Gigabit)"
-    default y
+	depends on XENO_DRIVERS_NET && PCI
+	tristate "Intel(R) PRO/1000 (Gigabit)"
+	default y
 
 config XENO_DRIVERS_NET_DRV_E1000E
-    depends on XENO_DRIVERS_NET && PCI
-    tristate "New Intel(R) PRO/1000 PCIe (Gigabit)"
+	depends on XENO_DRIVERS_NET && PCI
+	tristate "New Intel(R) PRO/1000 PCIe (Gigabit)"
 
 
 config XENO_DRIVERS_NET_DRV_NATSEMI
-    depends on XENO_DRIVERS_NET && PCI
-    tristate "NatSemi"
+	depends on XENO_DRIVERS_NET && PCI
+	tristate "NatSemi"
 
 
 config XENO_DRIVERS_NET_DRV_8139
-    depends on XENO_DRIVERS_NET && PCI
-    tristate "Realtek 8139"
-    default y
+	depends on XENO_DRIVERS_NET && PCI
+	tristate "Realtek 8139"
+	default y
 
 
 config XENO_DRIVERS_NET_DRV_VIA_RHINE
-    depends on XENO_DRIVERS_NET && PCI
-    tristate "VIA Rhine"
+	depends on XENO_DRIVERS_NET && PCI
+	tristate "VIA Rhine"
 
 
 config XENO_DRIVERS_NET_DRV_IGB
-    select I2C
-    select I2C_ALGOBIT
-    depends on XENO_DRIVERS_NET && PCI
-    tristate "Intel(R) 82575 (Gigabit)"
+	select I2C
+	select I2C_ALGOBIT
+	depends on XENO_DRIVERS_NET && PCI
+	tristate "Intel(R) 82575 (Gigabit)"
 
 config XENO_DRIVERS_NET_DRV_IGC
-    depends on XENO_DRIVERS_NET && PCI
-    tristate "Intel(R) Ethernet Controller I225-LM/I225-V support"
+	depends on XENO_DRIVERS_NET && PCI
+	tristate "Intel(R) Ethernet Controller I225-LM/I225-V support"
 
 config XENO_DRIVERS_NET_DRV_R8169
-    depends on XENO_DRIVERS_NET && PCI
-    tristate "Realtek 8169 (Gigabit)"
+	depends on XENO_DRIVERS_NET && PCI
+	tristate "Realtek 8169 (Gigabit)"
 
 
 comment "Misc Drivers"
 
 config XENO_DRIVERS_NET_DRV_LOOPBACK
-    depends on XENO_DRIVERS_NET
-    tristate "Loopback"
-    default y
+	depends on XENO_DRIVERS_NET
+	tristate "Loopback"
+	default y
 
 if ARM
 
 config XENO_DRIVERS_NET_DRV_AT91_ETHER
-    depends on XENO_DRIVERS_NET && SOC_AT91RM9200
-    select XENO_DRIVERS_NET_DRV_MACB
-    tristate "AT91RM9200 Board Ethernet Driver"
+	depends on XENO_DRIVERS_NET && SOC_AT91RM9200
+	select XENO_DRIVERS_NET_DRV_MACB
+	tristate "AT91RM9200 Board Ethernet Driver"
 
 config XENO_DRIVERS_NET_DRV_MACB
-    depends on XENO_DRIVERS_NET
-    select AT91_PROGRAMMABLE_CLOCKS if ARCH_AT91
-    tristate "Cadence MACB/GEM devices"
-    help
-    Driver for internal MAC-controller on AT91SAM926x microcontrollers.
-    Porting by Cristiano Mantovani and Stefano Banzi (Marposs SpA).
+	depends on XENO_DRIVERS_NET
+	select AT91_PROGRAMMABLE_CLOCKS if ARCH_AT91
+	tristate "Cadence MACB/GEM devices"
+	help
+	  Driver for internal MAC-controller on AT91SAM926x microcontrollers.
+	  Porting by Cristiano Mantovani and Stefano Banzi (Marposs SpA).
 
 endif
 
 config XENO_DRIVERS_NET_FEC
-    depends on XENO_DRIVERS_NET
-    depends on BROKEN || $(VERSION) < 6 || ($(VERSION) = 6 && $(PATCHLEVEL) < 3)
-    tristate "Freescale FEC"
-    depends on ARCH_MXC || SOC_IMX28
-    select PHYLIB
-    imply PTP_1588_CLOCK
-    help
-    For built-in 10/100 Fast ethernet controller on Freescale i.MX
-    processors.
+	depends on XENO_DRIVERS_NET
+	depends on BROKEN || $(VERSION) < 6 || ($(VERSION) = 6 && $(PATCHLEVEL) < 3)
+	tristate "Freescale FEC"
+	depends on ARCH_MXC || SOC_IMX28
+	select PHYLIB
+	imply PTP_1588_CLOCK
+	help
+	  For built-in 10/100 Fast ethernet controller on Freescale i.MX
+	  processors.
 
 source "drivers/xenomai/net/drivers/experimental/Kconfig"
 
diff --git a/kernel/drivers/net/drivers/experimental/Kconfig b/kernel/drivers/net/drivers/experimental/Kconfig
index e6a5edb9f..3571f06b8 100644
--- a/kernel/drivers/net/drivers/experimental/Kconfig
+++ b/kernel/drivers/net/drivers/experimental/Kconfig
@@ -1,12 +1,12 @@
 config XENO_DRIVERS_NET_EXP_DRIVERS
-    depends on XENO_DRIVERS_NET && PCI
-    bool "Experimental Drivers"
+	depends on XENO_DRIVERS_NET && PCI
+	bool "Experimental Drivers"
 
 if XENO_DRIVERS_NET_EXP_DRIVERS
 
 config XENO_DRIVERS_NET_DRV_E1000_NEW
-    depends on PCI
-    tristate "New Intel(R) PRO/1000 (Gigabit)"
+	depends on PCI
+	tristate "New Intel(R) PRO/1000 (Gigabit)"
 
 source "drivers/xenomai/net/drivers/experimental/rt2500/Kconfig"
 
diff --git a/kernel/drivers/net/drivers/experimental/rt2500/Kconfig b/kernel/drivers/net/drivers/experimental/rt2500/Kconfig
index 054412839..46cd4308a 100644
--- a/kernel/drivers/net/drivers/experimental/rt2500/Kconfig
+++ b/kernel/drivers/net/drivers/experimental/rt2500/Kconfig
@@ -1,4 +1,4 @@
 config XENO_DRIVERS_NET_DRV_RT2500
-    depends on XENO_DRIVERS_NET && PCI
-    tristate "Ralink 2500 WLAN"
-    select XENO_DRIVERS_NET_RTWLAN
+	depends on XENO_DRIVERS_NET && PCI
+	tristate "Ralink 2500 WLAN"
+	select XENO_DRIVERS_NET_RTWLAN
diff --git a/kernel/drivers/net/stack/Kconfig b/kernel/drivers/net/stack/Kconfig
index 996536cc5..bf151f3df 100644
--- a/kernel/drivers/net/stack/Kconfig
+++ b/kernel/drivers/net/stack/Kconfig
@@ -1,35 +1,35 @@
 menu "Protocol Stack"
-    depends on XENO_DRIVERS_NET
+	depends on XENO_DRIVERS_NET
 
 comment "Stack parameters"
 
 config XENO_DRIVERS_NET_RX_FIFO_SIZE
-    int "Size of central RX-FIFO"
-    depends on XENO_DRIVERS_NET
-    default 32
-    help
-    Size of FIFO between NICs and stack manager task. Must be power
-    of two! Effectively, only CONFIG_RTNET_RX_FIFO_SIZE-1 slots will
-    be usable.
+	int "Size of central RX-FIFO"
+	depends on XENO_DRIVERS_NET
+	default 32
+	help
+	  Size of FIFO between NICs and stack manager task. Must be power
+	  of two! Effectively, only CONFIG_RTNET_RX_FIFO_SIZE-1 slots will
+	  be usable.
 
 config XENO_DRIVERS_NET_ETH_P_ALL
-    depends on XENO_DRIVERS_NET
-    bool "Support for ETH_P_ALL"
-    help
-    Enables core support for registering listeners on all layer 3
-    protocols (ETH_P_ALL). Internally this is currently realised by
-    clone-copying incoming frames for those listners, future versions
-    will implement buffer sharing for efficiency reasons. Use with
-    care, every ETH_P_ALL-listener adds noticable overhead to the
-    reception path.
+	depends on XENO_DRIVERS_NET
+	bool "Support for ETH_P_ALL"
+	help
+	  Enables core support for registering listeners on all layer 3
+	  protocols (ETH_P_ALL). Internally this is currently realised by
+	  clone-copying incoming frames for those listeners, future versions
+	  will implement buffer sharing for efficiency reasons. Use with
+	  care, every ETH_P_ALL-listener adds noticeable overhead to the
+	  reception path.
 
 config XENO_DRIVERS_NET_RTWLAN
-    depends on XENO_DRIVERS_NET
-    bool "Real-Time WLAN"
-    help
-    Enables core support for real-time wireless LAN. RT-WLAN is based
-    on low-level access to 802.11-compliant adapters and is currently
-    in an experimental stage.
+	depends on XENO_DRIVERS_NET
+	bool "Real-Time WLAN"
+	help
+	  Enables core support for real-time wireless LAN. RT-WLAN is based
+	  on low-level access to 802.11-compliant adapters and is currently
+	  in an experimental stage.
 
 comment "Protocols"
 
diff --git a/kernel/drivers/net/stack/ipv4/Kconfig b/kernel/drivers/net/stack/ipv4/Kconfig
index d5a6cd6d7..46c5d0f98 100644
--- a/kernel/drivers/net/stack/ipv4/Kconfig
+++ b/kernel/drivers/net/stack/ipv4/Kconfig
@@ -1,75 +1,75 @@
 config XENO_DRIVERS_NET_RTIPV4
-    depends on XENO_DRIVERS_NET
-    tristate "Real-Time IPv4"
-    default y
-    help
-    Enables the real-time capable IPv4 support of RTnet. The protocol is
-    implemented as a separate module. Supplementing tools (rtroute,
-    rtping) and examples are provided as well. Moreover, RTcfg will
-    include IPv4 support when this option is switched on.
+	depends on XENO_DRIVERS_NET
+	tristate "Real-Time IPv4"
+	default y
+	help
+	  Enables the real-time capable IPv4 support of RTnet. The protocol is
+	  implemented as a separate module. Supplementing tools (rtroute,
+	  rtping) and examples are provided as well. Moreover, RTcfg will
+	  include IPv4 support when this option is switched on.
 
-    For further information see also Documentation/README.routing and
-    Documentation/README.ipfragmentation.
+	  For further information see also Documentation/README.routing and
+	  Documentation/README.ipfragmentation.
 
 config XENO_DRIVERS_NET_RTIPV4_ICMP
-    bool "ICMP support"
-    depends on XENO_DRIVERS_NET_RTIPV4
-    default y
-    help
-    Enables ICMP support of the RTnet Real-Time IPv4 protocol.
+	bool "ICMP support"
+	depends on XENO_DRIVERS_NET_RTIPV4
+	default y
+	help
+	  Enables ICMP support of the RTnet Real-Time IPv4 protocol.
 
-    When the RTnet-Proxy is enabled while this feature is disabled, ICMP
-    will be forwarded to the Linux network stack.
+	  When the RTnet-Proxy is enabled while this feature is disabled, ICMP
+	  will be forwarded to the Linux network stack.
 
 config XENO_DRIVERS_NET_RTIPV4_HOST_ROUTES
-    int "Maximum host routing table entries"
-    depends on XENO_DRIVERS_NET_RTIPV4
-    default 32
-    help
-    Each IPv4 supporting interface and each remote host that is directly
-    reachable via via some output interface requires a host routing table
-    entry. If you run larger networks with may hosts per subnet, you may
-    have to increase this limit. Must be power of 2!
+	int "Maximum host routing table entries"
+	depends on XENO_DRIVERS_NET_RTIPV4
+	default 32
+	help
+	  Each IPv4 supporting interface and each remote host that is directly
+	  reachable via some output interface requires a host routing table
+	  entry. If you run larger networks with may hosts per subnet, you may
+	  have to increase this limit. Must be power of 2!
 
 config XENO_DRIVERS_NET_RTIPV4_NETROUTING
-    bool "IP Network Routing"
-    depends on XENO_DRIVERS_NET_RTIPV4
-    help
-    Enables routing across IPv4 real-time networks. You will only require
-    this feature in complex networks, while switching it off for flat,
-    single-segment networks improves code size and the worst-case routing
-    decision delay.
+	bool "IP Network Routing"
+	depends on XENO_DRIVERS_NET_RTIPV4
+	help
+	  Enables routing across IPv4 real-time networks. You will only require
+	  this feature in complex networks, while switching it off for flat,
+	  single-segment networks improves code size and the worst-case routing
+	  decision delay.
 
-    See Documentation/README.routing for further information.
+	  See Documentation/README.routing for further information.
 
 config XENO_DRIVERS_NET_RTIPV4_NET_ROUTES
-    int "Maximum network routing table entries"
-    depends on XENO_DRIVERS_NET_RTIPV4_NETROUTING
-    default 16
-    help
-    Each route describing a target network reachable via a router
-    requires an entry in the network routing table. If you run very
-    complex realtime networks, you may have to increase this limit. Must
-    be power of 2!
+	int "Maximum network routing table entries"
+	depends on XENO_DRIVERS_NET_RTIPV4_NETROUTING
+	default 16
+	help
+	  Each route describing a target network reachable via a router
+	  requires an entry in the network routing table. If you run very
+	  complex realtime networks, you may have to increase this limit. Must
+	  be power of 2!
 
 config XENO_DRIVERS_NET_RTIPV4_ROUTER
-    bool "IP Router"
-    depends on XENO_DRIVERS_NET_RTIPV4
-    help
-    When switched on, the RTnet station will be able to forward IPv4
-    packets that are not directed to the station itself. Typically used in
-    combination with CONFIG_RTNET_RTIPV4_NETROUTING.
+	bool "IP Router"
+	depends on XENO_DRIVERS_NET_RTIPV4
+	help
+	  When switched on, the RTnet station will be able to forward IPv4
+	  packets that are not directed to the station itself. Typically used
+	  in combination with CONFIG_RTNET_RTIPV4_NETROUTING.
 
-    See Documentation/README.routing for further information.
+	  See Documentation/README.routing for further information.
 
 config XENO_DRIVERS_NET_RTIPV4_DEBUG
-    bool "RTipv4 Debugging"
-    depends on XENO_DRIVERS_NET_RTIPV4
-    default n
-    
-    help
-    Enables debug message output of the RTipv4 layer. Typically, you
-    may want to turn this on for tracing issues in packet delivery.
+	bool "RTipv4 Debugging"
+	depends on XENO_DRIVERS_NET_RTIPV4
+	default n
+
+	help
+	  Enables debug message output of the RTipv4 layer. Typically, you
+	  may want to turn this on for tracing issues in packet delivery.
 
 source "drivers/xenomai/net/stack/ipv4/udp/Kconfig"
 source "drivers/xenomai/net/stack/ipv4/tcp/Kconfig"
diff --git a/kernel/drivers/net/stack/ipv4/tcp/Kconfig b/kernel/drivers/net/stack/ipv4/tcp/Kconfig
index a69d34679..69f606c42 100644
--- a/kernel/drivers/net/stack/ipv4/tcp/Kconfig
+++ b/kernel/drivers/net/stack/ipv4/tcp/Kconfig
@@ -1,18 +1,18 @@
 config XENO_DRIVERS_NET_RTIPV4_TCP
-    tristate "TCP support"
-    depends on XENO_DRIVERS_NET_RTIPV4
-    help
-    Enables TCP support of the RTnet Real-Time IPv4 protocol.
+	tristate "TCP support"
+	depends on XENO_DRIVERS_NET_RTIPV4
+	help
+	  Enables TCP support of the RTnet Real-Time IPv4 protocol.
 
-    When the RTnet IPv4 is enabled while this feature is disabled, TCP
-    will be forwarded to the Linux network stack.
+	  When the RTnet IPv4 is enabled while this feature is disabled, TCP
+	  will be forwarded to the Linux network stack.
 
 config XENO_DRIVERS_NET_RTIPV4_TCP_ERROR_INJECTION
-    bool "TCP error injection"
-    depends on XENO_DRIVERS_NET_RTIPV4_TCP
-    help
-    Enables error injection for incoming TCP packets. This can be used
-    to test both protocol as well as application behavior under error
-    conditions. The per-socket error rate is 0 by default and can be
-    tuned during runtime via the error_rate and multi_error module
-    parameters.
+	bool "TCP error injection"
+	depends on XENO_DRIVERS_NET_RTIPV4_TCP
+	help
+	  Enables error injection for incoming TCP packets. This can be used
+	  to test both protocol as well as application behavior under error
+	  conditions. The per-socket error rate is 0 by default and can be
+	  tuned during runtime via the error_rate and multi_error module
+	  parameters.
diff --git a/kernel/drivers/net/stack/ipv4/udp/Kconfig b/kernel/drivers/net/stack/ipv4/udp/Kconfig
index a23279411..79141df50 100644
--- a/kernel/drivers/net/stack/ipv4/udp/Kconfig
+++ b/kernel/drivers/net/stack/ipv4/udp/Kconfig
@@ -1,6 +1,6 @@
 config XENO_DRIVERS_NET_RTIPV4_UDP
-    tristate "UDP support"
-    depends on XENO_DRIVERS_NET_RTIPV4
-    default y
-    help
-    Enables UDP support of the RTnet Real-Time IPv4 protocol.
+	tristate "UDP support"
+	depends on XENO_DRIVERS_NET_RTIPV4
+	default y
+	help
+	  Enables UDP support of the RTnet Real-Time IPv4 protocol.
diff --git a/kernel/drivers/net/stack/packet/Kconfig b/kernel/drivers/net/stack/packet/Kconfig
index 4c83b73c2..bb2dbe886 100644
--- a/kernel/drivers/net/stack/packet/Kconfig
+++ b/kernel/drivers/net/stack/packet/Kconfig
@@ -1,14 +1,14 @@
 config XENO_DRIVERS_NET_RTPACKET
-    depends on XENO_DRIVERS_NET
-    tristate "Real-Time Packet Socket Support"
-    default y
-    help
-    Enables real-time packet sockets for RTnet. This support is
-    implemented in a separate module. When loaded, application programs
-    can send and received so-called "cooked" packets directly at OSI layer
-    2 (device layer). This means that RTnet will still maintain the
-    device-dependent packet header but leave the full data segment to the
-    user.
+	depends on XENO_DRIVERS_NET
+	tristate "Real-Time Packet Socket Support"
+	default y
+	help
+	  Enables real-time packet sockets for RTnet. This support is
+	  implemented in a separate module. When loaded, application programs
+	  can send and received so-called "cooked" packets directly at OSI
+	  layer 2 (device layer). This means that RTnet will still maintain the
+	  device-dependent packet header but leave the full data segment to the
+	  user.
 
-    Examples like raw-ethernet or netshm make use of this support. See
-    also Linux man page packet(7).
+	  Examples like raw-ethernet or netshm make use of this support. See
+	  also Linux man page packet(7).
diff --git a/kernel/drivers/net/stack/rtcfg/Kconfig b/kernel/drivers/net/stack/rtcfg/Kconfig
index 38c484046..a04c8f8fb 100644
--- a/kernel/drivers/net/stack/rtcfg/Kconfig
+++ b/kernel/drivers/net/stack/rtcfg/Kconfig
@@ -1,23 +1,23 @@
 config XENO_DRIVERS_NET_RTCFG
-    depends on XENO_DRIVERS_NET
-    tristate "RTcfg Service"
-    default y
-    help
-    The Real-Time Configuration service configures and monitors nodes in
-    a RTnet network. It works both with plain MAC as well as with IPv4
-    addresses (in case CONFIG_RTNET_RTIPV4 has been switched on). RTcfg
-    consists of a configuration server, which can run on the same station
-    as the TDMA master e.g., and one or more clients. Clients can join and
-    leave the network during runtime without interfering with other
-    stations. Besides network configuration, the RTcfg server can also
-    distribute custom data.
+	depends on XENO_DRIVERS_NET
+	tristate "RTcfg Service"
+	default y
+	help
+	  The Real-Time Configuration service configures and monitors nodes in
+	  a RTnet network. It works both with plain MAC as well as with IPv4
+	  addresses (in case CONFIG_RTNET_RTIPV4 has been switched on). RTcfg
+	  consists of a configuration server, which can run on the same station
+	  as the TDMA master e.g., and one or more clients. Clients can join and
+	  leave the network during runtime without interfering with other
+	  stations. Besides network configuration, the RTcfg server can also
+	  distribute custom data.
 
-    See Documentation/README.rtcfg for further information.
+	  See Documentation/README.rtcfg for further information.
 
 config XENO_DRIVERS_NET_RTCFG_DEBUG
-    bool "RTcfg Debugging"
-    depends on XENO_DRIVERS_NET_RTCFG
-    default n
-    help
-    Enables debug message output of the RTcfg state machines. Switch on if
-    you have to trace some problem related to RTcfg.
+	bool "RTcfg Debugging"
+	depends on XENO_DRIVERS_NET_RTCFG
+	default n
+	help
+	  Enables debug message output of the RTcfg state machines. Switch on if
+	  you have to trace some problem related to RTcfg.
diff --git a/kernel/drivers/net/stack/rtmac/Kconfig b/kernel/drivers/net/stack/rtmac/Kconfig
index a97b316b0..56f70af38 100644
--- a/kernel/drivers/net/stack/rtmac/Kconfig
+++ b/kernel/drivers/net/stack/rtmac/Kconfig
@@ -1,16 +1,16 @@
 menuconfig XENO_DRIVERS_NET_RTMAC
-    depends on XENO_DRIVERS_NET
-    tristate "RTmac Layer"
-    default y
-    help
-    The Real-Time Media Access Control layer allows to extend the RTnet
-    stack with software-based access control mechanisms (also called
-    disciplines) for nondeterministic transport media. Disciplines can be
-    attached and detached per real-time device. RTmac also provides a
-    framework for tunnelling non-time-critical packets through real-time
-    networks by installing virtual NICs (VNIC) in the Linux domain.
+	depends on XENO_DRIVERS_NET
+	tristate "RTmac Layer"
+	default y
+	help
+	  The Real-Time Media Access Control layer allows to extend the RTnet
+	  stack with software-based access control mechanisms (also called
+	  disciplines) for nondeterministic transport media. Disciplines can be
+	  attached and detached per real-time device. RTmac also provides a
+	  framework for tunnelling non-time-critical packets through real-time
+	  networks by installing virtual NICs (VNIC) in the Linux domain.
 
-    See Documentation/README.rtmac for further information.
+	  See Documentation/README.rtmac for further information.
 
 source "drivers/xenomai/net/stack/rtmac/tdma/Kconfig"
 source "drivers/xenomai/net/stack/rtmac/nomac/Kconfig"
diff --git a/kernel/drivers/net/stack/rtmac/nomac/Kconfig b/kernel/drivers/net/stack/rtmac/nomac/Kconfig
index e706d4a96..9e457cd3f 100644
--- a/kernel/drivers/net/stack/rtmac/nomac/Kconfig
+++ b/kernel/drivers/net/stack/rtmac/nomac/Kconfig
@@ -1,9 +1,9 @@
 config XENO_DRIVERS_NET_NOMAC
-    tristate "NoMAC discipline for RTmac"
-    depends on XENO_DRIVERS_NET_RTMAC
-    default n
-    help
-    This no-operation RTmac discipline is intended to act as a template
-    for new implementations. However, it can be compiled and used (see
-    nomaccfg management tool), but don't expect any improved determinism
-    of your network. ;)
+	tristate "NoMAC discipline for RTmac"
+	depends on XENO_DRIVERS_NET_RTMAC
+	default n
+	help
+	  This no-operation RTmac discipline is intended to act as a template
+	  for new implementations. However, it can be compiled and used (see
+	  nomaccfg management tool), but don't expect any improved determinism
+	  of your network. ;)
diff --git a/kernel/drivers/net/stack/rtmac/tdma/Kconfig b/kernel/drivers/net/stack/rtmac/tdma/Kconfig
index 4444661f2..3f806c68d 100644
--- a/kernel/drivers/net/stack/rtmac/tdma/Kconfig
+++ b/kernel/drivers/net/stack/rtmac/tdma/Kconfig
@@ -1,21 +1,21 @@
 config XENO_DRIVERS_NET_TDMA
-    tristate "TDMA discipline for RTmac"
-    depends on XENO_DRIVERS_NET_RTMAC
-    default y
-    help
-    The Time Division Multiple Access discipline is the default RTmac
-    protocol for Ethernet networks. It consists of a master synchronising
-    the access of the slaves to the media by periodically issuing frames.
-    Backup masters can be set up to take over if the primary master fails.
-    TDMA also provides a global clock across all participants. The tdmacfg
-    tool can be used to configure a real-time NIC to use TDMA.
+	tristate "TDMA discipline for RTmac"
+	depends on XENO_DRIVERS_NET_RTMAC
+	default y
+	help
+	  The Time Division Multiple Access discipline is the default RTmac
+	  protocol for Ethernet networks. It consists of a master synchronising
+	  the access of the slaves to the media by periodically issuing frames.
+	  Backup masters can be set up to take over if the primary master fails.
+	  TDMA also provides a global clock across all participants. The tdmacfg
+	  tool can be used to configure a real-time NIC to use TDMA.
 
-    See Documenatation/README.rtmac for further details.
+	  See Documenatation/README.rtmac for further details.
 
 config XENO_DRIVERS_NET_TDMA_MASTER
-    bool "TDMA master support"
-    depends on XENO_DRIVERS_NET_TDMA
-    default y
-    help
-    Enables TDMA master and backup master support for the node. This can
-    be switched of to reduce the memory footprint of pure slave nodes.
+	bool "TDMA master support"
+	depends on XENO_DRIVERS_NET_TDMA
+	default y
+	help
+	  Enables TDMA master and backup master support for the node. This can
+	  be switched of to reduce the memory footprint of pure slave nodes.
diff --git a/kernel/drivers/serial/Kconfig b/kernel/drivers/serial/Kconfig
index 43dd5ec23..f6eadb152 100644
--- a/kernel/drivers/serial/Kconfig
+++ b/kernel/drivers/serial/Kconfig
@@ -3,8 +3,8 @@ menu "Serial drivers"
 config XENO_DRIVERS_16550A
 	tristate "16550A UART driver"
 	help
-	Real-time UART driver for 16550A compatible controllers. See
-	doc/txt/16550A-driver.txt for more details.
+	  Real-time UART driver for 16550A compatible controllers. See
+	  doc/txt/16550A-driver.txt for more details.
 
 choice
 	prompt "Hardware access mode"
@@ -14,27 +14,27 @@ choice
 config XENO_DRIVERS_16550A_PIO
 	bool "Port-based I/O"
 	help
-	Hardware access only via I/O ports. Use module parameter
-	"io=<port>[,<port>[,...]]" to specify the base port of a device.
+	  Hardware access only via I/O ports. Use module parameter
+	  "io=<port>[,<port>[,...]]" to specify the base port of a device.
 
 config XENO_DRIVERS_16550A_MMIO
 	bool "Memory-mapped I/O"
 	help
-	Hardware access only via memory mapping. Use module paramter
-	"mem=<addr>[,<addr>[,...]]" to specify the physical base address of
-	a device.
+	  Hardware access only via memory mapping. Use module parameter
+	  "mem=<addr>[,<addr>[,...]]" to specify the physical base address of
+	  a device.
 
 config XENO_DRIVERS_16550A_ANY
 	bool "Any access mode"
 	help
-	Decide at module load-time (or via kernel parameter) which access
-	mode to use for which device. This mode is useful when devices of
-	both types can be present in a system, also at the same time.
+	  Decide at module load-time (or via kernel parameter) which access
+	  mode to use for which device. This mode is useful when devices of
+	  both types can be present in a system, also at the same time.
 
-	Both "io" and "mem" module parameters are available, but always only
-	one of them can be applied on a particular device. Use, e.g.,
-	"io=0x3f8,0 mem=0,0xe0000000" to address device 1 via IO base port
-	0x3f8 and device 2 via physical base address 0xe0000000.
+	  Both "io" and "mem" module parameters are available, but always only
+	  one of them can be applied on a particular device. Use, e.g.,
+	  "io=0x3f8,0 mem=0,0xe0000000" to address device 1 via IO base port
+	  0x3f8 and device 2 via physical base address 0xe0000000.
 
 endchoice
 
@@ -43,37 +43,35 @@ config XENO_DRIVERS_16550A_PCI
 	bool "PCI board support"
 	default n
 	help
-
-	This option activates support for PCI serial boards.
+	  This option activates support for PCI serial boards.
 
 config XENO_DRIVERS_16550A_PCI_MOXA
 	depends on XENO_DRIVERS_16550A_PCI
 	bool "Moxa PCI boards"
 	default n
 	help
-
-	This option activates support for the following Moxa boards:
-	PCI Serial Boards:
-	  C104H/PCI, C168H/PCI
-	  CP-114, CP-132
-	Universal PCI Serial Boards:
-	  CP-102U, CP-102UL, CP-104U
-	  CP-112UL, CP-114UL, CP-118U
-	  CP-132U, CP-134U, CP-138U
-	  CP-168U
+	  This option activates support for the following Moxa boards:
+	  PCI Serial Boards:
+	    C104H/PCI, C168H/PCI
+	    CP-114, CP-132
+	  Universal PCI Serial Boards:
+	    CP-102U, CP-102UL, CP-104U
+	    CP-112UL, CP-114UL, CP-118U
+	    CP-132U, CP-134U, CP-138U
+	    CP-168U
 
 config XENO_DRIVERS_MPC52XX_UART
 	depends on PPC_MPC52xx
 	tristate "MPC52xx PSC UART driver"
 	help
-	Real-time UART driver for the PSC on the MPC5200 processor.
+	  Real-time UART driver for the PSC on the MPC5200 processor.
 
 config XENO_DRIVERS_IMX_UART
 	depends on ARCH_IMX || ARCH_MXC
 	tristate "RT IMX UART driver"
 	select RATIONAL
 	help
-	Real-time UART driver for the Freescale Semiconductor MXC Internal
-	UART compatible controllers.
+	  Real-time UART driver for the Freescale Semiconductor MXC Internal
+	  UART compatible controllers.
 
 endmenu
diff --git a/kernel/drivers/spi/Kconfig b/kernel/drivers/spi/Kconfig
index b48aaf3f9..663a6400c 100644
--- a/kernel/drivers/spi/Kconfig
+++ b/kernel/drivers/spi/Kconfig
@@ -1,26 +1,24 @@
 menu "Real-time SPI master drivers"
 
 config XENO_DRIVERS_SPI
-       depends on SPI
-       tristate
+	depends on SPI
+	tristate
 
 config XENO_DRIVERS_SPI_BCM2835
 	depends on ARCH_BCM2708 || ARCH_BCM2835
 	select XENO_DRIVERS_SPI
 	tristate "Support for BCM2835 SPI"
 	help
-
-	Enables support for the SPI0 controller available from
-	Broadcom's BCM2835 SoC.
+	  Enables support for the SPI0 controller available from
+	  Broadcom's BCM2835 SoC.
 
 config XENO_DRIVERS_SPI_SUN6I
 	depends on MACH_SUN6I || MACH_SUN8I
 	select XENO_DRIVERS_SPI
 	tristate "Support for A31/H3 SoC SPI"
 	help
-
-	Enables support for the SPI controller available from
-	Allwinner's A31, H3 SoCs.
+	  Enables support for the SPI controller available from
+	  Allwinner's A31, H3 SoCs.
 
 config XENO_DRIVERS_SPI_OMAP2_MCSPI_RT
 	tristate "McSPI rt-driver for OMAP"
@@ -28,12 +26,11 @@ config XENO_DRIVERS_SPI_OMAP2_MCSPI_RT
 	depends on ARCH_OMAP2PLUS || COMPILE_TEST
 	select XENO_DRIVERS_SPI
 	help
-
-	SPI real-time master controller for OMAP24XX and later Multichannel SPI
-	(McSPI) modules.
+	  SPI real-time master controller for OMAP24XX and later Multichannel
+	  SPI (McSPI) modules.
 
 config XENO_DRIVERS_SPI_DEBUG
-       depends on XENO_DRIVERS_SPI
-       bool "Enable SPI core debugging features"
-       
+	depends on XENO_DRIVERS_SPI
+	bool "Enable SPI core debugging features"
+
 endmenu
diff --git a/kernel/drivers/testing/Kconfig b/kernel/drivers/testing/Kconfig
index 88c043c82..a189fa19d 100644
--- a/kernel/drivers/testing/Kconfig
+++ b/kernel/drivers/testing/Kconfig
@@ -4,26 +4,26 @@ config XENO_DRIVERS_TIMERBENCH
 	tristate "Timer benchmark driver"
 	default y
 	help
-	Kernel-based benchmark driver for timer latency evaluation.
-	See testsuite/latency for a possible front-end.
+	  Kernel-based benchmark driver for timer latency evaluation.
+	  See testsuite/latency for a possible front-end.
 
 config XENO_DRIVERS_SWITCHTEST
 	tristate "Context switch unit testing driver"
 	default y
 	help
-	Kernel-based driver for unit testing context switches and
-	FPU switches.
+	  Kernel-based driver for unit testing context switches and
+	  FPU switches.
 
 config XENO_DRIVERS_HEAPCHECK
 	tristate "Memory allocator test driver"
 	default y
 	help
-	Kernel-based driver for testing Cobalt's memory allocator.
+	  Kernel-based driver for testing Cobalt's memory allocator.
 
 config XENO_DRIVERS_RTDMTEST
 	depends on m
 	tristate "RTDM unit tests driver"
 	help
-	Kernel driver for performing RTDM unit tests.
+	  Kernel driver for performing RTDM unit tests.
 
 endmenu
diff --git a/kernel/drivers/udd/Kconfig b/kernel/drivers/udd/Kconfig
index 86b9a8258..9b9b0776a 100644
--- a/kernel/drivers/udd/Kconfig
+++ b/kernel/drivers/udd/Kconfig
@@ -3,8 +3,7 @@ menu "UDD support"
 config XENO_DRIVERS_UDD
 	tristate "User-space device driver framework"
 	help
-
-	A RTDM-based driver for enabling interrupt control and I/O
-	memory access interfaces to user-space device drivers.
+	  A RTDM-based driver for enabling interrupt control and I/O
+	  memory access interfaces to user-space device drivers.
 
 endmenu
-- 
2.39.5

