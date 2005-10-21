Message-ID: <4358C829.5050304@domain.hid>
Date: Fri, 21 Oct 2005 12:51:21 +0200
From: =?ISO-8859-15?Q?Ignacio_Garc=EDa_P=E9rez?= <iggarpe@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] timeout in native API calls (cond, sem, mutex,
	etc).
References: <4357C3E1.1040701@domain.hid>
	<4357C9F7.2060808@domain.hid>	<4357CF67.8080601@domain.hid>
	<4357DF0F.3060806@domain.hid> <435896AA.1060103@domain.hid>
In-Reply-To: <435896AA.1060103@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
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

Ok, so I took the time to delve a bit into the xenomai code to check out
by myself how complex would it be to implement absolute timeouts. This
is from a 1 hour walk around the code, so I'll post my thoughts so those
truly knowledgeable can correct me.

(BTW, here goes another praise: nice, readable, structured,
understandable code, you know what's my reference for comparison)

All synchronization primitive's blocking calls that take a timeout end
up using

xnsync_sleep_on()

to suspend (delay, actually) the current thread. That function takes a
relative timeout, just as passed to the blocking synchronization
primitive call. After some magic, xsync_sleep_on() ends up calling

xnpod_suspend_thread()

again passign the timeout as a relative value. Eventually, the timeout
is again passed in a call to:

xntimer_start()

which in turn calls xntimer_do_start_periodic() or
xntimer_do_start_aperiodic() depending on the current timer operation
mode. In xntimer_do_start_(a)periodic(), one can see, finally how the
wakeup time (xntimer_t.date) is calculated from the current time and the
requested sleep interval.

So, we timeout trail is:

rt_mutex_lock() --> xsync_sleep_on() ---> xnpod_suspend_thread() --->
xntimer_start() ---> xntimer_do_start_(a)periodic()

And my assumption that internally the scheduler works with absolute
timeouts for delayed threads is true.

Now suppose that I want to implement absolute timeouts. There are two
alternatives:

1- Write an absolute timeout alter ego of every "public" function in the
native skin AND in the nucleus, except maybe for
xntimer_do_start_(a)periodic.

2- Add a parmeter to every "public" function in the native skin AND in
the nucleus which specifies if the timeout is absolute or relative.

3- Write an absolute timeout alter ego of every synchronization call in
the native skin, and add a parameter in the nucleus calls to specify
absolute/relative timeout.

4- Rewrite all functions that use a relatime timeout to use an absolute
timeout.

(1) Would mean copy&paste of code. Definitely a no-no.

(2) Is very easy to implement. One downside is that, for example, the
locking of a mutex requires three parameters when most of the time one
would do (just the mutex). Another important downside is that it breaks
the API of applications written over the native API.

(3) Best IMHO. Would keep the native API intact while providing all the
absolute/relatime timeout flexibility in the nucleus.

(4) Worst IMHO. Would break the whole API, would be a nightmare to
debug. However, I have to point out that this would probably have been
my initial design choice. Work always with absolute timeouts, if the
user wants a relative timeout, he should calculate it from current time.
I cannot imagine a situation in which a preemption in between getting
current time and issuing the blocking call would be undesirable. I'll
explain:

With the relatime timeout API, if I want this thread to wake up at
t=1000, I must calculate delay as d = 1000 - current_time and then call
rt_sem_p (or whatever). If the thread is preempted between getting
current time and calling rt_sem_p, it will sleep for longer than desired
and will end up waking up after t=1000, which is what I wanted exactly.

In the absolute timeout scenatio, suppose that I want this thread to
wake up in 100 ns. In 100 ns since when?... since current time?... then
use the absolute timeout and you're done. Since some other operation
like setting a digital output?, then there is anyway nothing you can do
to prevent the possibility of being preempted in between the I/O
operation and the actual rt_sem_p call, so why worry about that
preemption happening in between getting current time and issuing the call?

Nacho.

P.S: Not to be a purist, but I think that functions like
xntimer_do_start_aperiodic and xntimer_do_start_periodic should be
declared static, since they are only to be accessed through their
pointers in the nktimer structure.

P.S: As a side note, wouldn't be a good practice to expand tabs to
spaces in all the code?

