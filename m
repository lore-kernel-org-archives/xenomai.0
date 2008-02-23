MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <18368.6678.827830.689229@domain.hid>
Date: Sat, 23 Feb 2008 14:05:26 +0100
In-Reply-To: <47C01300.9070204@domain.hid>
References: <47BEA5C3.9050100@domain.hid>
	<18367.7523.207507.331701@domain.hid>
	<47C01300.9070204@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Subject: Re: [Adeos-main] [PATCH] tracer: use per-cpu trace buffers
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: Jan Kiszka <jan.kiszka@domain.hid>, adeos-main <adeos-main@gna.org>, Philippe Gerum <rpm@xenomai.org>

Jan Kiszka wrote:
 > Gilles Chanteperdrix wrote:
 > > Jan Kiszka wrote:
 > >  > This patch addresses two issues:
 > >  > 
 > >  >  - fixes boot hang with CONFIG_IPIPE_TRACE, !CONFIG_IPIPE_TRACE_VMALLOC,
 > >  >    and large CONFIG_NR_CPUS (due to the huge trace buffers this implies,
 > >  >    even if the system has only a few CPUs in fact)
 > > 
 > > This is something I observed even on UP systems: the kernel does not
 > > boot on ARM if CONFIG_IPIPE_TRACE_VMALLOC is not selected.
 > > 
 > 
 > Yeah, well known, that's why we have vmalloc'ed trace buffers.
 > 
 > I just wondered again if this is an arch-specific issue, or if it
 > depends on the RAM size. If it is arch-specific, you are welcome to
 > change the default of IPIPE_TRACE_VMALLOC ("default y if ARM || ...").
 > Or reduce IPIPE_TRACE_SHIFT for ARM, given there is a reasonable value
 > (/wrt to the tracer) your boards still boot with.

I will do some tests and propose something like that. I had this problem
with linux 2.6.15 where the initial image (I guess text + data + bss)
must fit in 3 MB. I have not tested since then.

-- 


					    Gilles Chanteperdrix.

