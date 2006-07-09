MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17584.64392.157061.788526@domain.hid>
Date: Sun, 9 Jul 2006 14:50:16 +0200
Subject: Re: [Xenomai-core] nervous nmi-watchdog
In-Reply-To: <448482B4.2040105@domain.hid>
References: <44736EE4.2060807@domain.hid> <44845D59.5040608@domain.hid>
	<17540.32930.566897.960413@domain.hid>
	<448482B4.2040105@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
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
 > > I never observe this on my dual PIII whereas I always have the NMI
 > > watchdog option enabled. Are you running with or without the tracer ?
 > > 
 > 
 > w/o.

enabling xeno nmi watchdog whereas the nucleus module is built-in break
Linux nmi watchdog test. Maybe some setups are not done at Linux level
when this test fails, which could explain some weird behaviour
afterwards.

Do you have the message:
Testing NMI watchdog... CPU#0: NMI appears to be stuck (x->y)!

In Linux boot messages ?

-- 


					    Gilles Chanteperdrix.

