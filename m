MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <18367.7523.207507.331701@domain.hid>
Date: Fri, 22 Feb 2008 20:07:15 +0100
In-Reply-To: <47BEA5C3.9050100@domain.hid>
References: <47BEA5C3.9050100@domain.hid>
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
Cc: adeos-main <adeos-main@gna.org>, Philippe Gerum <rpm@xenomai.org>

Jan Kiszka wrote:
 > This patch addresses two issues:
 > 
 >  - fixes boot hang with CONFIG_IPIPE_TRACE, !CONFIG_IPIPE_TRACE_VMALLOC,
 >    and large CONFIG_NR_CPUS (due to the huge trace buffers this implies,
 >    even if the system has only a few CPUs in fact)

This is something I observed even on UP systems: the kernel does not
boot on ARM if CONFIG_IPIPE_TRACE_VMALLOC is not selected.

-- 


					    Gilles Chanteperdrix.

