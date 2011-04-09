Date: Sat, 9 Apr 2011 20:55:03 +0200
From: Richard Cochran <richardcochran@domain.hid>
Message-ID: <20110409185503.GB11908@domain.hid>
References: <20110409184122.GA11908@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20110409184122.GA11908@domain.hid>
Subject: Re: [Xenomai-core] arm ixp: more trouble with recent xenomai
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

On Sat, Apr 09, 2011 at 08:41:22PM +0200, Richard Cochran wrote:
> 
> I tried disabling various CONFIG options, and I found by accident that
> enabling IPIPE_DEBUG allows the system to run just fine.

Update: It is not enough for me to enable IPIPE_DEBUG. The kernels
that boot have all of the XENO_OPT_DEBUG options enabled.

Disabling XENO_OPT_DEBUG results in a kernel that freezes. I will try
to find out which of these options makes a difference.

Thanks,

Richard

