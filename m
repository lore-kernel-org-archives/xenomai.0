From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17462.27062.971201.82560@domain.hid>
Date: Fri, 7 Apr 2006 15:31:34 +0200
Subject: Re: [Xenomai-core] nkpod->watchdog_trigger per CPU?
In-Reply-To: <44361D46.9080003@domain.hid>
References: <44361837.9080206@domain.hid>
	<44361D46.9080003@domain.hid>
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: Jan Kiszka <jan.kiszka@domain.hid>, xenomai-core <xenomai@xenomai.org>

Philippe Gerum wrote:
 > Jan Kiszka wrote:
 > > Hi,
 > > 
 > > analysing the watchdog characteristics in our scenarios, I just wondered
 > > if it is SMP-aware (we have no SMP in use, it's a pure analytical concern).
 > > 
 > > The watchdog timeout is stored system-wide in nkpod->watchdog_trigger,
 > > but it is based on a per-CPU clock (TSC). Is the tick IRQ bound to a
 > > specific CPU in SMP scenarios so that this doesn't matter? Or am I just
 > > overseeing some detail?
 > > 
 > 
 > Good catch. This code was written before per-CPU ticking became the 
 > "official" implementation, so it needs to be updated.

The watchdog is handled on a per-cpu basis with revision 901.

-- 


					    Gilles Chanteperdrix.

