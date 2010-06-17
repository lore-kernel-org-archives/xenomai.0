From: Travis Stratman <tstratman@domain.hid>
In-Reply-To: <4C19E1D8.6010705@domain.hid>
References: <181804936ABC2349BE503168465576460EBD5C0D@exchserver.basler.com>
	<1274047063.2972.1.camel@domain.hid>
	<2319761F7FA0D1479BA77EC2E0A8E7BCE8A603@domain.hid>
	<1275033915.27918.31.camel@domain.hid>
	<2319761F7FA0D1479BA77EC2E0A8E7BCEDCE09@domain.hid>
	<4C191D07.4050203@domain.hid> <4C191D91.6060209@domain.hid>
	<2319761F7FA0D1479BA77EC2E0A8E7BCEDCE78@domain.hid>
	<4C19E1D8.6010705@domain.hid>
Date: Thu, 17 Jun 2010 11:26:40 -0500
Message-Id: <1276792000.4890.600.camel@domain.hid>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] rt_task_sleep causing crashes on PowerPC
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>, Abhijit Majumdar <abhijit.majumdar@domain.hid>
Cc: xenomai@xenomai.org, Steve Deiters <SteveDeiters@domain.hid>

Gilles,

On Thu, 2010-06-17 at 10:50 +0200, Gilles Chanteperdrix wrote:
> Abhijit Majumdar wrote:
> > We use adeos-ipipe-2.6.28.10-arm-1.12-07.patch.
> 
> Ok. That is the latest I-pipe patch for 2.6.28. However, why are you
> using a 2.6.28 kernel? If you are starting a new project, there is no
> reason not to pick the latest kernel.

The 2.6.28.10 kernel that they are using is the latest release that we
provide that has support patches for the board that they are using. We
pick a stable version and develop with that for awhile before updating
to a newer version, as we simply don't have enough developers to
continually update and re-test newer kernel versions for all of our
products. We are working on a newer version for a new board but that
hasn't been tested yet.

Abhijit: it would be possible to compile a new kernel (i.e. 2.6.33) with
Xenomai 2.5.3 for the AT91SAM9G20 eval board that would work with your
board (after some configuration changes). It wouldn't support all of the
custom I/O but you would be able to test the failure that you are
seeing. The AT91 patch set for 2.6.33 would also need to be applied. The
at91 experimental patch set is not ported to 2.6.33 yet, but this
shouldn't be a problem for initial testing.

Thanks,

TAS


