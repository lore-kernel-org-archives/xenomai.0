From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <46AF69BC.6030109@domain.hid>
References: <46AF5F1E.7030009@domain.hid> <1185899217.6611.246.camel@domain.hid>
	<46AF63F8.70207@domain.hid>  <1185900471.6611.249.camel@domain.hid>
	<1185900717.6611.251.camel@domain.hid>  <46AF69BC.6030109@domain.hid>
Content-Type: text/plain
Date: Tue, 31 Jul 2007 19:16:17 +0200
Message-Id: <1185902177.6611.253.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-core] [BUG] 2.4-rc1: modular nucleus	cannot	be	unloaded
Reply-To: rpm@xenomai.org
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

On Tue, 2007-07-31 at 18:56 +0200, Jan Kiszka wrote:
> Philippe Gerum wrote:
> > On Tue, 2007-07-31 at 18:47 +0200, Philippe Gerum wrote:
> >> On Tue, 2007-07-31 at 18:31 +0200, Jan Kiszka wrote:
> >>> Philippe Gerum wrote:
> >>>> On Tue, 2007-07-31 at 18:11 +0200, Jan Kiszka wrote:
> >>>>> Already a plain command sequence causes this problem:
> >>>>>
> >>>>> # modprobe xeno_nucleus
> >>>>> # rmmod xeno_nucleus
> >>>>> rmmod: xeno_nucleus: Resource temporarily unavailable
> >>>>>
> >>>>> Can anyone confirm?
> >>>> Cannot reproduce it here. However, I got another report saying that
> >>>> /proc/xenomai/stat would return -ENOMEM. Cannot reproduce it here
> >> Correction: it would return -EAGAIN, so maybe the status leaks when a
> >> restart condition has been encountered in the stat loop. Seems minor,
> >> compared to ENOMEM.
> >>
> > 
> > Btw, you will likely need a large number of threads to make this happen
> > (~40), at least this is the case for the reporting site.
> >  
> 
> I think you need a large number of _fluctuating_ threads, as EAGAIN
> should only be returned if something (thread count, IRQ assignments)
> changes while dumping the list.

This was implied.

>  But I would have to re-check this thing
> as well. I assume there is no hope for a test case then?
> 

Nope.

> Jan
> 
-- 
Philippe.



