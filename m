Message-ID: <4BF50BEA.4030208@domain.hid>
Date: Thu, 20 May 2010 12:16:10 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <201005191125.51812.smolorz@domain.hid>
	<4BF50124.20801@domain.hid>
In-Reply-To: <4BF50124.20801@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Adeos-main] [BUG] Interrupt recursion with libata-sff
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: adeos-main <adeos-main@gna.org>

Jan Kiszka wrote:
> Looks like your problem is x86-32 returning from interrupts with hard
> IRQs enabled (and therefore flushing the pipeline already over the
> interrupt handler). That should ideally be unified with x86-64 now, also
> as x86-64 may already gain better testing than 32 bit.

I may have not understood right, but from my understanding, the big
difference between x86_32 and x86_64 is that interrupts flags are
virtualized in x86_32's entry.S. To unify x86_32 and x86_64 would
basically mean rewrite this. And the the two entry.S are separated, so
x86_32 has to be tested separately from x86_64.


-- 
					    Gilles.

