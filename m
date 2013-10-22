From: "Daniel Merrill" <daniel.merrill@psware.com>
References: <efafe9af.0000172c.00000011@dmerrill_win764.PERF.PERFORMANCESOFTWARE>	<52558563.2010408@xenomai.org>	<8fed609f.0000172c.00000017@dmerrill_win764.PERF.PERFORMANCESOFTWARE>	<525587A2.5000507@xenomai.org>
 <73cb019f.0000172c.0000001c@dmerrill_win764.PERF.PERFORMANCESOFTWARE>
 <8a1928a6.00000970.00000009@dmerrill_win764.PERF.PERFORMANCESOFTWARE>
 <1aa47ae4.00001700.00000005@dmerrill_win764.PERF.PERFORMANCESOFTWARE>
 <526681B9.1010302@xenomai.org> <5266907C.4010905@xenomai.org>
 <5266AD85.2040201@xenomai.org>
In-Reply-To: <5266AD85.2040201@xenomai.org>
Date: Tue, 22 Oct 2013 15:10:05 -0700 (MST)
Message-ID: <3f032cae.00001700.0000001c@dmerrill_win764.PERF.PERFORMANCESOFTWARE>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Language: en-us
Subject: Re: [Xenomai] t_suspend and XNBREAK
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: 'Philippe Gerum' <rpm@xenomai.org>, 'Gilles Chanteperdrix' <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org



> -----Original Message-----
> From: Philippe Gerum [mailto:rpm@xenomai.org]
> Sent: Tuesday, October 22, 2013 9:53 AM
> To: Gilles Chanteperdrix
> Cc: Daniel Merrill; xenomai@xenomai.org
> Subject: Re: [Xenomai] t_suspend and XNBREAK
>
> On 10/22/2013 04:49 PM, Gilles Chanteperdrix wrote:
> > On 10/22/2013 03:46 PM, Philippe Gerum wrote:
> >> On 10/21/2013 08:21 PM, Daniel Merrill wrote:
> >>
> >>> More follow up on this, we went ahead and put some logging in
> >>> shadow.c which from what we could find is where the signal is
> >>> "kicking" the thread.
> >>> >From the logging it looks like the only signals we get (while
> >>> attached to
> >>> GDB) are SIGSTOP, SIGTRAP, SIGRT32 and SIGKILL(upon exiting the
> >>> debugger).
> >>> I'm assuming the SIGSTOP, SIGTRAP and SIGKILL are normal from the
> >>> debugger. It looks like shadow.c looks for SIGTRAP and SIGSTOP and
> >>> sets an XNDEBUG state on the thread which I assume allows it to
> >>> restart the suspend?
> >>
> >> XNDEBUG marks a thread which is ptraced, this has implications when
> >> managing the system timer while the app is single-stepped/stopped by
> >> a debugger.
> >>
> >>    SIGRT32 I believe comes from our calls to t_delete. I'm guessing
> >>> this is what's causing the suspends to fail? Anyway, I appreciate
> >>> any additional insight anyone can offer. Thanks again for all the 
> >>> help.
> >>>
> >>
> >> t_delete() will cause t_suspend() to unblock if sent to the suspended
> >> task, due to receiving SIGRT32/SIGCANCEL from the linux side, which
> >> is how the NPTL deals with async cancellation internally (t_delete()
> >> ->
> >> pthread_cancel() -> t(g)kill(SIGCANCEL)).
> >>
> >> Internally, XNBREAK will be raised for that task, causing -EINTR to
> >> be propagated back. However, since there is SIGCANCEL pending for the
> >> task, the NPTL handler should run on the way back to the call site in
> >> t_suspend(), and the task should never return from this handler.
> >>
> >> In short, receiving EINTR from t_suspend() is unexpected,
> >> particularly when unblocked by SIGCANCEL. I could not reproduce this
> >> issue based on the simple test, running over GDB (7.5.1).
> >>
> >> A few questions more:
> >>
> >> - regardless of t_delete(), is the problem about one or multiple
> >> threads unblocking unexpectedly from t_suspend(0), when
> >> single-stepping a distinct thread over GDB?
> >>
> >> - I'm testing with Xenomai 2.6.3. Which version have you been using,
> >> on which cpu/platform, using which I-pipe release in the kernel
> >> (check /proc/xenomai/{version, hal}?
> >>
> >> - Also could you write a simple test code illustrating the issue so
> >> that I could try reproducing it? Typically, would this be
> >> reproducible on your setup with a single task running t_suspend(0),
> >> while ptracing the main routine in parallel?
> >
> > Maybe cancellation is disabled with pthread_setcancelstate?
> >
>
> AFAIU the NPTL code, then SIGCANCEL should not be sent.
>
> --
> Philippe.

Ok, If I didn't do anything stupid (don't hold it against me if I did) the
following code seems to reproduce the issue on my system:

