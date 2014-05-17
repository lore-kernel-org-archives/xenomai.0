References: <1400327350.427.YahooMailNeo@web171605.mail.ir2.yahoo.com>
Message-ID: <1400335101.23289.YahooMailNeo@web171603.mail.ir2.yahoo.com>
Date: Sat, 17 May 2014 14:58:21 +0100 (BST)
From: Matthias Schneider <ma30002000@yahoo.de>
In-Reply-To: <1400327350.427.YahooMailNeo@web171605.mail.ir2.yahoo.com>
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
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

----- Original Message -----=0A=0A> From: Matthias Schneider <ma30002000@ya=
hoo.de>=0A> To: "xenomai@xenomai.org" <xenomai@xenomai.org>=0A> Cc: =0A> Se=
nt: Saturday, May 17, 2014 1:49 PM=0A> Subject: [Xenomai] Round-robin sched=
uling on cobalt=0A> =0A> Hi all,=0A> =0A> When enabling rr schduling on cob=
alt via threadobj_set_rr(),=A0 the call will be=A0=0A> forwarded to the cob=
alt-specific set_rr(). This function will then call=A0=0A> pthread_setsched=
param_ex(), which in turn calls libc_setschedparam() for=A0=0A> updating th=
e regular kernels view on the rr task. However, when using prios =0A>> =A0=
=0A> 99, libc_setschedparam() will clip them for SCHED_COBALT / SCHED_RT, S=
CHED_TP,=A0=0A> SCHED_SPORADIC, SCHED_QUOTA, but not for SCHED_RR, leading =
to an EINVAL error.=A0=0A> Mercury maps rr scheduling to SCHED_FIFO. Should=
nt cobalt also register rr =0A> tasks=A0=0A> as SCHED_FIFO and clip their p=
rio? i.e. add SCHED_RR to the fall-through case=A0=0A> list of in libc_sets=
chedparam()?=0A> =0A> Thanks in advance,=0A> =0A> Matthias=0A>=A0=0A=0AMy o=
bservation is shows a situation slightly more complicate than described=0Ab=
efore.=A0Scheduling policies are being set as follows:=0A=0Athreadobj_init(=
) sets either : SCHED_OTHER when prio =3D 0 or SCHED_RT otherwise=A0=0A(whi=
ch maps to SCHED_COBALT on cobalt and SCHED_FIFO on mercury).=0Aset_rr may=
=A0change the policy to SCHED_RR on cobalt or SCHED_FIFO on mercury.=0A=0AH=
owever, considering cobalt specific prios > 99, it seems that task with pri=
os >=A0=0A99 with SCHED_RT do actually work, but task with SCHED_RR seem to=
 only to run=A0=0Ainto the issue described by my previous email, but also t=
he cobalt core itself=A0=0Aseems to expect something <=3D99 here:=0A=0Aget_=
policy_param():=A0=0A[...]=0Acase SCHED_RR:=0A[...]=0A=A0 if (prio < XNSCHE=
D_FIFO_MIN_PRIO(1) ||=0A=A0 =A0 =A0 prio > XNSCHED_FIFO_MAX_PRIO(99))=0A=A0=
 =A0 =A0 =A0 =A0 =A0 return NULL;=0A=0Abut not XNSCHED_RT_MAX_PRIO(257)=A0a=
s I would have expected.=0A=0AThis leads to an EINVAL in the cobalt call fo=
r sc_cobalt_thread_setschedparam_ex=A0=0Ain the same way like libc_setsched=
param.=0A=0AIs the max prio on cobalt only 99 for RR tasks, while non-RR (i=
.e.=A0=0ASCHED_RT/SCHED_COBALT) tasks can go higher?=0A=0AThanks in advance=
,=0AMatthias=0A

