From: Sebastian Smolorz <ssm@domain.hid>
Subject: Re: [Xenomai-help] Interrupt shield
Date: Mon, 20 Nov 2006 10:24:04 +0100
References: <E1Gke0B-0003BT-CA@mailer.emlix.com>
	<1163712755.4980.16.camel@domain.hid> <1163762469.4980.29.camel@domain.hid>
In-Reply-To: <1163762469.4980.29.camel@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <E1Gm5Nk-0000vS-Le@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: rpm@xenomai.org
Cc: xenomai@xenomai.org

Philippe Gerum wrote:
> On Thu, 2006-11-16 at 22:32 +0100, Philippe Gerum wrote:
> > On Thu, 2006-11-16 at 10:57 +0100, Sebastian Smolorz wrote:
> > > Hello,
> > >
> > > can anybody confirm this behaviour? If I configure the I-shield into
> > > the kernel and start the latency test the RT tasks have not activated
> > > T_SHIELD although the documentation states it (and btw in
> > > rt_task_create this bit is set).
> >
> > The documentation of rt_task_create() is wrong. The default behaviour
> > should be to create tasks with disabled I-shield support.
> >
> > >  If I try to set T_SHIELD inside the display task, the system hangs, a
> > > soft lockup appears and sometimes a few correct lines of the display
> > > task are printed, followed by the next lockup.
> >
> > Confirmed here (on x86).
> >
> > > Explainable?
> >
> > Yes. I must have screwed up something somewhere, many moons ago.
>
> Yes I did. This patch should fix the issue on your setup too.

Yes, it is working now. Thank you!

--
Sebastian

