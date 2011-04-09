Message-ID: <4DA0B580.4070602@domain.hid>
Date: Sat, 09 Apr 2011 21:37:36 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <20110409184122.GA11908@domain.hid>
	<20110409185503.GB11908@domain.hid>
In-Reply-To: <20110409185503.GB11908@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] arm ixp: more trouble with recent xenomai
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Richard Cochran <richardcochran@domain.hid>
Cc: xenomai@xenomai.org

Richard Cochran wrote:
> On Sat, Apr 09, 2011 at 08:41:22PM +0200, Richard Cochran wrote:
>> I tried disabling various CONFIG options, and I found by accident that
>> enabling IPIPE_DEBUG allows the system to run just fine.
> 
> Update: It is not enough for me to enable IPIPE_DEBUG. The kernels
> that boot have all of the XENO_OPT_DEBUG options enabled.
> 
> Disabling XENO_OPT_DEBUG results in a kernel that freezes. I will try
> to find out which of these options makes a difference.

Just to have an idea where the issue come from, could you try reverting
all the changes which were made on the tsc and timer? i.e. revert to the
original ipipe_mach_get_tsc and ipipe_mach_set_dec?

-- 
                                                                Gilles.

