Message-ID: <491883AF.4080901@domain.hid>
Date: Mon, 10 Nov 2008 19:55:43 +0100
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
References: <491805AE.1060809@domain.hid>
	<52e18582a48da6c08ed88bbce325aed8.squirrel@domain.hid>
	<491829F9.2050305@domain.hid>
	<c54f288fee2b8a5ee68a00c27056c6ed.squirrel@domain.hid>
In-Reply-To: <c54f288fee2b8a5ee68a00c27056c6ed.squirrel@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Mode switch when using RT heap on ARM
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai-help <xenomai@xenomai.org>

Gilles Chanteperdrix wrote:
> Wolfgang Grandegger wrote:
>> Gilles Chanteperdrix wrote:
>>> Wolfgang Grandegger wrote:
>>>> Hello,
>>>>
>>>> I realized that accessing memory allocated with rt_heap_alloc() causes
>>>> mode switches on ARM i.mx31. The attached patch provides a demo program
>>>> to demonstrate the problem, which actually does *not* show up on my
>>>> PowerPC TQM5200 board.
>>> On ARM, we normally map the heaps uncacheable, this should not be
>>> necessary on ARMv6, but I am afraid we then get the fault on first
>>> access.
>> Is each cache-line of the heap not touched automatically when the heap
>> gets created? I thought it's necessary for other archs as well.
> 
> No, the thing which comes near to this is the workaround in I-pipe of the
> way pages are write-protected upon fork. But this happens only upon fork.
> I am not sure I understand all the subtleties of ARM memory management,
> but I think this fault on first write is the way the "dirty" bit is
> implemented.

Well, it seems not to be that simple. My attached rtheap example program
behaves the following way:

- Heap-mode=0: I see plenty of mode switches also for read-only:

  # cat /proc/xenomai/stat ;sleep 10; cat /proc/xenomai/stat
  CPU  PID    MSW        CSW        PF    STAT       %CPU  NAME
    0  0      0          2951       0     00400080   99.7  ROOT
    0  929    102        398        3     00300184    0.0  rtheap
    0  0      0          23005      0     00000000    0.1  IRQ29: [timer]
  CPU  PID    MSW        CSW        PF    STAT       %CPU  NAME
    0  0      0          4287       0     00400080   99.4  ROOT
    0  929    435        1734       3     00300184    0.4  rtheap
    0  0      0          25010      0     00000000    0.1  IRQ29: [timer]

- Heap-mode=H_NONCACHED: I see just 2 mode switches but the system
  gets very slow:

  # cat /proc/xenomai/stat ;sleep 10; cat /proc/xenomai/stat
  CPU  PID    MSW        CSW        PF    STAT       %CPU  NAME
    0  0      0          5358       0     00400080  100.0  ROOT
    0  941    2          5          1     00300380    0.0  rtheap
    0  0      0          39030      0     00000000    0.0  IRQ29: [timer]
  CPU  PID    MSW        CSW        PF    STAT       %CPU  NAME
    0  0      0          5358       0     00400080   99.9  ROOT
    0  941    2          5          1     00300380    0.0  rtheap
    0  0      0          41232      0     00000000    0.1  IRQ29: [timer]

Hm, am I doing something wrong?

Wolfgang.



#include <stdio.h>
#include <signal.h>
#include <unistd.h>
#include <sys/mman.h>

#include <native/task.h>
#include <native/timer.h>
#include <native/heap.h>

#define USE_HEAP
//#define USE_SIGXCPU

#define HEAP_SIZE (1024*1024)
#if 1
#define HEAP_MODE 0		/* Local heap. */
#else
#define HEAP_MODE H_NONCACHED
#endif

RT_HEAP heap_desc;
RT_TASK demo_task;


static int block_sizes[] = {16, 20, 90, 150, 310, 800, 1000, 5000, 9000};

/* NOTE: error handling omitted. */

void demo(void *arg)
{
	RTIME now, previous;
	void *block;
	int sizes = sizeof(block_sizes) / sizeof(int);
	int count = 0;
	int size, err;
	int *ptr;

#ifdef USE_SIGXCPU
	/* Ask Xenomai to warn us upon switches to secondary mode. */
	rt_task_set_mode(0, T_WARNSW, NULL);
#endif

	/*
	 * Arguments: &task (NULL=self),
	 *            start time,
	 *            period (here: 1 s)
	 */
	rt_task_set_periodic(NULL, TM_NOW, 10000000);
	previous = rt_timer_read();

	while (1) {
		rt_task_wait_period(NULL);
		now = rt_timer_read();

		size = block_sizes[count % sizes];
#ifdef USE_HEAP
		/*
		 * Request a 16-bytes block, asking for a non-blocking call
		 * since only Xenomai tasks may block.
		 */
		err = rt_heap_alloc(&heap_desc, size, TM_NONBLOCK, &block);
		if (err) {
			printf("rt_heap_alloc() failed with %d\n", err);
			break;
		}

		ptr = (int *)block;
		*ptr = 0xdeadbeef;
		if (*ptr != 0xdeadbeef) {
			printf("Write/read test to heap failed\n");
			break;
		}

		ptr = (int *)(block + size - sizeof(int));
		*ptr = 0xbeefface;
		if (*ptr != 0xbeefface) {
			printf("Write/read test to heap failed\n");
			break;
		}

		/* Free the block: */
		rt_heap_free(&heap_desc, block);
#endif

		/*
		 * NOTE: printf may have unexpected impact on the timing of
		 *       your program. It is used here in the critical loop
		 *       only for demonstration purposes.
		 */
		if ((count % 100) == 9) {
			rt_printf("%d: Time since last turn: %ld.%06ld ms\n",
				  count,
				  (long)(now - previous) / 1000000,
				  (long)(now - previous) % 1000000);
			previous = now;
		}
		count++;
	}
}

void catch_signal(int sig)
{
	printf("%s: sig=%d\n", __func__, sig);
}

#ifdef USE_SIGXCPU
void catch_signal_msw(int sig)
{
	void *bt[32];
	int nentries;
		
	rt_printf("%s: sig=%d\n", __func__, sig);

	/* Dump a backtrace of the frame which caused the switch to
	   secondary mode: */
	nentries = backtrace(bt,sizeof(bt) / sizeof(bt[0]));
	backtrace_symbols_fd(bt,nentries,fileno(stdout));
}
#endif

int main(int argc, char* argv[])
{
	void *block;
	int err;

	signal(SIGTERM, catch_signal);
	signal(SIGINT, catch_signal);
#ifdef USE_SIGXCPU
	signal(SIGXCPU, catch_signal_msw);
#endif

	/* Avoids memory swapping for this program */
	mlockall(MCL_CURRENT | MCL_FUTURE);

	/*
	 * Create a 256Kb heap usable for dynamic memory allocation of
	 * variable-size blocks in kernel space.
	 */

	err = rt_heap_create(&heap_desc, "MyHeapName", HEAP_SIZE, HEAP_MODE);
	if (err)
		return err;

	/* Perform auto-init of rt_print buffers if the task doesn't do so */
	rt_print_auto_init(1);

	/* Initialise the rt_print buffer for this task explicitly */
	rt_print_init(4096, "Task 1");

	/*
	 * Arguments: &task,
	 *            name,
	 *            stack size (0=default),
	 *            priority,
	 *            mode (FPU, start suspended, ...)
	 */
	rt_task_create(&demo_task, "rtheap", 0, 99, 0);

	/*
	 * Arguments: &task,
	 *            task function,
	 *            function argument
	 */
	rt_task_start(&demo_task, &demo, NULL);

	pause();

	rt_task_delete(&demo_task);
}


