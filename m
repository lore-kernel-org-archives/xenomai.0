From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <4630B46C.9050809@domain.hid>
References: <4630655A.50204@domain.hid>  <4630B46C.9050809@domain.hid>
Content-Type: text/plain
Date: Thu, 26 Apr 2007 17:45:36 +0200
Message-Id: <1177602336.6860.109.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-core] [PATCH] fix smp build error of native skin
Reply-To: rpm@xenomai.org
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

On Thu, 2007-04-26 at 16:17 +0200, Jan Kiszka wrote:
> Jan Kiszka wrote:
> > We need nucleus/pod.h because xeno_flush_rq() refers to nklock.
> > 
> 
> That was too simple, utterly breaking elsewhere.
> 

The current one also breaks the simulator in alarm.c, fixed.

> The problem was actually that a bit too much stuff (here: native/ppd.h)
> got included in userspace. Here comes a fix + more cleanups of the
> native headers. Hope I'm not causing regressions (only in projects that
> where sloppy about inclusions before).

Ok, a number of people are likely going to hate you for submitting this
patch, as well as myself for applying it, but that's part of the fun of
being a maintainer, I guess. Applied, thanks.

> 
> Jan
> plain text document attachment (native-include-cleanup.patch)
> ---
>  include/native/alarm.h    |    7 ++++---
>  include/native/cond.h     |    5 +++--
>  include/native/event.h    |    3 ++-
>  include/native/heap.h     |    3 ++-
>  include/native/intr.h     |    5 +++--
>  include/native/mutex.h    |    5 +++--
>  include/native/pipe.h     |    3 ++-
>  include/native/ppd.h      |    1 +
>  include/native/queue.h    |    3 ++-
>  include/native/sem.h      |    3 ++-
>  include/native/task.h     |    5 +++--
>  include/native/timer.h    |    5 ++++-
>  ksrc/skins/native/task.c  |    1 +
>  src/skins/native/timer.c  |    2 +-
>  src/utils/can/rtcansend.c |    1 +
>  15 files changed, 34 insertions(+), 18 deletions(-)
> 
> Index: xenomai/include/native/alarm.h
> ===================================================================
> --- xenomai.orig/include/native/alarm.h
> +++ xenomai/include/native/alarm.h
> @@ -22,10 +22,7 @@
>  #ifndef _XENO_ALARM_H
>  #define _XENO_ALARM_H
>  
> -#include <nucleus/timer.h>
> -#include <nucleus/synch.h>
>  #include <native/types.h>
> -#include <native/ppd.h>
>  
>  typedef struct rt_alarm_info {
>  
> @@ -43,6 +40,10 @@ typedef struct rt_alarm_placeholder {
>  
>  #if defined(__KERNEL__) || defined(__XENO_SIM__)
>  
> +#include <nucleus/timer.h>
> +#include <nucleus/synch.h>
> +#include <native/ppd.h>
> +
>  #define XENO_ALARM_MAGIC 0x55550909
>  
>  typedef struct rt_alarm {
> Index: xenomai/include/native/pipe.h
> ===================================================================
> --- xenomai.orig/include/native/pipe.h
> +++ xenomai/include/native/pipe.h
> @@ -25,7 +25,6 @@
>  #include <nucleus/pipe.h>
>  #include <nucleus/heap.h>
>  #include <native/types.h>
> -#include <native/ppd.h>
>  
>  /* Operation flags. */
>  #define P_NORMAL  XNPIPE_NORMAL
> @@ -39,6 +38,8 @@ typedef struct rt_pipe_placeholder {
>  
>  #ifdef __KERNEL__
>  
> +#include <native/ppd.h>
> +
>  #define XENO_PIPE_MAGIC  0x55550202
>  
>  #define P_SYNCWAIT  0
> Index: xenomai/include/native/task.h
> ===================================================================
> --- xenomai.orig/include/native/task.h
> +++ xenomai/include/native/task.h
> @@ -24,8 +24,7 @@
>  
>  #include <nucleus/core.h>
>  #include <nucleus/thread.h>
> -#include <nucleus/synch.h>
> -#include <native/timer.h>
> +#include <native/types.h>
>  
>  /* Creation flags. */
>  #define T_FPU     XNFPU
> @@ -112,6 +111,8 @@ typedef struct rt_task_mcb {
>  
>  #if (defined(__KERNEL__) || defined(__XENO_SIM__)) && !defined(DOXYGEN_CPP)
>  
> +#include <nucleus/synch.h>
> +
>  #define XENO_TASK_MAGIC 0x55550101
>  
>  typedef struct rt_task {
> Index: xenomai/include/native/mutex.h
> ===================================================================
> --- xenomai.orig/include/native/mutex.h
> +++ xenomai/include/native/mutex.h
> @@ -22,9 +22,7 @@
>  #ifndef _XENO_MUTEX_H
>  #define _XENO_MUTEX_H
>  
> -#include <nucleus/synch.h>
>  #include <native/types.h>
> -#include <native/ppd.h>
>  
>  struct rt_task;
>  
> @@ -44,6 +42,9 @@ typedef struct rt_mutex_placeholder {
>  
>  #if (defined(__KERNEL__) || defined(__XENO_SIM__)) && !defined(DOXYGEN_CPP)
>  
> +#include <nucleus/synch.h>
> +#include <native/ppd.h>
> +
>  #define XENO_MUTEX_MAGIC 0x55550505
>  
>  typedef struct __rt_mutex {
> Index: xenomai/include/native/intr.h
> ===================================================================
> --- xenomai.orig/include/native/intr.h
> +++ xenomai/include/native/intr.h
> @@ -22,10 +22,8 @@
>  #ifndef _XENO_INTR_H
>  #define _XENO_INTR_H
>  
> -#include <nucleus/synch.h>
>  #include <nucleus/intr.h>
>  #include <native/types.h>
> -#include <native/ppd.h>
>  
>  /* Creation flag. */
>  #define I_NOAUTOENA  XN_ISR_NOENABLE  /* Do not auto-enable interrupt channel
> @@ -50,6 +48,9 @@ typedef struct rt_intr_placeholder {
>  
>  #if (defined(__KERNEL__) || defined(__XENO_SIM__)) && !defined(DOXYGEN_CPP)
>  
> +#include <nucleus/synch.h>
> +#include <native/ppd.h>
> +
>  #define XENO_INTR_MAGIC 0x55550a0a
>  
>  /* Creation flags. */
> Index: xenomai/include/native/heap.h
> ===================================================================
> --- xenomai.orig/include/native/heap.h
> +++ xenomai/include/native/heap.h
> @@ -25,7 +25,6 @@
>  #include <nucleus/synch.h>
>  #include <nucleus/heap.h>
>  #include <native/types.h>
> -#include <native/ppd.h>
>  
>  /* Creation flags. */
>  #define H_PRIO     XNSYNCH_PRIO	/* Pend by task priority order. */
> @@ -61,6 +60,8 @@ typedef struct rt_heap_placeholder {
>  
>  #if defined(__KERNEL__) || defined(__XENO_SIM__)
>  
> +#include <native/ppd.h>
> +
>  #define XENO_HEAP_MAGIC 0x55550808
>  
>  typedef struct rt_heap {
> Index: xenomai/include/native/timer.h
> ===================================================================
> --- xenomai.orig/include/native/timer.h
> +++ xenomai/include/native/timer.h
> @@ -22,7 +22,6 @@
>  #ifndef _XENO_TIMER_H
>  #define _XENO_TIMER_H
>  
> -#include <nucleus/timer.h>
>  #include <native/types.h>
>  
>  #define TM_ONESHOT XN_APERIODIC_TICK
> @@ -36,7 +35,11 @@ typedef struct rt_timer_info {
>  } RT_TIMER_INFO;
>  
>  #if defined(__KERNEL__) || defined(__XENO_SIM__)
> +
> +#include <nucleus/timer.h>
> +
>  extern xntbase_t *__native_tbase;
> +
>  #endif /* __KERNEL__ || __XENO_SIM__ */
>  
>  #ifdef __cplusplus
> Index: xenomai/include/native/event.h
> ===================================================================
> --- xenomai.orig/include/native/event.h
> +++ xenomai/include/native/event.h
> @@ -24,7 +24,6 @@
>  
>  #include <nucleus/synch.h>
>  #include <native/types.h>
> -#include <native/ppd.h>
>  
>  /* Creation flags. */
>  #define EV_PRIO  XNSYNCH_PRIO	/* Pend by task priority order. */
> @@ -50,6 +49,8 @@ typedef struct rt_event_placeholder {
>  
>  #if (defined(__KERNEL__) || defined(__XENO_SIM__)) && !defined(DOXYGEN_CPP)
>  
> +#include <native/ppd.h>
> +
>  #define XENO_EVENT_MAGIC 0x55550404
>  
>  typedef struct rt_event {
> Index: xenomai/include/native/cond.h
> ===================================================================
> --- xenomai.orig/include/native/cond.h
> +++ xenomai/include/native/cond.h
> @@ -22,9 +22,7 @@
>  #ifndef _XENO_COND_H
>  #define _XENO_COND_H
>  
> -#include <nucleus/synch.h>
>  #include <native/mutex.h>
> -#include <native/ppd.h>
>  
>  typedef struct rt_cond_info {
>  
> @@ -42,6 +40,9 @@ typedef struct rt_cond_placeholder {
>  
>  #if (defined(__KERNEL__) || defined(__XENO_SIM__)) && !defined(DOXYGEN_CPP)
>  
> +#include <nucleus/synch.h>
> +#include <native/ppd.h>
> +
>  #define XENO_COND_MAGIC 0x55550606
>  
>  typedef struct rt_cond {
> Index: xenomai/include/native/ppd.h
> ===================================================================
> --- xenomai.orig/include/native/ppd.h
> +++ xenomai/include/native/ppd.h
> @@ -22,6 +22,7 @@
>  #ifndef _XENO_PPD_H
>  #define _XENO_PPD_H
>  
> +#include <nucleus/pod.h>
>  #include <nucleus/ppd.h>
>  #include <nucleus/heap.h>
>  
> Index: xenomai/include/native/sem.h
> ===================================================================
> --- xenomai.orig/include/native/sem.h
> +++ xenomai/include/native/sem.h
> @@ -24,7 +24,6 @@
>  
>  #include <nucleus/synch.h>
>  #include <native/types.h>
> -#include <native/ppd.h>
>  
>  /* Creation flags. */
>  #define S_PRIO  XNSYNCH_PRIO	/* Pend by task priority order. */
> @@ -47,6 +46,8 @@ typedef struct rt_sem_placeholder {
>  
>  #if (defined(__KERNEL__) || defined(__XENO_SIM__)) && !defined(DOXYGEN_CPP)
>  
> +#include <native/ppd.h>
> +
>  #define XENO_SEM_MAGIC 0x55550303
>  
>  typedef struct rt_sem {
> Index: xenomai/include/native/queue.h
> ===================================================================
> --- xenomai.orig/include/native/queue.h
> +++ xenomai/include/native/queue.h
> @@ -25,7 +25,6 @@
>  #include <nucleus/synch.h>
>  #include <nucleus/heap.h>
>  #include <native/types.h>
> -#include <native/ppd.h>
>  
>  /* Creation flags. */
>  #define Q_PRIO   XNSYNCH_PRIO	/* Pend by task priority order. */
> @@ -72,6 +71,8 @@ typedef struct rt_queue_placeholder {
>  
>  #if defined(__KERNEL__) || defined(__XENO_SIM__)
>  
> +#include <native/ppd.h>
> +
>  #define XENO_QUEUE_MAGIC 0x55550707
>  
>  typedef struct rt_queue {
> Index: xenomai/src/utils/can/rtcansend.c
> ===================================================================
> --- xenomai.orig/src/utils/can/rtcansend.c
> +++ xenomai/src/utils/can/rtcansend.c
> @@ -8,6 +8,7 @@
>  #include <sys/mman.h>
>  
>  #include <native/task.h>
> +#include <native/timer.h>
>  #include <native/pipe.h>
>  
>  #include <rtdm/rtcan.h>
> Index: xenomai/src/skins/native/timer.c
> ===================================================================
> --- xenomai.orig/src/skins/native/timer.c
> +++ xenomai/src/skins/native/timer.c
> @@ -17,7 +17,7 @@
>   */
>  
>  #include <native/syscall.h>
> -#include <native/task.h>
> +#include <native/timer.h>
>  
>  extern int __native_muxid;
>  
> Index: xenomai/ksrc/skins/native/task.c
> ===================================================================
> --- xenomai.orig/ksrc/skins/native/task.c
> +++ xenomai/ksrc/skins/native/task.c
> @@ -48,6 +48,7 @@
>  #include <nucleus/heap.h>
>  #include <nucleus/registry.h>
>  #include <native/task.h>
> +#include <native/timer.h>
>  
>  static DECLARE_XNQUEUE(__xeno_task_q);
>  
> _______________________________________________
> Xenomai-core mailing list
> Xenomai-core@domain.hid
> https://mail.gna.org/listinfo/xenomai-core
-- 
Philippe.



