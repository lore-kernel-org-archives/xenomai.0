References: <1398944548.9186.YahooMailNeo@web171603.mail.ir2.yahoo.com>
 <53624421.8090903@xenomai.org>
Message-ID: <1398954230.40374.YahooMailNeo@web171605.mail.ir2.yahoo.com>
Date: Thu, 1 May 2014 15:23:50 +0100 (BST)
From: Matthias Schneider <ma30002000@yahoo.de>
In-Reply-To: <53624421.8090903@xenomai.org>
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
enomai@xenomai.org>=0A> Cc: =0A> Sent: Thursday, May 1, 2014 2:54 PM=0A> Su=
bject: Re: [Xenomai] Issue in __threadobj_unlock_sched (forge/mercury)=0A> =
=0A> On 05/01/2014 01:42 PM, Matthias Schneider wrote:=0A> =0A>>  Hi all,=
=0A>> =0A>>  it seems __threadobj_unlock_sched has a slight bug=0A>>  and d=
oes not reset the current->policy value.=0A>>  This leads to the old policy=
 being restored, but=0A>>  no longer being available for the next=0A>>  __t=
hreadobj_lock_sched / __threadobj_unlock_sched=0A>>  call pair.=0A>> =0A> =
=0A> That would mean that the client code switches between different =0A> s=
cheduling policies while holding the scheduler lock?=0A> =0A> -- =0A> Phili=
ppe.=0A> =0A=0AConsider the following scenario:=0A=0Aa) threads may hold SC=
HED_RT, SCHED_RR or SCHED_OTHER while not in=A0=0Athreadobj_lock_sched(). (=
see e.g. threadobj_set_priority).=0A=0Ab) threadobj_lock_sched() saves prio=
 and policy and sets it to=A0=0ASCHED_RT/threadobj_lock_prio=0A=0Ac) thread=
obj_unlock_sched() will restore (correctly) previous=A0=0Asettings, but not=
 update the threadobj's policy=0A=0Ad) next time threadobj_lock_sched() is =
called, it will save prio=A0=0Aand priority, howver policy will always be S=
CHED_RT (which is=A0=0Anot the currently set policy before upgrading it)=0A=
=0Ae) threadobj_unlock_sched() will restore prio and incorrectly saved=0Apo=
licy, which is always SCHED_RT -> threads that originally had=0ASCHED_RR or=
 SCHED_OTHER now have SCHED_RT=0A=0A=0AChanging prio while holding the sche=
duler lock should be handled=A0=0Afine due to :=0A=0Athreadobj_set_priority=
():=0Aif (thobj->schedlock_depth > 0) {=0A=A0 thobj->core.prio_unlocked =3D=
 prio;=0A=A0 thobj->core.policy_unlocked =3D prio ? SCHED_RT : SCHED_OTHER;=
=0A=A0 threadobj_unlock(thobj);=0A=A0 return 0;=0A=A0}=0A=0AMatthias=0A

