References: <1202-60b53180-ed-1ab27320@266121244>
 <10a7-60b5e600-39-35a6e6c0@9974389>
From: Philippe Gerum <rpm@xenomai.org>
Subject: Re: Hunting mode switches
In-reply-to: <10a7-60b5e600-39-35a6e6c0@9974389>
Date: Tue, 01 Jun 2021 10:46:10 +0200
Message-ID: <871r9mht0t.fsf@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: =?utf-8?Q?Fran=C3=A7ois?= Legal <devel@thom.fr.eu.org>
Cc: xenomai@xenomai.org


Fran=C3=A7ois Legal via Xenomai <xenomai@xenomai.org> writes:

> Le Lundi, Mai 31, 2021 20:57 CEST, Fran=C3=A7ois Legal via Xenomai <xenom=
ai@xenomai.org> a =C3=A9crit:=20
>=20=20
>> Le Lundi, Mai 31, 2021 18:14 CEST, Jan Kiszka <jan.kiszka@siemens.com> a=
 =C3=A9crit:=20
>>=20=20
>> > On 31.05.21 18:06, Fran=C3=A7ois Legal via Xenomai wrote:
>> > > Hello,
>> > >=20
>> > > I'm having trouble hunting mode switches on an arm embedded applicat=
ion.
>> > >=20
>> > > When I look at cat /proc/xenomai/sched/stat
>> > >=20
>> > > CPU  PID    MSW        CSW        XSC        PF    STAT       %CPU  =
NAME
>> > >   0  0      0          476986     0          0     00218000   84.5  =
[ROOT/0]
>> > >   1  0      0          137743     0          0     00218000   99.3  =
[ROOT/1]
>> > >   1  667    0          137550     0          0     00200042    0.7  =
[rtnet-stack]
>> > >   0  669    0          2          0          0     00220042    0.0  =
[rtnet-rtpc]
>> > >   1  901    110        218        203        0     00264044    0.0  =
APP_Main
>> > >   0  911    1          1216       3524       0     00240046    0.0  =
ThreadPar
>> > >   0  912    3          56683      3531       0     00240046    0.2  =
ThreadMessage
>> > >   0  913    309702     470522     2152301    0     00240046    8.9  =
ThreadExec
>> > >   0  914    7          62         71         0     00240042    0.0  =
TheadGO
>> > >   0  915    3          647        1190       0     00248046    0.0  =
ThreadDbg
>> > >   0  916    1          2024       3087       0     00248046    0.0  =
ThreadCt
>> > >   0  917    1          35801      320489     0     00248046    0.8  =
ThreadSupInv
>> > >   0  918    1          1231       3596       0     00248046    0.0  =
ThreadMessage2
>> > >   0  919    1          161554     479305     0     00248042    1.4  =
ThreadSched
>> > >   0  0      0          247850     0          0     00000000    0.4  =
[IRQ18: [timer]]
>> > >   1  0      0          15419      0          0     00000000    0.0  =
[IRQ18: [timer]]
>> > >   0  0      0          137548     0          0     00000000    1.5  =
[IRQ31: rteth0]
>> > >   1  0      0          0          0          0     00000000    0.0  =
[IRQ31: rteth0]
>> > >   0  0      0          1          0          0     00000000    0.0  =
[IRQ118: rteth1-tx]
>> > >   1  0      0          0          0          0     00000000    0.0  =
[IRQ118: rteth1-tx]
>> > >   0  0      0          0          0          0     00000000    0.0  =
[IRQ119: rteth1-rx]
>> > >   1  0      0          0          0          0     00000000    0.0  =
[IRQ119: rteth1-rx]
>> > >=20
>> > > But when following the procedure in [1], I get=20
>> > > no slacker
>> > >=20
>> > > I can however see that Thread 913 seem to switch to secondary more t=
han once out of 2 cycles !
>> > > What am I doing wrong.
>> > >=20
>> >=20
>> > CONFIG_XENO_OPT_DEBUG_TRACE_RELAX is on?
>> >=20
>>=20
>> Yes, it is.
>>=20
>> > Did you also try the in-app instrumentation via SIGDEBUG, maybe
>> > attaching gdb to the process to catch the unwanted cases?
>> >=20
>>=20
>> No, not yet. It seems mode switches happen hundreds of time every second=
s, so I was willing to try the slackspot.
>> I'll try that tomorrow and report back to the list=20
>>=20
>
> So trying the manual way, there seem to be something happening, but I cou=
ld not tell exactly what, and I not sure how to track this.
>
> On thread ThreadExec, I get execution halted with SIGXCPU, and a backtrac=
e indicating getpid(), then __pthread_kill() which I'm 100% sure I never ca=
ll !
>
> Moreover, when being halted at that point, all threads are not created, a=
nd all of which are created seem to have done 3 or 4 MSW each, and without =
triggering any break.
>
> Moreover, in the stats capture below, the APP_Main (the main program entr=
y), is looping on a 1s nanosleep, and it seems the MSW number increases onc=
e per second.
>
> I'm really confused now.
>

You may be receiving a SIGDEBUG signal from the Cobalt core which is not
handled by cobalt_sigdebug_handler() in lib/cobalt (internal.c) and
therefore passed on to the original handler, likely SIG_DFL. So first
thing is to run the app over gdb, breakpoint into
cobalt_sigdebug_handler(), then inspect the cause code in siginfo and
the backtrace at this point (bt).

--=20
Philippe.

