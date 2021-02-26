From: =?utf-8?q?Fran=C3=A7ois_Legal?= <francois.legal@thom.fr.eu.org>
In-Reply-To: <4e03-60391f00-29-10b42340@55509927>
Content-Type: text/plain; charset="utf-8"
Date: Fri, 26 Feb 2021 17:36:47 +0100
MIME-Version: 1.0
Message-ID: <35a5-60392380-18f-48dc0d80@57279928>
Subject: =?utf-8?q?Re=3A?= Weird =?utf-8?q?semaphore=2Ftimeout?= behaviour
 with gdbserver
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: jan.kiszka@siemens.com
Cc: xenomai@xenomai.org

Le Vendredi, F=C3=A9vrier 26, 2021 17:17 CET, Fran=C3=A7ois Legal via X=
enomai <xenomai@xenomai.org> a =C3=A9crit: 
 
> Le Vendredi, F=C3=A9vrier 26, 2021 09:08 CET, Fran=C3=A7ois Legal via=
 Xenomai <xenomai@xenomai.org> a =C3=A9crit: 
>  
> > Le Jeudi, Janvier 21, 2021 22:42 CET, Jan Kiszka <jan.kiszka@siemen=
s.com> a =C3=A9crit: 
> >  
> > > On 19.01.21 18:41, Fran=C3=A7ois Legal via Xenomai wrote:
> > > > Le Vendredi, Janvier 08, 2021 19:35 CET, Fran=C3=A7ois Legal vi=
a Xenomai <xenomai@xenomai.org> a =C3=A9crit: 
> > > >  
> > > >> Hello,
> > > >>
> > > >> Working on ARMv7 with linux 4.4 and xenomai 3.1, I get a stran=
ge behaviour when using GDB.
> > > >> There seem to be troubles with threads pending on semaphores, =
which do not wake up when sem is posted nor when the timedwait is over.=

> > > >> It does not seem to make a problem with all the semaphores on =
the software, but at program startup, the behaviour is pretty constant.=

> > > >>
> > > >> If I start the same program from shell, thread activation work=
s flawlessly.
> > > >>
> > > >> ANybody can give a hint on this ?
> > > >>
> > > >> Thanks.
> > > >>
> > > >> Fran=C3=A7ois
> > > >>
> > > >>
> > > >  
> > > > I've got another case with pulse semaphores with timeout, that =
outline the same behaviour without gdbserver.
> > > > I've got 2 threads and 2 pulse semaphores. Thread1 (priority 60=
) successively pends (with 30s timeout) on SEM1 then posts SEM2, while =
thread2 (priority 52) posts SEM1 then pends (forever) on SEM2. Both sem=
aphores are initialized at 0.
> > > > I can see from debug log that Thread1 pends on SEM1, then threa=
d2 posts SEM1 and pends SEM2, then thread1 posts SEM2, then thread2 pos=
ts SEM1 then pends SEM2, then thread1 pends SEM1, then nothing happens =
anymore. I thought thread1 should be unblocked (either by thread2 posti=
ng SEM1, or by the 30s timeout) but that never happens.
> > > > 
> > > > What am I getting wrong here ?
> > > > 
> > > 
> > > These scenarios are hairy without test cases. Can you derive some=
thing
> > > simple, portable from your problems? There is testsuite/smokey/gd=
b/gdb.c
> > > for full automated tests, but already something we can compile an=
d run
> > > locally here, gdb manually operated, would be fine. It would also=
 allow
> > > to cross-check on x86 and arm64 to see if this is arch-specific.
> > > 
> > > Jan
> > > 
> > > -- 
> > > Siemens AG, T RDA IOT
> > > Corporate Competence Center Embedded Linux
> >  
> >  
> > Sorry to reply so late on this, but I've been busy on some other st=
uff.I tried to write a simple piece of code that reproduces the problem=
, but with no luck. In the simple case, the sems work as intended (and =
thus do not need to honor the timeout).
> > I'm not sure how I can find the answer on this. Also is there any w=
ay to check the state of shored objects like semaphores, mutexes, ...
> > I read the registry should provide this, but I not able to get more=
 entries than what already present in /proc/xenomai/ (heaps, threads an=
d version)
> > 
> > Fran=C3=A7ois
> > 
> > 
>  
> I believe I found out why my semaphores behave oddly when under GDB. =
I checked /proc/xenomai/sched/stats, and saw that almost all of my thre=
ads have the 0x400000 bit set (#define XNDBGSTOP 0x00400000 /**< Stoppe=
d for synchronous debugging */)
> 
> So I believe that's perfectly normal for the semaphores not to timeou=
t, because the threads are stopped.
> 
> What I wonder now, is why this bit got set for all but one thread in =
the project.
> 
> Thanks
> 
> Fran=C3=A7ois
> 
> 
 
And if I check the same with the simple app I created, I don't see the =
XNDBGSTOP bit being automagically set when running with GDB

Fran=C3=A7ois


