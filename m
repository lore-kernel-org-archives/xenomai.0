Message-ID: <48ADC224.9030409@domain.hid>
Date: Thu, 21 Aug 2008 21:29:40 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <48ADC134.7060605@domain.hid>
In-Reply-To: <48ADC134.7060605@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] Fast userspace locks for native skin
Reply-To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
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
> Hi Gilles,
> 
> do you - or anyone else - happen to have some patches under preparation
> to extend also the native skin with the newly added CONFIG_XENO_FASTSEM
> support? Just to avoid duplicate work (we are about to work on this).

Not yet. But the fastsem work is largely unfinished in other areas: for
instance, semaphores are not implemented yet.

-- 
					    Gilles.

