MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17570.34620.38518.404171@domain.hid>
Date: Wed, 28 Jun 2006 15:42:20 +0200
Subject: Re: [Xenomai-core] [PATCH 6/6] Introduce IRQ latency benchmark
In-Reply-To: <44A275DE.5080500@domain.hid>
References: <20060626172116.019532000@domain.hid> <20060626172120.322015000@domain.hid>
	<17570.29185.754625.871443@domain.hid>
	<44A275DE.5080500@domain.hid>
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
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai@xenomai.org

Jan Kiszka wrote:
 > > Is there no way to make this code easier to port for example by using
 > > native or posix services for timings measurement and by abstracting the
 > > non portable part and moving them to include/asm-i386 ?
 > 
 > This tool is intentionally left Xenomai-free. You can put it on any x86
 > box around (and I assume that there is almost always some...) and run
 > the test. Thus, no need for a second RT-patched system.
 > 
 > Anyway, suggestions or patches to add a porting layer are welcome. The
 > following points need to be addressed: time measuring, irq protection,
 > hardware access. I just wonder if this is worth the effort.

I do not understand: it appears to me that Xenomai trunk does not
compile on other architectures than x86 when applying the IRQ latency
benchmark patch. So, something needs to be done. It may be the enabling
of an automake conditional in configure.in when compiling for x86.

 > 
 > > 
 > > Also note that calling printf from a signal handler risk deadlocking if
 > > the signal handler get called on the return path of the write call that
 > > take place in the middle of a printf call on the main thread.
 > > 
 > 
 > Ok, then we also need a fix for the latency test (this is where I
 > grabbed that pattern from). Is there a high risk that this locks up? I
 > wonder why I never observed or heard of problems with latency.

The latency test used to deadlock, that is why the summary printed on
signal is printed on stderr. Unfortunately, there seem to be one display
left on stdout, so it should still deadlock. The reason why we never see
the deadlock is (perhaps) that the continuous intermediate results are
printed on the context of the "display" thread, whereas the termination
signals are preferably delivered by the kernel to the "main" thread,
that only calls pause. Which makes the use of stderr in signals handlers
pointless.

Anyway, since your program is frequently using printf on the context of
the main thread, the risk of deadlock is real.

-- 


					    Gilles Chanteperdrix.

