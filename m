Date: Mon, 11 Apr 2011 07:53:44 +0200
From: Richard Cochran <richardcochran@domain.hid>
Message-ID: <20110411055344.GA5854@domain.hid>
References: <20110409184122.GA11908@domain.hid>
	<20110409185503.GB11908@domain.hid>
	<4DA0B580.4070602@domain.hid> <4DA0B878.9010106@domain.hid>
	<20110410065250.GA28869@domain.hid>
	<4DA192E0.2090802@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4DA192E0.2090802@domain.hid>
Subject: Re: [Xenomai-core] arm ixp: more trouble with recent xenomai
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

On Sun, Apr 10, 2011 at 01:22:08PM +0200, Gilles Chanteperdrix wrote:
> 
> Also, about the performances, Xenomai 2.4 did not have the Xenomai
> preemptible context switches. Maybe with FCSE, it results in reduced
> latencies to disable this option in Xenomai 2.5.

So, are you saying that XENO_HW_UNLOCKED_SWITCH=n might improve
latency?

The help for this option says...

    This option reduces interrupt latency when costly cache and
    TLB flushes are required to switch context, and may improve
    concurrency on some SMP/multi-core systems as well.

    You definitely want to enable that option on embedded ARM
    platforms.

so I am confused.

Thanks,

Richard


