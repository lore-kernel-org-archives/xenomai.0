MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <18326.27800.259400.815958@domain.hid>
Date: Tue, 22 Jan 2008 23:22:16 +0100
In-Reply-To: <4796643D.7010208@domain.hid>
References: <2ff1a98a0801020231k19be7d89k1a6f04b7d497cc34@domain.hid>
	<18326.21459.333811.155772@domain.hid>
	<4796643D.7010208@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Subject: Re: [Xenomai-core] High latencies on ARM.
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

Jan Kiszka wrote:
 > Does the patch improve ARM latencies already?

Yes, it does. The (interrupt) latency goes from above 100us to
80us. This is not yet 50us, though.

-- 


					    Gilles Chanteperdrix.

