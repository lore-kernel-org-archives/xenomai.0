Date: Thu, 14 Nov 2019 13:24:02 +0000
From: Jeff Webb <w1@codecraftsmen.org>
Reply-To: Jeff Webb <w1@codecraftsmen.org>
Subject: Re: Xenomai crashes when braking into the debugger
Message-ID: <n_Q0J0JEylsrQBHk5gHsDZvBKayPp_hOXGn-QOwhi-eKuNJ99T7T9FbLOO4K-SHF6-vY3TA1gro2tel3O-zTAa606ZpeGfJyGnExVS6gifo=@codecraftsmen.org>
In-Reply-To: <5abfd650-c763-122e-7884-da5bc93a8a9f@siemens.com>
References: <oCTXNhYPNrFqmthwoeR4fQyxnXGl41aoUVYyaRhIckO4b3HyTRyNCYJzkB58WAQI6Ob0Lij2d5lmcy1rJSwTkM-GCo30htAi5C98qIi5W24=@codecraftsmen.org>
 <5abfd650-c763-122e-7884-da5bc93a8a9f@siemens.com>
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
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90 Original Me=
ssage =E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90
On Thursday, November 14, 2019 1:43 AM, Jan Kiszka <jan.kiszka@siemens.com>=
 wrote:
> On 14.11.19 02:58, Jeff Webb via Xenomai wrote:
>
> > Lange Norbert via Xenomai wrote:
> >
> > > > From: Jan Kiszka <jan.kiszka at siemens.com>
> > > > On 13.11.19 16:18, Lange Norbert via Xenomai wrote:
> > > >
> > > > > I am running into some bad issues with debugging, can't really na=
rrow
> > > > > down when they happen, but usually when I run through GDB and wan=
t to
> > > > > "break" (pause execution), it seems to be related to other Xenoma=
i
> > > > > programs running at the same time (as said its hard to narrow dow=
n).
> > > >
> > > > We have a gdb test case. Does it trigger for you as well when you r=
un some
> > > > other program in parallel?
> > > > Also, could you provide the kernel full log? Possibly, enabling the=
 I-pipe
> > > > tracer with panic dump could be useful as well. But the most import=
ant step
> > > > would be to create reproducibility for a third party like me.
> > >
> > > Currently the issue is gone, and I don't have time for researching th=
e cause.
> > > is panic dump a kernel compilation config?
> >
> > I think one of my colleagues has experienced something similar.
> > He said that a when one application was stopped in a breakpoint,
> > it caused sem_timedwait calls in another application to not time
> > out until execution of the other program was resumed. I will ask
> > and see if he can put together a reproducible test case. I know
> > the problem was repeatable at one point with the two applications
> > he was working with.
>
> This particular behavior is solved in 3.1 by
> https://gitlab.denx.de/Xenomai/xenomai/commit/9ebc2b6ea49406026e9e69d8fa4=
90b3f8d8f0a24.

That is great.  Thanks for pointing this out.

> > I have personally experienced what seems (to me) to be a similar
> > issue involving signal handling where a signal handling thread
> > received a SIGINT via sigwait (other threads had SIGINT blocked),
> > and tried to set a global variable that should have caused the
> > other threads to terminate. The other threads had an issue where
> > they would not wake up from sem_timedwait calls (or even sleep
> > calls) after the SIGINT was received by the other thread, so they
> > would not terminate properly. The same code worked fine under
> > Xenomai 2.6. I tried to create a standalone example to reproduce
> > this today, but I could recreate the problem. I know it was very
> > reproducible when I was constructing a work-around for it.
> > Could it be that some fault occurs that causes subsequent bad
> > behavior with respect to signal handling (SIGINT/debugging) that
> > is fixed by a reboot?
> > Just trying to shed some light on the problem. I think there is
> > a bug here somewhere...
>
> Stand-alone test cases or test sequences are always welcome! Just please
> also make sure 3.1-rc as debugging code changed there quite a bit.

Also good to know.  Thanks again!

-Jeff

