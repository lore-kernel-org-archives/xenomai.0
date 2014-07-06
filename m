References: <1404638402.36454.YahooMailNeo@web171603.mail.ir2.yahoo.com>
 <53B91595.9060604@xenomai.org>
Message-ID: <1404639382.8763.YahooMailNeo@web171605.mail.ir2.yahoo.com>
Date: Sun, 6 Jul 2014 10:36:22 +0100
From: Matthias Schneider <ma30002000@yahoo.de>
In-Reply-To: <53B91595.9060604@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] Question about threadobj_irq_prio
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
enomai@xenomai.org>=0A> Cc: =0A> Sent: Sunday, July 6, 2014 11:23 AM=0A> Su=
bject: Re: [Xenomai] Question about threadobj_irq_prio=0A> =0A> On 07/06/20=
14 11:20 AM, Matthias Schneider wrote:=0A>>  Hi all,=0A>> =0A>>  I was unde=
r the expression that the max cobal scheduling prio in=0A>>  forge was now =
256 and that SCHED_COBALT had been replaced with=0A>>  SCHED_FIFO. Is this =
correct?=0A>> =0A> =0A> Yes.=0A> =0A>>  Anyway,=0A>> =0A>>  threadobj_pkg_i=
nit(void) initializes=0A>>  threadobj_irq_prio =3D __RT(sched_get_priority_=
max(SCHED_CORE));=0A>>  which is still mapping to 258 - however I would rat=
her expect=0A>>  256...=0A>> =0A> =0A> 256 regular FIFO levels, +2 special =
levels for scheduler lock (mercury =0A> only) and interrupt service emulati=
on (both cores).=0A> =0A> =0A>>  Thanks for clarification,=0A>> =0A>>  rega=
rds,=0A>>  Matthias=0A>>=A0=0A=0AI get=0A=0Athreadobj_high_prio=A0=3D 258=
=0Athreadobj_irq_prio=A0=3D 259=0Athreadobj_agent_prio=A0=3D 258=0A=0Aand=
=A0=0A=0Ae.g.=A0int psos_task_normalize_priority(unsigned long psos_prio)=
=0A=0Aclips the prio to threadobj_high_prio. However it should=A0=0Aclip pr=
io at threadobj_high_prio - 2, shouldnt it?=0A=0ARegards,=0AMatthias=0A

