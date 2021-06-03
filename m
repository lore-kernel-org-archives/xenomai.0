From: =?utf-8?q?Fran=C3=A7ois_Legal?= <devel@thom.fr.eu.org>
In-Reply-To: <10a7-60b89980-61-35a6e6c0@10011745>
Content-Type: text/plain; charset="utf-8"
Date: Thu, 03 Jun 2021 20:39:52 +0200
MIME-Version: 1.0
Message-ID: <10a0-60b92200-35-29fb8780@204320304>
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
Cc: Jan Kiszka <jan.kiszka@siemens.com>, xenomai@xenomai.org

Le Jeudi, Juin 03, 2021 10:57 CEST, Fran=C3=A7ois Legal via Xenomai <xe=
nomai@xenomai.org> a =C3=A9crit: 
 
> Le Mercredi, Juin 02, 2021 12:59 CEST, Jan Kiszka <jan.kiszka@siemens=
.com> a =C3=A9crit: 
>  
> > On 02.06.21 12:26, Fran=C3=A7ois Legal wrote:
> > > Le Mardi, Juin 01, 2021 10:31 CEST, Jan Kiszka <jan.kiszka@siemen=
s.com> a =C3=A9crit: 
> > >  
> > >> On 01.06.21 09:47, Fran=C3=A7ois Legal wrote:
> > >>> Le Lundi, Mai 31, 2021 20:57 CEST, Fran=C3=A7ois Legal via Xeno=
mai <xenomai@xenomai.org> a =C3=A9crit: 
> > >>>  
> > >>>> Le Lundi, Mai 31, 2021 18:14 CEST, Jan Kiszka <jan.kiszka@siem=
ens.com> a =C3=A9crit: 
> > >>>>  
> > >>>>> On 31.05.21 18:06, Fran=C3=A7ois Legal via Xenomai wrote:
> > >>>>>> Hello,
> > >>>>>>
> > >>>>>> I'm having trouble hunting mode switches on an arm embedded =
application.
> > >>>>>>
> > >>>>>> When I look at cat /proc/xenomai/sched/stat
> > >>>>>>
> > >>>>>> CPU  PID    MSW        CSW        XSC        PF    STAT     =
  %CPU  NAME
> > >>>>>>   0  0      0          476986     0          0     00218000 =
  84.5  [ROOT/0]
> > >>>>>>   1  0      0          137743     0          0     00218000 =
  99.3  [ROOT/1]
> > >>>>>>   1  667    0          137550     0          0     00200042 =
   0.7  [rtnet-stack]
> > >>>>>>   0  669    0          2          0          0     00220042 =
   0.0  [rtnet-rtpc]
> > >>>>>>   1  901    110        218        203        0     00264044 =
   0.0  APP=5FMain
> > >>>>>>   0  911    1          1216       3524       0     00240046 =
   0.0  ThreadPar
> > >>>>>>   0  912    3          56683      3531       0     00240046 =
   0.2  ThreadMessage
> > >>>>>>   0  913    309702     470522     2152301    0     00240046 =
   8.9  ThreadExec
> > >>>>>>   0  914    7          62         71         0     00240042 =
   0.0  TheadGO
> > >>>>>>   0  915    3          647        1190       0     00248046 =
   0.0  ThreadDbg
> > >>>>>>   0  916    1          2024       3087       0     00248046 =
   0.0  ThreadCt
> > >>>>>>   0  917    1          35801      320489     0     00248046 =
   0.8  ThreadSupInv
> > >>>>>>   0  918    1          1231       3596       0     00248046 =
   0.0  ThreadMessage2
> > >>>>>>   0  919    1          161554     479305     0     00248042 =
   1.4  ThreadSched
> > >>>>>>   0  0      0          247850     0          0     00000000 =
   0.4  [IRQ18: [timer]]
> > >>>>>>   1  0      0          15419      0          0     00000000 =
   0.0  [IRQ18: [timer]]
> > >>>>>>   0  0      0          137548     0          0     00000000 =
   1.5  [IRQ31: rteth0]
