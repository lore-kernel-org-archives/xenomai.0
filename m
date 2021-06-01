From: =?utf-8?q?Fran=C3=A7ois_Legal?= <devel@thom.fr.eu.org>
In-Reply-To: <1202-60b53180-ed-1ab27320@266121244>
Content-Type: text/plain; charset="utf-8"
Date: Tue, 01 Jun 2021 09:47:09 +0200
MIME-Version: 1.0
Message-ID: <10a7-60b5e600-39-35a6e6c0@9974389>
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

Le Lundi, Mai 31, 2021 20:57 CEST, Fran=C3=A7ois Legal via Xenomai <xen=
omai@xenomai.org> a =C3=A9crit: 
 
> Le Lundi, Mai 31, 2021 18:14 CEST, Jan Kiszka <jan.kiszka@siemens.com=
> a =C3=A9crit: 
>  
> > On 31.05.21 18:06, Fran=C3=A7ois Legal via Xenomai wrote:
> > > Hello,
> > > 
> > > I'm having trouble hunting mode switches on an arm embedded appli=
cation.
> > > 
> > > When I look at cat /proc/xenomai/sched/stat
> > > 
> > > CPU  PID    MSW        CSW        XSC        PF    STAT       %CP=
U  NAME
> > >   0  0      0          476986     0          0     00218000   84.=
5  [ROOT/0]
> > >   1  0      0          137743     0          0     00218000   99.=
3  [ROOT/1]
> > >   1  667    0          137550     0          0     00200042    0.=
7  [rtnet-stack]
> > >   0  669    0          2          0          0     00220042    0.=
0  [rtnet-rtpc]
> > >   1  901    110        218        203        0     00264044    0.=
0  APP=5FMain
> > >   0  911    1          1216       3524       0     00240046    0.=
0  ThreadPar
> > >   0  912    3          56683      3531       0     00240046    0.=
2  ThreadMessage
> > >   0  913    309702     470522     2152301    0     00240046    8.=
9  ThreadExec
> > >   0  914    7          62         71         0     00240042    0.=
0  TheadGO
> > >   0  915    3          647        1190       0     00248046    0.=
0  ThreadDbg
> > >   0  916    1          2024       3087       0     00248046    0.=
0  ThreadCt
> > >   0  917    1          35801      320489     0     00248046    0.=
8  ThreadSupInv
> > >   0  918    1          1231       3596       0     00248046    0.=
0  ThreadMessage2
> > >   0  919    1          161554     479305     0     00248042    1.=
4  ThreadSched
> > >   0  0      0          247850     0          0     00000000    0.=
4  [IRQ18: [timer]]
> > >   1  0      0          15419      0          0     00000000    0.=
0  [IRQ18: [timer]]
> > >   0  0      0          137548     0          0     00000000    1.=
5  [IRQ31: rteth0]
> > >   1  0      0          0          0          0     00000000    0.=
0  [IRQ31: rteth0]
> > >   0  0      0          1          0          0     00000000    0.=
0  [IRQ118: rteth1-tx]
> > >   1  0      0          0          0          0     00000000    0.=
0  [IRQ118: rteth1-tx]
> > >   0  0      0          0          0          0     00000000    0.=
0  [IRQ119: rteth1-rx]
> > >   1  0      0          0          0          0     00000000    0.=
0  [IRQ119: rteth1-rx]
> > > 
> > > But when following the procedure in [1], I get 
> > > no slacker
> > > 
> > > I can however see that Thread 913 seem to switch to secondary mor=
e than once out of 2 cycles !
> > > What am I doing wrong.
> > > 
> > 
> > CONFIG=5FXENO=5FOPT=5FDEBUG=5FTRACE=5FRELAX is on?
> > 
> 
> Yes, it is.
> 
> > Did you also try the in-app instrumentation via SIGDEBUG, maybe
> > attaching gdb to the process to catch the unwanted cases?
> > 
> 
> No, not yet. It seems mode switches happen hundreds of time every sec=
onds, so I was willing to try the slackspot.
> I'll try that tomorrow and report back to the list 
> 

So trying the manual way, there seem to be something happening, but I c=
ould not tell exactly what, and I not sure how to track this.

On thread ThreadExec, I get execution halted with SIGXCPU, and a backtr=
ace indicating getpid(), then =5F=5Fpthread=5Fkill() which I'm 100% sur=
e I never call !

Moreover, when being halted at that point, all threads are not created,=
 and all of which are created seem to have done 3 or 4 MSW each, and wi=
thout triggering any break.

Moreover, in the stats capture below, the APP=5FMain (the main program =
entry), is looping on a 1s nanosleep, and it seems the MSW number incre=
ases once per second.

I'm really confused now.

Fran=C3=A7ois

> > Jan
> > 
> > > Thanks in advance
> > > 
> > > Fran=C3=A7ois
> > > 
> > > [1] : https://source.denx.de/Xenomai/xenomai/-/wikis/Finding=5FSp=
urious=5FRelaxes
> > > 
> > > 
> > 
> > -- 
> > Siemens AG, T RDA IOT
> > Corporate Competence Center Embedded Linux
> 
>


