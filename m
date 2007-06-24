MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <18046.42783.829807.333066@domain.hid>
Date: Sun, 24 Jun 2007 19:17:19 +0200
In-Reply-To: <467E2E9C.90905@domain.hid>
References: <467CD519.1060802@domain.hid> <1182594345.6000.9.camel@domain.hid>
	<467D0684.7030604@domain.hid> <1182623858.6000.139.camel@domain.hid>
	<467E2E9C.90905@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Subject: Re: [Xenomai-core] Monotonic, realtime, and other timers
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


IMO, the only advantage of having absolute timers is to be able to apply
the posix scheme. So, if I followed correctly your discussion, what we
need is:
- an XNTBISOL flag with a service xntbase_isol which set this flag and
  unshare the target timebase if it is shared (IOW, if aperiodic)
- the service xntbase_adjust_time to walk all the absolute timers of the
  non isolated timebases and adjust their expiry date or play their
  handler the posix way.

-- 


					    Gilles Chanteperdrix.

