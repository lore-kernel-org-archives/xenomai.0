References: <1394996997.10478.YahooMailNeo@web171605.mail.ir2.yahoo.com>
 <5326AE7E.3050201@xenomai.org>
 <1395076680.34261.YahooMailNeo@web171604.mail.ir2.yahoo.com>
Message-ID: <1395582539.27462.YahooMailNeo@web171602.mail.ir2.yahoo.com>
Date: Sun, 23 Mar 2014 13:48:59 +0000 (GMT)
From: Matthias Schneider <ma30002000@yahoo.de>
In-Reply-To: <1395076680.34261.YahooMailNeo@web171604.mail.ir2.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] Issue suspending threads on mercury
Reply-To: Matthias Schneider <ma30002000@yahoo.de>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

> On Monday, March 17, 2014 6:19 PM, Matthias Schneider <ma30002000@yahoo.d=
e> wrote:

> >>  On Monday, March 17, 2014 9:12 AM, Philippe Gerum <rpm@xenomai.org> =

> wrote:
> =

>>  > On 03/16/2014 08:09 PM, Matthias Schneider wrote:
>>> =A0 Hi all,
>>> =

>>> =A0 I am experiencing a problem with xenomai-forge (recent "next" check=
out) on
>>> =A0 Mercury (on top of a 3.12.9+CONFIG_PREEMPT_RT on x86) when suspendi=
ng
>>> =A0 tasks/threads.
>>> =

>>> =A0 As far=A0 as I understand, the mercury implementation sends a signa=
l to the thread
>>> =A0 to be suspended, with that threads signal handler setting the=A0sus=
pended state,
>>> =A0 i.e. the setting of __THREAD_S_SUSPENDED happens in notifier_callba=
ck, which
>>> =A0 seems to be different from the cobalt implementation.
>>> =

>>> =A0 The problem I am experiencing is that sometimes the signal handler =
never seems
>>> =A0 to get called in a thread that should be suspended,=A0 i.e. that th=
read suspension
>>> =A0 sometimes simply does not work.
>>> =A0 The following example code (for the vxworks skin) reproduces the is=
sue (it gets
>>> =A0 stuck in the loop waiting for the WIND_SUSPEND flag):
>>> =

>>> =A0 http://www.pastebin.ca/2667435
>> =

>>  Could you check this URL? I can't seem to find anything pasted there.
>> =

>> =

>>> =

>>> =A0 Any hints on how I can continue investigating this issue?
>>> =

>> =

>>  Running the test suite in lib/vxworks/testsuite may give us more =

>>  information. sem-1, sem-2, task-2 and wd-1 are all using the =

>>  suspend/resume mechanism.
>> =

>>  -- =

>>  Philippe.
>> =

> =

> Hi all,
> =

> please find another copy of the example code at:
> =

> http://pastebin.com/rNGDfR2b
> =

> =

> The scenario described by Kim when using gdb may coincide with ocurrence=
=A0
> of the issue all the time when using gdb on my system. However,=A0
> also without gdb it happens from time to time (several 10000s cycles=A0
> of the code above).
> =

> The enclosed test code from vxworks/testsuite seems to work when executin=
g it =

> once,=A0
> but note that the issue only happens from time to time (thats why I added=
 the =

> sample=A0
> code).
>
> Matthias


Investigating the issue further, it seems that the signal that should trigg=
er=A0
the "suspend" notifier call seems to be routed to the main thread instead o=
f the=A0
thread to be suspended. The main thread then executes notifier_sighandler()=
,=A0
finds the signaled fd, sets "matched" to 1, but does not enter the=A0
read/callback loop since it is not the owner (which is correct since the ow=
ner=A0
is the thread that was supposed to be suspended). =A0After finishing the=A0
pvlist_for_each_entry loop, notifier_sighandler() then runs through the=A0
following code

/*
=A0 * We may have received a valid notification on the wrong
=A0 * thread: bail out silently, assuming the recipient will find
=A0 * out eventually.
=A0 */
if (matched)
=A0 =A0 =A0 =A0 return;

actually doing nothing. The thread to be suspended however never gets its s=
ignal=A0
handler executed.

Investigating the registration of the signal handler in notifier_init(), it=
=A0
seems the following code is responsible:
=A0 =A0 =A0 =A0=A0
fd =3D nf->psfd[0];
fcntl(fd, F_SETSIG, NOTIFYSIG);
fcntl(fd, F_SETOWN, nf->owner);
fcntl(fd, F_SETFL, fcntl(fd, F_GETFL) | O_ASYNC | O_NONBLOCK);
fcntl(fd, F_SETFD, fcntl(fd, F_GETFD) | FD_CLOEXEC);

with nf->owner being the thread id of the owning thread, i.e. the one to be=
=A0
suspended in my case.

Studying the manpage of fcntl() reveals the following information:


"Set the process ID or process group ID that will receive SIGIO
and SIGURG signals for events on file descriptor fd to the ID
given in arg. =A0A process ID is specified as a positive value;
a process group ID is specified as a negative value. =A0Most
commonly, the calling process specifies itself as the owner
(that is, arg is specified as getpid(2)).

[...]

The following was true in 2.6.x kernels up to and including
kernel 2.6.11:

=A0 =A0 =A0 If a nonzero value is given to F_SETSIG in a
=A0 =A0 =A0 multithreaded process running with a threading library
=A0 =A0 =A0 that supports thread groups (e.g., NPTL), then a
=A0 =A0 =A0 positive value given to F_SETOWN has a different
=A0 =A0 =A0 meaning: instead of being a process ID identifying a
=A0 =A0 =A0 whole process, it is a thread ID identifying a specific
=A0 =A0 =A0 thread within a process. =A0Consequently, it may be
=A0 =A0 =A0 necessary to pass F_SETOWN the result of gettid(2)
=A0 =A0 =A0 instead of getpid(2) to get sensible results when
=A0 =A0 =A0 F_SETSIG is used. =A0(In current Linux threading
=A0 =A0 =A0 implementations, a main thread's thread ID is the same
=A0 =A0 =A0 as its process ID. =A0This means that a single-threaded
=A0 =A0 =A0 program can equally use gettid(2) or getpid(2) in this
=A0 =A0 =A0 scenario.) =A0Note, however, that the statements in this
=A0 =A0 =A0 paragraph do not apply to the SIGURG signal generated
=A0 =A0 =A0 for out-of-band data on a socket: this signal is always
=A0 =A0 =A0 sent to either a process or a process group, depending
=A0 =A0 =A0 on the value given to F_SETOWN.

The above behavior was accidentally dropped in Linux 2.6.12,
and won't be restored. =A0From Linux 2.6.32 onward, use
F_SETOWN_EX to target SIGIO and SIGURG signals at a particular
thread."


If I understand correctly, the desired behavior, i.e. sending a signal to a=
=A0
specific thread, would just be achieved up to Linux 2.6.12. Note that I als=
o=A0
stumbled over some manpages that did not include the paragraph above...

Using F_SETOWN_EX like in the attached patch solves my problem (at least th=
e=A0
described one) with the misdirected signals. However I still do not underst=
and=A0
why the signal seems to have been delivered sometimes to the correct thread=
 and=A0
sometimes not, but the answer can probably be found studying the kernel sou=
rces..

Regards,

Matthias
-------------- next part --------------
A non-text attachment was scrubbed...
Name: notif_owner.patch
Type: text/x-patch
Size: 542 bytes
Desc: not available
URL: <http://www.xenomai.org/pipermail/xenomai/attachments/20140323/e36827d=
6/attachment.bin>
