From: =?utf-8?q?Fran=C3=A7ois_Legal?= <devel@thom.fr.eu.org>
In-Reply-To: <b7612ecb-332a-c16f-163d-9a24d70c5337@siemens.com>
Content-Type: text/plain; charset="utf-8"
Date: Wed, 02 Jun 2021 17:06:46 +0200
MIME-Version: 1.0
Message-ID: <1202-60b79e80-111-1ab27320@266157247>
Subject: =?utf-8?q?Re=3A?= Hunting mode switches
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
Cc: xenomai@xenomai.org

Le Mercredi, Juin 02, 2021 12:59 CEST, Jan Kiszka <jan.kiszka@siemens.c=
om> a =C3=A9crit: 
 
> On 02.06.21 12:26, Fran=C3=A7ois Legal wrote:
> > Le Mardi, Juin 01, 2021 10:31 CEST, Jan Kiszka <jan.kiszka@siemens.=
com> a =C3=A9crit: 
> >  
> >> On 01.06.21 09:47, Fran=C3=A7ois Legal wrote:
> >>> Le Lundi, Mai 31, 2021 20:57 CEST, Fran=C3=A7ois Legal via Xenoma=
i <xenomai@xenomai.org> a =C3=A9crit: 
> >>>  
> >>>> Le Lundi, Mai 31, 2021 18:14 CEST, Jan Kiszka <jan.kiszka@siemen=
s.com> a =C3=A9crit: 
> >>>>  
> >>>>> On 31.05.21 18:06, Fran=C3=A7ois Legal via Xenomai wrote:
> >>>>>> Hello,
> >>>>>>
> >>>>>> I'm having trouble hunting mode switches on an arm embedded ap=
plication.
> >>>>>>
> >>>>>> When I look at cat /proc/xenomai/sched/stat
> >>>>>>
> >>>>>> CPU  PID    MSW        CSW        XSC        PF    STAT       =
%CPU  NAME
> >>>>>>   0  0      0          476986     0          0     00218000   =
84.5  [ROOT/0]
> >>>>>>   1  0      0          137743     0          0     00218000   =
99.3  [ROOT/1]
> >>>>>>   1  667    0          137550     0          0     00200042   =
 0.7  [rtnet-stack]
> >>>>>>   0  669    0          2          0          0     00220042   =
 0.0  [rtnet-rtpc]
> >>>>>>   1  901    110        218        203        0     00264044   =
 0.0  APP=5FMain
> >>>>>>   0  911    1          1216       3524       0     00240046   =
 0.0  ThreadPar
> >>>>>>   0  912    3          56683      3531       0     00240046   =
 0.2  ThreadMessage
> >>>>>>   0  913    309702     470522     2152301    0     00240046   =
 8.9  ThreadExec
> >>>>>>   0  914    7          62         71         0     00240042   =
 0.0  TheadGO
> >>>>>>   0  915    3          647        1190       0     00248046   =
 0.0  ThreadDbg
> >>>>>>   0  916    1          2024       3087       0     00248046   =
 0.0  ThreadCt
> >>>>>>   0  917    1          35801      320489     0     00248046   =
 0.8  ThreadSupInv
> >>>>>>   0  918    1          1231       3596       0     00248046   =
 0.0  ThreadMessage2
> >>>>>>   0  919    1          161554     479305     0     00248042   =
 1.4  ThreadSched
> >>>>>>   0  0      0          247850     0          0     00000000   =
 0.4  [IRQ18: [timer]]
> >>>>>>   1  0      0          15419      0          0     00000000   =
 0.0  [IRQ18: [timer]]
> >>>>>>   0  0      0          137548     0          0     00000000   =
 1.5  [IRQ31: rteth0]
> >>>>>>   1  0      0          0          0          0     00000000   =
 0.0  [IRQ31: rteth0]
> >>>>>>   0  0      0          1          0          0     00000000   =
 0.0  [IRQ118: rteth1-tx]
> >>>>>>   1  0      0          0          0          0     00000000   =
 0.0  [IRQ118: rteth1-tx]
> >>>>>>   0  0      0          0          0          0     00000000   =
 0.0  [IRQ119: rteth1-rx]
> >>>>>>   1  0      0          0          0          0     00000000   =
 0.0  [IRQ119: rteth1-rx]
> >>>>>>
> >>>>>> But when following the procedure in [1], I get 
> >>>>>> no slacker
> >>>>>>
> >>>>>> I can however see that Thread 913 seem to switch to secondary =
more than once out of 2 cycles !
> >>>>>> What am I doing wrong.
> >>>>>>
> >>>>>
> >>>>> CONFIG=5FXENO=5FOPT=5FDEBUG=5FTRACE=5FRELAX is on?
> >>>>>
> >>>>
> >>>> Yes, it is.
> >>>>
> >>>>> Did you also try the in-app instrumentation via SIGDEBUG, maybe=

