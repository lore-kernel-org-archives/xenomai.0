Subject: Re: [Xenomai-core] nervous nmi-watchdog
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <44B1354A.50403@domain.hid>
References: <44736EE4.2060807@domain.hid> <44845D59.5040608@domain.hid>
	<17540.32930.566897.960413@domain.hid>
	<448482B4.2040105@domain.hid>
	<17584.64392.157061.788526@domain.hid>
	<1152463301.5027.3.camel@domain.hid>  <44B1354A.50403@domain.hid>
Content-Type: text/plain
Date: Sun, 09 Jul 2006 19:07:01 +0200
Message-Id: <1152464821.5027.6.camel@domain.hid>
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

On Sun, 2006-07-09 at 18:56 +0200, Jan Kiszka wrote:
> I can confirm the failing NMI test here on my notebook with both nucleus
> and native skin built into the kernel. I haven't seen false positive
> NMIs yet, but the tracer is still on. Will switch off and re-check.

FWIW, here, the false positive is raised immediately when starting the
latency test.

-- 
Philippe.



