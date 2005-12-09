From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17305.51026.541872.815402@domain.hid>
Date: Fri, 9 Dec 2005 19:05:06 +0100
Subject: Re: [Xenomai-help] Xenomai 2.0.1 - Posix Skin - realtime priorities -
	what I'm doing wrong?
In-Reply-To: <200512091650.11637.schwab@domain.hid>
References: <439995C0.6030006@domain.hid>
	<200512091650.11637.schwab@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

Ulrich Schwab wrote:
 > On Friday 09 December 2005 15:33, Paolo Gai wrote:
 > > Dear all,
 > >
 > > First of all, I would like to thank Philippe for the long and exaustive
 > > reply to my previous post about the scheduling example.
 > >
 > > I'm now trying the POSIX skin to write a very simple example using
 > > real-time priorities, RR and FIFO scheduling.
 > >
 > > The idea is that a high priority task creates two medium priority tasks
 > > (that just prints something using printf) and a low priority task (that
 > > prints a message).  The example is run twice, in one case the medium
 > > priority tasks have SCHED_FIFO, in another case they have SCHED_RR.
 > >
 > > I would expect that in both cases the two medium priority tasks would
 > > run printing their characters (either in a FIFO order or mixed when
 > > using RR), and at their end the low priority task would have run
 > > printing its message.
 > I did not look inside Your code, but if You are using printf the threads will 
 > be switched back to secondary domain (non-RT), this might screw up the order 
 > of scheduling.

What happens for certain is that the access to stdout buffer, when
compiling with the -D_REENTRANT flag, is serialized with a GNU libc
POSIX mutex. This account for the consistent behaviour between GNU libc
libpthread, or Xenomai POSIX skin library. The scheduling order is the
one of the libc POSIX library, and knowing exactly what happens would
require further investigation (there may be a difference between NPTL
and linuxthreads for example).

Working around this issue means using calls to unlocked versions of libc
functions protected with Xenomai POSIX mutexes, such as, for example,
myputs and myputchar (sufficient for Paolo example) defined as :

pthread_mutex_t xeno_stdout_lock;

int myputchar(int c)
{
    int err;

    pthread_mutex_lock(&xeno_stdout_lock);
    err = putchar_unlocked(c);
    pthread_mutex_unlock(&xeno_stdout_lock);

    return err;
}

int myputs(const char *s)
{
    int err;

    pthread_mutex_lock(&xeno_stdout_lock);
    err = puts_unlocked(s);
    pthread_mutex_unlock(&xeno_stdout_lock);

    return err;
}

defining myprintf is a bit more complicated if we want to avoid dynamic
allocation, and if we do not avoid dynamic allocation, malloc is
protected with another mutex, so we may run (less often, of course) into
a similar issue.

Now, your answer yields another important question: are domain
migrations inocuous from a scheduling point of view ?
Intuitively, if two tasks A and B in the same priority group are
runnable, and task A undergoes a migration from secondary to primary,
followed by a migration from primary to secondary without a suspension,
the scheduling order will be wrong.

The reason for this behaviour is that when task A migrates from
primary mode to secondary mode and will be waken up in Linux scheduler,
it should be put at the end of its priority group, so that B should
become the running task.

In short, the two successive migrations are equivalent to calling
sched_yield() from Linux scheduler point of view.

-- 


					    Gilles Chanteperdrix.