#include <stdlib.h>
#include <stdio.h>
#include <psos+/psos.h>
#include <sys/mman.h>

#define CONTROLLER_PRIORITY	5
#define SUB_TASK1_PRIORITY	2
#define SUB_TASK2_PRIORITY	3
#define SUB_TASK3_PRIORITY	4

void subTask3()
{
	u_long retValue = 0;
	int count = 0;
	retValue = t_suspend(0);
	printf("subTask3, suspend returned %ld\n", retValue);
	/* count to 1000000 */
	while(count < 1000000)
		count++;
	retValue = t_suspend(0);
	printf("subTask3, suspend returned %ld\n", retValue);
	/*should never get here, we should have either suspended or
	 * been deleted*/
	while(1);
}

void subTask2()
{
	u_long retValue = 0;
	int count = 0;
	retValue = t_suspend(0);
	printf("subTask2, suspend returned %ld\n", retValue);
	/* count to 100000 */
	while(count < 100000)
		count++;
	retValue = t_suspend(0);
	printf("subTask2, suspend returned %ld\n", retValue);
	/*should never get here, we should have either suspended or
	 * been deleted*/
	while(1);
}

void subTask1()
{
	u_long retValue = 0;
	int count = 0;
	retValue = t_suspend(0);
	printf("subTask1, suspend returned %ld\n", retValue);
	/* count to 10000 */
	while(count < 10000)
		count++;
	retValue = t_suspend(0);
	printf("subTask1, suspend returned %ld\n", retValue);
	/*should never get here, we should have either suspended or
	 * been deleted*/
	while(1);
}

void controllerTask()
{
	u_long tid;

	t_ident("SUB1", 0, &tid);
	t_resume(tid);
	tm_wkafter(5);
	t_delete(tid);

	t_ident("SUB2", 0, &tid);
	t_resume(tid);
	tm_wkafter(5);
	t_delete(tid);

	t_ident("SUB3", 0, &tid);
	t_resume(tid);
	tm_wkafter(5);
	t_delete(tid);

	t_ident("MAIN", 0, &tid);
	ev_send(tid, 0x00000001);
	t_suspend(0);
}


int main(int argc, char *argv[])
{
	u_long contId, sub1Id, sub2Id, sub3Id;
	u_long eventsReceived;

	mlockall(MCL_CURRENT | MCL_FUTURE);

	t_create("CONT", CONTROLLER_PRIORITY, 1000, 1000,
			T_FPU | T_LOCAL, &contId);
	t_create("SUB1", SUB_TASK1_PRIORITY, 1000, 1000,
			T_FPU | T_LOCAL, &sub1Id);
	t_create("SUB2", SUB_TASK2_PRIORITY, 1000, 1000,
		       	T_FPU | T_LOCAL, &sub2Id);
	t_create("SUB3", SUB_TASK3_PRIORITY, 1000, 1000,
		       	T_FPU | T_LOCAL, &sub3Id);
	t_start(sub1Id, T_PREEMPT | T_SUPV | T_NOASR, subTask1, NULL);
	t_start(sub2Id, T_PREEMPT | T_SUPV | T_NOASR, subTask2, NULL);
	t_start(sub3Id, T_PREEMPT | T_SUPV | T_NOASR, subTask3, NULL);
	tm_wkafter(5);
	t_start(contId, T_PREEMPT | T_SUPV | T_NOASR, controllerTask, NULL);

	ev_receive(0x00000001, EV_WAIT | EV_ALL, 0, &eventsReceived);

}

This was compiled with the following command:

gcc -g -I/usr/include/xenomai -D_GNU_SOURCE -D_REENTRANT -D__XENO__
 -I/usr/include/xenomai/psos+ 
test.c -lpsos -L/usr/lib -lxenomai -lpthread -lrt

It was then run in gdb using the following gdb script:

break 20
commands
next
continue
end
b 32
commands
next
continue
end
b 52
commands
next
continue
end
run

Please let me know what you think. If I made a mistake in the test I'm more 
than happy to try again, just let me know what I did wrong. Thanks for 
sticking with me through all this. I appreciate all the advice and help 
that's been given.

Dan Merrill

