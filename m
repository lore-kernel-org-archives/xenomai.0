Subject: Re: [Xenomai-help] New install of Xenomai 2.3 for 2.6.17
	kernel.... Various problems
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <032320071404.24123.4603DE73000D814600005E3B2216557996070E0301020A98@domain.hid>
References: <032320071404.24123.4603DE73000D814600005E3B2216557996070E0301020A98@domain.hid>
Content-Type: text/plain
Date: Fri, 23 Mar 2007 15:47:04 +0100
Message-Id: <1174661225.4606.29.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
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
To: xenomai@domain.hid
Cc: xenomai@xenomai.org

On Fri, 2007-03-23 at 14:04 +0000, xenomai@domain.hid wrote:
> Hello,
> 
> I have been working on trying to find the optimal linux kernel configuration and have noticed a couple problems.
> No matter what I do it seems that while cpu #2 is detected, nothing gets scheduled on it. 

If not already done, try building the Xenomai nucleus as a module
instead of statically into the kernel. Is the situation normal with
respect to load balancing between CPUs before you eventually modprobe
this module?

> Also, there is always a modprobe process running at 100%cpu that I can't kill.

modprobe of which module?

>   The command that is showed in top is "modprobe -s ac".  If I run it from the command line it hangs as well.
>   Latencies are however very acceptable when running xeno-test.  I do however see some negative values
>  in the test output.

Negative values are (mostly) ok. This only means that your machine is
faster than pre-calibrated for, which causes the timer shots to be ahead
of time, due to a pessimistic calibration.
Check /proc/xenomai/latency, this gives the intrinsic latency Xenomai
anticipates when programming timer shots (i.e. interrupt latency +
scheduling latency altogether), given as a count of nanoseconds.

You can change this value on the fly while the latency test is running;
just echo a new value to this file. You should try lowering it until all
the values (particularly the leftmost ones, i.e. "min lat") raise
slightly above zero.

> 
> The config file that I am using currently is the same as the one below just with CONFIG_XENO_HW_SMI_ALL.
>   This seems to give me the best latencies.
> 
> Mike
> 
>  -------------- Original message ----------------------
> From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
> > xenomai@domain.hid wrote:
> > >  -------------- Original message ----------------------
> > > From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
> > > 
> > >>xenomai@domain.hid wrote:
> > >>
> > >>>#
> > >>># SMI workaround
> > >>>#
> > >>># CONFIG_XENO_HW_SMI_DETECT_DISABLE is not set
> > >>>CONFIG_XENO_HW_SMI_DETECT=y
> > >>>CONFIG_XENO_HW_SMI_WORKAROUND=y
> > >>># CONFIG_XENO_HW_SMI_ALL is not set
> > >>># CONFIG_XENO_HW_SMI_INTEL_USB2 is not set
> > >>># CONFIG_XENO_HW_SMI_LEGACY_USB2 is not set
> > >>># CONFIG_XENO_HW_SMI_PERIODIC is not set
> > >>># CONFIG_XENO_HW_SMI_TCO is not set
> > >>># CONFIG_XENO_HW_SMI_MC is not set
> > >>>CONFIG_XENO_HW_SMI_APMC=y
> > >>># CONFIG_XENO_HW_SMI_LEGACY_USB is not set
> > >>>CONFIG_XENO_HW_SMI_BIOS=y
> > >>
> > >>Chances are that the latencies you get are due to the SMI you leave
> > >>enabled (APMC or BIOS). Could you try first with only
> > >>CONFIG_XENO_HW_SMI_ALL ?
> > >>
> > > WOW!!!  I did try that with the 2.6.17 kernel but it wouldnt boot,
> > > I had to enable APM.  It is working like  charm now.  Max latency
> > > is 4-5 us while running X.  If I drag a window around it goes up
> > > to 7us or so.  Deffinately a step in the righ direction!  Thanks.
> > 
> > Good news.
> > 
> > -- 
> >                                                  Gilles Chanteperdrix
> 
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
-- 
Philippe.



