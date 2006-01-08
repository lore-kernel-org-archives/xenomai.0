From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17345.26276.110671.822369@domain.hid>
Date: Sun, 8 Jan 2006 20:23:16 +0100
Subject: Re: [Xenomai-core] latency kernel part crashes on ppc64
In-Reply-To: <43C14453.3040907@domain.hid>
References: <43C12304.4040802@domain.hid> <43C12CEC.8070403@domain.hid>
	<43C14453.3040907@domain.hid>
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Heikki Lindholm <holindho@domain.hid>
Cc: Jan Kiszka <jan.kiszka@domain.hid>, xenomai@xenomai.org

Heikki Lindholm wrote:
 > >  o When and how does it crash? At start-up immediately? Or after a
 > >    while?
 > 
 > I inserted some serial debug prints and it gets two passes to 
 > eval_outer_loop done (enter/exit function). After that it freezes. 
 > Without the debug printing it dies with kernel access of illegal memory 
 > at xnpod_schedule, which btw. has been quite a common place to die.

A way to know a bit more about this error would be to have a look at the
exact address given by the kernel oops in the disassembly of
xnpod_schedule and try and find which pointer is invalid. This is not
very subtle, but sometimes works.

One reason why there used to be some invalid pointers accesses in
xnpod_schedule was when the context switch routine (on x86) forgot to
declare a few output or clobbered registers. In this case, the compiler
may assume that the contents of the registers are correct, whereas the
context switch clobbered them.

-- 


					    Gilles Chanteperdrix.

