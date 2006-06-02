MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17536.15954.613301.603959@domain.hid>
Date: Fri, 2 Jun 2006 15:34:10 +0200
In-Reply-To: <44802CA1.3050301@domain.hid>
References: <447F72A0.8000000@domain.hid>
	<17536.10247.604874.412137@domain.hid>
	<44802CA1.3050301@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Subject: [Xenomai-core] Re: [patch] static buffer for timer-bheap
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
 > Gilles Chanteperdrix wrote:
 > > Jan Kiszka wrote:
 > >  > Hi,
 > >  > 
 > >  > this patch moves the heap for scalable timer queues into the xnpod_t
 > >  > structure instead of allocating it dynamically. This simplifies the pod
 > >  > initialisation and cleanup, which was not fully robust in this regard
 > >  > anyway. If a pod is now considered too large (but we are discussion
 > >  > kbytes here), allocating its buffer via xnarch_sysalloc would be an option.
 > >  > 
 > >  > In case this patch is acceptable, I would suggest merging it before 2.2
 > >  > due to the contained (minor) fix.
 > > 
 > > Since this memory is specific to the data structure, its allocation
 > > seems better by the data structure functions. It also make the binary
 > > heap structure reusable for other purposes.
 > 
 > That's what I added the DECLARE_BHEAP_CONTAINER macro for. Sorry, did
 > not mention this.
 > 
 > The idea is to leave the allocation policy up to the user instead of
 > enforcing it in the bheap layer. The current approach also implicitly
 > excludes its usage from RT contexts, BTW.
 > 
 > > 
 > > Could you explain why the current scheme is not robust ?
 > > 
 > 
 > Given a SMP system where the allocation fails right in the middle of the
 > per-CPU loop [1], cleanup will not be performed for already allocated heaps.

You are right.

-- 


					    Gilles Chanteperdrix.

