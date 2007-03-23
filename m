From: xenomai@domain.hid
Subject: Re: [Xenomai-help] New install of Xenomai 2.3 for 2.6.17 kernel....
	Various problems
Date: Fri, 23 Mar 2007 14:04:36 +0000
Message-Id: <032320071404.24123.4603DE73000D814600005E3B2216557996070E0301020A98@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>, xenomai@xenomai.org

Hello,

I have been working on trying to find the optimal linux kernel configuration and have noticed a couple problems.  No matter what I do it seems that while cpu #2 is detected, nothing gets scheduled on it.  Also, there is always a modprobe process running at 100%cpu that I can't kill.  The command that is showed in top is "modprobe -s ac".  If I run it from the command line it hangs as well.  Latencies are however very acceptable when running xeno-test.  I do however see some negative values in the test output.

The config file that I am using currently is the same as the one below just with CONFIG_XENO_HW_SMI_ALL.  This seems to give me the best latencies.

Mike

 -------------- Original message ----------------------
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
> xenomai@domain.hid wrote:
> >  -------------- Original message ----------------------
> > From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
> > 
> >>xenomai@domain.hid wrote:
> >>
> >>>#
> >>># SMI workaround
> >>>#
> >>># CONFIG_XENO_HW_SMI_DETECT_DISABLE is not set
> >>>CONFIG_XENO_HW_SMI_DETECT=y
> >>>CONFIG_XENO_HW_SMI_WORKAROUND=y
> >>># CONFIG_XENO_HW_SMI_ALL is not set
> >>># CONFIG_XENO_HW_SMI_INTEL_USB2 is not set
> >>># CONFIG_XENO_HW_SMI_LEGACY_USB2 is not set
> >>># CONFIG_XENO_HW_SMI_PERIODIC is not set
> >>># CONFIG_XENO_HW_SMI_TCO is not set
> >>># CONFIG_XENO_HW_SMI_MC is not set
> >>>CONFIG_XENO_HW_SMI_APMC=y
> >>># CONFIG_XENO_HW_SMI_LEGACY_USB is not set
> >>>CONFIG_XENO_HW_SMI_BIOS=y
> >>
> >>Chances are that the latencies you get are due to the SMI you leave
> >>enabled (APMC or BIOS). Could you try first with only
> >>CONFIG_XENO_HW_SMI_ALL ?
> >>
> > WOW!!!  I did try that with the 2.6.17 kernel but it wouldnt boot,
> > I had to enable APM.  It is working like  charm now.  Max latency
> > is 4-5 us while running X.  If I drag a window around it goes up
> > to 7us or so.  Deffinately a step in the righ direction!  Thanks.
> 
> Good news.
> 
> -- 
>                                                  Gilles Chanteperdrix


