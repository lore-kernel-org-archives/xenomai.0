References: <1396262085.387.YahooMailNeo@web171601.mail.ir2.yahoo.com>
 <53395104.6050109@xenomai.org> <53396B31.1090903@xenomai.org>
 <5339AACA.4090807@xenomai.org>
 <1396782702.1096.YahooMailNeo@web171605.mail.ir2.yahoo.com>
 <53416D09.7060805@xenomai.org>
 <1396889360.63594.YahooMailNeo@web171605.mail.ir2.yahoo.com>
 <5348033D.70806@xenomai.org> <53480514.9010801@xenomai.org>
Message-ID: <1397234658.97268.YahooMailNeo@web171602.mail.ir2.yahoo.com>
Date: Fri, 11 Apr 2014 17:44:18 +0100 (BST)
From: Matthias Schneider <ma30002000@yahoo.de>
In-Reply-To: <53480514.9010801@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] EINTR in notifier.c (mercury)
Reply-To: Matthias Schneider <ma30002000@yahoo.de>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>, "xenomai@xenomai.org" <xenomai@xenomai.org>

=0A=0A=0A=0A----- Original Message -----=0A> From: Philippe Gerum <rpm@xeno=
mai.org>=0A> To: Matthias Schneider <ma30002000@yahoo.de>; "xenomai@xenomai=
.org" <xenomai@xenomai.org>=0A> Cc: =0A> Sent: Friday, April 11, 2014 5:07 =
PM=0A> Subject: Re: [Xenomai] EINTR in notifier.c (mercury)=0A> =0A> On 04/=
11/2014 04:59 PM, Philippe Gerum wrote:=0A>>  On 04/07/2014 06:49 PM, Matth=
ias Schneider wrote:=0A>>>  ----- Original Message -----=0A>>> =0A>>>>  Fro=
m: Philippe Gerum <rpm@xenomai.org>=0A>>>>  To: Matthias Schneider <ma30002=
000@yahoo.de>; =0A> "xenomai@xenomai.org"=0A>>>>  <xenomai@xenomai.org>=0A>=
>>>  Cc:=0A>>>>  Sent: Sunday, April 6, 2014 5:04 PM=0A>>>>  Subject: Re: [=
Xenomai] EINTR in notifier.c (mercury)=0A>>>> =0A>>>>  On 04/06/2014 01:11 =
PM, Matthias Schneider wrote:=0A>>>>>> =A0  On Monday, March 31, 2014 7:50 =
PM, Gilles Chanteperdrix=0A>>>>  <gilles.chanteperdrix@xenomai.org> wrote:=
=0A>>>>> =0A>>>>>>> =A0  On 03/31/2014 03:18 PM, Philippe Gerum wrote:=0A>>=
>>>>> =A0 =A0  On 03/31/2014 01:27 PM, Gilles Chanteperdrix wrote:=0A>>>>>>=
>> =A0 =A0  On 03/31/2014 12:34 PM, Matthias Schneider =0A> wrote:=0A>>>>>>=
>>> =A0 =A0  Hi all,=0A>>>>>>>>> =0A>>>>>>>>> =0A>>>>>>>>> =A0 =A0  still w=
orking on thread suspension in =0A> mercury, I noticed=0A>>>>  that some=0A=
>>>>>>>>> =A0 =A0  threadobj_suspend() and threadobj_resume() =0A> calls se=
emed=0A>>>>  not to have the desired=0A>>>>>>>>> =A0 =A0  effect. Analyzing=
 the issue, I found out =0A> that sometimes=0A>>>>  the read operations on=
=0A>>>>>>>>> =A0 =A0  the pipe in notifier_wait() seem to return =0A> with =
EINTR,=0A>>>>  especially in=0A>>>>>>>>> =A0 =A0  heavily loaded systems. R=
estarting the read =0A> system call=0A>>>>  in that case made=0A>>>>>>>>> =
=A0 =A0  thread suspension a lot more reliable in my =0A> case.=0A>>>>>>>>>=
 =0A>>>>>>>>> =A0 =A0  I have attached a patch adding loops to =0A> deal wi=
th the=0A>>>>  EINTR situation in all=0A>>>>>>>> =0A>>>>>>>> =A0 =A0  You c=
an probably avoid testing for EINTR if all =0A> signal=0A>>>>  handlers are=
=0A>>>>>>>> =A0 =A0  registered with the SA_RESTART flag.=0A>>>>>>>> =0A>>>=
>>>> =0A>>>>>>> =A0 =A0  The app may not explicitly care for signals =0A> (=
granted, most would=0A>>>>  do, but=0A>>>>>>> =A0 =A0  we would then have t=
o assume they do it right).=0A>>>>>>> =0A>>>>>> =0A>>>>>> =A0  Yes, applica=
tions may want to use signals to interrupt a =0A> call to=0A>>>>>>  read=0A=
>>>>>> =A0  and voluntarily get EINTR anyway.=0A>>>>>> =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 Gilles.=0A>>>>> =0A>>>>> =0A>>>>> =A0  =
Please find attached a third version of my patch dealing with=0A>>>>> =A0  =
EINTR syscalls. Note that I also stumbled over unexpected =0A> behavior=0A>=
>>>> =A0  in threadobj_sleep and cancel_sync due to EINTRs. Considering =0A=
> that=0A>>>>> =A0  mercury is using signals for user-space round-robin and=
 =0A> thread=0A>>>>> =A0  suspension, even without any application signals =
