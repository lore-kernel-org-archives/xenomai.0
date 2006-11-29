Message-ID: <456D5EE7.80507@domain.hid>
Date: Wed, 29 Nov 2006 11:20:23 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Re: [RFC][PATCH 2/2] global CPU affinity control
References: <456C3EFB.7030303@domain.hid> <456C887D.9040008@domain.hid>
	<456C983E.70408@domain.hid>
In-Reply-To: <456C983E.70408@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
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
Cc: "M. Koehrer" <mathias_koehrer@domain.hid>, xenomai-core <xenomai@xenomai.org>

Jan Kiszka wrote:
> Nope, that's intentional (forgot to repeat this fact, was explained
> earlier): Users can always override nkaffinity by their own mask. Only
> the "I-don't-care" XNPOD_ALL_CPUS activates this new selection mechanism.

Ok. But there is still something wrong: if the affinity is empty, it
will remain empty whereas it was replaced by XNARCH_CPU_MASK_ALL in the
current version.

-- 
                                                 Gilles Chanteperdrix

