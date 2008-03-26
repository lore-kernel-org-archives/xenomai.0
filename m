Message-ID: <47EA8F43.9030707@domain.hid>
Date: Wed, 26 Mar 2008 19:00:35 +0100
From: Roland Stigge <stigge@domain.hid>
MIME-Version: 1.0
References: <20080326162011.0040C243A7@domain.hid>
In-Reply-To: <20080326162011.0040C243A7@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] Xenomai/SOLO - RTOS emulation for standard Linux
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Wolfgang Denk <wd@domain.hid>
Cc: xenomai@xenomai.org

Wolfgang Denk wrote:
> If it comes to  hard,  reliable  real-time  behaviour,  we  recommend
> Xenomai/ipipe to all our customers. However, there are some who think
> it  is  important  to have an "original, unpatched" kernel.org source
> tree. These obviously run for PREEMPT_RT, and SOLO.

Please remember that PREEMPT_RT currently doesn't mean "unpatched", so
you could theoretically patch every PREEMPT_RT enhanced kernel with
ipipe instead... ;->

(Feelings of customers are a completely different thing, though...)

Roland

