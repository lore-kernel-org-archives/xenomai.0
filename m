From: Sebastian Smolorz <ssm@domain.hid>
Subject: Re: [Xenomai-help] Interrupt shield
Date: Thu, 16 Nov 2006 17:03:05 +0100
References: <E1Gke0B-0003BT-CA@mailer.emlix.com> <455C88C7.6080509@domain.hid>
In-Reply-To: <455C88C7.6080509@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <E1Gkjhi-00083x-9s@domain.hid>
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

Jan Kiszka wrote:
> Sebastian Smolorz wrote:
> > Hello,
> >
> > can anybody confirm this behaviour? If I configure the I-shield into the
> > kernel and start the latency test the RT tasks have not activated
> > T_SHIELD although the documentation states it (and btw in rt_task_create
> > this bit is set). If I try to set T_SHIELD inside the display task, the
> > system hangs, a soft lockup appears and sometimes a few correct lines of
> > the display task are printed, followed by the next lockup.
> >
> > Explainable?
> >
> > I'm testing on ARM with my S3C24xx I-pipe patch.
>
> Have you tried over x86, too?

No, but I'm considering it.

> The shield used to be off by default for 
> quite some time, and it's a fairly special feature. I wouldn't be
> surprised if there is some regression sleeping. But it might also be an 
> ARM-specific issue.
>
> Soft lockup sounds like the shield is not released appropriately again.
> The tracer would visualise this nicely in verbose mode...

Yes, I was thinking the same. So now there are two good arguments to learn 
some assembler for ARM ... ;-)

--
Sebastian

