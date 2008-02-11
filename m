MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <18352.48744.598358.653963@domain.hid>
Date: Mon, 11 Feb 2008 22:30:16 +0100
In-Reply-To: <47B081C8.60409@domain.hid>
References: <20080123065221.GB6573@domain.hid>
	<2ff1a98a0801230204s15e4eefaifdd2c946c44549df@domain.hid>
	<2ff1a98a0801230515i77f8c22bk866c4cd592a3a9b8@domain.hid>
	<20080124094150.GA7503@domain.hid>
	<18351.24380.551907.397687@domain.hid>
	<47B050A4.4060409@domain.hid>
	<2ff1a98a0802110605l416bc82bpdd4a7f2e6e92a342@domain.hid>
	<47B081C8.60409@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Subject: Re: [Xenomai-core] [Xenomai-help] AT91SAM9260 latency
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
Cc: jagarcia@domain.hid, xenomai@xenomai.org

Jan Kiszka wrote:
 > There is a shadow relax procedure running before the timer IRQ fires,
 > and that takes another context switch. So the latency sum is:
 > 
 >  - unrelated context switch
 >  - timer IRQ
 >  - switch to woken up RT process
 >  - serial IRQ
 > 
 > Almost the theoretical worst case.

The problem is that it does not happen when launching latency with -t 1
or -t 2, or if latency is not run in the background.

Anyway, I will investigate on the double ack issue, because it could
mean that there is a double EOI, which, I guess could cause some
troubles at interrupt controller level.

-- 


					    Gilles Chanteperdrix.

