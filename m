Content-Type: text/plain; charset="utf-8"
In-Reply-To: <423a8582-50e7-2e50-6ad8-f247b1239dde@siemens.com>
From: =?utf-8?q?Fran=C3=A7ois_Legal?= <devel@thom.fr.eu.org>
Date: Thu, 07 May 2020 14:10:17 +0200
MIME-Version: 1.0
Message-ID: <1108-5eb3fa80-f-411d5c80@96373630>
Subject: =?utf-8?q?Re=3A?= Kernel panic while booting in single processor mode
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: xenomai@xenomai.org

Le Jeudi, Mai 07, 2020 11:38 CEST, Jan Kiszka <jan.kiszka@siemens.com> =
a =C3=A9crit: 
 
> On 07.05.20 11:02, Fran=C3=A7ois Legal wrote:
> > Le Jeudi, Mai 07, 2020 10:42 CEST, Jan Kiszka <jan.kiszka@siemens.c=
om> a =C3=A9crit:
> >   
> >> On 07.05.20 10:36, Fran=C3=A7ois Legal via Xenomai wrote:
> >>> Hello,
> >>>
> >>> trying to diagnose an imprecise external abort, I reconfigured th=
e kernel to boot on a single core (SMP disabled) with I&D caches disabl=
ed.
> >>>
> >>> Config is linux 4.4.189, xenomai-3.0.9
> >>>
> >>> During the boot, when the system creates the thread for RTNET sta=
ck mgr, I get a kernel panic as you can see below.
> >>> I could track that down to the "list=5Fadd=5Ftail(&timer->next=5F=
stat, &clock->timerq);" in =5F=5Fxntimer=5Finit.
> >>>
> >>> Looks like clock->timerq (which is nkclock->timerq) is not initia=
lized.
> >>>
> >>> Am I missing something ?
> >>
> >> I thinks there was an ordering issue... Is RTnet built-in (I suspe=
ct
> >> from the backtrace) or a module? That should be addressed in 3.1,
> >> possibly not backported to 3.0 (or only in current stable). I woul=
d have
> >> to dig into the git history myself now.
> >>
> >> Jan
> >>
> > 
> > It is built in. There used to be an ordering issue (which I fixed i=
n a patch some monthes ago), but that was due to protocols being probed=
 before stack manager. Here, there is something wrong with the xnthread=
s I think.
> > 
> > There might be something wrong with my config however, as I did not=
 pay attention, but earlier in the boot, I just noticed this :
> > [   11.613033] [Xenomai] scheduling class rt registered.
> > [   11.615582] I-pipe: could not find timer for cpu #0
> > [   11.616487] [Xenomai] init failed, code -19
> > 
> > That might explain why the nkclock is not properly initialized.
> > 
> 
> Yep, that's the root cause. We then fail ungracefully later, another =

> issue, patches welcome.
> 
> Jan
> 

I'm not sure how to go through this. The timer used by xenomai is (used=
 to be) the twd (which is arm cortex A9 core private timer), which driv=
er depends on HAVE=5FSMP.
I don't quite understand why that depends on SMP as this is a private c=
ore peripheral. Anyway, it looks like it comes from upstream, so there =
not much we can do here.

I'm quite surprise here. That means any Cortex A9 MPCore cluster runnin=
g as AMP or with a single core enabled can't work with xenomai ? What a=
bout the IMX6 solo and stuff like that ? Aren't they supported ?

I think I can patch the global=5Ftimer driver to make it look like TWD,=
 but it does not seem right.

Fran=C3=A7ois



> -- 
> Siemens AG, Corporate Technology, CT RDA IOT SES-DE
> Corporate Competence Center Embedded Linux


