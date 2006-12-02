Subject: Re: [Xenomai-core] [PATCH 1/3] decouple spinlock stats from
	XENO_OPT_STATS
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <4563FA59.6070605@domain.hid>
References: <456236D2.3050402@domain.hid>  <4563FA59.6070605@domain.hid>
Content-Type: text/plain
Date: Sat, 02 Dec 2006 19:29:03 +0100
Message-Id: <1165084143.4952.239.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
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


Ok, I ended up finding such decoupling cleaner, given that we don't drag
the full debug overhead when activating /proc/xenomai/locks in SMP mode,
thanks to the reorganized debug options. Gilles, is this patch series ok
for you too, and particularly the POSIX changes?

-- 
Philippe.



