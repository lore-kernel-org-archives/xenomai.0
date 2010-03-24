Date: Thu, 25 Mar 2010 00:44:09 +0100
From: Alexis Berlemont <alexis.berlemont@domain.hid>
Message-ID: <20100324234409.GA3247@domain.hid>
References: <4BA416AA.6050603@domain.hid> <4BA4C5EF.6020003@domain.hid>
	<20100321205955.GB3505@domain.hid> <4BA9EDEE.6070500@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4BA9EDEE.6070500@domain.hid>
Subject: Re: [Xenomai-core] [PULL REQUEST] analogy: bug fixes
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Daniele Nicolodi <daniele@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

Hi,
Daniele Nicolodi wrote:
> Alexis Berlemont wrote:
> > Daniele Nicolodi wrote:
> >> Alexis Berlemont wrote:
> >>> The following changes since commit 8cfc1103fe1cf9e700698e8230baf562ffb5cf06:
> >>>    Gilles Chanteperdrix (1):
> >>>          x86 syscalls: make __xn_get_eip a macro
> >>>
> >>> are available in the git repository at:
> >>>
> >>>    git://git.xenomai.org/xenomai-abe.git analogy
> >> Hello. Looking at your pull request, I see that my patch for correct
> >> buffer handling when using .stop_src  = TRIG_NONE is not included. Does
> >> the patch need some more work? Or it simply get lost on the way?
> > I have not forgotten it. I did not include it for two reasons:
> > - I have not found time to (fully) test it
> > - I wanted to properly modify the test program cmd_read so as to allow
> >   continuous acquisisitions 
> 
> Hi Alexis. Sorry for the late response. That's fine, I just wanted to be
> sure that the patch was not dropped by mistake. I'll test continuous
> output today and let you know if any other bugfix is necessary. I can
> also look into providing a patch for cmd_read and cmd_write.

If you want to test infinite acquisitions right now, you can clone my
git repository. I just pushed the modifications on it. I have not made
a pull request yet because I want to be sure there is no regression. 

Your patch did not integrate fixes for both directions (read and
write). So, I had to modify it.

I also modified cmd_read; with the option -S set to 0, an infinite
acquisition will be configured.

Any patch from you is welcome (cmd_write or anything else), so do not
hesitate to send them.

> 
> Cheers,
> -- 
> Daniele

-- 
Alexis.

