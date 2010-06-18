Message-ID: <4C1BA6F7.9080004@domain.hid>
Date: Fri, 18 Jun 2010 19:03:51 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <1276880276.12743.73.camel@domain.hid>
In-Reply-To: <1276880276.12743.73.camel@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [PULL REQUEST] fixes for 2.5.4
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org, xenomai@xenomai.org

Philippe Gerum wrote:
> This series is mainly about fixing the shared heap management for nommu,
> and introducing a way to break out from syscall-less runaway loops, in
> primary mode.
> 
> Regarding the shared heaps, we have no choice but break the 2.5.x ABI
> for blackfin and nios2 for fixing them, but for a good reason: they just
> could not work on any earlier release.
> 
> Recovery from runaway loops in primary mode is introduced by the mayday
> patch series; the faulty thread gets relaxed, instead of being killed,
> when the nucleus watchdog triggers.
> 
> Gilles, please merge.

Merged, thanks (a bit rebased though).

-- 
					    Gilles.

