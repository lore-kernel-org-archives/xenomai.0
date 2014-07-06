References: <1404638402.36454.YahooMailNeo@web171603.mail.ir2.yahoo.com>
 <53B91595.9060604@xenomai.org>
 <1404639382.8763.YahooMailNeo@web171605.mail.ir2.yahoo.com>
 <53B91C45.8090802@xenomai.org> <53B91D72.8030503@xenomai.org>
Message-ID: <1404673210.38609.YahooMailNeo@web171603.mail.ir2.yahoo.com>
Date: Sun, 6 Jul 2014 20:00:10 +0100
From: Matthias Schneider <ma30002000@yahoo.de>
In-Reply-To: <53B91D72.8030503@xenomai.org>
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
enomai@xenomai.org>=0A> Cc: =0A> Sent: Sunday, July 6, 2014 11:57 AM=0A> Su=
bject: Re: [Xenomai] Question about threadobj_irq_prio=0A> =0A> On 07/06/20=
14 11:52 AM, Philippe Gerum wrote:=0A>>  On 07/06/2014 11:36 AM, Matthias S=
chneider wrote:=0A>>>  ----- Original Message -----=0A>>> =0A>>>>  From: Ph=
ilippe Gerum <rpm@xenomai.org>=0A>>>>  To: Matthias Schneider <ma30002000@y=
ahoo.de>; =0A> "xenomai@xenomai.org"=0A>>>>  <xenomai@xenomai.org>=0A>>>>  =
Cc:=0A>>>>  Sent: Sunday, July 6, 2014 11:23 AM=0A>>>>  Subject: Re: [Xenom=
ai] Question about threadobj_irq_prio=0A>>>> =0A>>>>  On 07/06/2014 11:20 A=
M, Matthias Schneider wrote:=0A>>>>> =A0  Hi all,=0A>>>>> =0A>>>>> =A0  I w=
as under the expression that the max cobal scheduling prio =0A> in=0A>>>>> =
=A0  forge was now 256 and that SCHED_COBALT had been replaced =0A> with=0A=
>>>>> =A0  SCHED_FIFO. Is this correct?=0A>>>>> =0A>>>> =0A>>>>  Yes.=0A>>>=
> =0A>>>>> =A0  Anyway,=0A>>>>> =0A>>>>> =A0  threadobj_pkg_init(void) init=
ializes=0A>>>>> =A0  threadobj_irq_prio =3D =0A> __RT(sched_get_priority_ma=
x(SCHED_CORE));=0A>>>>> =A0  which is still mapping to 258 - however I woul=
d rather expect=0A>>>>> =A0  256...=0A>>>>> =0A>>>> =0A>>>>  256 regular FI=
FO levels, +2 special levels for scheduler lock =0A> (mercury=0A>>>>  only)=
 and interrupt service emulation (both cores).=0A>>>> =0A>>>> =0A>>>>> =A0 =
 Thanks for clarification,=0A>>>>> =0A>>>>> =A0  regards,=0A>>>>> =A0  Matt=
hias=0A>>>>> =0A>>> =0A>>>  I get=0A>>> =0A>>>  threadobj_high_prio =3D 258=
=0A>>>  threadobj_irq_prio =3D 259=0A>>>  threadobj_agent_prio =3D 258=0A>>=
> =0A>>>  and=0A>>> =0A>>>  e.g. int psos_task_normalize_priority(unsigned =
long psos_prio)=0A>>> =0A>>>  clips the prio to threadobj_high_prio. Howeve=
r it should=0A>>>  clip prio at threadobj_high_prio - 2, shouldnt it?=0A>>>=
 =0A>> =0A>>  Even 256 explicitly, since pSOS specifies this limit.=0A>> =
=0A> =0A> No, we can't do that over Mercury, where we only have the limited=
 1-97 =0A> range available. So that would be high_prio -2 for Cobalt, but h=
igh_prio =0A> for Mercury. copperplate should be fixed on the Cobalt side.=
=0A> =0A> =0A> -- =0A> Philippe.=0A> =0A=0AThanks for the fix..=0AMatthias

