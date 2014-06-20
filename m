Message-ID: <53A471AB.3030904@xenomai.org>
Date: Fri, 20 Jun 2014 19:38:51 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <1705234.5kun8kYdZP@riemann>
In-Reply-To: <1705234.5kun8kYdZP@riemann>
Content-Type: text/plain; charset="iso-8859-1"; format="flowed"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] POSIX application running under xenomai -- what do
 wrapped functions do?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Steve M. Robbins" <steve@sumost.ca>, xenomai@xenomai.org

On 06/20/2014 05:48 PM, Steve M. Robbins wrote:
> Hi,
>
> I've looked through the FAQ and read all the "Start Here" documentation o=
n the
> wiki.  At the risk of sounding dense, I confess I am still a bit unsure w=
hat
> the wrapped POSIX functions are doing.  This is going to be a long-winded
> post, but here's the first questions:
>
> Q1: Generically, what are the wrapped functions doing?  I did look at the=
 code
> for wrapped select().  I can see it calls some xenomai function and falls=
 back
> to the regular select(), but well, let's just say I'm no wiser...

Wrapping is only aimed at keeping the regular POSIX names for calling=20
POSIX-compliant Xenomai services, without resorting to a parallel naming=20
scheme for an API which is deemed portable and standardized (e.g.=20
pthread_create_whatever_nonsense() instead of pthread_create()).

When a wrapper ends up calling the regular glibc service, this means=20
that Xenomai won't process the call, so it simply hands it over to the=20
regular kernel via the glibc, hoping for the best. In the select() case,=20
this typically happens when Xenomai discovers that one or more file=20
descriptors found in the sets are not RTDM ones (ie. not belonging to=20
the Xenomai realm).

The key issue is that in such system with two kernels running=20
side-by-side, there must be two service call stacks. One stack ends up=20
calling into the real-time extension, the other into the host/Linux=20
non-rt kernel. Sometimes the Xenomai wrappers do some bridging between=20
them to make things more transparent to the user (well, that was the=20
plan), like what happens with the select() call.

>
> Q2: The POSIX skin wraps I/O like read() and write().  Is it supported to=
 mix
> wrapped and unwrapped calls?  I have inherited a code base where some I/O=
 with
> FIFOs and files uses wrapped calls but socket code uses unwrapped code.

It is supported, but this also means that your code may switch back and=20
forth between real-time and non real-time modes, we call these "primary"=20
and "secondary" modes. Passing a RTDM fd to some unwrapped call will=20
never work though, and should beget EBADF.

A thread in primary mode will be switched to secondary mode whenever it=20
issues a Linux system call. Conversely, a (Xenomai) thread in secondary=20
mode will switch back to primary mode when it calls a Xenomai service=20
which requires it. Switching mode is:

1) time consuming and causes overhead when done very frequently (e.g.=20
within some tight processing loop),

2) defeats the purpose of using a real-time extension as soon as the=20
code moves to secondary mode.

This said, invoking regular kernel services from real-time threads in=20
well-defined and delimited sections may be perfectly fine. We definitely=20
need this for carrying out initialization/cleanup chores and such.

>
> Q3: The POSIX skin wraps select() but not pselect().  The two functions a=
re
> basically identical in function if you don't use signal masking (as we do=
n't).
> So we have different behaviour if I choose pselect() over select(). Since
> Xenomai needs to wrap one, is there a chance that using the unwrapped
> alternative may confuse Xenomai?  Our code uses pselect() today.
>
>

Then your code invokes the regular pselect() service from the regular=20
kernel, since Xenomai does not wrap it. Xenomai won't be confused, the=20
operation fully happens within the "other" kernel. This also means that=20
the file descriptors must be regular ones, not obtained from the wrapped=20
(i.e. RTDM-provided) open() call though.

>
> So I'm working on a motion control project using a Delta Tau system which
> consists of a PowerPC running Linux with Xenomai 2.5.6.  Delta Tau has
> arranged things so that you can just write servo loop code in their IDE a=
nd
> the build process takes care of the details.  They also provide a way to =
write
> a "background" linux program, which we use as a communications bridge to a
> second user interface system, sending commands and data over a socket.  T=
he
> bridge program is mainly doing logging and socket I/O. We use some shared
> memory to send commands down to a real-time task (called RTI) and servo
> routine tasks (all written in C) and read back status. Additionally, we h=
ave a
> pair of FIFOs sending data streams from RTI to the bridge process.
>
> Until a few days ago, I considered the bridge program as a regular POSIX C
> program, but digging into the build system I discovered that it links wit=
h the
> xenomai posix skin libraries, with all the --wrap commands passed to the
> linker.  Furthermore the threads of this program appear in /proc/xenomai/=
sched
> (with PRI=3D1) and /proc/xenomai/stat shows that the threads are performi=
ng a
> huge number of mode switches.
>

