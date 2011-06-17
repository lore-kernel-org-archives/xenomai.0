Message-ID: <4DFB32B2.1010904@domain.hid>
Date: Fri, 17 Jun 2011 12:55:46 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4DFB1DC3.80203@domain.hid>
In-Reply-To: <4DFB1DC3.80203@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [PATCH] nucleus: Fix interrupt handler tails
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: Xenomai core <Xenomai-core@domain.hid>

On 06/17/2011 11:26 AM, Jan Kiszka wrote:
> Our current interrupt handlers assume that they leave over the same task
> and CPU they entered. But CONFIG_XENO_HW_UNLOCKED_SWITCH and commit
> f6af9b831c broke this assumption: xnpod_schedule invoked from the
> handler tail can now actually trigger a domain migration

What unlocked context swith introduce from my point of view is simply
sections where interrupt happen which do not reschedule.

f6af9b831c introduce a rescheduling point, but does not change what
happens during the interrupt handler either.

So, I do not really understand this commit message. Either we can assume
that interrupt handlers migrate tasks or not, but this does not seem to
have anything to do with unlocked context switches or commit f6af9b831c.

-- 
                                                                Gilles.

