Message-ID: <4573E871.3060304@domain.hid>
Date: Mon, 04 Dec 2006 10:20:49 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [PATCH 1/3] decouple spinlock stats
	from	XENO_OPT_STATS
References: <456236D2.3050402@domain.hid> <4563FA59.6070605@domain.hid>
	<1165084143.4952.239.camel@domain.hid>
In-Reply-To: <1165084143.4952.239.camel@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: rpm@xenomai.org
Cc: Jan Kiszka <jan.kiszka@domain.hid>, xenomai-core <xenomai@xenomai.org>

Philippe Gerum wrote:
> Ok, I ended up finding such decoupling cleaner, given that we don't drag
> the full debug overhead when activating /proc/xenomai/locks in SMP mode,
> thanks to the reorganized debug options. Gilles, is this patch series ok
> for you too, and particularly the POSIX changes?
> 

Yes, it is Ok.

-- 
                                                 Gilles Chanteperdrix

