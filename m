References: <1400785908.61926.YahooMailNeo@web171606.mail.ir2.yahoo.com>
 <537E4DBE.5060406@xenomai.org> <537E4E01.2030108@xenomai.org>
Message-ID: <1401017215.32791.YahooMailNeo@web171603.mail.ir2.yahoo.com>
Date: Sun, 25 May 2014 12:26:55 +0100 (BST)
From: Matthias Schneider <ma30002000@yahoo.de>
In-Reply-To: <537E4E01.2030108@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] threadobj_set_schedparam and SCHED_OTHER on mercury
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
mai.org" <xenomai@xenomai.org>=0A> Cc: =0A> Sent: Thursday, May 22, 2014 9:=
20 PM=0A> Subject: Re: [Xenomai] threadobj_set_schedparam and SCHED_OTHER o=
n mercury=0A> =0A> On 05/22/2014 09:19 PM, Philippe Gerum wrote:=0A>>  On 0=
5/22/2014 09:11 PM, Matthias Schneider wrote:=0A>>>  Hi,=0A>>> =0A>>>  Sinc=
e commit=0A>>> =A0  2d102939333201169493688dd91258164bd9737c=0A>>>  copperp=
late: more robustness for threadobj_set_schedparam()=0A>>> =0A>>>  threadob=
j_set_schedparam() seems no longer to allow=0A>>>  SCHED_OTHER on mercury, =
due to prepare_rr_corespec() always=0A>>>  returning SCHED_FIFO.=0A>>> =0A>=
>>  i.e. threadobj_set_schedparam( prio 0, SCHED_OTHER) does not work=0A>>>=
  anymore.=0A>>> =0A>> =0A>>  This should help. With those latest changes, =
the issue with the priority=0A>>  range available for SCHED_RR with Cobalt =
should be fixed.=0A>> =0A>>  diff --git a/lib/copperplate/threadobj.c b/lib=
/copperplate/threadobj.c=0A>>  index 8792927..dc5c905 100644=0A>>  --- a/li=
b/copperplate/threadobj.c=0A>>  +++ b/lib/copperplate/threadobj.c=0A>>  @@ =
-1486,7 +1486,9 @@ int threadobj_set_schedparam(struct threadobj=0A>>  *tho=
bj, int policy,=0A>> =A0 =A0 =A0  if (thobj->schedlock_depth > 0)=0A>> =A0 =
=A0 =A0 =A0 =A0  return __bt(-EPERM);=0A>> =0A>>  -=A0 =A0 _policy =3D prep=
are_rr_corespec(thobj, policy, param_ex);=0A>>  +=A0 =A0 _policy =3D policy=
;=0A>>  +=A0 =A0 if (rr =3D=3D SCHED_RR)=0A>>  +=A0 =A0 =A0 =A0 _policy =3D=
 prepare_rr_corespec(thobj, policy, param_ex);=0A>> =A0 =A0 =A0  /*=0A>> =
=A0 =A0 =A0 =A0 * NOTE: if the current thread suddently starves as a result=
=0A>> =A0 =A0 =A0 =A0 * of switching itself to a scheduling class with no r=
untime=0A>> =0A> =0A> Typo.=0A> =0A> diff --git a/lib/copperplate/threadobj=
.c b/lib/copperplate/threadobj.c=0A> index 8792927..4515c9e 100644=0A> --- =
a/lib/copperplate/threadobj.c=0A> +++ b/lib/copperplate/threadobj.c=0A> @@ =
-1486,7 +1486,9 @@ int threadobj_set_schedparam(struct threadobj =0A> *thob=
j, int policy,=0A> =A0 =A0=A0=A0 if (thobj->schedlock_depth > 0)=0A> =A0 =
=A0=A0=A0 =A0=A0=A0 return __bt(-EPERM);=0A> =0A> -=A0=A0=A0 _policy =3D pr=
epare_rr_corespec(thobj, policy, param_ex);=0A> +=A0=A0=A0 _policy =3D poli=
cy;=0A> +=A0=A0=A0 if (policy =3D=3D SCHED_RR)=0A> =0A> +=A0=A0=A0 =A0=A0=
=A0 _policy =3D prepare_rr_corespec(thobj, policy, param_ex);=0A> =A0 =A0=
=A0=A0 /*=0A> =A0 =A0=A0=A0  * NOTE: if the current thread suddently starve=
s as a result=0A> =A0 =A0=A0=A0  * of switching itself to a scheduling clas=
s with no runtime=0A> =0A> -- =0A> Philippe.=0A> =0A=0AThe patch fixes my i=
ssue on mercury. I have not yet had the chance to=A0=0Averify cobalt. Are t=
he number of priorities for SCHED_RT and SCHED_RR=A0=0Anow both 257 on coba=
lt?=0A=0AThanks for the quick fix,=0A=0Aregards,=0AMatthias

