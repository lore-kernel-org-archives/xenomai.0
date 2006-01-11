MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17349.33404.156585.857948@domain.hid>
Date: Wed, 11 Jan 2006 23:11:08 +0100
Subject: Re: [Xenomai-core] latency kernel part crashes on ppc64
In-Reply-To: <43C37926.5060007@domain.hid>
References: <43C12304.4040802@domain.hid> <43C12CEC.8070403@domain.hid>
	<43C14453.3040907@domain.hid>
	<1136754149.17443.21.camel@domain.hid>
	<43C18CE1.5040509@domain.hid> <43C1CFC2.8040104@domain.hid>
	<43C21BA7.4050806@domain.hid> <43C220FE.4010100@domain.hid>
	<17346.57955.432284.905332@domain.hid>
	<43C37926.5060007@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: Jan Kiszka <jan.kiszka@domain.hid>, xenomai@xenomai.org

Philippe Gerum wrote:
 > Gilles Chanteperdrix wrote:
 > > Philippe Gerum wrote:
 > >  > Likely not this time (keep it cold anyway, who knows); I strongly suspect a bug in 
 > >  > xnarch_switch_to() for all archs but x86
 > > 
 > > Now that you are talking about it, I may be the one who owes a beer to
 > > everyone by first having put a bug in ia64 context-switch code... If I
 > > am not wrong, the bug should be observed on ia64 too. Unfortunately, I
 > > am unable to compile my ia64 kernel right now, so I wrote a patch for
 > > power PC, and would be glad if some power PC owner could try it.
 > > 
 > 
 > Nope, same lockup with hybrid scheduling.

The latency -t 1 crash may be observed on ia64 too.

But it does not seem to be due to the bug I was suspecting in context
switch code.

-- 


					    Gilles Chanteperdrix.

