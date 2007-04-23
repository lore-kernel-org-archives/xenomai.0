Message-ID: <462CADFB.40008@domain.hid>
Date: Mon, 23 Apr 2007 15:00:43 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <46265FC8.1070207@domain.hid>	<1176926837.5010.90.camel@domain.hid>	<46268879.30507@domain.hid>	<462C7DF4.9060002@domain.hid>	<1177324208.30217.98.camel@domain.hid>	<17964.35957.487976.245056@domain.hid>
	<17964.36864.695360.167360@domain.hid>
	<462CAB3B.9080408@domain.hid>
In-Reply-To: <462CAB3B.9080408@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [BUG] target width of shifts on 64 bits
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
> Who the hell is using the ffnz implementation in system.h? The
> simulator? I kicked it out for a x64-build here, and I got no noticeable
> effects.

No, the simulator uses the one in asm-sim/system.h. The one in
nucleus/system.h is, for instance, for xnmlqueue_t in user-space.

-- 
                                                 Gilles Chanteperdrix

