Subject: Re: [Xenomai-help] Priority inversion
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <44C0D0BE.5020500@domain.hid>
References: <FDBBB5CC70676540B3EF7CFE83FD94E0210E1A@EINT11.einet.ad.eivd.ch>
	<FDBBB5CC70676540B3EF7CFE83FD94E05B4564@domain.hid>
	<20060721145159.5a87453c@domain.hid> <44C0D0BE.5020500@domain.hid>
Content-Type: text/plain
Date: Fri, 21 Jul 2006 15:19:43 +0200
Message-Id: <1153487984.5019.36.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Reply-To: rpm@xenomai.org
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai@xenomai.org

On Fri, 2006-07-21 at 15:03 +0200, Jan Kiszka wrote:
> Daniel Simon wrote:
> > On Fri, 21 Jul 2006 14:12:47 +0200
> > "ROSSIER Daniel" <Daniel.Rossier@domain.hid> wrote:
> > 
> >> but it might be at the spin() level.
> > 
> > I have observed that the behaviour of rt_timer_spin() does not fit with
> > the expected behaviour as described in the doxygened comment: its actual
> > awakening time do not increase when it is preempted. 
> > 
> > According to the code in timer.c (using 2.1.2) the wakening time seems
> > to be computed once for all at the beginning of the function call.
> > 
> > Am I right?
> 
> Partially. The doc doesn't claim that the time during preemption will
> get added to your requested spin time. Depending on how long you got
> preempted, the delay /may/ be longer (until the preemption actually
> ends). Anyway, this could explain some misunderstandings in this tricky
> scenario here.
> 
> [There is actually one undocumented issue of rt_timer_spin: if the task
> is migrated to another CPU during spin, the end time will not match the
> new timebase. So, one should not forget to pin such spinning tasks to
> one CPU first when running on SMP.]
> 

Fortunately, this scenario cannot happen, since migration is always a
self-targeted action, i.e. tasks can only request migration for
themselves, Xenomai never ever forcibly migrates RT threads on its own
decision. So if the task spins, it can't request any migration. If the
migration comes first, then the spinning occurs on the target CPU, so
this is still a non-issue. 

> Jan
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
-- 
Philippe.