> >>>>> attaching gdb to the process to catch the unwanted cases?
> >>>>>
> >>>>
> >>>> No, not yet. It seems mode switches happen hundreds of time ever=
y seconds, so I was willing to try the slackspot.
> >>>> I'll try that tomorrow and report back to the list 
> >>>>
> >>>
> >>> So trying the manual way, there seem to be something happening, b=
ut I could not tell exactly what, and I not sure how to track this.
> >>>
> >>> On thread ThreadExec, I get execution halted with SIGXCPU, and a =
backtrace indicating getpid(), then =5F=5Fpthread=5Fkill() which I'm 10=
0% sure I never call !
> >>>
> >>> Moreover, when being halted at that point, all threads are not cr=
eated, and all of which are created seem to have done 3 or 4 MSW each, =
and without triggering any break.
> >>>
> >>> Moreover, in the stats capture below, the APP=5FMain (the main pr=
ogram entry), is looping on a 1s nanosleep, and it seems the MSW number=
 increases once per second.
> >>>
> >>> I'm really confused now.
> >>>
> >>
> >> Are you instrumenting only the part of the thread that has all
> >> initialization done and until it starts to de-initialize again? Yo=
u can
> >> control when the mode switches should be reported and when not.
> >>
> >> Then, if you have a backtrace and that backtrace contain a valid
> >> syscall, you should also find a valid point in your own applicatio=
n when
> >> this was started (indirectly). Maybe some library call?
> >>
> >> Jan
> >>
> > 
> > So in the end, slackspot seems to work. I did not understand, by re=
ading the manual, that slackspot/CONFIG=5FXENO=5FOPT=5FDEBUG=5FTRACE=5F=
RELAX also needed that each thread call pthread=5Fsetmode=5Fnp(0, PTHRE=
AD=5FWARNSW, NULL);
> > 
> 
> We are happy to take patches - also against the doc / the wiki.
> 
> > So now, I've got a working backtrace, however, I'm still lost onto =
understanding what happens.
> > 
> > I believe I might be having some troubles with the signals, but I c=
an't seem to find an explanation.
> > Maybe I should document more my app.
> > 
> > ThreadSched is pending on a timer (with sigwaitinfo). That time tri=
ggers every 750=C2=B5s. When waking up, this thread will post one or 2 =
semaphores, that will unlock other threads (of which ThreadExec which s=
eem to be doing MSW more than once every two activations).
> > 
> > I ended up modifying the app startup code because I was experiencin=
g weirdness in the startup with debugger attached (some semaphores woul=
dn't unlock, ...). Anyhow, I ended up doing :
> > 
> >     sigemptyset(&sigHandling.sa=5Fmask);
> >     sigHandling.sa=5Fsigaction =3D sigdebug=5Fhandler;
> >     sigHandling.sa=5Fflags =3D SA=5FSIGINFO;
> >     sigaction(SIGDEBUG, &sigHandling, NULL);
> > 
> >     sigemptyset(&sigset);
> >     sigaddset (&sigset, SIGALRM);
> >     sigaddset (&sigset, SIGDEBUG);
> >     sigprocmask (SIG=5FBLOCK, &sigset, NULL);
> >     pthread=5Fsigmask (SIG=5FBLOCK, &sigset, NULL);
> > 
> > before creating my RT threads (of which ThreadSched), then doing
> > 
> >         sigdelset(&sigset, SIGALRM);
> >         sigprocmask (SIG=5FUNBLOCK, &sigset, NULL);
> >         pthread=5Fsigmask (SIG=5FUNBLOCK, &sigset, NULL);
> > 
> >         signal(SIGINT, sighandler=5Fexit);
> >         signal(SIGTERM, sighandler=5Fexit);
> >         signal(SIGUSR1, sighandler=5Fexit);
> > 
> > After my RT threads are created.
> > 
> > If I comment out all of these, and add the pthread=5Fsetmode=5Fnp s=
ome place when initialisation of ThreadExec is over, I end up with the =
program being forcibly stopped with the indication [1]+  CPU time limit=
 exceeded
> > 
> > So I put all those back in place, start again, then /proc/xenomai/d=
ebug/relax gets populated :
> > 1115 75731 syscall ThreadExec 
> > 0x12720 /usr/lib/libcobalt.so.2.0.0
> > 0x127b0 /usr/lib/libcobalt.so.2.0.0
> > 0x2cd40 /usr/lib/libc-2.29.so
> > .
> > /usr/bin/CCN2019=5FDSP
> > 1115 80299 syscall ThreadExec 
> > 0xd58a0 /usr/lib/libc-2.29.so
> > .
> > 
> > On this, slackspot gives :
> > Thread[1115] "Module d'Execution des Blocs" started by /usr/bin/CCN=
2019=5FDSP (107769 times):
> > Caused by: syscall
> >    #0  0x00000000000d589f prctl() in /home/dev/crosstool/arm-cortex=
a9=5Fneon-linux-gnueabihf/.build/src/glibc-2.29/misc/../sysdeps/unix/sy=
scall-template.S:78
> > 
> > Thread[1115] "Module d'Execution des Blocs" started by /usr/bin/CCN=
2019=5FDSP (101892 times):
> > Caused by: syscall
> >    #0  0x000000000001271f ??? in [/usr/lib/libcobalt.so.2.0.0]
> >    #1  0x00000000000127af ??? in [/usr/lib/libcobalt.so.2.0.0]
> >    #2  0x000000000002cd3f =5F=5Fdefault=5Fsa=5Frestorer() in /home/=
dev/crosstool/arm-cortexa9=5Fneon-linux-gnueabihf/.build/src/glibc-2.29=
/signal/../sysdeps/unix/sysv/linux/arm/sigrestorer.S:77
> > 
> > So know, I really don't know where to go from here !
> > 
> 
> Could you recompile with debugging symbols for libcobalt and your
> application and check where exactly the Linux syscall is issued and w=
hat
> library call from your application relates to it? gdb may provide thi=
s
> better.
> 

I'm trying hard to do that, but with the debug enabled libcobalt, my ap=
p stays blocked on a semaphore (I posted a topic on this on the list a =
while ago, but had no time to diagnose this). What is strange, is that =
when I start the app and reach the point where it gets locked, I get th=
e following :

 cat /proc/xenomai/sched/threads
CPU  PID    CLASS  TYPE      PRI   TIMEOUT       STAT       NAME
  0  0      idle   core       -1   -             R          [ROOT/0]
  1  0      idle   core       -1   -             R          [ROOT/1]
  0  765    rt     core       98   -             W          [rtnet-stac=
k]
  1  767    rt     core        0   -             W          [rtnet-rtpc=
]
  0  1069   rt     cobalt      0   -             Xts        APP=5FMain
  0  1071   rt     cobalt     60   -             s          ThreadInit
  0  1072   rt     cobalt     62   -             W          ThreadEcat
  0  1073   rt     cobalt     52   -             s          ThreadPar
  0  1074   rt     cobalt     60   -             s          ThreadMessa=
ge
  0  1075   rt     cobalt     55   -             s          ThreadExec
  0  1076   rt     cobalt     55   -             Ws         ThreadGO
  0  1077   rt     cobalt     51   -             s          ThreadDbg
  0  1078   rt     cobalt     64   -             ts         ThreadCT
  0  1079   rt     cobalt     51   -             s          ThreadSupIn=
v
  0  1080   rt     cobalt     52   -             s          ThreadMessa=
ge2
  0  1081   rt     cobalt     70   -             s          ThreadSched=


Then I halt the program in the debugger, then hit continue, then I get =
:

cat /proc/xenomai/sched/threads
CPU  PID    CLASS  TYPE      PRI   TIMEOUT       STAT       NAME
  0  0      idle   core       -1   -             R          [ROOT/0]
  1  0      idle   core       -1   -             R          [ROOT/1]
  0  765    rt     core       98   -             W          [rtnet-stac=
k]
  1  767    rt     core        0   -             W          [rtnet-rtpc=
]
  0  1069   rt     cobalt      0   -             Xt         APP=5FMain
  0  1071   rt     cobalt     60   1266874550s283m  w          ThreadIn=
it
  0  1072   rt     cobalt     62   -             W          ThreadEcat
  0  1073   rt     cobalt     52   41ms937us     w          ThreadPar
  0  1074   rt     cobalt     60   41ms917us     w          ThreadMessa=
ge
  0  1075   rt     cobalt     55   9ms653us      w          ThreadExec
  0  1076   rt     cobalt     55   -             W          ThreadGO
  0  1077   rt     cobalt     51   41ms949us     w          ThreadDbg
  0  1078   rt     cobalt     64   1ms387us      Dt         ThreadCT
  0  1079   rt     cobalt     51   41ms963us     w          ThreadSupIn=
v
  0  1080   rt     cobalt     52   41ms955us     w          ThreadMessa=
ge2
  0  1081   rt     cobalt     70   -             W          ThreadSched=


There shall be a ping/pong with 2 semaphores between ThreadInit and Thr=
eadEcat. Thread init is supposed to pend with a 30s timeout on the sema=
phore.

I don't know what to do from here.

I tried to make a simple program to diagnose that too, but wasn't able =
to reproduce the problem.

Fran=C3=A7ois

> Jan
> 
> -- 
> Siemens AG, T RDA IOT
> Corporate Competence Center Embedded Linux


