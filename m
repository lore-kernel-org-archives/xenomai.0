References: <1398944548.9186.YahooMailNeo@web171603.mail.ir2.yahoo.com>
 <53624421.8090903@xenomai.org>
 <1398954230.40374.YahooMailNeo@web171605.mail.ir2.yahoo.com>
 <536356E2.30308@xenomai.org>
Message-ID: <1400336435.71762.YahooMailNeo@web171605.mail.ir2.yahoo.com>
Date: Sat, 17 May 2014 15:20:35 +0100 (BST)
From: Matthias Schneider <ma30002000@yahoo.de>
In-Reply-To: <536356E2.30308@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] Issue in __threadobj_unlock_sched (forge/mercury)
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

----- Original Message -----=0A=0A> From: Philippe Gerum <rpm@xenomai.org>=
=0A> To: Matthias Schneider <ma30002000@yahoo.de>; "xenomai@xenomai.org" <x=
enomai@xenomai.org>=0A> Cc: =0A> Sent: Friday, May 2, 2014 10:27 AM=0A> Sub=
ject: Re: [Xenomai] Issue in __threadobj_unlock_sched (forge/mercury)=0A> =
=0A> On 05/01/2014 04:23 PM, Matthias Schneider wrote:=0A> =0A>>  b) thread=
obj_lock_sched() saves prio and policy and sets it to=0A>>  SCHED_RT/thread=
obj_lock_prio=0A> =0A> Forcing SCHED_RT in threadobj_lock() is the core iss=
ue. Doing so allows =0A> SCHED_OTHER callers to hold that lock: does it mak=
e sense? Maybe it's =0A> handy so that client code does not have to care, o=
n the other hand, this =0A> very much sounds like introducing priority inve=
rsion by design.=0A> =0A> What would be the use case for holding the sched =
lock over SCHED_OTHER?=0A> =0A> =0A> -- =0A> Philippe.=0A> =0A=0AThere are =
some points I would like to raise about this issue:=0A=0Aa) the policy acti=
ve before holding the "scheduler lock" is actually reapplied,=A0=0Abut the =
threadobj info about this is left inconsistent=0Ab) independent from wether=
 SCHED_OTHER is a use case, SCHED_RR and SCHED_RT/SCHED_FIFO=A0=0Adefinitel=
y are.=0Ac) In my recently published FreeRTOS prototype, the "main" thread =
calling=A0=0ATaskSchedulerStart is actually a SCHED_OTHER thread that takes=
 the scheduler=A0=0Alock=0A=0ANevertheless, please have a look at the code =
again, it seems like a simple bug=A0=0Ato me.=0A=0AConsider the following:=
=0A=0Acurrent task is SCHED_RR, prio 5=0A=0Athreadobj_lock_sched()=0A=A0-> =
SCHED_RT, prio 99=0A=0Athreadobj_unlock_sched()=0A=A0-> SCHED_RR, prio 5=0A=
=0Athreadobj_lock_sched()=0A=A0-> SCHED_RT, prio 99=0A=0Athreadobj_unlock_s=
ched()=0A=A0-> SCHED_RT(!), prio 5=0A=0ARegards,=0AMatthias