> > >>>>>>   1  0      0          0          0          0     00000000 =
   0.0  [IRQ31: rteth0]
> > >>>>>>   0  0      0          1          0          0     00000000 =
   0.0  [IRQ118: rteth1-tx]
> > >>>>>>   1  0      0          0          0          0     00000000 =
   0.0  [IRQ118: rteth1-tx]
> > >>>>>>   0  0      0          0          0          0     00000000 =
   0.0  [IRQ119: rteth1-rx]
> > >>>>>>   1  0      0          0          0          0     00000000 =
   0.0  [IRQ119: rteth1-rx]
> > >>>>>>
> > >>>>>> But when following the procedure in [1], I get 
> > >>>>>> no slacker
> > >>>>>>
> > >>>>>> I can however see that Thread 913 seem to switch to secondar=
y more than once out of 2 cycles !
> > >>>>>> What am I doing wrong.
> > >>>>>>
> > >>>>>
> > >>>>> CONFIG=5FXENO=5FOPT=5FDEBUG=5FTRACE=5FRELAX is on?
> > >>>>>
> > >>>>
> > >>>> Yes, it is.
> > >>>>
> > >>>>> Did you also try the in-app instrumentation via SIGDEBUG, may=
be> >>>>> attaching gdb to the process to catch the unwanted cases?
> > >>>>>
> > >>>>
> > >>>> No, not yet. It seems mode switches happen hundreds of time ev=
ery seconds, so I was willing to try the slackspot.
> > >>>> I'll try that tomorrow and report back to the list 
> > >>>>
> > >>>
> > >>> So trying the manual way, there seem to be something happening,=
 but I could not tell exactly what, and I not sure how to track this.
> > >>>
> > >>> On thread ThreadExec, I get execution halted with SIGXCPU, and =
a backtrace indicating getpid(), then =5F=5Fpthread=5Fkill() which I'm =
100% sure I never call !
> > >>>
> > >>> Moreover, when being halted at that point, all threads are not =
created, and all of which are created seem to have done 3 or 4 MSW each=
, and without triggering any break.
> > >>>
> > >>> Moreover, in the stats capture below, the APP=5FMain (the main =
program entry), is looping on a 1s nanosleep, and it seems the MSW numb=
er increases once per second.
> > >>>
> > >>> I'm really confused now.
> > >>>
> > >>
> > >> Are you instrumenting only the part of the thread that has all
> > >> initialization done and until it starts to de-initialize again? =
You can
> > >> control when the mode switches should be reported and when not.
> > >>
> > >> Then, if you have a backtrace and that backtrace contain a valid=

> > >> syscall, you should also find a valid point in your own applicat=
ion when
> > >> this was started (indirectly). Maybe some library call?
> > >>
> > >> Jan
> > >>
> > > 
> > > So in the end, slackspot seems to work. I did not understand, by =
reading the manual, that slackspot/CONFIG=5FXENO=5FOPT=5FDEBUG=5FTRACE=5F=
RELAX also needed that each thread call pthread=5Fsetmode=5Fnp(0, PTHRE=
AD=5FWARNSW, NULL);
> > > 
> > 
> > We are happy to take patches - also against the doc / the wiki.
> > 
> > > So now, I've got a working backtrace, however, I'm still lost ont=
o understanding what happens.
> > > 
> > > I believe I might be having some troubles with the signals, but I=
 can't seem to find an explanation.
> > > Maybe I should document more my app.
> > > 
> > > ThreadSched is pending on a timer (with sigwaitinfo). That time t=
riggers every 750=C2=B5s. When waking up, this thread will post one or =
2 semaphores, that will unlock other threads (of which ThreadExec which=
 seem to be doing MSW more than once every two activations).