EINTR =0A> happens=0A>>>>> =A0  quite often.=0A>>>> =0A>>>>  @@ -86,9 +88,1=
3 @@ static void notifier_sighandler(int sig, =0A> siginfo_t=0A>>>>  *sigin=
fo,=0A>>>>  void *uc)=0A>>>> =A0 =A0 =A0 =A0 =A0 if (nf->owner && nf->owner=
 !=3D tid)=0A>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 continue;=0A>>>> =0A>>>>  -=
=A0 =A0 =A0 =A0 while (__STD(read(nf->psfd[0], &c, 1)) > 0)=0A>>>>  -=A0 =
=A0 =A0 =A0 =A0 =A0 /* Callee must run async-safe code only. */=0A>>>>  -=
=A0 =A0 =A0 =A0 =A0 =A0 nf->callback(nf);=0A>>>>  +=A0 =A0 =A0 =A0 do {=0A>=
>>>  +=A0 =A0 =A0 =A0 =A0 =A0 ret =3D __STD(read(nf->psfd[0], &c, 1));=0A>>=
>>  +=A0 =A0 =A0 =A0 =A0 =A0 if (ret > 0)=0A>>>>  +=A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 /* Callee must run async-safe code only. */=0A>>>>  +=A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 nf->callback(nf);=0A>>>>  +=A0 =A0 =A0 =A0 } while (ret=
 > 0 || errno =3D=3D EINTR);=0A>>>> =0A>>>>  In theory, we could receive a =
zero byte count on EOF, in which case=0A>>>>  we should=0A>>>>  not test er=
rno, rather we should bail out immediately.=0A>>>> =0A>>>>  @@ -1093,7 +109=
3,9 @@ int threadobj_sleep(struct timespec *ts)=0A>>>> =A0 =A0 =A0  */=0A>>=
>> =A0 =A0 =A0 current->run_state =3D __THREAD_S_DELAYED;=0A>>>> =A0 =A0 =
=A0 threadobj_save_timeout(&current->core, ts);=0A>>>>  -=A0 =A0 ret =3D -_=
_RT(clock_nanosleep(CLOCK_COPPERPLATE, TIMER_ABSTIME,=0A>>>>  ts, NULL));=
=0A>>>>  +=A0 =A0 do=0A>>>>  +=A0 =A0 =A0 =A0 ret =3D -__RT(clock_nanosleep=
(CLOCK_COPPERPLATE,=0A>>>>  TIMER_ABSTIME, ts,=0A>>>>  NULL));=0A>>>> =0A>>=
>>  We should definitely pass and use the "remain" field in=0A>>>>  clock_n=
anosleep(), not to restart a complete wait each time we get=0A>>>>  interru=
pted.=0A>>>> =0A>>>> =0A>>>>  --=0A>>>>  Philippe.=0A>>>> =0A>>> =0A>>>  I =
have attached a new version of the patch leaving the loop on ret =3D=3D=0A>=
>>  0. Note=0A>>>  that this will be a new behavior in compared to before t=
he patch.=0A>>> =0A>>>  Gilles already pointed out that TIMER_ABSTIME allow=
s restarting the=0A>>>  same syscall=0A>>>  in threadobj_sleep.=0A>>> =0A>>=
 =0A>>  Yes, but unfortunately, that part of the patch is still broken and=
=0A>>  introduced a regression of other copperplate-based AP=CFs. Several R=
TOS=0A>>  implement some kind of thread/task_unblock() service, which shall=
 cause=0A>>  sleep calls based on threadobj_sleep() to return upon receivin=
g the=0A>>  SIGRELS notification via a signal. This is the meaning of the c=
omment=0A>>  heading that code.=0A>> =0A>>  So the proper fix should go to =
the call site in the pSOS emulator,=0A>>  instead of changing the generic b=
ehavior in threadobj_sleep().=0A>> =0A> =0A> Or threadobj_sleep() should be=
 made smarter, specifically detecting =0A> SIGRELS in the mercury case for =
aborting the wait.=0A> =0A> =0A> -- =0A> Philippe.=0A> =0A=0AI think I woul=
d prefer to encapsulate that in threadobj_sleep(). Would=A0=0Astoring a fla=
g in=A0threadobj_current() in unblock_sighandler() and=0Achecking this in=
=A0threadobj_sleep() be an option? Sorry for having=A0=0Aoverlooked this,=
=0A=0AMatthias