Yuck. Then the issue about frenetic mode switching I described earlier=20
might apply. This code may have a basic issue with properly splitting=20
the real-time and non real-time activities.

> Our bridge suffers from random lockups. During one lockup, with the help =
of
> /proc/PID/status and /proc/PID/wchan, I was able to determine that the pr=
ocess
> was stuck in the system call "xnshadow_harden".  It stayed "stuck" for 30+
> hours until I rebooted the machine.

We fixed quite a few bugs (read: a truckload) since 2.5.6, including a=20
few in the mode transition paths and elsewhere. So I would not be=20
surprised that some of them still bite here. Any chance you could=20
upgrade your board to 2.6.3? API-wise, I'm confident you would have no=20
significant issue, if any at all. Besides, you would not have to change=20
your kernel release - although it's likely quite old as well I guess.

>
> If interested, I posted some more details here:
> * http://forums.deltatau.com/showthread.php?tid=3D1654
> * http://forums.deltatau.com/showthread.php?tid=3D743
>
>
> Q4: Generically, what causes a process to get stuck in xnshadow_harden()?=
  How
> would I troubleshoot further?
>

As mentioned earlier, a Xenomai bug, and these ones have been nasty to=20
chase down. xnshadow_harden() is part of the mode switch machinery.

> Q5: We do not call pthread_setschedparam() to change the scheduler or pri=
ority
> of the bridge program's threads, yet they appear as PRI=3D1 in
> /proc/xenomai/sched ... any ideas?  (Note that we do invoke an initializa=
tion
> function provided by Delta Tau which may be doing something under the cov=
ers).
>

If by threads you mean the main() threads, then there is the possibility=20
that the library constructor of libpthread_rt switches the originally=20
SCHED_FIFO,1 thread to its Xenomai equivalent, thus visible under=20
/proc/xenomai/sched. But that would mean that your program inherits=20
SCHED_FIFO,1 from its parent, not SCHED_OTHER.

> Q6: I realize I haven't given terribly many details, but generically, what
> would cause a non-real time "background" process to switch to the primary
> domain, as ours seems to do?

Calling into any Xenomai service which requires it. There are two=20
classes of services that do:

- those which might block/suspend the caller (e.g. waiting on a sema4,=20
reading/selecting RTDM-originated fildes, etc)

- those which do some kind of introspection of the calling context, or=20
would affect some properties of the current thread.

However, a thread may only switch to primary mode if it's a Xenomai=20
thread in the first place. A Xenomai thread in user-space is a regular=20
POSIX thread on stero=EFds, which received Xenomai capabilities because=20
either of these events happened:

- it was started by the wrapped pthread_create() call
- the wrapped pthread_setschedparam() call was invoked for it.

There is a subtlety to keep in mind at this point: a Xenomai thread is=20
not necessarily real-time capable. Xenomai threads created in or moved=20
to the SCHED_OTHER class are able to call Xenomai services (e.g. wait=20
for, use or signal Xenomai resources), but won't compete for the CPU=20
with Xenomai threads which belong to SCHED_FIFO/RR.

This is aimed at allowing non rt threads to synchronize with rt threads=20
using common IPCs (sema4, mutexes etc), without having to resort to=20
exchanging messages, provided both are Xenomai threads.

So, to sum up, the fact that a thread is able to call Xenomai(-only)=20
services means that it must have been given at least Xenomai=20
capabilities as mentioned (otherwise it would receive EPERM).

Unlike SCHED_FIFO/RR Xenomai threads, those special SCHED_OTHER Xenomai=20
threads will switch back to secondary mode automatically when leaving a=20
Xenomai system call if they happened to switch to primary mode for that=20
purpose (unless they hold a real-time mutex though).

>
> Q7: In addition to the inconsistent wrapping in bridge, the real-time tas=
k RTI
> does not wrap any of its calls, e.g. we use write() on the FIFO.  Is this
> going to cause trouble?
>

This is going to switch any real-time Xenomai caller to secondary/non rt=20
mode for sure.

In case this applies, if you want to exchange a stream of data between=20
the rt and non-rt world, then you may want to have a look at the=20
RTDM-based XDDP IPC,=20
http://www.xenomai.org/documentation/xenomai-2.6/html/api/group__rtipc.html=
,=20
with sample code in examples/rtdm/profiles/ipc.
This feature allows a non-rt thread reading/writing to a pseudo-device=20
from /dev/rtp* to exchange messages with a rt thread reading/writing to=20
a RTDM socket. The rt side never leaves primary mode when doing so, and=20
the non rt program does not even have to link against Xenomai libraries.

> Thanks for reading this far.  If you can provide clues for even one of my
> questions, I'd be very very grateful.
>

Hopefully I won't have increased the headache.

HTH,

--=20
Philippe.

