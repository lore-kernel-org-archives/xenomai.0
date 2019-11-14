Date: Thu, 14 Nov 2019 01:58:21 +0000
From: Jeff Webb <w1@codecraftsmen.org>
Reply-To: Jeff Webb <w1@codecraftsmen.org>
Subject: RE: Xenomai crashes when braking into the debugger
Message-ID: <oCTXNhYPNrFqmthwoeR4fQyxnXGl41aoUVYyaRhIckO4b3HyTRyNCYJzkB58WAQI6Ob0Lij2d5lmcy1rJSwTkM-GCo30htAi5C98qIi5W24=@codecraftsmen.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

Lange Norbert via Xenomai wrote:
> > From: Jan Kiszka <jan.kiszka at siemens.com>
> > On 13.11.19 16:18, Lange Norbert via Xenomai wrote:
> > > I am running into some bad issues with debugging, can't really narrow
> > > down when they happen, but usually when I run through GDB and want to
> > > "break" (pause execution), it seems to be related to *other* Xenomai
> > programs running at the same time (as said its hard to narrow down).
> >
> > We have a gdb test case. Does it trigger for you as well when you run s=
ome
> > other program in parallel?
> >
> > Also, could you provide the kernel full log? Possibly, enabling the I-p=
ipe
> > tracer with panic dump could be useful as well. But the most important =
step
> > would be to create reproducibility for a third party like me.
>
> Currently the issue is gone, and I don't have time for researching the ca=
use.
> is panic dump a kernel compilation config?

I think one of my colleagues has experienced something similar.
He said that a when one application was stopped in a breakpoint,
it caused sem_timedwait calls in another application to not time
out until execution of the other program was resumed.  I will ask
and see if he can put together a reproducible test case.  I know
the problem was repeatable at one point with the two applications
he was working with.

I have personally experienced what seems (to me) to be a similar
issue involving signal handling where a signal handling thread
received a SIGINT via sigwait (other threads had SIGINT blocked),
and tried to set a global variable that should have caused the
other threads to terminate.  The other threads had an issue where
they would not wake up from sem_timedwait calls (or even sleep
calls) after the SIGINT was received by the other thread, so they
would not terminate properly.  The same code worked fine under
Xenomai 2.6.  I tried to create a standalone example to reproduce
this today, but I could recreate the problem.  I know it was very
reproducible when I was constructing a work-around for it.

Could it be that some fault occurs that causes subsequent bad
behavior with respect to signal handling (SIGINT/debugging) that
is fixed by a reboot?

Just trying to shed some light on the problem.  I think there is
a bug here somewhere...

Thanks,

-Jeff Webb


