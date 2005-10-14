From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17232.10761.702953.65447@domain.hid>
Date: Fri, 14 Oct 2005 23:58:33 +0200
Subject: Re: [Xenomai-help] Xenomai PPC -> Disable FP : Bingo !
In-Reply-To: <42134.193.52.24.125.1129325991.squirrel@domain.hid>
References: <42134.193.52.24.125.1129325991.squirrel@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: smannori@domain.hid
Cc: xenomai@xenomai.org

smannori@domain.hid wrote:
 > I smell FPU/Altivec problems...May be Adeos is not fully G4 compliant for
 > the FP section ? Ok Real man don't need FP (see Linux/Linus in the kernel).
 > ... but sometime a couple of FP ops could be very useful :)

This is probably a Xenomai bug. Adeos has not much to do about FPU,
except insuring that a domain may not preempt another while it is
switching its FPU context.

If you suspect the problem comes from Altivec (which is highly probable,
if not almost certain, since ppc FPU switching code does not seem to
switch Altivec contexts, actually), you may try choosing a processor
without altivec support in kernel configuration menu, re-compile kernel
and re-enable Xenomai FPU support.

-- 


					    Gilles Chanteperdrix.

