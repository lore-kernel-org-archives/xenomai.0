References: <1400327350.427.YahooMailNeo@web171605.mail.ir2.yahoo.com>
 <1400335101.23289.YahooMailNeo@web171603.mail.ir2.yahoo.com>
 <537781C1.6050101@xenomai.org>
Message-ID: <1400350485.64520.YahooMailNeo@web171602.mail.ir2.yahoo.com>
Date: Sat, 17 May 2014 19:14:45 +0100 (BST)
From: Matthias Schneider <ma30002000@yahoo.de>
In-Reply-To: <537781C1.6050101@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] Round-robin scheduling on cobalt
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

=0A=0A=0A=0A=0A----- Original Message -----=0A> From: Philippe Gerum <rpm@x=
enomai.org>=0A> To: Matthias Schneider <ma30002000@yahoo.de>; "xenomai@xeno=
mai.org" <xenomai@xenomai.org>=0A> Cc: =0A> Sent: Saturday, May 17, 2014 5:=
35 PM=0A> Subject: Re: [Xenomai] Round-robin scheduling on cobalt=0A> =0A> =
On 05/17/2014 03:58 PM, Matthias Schneider wrote:=0A> =0A>>  ----- Original=
 Message -----=0A>> =0A>>>  From: Matthias Schneider <ma30002000@yahoo.de>=
=0A>>>  To: "xenomai@xenomai.org" <xenomai@xenomai.org>=0A>>>  Cc:=0A>>>  S=
ent: Saturday, May 17, 2014 1:49 PM=0A>>>  Subject: [Xenomai] Round-robin s=
cheduling on cobalt=0A>>> =0A>>>  Hi all,=0A>>> =0A>>>  When enabling rr sc=
hduling on cobalt via threadobj_set_rr(),=A0 the call =0A> will be=0A>>>  f=
orwarded to the cobalt-specific set_rr(). This function will then call=0A>>=
>  pthread_setschedparam_ex(), which in turn calls libc_setschedparam() =0A=
> for=0A>>>  updating the regular kernels view on the rr task. However, whe=
n using =0A> prios=0A>>>> =0A>>>  99, libc_setschedparam() will clip them f=
or SCHED_COBALT / SCHED_RT, =0A> SCHED_TP,=0A>>>  SCHED_SPORADIC, SCHED_QUO=
TA, but not for SCHED_RR, leading to an EINVAL =0A> error.=0A>>>  Mercury m=
aps rr scheduling to SCHED_FIFO. Shouldnt cobalt also register =0A> rr=0A>>=
>  tasks=0A>>>  as SCHED_FIFO and clip their prio? i.e. add SCHED_RR to the=
 =0A> fall-through case=0A>>>  list of in libc_setschedparam()?=0A>>> =0A>>=
>  Thanks in advance,=0A>>> =0A>>>  Matthias=0A>>> =0A>> =0A>>  My observat=
ion is shows a situation slightly more complicate than described=0A>>  befo=
re. Scheduling policies are being set as follows:=0A>> =0A>>  threadobj_ini=
t() sets either : SCHED_OTHER when prio =3D 0 or SCHED_RT =0A> otherwise=0A=
>>  (which maps to SCHED_COBALT on cobalt and SCHED_FIFO on mercury).=0A>> =
 set_rr may change the policy to SCHED_RR on cobalt or SCHED_FIFO on =0A> m=
ercury.=0A>> =0A>>  However, considering cobalt specific prios > 99, it see=
ms that task with =0A> prios >=0A>>  99 with SCHED_RT do actually work, but=
 task with SCHED_RR seem to only to =0A> run=0A>>  into the issue described=
 by my previous email, but also the cobalt core =0A> itself=0A>>  seems to =
expect something <=3D99 here:=0A>> =0A>>  get_policy_param():=0A>>  [...]=
=0A>>  case SCHED_RR:=0A>>  [...]=0A>> =A0 =A0 if (prio < XNSCHED_FIFO_MIN_=
PRIO(1) ||=0A>> =A0 =A0 =A0 =A0 prio > XNSCHED_FIFO_MAX_PRIO(99))=0A>> =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 return NULL;=0A>> =0A>>  but not XNSCHED_RT_MAX_PRI=
O(257) as I would have expected.=0A>> =0A>>  This leads to an EINVAL in the=
 cobalt call for =0A> sc_cobalt_thread_setschedparam_ex=0A>>  in the same w=
ay like libc_setschedparam.=0A>> =0A>>  Is the max prio on cobalt only 99 f=
or RR tasks, while non-RR (i.e.=0A>>  SCHED_RT/SCHED_COBALT) tasks can go h=
igher?=0A>> =0A> =0A> Yes. SCHED_RR and SCHED_FIFO have the same priority s=
cale than their =0A> counterpart in the host kernel, [1..99]. SCHED_COBALT =
has access to the =0A> full range of priorities defined by the Cobalt core,=
 i.e. 257.=0A> =0A> -- =0A> Philippe.=0A> =0A=0AHow does this play with the=
 existing skins?=A0=0A=0APSOS enables rr based on the T_TSLICE flag. Howeve=
r,=A0=0Apsos_task_normalize_priority() is based=A0on threadobj_high_prio on=
ly.=0Ai.e. I can create a task with T_SLICE and a prio > 99 and it will cau=
se=0Athe described the problem, right?=0A=0ASame should go for VxWorks. The=
re additionally kernelTimeSlice() may=0Acause a problem enabling RR on task=
s that have already been started,=0Athat may also have a prio > 99.=A0=0A=
=0AArent both SCHED_RR and SCHED_COBALT scheduled by the cobalt core=0A(con=
trary to to use SCHED_FIFO and userspace RR in mercury?)=0A=0ARegards,=0AMa=
tthias