> > > 
> > > I ended up modifying the app startup code because I was experienc=
ing weirdness in the startup with debugger attached (some semaphores wo=
uldn't unlock, ...). Anyhow, I ended up doing :
> > > 
> > >     sigemptyset(&sigHandling.sa=5Fmask);
> > >     sigHandling.sa=5Fsigaction =3D sigdebug=5Fhandler;
> > >     sigHandling.sa=5Fflags =3D SA=5FSIGINFO;
> > >     sigaction(SIGDEBUG, &sigHandling, NULL);
> > > 
> > >     sigemptyset(&sigset);
> > >     sigaddset (&sigset, SIGALRM);
> > >     sigaddset (&sigset, SIGDEBUG);
> > >     sigprocmask (SIG=5FBLOCK, &sigset, NULL);
> > >     pthread=5Fsigmask (SIG=5FBLOCK, &sigset, NULL);
> > > 
> > > before creating my RT threads (of which ThreadSched), then doing
> > > 
> > >         sigdelset(&sigset, SIGALRM);
> > >         sigprocmask (SIG=5FUNBLOCK, &sigset, NULL);
> > >         pthread=5Fsigmask (SIG=5FUNBLOCK, &sigset, NULL);
> > > 
> > >         signal(SIGINT, sighandler=5Fexit);
> > >         signal(SIGTERM, sighandler=5Fexit);
> > >         signal(SIGUSR1, sighandler=5Fexit);
> > > 
> > > After my RT threads are created.
> > > 
> > > If I comment out all of these, and add the pthread=5Fsetmode=5Fnp=
 some place when initialisation of ThreadExec is over, I end up with th=
e program being forcibly stopped with the indication [1]+  CPU time lim=
it exceeded
> > > 
> > > So I put all those back in place, start again, then /proc/xenomai=
/debug/relax gets populated :
> > > 1115 75731 syscall ThreadExec 
> > > 0x12720 /usr/lib/libcobalt.so.2.0.0
> > > 0x127b0 /usr/lib/libcobalt.so.2.0.0
> > > 0x2cd40 /usr/lib/libc-2.29.so
> > > .
> > > /usr/bin/CCN2019=5FDSP
> > > 1115 80299 syscall ThreadExec 
> > > 0xd58a0 /usr/lib/libc-2.29.so
> > > .
> > > 
> > > On this, slackspot gives :
> > > Thread[1115] "Module d'Execution des Blocs" started by /usr/bin/C=
CN2019=5FDSP (107769 times):
> > > Caused by: syscall
> > >    #0  0x00000000000d589f prctl() in /home/dev/crosstool/arm-cort=
exa9=5Fneon-linux-gnueabihf/.build/src/glibc-2.29/misc/../sysdeps/unix/=
syscall-template.S:78
> > > 
> > > Thread[1115] "Module d'Execution des Blocs" started by /usr/bin/C=
CN2019=5FDSP (101892 times):
> > > Caused by: syscall
> > >    #0  0x000000000001271f ??? in [/usr/lib/libcobalt.so.2.0.0]
> > >    #1  0x00000000000127af ??? in [/usr/lib/libcobalt.so.2.0.0]
> > >    #2  0x000000000002cd3f =5F=5Fdefault=5Fsa=5Frestorer() in /hom=
e/dev/crosstool/arm-cortexa9=5Fneon-linux-gnueabihf/.build/src/glibc-2.=
29/signal/../sysdeps/unix/sysv/linux/arm/sigrestorer.S:77
> > > 
> > > So know, I really don't know where to go from here !
> > > 
> > 
> > Could you recompile with debugging symbols for libcobalt and your
> > application and check where exactly the Linux syscall is issued and=
 what
> > library call from your application relates to it? gdb may provide t=
his
> > better.
> > 
> 
> Ok. I think I found it. I had put in some debug code in my semaphore =
wrappers to check if the timeout given was not before the current time,=
 and thus I used pthread=5Fgetname to display a trace with the name of =
the thread. This was the main problem.
> 

After checking again, that wasn't it. I can still see lots (about the s=
ame as before) MSW on that same thread. However, the sigdebug never get=
s called now !
By checking the other, I could see that socket() triggers a MSW which i=
s surprising.


> > Jan
> > 
> > -- 
> > Siemens AG, T RDA IOT
> > Corporate Competence Center Embedded Linux
> 
>


